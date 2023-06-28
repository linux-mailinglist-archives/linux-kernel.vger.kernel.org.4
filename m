Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E27741AA5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjF1VVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjF1VVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:21:25 -0400
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C596E9B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:14:54 -0700 (PDT)
Received: from eig-obgw-6008a.ext.cloudfilter.net ([10.0.30.227])
        by cmsmtp with ESMTP
        id ERz5qnpzJDKaKEcV3qfa02; Wed, 28 Jun 2023 21:14:54 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with ESMTPS
        id EcV3qFAAYMLFAEcV3q9e25; Wed, 28 Jun 2023 21:14:53 +0000
X-Authority-Analysis: v=2.4 cv=SY/ky9du c=1 sm=1 tr=0 ts=649ca2cd
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=WzbPXH4gqzPVN0x6HrNMNA==:17
 a=dLZJa+xiwSxG16/P+YVxDGlgEgI=:19 a=IkcTkHD0fZMA:10 a=of4jigFt-DYA:10
 a=wYkD_t78qR0A:10 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=yh9_tVENTYqonHDCVgEA:9
 a=QEXdDO2ut3YA:10 a=AjGcO6oz07-iQ99wixmX:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bE4J5MPQYuyXDtGDX71VCEquyoT9/ErgybRN1F6dckE=; b=ToRyGRNT0uZIDM7v76nLPHNh9g
        6vhbScvihIgB7xVC3Vxa2Xo3cskZJMgqRMQxlgRGmtyrD5t0QTNZLGvfRqPypd7nXnda5PQc5xdu1
        4+d4cG2urEVkH2GuR4M5mTTpEiKCmUID8o85cLD9I1orJjQuYTBWxa5I6WDqnh0Q/xGx2RosNCsWo
        dq2B3mwW4V9PhWRDsBsL118cEajxzET1Knm150QFPRv6bwM+m1aq4/O/oxeqoFfMpb/P68llw6cuy
        wx0OHmVh4U32SvZbSe3TsHWlHnBYqeei/N5TPHsQ0VLnA5qi5ipq0PZ1PQr8qkJV9jeb60p3/UdRo
        0TUcS4kg==;
Received: from 187-162-21-192.static.axtel.net ([187.162.21.192]:47538 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.96)
        (envelope-from <gustavo@embeddedor.com>)
        id 1qEcV2-001MHN-1y;
        Wed, 28 Jun 2023 16:14:52 -0500
Message-ID: <852dc07b-3e68-7a94-f548-8ae0f9d37d2f@embeddedor.com>
Date:   Wed, 28 Jun 2023 15:15:48 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/10][next] scsi: aacraid: Replace one-element array with
 flexible-array member in struct sgmap
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     aacraid@microsemi.com, "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <cover.1687974498.git.gustavoars@kernel.org>
 <0c7402fe6448186cda5a2618a35eb5f8d1cbb313.1687974498.git.gustavoars@kernel.org>
 <202306281311.3A69CB64@keescook>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202306281311.3A69CB64@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.21.192
X-Source-L: No
X-Exim-ID: 1qEcV2-001MHN-1y
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-21-192.static.axtel.net ([192.168.15.8]) [187.162.21.192]:47538
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 2
X-Org:  HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfE16ZM9AuBBc+LGve8JmQovkLJYtA7pMcim1/DAsqDmY8hZsitXCGYqYwNPZ0+tUZa14jRTxmxgwRjq90lwubYeogENfHcPo8DIBjlH2JOg32gIuPYQD
 EhwASx78RA3vT1kTUd/ywVCqa76PibV37HZ4bd3CZ/SP02hxWEsn8l/vVG4DpdNCKIl4dRFHOGzIw439qO0my2asGVmi5FL7Alb4NWQU0DvAth99SxTzpMMm
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/23 14:36, Kees Cook wrote:
> On Wed, Jun 28, 2023 at 11:57:13AM -0600, Gustavo A. R. Silva wrote:
>> Replace one-element array with flexible-array member in struct
>> sgmap and refactor the rest of the code, accordingly.
>>
>> Issue found with the help of Coccinelle and audited and fixed,
>> manually.
> 
> This change _does_ have binary output differences, although it looks
> like you got most of them. I still see:
> 
> commsup.o:
> -       mov    $0x40,%edx
> +       mov    $0x38,%edx
> 
> This appears to be the sizeof() here:
> 
>          ret = aac_fib_send(ScsiPortCommand64, fibptr, sizeof(struct aac_srb),
>                                  FsaNormal, 1, 1, NULL, NULL);
> 
> struct aac_srb includes struct sgmap. I think this needs to explicitly
> include the 1 sgmap, which seems to be sent in the fibptr:

I see your point. Yeah; this is one of those cases of nested struct-with-flex-array.

The flex-array is a couple of layers into the main enclosing structure.

However, I would like to have the input of a maintainer here, just to confirm
this would be the expected change.

Thanks a lot for the feedback! :)
--
Gustavo

> 
>          srbcmd = (struct aac_srb *)fib_data(fibptr);
> 	...
>          sg64 = (struct sgmap64 *)&srbcmd->sg;
>          sg64->count = cpu_to_le32(1);
> 
> i.e. "sending 1". This seems to fix it:
> 
> -       ret = aac_fib_send(ScsiPortCommand64, fibptr, sizeof(struct aac_srb),
> +       ret = aac_fib_send(ScsiPortCommand64, fibptr,
> +                               struct_size(srbcmd, sg.sg, 1),
> 
> Then I see changes in both aac_write_block() and aac_scsi_32(), but they
> match the changes you made to get the correct size (it's just an easier
> calculation for the compiler to perform, so the code is slightly
> simplified).
> 
> So I think with the hunk I suggested at the start, and a comment on the
> (expected) binary changes, this should be good to go.
> 
> -Kees
> 
>> Link: https://github.com/KSPP/linux/issues/79
>> Link: https://github.com/ClangBuiltLinux/linux/issues/1851
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   drivers/scsi/aacraid/aachba.c   | 24 ++++++++++--------------
>>   drivers/scsi/aacraid/aacraid.h  |  2 +-
>>   drivers/scsi/aacraid/commctrl.c |  4 ++--
>>   drivers/scsi/aacraid/comminit.c |  3 +--
>>   4 files changed, 14 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
>> index 03ba974f6b2a..b2849e5cc104 100644
>> --- a/drivers/scsi/aacraid/aachba.c
>> +++ b/drivers/scsi/aacraid/aachba.c
>> @@ -1336,8 +1336,7 @@ static int aac_read_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u32
>>   	if (ret < 0)
>>   		return ret;
>>   	fibsize = sizeof(struct aac_read) +
>> -			((le32_to_cpu(readcmd->sg.count) - 1) *
>> -			 sizeof (struct sgentry));
>> +		  le32_to_cpu(readcmd->sg.count) * sizeof(struct sgentry);
>>   	BUG_ON (fibsize > (fib->dev->max_fib_size -
>>   				sizeof(struct aac_fibhdr)));
>>   	/*
>> @@ -1471,8 +1470,7 @@ static int aac_write_block(struct fib * fib, struct scsi_cmnd * cmd, u64 lba, u3
>>   	if (ret < 0)
>>   		return ret;
>>   	fibsize = sizeof(struct aac_write) +
>> -		((le32_to_cpu(writecmd->sg.count) - 1) *
>> -		 sizeof (struct sgentry));
>> +		  le32_to_cpu(writecmd->sg.count) * sizeof(struct sgentry);
>>   	BUG_ON (fibsize > (fib->dev->max_fib_size -
>>   				sizeof(struct aac_fibhdr)));
>>   	/*
>> @@ -1590,9 +1588,9 @@ static int aac_scsi_64(struct fib * fib, struct scsi_cmnd * cmd)
>>   	/*
>>   	 *	Build Scatter/Gather list
>>   	 */
>> -	fibsize = sizeof (struct aac_srb) - sizeof (struct sgentry) +
>> -		((le32_to_cpu(srbcmd->sg.count) & 0xff) *
>> -		 sizeof (struct sgentry64));
>> +	fibsize = sizeof(struct aac_srb) +
>> +		  (le32_to_cpu(srbcmd->sg.count) & 0xff) *
>> +		  sizeof(struct sgentry64);
>>   	BUG_ON (fibsize > (fib->dev->max_fib_size -
>>   				sizeof(struct aac_fibhdr)));
>>   
>> @@ -1621,9 +1619,9 @@ static int aac_scsi_32(struct fib * fib, struct scsi_cmnd * cmd)
>>   	/*
>>   	 *	Build Scatter/Gather list
>>   	 */
>> -	fibsize = sizeof (struct aac_srb) +
>> -		(((le32_to_cpu(srbcmd->sg.count) & 0xff) - 1) *
>> -		 sizeof (struct sgentry));
>> +	fibsize = sizeof(struct aac_srb) +
>> +		  (le32_to_cpu(srbcmd->sg.count) & 0xff) *
>> +		  sizeof(struct sgentry);
>>   	BUG_ON (fibsize > (fib->dev->max_fib_size -
>>   				sizeof(struct aac_fibhdr)));
>>   
>> @@ -1691,8 +1689,7 @@ static int aac_send_safw_bmic_cmd(struct aac_dev *dev,
>>   	fibptr->hw_fib_va->header.XferState &=
>>   		~cpu_to_le32(FastResponseCapable);
>>   
>> -	fibsize  = sizeof(struct aac_srb) - sizeof(struct sgentry) +
>> -						sizeof(struct sgentry64);
>> +	fibsize  = sizeof(struct aac_srb) + sizeof(struct sgentry64);
>>   
>>   	/* allocate DMA buffer for response */
>>   	addr = dma_map_single(&dev->pdev->dev, xfer_buf, xfer_len,
>> @@ -2264,8 +2261,7 @@ int aac_get_adapter_info(struct aac_dev* dev)
>>   		dev->a_ops.adapter_bounds = aac_bounds_32;
>>   		dev->scsi_host_ptr->sg_tablesize = (dev->max_fib_size -
>>   			sizeof(struct aac_fibhdr) -
>> -			sizeof(struct aac_write) + sizeof(struct sgentry)) /
>> -				sizeof(struct sgentry);
>> +			sizeof(struct aac_write)) / sizeof(struct sgentry);
>>   		if (dev->dac_support) {
>>   			dev->a_ops.adapter_read = aac_read_block64;
>>   			dev->a_ops.adapter_write = aac_write_block64;
>> diff --git a/drivers/scsi/aacraid/aacraid.h b/drivers/scsi/aacraid/aacraid.h
>> index 94eb83d38be6..3fbc22ae72b6 100644
>> --- a/drivers/scsi/aacraid/aacraid.h
>> +++ b/drivers/scsi/aacraid/aacraid.h
>> @@ -507,7 +507,7 @@ struct sge_ieee1212 {
>>   
>>   struct sgmap {
>>   	__le32		count;
>> -	struct sgentry	sg[1];
>> +	struct sgentry	sg[];
>>   };
>>   
>>   struct user_sgmap {
>> diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
>> index e7cc927ed952..df811ad4afaa 100644
>> --- a/drivers/scsi/aacraid/commctrl.c
>> +++ b/drivers/scsi/aacraid/commctrl.c
>> @@ -561,8 +561,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
>>   		rcode = -EINVAL;
>>   		goto cleanup;
>>   	}
>> -	actual_fibsize = sizeof(struct aac_srb) - sizeof(struct sgentry) +
>> -		((user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry));
>> +	actual_fibsize = sizeof(struct aac_srb) +
>> +		(user_srbcmd->sg.count & 0xff) * sizeof(struct sgentry);
>>   	actual_fibsize64 = actual_fibsize + (user_srbcmd->sg.count & 0xff) *
>>   	  (sizeof(struct sgentry64) - sizeof(struct sgentry));
>>   	/* User made a mistake - should not continue */
>> diff --git a/drivers/scsi/aacraid/comminit.c b/drivers/scsi/aacraid/comminit.c
>> index bd99c5492b7d..d8dd89c87b01 100644
>> --- a/drivers/scsi/aacraid/comminit.c
>> +++ b/drivers/scsi/aacraid/comminit.c
>> @@ -523,8 +523,7 @@ struct aac_dev *aac_init_adapter(struct aac_dev *dev)
>>   	dev->max_fib_size = sizeof(struct hw_fib);
>>   	dev->sg_tablesize = host->sg_tablesize = (dev->max_fib_size
>>   		- sizeof(struct aac_fibhdr)
>> -		- sizeof(struct aac_write) + sizeof(struct sgentry))
>> -			/ sizeof(struct sgentry);
>> +		- sizeof(struct aac_write)) / sizeof(struct sgentry);
>>   	dev->comm_interface = AAC_COMM_PRODUCER;
>>   	dev->raw_io_interface = dev->raw_io_64 = 0;
>>   
>> -- 
>> 2.34.1
>>
> 

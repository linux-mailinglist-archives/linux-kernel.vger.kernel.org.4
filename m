Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 289C8652A84
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 01:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234360AbiLUAgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 19:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234342AbiLUAgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 19:36:12 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45638E32
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1671582971; x=1703118971;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q0ahnBYAstKhjnn4LtyS1XS23LTr37IS9ECQYCkoAP0=;
  b=g22DUOFi8s3ITvwcFbGn8VLHVzi24OB07AHp+TOdl1eQzOsRtswh41EM
   rNCZ1Iiyi6psN1bJDdNKHOikBLaZhyM4HcQbQsFf7zQDqCtuQ1FTyVcEC
   PIKFGdvpaswUG2JY4Iy6Wjwtr1dhCMc5N5fW67PPxNe8TFS4GfQvVBdiY
   gaD/zzGFXwF7bjJt8qxDcu9Ol9Ddl+3P7ctjD/vVgll7yREy6c/wBR7GL
   a4tq7/a2SSo1eOXAhhwoAvauilm53LxWPsQjUVMfF7hLrJvDg8tQy7djH
   obPOLhZpNpUXOCZrbqLYZEPxYUKth7g+fjIoM+pHM1y+hUvMQUGf8jpW6
   w==;
X-IronPort-AV: E=Sophos;i="5.96,261,1665417600"; 
   d="scan'208";a="219335683"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 21 Dec 2022 08:36:07 +0800
IronPort-SDR: xqTFZ48FgyhJT52pDsRjs/vRTPn2znilihPmtRknrIQfrBMckqh4t9EvzJf+pcJP2RZ2HCMawX
 wAuyvKKym5RJhhajMlG+K3CmnvRf8qYqn03yBUr/L02VHE8COhgzBs74u5WK1NBq2fOP+Kjspo
 NbHjrViRbaZMCHlh8MTaWVedTlhHHKEU90ng6CbiZlMmiMdq3LRpLKRgzBuPCIa/QQpCNpxh5Z
 HijCnetOLc7eMRGG8WZUS5wkSxnffDKyEzJgRKMtJ/ufOqMtnRD7ExzwDXqb9gukS35gGcE62C
 /W4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 15:54:21 -0800
IronPort-SDR: h4Iw0CETRfvVkS2A+Vscw79S0xGHDyVTUaSVn8jd+PHM1nrrSrrN4Tfyt514Ru6TUy5gMwbhgP
 yvpQf2+XBjY9Zg19HgjeNHf3sFC9oqXS7K6ZPOQXTJ2eLnNeOu+OoWjvCdNnyMHA3pOswWr9SG
 ySLEtn1JK4F/xqymHENS4RXx8g3/FVRdtFkbAybYgbSR9ij8voNBUiY6XgaEyjofp8qpmIRXZG
 zG81LoV0Xg5azjWsg3dwY1icQaJXIKMoAquLOgtFNUyGrS2OPOe7V5CfCut0VdQF5UGWn8LrO8
 K2A=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Dec 2022 16:36:07 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4NcDyG5r5xz1Rwt8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 16:36:06 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1671582965; x=1674174966; bh=q0ahnBYAstKhjnn4LtyS1XS23LTr37IS9EC
        QYCkoAP0=; b=p5JXa5ZCV39ji/p6irfYD/CiXosNIkEy7Rqvp7ioj9Vlxq3/Fv7
        R4Cg7w2cyk2tgcpGr85BceHqzsD2fGJvbxtmISAkPz5JDHUrp0mPh5BxlqITA/Zm
        WYymkldx2vuwSz6GVo5oWTjeDmEJ2aaY9er6juUWBhFrbQyn+GrteUVvinUkq9CX
        GlH/v90hTRDVVQPERp8coUQ3/6AS9VJXf/xDJUW/MoQYssFHDFqrlDpNgr6ZIBUW
        tc9V4votkFVr3LFufHF99a6vCaXT9a1Yde319LFYeccDg0B0UaP1O1j98733wv27
        Twh268yNB1qZa+rygIRCEGQ9XP+hk7I9ySA==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id D6PE-xX7_DvJ for <linux-kernel@vger.kernel.org>;
        Tue, 20 Dec 2022 16:36:05 -0800 (PST)
Received: from [10.89.80.120] (c02drav6md6t.dhcp.fujisawa.hgst.com [10.89.80.120])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4NcDyD3LqNz1RvLy;
        Tue, 20 Dec 2022 16:36:04 -0800 (PST)
Message-ID: <c8387766-2ca0-51f3-e332-71492b13e5c1@opensource.wdc.com>
Date:   Wed, 21 Dec 2022 09:36:03 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] scsi: libsas: Grab the host lock in
 sas_ata_device_link_abort()
Content-Language: en-US
To:     John Garry <john.g.garry@oracle.com>,
        Xingui Yang <yangxingui@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, niklas.cassel@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, prime.zeng@hisilicon.com,
        kangfenglong@huawei.com
References: <20221220125349.45091-1-yangxingui@huawei.com>
 <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <4ec9dbed-1758-d6b4-dc1d-ac42e8c22731@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/20 23:59, John Garry wrote:
> On 20/12/2022 12:53, Xingui Yang wrote:
>> Grab the host lock in sas_ata_device_link_abort() before calling
> 
> This is should be the ata port lock, right? I know that the ata comments 
> say differently.
> 
>> ata_link_abort(), as the comment in ata_link_abort() mentions.
>>
> 
> Can you please add a fixes tag?
> 
>> Signed-off-by: Xingui Yang <yangxingui@huawei.com>
> 
> Reviewed-by: John Garry <john.g.garry@oracle.com>
> 
>> ---
>>   drivers/scsi/libsas/sas_ata.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/scsi/libsas/sas_ata.c b/drivers/scsi/libsas/sas_ata.c
>> index f7439bf9cdc6..4f2017b21e6d 100644
>> --- a/drivers/scsi/libsas/sas_ata.c
>> +++ b/drivers/scsi/libsas/sas_ata.c
>> @@ -889,7 +889,9 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>>   {
>>   	struct ata_port *ap = device->sata_dev.ap;
>>   	struct ata_link *link = &ap->link;
>> +	unsigned long flags;
>>   
>> +	spin_lock_irqsave(ap->lock, flags);
>>   	device->sata_dev.fis[2] = ATA_ERR | ATA_DRDY; /* tf status */
>>   	device->sata_dev.fis[3] = ATA_ABORTED; /* tf error */
>>   
>> @@ -897,6 +899,7 @@ void sas_ata_device_link_abort(struct domain_device *device, bool force_reset)
>>   	if (force_reset)
>>   		link->eh_info.action |= ATA_EH_RESET;
>>   	ata_link_abort(link);

Really need to add lockdep annotations in libata to avoid/catch such bugs...
Will work on that.

>> +	spin_unlock_irqrestore(ap->lock, flags);
>>   }
>>   EXPORT_SYMBOL_GPL(sas_ata_device_link_abort);
>>   
> 

-- 
Damien Le Moal
Western Digital Research


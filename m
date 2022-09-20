Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF3C5BEF91
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 00:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiITWCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 18:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbiITWCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 18:02:50 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F9B2E6A2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1663711368; x=1695247368;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6u/Do0n+DJNOsBzHcFMsX5pbbOEzyvcZYBGc4xAk91s=;
  b=XC9VBuWikhpkLYVHBrF/+kzn9/MMlXwQ8G2Vu5Aa7jwPjlE31X3y8uh6
   N5+KhVl5AyH+1BDsyieZKpPidcj0fwFODi53j+NwCDScfAlKYCt7TNZhP
   SlNU38jmO1bWGnXK0N/wv/2tszITx76PdEl/q0umY3k9hsIBiHCLTgRcF
   dHQUMe6ddtWuKLzlRvrfVH4l1h50VZHowhMX5wUM1YgL+4PhgMhXfOKGE
   tMzbvlfZBwXnDbFLIf5TYJVzt+BNwl50j1YPsFAwf2MnssHqOa4lsqlk1
   4JOxLl+FPhp9hp66TCsBrOXr+vCJf4rmyK/BFgaMBwa+v5df4/Sre2SOG
   g==;
X-IronPort-AV: E=Sophos;i="5.93,331,1654531200"; 
   d="scan'208";a="211848336"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 21 Sep 2022 06:02:48 +0800
IronPort-SDR: Z5tjoK9ZDHQmXSQrL+CKo+1kuLdVAO/cmM+DfNHvbecVrKaYcxy529Wdy5L6NJ19kO+SqWi+H8
 5ZUINkIljGMWhac81u5nUmhp/j0ccq23ADF2oHCiezYxf20yxgFyIPRDdGGVYepHMmxdlHiomd
 npGD3iEp/G4qmt+bFxtDlKKZMxhBTTeHTjKAe7KpM4GdUw12Ov3EZUDJ6NjnBo8u85wlKfj80e
 fSOMgAHgyLtPx3g9mZsLxsTde0mkGHpjlzG+YHBaCtGtdUKATaye+Q16VE4kEl+CU12uGqbZ3t
 +2iwIoqzFUD6k5RBmFus48l7
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 14:17:24 -0700
IronPort-SDR: sKPUqq0LX6tkd2bD+7mSuxqizZuiZMwcnoqjVzBrcAVRaw5+boi1DfGYTPkQjpi3lCzpu6cPij
 lV6EC16DG/ALeGD82H+W01FWbmfLTi5DRSN6qRaH5vvqDH18aKdeAEyXl+aYb1QCAsOEOCCJ50
 tnCHnr/ztKlrCC7JiLJhktyLooln9AyFTdUgy3VeotyElDUdRlHDFg1B4mJtHmD9KyWdFUZ3dw
 Wb3GtY5hDBAGEfePxkjxMX4FOr71efwKtMvt+0VdirXhDzgtBC+DBy6huQKNEAAo1vHmKTr9QY
 ocw=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Sep 2022 15:02:49 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MXFsN4VwJz1RwtC
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 15:02:48 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1663711368; x=1666303369; bh=6u/Do0n+DJNOsBzHcFMsX5pbbOEzyvcZYBG
        c4xAk91s=; b=Vy2jDG5CWTP1bCLAuV+2/7XzFGagws2IDT2t68UUsgEHlhpJX3M
        omkxRW4wBMkbxtNRPh8Qx8sReRWiy+iwNOTm46I5IoXBDPQbqzfiPydACPVO6Bnr
        QyB9ezhsrXo3fElUVHlyDd0zNMQ21iVQiuuhcSFI9JVgTu54c2HW6toF5UrF3TTi
        L+wi5gdJ6uQso4VxuU+QOz2s56AsCKudramoD9wQpUymOPqASy+cUBbvEQTn7eJw
        8BYLPA0A80j+3eMVzdd7X82P+hIEyk34UFak912EHQKmzoP6YSgiGafXnifyuI/a
        1Kw68xjZ1LHOuPLsqC1VwTGzo2MiOe5sBHw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YRWqC1Od9WHm for <linux-kernel@vger.kernel.org>;
        Tue, 20 Sep 2022 15:02:48 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MXFsJ47y5z1RvLy;
        Tue, 20 Sep 2022 15:02:44 -0700 (PDT)
Message-ID: <ecde5199-bb9e-6df4-832a-f3707babd3d6@opensource.wdc.com>
Date:   Wed, 21 Sep 2022 07:02:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH RFC 2/6] scsi: scsi_transport_sas: Allocate end device
 target id in the rphy alloc
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, hare@suse.de, hch@lst.de
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, brking@us.ibm.com
References: <1663669630-21333-1-git-send-email-john.garry@huawei.com>
 <1663669630-21333-3-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1663669630-21333-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 19:27, John Garry wrote:
> Currently the per-end device target id is allocated when adding the rphy,
> which is when we execute the scan of the target.
> 
> However it will be useful to have the target id allocated earlier when
> allocating the rphy for the end device. For libata we want to move to a
> scheme of allocating the sdev early in the probe process and then later
> executing the scan (for that target). As such, users of would libata would
> require that the target id allocated earlier here (before the scan).
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/scsi/scsi_transport_sas.c | 25 +++++++++++++++++--------
>   1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/scsi/scsi_transport_sas.c b/drivers/scsi/scsi_transport_sas.c
> index 2f88c61216ee..56d325665bc7 100644
> --- a/drivers/scsi/scsi_transport_sas.c
> +++ b/drivers/scsi/scsi_transport_sas.c
> @@ -1433,6 +1433,7 @@ static void sas_rphy_initialize(struct sas_rphy *rphy)
>   struct sas_rphy *sas_end_device_alloc(struct sas_port *parent)
>   {
>   	struct Scsi_Host *shost = dev_to_shost(&parent->dev);
> +	struct sas_host_attrs *sas_host = to_sas_host_attrs(shost);
>   	struct sas_end_device *rdev;
>   
>   	rdev = kzalloc(sizeof(*rdev), GFP_KERNEL);
> @@ -1455,6 +1456,10 @@ struct sas_rphy *sas_end_device_alloc(struct sas_port *parent)
>   	sas_rphy_initialize(&rdev->rphy);
>   	transport_setup_device(&rdev->rphy.dev);
>   
> +	mutex_lock(&sas_host->lock);
> +	rdev->rphy.scsi_target_id = sas_host->next_target_id++;
> +	mutex_unlock(&sas_host->lock);
> +
>   	return &rdev->rphy;
>   }
>   EXPORT_SYMBOL(sas_end_device_alloc);
> @@ -1500,6 +1505,16 @@ struct sas_rphy *sas_expander_alloc(struct sas_port *parent,
>   }
>   EXPORT_SYMBOL(sas_expander_alloc);
>   
> +static bool sas_rphy_end_device_valid_tproto(struct sas_rphy *rphy)
> +{
> +	struct sas_identify *identify = &rphy->identify;
> +
> +	if (identify->target_port_protocols &
> +	    (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA))
> +		return true;
> +	return false;

You could just do:

return identify->target_port_protocols &
	(SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA))

> +}
> +
>   /**
>    * sas_rphy_add  -  add a SAS remote PHY to the device hierarchy
>    * @rphy:	The remote PHY to be added
> @@ -1529,16 +1544,10 @@ int sas_rphy_add(struct sas_rphy *rphy)
>   
>   	mutex_lock(&sas_host->lock);
>   	list_add_tail(&rphy->list, &sas_host->rphy_list);
> -	if (identify->device_type == SAS_END_DEVICE &&
> -	    (identify->target_port_protocols &
> -	     (SAS_PROTOCOL_SSP | SAS_PROTOCOL_STP | SAS_PROTOCOL_SATA)))
> -		rphy->scsi_target_id = sas_host->next_target_id++;
> -	else if (identify->device_type == SAS_END_DEVICE)
> -		rphy->scsi_target_id = -1;
>   	mutex_unlock(&sas_host->lock);
>   
>   	if (identify->device_type == SAS_END_DEVICE &&

You could move this check inside sas_rphy_end_device_valid_tproto(),
no ?

> -	    rphy->scsi_target_id != -1) {
> +	    sas_rphy_end_device_valid_tproto(rphy)) {
>   		int lun;
>   
>   		if (identify->target_port_protocols & SAS_PROTOCOL_SSP)
> @@ -1667,7 +1676,7 @@ static int sas_user_scan(struct Scsi_Host *shost, uint channel,
>   	mutex_lock(&sas_host->lock);
>   	list_for_each_entry(rphy, &sas_host->rphy_list, list) {
>   		if (rphy->identify.device_type != SAS_END_DEVICE ||
> -		    rphy->scsi_target_id == -1)
> +		    !sas_rphy_end_device_valid_tproto(rphy))
>   			continue;
>   
>   		if ((channel == SCAN_WILD_CARD || channel == 0) &&

-- 
Damien Le Moal
Western Digital Research


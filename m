Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9732C5EEB70
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 04:09:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiI2CJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 22:09:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiI2CJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 22:09:42 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3916D7658
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664417380; x=1695953380;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UePg92TmQirppI3fLER8oTy0F5vGd/zU7VLVsuGJ+60=;
  b=Li+GEJlaXlh5sYQlCnRBzLTfCIp4CY1X6bJv6FWFR9lesGhR2zzILlMU
   M0umg0VHofxI8o/4Kp05UTVxcIcjE8Xz+SBWcMD9x4wK7a3ckxn1RpMSA
   XKv79n1zZTUx9pNhdJhC7nuybsgIjoLhzt58RH5Bay0RjdfzykcSFhCTT
   fkoTKdlsQw1lyvSg6NcqGJn7oYbBaDhWD7fydgD/Cklfdw50gOEn/LskB
   lvGctGBES2nckAazJ7IEIvd9/RXgqDTkUYg+kVReRxwglJ9IZDlNQaIEV
   yxnncZ7ME8jitCNFkvaF89MmSz4+MoT13kmVBDCia5dQp8rILUpxgHwN6
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,353,1654531200"; 
   d="scan'208";a="212540169"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 10:09:39 +0800
IronPort-SDR: pcvMHEJ5FJnbS63FavhmAp7d8i/dtA0ix6BBbJx+DIqNVAPBSWY1i0/xR9wu5vVa3kmKHmkcEC
 bglO5VHrgMMDb6bQNGSZnhC3zCROq1jxRKmCvl1+CPjYAttx7v8cYGHiUsAigy+s7crAJ60ZhF
 xkpwdYW8jYjAAP25uuhODHxcOmuUWN4EAlEgzquH14U3wZeGe9KJg6lh1/UxW5vs67oEC2kMDs
 X1d5vp+m5XCzN8zOjPdxioIsDQdrkO33HBWEElvmCogVVwFPbySoF11aXsLbg6e2kYXCHTvxmy
 2iv0N0fqot3sA8jpTUYmm2T4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 18:29:34 -0700
IronPort-SDR: Bs9YIeuAwrDO5y00lbbiAq823ZbBlGZzTZDPd7+9JPZsgEUl8NnYnInJ6EZxnq6A1fFAaevEZF
 Q+AVf20EgA1GYupZNd2hg5GB+i4fgy7XAidwXEeMppEnMDFLAOxs6opA0q3ovCURD5359/UPDx
 moBdg1gxQ7YjqtnJiWH0FT2ickAyKArR0GuHszGJMrj2m6Brxlto/m+fjOMIMTPZwjvIJOvpwf
 /fkVK4fAi+mdY5x3KL7WzhWaR22E9yFNYNvzDdZmLwRKWQdaLEp3LMX7dIaHdQiiJ+3vQa2pVp
 Dck=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Sep 2022 19:09:39 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MdGyW0rS6z1Rwtl
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 19:09:39 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664417378; x=1667009379; bh=UePg92TmQirppI3fLER8oTy0F5vGd/zU7VL
        VsuGJ+60=; b=oTuOwkz/6D3sY84sla1wrNVLi37KJq23/Gf9FMfUcXNN1qNSoN9
        eE5wEtPuHlfnMsPKjLrp3okD7CzojRh83fYwuoEFQyF9F9SzGDZioFpG6IRSD/gF
        PWhBzDQgIfvGWK52/xHC2QPdUjrx1Sees2LDMAfRcIi5nsn+Gnnwsrt+C2heQDEr
        KKJowu5huCFN5fZkJ+O+cVKfI2zk0OiIO96m2D/mXa7tE8AbhL7d1KdZrzcwDRqF
        fzyKaPsHmeeU0cGvn60sZQhCSAYe/CWALn7ulXG3Lc7OBjZG5K+4TrXDH6CR40IJ
        SYFPVai/8ODd1FhhZfPtSPaxUEzC+qDOl5Q==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8UpTYnDmnu4N for <linux-kernel@vger.kernel.org>;
        Wed, 28 Sep 2022 19:09:38 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MdGyS20pzz1RvLy;
        Wed, 28 Sep 2022 19:09:36 -0700 (PDT)
Message-ID: <0c0306d7-2645-874a-9745-8aa5dcfeede1@opensource.wdc.com>
Date:   Thu, 29 Sep 2022 11:09:35 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/6] scsi: libsas: Add sas_task_find_rq()
Content-Language: en-US
To:     John Garry <john.garry@huawei.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, jinpu.wang@cloud.ionos.com,
        damien.lemoal@wdc.com
Cc:     hare@suse.de, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        ipylypiv@google.com, changyuanl@google.com, hch@lst.de
References: <1664368034-114991-1-git-send-email-john.garry@huawei.com>
 <1664368034-114991-2-git-send-email-john.garry@huawei.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1664368034-114991-2-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 21:27, John Garry wrote:
> blk-mq already provides a unique tag per request. Some libsas LLDDs - like
> hisi_sas - already use this tag as the unique per-IO HW tag.
> 
> Add a common function to provide the request associated with a sas_task
> for all libsas LLDDs.
> 
> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>  include/scsi/libsas.h | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/include/scsi/libsas.h b/include/scsi/libsas.h
> index f86b56bf7833..bc51756a3317 100644
> --- a/include/scsi/libsas.h
> +++ b/include/scsi/libsas.h
> @@ -644,6 +644,28 @@ static inline bool sas_is_internal_abort(struct sas_task *task)
>  	return task->task_proto == SAS_PROTOCOL_INTERNAL_ABORT;
>  }
>  
> +static inline struct request *sas_task_find_rq(struct sas_task *task)
> +{
> +	struct scsi_cmnd *scmd;
> +
> +	if (!task || !task->uldd_task)
> +		return NULL;
> +
> +	if (task->task_proto & SAS_PROTOCOL_STP_ALL) {
> +		struct ata_queued_cmd *qc;
> +
> +		qc = task->uldd_task;

I would change these 2 lines into a single line:

		struct ata_queued_cmd *qc = task->uldd_task;

And no cast as suggested.

> +		scmd = qc->scsicmd;
> +	} else {
> +		scmd = task->uldd_task;
> +	}
> +
> +	if (!scmd)
> +		return NULL;
> +
> +	return scsi_cmd_to_rq(scmd);
> +}
> +
>  struct sas_domain_function_template {
>  	/* The class calls these to notify the LLDD of an event. */
>  	void (*lldd_port_formed)(struct asd_sas_phy *);

-- 
Damien Le Moal
Western Digital Research


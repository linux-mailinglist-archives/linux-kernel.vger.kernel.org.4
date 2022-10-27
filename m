Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7248260ED03
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 02:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233512AbiJ0AbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 20:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJ0Aa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 20:30:59 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D73910452A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666830658; x=1698366658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=uNlqtDf6jWpkFPA0E2cg8BhVIpvaDxbPOBiNnbpCpcg=;
  b=WqJLOftIWd/flCHR/a+l8ASrHfKo/Jd+OqJSooPLKyN4QSSS/KobvPJv
   QH+Q9jVBZ3QFytyOP+0S/BuSfNRrX6aF2aAW5XQ5ah7CYxKOa3buTZtgz
   4uRVeZPCCHHktY0ShWKvYFiIBjORXRASJ/Ezzr2ITgL5zHQKz94Oux2OY
   7XcktkiKqizInoZkTmIiC8NMxyWPz13FqZUCDuNj1xF0RF9Yk62aAg/qy
   jOMz5jRzRqUOd38M088I2qNL1WwZTQv+czR1jnbL2g40hgMsdUMw/Bvar
   IZG6WNxMqeiOBKiNkLkdu7vuSg37BYyanz6jKnIt+91Pg6Wz/o4mGmQOv
   g==;
X-IronPort-AV: E=Sophos;i="5.95,215,1661788800"; 
   d="scan'208";a="219994892"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 27 Oct 2022 08:30:57 +0800
IronPort-SDR: /5xjH2xzZOuaS4i6wS+aQbz2Ael3EQG5YeICI38nsRO8P6IsufQ8uEkn+lXfmVdRiIQ/E1zMnn
 +7Ze9WbbHBEqnOZ9pGHj/oQYuhtp4QcubmpMy2Tg/zBX1+279a3y2v81dBR8SSHWDSePKQRflL
 5gtInonZrCf0KFfftrA0h2d1LLa8TI6SZ9q3nyLYG+uzlnNcb7e6BW02JxuWSfxVbIWW9PoHgi
 3l9Vn+1U2H/poVWkhyZQj6O73cYtJoJ/NJjKCkzxJQ0lWLrBQM3Yx5tPsjuTpRPELfTKkkDUAw
 tj0a2lmZx1Qn5eOAzG03aU5P
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 16:50:18 -0700
IronPort-SDR: LzAdDNRHO6tAxoUU5Eb2rQeGNrOfnmuWhdo7QITEj1fWZLS/+C595UeQHTjIBgPBd6KltiHKFO
 3U8YJlHNDTHdOAzgDOmcDavepJfTxs5y0+6LeL0aeLkrxXNpRbZJa9koL1BTg4YWyTIjHGYd+w
 j2vU7FQ56yRSA1caBKfdzXhQyUFCdMicik16wCMiqlGloGikq8Vi/lV3deiC73tZcBJ/W2ky14
 ee7cNff2J7oaNB7iD8yCxMXiY/1Ms0xrglHE0UsfCi+1Rjn52FkiDG+6f/y+hgQXGwdUwN5gHm
 87g=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 26 Oct 2022 17:30:57 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4MyRRh5gQFz1Rwt8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 17:30:56 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:content-language:references:to
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1666830656; x=1669422657; bh=uNlqtDf6jWpkFPA0E2cg8BhVIpvaDxbPOBi
        NnbpCpcg=; b=EmJz53YhIuBHiIY3ei1U3aKKp940WjQ2V8n2aGWzEOVHOXFqHw+
        F+ST5FDSsRDf5L6i6vnb56UxNGUkqU5bqF0npHqh2syqrURlAp5dNeVdz8WfJzHv
        yZKT8K4Szth/Yp6izNkT8Sqy3XLYUdRf5HbE3BrSKbh9eQ9buWeRriAeS7k2mIwE
        LWZUmyOW7mYs1YMANChRgWtVEDPxMDmHxC0acD6sytZWi44GrxMeF0FsxaQQA/lh
        iMzZztxhXOGYhU1iW2s29QrvpcaltA50LpMjc+ciNuoPWzuVRdRunJg5iaMczK2m
        8TcCQHE+UIIHIUNPnFO8mBoZuRUSaEmnAbg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id i3UA6536VBrp for <linux-kernel@vger.kernel.org>;
        Wed, 26 Oct 2022 17:30:56 -0700 (PDT)
Received: from [10.149.53.254] (washi.fujisawa.hgst.com [10.149.53.254])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4MyRRf6Xd1z1RvLy;
        Wed, 26 Oct 2022 17:30:54 -0700 (PDT)
Message-ID: <23b7b1f7-94c1-9c01-e1c8-c0a30a4aa06d@opensource.wdc.com>
Date:   Thu, 27 Oct 2022 09:30:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH] scsi: pm8001: Drop !task check in pm8001_abort_task()
To:     John Garry <john.garry@huawei.com>, jinpu.wang@cloud.ionos.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1666781764-123090-1-git-send-email-john.garry@huawei.com>
Content-Language: en-US
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <1666781764-123090-1-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/22 19:56, John Garry wrote:
> In commit 0b639decf651 ("scsi: pm8001: Modify task abort handling for SATA
> task"), code was introduced to dereference "task" pointer in
> pm8001_abort_task(). However there was a pre-existing later check for
> "!task", which spooked the kernel test robot.
> 
> Function pm8001_abort_task() should never be passed NULL for "task"
> pointer, so remove that check. Also remove the "unlikely" hint, as this is
> not fastpath code.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> diff --git a/drivers/scsi/pm8001/pm8001_sas.c b/drivers/scsi/pm8001/pm8001_sas.c
> index 2359e827c9e6..e5673c774f66 100644
> --- a/drivers/scsi/pm8001/pm8001_sas.c
> +++ b/drivers/scsi/pm8001/pm8001_sas.c
> @@ -979,7 +979,7 @@ int pm8001_abort_task(struct sas_task *task)
>  	u32 phy_id, port_id;
>  	struct sas_task_slow slow_task;
>  
> -	if (unlikely(!task || !task->lldd_task || !task->dev))
> +	if (!task->lldd_task || !task->dev)
>  		return TMF_RESP_FUNC_FAILED;
>  
>  	dev = task->dev;

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

-- 
Damien Le Moal
Western Digital Research


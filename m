Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EEAE5F4F52
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 07:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiJEFJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 01:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJEFIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 01:08:23 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1B674E05
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664946393; x=1696482393;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EeFB7dhZIp+jQGWS+hX5NNzke0u6/fjW43g1++marZU=;
  b=ddFPBeTaBqY+YVfWZrtqTb0sTNEeZXrgZt/1dAjzfjnqxeflSZyOWabZ
   CoUiFbZOxT/tkuZbLNut/kBRzNTaoL28NdrUfbAWA1jo8bCI+KDfhzd2i
   Ddqy//f7v9iHUUwYdr9+T+rVBvGHFH2O+iKEdfcpeT/2DFdN9RnVlCD6i
   2h9fBCXDQEPLKWLv0W295MFTw1Mo8UqT2vsTfisp0GuDjbZPOFPdIfJjP
   337r/Qzb4fL5TCr3CqVTohn0fZ7SDePeqtOkCoTZjgsrdtnAet/NSm6zT
   JNJPKKFMIztlPkAUttNdOKzqSoheCH3hHnPrBqoWPlUGvpvjnCxSpQn/h
   A==;
X-IronPort-AV: E=Sophos;i="5.95,159,1661788800"; 
   d="scan'208";a="213419525"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 05 Oct 2022 13:06:23 +0800
IronPort-SDR: sglQV96LWFbKqKQeX/ILBh6o99XHiuY+YkPItnAFacEh0axXZzpztzG5Gd2/BMRkg3w8UaeyV6
 Hyb68KYjwoYVkzV7GDCC6cxGF1aU+Ke49wxK/73QbWGWd2aHpLRKSXb8LTblegqYLPknN0Y4HA
 Jl/DcdXRh1vI+RfDsfKHreQVAvdUZ42SbKRfIBMHDSCOkBIe/HvFfx+iWA/XZVIqZjNDVU63ht
 0onmKYDK/W05gSHZXQ0OOVF+Lmq47Juipt6TvheCJrvWQO7aLFGE/0jMlhWmq7zcEHwmq2VHGI
 992gHEOAAVQGVZCNDHz9zyB/
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 21:20:36 -0700
IronPort-SDR: hWbNISSjXmZ/mCdiGLKdjyz1gvujTwULauL6SzAVr4xGoIXsvZQ4gEngqKpSBRL/6EL/4fEBLZ
 vC1tSbaZh1NuC/MvlH9qsl44NyqIzNEXMxSlvFcrUduIt+MWvBRmH+A4kTzBxxUwxZf3dF4W3F
 okonslHYZWb8b2Vb5DAtrdZIuKGyNPG7RQuNNH6IIXWJja2js/Ss+nZt5ToZIMZZw4KCh9dZKv
 dSBnzMbprwn53Txw5COROFA8yXobtphM46wjJJyxdYOXllvsA1xCR2Q6QE9DqY7U87EVOcL+uC
 Koo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Oct 2022 22:06:24 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4Mj2bg1gSFz1RvLy
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 22:06:23 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1664946382; x=1667538383; bh=EeFB7dhZIp+jQGWS+hX5NNzke0u6/fjW43g
        1++marZU=; b=YKAozr7TbiFanSOWsaUl7LJWKepls26WHxlHBneEkUVarAlnlVw
        KdRlJzj29gFBzcri5pAhPDm0g0wvlhYDpHlNqwqe7PBahW3142oAMpRv5wQUtv63
        cj0SidiuVcbfsIYKM596fyELPnorTLHE26JraNHoJ0hhi1/yASSj5twPkCqcZYbF
        WBlplZslJLaxeDzYRBzu7uvYv/xRaZedREOni9O81T9dNO5hWf8Hqg1b8EUhi5oD
        WRYAoEmG4Pf/vF0eruPwelrZ0JobZPRJLt8Ag3xjnaoiErqlaZG+KFGa1VikTyYi
        UL5+rb19S0WljvNAYEMlxFCncqSlX8IfYBw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PWdcseyF585m for <linux-kernel@vger.kernel.org>;
        Tue,  4 Oct 2022 22:06:22 -0700 (PDT)
Received: from [10.225.163.106] (unknown [10.225.163.106])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4Mj2bd0nCjz1RvTp;
        Tue,  4 Oct 2022 22:06:20 -0700 (PDT)
Message-ID: <ea505961-758e-01ab-6ce9-775f170c3979@opensource.wdc.com>
Date:   Wed, 5 Oct 2022 14:06:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 6/6] null_blk: remove extra space in switch condition
Content-Language: en-US
To:     Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     axboe@kernel.dk, johannes.thumshirn@wdc.com, bvanassche@acm.org,
        ming.lei@redhat.com, shinichiro.kawasaki@wdc.com,
        vincent.fu@samsung.com, yukuai3@huawei.com
References: <20221005031701.79077-1-kch@nvidia.com>
 <20221005031701.79077-7-kch@nvidia.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20221005031701.79077-7-kch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 12:17, Chaitanya Kulkarni wrote:
> The extra space in after switch condition does not follow kernel coding
> standards, remove extra space in switch condition end_cmd().
> 
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  drivers/block/null_blk/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eda5050d6dee..e030f87d0208 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -789,7 +789,7 @@ static void end_cmd(struct nullb_cmd *cmd)
>  {
>  	int queue_mode = cmd->nq->dev->queue_mode;
>  
> -	switch (queue_mode)  {
> +	switch (queue_mode) {
>  	case NULL_Q_MQ:
>  		blk_mq_end_request(cmd->rq, cmd->error);
>  		return;

-- 
Damien Le Moal
Western Digital Research


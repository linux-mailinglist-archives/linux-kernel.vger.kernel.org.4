Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297076A32B9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjBZQKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:10:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBZQKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:10:42 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412E915560;
        Sun, 26 Feb 2023 08:10:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id t15so3837175wrz.7;
        Sun, 26 Feb 2023 08:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=djzqrtOMQJZwFBUw6nLjGzlqHj5X2tklbzG5twEnCXY=;
        b=V8aTa5JRGEAaGQYU28XDRgLbIOzrbpfgnAUQvBsgxlcrgn2nyl/7rX7utupOM+ChEU
         +kt+lxiRF8bSptGggqdXDjozmaUYzX8BwPMS7cDRv9RZ6aND/l/DpX89HHuepK0871EZ
         9a4d+HsvmZ1YWlVSSxcGf8u1rFgJ7jIK6s5zfywv45rRXTnzCELuPG5w1Iq2HubxNbbl
         gYRBAPOexY6W3/w6OYbkW/Hg9ghw5lLfs0e9of4USw6OmlagQ+fhC3K9qEAnjOYDvPWI
         2o6xnOwRYiqt9/442cNwlQSi/igTNBG2uTIYlmqZB9beeBkIEDwEJo8d+NvKzruvy6PG
         OvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=djzqrtOMQJZwFBUw6nLjGzlqHj5X2tklbzG5twEnCXY=;
        b=LXMX4KqfpwO7LiiJywshmAHO0g5ag1NyddflDfZJyYAg6kMUJ/6v3+Olb+CZDmVu1e
         3aO8e8xg+jx5STrgqOPJQ92tVrWwkbnpFAx7JvzZVUITYeVLyeEd9cNFM5JYtonAoY1L
         wW10uPjnZyCxYzsxsaSnCHpQVjP9koZt0mr7H1VrDwfWvuOV/QSst5W/sb2bxoCtt8dq
         /CijfW2f/f2705c0aLVxjmX02+5O+tpy8LQaW9NALUDkPOr8FksG/rhHJgiYoXEqkKwt
         N24/cuyOicJj/cbVdkUf7duJvP1qLS6+VBWcX9RHfrP8CLul3jUbwTMq1TgbxhRgRTeE
         ev2g==
X-Gm-Message-State: AO0yUKUhqWrdP/Qy3b2RdcORZJBRMY8Wh1bS8nFPZMDPXp+MiPTyBsRd
        Im0gf5IIm++5yywe78iINKI=
X-Google-Smtp-Source: AK7set+O6bbAbxN1Ua/kXrH9BrNj+8QqW48HQ41VeWnrZz80AzUBwi3iXQAPXrouWaLivdhHnhmNcA==
X-Received: by 2002:adf:f6c1:0:b0:2c9:5dd8:2978 with SMTP id y1-20020adff6c1000000b002c95dd82978mr3003862wrp.59.1677427839646;
        Sun, 26 Feb 2023 08:10:39 -0800 (PST)
Received: from ?IPV6:2003:c5:8708:4321:dcf1:ac0e:cc8d:62ca? (p200300c587084321dcf1ac0ecc8d62ca.dip0.t-ipconnect.de. [2003:c5:8708:4321:dcf1:ac0e:cc8d:62ca])
        by smtp.gmail.com with ESMTPSA id n7-20020adfe787000000b002c573778432sm4674775wrm.102.2023.02.26.08.10.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 08:10:36 -0800 (PST)
Message-ID: <d7dbf7e2-5cfe-d728-4ca6-51ab8a6ac60c@gmail.com>
Date:   Sun, 26 Feb 2023 17:10:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 3/6] scsi: ufs: core: Fix mcq nr_hw_queues
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
References: <20230223152757.13606-1-powen.kao@mediatek.com>
 <20230223152757.13606-4-powen.kao@mediatek.com>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230223152757.13606-4-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.23 4:27 PM, Po-Wen Kao wrote:
> Since MAXQ is 0 based value, add one to obtain number of hardware queue.

MAXQ in Multi-Circular Queue Capability Register is 0 based, hence ..

>
> Signed-off-by: Po-Wen Kao<powen.kao@mediatek.com>
> ---
>   drivers/ufs/core/ufs-mcq.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/core/ufs-mcq.c b/drivers/ufs/core/ufs-mcq.c
> index a39746b2a8be..f9af658b4ba2 100644
> --- a/drivers/ufs/core/ufs-mcq.c
> +++ b/drivers/ufs/core/ufs-mcq.c
> @@ -150,7 +150,8 @@ static int ufshcd_mcq_config_nr_queues(struct ufs_hba *hba)
>   	u32 hba_maxq, rem, tot_queues;
>   	struct Scsi_Host *host = hba->host;
>   
> -	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities);
> +	/* maxq is 0 based value */
> +	hba_maxq = FIELD_GET(MAX_QUEUE_SUP, hba->mcq_capabilities) + 1 ;

Reviewed-by: Bean Huo <beanhuo@micron.com>


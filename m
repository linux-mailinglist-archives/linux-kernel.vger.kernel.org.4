Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E4C5F0C4F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiI3NUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiI3NUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:20:36 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8313ACA1A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:20:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id t4so2903722wmj.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:20:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rUPHkLfCnOExIOPw36MI3hiNQgUNOyt/+Ejs2msZtGo=;
        b=oaRVIi/nM4qtf2LWlFNRoa6QLY6sjwD6WQdykKgiDYikNPedM+I06euEHolmIDII1A
         GgjLJmjePVj/Q4Ylfn+cT+al+ZX0EA+Wug+ov9QlQ7N4DcHAp40UUwJjfruL1JnRarjD
         UzqUkcxUSWsy0pdzX8F95RU2Iv14z8W9P9iVHGI1RzEVsPtVWWZR5VnQ4qHarYmuL5a5
         5gbUPzro/PlyNUslpWj0Hu01LK27NOwoo8UqZsvmaZyEUQ5FY531oEJfTLu7khO0llTY
         8yAuBxqnjJw+QpuBLKuUyFcr5CJK7fjKJzcLKmP0dec62/I9V1TT9aC96Q9pk+D8ML3k
         cLnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rUPHkLfCnOExIOPw36MI3hiNQgUNOyt/+Ejs2msZtGo=;
        b=w3QjDrQ21ZZN3+rtAxbGT06gMmUYjnXf689f2uLCnlbS6RV+QGrMUkzNjFqNuKulAa
         cjabLrCc7Rgk+tmKvAKH69gUDqF8mivzGCtscb49B12QfHjAHHDNzWYYDmB2tctiigMg
         P57euxrypk+RO7iKzg4tuLppGaDbdWsx6ig3RTh2+lCj9fCiNs62y0NEFlF2nQLovWU2
         mb+kN6mMiHFhZjkcETVeaKZ2JeYRkQRru11R05osovUmULlIRA7DlZD9U7sctYXfH1gc
         0+M5ISq1MC8JDEV15AVGkJ0DihU2KVzWaFcz1V3M8T0zRdJP5g06FCJVNpjxEiIW+VXW
         86Tw==
X-Gm-Message-State: ACrzQf3KGeEhBfJdbg2P7YLt8ShFnAMO84L/KTNvysWzU2pMM9uAlHuA
        NQVdVayfWjQnxLHz6p3q0TJChuesv6I=
X-Google-Smtp-Source: AMsMyM4pt64tMe4+pb2vpJpg8/j08+dib/aZWGT5IUsBTYyfLgJ+EoR6u38rGNGwI7+uqxhv/rIdEw==
X-Received: by 2002:a7b:ce0d:0:b0:3b4:8728:3e7e with SMTP id m13-20020a7bce0d000000b003b487283e7emr5601443wmc.182.1664544031821;
        Fri, 30 Sep 2022 06:20:31 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id b3-20020adfee83000000b0022cc3e67fc5sm1987475wro.65.2022.09.30.06.20.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 06:20:30 -0700 (PDT)
Message-ID: <bc6a4fe5-3f9e-6552-eeab-f1665d691f56@gmail.com>
Date:   Fri, 30 Sep 2022 15:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v7, 1/3] mailbox: mtk-cmdq: add gce software ddr enable
 private data
Content-Language: en-US
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220930095915.13684-1-yongqiang.niu@mediatek.com>
 <20220930095915.13684-2-yongqiang.niu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220930095915.13684-2-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/09/2022 11:59, Yongqiang Niu wrote:
> if gce work control by software, we need set software enable
> for MT8186 Soc
> 
> there is a handshake flow between gce and ddr hardware,
> if not set ddr enable flag of gce, ddr will fall into idle
> mode, then gce instructions will not process done.
> we need set this flag of gce to tell ddr when gce is idle or busy
> controlled by software flow.
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 9465f9081515..04eb44d89119 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -38,6 +38,8 @@
>   #define CMDQ_THR_PRIORITY		0x40
>   
>   #define GCE_GCTL_VALUE			0x48
> +#define GCE_CTRL_BY_SW				GENMASK(2, 0)
> +#define GCE_DDR_EN				GENMASK(18, 16)
>   
>   #define CMDQ_THR_ACTIVE_SLOT_CYCLES	0x3200
>   #define CMDQ_THR_ENABLED		0x1
> @@ -80,6 +82,7 @@ struct cmdq {
>   	bool			suspended;
>   	u8			shift_pa;
>   	bool			control_by_sw;
> +	bool			sw_ddr_en;
>   	u32			gce_num;
>   };
>   
> @@ -87,6 +90,7 @@ struct gce_plat {
>   	u32 thread_nr;
>   	u8 shift;
>   	bool control_by_sw;
> +	bool sw_ddr_en;
>   	u32 gce_num;
>   };
>   
> @@ -129,7 +133,11 @@ static void cmdq_init(struct cmdq *cmdq)
>   
>   	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
>   	if (cmdq->control_by_sw)
> -		writel(0x7, cmdq->base + GCE_GCTL_VALUE);
> +		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);

Thanks for doing this, but I think this should be part of a seperate patch. It's 
a cleanup and has nothing to do with the new sw_ddr_en, correct?

Regards,
Matthias

> +
> +	if (cmdq->sw_ddr_en)
> +		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
> +
>   	writel(CMDQ_THR_ACTIVE_SLOT_CYCLES, cmdq->base + CMDQ_THR_SLOT_CYCLES);
>   	for (i = 0; i <= CMDQ_MAX_EVENT; i++)
>   		writel(i, cmdq->base + CMDQ_SYNC_TOKEN_UPDATE);
> @@ -543,6 +551,7 @@ static int cmdq_probe(struct platform_device *pdev)
>   	cmdq->thread_nr = plat_data->thread_nr;
>   	cmdq->shift_pa = plat_data->shift;
>   	cmdq->control_by_sw = plat_data->control_by_sw;
> +	cmdq->sw_ddr_en = plat_data->sw_ddr_en;
>   	cmdq->gce_num = plat_data->gce_num;
>   	cmdq->irq_mask = GENMASK(cmdq->thread_nr - 1, 0);
>   	err = devm_request_irq(dev, cmdq->irq, cmdq_irq_handler, IRQF_SHARED,

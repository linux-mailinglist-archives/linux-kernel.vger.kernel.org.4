Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDEE5F0C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 15:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiI3NSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 09:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiI3NSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 09:18:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13DE42C642
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:18:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id c11so6806464wrp.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 06:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=rgiQh7mP8KwG/YiurXPmj99tTlJmmSjn1FaGlOzYS6k=;
        b=J1PVYqGiQwSCTJwk6eVIAkLAaoQVwcWlWx4og5FPF95IVoe6rxARW+ZU41LLZswjVt
         DRPTvp+v2tfeM9CDKgXfaoanO+imTxYP0lmngQncZU4UWV5A44gOUtTFW4mn60SmHu9D
         nzF2eMtbimnzY1CS7bwZCjigOB9eE4Nc7OEkx1g9u1CG0cnE7xwjOVh2EPgoW006/TUP
         dzZNzAKPhutYm4HxNkyT7LZnDgorgnH47yiReW+k2fetW47+h8CgvCHVO4EA2ecSW8/l
         yDo6Yt9XqtuwWsIY6cxb5hn+x7kA+Osks6uETGpuek+lEtC8Bh7GeTFk0gX93epDA/qK
         BQlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=rgiQh7mP8KwG/YiurXPmj99tTlJmmSjn1FaGlOzYS6k=;
        b=mTs2vxhwZKx6PiTCMVK/m7IQ+Kv9BfPzzXZA42iEBY8rH2M6hCxQhEX2DiBjjzy8fv
         FfNtdbWox1XUVTngGgwoeLtvlVVDXGeVJj9WPBJuD5LVkhL/sop7RkTres8dBNVnWGX7
         VmuKzSGZxDHekv9sdlHYZAShc71Q74tDA4ewG4GNAuy9+8WO35IkJ81vF6rbyN8EcPyH
         lfyBrMyo9j2WyVPOS9vR5Ph5WGM1TSVVplEf1Zoo9sBxLnCd23RZjB8f3qFBXtK9m2qj
         fTMTyLLLel8tPPR1G/J+FSuEml4GfNL6LBRTPnXT//iTgMb605E53genABwO1Q7ko/+D
         vvRw==
X-Gm-Message-State: ACrzQf3/IFi4NB52s7SvevGaHvQ0X2mkwIFMhxT/qEMraSBgyO5Ki92y
        gP26Da66sGd92cgtOP2qFbBJ/5cMTvE=
X-Google-Smtp-Source: AMsMyM6MIuxu3qhuv0DkvpGaMMPc5S7P2yhXwxKVeIELOYwNdBiCpSdvg15YKFUyFTlXEXuBQmIHhg==
X-Received: by 2002:a5d:64e4:0:b0:22a:4997:c13c with SMTP id g4-20020a5d64e4000000b0022a4997c13cmr6029240wri.621.1664543895204;
        Fri, 30 Sep 2022 06:18:15 -0700 (PDT)
Received: from [192.168.0.30] ([47.62.125.55])
        by smtp.gmail.com with ESMTPSA id ay26-20020a05600c1e1a00b003b4868eb6bbsm2565061wmb.23.2022.09.30.06.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Sep 2022 06:18:13 -0700 (PDT)
Message-ID: <3de55ec9-568a-6240-c13a-f35adff228d3@gmail.com>
Date:   Fri, 30 Sep 2022 15:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v7, 2/3] mailbox: mtk-cmdq: add gce ddr enable support
 flow
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20220930095915.13684-1-yongqiang.niu@mediatek.com>
 <20220930095915.13684-3-yongqiang.niu@mediatek.com>
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20220930095915.13684-3-yongqiang.niu@mediatek.com>
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
> add gce ddr enable control flow when gce suspend/resume
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>   drivers/mailbox/mtk-cmdq-mailbox.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
> index 04eb44d89119..84a60750d0c4 100644
> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
> @@ -94,6 +94,21 @@ struct gce_plat {
>   	u32 gce_num;
>   };
>   
> +static void cmdq_sw_ddr_enable(struct cmdq *cmdq, bool enable)
> +{
> +	if (!cmdq->sw_ddr_en)
> +		return;
> +
> +	WARN_ON(clk_bulk_enable(cmdq->gce_num, cmdq->clocks));
> +
> +	if (enable)
> +		writel(GCE_DDR_EN | GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
> +	else
> +		writel(GCE_CTRL_BY_SW, cmdq->base + GCE_GCTL_VALUE);
> +
> +	clk_bulk_disable(cmdq->gce_num, cmdq->clocks);
> +}
> +
>   u8 cmdq_get_shift_pa(struct mbox_chan *chan)
>   {
>   	struct cmdq *cmdq = container_of(chan->mbox, struct cmdq, mbox);
> @@ -319,6 +334,8 @@ static int cmdq_suspend(struct device *dev)
>   	if (task_running)
>   		dev_warn(dev, "exist running task(s) in suspend\n");
>   
> +	cmdq_sw_ddr_enable(cmdq, false);

I'd say
if (!cmdq->sw_ddr_en)
should be checked before calling cmdq_sw_ddr_enable().

Regards,
Matthias

> +
>   	clk_bulk_unprepare(cmdq->gce_num, cmdq->clocks);
>   
>   	return 0;
> @@ -330,6 +347,9 @@ static int cmdq_resume(struct device *dev)
>   
>   	WARN_ON(clk_bulk_prepare(cmdq->gce_num, cmdq->clocks));
>   	cmdq->suspended = false;
> +
> +	cmdq_sw_ddr_enable(cmdq, true);
> +
>   	return 0;
>   }
>   
> @@ -337,6 +357,8 @@ static int cmdq_remove(struct platform_device *pdev)
>   {
>   	struct cmdq *cmdq = platform_get_drvdata(pdev);
>   
> +	cmdq_sw_ddr_enable(cmdq, false);
> +
>   	clk_bulk_unprepare(cmdq->gce_num, cmdq->clocks);
>   	return 0;
>   }

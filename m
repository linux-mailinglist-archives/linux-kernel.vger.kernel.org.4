Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A43714C0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjE2O2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjE2O2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:28:01 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A10BE;
        Mon, 29 May 2023 07:27:58 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-64d5b4c400fso3839084b3a.1;
        Mon, 29 May 2023 07:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685370478; x=1687962478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Jmuun/VWT+neP2DA7RKfwQ89UBcOBnCQ2W3RabGpYlk=;
        b=sShWWNQl21iKyy6VI0j8on90ULIeyVnlk1w3zQwvz7MOJzRfMW5cp5G4uijrcrxEY0
         6C8sKU2Qfzpb3GFSngykxKOa8CLHryobEhZ4eZzXiRyC6Mi6eNG+Ax7UhTl/oFRANKgy
         epWdGu5xe1F27+rkJh6DJVBn/p25g2l+3p2r93rbc1YY4HC3W01v4hxU7WuxvqpT6LG4
         PUHfudkGsFaeQKBlCUt4NFIzNEyPMCdPcl4l23AZfQDQQxkj9r6jE+NS8HFqE6uxkeMt
         ZPUXaQTJOTsgiF+Cb4BrdFDtGUGzPcZHQEna70vWf3MG27npVY5Gzq4OaeMWBPR8Es1Y
         4oQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685370478; x=1687962478;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Jmuun/VWT+neP2DA7RKfwQ89UBcOBnCQ2W3RabGpYlk=;
        b=EAnLDJDdOvk2msZoaW3fyXjyh6zN6yFH99/0yjSJ03QMmcf9HqU55R86Wf8fdkblIy
         /j2JH+8XhfCT3r+08SF6M01yW0l8VneNQwLLQWe74UoQTJKT7v3cB3a7qWxSe00LJ7M+
         28ksJ9xzVZNpjQEtoPx4pSZdoEkqe7/tljdCyrG3VuWrW3xS0iQSoCJdcK5kH1sKgh3F
         DeklydW3bIGrU0GnqxAkO3AaBxKap7IlpZqzNd5uw/XEtN/P6LWBD2Qo1Kyf0/E/p4Em
         77eALimYg7TqdDUCQa5283i5EAhYs11TVymW+RrZoRomZ3Ic3E1fE663iTpaLCdcb6Pg
         wksw==
X-Gm-Message-State: AC+VfDxvdhZ9wPQP5Rf/f59lllHZnW34jwtnv44pPwht6HjmFHHZTmCB
        SZuL9B84DgyO2Wyulv/dN2gp04Sjymosyg==
X-Google-Smtp-Source: ACHHUZ4m+1SBfexp2uuaKCxUBhxnxFcc8rr2wUBHwXHwRK+R4InktUg565WydQIQVbv++T185v9wPw==
X-Received: by 2002:a05:6a00:228f:b0:63d:368b:76b4 with SMTP id f15-20020a056a00228f00b0063d368b76b4mr16718661pfe.17.1685370477720;
        Mon, 29 May 2023 07:27:57 -0700 (PDT)
Received: from [172.30.1.35] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id g10-20020aa7818a000000b0064f97ff4506sm36358pfi.68.2023.05.29.07.27.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 07:27:57 -0700 (PDT)
Message-ID: <eba06c01-e2bb-f715-8b2e-9c489e7c06d3@gmail.com>
Date:   Mon, 29 May 2023 23:27:51 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH5b51a54ae2fa1cc8459b68a28b3c8ca7b7203994] PM / devfreq:
 mtk-cci: Fix variable deferencing before NULL check
Content-Language: en-US
To:     Sukrut Bellary <sukrut.bellary@linux.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20230518084033.508711-1-sukrut.bellary@linux.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230518084033.508711-1-sukrut.bellary@linux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 5. 18. 17:40, Sukrut Bellary wrote:
> smatch warning:
> drivers/devfreq/mtk-cci-devfreq.c:135 mtk_ccifreq_target()
> warn: variable dereferenced before check 'drv' (see line 130)
> 
> This is based on static analysis only. Compilation tested.
> 
> Signed-off-by: Sukrut Bellary <sukrut.bellary@linux.com>
> ---
>  drivers/devfreq/mtk-cci-devfreq.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/mtk-cci-devfreq.c b/drivers/devfreq/mtk-cci-devfreq.c
> index e5458ada5197..6354622eda65 100644
> --- a/drivers/devfreq/mtk-cci-devfreq.c
> +++ b/drivers/devfreq/mtk-cci-devfreq.c
> @@ -127,7 +127,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
>  			      u32 flags)
>  {
>  	struct mtk_ccifreq_drv *drv = dev_get_drvdata(dev);
> -	struct clk *cci_pll = clk_get_parent(drv->cci_clk);
> +	struct clk *cci_pll;
>  	struct dev_pm_opp *opp;
>  	unsigned long opp_rate;
>  	int voltage, pre_voltage, inter_voltage, target_voltage, ret;
> @@ -139,6 +139,7 @@ static int mtk_ccifreq_target(struct device *dev, unsigned long *freq,
>  		return 0;
>  
>  	inter_voltage = drv->inter_voltage;
> +	cci_pll = clk_get_parent(drv->cci_clk);
>  
>  	opp_rate = *freq;
>  	opp = devfreq_recommended_opp(dev, &opp_rate, 1);

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


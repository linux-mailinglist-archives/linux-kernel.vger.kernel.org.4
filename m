Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF586B7450
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjCMKji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjCMKjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:39:35 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E226B46C;
        Mon, 13 Mar 2023 03:39:21 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id p6so6632357pga.0;
        Mon, 13 Mar 2023 03:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678703960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AdWZvDoiXOkhtz0FgU/G9RlHUgPqSYBL8Px+ljsJ/2U=;
        b=Rq7s5PVDQtf1N+47DPI5ClKgMAK1EO12UUd4nsy523dgBqVvu68AUfWHZz5+vgqAEi
         nF2zScYg1h11M8mj58jayRMOE3wB8+xXItGD7946FIgEXU4sc3erSQlm9do5AM8P4X+E
         XkFPKu+os8LURW4jVJickOL0/+drdlptmBre7qzfvDeRzYtI/Ny6Nr9/qvDSQDWzai9R
         fqyx+VCMcEAWEOpppGIQmHc2Il++g5mVIE2UWmNlGhsW8t+ClgaW+yB0aBDJjrqhHPRk
         QVU+UsvGIZl2oKYG3ZCzV+qdjx8hp8fpHl8JSq5rE8bkRE6m/FVimKHrvoiNXfERHRKM
         95mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678703960;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AdWZvDoiXOkhtz0FgU/G9RlHUgPqSYBL8Px+ljsJ/2U=;
        b=Ger7YGfb9/kEVqNSB5kkLGIjToMRBUiDWTFjDHnzFf8xJpB6Op6ZJPSWZi/dxAy6pG
         W7dNzeAa7B8nl1z/Uw8/V1lKsfEAXk6pU+oiVT7ZVJvyPPE9iO1QiL46QsLYitaWP97z
         WqemH2Jtezmlat+opz38QZExz2byE9kb3Jxo3EnXd2OmHwg9awh1g7BxGoLCMBKDB3g7
         vuQ7j2wCLI+BxischdzORMoI2r6H2lY7+sEBdA01L7pvsn9U7n6YhhdawdhwRUr/QB9u
         fq8YIedsPQnZKjkK25dAuSo23ZcvSkUQo7KpUQzBvKqG51BGeVRL2MOWZfDY5xEDid1A
         M0Ww==
X-Gm-Message-State: AO0yUKVX4Jeyzq40OsDyZX/OPy3VKK3fknriOM4DpgkIn18VX/ML1wjw
        d5X/W1khc55TzU5PJZAOi0g=
X-Google-Smtp-Source: AK7set9+XUJbjHbUYyEfT4VL/c1p9tIG+Ibui0wwEwmhtT685uC75sYqR6DOL3fWMVSwEsNnXc7ulA==
X-Received: by 2002:a05:6a00:15cf:b0:5a6:cbdc:2a1a with SMTP id o15-20020a056a0015cf00b005a6cbdc2a1amr11304087pfu.2.1678703960428;
        Mon, 13 Mar 2023 03:39:20 -0700 (PDT)
Received: from [172.30.1.89] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id i16-20020a63d450000000b00502f9fba637sm4276189pgj.68.2023.03.13.03.39.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 03:39:20 -0700 (PDT)
Message-ID: <770dde57-20b6-2877-53c6-b7ecf5980090@gmail.com>
Date:   Mon, 13 Mar 2023 19:39:14 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] PM / devfreq: exynos: Use of_property_present() for
 testing DT property presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230310144734.1546726-1-robh@kernel.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230310144734.1546726-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 10. 23:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/devfreq/exynos-bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
> index 027e8f336acc..d341876e7b62 100644
> --- a/drivers/devfreq/exynos-bus.c
> +++ b/drivers/devfreq/exynos-bus.c
> @@ -432,7 +432,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
>  		goto err;
>  
>  	/* Create child platform device for the interconnect provider */
> -	if (of_get_property(dev->of_node, "#interconnect-cells", NULL)) {
> +	if (of_property_present(dev->of_node, "#interconnect-cells")) {
>  		bus->icc_pdev = platform_device_register_data(
>  						dev, "exynos-generic-icc",
>  						PLATFORM_DEVID_AUTO, NULL, 0);

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


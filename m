Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBBC5EEF10
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235102AbiI2HbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbiI2HbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:31:15 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40935123871
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:31:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id i26so941610lfp.11
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=d2EazhJPJSbwMcP0nRzwyGojAz7jhGIxDxpFS+S8wS4=;
        b=du0lWC60PB/jENlb0ba14brLNTgO/3DRWot41R5k3uTVz+24nP0HL0BjGYCMm95mr5
         BNPOsJXPrBecasKO/4qlBapwV9Vk1MORFh/AI+5khaDupzZXiCRMLYlaPQmhPIs0fHC5
         61a0SgFNd1bo75he6Oc53j8W4ssb2A1Xoerac/pU59704OyLHhAtMVxwnAmXul6rBN7/
         dkDvQgvbCQvydmJigpKdMTvayu4WJ4qDzSy/jkoHCdjfNX7fCJ0lpySU5GjsxY1W5WRg
         gPyi7UY8h0W+7uV9sa6V8XnVoTYDEBTwTchp9qibd2MzuQY1/sTmJIvsj0wjrl7NExbu
         JHAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=d2EazhJPJSbwMcP0nRzwyGojAz7jhGIxDxpFS+S8wS4=;
        b=dPQ/JUnwBfq5MOvpA22IFemcdMYKcfoYc9rGVAI/WxmS6lSnJSpUjo8eUUJFQVyd/h
         LTTFPJ8AD7vQPO3+YzKhfH4R8eFY/fmA1xgVPX8fO/HAMyF++xWl7hEo6c9qIhpVMLRq
         KoMR1aiz0Zk8YWfrLIwB0uKssWQkCP9sUkfgHh0Qe0dp/OI+fSxSBTkud6DXMpWGkAGw
         CJ8OnxQZqvp1OTHBJIkTQyc1h53Ct/mipcygF/rsoOTnb3y1MmqRiWasHgRiJnphFXWH
         JyYK2WXV9pVjr2RQp75zIESjKtUhK/ipEDPWrhbOfaX5oipa/pAKYty7O2OL6Wn6a+eG
         qSzQ==
X-Gm-Message-State: ACrzQf2kbB25TH11gV2bsmFJcOgkX2TDjpDRjTxf7F1oXD4MSW7IR1lK
        JK2wtleZf7hnN2zu51NrFzoH7g==
X-Google-Smtp-Source: AMsMyM5CKgW4S6Mj6aaX7feZSKj0JYhQYbjagNlBJnXfen43EhgyNrhEeSF02sHPuLu5XZa8/PUkvQ==
X-Received: by 2002:a19:6b01:0:b0:499:b6fb:fcf2 with SMTP id d1-20020a196b01000000b00499b6fbfcf2mr753900lfa.622.1664436671624;
        Thu, 29 Sep 2022 00:31:11 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id d22-20020a196b16000000b00497ac35ae1esm702592lfa.85.2022.09.29.00.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:31:11 -0700 (PDT)
Message-ID: <1ddfd9c5-7986-3ff7-bcf8-409bc1250076@linaro.org>
Date:   Thu, 29 Sep 2022 09:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v7 09/29] thermal/drivers/exynos: Replace
 of_thermal_is_trip_valid() by thermal_zone_get_trip()
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        rui.zhang@intel.com, Raju Rangoju <rajur@chelsio.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Peter Kaestle <peter@piie.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund@ragnatech.se>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Keerthy <j-keerthy@ti.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Antoine Tenart <atenart@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Dmitry Osipenko <digetx@gmail.com>, netdev@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org
References: <20220928210059.891387-1-daniel.lezcano@linaro.org>
 <20220928210059.891387-10-daniel.lezcano@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928210059.891387-10-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 23:00, Daniel Lezcano wrote:
> The thermal_zone_get_trip() does the same check as
> of_thermal_is_trip_valid(). Replace the call to
> of_thermal_is_trip_valid() by thermal_zone_get_trip().
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

I think I acked it...

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


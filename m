Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7727373F5F1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 09:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjF0Hox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 03:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjF0Hot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 03:44:49 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D6010D5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:44:48 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f865f0e16cso5658432e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 00:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687851886; x=1690443886;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wFNM/13zo+D8MIGQZG1lJZIvVzqHNgB235Wb/AV3lUA=;
        b=K/YymU1Fw0XlFUpLmM/JsiHLwp6gglJu2CMqRj/MvPnLc7dAWpN6W2xm9QdXW23zZp
         EB/GIMb+FQD5HXV5uFtsqcfehGsDp50mJyMvPti+NlTe3jpVwhiMw/DL9pD3lBwH/38F
         VI7hRahj2se3hwB30hdrHGJl97u6LAhwODzX4Bh+TtDsM7yK2QfDPkEM34BCfupe1bE5
         CDgGRXGwvthPDiFaEmsp0zOTJsRR35s5RBS7lQRVYjDPWPfO1VPnfC4wOGKYltmqexFf
         LOEniz8brkiDyP6blhoVPWh5jdm96n58qKU7Y+wgsyalJRh3ilMhvKZnh1kURlyvlsH5
         6z4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687851886; x=1690443886;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wFNM/13zo+D8MIGQZG1lJZIvVzqHNgB235Wb/AV3lUA=;
        b=XVI2jRgtJHSYJ0ZTcq+VP7PpJWIa62hB3lLh/+tLYD/j9NBcrJj5lSBm7mcbEUjAaT
         opIn93b6ifveIhY27G49hEsu704jNgrTeEqLOLN//RO2qQqEwzQmzTd0OSHgGyiXLOtN
         NjJjow3byL95zQQCKxvBska5+hqrz+aDDuC4N+S0/G7lh6lR9Qo0F7N2I6VgmkT9Gfdh
         LMRQN2d8zjDsz+vxU92TxR595nrygWa5k6aT9FeMGXoc1ysMD6v6MxI+eMfIGAwvsqOb
         IeS0z8iwkcjnGKuxSAvW17iW0O2SLHdam99D4hvCfooJaVz9vnj+TmD/HOpEtpdFOwHD
         jk7g==
X-Gm-Message-State: AC+VfDzAec5JwuRxtO/R9Bacs6WaPm/yw7nb8803mx5ZfXTCHY1I7/lZ
        UXcj2WYiSV5fD+lcwxCsul5uVQ==
X-Google-Smtp-Source: ACHHUZ6A6FWPC46/BuRGtluWDc8BUdgJ8Rg4tYYbbS+0qBeQ5xLXdOL8H0TzB80PlKS/a86NhKNNZg==
X-Received: by 2002:a19:2d01:0:b0:4f8:7568:e948 with SMTP id k1-20020a192d01000000b004f87568e948mr13532699lfj.51.1687851886659;
        Tue, 27 Jun 2023 00:44:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c378b00b003fa95f328afsm5250918wmr.29.2023.06.27.00.44.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 00:44:46 -0700 (PDT)
Message-ID: <3213e578-1c48-e1bb-f181-d0845f915031@linaro.org>
Date:   Tue, 27 Jun 2023 09:44:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 13/15] thermal/drivers/rockchip: remove redundant msg
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Yangtao Li <frank.li@vivo.com>, miquel.raynal@bootlin.com,
        rafael@kernel.org, daniel.lezcano@linaro.org, amitk@kernel.org,
        rui.zhang@intel.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, thara.gopinath@gmail.com,
        heiko@sntech.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, tglx@linutronix.de, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        srinivas.pandruvada@linux.intel.com,
        DLG-Adam.Ward.opensource@dm.renesas.com, shangxiaojing@huawei.com,
        bchihi@baylibre.com, wenst@chromium.org,
        u.kleine-koenig@pengutronix.de, hayashi.kunihiko@socionext.com,
        niklas.soderlund+renesas@ragnatech.se, chi.minghao@zte.com.cn,
        johan+linaro@kernel.org, jernej.skrabec@gmail.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20230627071707.77659-1-frank.li@vivo.com>
 <20230627071707.77659-13-frank.li@vivo.com>
 <61f9a781-81fe-d553-6c85-eb069174e6f0@linaro.org>
In-Reply-To: <61f9a781-81fe-d553-6c85-eb069174e6f0@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2023 09:40, Krzysztof Kozlowski wrote:
> On 27/06/2023 09:17, Yangtao Li wrote:
>> The upper-layer devm_request_threaded_irq() function can directly
>> print error information.
> 
> I don't understand. "Can print"? It does not matter if it can, if it
> does not. Currently it doesn't, therefore change is not correct.
> Otherwise explain a bit better why this is redundant.

All your patches ended up in spam, so now I found your patch one.
Anyway, if this stays, please replace "can" with statement - "prints".

Best regards,
Krzysztof


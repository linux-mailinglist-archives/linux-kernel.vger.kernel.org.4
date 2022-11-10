Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0D01623D78
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 09:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbiKJI0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 03:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232977AbiKJI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 03:26:37 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F831F2FA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:26:35 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id s24so625930ljs.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 00:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMK33ZLPXtrCd1qS8Z1zIzR9A9wpNvCs34PNuAlIq9I=;
        b=J3Jf96X9YinMGN6kprvpY1QVKM/cQVd+6TbBSR710D9nrCKiWpDae8yq+FkOqvRltU
         eFNaeVRV8Jhqr4rGsIdYAsH4UqLnZIQsQJpHZ+R+HJnAejg6Jc+HzZ96/Smen8xAewFk
         as6h3weDL4NH4n2bxWxX9igdTlOO8420nilYuL0JvoOanUwX31QDHktK/4UiZK6p31iu
         konDH0lDf+LQNhsv2yMGqGBcGvqeCl2m5alP2SA6Q6fkq1cy9ehqpzdFsv6Das5C7Yml
         v0HTLLCxKyLSCCbPccF1cGTgSk9GoG+YDJOEphmEVAY4KOdZuKha3DXvVeSxwQ5OdFFQ
         A8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rMK33ZLPXtrCd1qS8Z1zIzR9A9wpNvCs34PNuAlIq9I=;
        b=ZNsprnECIiAq0aTcy3EBkr44kzOYUbCv9A8o63VOe4NV2hnYwtYlc2DfetMYEadvS2
         QTNSR1M35hV86kUASo1X3dLGmOPse8xhVRcthYLglUoYe4/Z+2pjLTRsGWmv+OhjAukt
         HKmj8n7DmkzUROKfhZjSq+Q+OaL7K6UofOork0D7/Hw03W3M2dEVy1x7Old5OQlWMA7w
         AFc4Rd0X/dtAmrqa7dJ7vO2qrEuYYWNqL4RSIEB+aCOzvRTd7dOf60m27Gxgwld6Ccii
         2xuCdpeN8oipbKeeoHAMXPyWZeNMR4gJ8y/k6E01qbJlokTwb9C7gKTLTtKmBsomWpCR
         kk/w==
X-Gm-Message-State: ACrzQf2VcPd1SDSIUzOFOYnXE9LhyYp8W3TOvfuDFSu1IwaKal9XcyJq
        7+IkBRxj6qEINQfqFtoHQHU3rQ==
X-Google-Smtp-Source: AMsMyM6Zi9zA8J8hiP/x4AOF3HfQ9cMmX90PzpzeqZgNPcM4B7qDonY4UVbrgI+sMOyqwhQvXJULJA==
X-Received: by 2002:a2e:3017:0:b0:277:81ff:c2c7 with SMTP id w23-20020a2e3017000000b0027781ffc2c7mr6759752ljw.23.1668068793644;
        Thu, 10 Nov 2022 00:26:33 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id b23-20020a2e8497000000b00267232d0652sm2552122ljh.46.2022.11.10.00.26.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 00:26:33 -0800 (PST)
Message-ID: <5ace99aa-41aa-c0d3-fbb5-a23bcf06f6f0@linaro.org>
Date:   Thu, 10 Nov 2022 09:26:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2] arm64: defconfig: Enable missing configs for
 mt8183-jacuzzi-juniper
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221109195012.1231059-1-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221109195012.1231059-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 20:50, Nícolas F. R. A. Prado wrote:
> Enable missing configs in the arm64 defconfig to get all devices probing
> on the mt8183-kukui-jacuzzi-juniper machine.
> 
> The devices enabled are: ATH10K SDIO wireless adapter, Elan touchscreen,
> cr50 TPM, MediaTek SPI controller, JPEG video decoder, ANX7625 DSI/DPI
> to DP bridge (used for the internal display), MT8183 sound cards, SCP
> co-processor, MediaTek Global Command Engine (controlled by CMDQ
> driver), MediaTek Smart Voltage Scaling (SVS) engine, CCI frequency
> and voltage scaling, AUXADC thermal sensors.
> 
> All symbols are enabled as modules with the exception of SPI, which is
> enabled as builtin since on some platforms like mt8195-cherry, the
> ChromeOS Embedded Controller is connected through SPI and it is
> responsible for the regulators powering the MMC controller used for the
> SD card, and thus SPI support is required for booting.
> 
> By enabling the support for all of this machine's devices on the
> defconfig we make it effortless to test the relevant hardware both by
> developers as well as CI systems like KernelCI.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


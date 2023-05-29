Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17946714E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:31:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjE2QbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjE2QbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:31:03 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7219DAB;
        Mon, 29 May 2023 09:31:02 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3f6a6b9c079so22869085e9.1;
        Mon, 29 May 2023 09:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685377861; x=1687969861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fl5UqcVglx/Zk4w3uBA6m2BcPMsFBjrRyQ7G0qcJSnw=;
        b=czU8EWyfqVVWum0f9XkGKu0jfiJKyRLWAWQTbnM9PgfeGqVvCD7Xx3pMDXFXcZOkL3
         fMbb+fve6pNR01Vg00VBv5ZdB5F54WDGgndSixL18EAfFd9wdotJ6Nohc2FhtDsv4T0w
         /hm8/erKDe/oDQzgeJ9lAEcsZrSvsY81H60DrUsdwH8EfWbep9f/RBjkxxmkifWOhxW/
         oC5+foF5Aaek7VmjZbihB1HMuSBqgoGlrxCapUDDp5kSyaZt/M0MbU87AP1yp2Bb266E
         Zd4lmkZWHYUb7/ZXmISXbeYtQBYf+QLJckDj1BcynPKtdDbj2Z9Me3w+k5TanXj2foqn
         NhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685377861; x=1687969861;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fl5UqcVglx/Zk4w3uBA6m2BcPMsFBjrRyQ7G0qcJSnw=;
        b=NqYMSk6KbAkW6BIzU1+7zf112tUqbrY1TthvBE2WwM1hMLPEL+//S7qjXtOZFoJBjg
         JyIQ0jN7rWFJSYuVcXzm9tIw1vS0oY1vwcOFawJn0I6nf3UbzZu4HYGjcAI/8p3B/oDu
         lAJUUu+riyKfItxoRPGcrQzpNrjtLZKGRSmUPBqzldsFELlYrDVT+CWJBAFSt3pKD8eK
         WhBke4fS77d2/Mdt9fnp4EXqaVZJ7JqEg6TOK1xZAIs3y2VTlDoTNAo6IkgOlKi4azT3
         8KqJnh+Hq4/r+MVFkZrqTkymOMYiJ21DrL0DEyn85oqso/uCuz5EzHKoUbIKmJAmuRIW
         4KrQ==
X-Gm-Message-State: AC+VfDxeh4OaUn14HZQkXXYhSkTf62/i65m2FmerTCENUS+5HSuIf53+
        jQBMxqoVxHbc2IhWY1mopfU=
X-Google-Smtp-Source: ACHHUZ68EkX8uWUYLnaeTCPg9KW76zCSKxPbjesOhvm3Uf4e0jK8An2oGQJJJQ2gVB6MRWG8RERtRA==
X-Received: by 2002:a1c:f704:0:b0:3f1:74bd:bc22 with SMTP id v4-20020a1cf704000000b003f174bdbc22mr8535282wmh.6.1685377860857;
        Mon, 29 May 2023 09:31:00 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x15-20020a1c7c0f000000b003f4266965fbsm18306579wmc.5.2023.05.29.09.30.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:30:59 -0700 (PDT)
Message-ID: <634c155d-6c04-00a3-2e5b-618c36ec706f@gmail.com>
Date:   Mon, 29 May 2023 18:30:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/5]
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzystof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pangutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        wenst@chromium.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com, nfraprado@collabora.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
References: <20230529153532.3541327-1-bero@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230529153532.3541327-1-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernhard,

Please resend with a subject line for the cover letter.

Regards,
Matthias

On 29/05/2023 17:35, Bernhard Rosenkränzer wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
> Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> and update the documentation that describes the Calibration Data Offsets.
> 
> Changelog:
>      v3 :
>          - Rebased :
>              base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
>          - Fix issues in v2 pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>:
>            Use filtered mode to make sure threshold interrupts are triggered,
>            protocol documentation, cosmetics
>          - I (bero@baylibre.com) will be taking care of this patchset
>            from now on, since Balsam has left BayLibre. Thanks for
>            getting it almost ready, Balsam!
> 
>      v2 :
>          - Based on top of thermal/linux-next :
>              base-commit: 7ac82227ee046f8234471de4c12a40b8c2d3ddcc
>          - Squash "add thermal zones and thermal nodes" and
>              "add temperature mitigation threshold" commits together to form
>              "arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones" commit.
>          - Add Suspend and Resume support to LVTS Driver.
>          - Update Calibration Data documentation.
>          - Fix calibration data offsets for mt8192
>              (Thanks to "Chen-Yu Tsai" and "Nícolas F. R. A. Prado").
>          https://lore.kernel.org/all/20230425133052.199767-1-bchihi@baylibre.com/
>          Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> 
>      v1 :
>          - The initial series "Add LVTS support for mt8192" :
>              "https://lore.kernel.org/all/20230307163413.143334-1-bchihi@baylibre.com/".
> 
> Balsam CHIHI (5):
>    dt-bindings: thermal: mediatek: Add LVTS thermal controller definition
>      for mt8192
>    thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
>    thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
>    arm64: dts: mediatek: mt8192: Add thermal nodes and thermal zones
>    thermal/drivers/mediatek/lvts_thermal: Update calibration data
>      documentation
> 
>   arch/arm64/boot/dts/mediatek/mt8192.dtsi      | 454 ++++++++++++++++++
>   drivers/thermal/mediatek/lvts_thermal.c       | 160 +++++-
>   .../thermal/mediatek,lvts-thermal.h           |  19 +
>   3 files changed, 631 insertions(+), 2 deletions(-)
> 
> base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e

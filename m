Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7DE69407B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbjBMJOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBMJOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:14:21 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D852B452
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:14:19 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id r18so8189213wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 01:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gvHDMUzeluufEeHph0ENumOann+/QiEfW8b/S7gPi+s=;
        b=DqxOfAQDiloqIH1ESZjz8i4hY8LwAwXX0Uj4PmkPJKImL9ngImlmoCt6yjADMW+J6w
         OPBkkP22o9JklNpmrh4Iumkr1YD2S7uBvXsnIPD/LITl8XEboQABQG3fOJ2pmXWs4Yzy
         MOF0lVY5f+5viifXXcXPCv+qdcwieOyCKTfqQi/r/S02KdGPPuVsedVHyiV7Xq8WCuj7
         +Db/eJ8AYJDZ00MFIOSHgLdQBxlM0//LMdPKFHxotBr+iC7zVBmR+uACznh50ZoOMl5j
         xkAvEvn7daCYW4nVODMgN09oP9eo2syMqOdQStqkV/0AM5vugIoaNm6AWkAEawxDRWHV
         aXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gvHDMUzeluufEeHph0ENumOann+/QiEfW8b/S7gPi+s=;
        b=P72verNvdBBIIcZTI9pwxsymGNGXK3XF5pxM4ZAcL0bIA0wuEnz1HPk2PyFEh/pY7l
         nAHIeuRzV+u7bLC3hVXZHmNe1SGCEC+eQFJu71kIUslD+VPj2yGmTk/m0CuOZdQCve0f
         movSAIOxizY/Syf/5kKfpqQjXtVmcsh1HS1gVCWx+MAKcHtUM+yZ8Hn4L3OdSCWDtSTr
         buK6Hqn8+4ygmCb7I0P72wiNKCsbx4JI2IOl8fFvVhjhViV4kNE1M3gbtNoxtQsQwHPO
         jDOoj8BCfJgNSFft9C6HWFVERMPpMUyH8nL8Tc+rMiMgbcKRUeYFnPunrqspT7U+Iha3
         zfHw==
X-Gm-Message-State: AO0yUKXTvZlH4DJ3WHLz9zIWqTet2MWj+ZbvsXWNSzi0TZ7fkHwRrUpy
        9GZU2ZA+xb0m/xhpyipn8tkk3w==
X-Google-Smtp-Source: AK7set9tgRo5lFAVpgHrCLNyV1ZeygrioZEaIMRiq+ujIM7Ea+or2IFx2u4OpkK9TZuPNQY9IXnHOA==
X-Received: by 2002:a05:600c:1898:b0:3e0:185:44af with SMTP id x24-20020a05600c189800b003e0018544afmr3825561wmp.20.1676279658073;
        Mon, 13 Feb 2023 01:14:18 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p3-20020adff203000000b002c3f6d7d5fesm10089446wro.44.2023.02.13.01.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 01:14:17 -0800 (PST)
Message-ID: <3578406e-a2ab-15a3-64fe-5873fc26477f@linaro.org>
Date:   Mon, 13 Feb 2023 10:14:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v5 02/12] dt-bindings: net: mediatek,net: add mt7981-eth
 binding
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        John Crispin <john@phrozen.org>, Felix Fietkau <nbd@nbd.name>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vladimir Oltean <olteanv@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     Jianhui Zhao <zhaojh329@gmail.com>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>
References: <cover.1676128246.git.daniel@makrotopia.org>
 <43d5e9cbf0e75ea2c039ffc632aa5cc5c83a3c33.1676128246.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <43d5e9cbf0e75ea2c039ffc632aa5cc5c83a3c33.1676128246.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 17:02, Daniel Golle wrote:
> Introduce DT bindings for the MT7981 SoC to mediatek,net.yaml.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Confusing diff but in general looks ok except:

> +
> +        mediatek,wed-pcie: true

This is now anything. I propose to cleanup the bindings first, before
adding new compatible.


Best regards,
Krzysztof


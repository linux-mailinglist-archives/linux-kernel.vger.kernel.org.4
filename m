Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0ED6071F6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbiJUITY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:19:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJUITS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:19:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC7A24AE27;
        Fri, 21 Oct 2022 01:19:12 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B8A38660252D;
        Fri, 21 Oct 2022 09:19:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666340350;
        bh=ZYx/Yzop9D7hc2wSOTEttiAxiuCQ7YU4rCEkjT3yODU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NnYwy9OltXtkN2rnajIF1cE5Y9s4R7U85GX8iWvq4m8gIQl0S2ezVgBlgdsL8gGdW
         8E/6wjGfB2RKZtExdgYrMbI+edoWnvOUH+v0zP5Yx8b+9r3E90LERx+tyzY+wcLuoh
         1TRM20fQoWQC0N5R7KZRM+RFJKmHa//z5zL37eVS2uLeaufj5WMWGVnp154J4zjQ9m
         +lYm4W+XjmeVU+mY+8QSePC3Ua0V4B+ocpDyDfKrzTiiCxL0j/U8/BuNjkI3a8aL+I
         U8ysZbdcMmfFRMP/pQoz054r6mZR6+X1VKeVob+7LVnQSJNL0e4+a2Sm8egXQ3G89F
         rMgbRUPHXZ31g==
Message-ID: <c34ccb61-8a8d-1d44-35f0-1433eceb3e9c@collabora.com>
Date:   Fri, 21 Oct 2022 10:19:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 06/10] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Add MT6795
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221007125904.55371-1-y.oudjana@protonmail.com>
 <20221007125904.55371-7-y.oudjana@protonmail.com>
 <0f078a85-056a-c11e-377b-27764a34485d@linaro.org>
 <8WU1KR.065JU8WYUX9C3@gmail.com>
 <2cfed688-f401-e69e-1ff4-f775c6d90f64@linaro.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <2cfed688-f401-e69e-1ff4-f775c6d90f64@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/10/22 14:21, Krzysztof Kozlowski ha scritto:
> On 20/10/2022 07:36, Yassine Oudjana wrote:
>>
>> On Mon, Oct 10 2022 at 07:24:59 -04:00:00, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>> On 07/10/2022 08:59, Yassine Oudjana wrote:
>>>>   From: Yassine Oudjana <y.oudjana@protonmail.com>
>>>>
>>>>   Combine MT6795 pin controller document into MT6779 one. In the
>>>>   process, replace the current interrupts property description with
>>>>   the one from the MT6795 document since it makes more sense. Also
>>>>   amend property descriptions and examples with more detailed
>>>>   information that was available in the MT6795 document, and replace
>>>>   the current pinmux node name patterns with ones from it since they
>>>>   are more common across mediatek pin controller bindings.
>>>>
>>>>   Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
>>>>   ---
>>>>    .../pinctrl/mediatek,mt6779-pinctrl.yaml      |  94 ++++++--
>>>>    .../pinctrl/mediatek,pinctrl-mt6795.yaml      | 227
>>>> ------------------
>>>>    2 files changed, 77 insertions(+), 244 deletions(-)
>>>>    delete mode 100644
>>>> Documentation/devicetree/bindings/pinctrl/mediatek,pinctrl-mt6795.yaml
>>>>
>>>>   diff --git
>>>> a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>>> b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>>>   index a2141eb0854e..cada3530dd0a 100644
>>>>   ---
>>>> a/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>>>   +++
>>>> b/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
>>>>   @@ -8,6 +8,7 @@ title: Mediatek MT6779 Pin Controller
>>>>
>>>>    maintainers:
>>>>      - Andy Teng <andy.teng@mediatek.com>
>>>>   +  - AngeloGioacchino Del Regno
>>>> <angelogioacchino.delregno@collabora.com>
>>>>      - Sean Wang <sean.wang@kernel.org>
>>>>
>>>>    description:
>>>>   @@ -18,6 +19,7 @@ properties:
>>>>      compatible:
>>>>        enum:
>>>>          - mediatek,mt6779-pinctrl
>>>>   +      - mediatek,mt6795-pinctrl
>>>>          - mediatek,mt6797-pinctrl
>>>>
>>>>      reg:
>>>>   @@ -43,9 +45,10 @@ properties:
>>>>      interrupt-controller: true
>>>>
>>>>      interrupts:
>>>>   -    maxItems: 1
>>>>   +    minItems: 1
>>>>   +    maxItems: 2
>>>>        description: |
>>>>   -      Specifies the summary IRQ.
>>>>   +      The interrupt outputs to sysirq.
>>>
>>> I am not sure if description is relevant now for all variants... what
>>> is
>>> the sysirq? You have two interrupts so both go to one sysirq?
>>
>> It's the system interrupt controller and it has several inputs. Both
>> interrupts go to it.
> 
> Then the naming is confusing because "sysirq" sounds like "system
> interrupt".
> 

Yassine: "Interrupt outputs to the system interrupt controller (sysirq)"

That will surely clear up the confusion... :-)

Cheers,
Angelo

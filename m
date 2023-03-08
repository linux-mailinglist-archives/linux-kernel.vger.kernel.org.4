Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A067D6B1379
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 22:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjCHVAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 16:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjCHVAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 16:00:19 -0500
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD5A80928;
        Wed,  8 Mar 2023 13:00:19 -0800 (PST)
Received: by mail-ot1-f54.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso9711787oti.8;
        Wed, 08 Mar 2023 13:00:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678309218;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ZdO8B4SE0hK6baO5Lz8pAHYpW240oNtgnEAr4GbZks=;
        b=qluHPesACLVoZJL9jpEzqkHw38CHYqRLD0lhlndCcGLmpUbkNmwUNZ1aHZ7Wx61rPh
         JvuOkxAzp8psfG7heB7ZrWGOgIUouZMA5FK9vMY1s8Wm2akgiFRNRZUO454R/hgZTPSw
         JNUwF2N9GTSnNUpNvK0fN5oTahv2ON86Qo57cXtTpTZTxp+FCFxrEtcwN/io3xB1pmyG
         xVjPpCzcxsf5CxjV455ZylaCfQ9ZcWItN6h0nVskJNK7RxpgVcbI7JbSjCDRrCvu1FwX
         h0IagmHQ0fhkJUGIMM3tdP7VypP5SMbpbDznXooLlVNqkeAJkETn0JYLLaOrvRQCCAfP
         DQrQ==
X-Gm-Message-State: AO0yUKVQMaB7A5ByJYwhjSvKCf7S/vHHwofG2V/po6W843BzTZhph54c
        dCWz3RTSBvVfIamdMlbZKM6sXOnHvg==
X-Google-Smtp-Source: AK7set+tW7tYKfBIsVQdLPPlbctu7CwHbL8aGPyNilvWijRtLffT6epCXw3arwIWAtYdIAEiSgtH4w==
X-Received: by 2002:a9d:715e:0:b0:68b:dfcc:bed with SMTP id y30-20020a9d715e000000b0068bdfcc0bedmr9758516otj.15.1678309218403;
        Wed, 08 Mar 2023 13:00:18 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f9-20020a9d5f09000000b0068bce0cd4e1sm6804531oti.9.2023.03.08.13.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 13:00:18 -0800 (PST)
Received: (nullmailer pid 3767368 invoked by uid 1000);
        Wed, 08 Mar 2023 21:00:17 -0000
Date:   Wed, 8 Mar 2023 15:00:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        William Dean <williamsukatube@gmail.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, erkin.bozoglu@xeront.com
Subject: Re: [PATCH 08/20] dt-bindings: pinctrl: ralink: add new compatible
 strings
Message-ID: <20230308210017.GA3744272-robh@kernel.org>
References: <20230303002850.51858-1-arinc.unal@arinc9.com>
 <20230303002850.51858-9-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230303002850.51858-9-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 03:28:37AM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add the new mediatek compatible strings. Change the compatible string on
> the examples with the mediatek compatible strings.
> 
> Add the new compatible strings for mt7620, mt76x8, and rt305x to be able to
> properly document the pin muxing information of each SoC, or SoCs that use
> the same pinmux data.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
>  .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 6 ++++--
>  .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 5 ++++-
>  3 files changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> index cde6de77e228..a94d2e7a5f37 100644
> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> @@ -17,7 +17,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: ralink,mt7620-pinctrl
> +    enum:
> +      - mediatek,mt7620-pinctrl
> +      - mediatek,mt76x8-pinctrl
> +      - ralink,mt7620-pinctrl

To repeat the options from last time:

>Carrying both strings is a NAK. Either you (and everyone using
>these platforms) care about the ABI and are stuck with the "wrong"
>string. In the end, they are just unique identifiers. Or you don't care
>and break the ABI and rename everything. If you do that, do just that 
>in your patches and make it crystal clear in the commit msg that is 
>your intention and why that is okay.

Marketing/acquistion renames was just an example and common reason. That 
doesn't make other reasons okay. I don't see any reason given here.

If you want to break the ABI (do you??, because the commit message 
still doesn't say), then you don't need "ralink,mt7620-pinctrl".

Rob

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A0B6A4816
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 18:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjB0Rd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 12:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjB0Rd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 12:33:56 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A0C510E3;
        Mon, 27 Feb 2023 09:33:37 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1729bdcca99so8111540fac.12;
        Mon, 27 Feb 2023 09:33:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oN8FxBckZtmYaMSZo87sPI384Nrsl3rmx9eLsbfMrE=;
        b=UfZfQSWmOJp6iLuXrUWUxCazXW0zXROs+OOdDhDQ5dFHrhCGeneptVi1CNglD+7OLZ
         c5S276vktWy/x4JMKzVJWiBLeUqan5dwztA3wF2adJFq6q6AVbYLI1i+GNtptdMgaels
         NdEJswK/3WCm78XcmRt8SAMheqPj79TYwxjBWEieEB8IzEPrAE3JMur3aNRsHCxRv/3D
         2f2nep+6/gSrMGs47TC2iTJ8HjVa4NCwMME7ooDJ3GE5C0ySIAj0FgYO36U85pvAi3jg
         g45gnR6GtMYqYxVCgr2vHk5Ze61lOY21szDX6Mw+qGTBX1ATFK27Lyq+Ft/jyGq+M+h7
         UCvA==
X-Gm-Message-State: AO0yUKWrluBPS14ECP4Yj6VhQKOhyIqhh8ctFA82VnxPUXvzZzWUvLg8
        yNFRuxuSi5+BaERj+tRKpQ==
X-Google-Smtp-Source: AK7set9iB+Y2H2YVIxACw0NlHiSHBMwnkJWQVinPxVxj6RyNikXsn6AAahpz+oWM/OgaYUHPeqIz/w==
X-Received: by 2002:a05:6870:5387:b0:15b:8856:f0cb with SMTP id h7-20020a056870538700b0015b8856f0cbmr20100932oan.57.1677519214294;
        Mon, 27 Feb 2023 09:33:34 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w18-20020a4aded2000000b00525270c233asm2828098oou.39.2023.02.27.09.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 09:33:33 -0800 (PST)
Received: (nullmailer pid 504389 invoked by uid 1000);
        Mon, 27 Feb 2023 17:33:33 -0000
Date:   Mon, 27 Feb 2023 11:33:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     arinc9.unal@gmail.com
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
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
Subject: Re: [RFC PATCH 07/16] dt-bindings: pinctrl: ralink: add new
 compatible strings
Message-ID: <20230227173333.GA496999-robh@kernel.org>
References: <20230222183932.33267-1-arinc.unal@arinc9.com>
 <20230222183932.33267-8-arinc.unal@arinc9.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230222183932.33267-8-arinc.unal@arinc9.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:39:23PM +0300, arinc9.unal@gmail.com wrote:
> From: Arınç ÜNAL <arinc.unal@arinc9.com>
> 
> Add the ralink,rt2880-pinmux compatible string. It had been removed from
> the driver which broke the ABI.
> 
> Add the mediatek compatible strings. Change the compatible string on the
> examples with the mediatek compatible strings.
> 
> Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
> ---
>  .../devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml | 7 +++++--
>  .../devicetree/bindings/pinctrl/ralink,mt7621-pinctrl.yaml | 7 +++++--
>  .../devicetree/bindings/pinctrl/ralink,rt2880-pinctrl.yaml | 7 +++++--
>  .../devicetree/bindings/pinctrl/ralink,rt305x-pinctrl.yaml | 7 +++++--
>  .../devicetree/bindings/pinctrl/ralink,rt3883-pinctrl.yaml | 7 +++++--
>  5 files changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> index 1e63ea34146a..531b5f616c3d 100644
> --- a/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/ralink,mt7620-pinctrl.yaml
> @@ -17,7 +17,10 @@ description:
>  
>  properties:
>    compatible:
> -    const: ralink,mt7620-pinctrl
> +    enum:
> +      - mediatek,mt7620-pinctrl
> +      - ralink,mt7620-pinctrl

We don't update compatible strings based on acquistions nor marketing 
whims. If you want to use 'mediatek' for new things, then fine.

Rob

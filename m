Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5EC60EA1D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 22:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbiJZURF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 16:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235166AbiJZURD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 16:17:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C817510C4DC;
        Wed, 26 Oct 2022 13:17:01 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ud5so21048132ejc.4;
        Wed, 26 Oct 2022 13:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZJ8nTWipM2h43z45/cmbXzTIVENawNHsahNhS9RcpVE=;
        b=Kxqstm7VQ9wJy7Ij2ipPmH5DZw1MvmdzzW9yPfk91cw2h4QdjBThnTPeMOzrAy7vUt
         fIQwhFtefVZHjmFrYkHiSQj7GVwA4MmCgt/kL/K2koy/z97sLiocW9pv49IL56xXhslK
         kzeRNugZhIHgDhF0MB0lfKw1Bv0S8654fVbc505y+FjRWS8b13OYNSsRTZ9uv/gaT3D2
         KRYrvgtjZlx8VHvuQsAxWFftkpXNgd8+TArKt5ZWGNam2vCZM5U7Fb0bymsxwgbfPHFr
         hzkEIt4jof0kgWZy4kGAYkp6u7fVizqSSl5furJGZbzgv7eJdYCLAIOxlPI5+D/YT/Dl
         btRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZJ8nTWipM2h43z45/cmbXzTIVENawNHsahNhS9RcpVE=;
        b=iXzy5gp76HhoBOI7aImVW+Pv7d+H11jWCGvclk3j/m7bIZ/rfIsE6143Mc7b60kh8j
         0oKs0iodB2Q3NVh30xm5qDCPV/fXpDV+u7bVPPvOtE6CKmVJGS0Q9VRV8QbBy4P+TNvr
         oEpc2pgRdXz9CIucgZlROSQmwvvxY7LfgpdzKTVWdk6mJSS9DfcunR2ab0I4QPgXlNzG
         jT0eNUgtzIica9yDWv9qa/OKkX/ly2kKDMOUBnsNzTULt7Lg2VQgoW4Kmn/davPENdKO
         hXOwhX62G4xqsavP2yk8kFvPIQyrE20a0OM9gqDjxFq2TkQw8c7Fvp4uzLZiSiiD216J
         rQcg==
X-Gm-Message-State: ACrzQf3XarfENupgaBVJd0hWzQ+yFSRDCCv09ZTzfea1vMvAhRo189TX
        8zjzgawzOwAqgDi9jWw0dB8QBTurRl0=
X-Google-Smtp-Source: AMsMyM5NohsjVMEM5se+lXt/+p7Lnxf45BGjphkLILdcCuAYQ4mJbYM2qqJrIcdYTHRO9Be0F2zNhA==
X-Received: by 2002:a17:906:478d:b0:7a3:cf5e:9027 with SMTP id cw13-20020a170906478d00b007a3cf5e9027mr19336206ejc.718.1666815420388;
        Wed, 26 Oct 2022 13:17:00 -0700 (PDT)
Received: from kista.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b007aacfce2a91sm3517868ejb.27.2022.10.26.13.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:16:59 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v3 0/2] AXP221/AXP223/AXP809 GPIO support
Date:   Wed, 26 Oct 2022 22:16:58 +0200
Message-ID: <5870583.lOV4Wx5bFT@kista>
In-Reply-To: <20220916042751.47906-1-samuel@sholland.org>
References: <20220916042751.47906-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 16. september 2022 ob 06:27:49 CEST je Samuel Holland napisal(a):
> This series hooks up the GPIO controller found in some older X-Powers
> PMICs. The main motivation is converting the U-Boot driver over to use
> devicetree, but Linux might as well gain support for the hardware too.
> 
> Changes in v3:
>  - Added patch to remove existing "ldo" pinctrl nodes
>  - Drop already-merged binding and driver patches
>  - Remove "ldo" pinctrl children from new nodes
> 
> Samuel Holland (2):
>   ARM: dts: axp803/axp81x: Drop GPIO LDO pinctrl nodes
>   ARM: dts: axp22x/axp809: Add GPIO controller nodes

Merged both, thanks!

Best regards,
Jernej

> 
>  arch/arm/boot/dts/axp22x.dtsi             |  6 ++++++
>  arch/arm/boot/dts/axp809.dtsi             |  7 +++++++
>  arch/arm/boot/dts/axp81x.dtsi             | 14 --------------
>  arch/arm64/boot/dts/allwinner/axp803.dtsi | 10 ----------
>  4 files changed, 13 insertions(+), 24 deletions(-)
> 
> --
> 2.35.1



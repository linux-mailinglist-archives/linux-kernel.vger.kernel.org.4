Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD4C86237CA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 00:55:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKIXzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 18:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbiKIXze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 18:55:34 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26089240BC;
        Wed,  9 Nov 2022 15:55:33 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so123747wmi.3;
        Wed, 09 Nov 2022 15:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j51pcpmAt7rygikiVDfge95qbdKBtRf/PjFzkYZrMnc=;
        b=Wd6ppp30utQntCUqz+qW2cMWBmwMs+rr95pprrQ4BHDRQxjd30vD6E/xLK0J4s5ygs
         XFdDT1RYyNMEv8ooKTwg21fWqx4yPRayjTX94hEsCfgP+jITqGcRlT5SkL5BNMlzhTL4
         KN621bpyhvV2Z759F5e+QYGQ6fKGmRLziziwM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j51pcpmAt7rygikiVDfge95qbdKBtRf/PjFzkYZrMnc=;
        b=aoXBj2Pq1XDSzXZ05GJlR9ntZQehNYkGGh83phvkPDp2w0Ycn6s1iWlwo6y6e49z7j
         WxKtaYjXsWH4tZFMrgWno3O5rID13+oXmASevw4Spci9ntlT3Fu1SunjnXhkfP+TzfYC
         4mQ3bH8MzQT/DiIB1wghr17+rzl/4TWdjYQP/zBAK9ycHIW//Vs3zNLMag7Ou8GBz/uv
         pIz0qy8JEHRB9vBJnCVId/GkxxfKqFrA4uKDbG9AmWdbUkh2TRKBgFmBJ8vFP4s6fy70
         OxQKD7ftVr07EUZOJwKhlFZOwEWkwUNpHQQKzKYI41vZ38r3xVNgPzLXuZdmrwO4EhTi
         2HIQ==
X-Gm-Message-State: ACrzQf1IxM+Ebi6O6UIuUgb3D6VxAGtc78zHciokuuCi8saaLNql9xON
        2/QsBKjIRQgmHw63mvNUEnBwPMA5Qbpeu7SffXIti8kA
X-Google-Smtp-Source: AMsMyM633cR3aqFZIJs92t3FJDeCnj/48LR9q/mCiFCWUWAAUvWB71S7IrPEET1nrwzBbJA7zpjBPNFK4ve3y4WY6Cg=
X-Received: by 2002:a05:600c:a46:b0:3b9:9b97:9304 with SMTP id
 c6-20020a05600c0a4600b003b99b979304mr41506443wmq.34.1668038131488; Wed, 09
 Nov 2022 15:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20221108001551.18175-1-zev@bewilderbeest.net>
In-Reply-To: <20221108001551.18175-1-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 9 Nov 2022 23:55:19 +0000
Message-ID: <CACPK8XeKA+rFwOGCZam2XZh9v8OndyZeE2sk4-3nb-rKdNeDBA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] ARM: dts: aspeed: Add Delta AHE-50DC BMC
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, soc@kernel.org,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Nov 2022 at 00:16, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> Hello,
>
> This series adds a device-tree for the BMCs of the Delta AHE-50DC
> Open19 power shelf.  The first patch adds a compat entry to the Aspeed
> bindings; the second adds the device-tree itself.
>
> Changes since v1 [0]:
>  - rearranged patch 2 with macros to reduce boilerplate
>  - added ack from Krzysztof on patch 1

Looks good to me, I've put it in the aspeed tree for 6.2.

>
> Thanks,
> Zev
>
> [0] https://lore.kernel.org/lkml/20221105013321.2719-1-zev@bewilderbeest.net/T/
>
> Zev Weiss (2):
>   dt-bindings: arm: aspeed: document Delta AHE-50DC BMC
>   ARM: dts: aspeed: Add Delta AHE-50DC BMC
>
>  .../bindings/arm/aspeed/aspeed.yaml           |   1 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts | 418 ++++++++++++++++++
>  3 files changed, 420 insertions(+)
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-delta-ahe50dc.dts
>
> --
> 2.38.1
>

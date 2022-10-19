Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E51F0603862
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 05:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJSDGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 23:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbiJSDGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 23:06:35 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D43D91847;
        Tue, 18 Oct 2022 20:06:21 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id i65so13456392ioa.0;
        Tue, 18 Oct 2022 20:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gLpWoxnIs3QCcCwsEK0w8ik4TxF86lHHTsF7ICCHXbE=;
        b=N8y4Z/VgLeF6P+ZBFR91IK1W853NSfFaYWVhs2AGD7DhGfnyBw3lIsMgo58S/kdo6I
         5dbQmkJJwnkl1bGbhDEbdrgaQfbRymsZMNyaqo9obJecteJEEMI5wH0xvGCNNsWi80X9
         LXTTCwZJvcrhQASnXpzXzu24z7bh4KekWHcwwHexIVC19tZ5TxXiZwuzz7xxR+XUAPgv
         6e9kwrGTqoYIGzAdYaQSL3LRMnZGZ4n7o2ohSVpnkjfqoW+Q+RuniAIe5OsBFYgpTn3I
         xv4PH4M0g0eC2xEsSUx4LDbGSggxetIgP6wCWBzvlax4Yug3u12OKjNnj6PUEuNNeMlK
         Ucjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gLpWoxnIs3QCcCwsEK0w8ik4TxF86lHHTsF7ICCHXbE=;
        b=Jdc/TjUwr3Z6NgyzYXirVS72uJiapXTo1D9g4fbxVsQqCniAV4LdnnzxMgUWeOHyl8
         bzlDWVFXA+Ee8mw523OgcF4dRE1ILE9Wb691QhL0CtP3xLlO7IOH88ccIiu5430TzTfG
         xV2hPKdphWzBFwdEOao7qDKlCyjS8mko3lc80MfKzH48UZrxejxIL2k3RzcyFlUld70z
         78gbOVOKQWgz9sFOmvnCCxNoSXs90zYowISQ4+9vUja6Zf9czZ8AS3kR2yTsNvYGNqsq
         vhy4N2Mz/4YT2/KfGy5sdHobleeTF+/X3Ic0gSvZRF6oTpgTUlOV3Qf9/39gfi1Vz2UA
         EQ9A==
X-Gm-Message-State: ACrzQf2L31WzIOUF8VYu2dsP/gg5UOblo+8cZHxbqpHoW80hWtl6XgEM
        Z/Tt5X4fTxogw4jS6SWabeE0nw/HV8YWag1+GoQ=
X-Google-Smtp-Source: AMsMyM68IQyMUNC/lASqb+n7vZcxhpU/sQZ8jKo/UDQU9/0P+t9fqHelhgsQ/xEmNLEB9mJEIBmYNu5bnFPYyvApEIs=
X-Received: by 2002:a02:cc90:0:b0:363:c1c2:e957 with SMTP id
 s16-20020a02cc90000000b00363c1c2e957mr4314251jap.277.1666148779932; Tue, 18
 Oct 2022 20:06:19 -0700 (PDT)
MIME-Version: 1.0
References: <20221018195122.8877-1-linux.amoon@gmail.com> <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
In-Reply-To: <CAFBinCCqXBk9Xq0k=NA3zGi8spwyPQN7dMVWcjE+pXkXYf+FKQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Wed, 19 Oct 2022 08:36:04 +0530
Message-ID: <CANAwSgSR6jHRQR6QgzUop_B4gcOsQnfc6LoUXrP0CSTasZkVfQ@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: meson: Enable active coling using gpio-fan on
 Odroid N2/N2+
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On Wed, 19 Oct 2022 at 02:46, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hello Anand,
>
> On Tue, Oct 18, 2022 at 9:53 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Odroid N2/N2+ support active cooling via gpio-fan controller.
> > Add fan controls and tip point for cpu and ddr thermal sensor
> > on this boards.
> In the schematics for board rev 0.6 [0] I cannot find any information
> about a fan connector.
> The schematics for board rev 0.3 [1] on the other hand document a PWM
> based fan connector on page 16.
> So now I am not sure whether your patch only applies to certain board
> revisions, the schematics are incorrect, etc.
>
> Can you please provide some details about the fan connector on
> Odroid-N2/N2+ and which hardware revisions are supported (and which
> aren't) by your patch?
>
>
Ok I got this wrong the schematics below there is pwm controller, not
gpio controller
GPIOAO.BIT10 (PWM)
I will correct the patch sorry for the mistake I did not look more carefully.

> Thank you!
> Martin
>
>
> [0] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.6_20210121.pdf
> [1] https://dn.odroid.com/S922X/ODROID-N2/Schematic/odroid-n2_rev0.3_20190117.pdf
Thanks
-Anand

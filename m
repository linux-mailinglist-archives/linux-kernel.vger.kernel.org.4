Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E91365ABD9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 22:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjAAV6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 16:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjAAV6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 16:58:12 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD82272E
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 13:58:10 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id y18-20020a0568301d9200b0067082cd4679so16435110oti.4
        for <linux-kernel@vger.kernel.org>; Sun, 01 Jan 2023 13:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=itENd4bv7sUz5J3kCLw+9gAbPG9mWjjKo0129xbt1AQ=;
        b=fb3LXnCyZ/kIWmb8tqNRWca8LIYBDCd5S3QU9qS017ZBuOHwJAjp+7E2RHKrwghQXA
         F89bQEWQvafxF0QTsYtfvmnT9B9ObbMuXSZLZ0Z4iu25Wi4QZ9pm31JRiQb1DGxqM8kg
         bKaa/o1DTP9MJKqpZI3nwwYjJLm3JLVzu1pgpf+AkBkWfuGJ2W6iKguyxa1s7VtCEuuX
         xrVeEaiCOnUiewnJ/MAySvKL/TNapMzc1RnofDNBVdu+OSqhQf5wHlzjOyNX+S1tMnnR
         GwHW7xQnDN6N6yg8yH6mUKhHkQDQyTf9KgtT9ISuGGkQ2ysnrKYx6sSPM2Ba/RG4ipgc
         l57A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itENd4bv7sUz5J3kCLw+9gAbPG9mWjjKo0129xbt1AQ=;
        b=46g4l8pd0Wdzuvy1+cpmadOkL/CrugIu2ByM7uiAYa0/DjWaFtBgs0LGPCXrlFMUbK
         BfnOONh1Oc9F9fBJ9dszLxe7jBGdU4jDsjShIgnIEy83GOcWHPMF9/5ZCZsYwenbhpRu
         Aw2L0nubdHBjMEbmo4S5Uqc6DPz6Cb2eU8SesrqTSuxjoG63IH6zjXRzPqo8VGlX1Za0
         ohmNlnpM2+N01rc8MbYURDD3nvUME2s9azsHRqrkFB87xMZhLXirzful2Jt5AF/VIRX5
         xI1zggSYxbhVYVjrxX97SQPwW8j+I6WTsF6kZjmBv/NxdKX1ieORA79QV678vKs7Rpkz
         iwmQ==
X-Gm-Message-State: AFqh2kp8L4ujx6gznSw5XZVBguXJ6dFBcpUnOM2RhdO19Da/CrSa4Uae
        o4AouESvh6/yRFUxFN4LidFdvAJ9/7Y7EO1fHU9yuQ==
X-Google-Smtp-Source: AMrXdXvYUSzWN57SlzCh3DW6LHX/uMQkh78bq7FU+RCyZ2XJRZPNKpSvrWCsru+LAl/TArGUqJFdjZTYm0mHsKAx6SI=
X-Received: by 2002:a05:6830:1dac:b0:670:99fe:2dc5 with SMTP id
 z12-20020a0568301dac00b0067099fe2dc5mr1566669oti.137.1672610289731; Sun, 01
 Jan 2023 13:58:09 -0800 (PST)
MIME-Version: 1.0
References: <20221230203541.146807-1-bero@baylibre.com> <20221230203541.146807-8-bero@baylibre.com>
 <87v8lsect3.wl-maz@kernel.org>
In-Reply-To: <87v8lsect3.wl-maz@kernel.org>
From:   =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Date:   Sun, 1 Jan 2023 22:57:58 +0100
Message-ID: <CAP2ifjMkKJbE_+B=XaxzXoALrc5+FUb7TKpPJQBLV3-3xqVh=g@mail.gmail.com>
Subject: Re: [PATCH v6 7/7] arm64: dts: mediatek: Initial mt8365-evk support
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        chunfeng.yun@mediatek.com, linus.walleij@linaro.org,
        lee@kernel.org, tglx@linutronix.de,
        angelogioacchino.delregno@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 30, 2022 at 11:41 PM Marc Zyngier <maz@kernel.org> wrote:
> > +             gic: interrupt-controller@c000000 {
> > +                     compatible = "arm,gic-v3";
> > +                     #interrupt-cells = <4>;
>
> Why 4 cells? All the SPIs routed via sysirq are perfectly happy with 3
> cells, and all the PPIs have 0 for the 4th cell (none of them use any
> form of partitioning that'd require 4 cells). So where is this coming
> from?

It's coming from the SoC vendor kernel (and went unnoticed because it
happens to work).
Will send an updated version that does the right thing instead. I've
been running it most of the day, so far looking good.

> > +                     interrupt-parent = <&gic>;
> > +                     interrupt-controller;
> > +                     reg = <0 0x0c000000 0 0x80000>, <0 0x0c080000 0 0x80000>;
> > +
>
> The first region is obviously wrong (512kB for the distributor?
> that's... most generous, but the architecture states that it is 64kB,
> and that's wasteful enough).
>
> This is also missing the GICC/GICH/GICV regions that Cortex-A53
> implements, and that must be provided as per the binding.

This was also taken from the vendor kernel; unfortunately neiter the
datasheet for the SoC not the vendor kernel specifies the addresses
for GICC/GICH/GICV.
I've "guessed" based on what's in similar SoCs (MT8183, MT7986a) in
v7; this seems to work (boots, kvm initializes hyp mode properly).

ttyl
bero

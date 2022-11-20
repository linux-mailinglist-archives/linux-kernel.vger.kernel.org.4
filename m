Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7266314B0
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 15:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiKTOjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 09:39:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKTOjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 09:39:05 -0500
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16D69F588
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:39:03 -0800 (PST)
Received: by mail-ot1-x332.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so5959778otl.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 06:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UkF984r0jfTzyI7tT6A37vG6Dq6NrZDLkNTSQzJ1szs=;
        b=FkknNl8+w+PHZAEsszcaj6TK9kPpmxhf8hqcerwxC5O1stx9ns4RZ/+42f5YcrjFSO
         b32/pr9TNcXXKesgg09UNuGx/jmd/g+11KmGXLwieKzKJHeF800iLkUuBcU0dJJRkNjy
         gPBTauQfrp90FjVVT6H5FFR8u+s6b9eRHJfS3Wt6IXY5SI3nhq3vntva8f/TCjn2WjT6
         preWJI5H9/6wxtXb25uUg6Q48J6/ze3hhMgSJusetrcOTg3BvSU6Bhwqe/HNCatc3jWv
         BKrIwhku5hdXbu/LsFyaPxR9lIXF5sDPAgyvW4Y0v0QBU8AAxZH4P0RFo0ymCPOY0Tq+
         umiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UkF984r0jfTzyI7tT6A37vG6Dq6NrZDLkNTSQzJ1szs=;
        b=QdNt49T4k8nObbwy4PuugU0Hlz4o2xDcHynIxI/fyW8F+Nb9yIM1Dd3gVL+QaX9tf8
         ijT+U3HRx0B11FxmXWF7QgflgPWQn8J1L2uc/90Yu4TI1jepGXi4duYDLWXOCQ/WlnLy
         9T6+4Ous4S1dAVxshwBLEInQr/jNsRZq/3Iy8TqhUgRJM0Col6HJlZcOZ5mqoyLDxdB4
         vXKHRg/UhQeoyNYb/1vQlFZhEC7Mf9XGiVeT7taPr4fT83WGsE24s5f9kKJGKXJQVRoY
         yGq7lWdms0WVFg9tn5aaH5rLK+BmgP3QJ6/pBrZCHa/ZkpNiCGXdJjfSp7YBIuHvpQL7
         vk0w==
X-Gm-Message-State: ANoB5pkfduiuRP3wRS3POZtTKmj4H2i+aB7XFT2WKj4PY0IQfq7yBfkW
        /YLeVHYfqHHaP3g9xROzkSKzRAj5HHUF+FXB4zv0pw==
X-Google-Smtp-Source: AA0mqf5QbUJkXVIDNzWd1p6fxDx5nruCaRzVAH4gg+pHDxWzbCNuyfH+tzGeQnV8UhP7ITbVDOo+859w3u2Hq+bHCA0=
X-Received: by 2002:a9d:6c4f:0:b0:66d:2671:da35 with SMTP id
 g15-20020a9d6c4f000000b0066d2671da35mr7528322otq.137.1668955142399; Sun, 20
 Nov 2022 06:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20221117210356.3178578-1-bero@baylibre.com> <20221117210356.3178578-5-bero@baylibre.com>
 <06e916b7-f8f2-6de5-f86e-7b020c052451@linaro.org> <7ha64o9h1d.fsf@baylibre.com>
 <76cae9bf-c81a-684a-c22b-9548dd82c8d4@linaro.org>
In-Reply-To: <76cae9bf-c81a-684a-c22b-9548dd82c8d4@linaro.org>
From:   =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Date:   Sun, 20 Nov 2022 15:38:51 +0100
Message-ID: <CAP2ifjMQAx23xc0p_LZ9Dj79Hx1cyLZ-tx8HrGUbtDR-SmdECw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, Nov 20, 2022 at 11:40 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
> >>> +  pins-are-numbered:
> >
> > Yeah, having this as a flag kind of implies that this could be present
> > for some boards but not others.  But in practice, the driver requires it
> > to be present or just fails[1].  What's the right way to describe that?
> > We're just trying to add a binding that reflects the existing driver.
>
> Uh, what an interesting property. What's the point of it then? Why
> failing to probe on a missing property which does nothing else?

I couldn't find any other use of it in the kernel, and also checked
u-boot (where the property also appears in some devicetree files, but
isn't used anywhere).
Both the MTK and STM drivers use it just to refuse it if it isn't there.

Unfortunately "git blame" only shows pins-are-numbered being added as
part of a larger commit ("add the driver"), so there's no "add check
for pins-are-numbered because xyz" commit message.

I can think of 3 possible explanations, but none of them are good:
1. It's something that had a purpose at some point, but doesn't
anymore (but that would likely leave some trace in "git blame"...)
2. It's something that was added in preparation for another patch (but
I can't find any queued/suggested patches that make use of it)
3. It's for the sake of userland -- check if pins-are-numbered is set
(which will be true for MTK and STM because these drivers enforce it,
false for anything else because the schemas don't mention it) and then
do different things. But this seems unlikely as well, the usual
suspects (libgpiod and friends) don't do any such lookup, and there
are ways to look up pins without that property - and I'd expect pins
are numbered on many controllers outside of MTK and STM, so looking up
that property would give a false response there.

> I would like to understand why do we need this property and what is
> described by it.

Same here...

> Because if it's purpose is only to fail or not fail
> driver probe, then we should just drop it everywhere.

Agreed (and I think more likely than not, that is the only purpose),
but probably a "add support for another board" patchset isn't the
right context for that.

I can prepare a "remove pins-are-numbered" patchset, but given it will
likely take time to track down someone who knows why this was added in
the first place, I don't think it should block the MT8365 patchset.

Best regards
bero

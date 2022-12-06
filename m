Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9414A644923
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 17:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiLFQZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 11:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiLFQZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 11:25:34 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E061829CBC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 08:25:32 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id q83so3996275oif.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 08:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ais45k9vzwCVRwJ6whVGyw5sNpBkvpT+u93PldECuY=;
        b=SJXK9Njs3/WtQdYO1n5tuMWFnm8eLIT/BZjadd4iLnQyhAXZ8ONXFwPHzYKYFKmvRY
         RUbmsPRvmSN+4oRKBXgX6i4ctkwgVYGNtMm2wdZFidfCSaQ/DQ5AEL6FMxUl0f7Vqi/N
         T0dFcibaJyb7eo5g6dZzXHexJ1NL2vz4ACpEiBj9q+fnBYHC2WM/yLNoY640QEfGORVL
         q3dXAZiHthjklcd02ga4DtsYdCLhAJK+YRTSkfjhD91SGLZT+gmG1wBYXQfyNTybrdWy
         1ej3vsNkXbAOc2pSxX2XFUQEI92czeXwYRrMKtznQZsR9SW0y3QbuZ+2/3P50aDtpYBQ
         0zvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ais45k9vzwCVRwJ6whVGyw5sNpBkvpT+u93PldECuY=;
        b=KTvn1+f+4vmb32llXEK8lc7rrKrVBCypRa4pQUM9jvTM3/Py+/MLN+xTlr9WCKmXIa
         EO+09X2a6X4BO42Z3SM4OnZdBdQcbZSDvDTXDwTWQJ3eDSbEL5GgRXrDn7NifUxgR6AS
         C3tkPJKlBSoyWaoZSWgUpnsZ3IoPKsj2n3E4zigSvQNn1s0ghA7ChUpPNrTl93yOl4hn
         +/tBaDHB35wYd06mChYGvZGNoPiokwqlZMnbBxnUzXVnj2XxSM5jNzcPyaE71uKugh17
         WQ/IWMC0m791D8dVjasshDoY9E//YpW1SCueKRODxAmFhtOXdEM4oPq+42gNC45DnRA3
         0H9Q==
X-Gm-Message-State: ANoB5pmkKI57sEay0AG74Xj1Hevo62MUwdxRb22odcvpEdqYk+zmAeDg
        A18h/88uJzO4F2nG/BUuGIHS94ir3rnS3W8RmXEu4w==
X-Google-Smtp-Source: AA0mqf7slrigjIb2YU0eOuwcUhtuWW55HhFXBRbOprBZ/PpE0rScnzOSK1B/21a3d6JGXEaZoNeytI+ZqJu+h+XBOmM=
X-Received: by 2002:aca:de45:0:b0:354:58db:8639 with SMTP id
 v66-20020acade45000000b0035458db8639mr32339713oig.152.1670343932030; Tue, 06
 Dec 2022 08:25:32 -0800 (PST)
MIME-Version: 1.0
References: <20221129023401.278780-1-bero@baylibre.com> <CACRpkda75U=b50rK=WecNvaEoTdN2UzGyEwfPRaO6jG9FGyWhw@mail.gmail.com>
In-Reply-To: <CACRpkda75U=b50rK=WecNvaEoTdN2UzGyEwfPRaO6jG9FGyWhw@mail.gmail.com>
From:   =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Date:   Tue, 6 Dec 2022 17:25:21 +0100
Message-ID: <CAP2ifjN-czBPKsm6o9U0Zx3dgau6bydFSrZmtwNJecSQu9VMzg@mail.gmail.com>
Subject: Re: [PATCH v3 0/7] Remove the pins-are-numbered DT property
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, khilman@baylibre.com,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 10:22 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> Hi Bero,
>
> long time no see!

Hi Linus,
indeed, I've been doing mostly userland stuff lately, and my latest
kernel patch was x86 (got to keep all of my hardware working ;) ). Now
that I've changed jobs, I'm expecting to be more active on the kernel
side (though still doing a lot of userland).

> > This patchset removes all uses of pins-are-numbered and marks the
> > property as deprecated.
>
> I don't remember any more why this property was introduced, but
> I am happy to see it go.

I couldn't find why it was introduced either (and git blame wasn't
much help). I'm assuming there was some other mode in vendor trees
that never made it into mainline (but the flag for switching between
the modes did).

> I applied patches 1-4 to the pin control tree for v6.2,
> please funnel the rest through mediatek/stm32 and
> SoC trees!

Thanks! Remaining patches reposted and currently waiting.

ttyl
bero

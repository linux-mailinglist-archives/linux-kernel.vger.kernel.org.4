Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107F15F88CE
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 04:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJICPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 22:15:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiJICPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 22:15:16 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634F527FCD
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 19:15:15 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id n73so1448616iod.13
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 19:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JpkrynInBk4Gig68d82GDSuRNyz+N99lUi3tPpqQn1Y=;
        b=KUBfVvEt03ilQTj5FK8GWOnIjci2oqtZdj15FaXJERjrMf8jRDPzUAqqmZV1tLO4gM
         M6PY1EQogYxy2bbzRSOZB2vELb/ehxzCXwUp7qKAZSKNryXSA43UqQhOtjlQj1owlQqX
         cTEjL3mjTEvtpaJ+hBMwTRMynyWhjsNjXTjVvAG5nIfk1PdMTu0TwOYWz3PtoPR2pVcn
         wWbjNOWLe2m5JfgESdOzTLT5C+CIN1q+Djn41ezD1TlQ82HMRy1ngxURJJelY5VylGdR
         hB61xPCEi2jpPc0d489v6o2jpxTX/wn2YnsbWoUko9ZzooRMr4f/3Zvdb72N3y83wQYc
         +mKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JpkrynInBk4Gig68d82GDSuRNyz+N99lUi3tPpqQn1Y=;
        b=kDeUAAde9H5o3zB56uvIaEuTSA53Yjuic0NQhwoQp5lDrSuP/bG3hR8gRN20qLK5Vf
         z5LNyeq8OacgiJTORUXFi4IeNfDy/sQRGDG4kz+pLJTgHA91vG40Xf1G0htcvMRwNRDY
         UzFILrmf/nxjxu7YJGS2w3BLah6nnf5gE1hZcG+/pFXWoIbG9ftnF9JQqoPjzeUw4UZN
         QS4so2Yvrm8jS5hY4A/VhNzkANXuQ+s4O5fa714ZLVcWqdt4EK9eKriBWVVJ4srdF7Nn
         hq3wKJcg0SUIE2Srqe+wl7J44BgSYnaiCAQocfiaDVm/nU8MYOLs3LKjD0dLg3QoNmXh
         tGYA==
X-Gm-Message-State: ACrzQf1QEuaA6XxEN0fpEl2POqtO0jJ+huJzRFy4Z8RTgdR57cZdAgWY
        Vq33xONSXGFMam6+2SJHRJUJjrA25CzUcniS5zM=
X-Google-Smtp-Source: AMsMyM5vG7sqy2eAPyqqAVTb/Ry1BFCa6AaLshQqgXZYNF8utqWbUUFQSIhAymSpj5T7j475tUW6Nn0dVCSEMDMPQHs=
X-Received: by 2002:a05:6638:2385:b0:35a:623b:b2ca with SMTP id
 q5-20020a056638238500b0035a623bb2camr6145496jat.24.1665281714718; Sat, 08 Oct
 2022 19:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220928093103.64014-1-khalid.masum.92@gmail.com> <CACRpkdbZWMk9+wH8ndFEzZyUwKecjNfgT2xJnZEQx0ACPzLWbw@mail.gmail.com>
In-Reply-To: <CACRpkdbZWMk9+wH8ndFEzZyUwKecjNfgT2xJnZEQx0ACPzLWbw@mail.gmail.com>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Sun, 9 Oct 2022 08:15:03 +0600
Message-ID: <CAABMjtGFKK2EJojFMqzMPmRfcJzo1yzdOqDVT804WnhOQ1O79Q@mail.gmail.com>
Subject: Re: [PATCH] drm/tve200: Use drm_* variants for logging
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 12:54 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Wed, Sep 28, 2022 at 11:31 AM Khalid Masum <khalid.masum.92@gmail.com> wrote:
>
> > We have routines like drm_info/warn/err for logging. Use them instead
> > of dev_* variants to get drm-formatted log messages.
> >
> > Signed-off-by: Khalid Masum <khalid.masum.92@gmail.com>
>
> So is this the new thing? We've been through:
> - DRM_INFO_ETC BIG CAPITAL LETTER MACROS
> - Just use dev_info() & friends like everyone else
> - Now drm_info() & co
>
> Note I don't wanna bikeshed about this, just tell me there is
> consensus now so we know what to do.

Hi,

I was working on a TODO described here:
https://github.com/torvalds/linux/blob/master/Documentation/gpu/todo.rst#convert-logging-to-drm_-functions-with-drm_device-paramater

"Convert logging to drm_* functions with drm_device paramater". I do not
know of any consensus by the way.

>
> Yours,
> Linus Walleij

Thanks,
  -- Khalid Masum

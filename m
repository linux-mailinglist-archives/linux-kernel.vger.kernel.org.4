Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2729A60C536
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiJYHcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiJYHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:32:39 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD28F257
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:32:37 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx35so9687925ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:32:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+r3Ej5MJ+sN5EgIN4UbB8uiEPUjhfnn1clmg3no9TJA=;
        b=dHEXI2+TslzzCiyCa1KMcE47r1HtIoMwtoBUvkYBvqpP87fm4EUvpXQfRQ6MXO6AuC
         9xeO4KO3F0T+tFK/WMcBGLd+yq4Fw4c2AXe1ISkqTIDMK654s+kSbgEVGoLARnx3uoJW
         aD0U5w1Q9U2FxNEaud2UGBpkhZQnjHh9Yln5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+r3Ej5MJ+sN5EgIN4UbB8uiEPUjhfnn1clmg3no9TJA=;
        b=SWpqMiehd0N/RutIPM8zhZ2287cf8fpBPk9tVIdQE0h1YUwwWqwbiri7o6bQX8AOzL
         eGqJmdv2Bgn92uqIqAe9ZrvLQlVfoD8vKzsV1lTIuSYiqr34odxhOaPwn/VOIAPlBmC3
         RJ0C59HpEnGaj9/xSf2/yFhykb6QG+yPvMUJ/fg8+rJHdbsCE7/OQmHI8Iaup80LXDGq
         gCwD+JO8uCloWbqdNlXEht7dWJCCXRBb8Pg/nXHyLnTFnaR87o93YlDKvhlhPsNM2Te8
         dR4s58JayjVuciX58JNkFJ1MT174OllVC3x+NEgQYkig8+fToDhjpKnRuOmaX0+Fy8VZ
         wPCQ==
X-Gm-Message-State: ACrzQf17Siqw1d7CCJQShJnvm4wW+OgGwa+fVOS119FZd93+YXaZEHhW
        szrokeVQ2KkFnVOUuBlR0JbsugCRy42nZ49AorlQnw==
X-Google-Smtp-Source: AMsMyM7I2ND3r5rWOu78x2UxeUO/s4RiLWEaBOmN4MFRAA0t4abyOutiAaFD3Hl5qHMnJY+WWxw8umC0FhsMF7F5Qq0=
X-Received: by 2002:a2e:b055:0:b0:277:a98:aac0 with SMTP id
 d21-20020a2eb055000000b002770a98aac0mr3617068ljl.480.1666683155618; Tue, 25
 Oct 2022 00:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220829093141.45583-1-tomeu.vizoso@collabora.com>
 <20220909141528.5090-1-tomeu.vizoso@collabora.com> <CAPj87rMYW1xZdacZ1Y0qk+D9xpqsqE+cwbQ1j1nZ7S+RKpzOoQ@mail.gmail.com>
In-Reply-To: <CAPj87rMYW1xZdacZ1Y0qk+D9xpqsqE+cwbQ1j1nZ7S+RKpzOoQ@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Tue, 25 Oct 2022 09:32:24 +0200
Message-ID: <CAKMK7uGkFP1jSNQzv37PvSqvOtt1FnbfbNyYEf99WM=_2AszSw@mail.gmail.com>
Subject: Re: [PATCH v8] drm: Add initial ci/ subdirectory
To:     Daniel Stone <daniel@fooishbar.org>
Cc:     Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Clark <robdclark@chromium.org>,
        dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sept 2022 at 19:18, Daniel Stone <daniel@fooishbar.org> wrote:
>
> Hi,
>
> On Fri, 9 Sept 2022 at 15:15, Tomeu Vizoso <tomeu.vizoso@collabora.com> w=
rote:
>>
>> Also include a configuration file that points to the out-of-tree CI
>> scripts.
>
>
>  I think this para is outdated given ...
>
>> v8:
>>   - Move all files specific to testing the kernel into the kernel tree
>>     (thus I have dropped the r-bs I had collected so far)
>>   - Uprev Gitlab CI infrastructure scripts to the latest from Mesa
>
>
> But equally - and sorry for not jumping on the IRC (?) discussion as I wa=
s in the middle of other stuff when it came up - I'm don't think this is th=
e right plan.
>
> Mesa having all its CI in-tree makes sense, because merges happen rapidly=
 to a single canonical tree. If the scripts need to be changed for whatever=
 reason, we can merge something in under an hour and everyone immediately g=
ets it. DRM is quite different though, given the forest of trees we have an=
d the long merge paths between them. I worry that merging the CI scripts in=
-tree - especially for our initial attempt at it, when we're likely to need=
 to make quite a lot of changes before it settles down to become a stable s=
ystem that works for everyone - is shooting ourselves in the foot by limiti=
ng our flexibility.

So the entire "we have multiple trees" is why I want at least the
gitlab-ci.yaml in tree, to force people to collaborate more on one
thing instead of everyone rolling their own fun and hacking stuff up.
And there's still tons of stuff outside in the separate repo, like the
lab status so Linus doesn't get a silly history of lab flapping.

Also wrt "developers don't get the update right away due to
backmerge/pull delays", that's why integration trees like drm-tip or
linux-next exist. So maybe initially we should make sure the ci
patches go in through drm-misc, to maximize how many people see it.
And even for mesa it's not fully automatic, you still have the rebase
your branch if you picked a bad one for development (but yeah marge
does that if the MR is ready). If you're doing kernel development on a
linear tree instead of an integration tree, you're doing it very
wrong.

What I think everyone agrees on is that we probably get the split
wrong and need to shuffle some files back&forth, and that's something
we need to warn Linus about I guess. But somewhere we do need a split
between internal and external stuff, and personally I'd like if at
least the pure sw testing (build and virtual stuff) could be all in
upstream.

> Given that it's currently very dependent on fd.o infrastructure (publishe=
d ci-templates, the registry, the specific-tag runners for Collabora/CrOS D=
UTs, etc), there isn't much of a portability gain in bringing the scripts i=
nto the tree either. It's a good goal, but not where we are today.

I don't think there's huge chances for any non-fdo gitlab anytime
soon. Once we get there we might need to figure out how to standardize
the hw lab interfacing, and if we have all the sw targets in upstream
that should help with shuffling stuff around for a hypothetical LF
gitlab CI (or whatever it is).
-Daniel
--=20
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

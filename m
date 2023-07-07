Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA67A74B742
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 21:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbjGGTj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 15:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGGThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 15:37:24 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E6D26AD
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 12:35:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbda07675fso15e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 12:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688758513; x=1691350513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjTTuy3pR7yCwxc+ymqk+V4QgNVJ/yG4vdogUTF+H08=;
        b=nmCtPhlm928yluJDW7fvKvZ/+zzYDWY9FE3v70mZ+XNsB2fApZMKLaudto7gm1ZkPY
         tIBUBEtfY9THz82uKOIZKKSy87kT8hPbIkOaKH09qTPPfYTY5RtDgxAKL1XV4o2I3mi5
         zR0RuJ5WTdwSTsu1AK+gJI9GEiFuY9bO7MhN8gwsRkm0icR2oDo1u19AKofExxZM8jtS
         vvaLJg6x0rJIQ+9gjcXWNdGVFC/ZcRJcycmXuoYPLoO1rNJ0Y8l/2rYrG11ELU5m0IPY
         gSrLa6GyW7UNHev4K/72o0DyFnbRPTJB95x075l0qWTISPAgBRdQaL1Us5K3mSv+RAS8
         W8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688758513; x=1691350513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NjTTuy3pR7yCwxc+ymqk+V4QgNVJ/yG4vdogUTF+H08=;
        b=IexY46KRV4BoI95uhXZWsNaWAdOG60GJk2cXyD95MDNuIqx7BS4mzhW7qw5DivZ1K0
         b96tjANW0GZ9r0BvzhD57IclllifTY5CNwl1eMuSw+wnjfk8ul4zY+PDXzbtBot9F3/X
         tFjo/lFJlT0AR6TKbu06/lpnWDqw463UwOtNKadkuV2CpxseXLzKwCKQxrMUqC4VFkWz
         iCYbZbqdsoDYZdvyx0qze/W6VcWm0/tZNMM38HCgUUb8XILSRTZx2x8hj5o6hP01q8Qx
         aO51D1J1r3F4xo13pR5HYDvQcaxDW3KoNiZ7OMXuWJbt9vyuGhSFzN/EIVlmEzqFISgM
         04aA==
X-Gm-Message-State: ABy/qLZsaVHCjUoyLnxMBXAsaiK6c0DAjXpS8u1YXhjofVwmi0iV/vQ1
        +0HiE9D8MPvW+B2g4CkASDFQU8d1gltZamQnpJQAGA==
X-Google-Smtp-Source: APBJJlHoDXrVRzZplAIxqvP5BGfmN0a1MoLsMFcOWAv9R9XEIWj3t/JVPls4FKxp06zmHVe2bjdVm98ZFJcGPedDjsk=
X-Received: by 2002:a05:600c:3c97:b0:3f9:738:4efe with SMTP id
 bg23-20020a05600c3c9700b003f907384efemr4804wmb.1.1688758512599; Fri, 07 Jul
 2023 12:35:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230614235452.3765265-1-pceballos@google.com> <6b49563d-e9e7-ae8e-582e-f4aead06de0a@intel.com>
In-Reply-To: <6b49563d-e9e7-ae8e-582e-f4aead06de0a@intel.com>
From:   Pablo Ceballos <pceballos@google.com>
Date:   Fri, 7 Jul 2023 12:34:59 -0700
Message-ID: <CAO9JgFx2i=S5P6_ndO85k3GFnggyJW1pXavc1emmSC3yjO8M7A@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH v2] drm/i915/display/lspcon: Increase LSPCON
 mode settle timeout
To:     "Nautiyal, Ankit K" <ankit.k.nautiyal@intel.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 9:35=E2=80=AFPM Nautiyal, Ankit K
<ankit.k.nautiyal@intel.com> wrote:
> I was wondering if trying to set LS/PCON mode multiple time will have
> any effect.
>
> Unfortunately I do not have access to machine with Parade LSPCON chip,
> had suggested in yet another git lab issue [2].
>
> I have a patch for this, sent to try-bot, though not sent to intel-gfx
> yet [3].

I tested this patch and it did not resolve the problem. The error log
was repeated multiple times and there were still link training issues
afterwards.

> The timeout value was already increased from 100 ms to 400 ms earlier too=
.
>
> If there is indeed no other way, perhaps need to have this solution.

Yes, can this please be merged?

Regards,
Pablo

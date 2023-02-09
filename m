Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B541690FBC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 18:59:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjBIR7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 12:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBIR7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 12:59:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93781677BB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 09:59:36 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m2-20020a17090a414200b00231173c006fso6320398pjg.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r1sHi/E23a5yYsmSD28sY0fyQwDO0i2DVxMae0s0JJ4=;
        b=o05haLPl9IFTnLiAg/ESlz8CztWBcdgK2wygltUQorSKpGgCzbiKdy/mr41/xzAshv
         y0/21lFwlWTvjRcqF+IhmRJHDIUg8JZcVFNobJiaYDr31RUlao8fMn1NdfDlb7qOH7Jv
         VlwAFW1ulaw/3IAJcEapTR2lFj6XfcAgdq8plHVMwsX3eN1JMcQ4k+WXW9MbykE/v9z8
         2s18E6qy2xJrEtIxE69vdC3GxA8cwV4SltaGKf8T54eCbVLwhFgVXQcuhIlnT5GiS0Eo
         gBESZZWoNL4WiwI1A+f3D48A3zVr627PHUVtxDBG2fypuK/dy/6BjRoXm4IBGnLkcCGb
         3hAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r1sHi/E23a5yYsmSD28sY0fyQwDO0i2DVxMae0s0JJ4=;
        b=bJo8/u46paOiVktGoYlSLwF47TkNbU8HPfpF3JYFMwvVgR+baxs16XziIQWPn0jprz
         eLeuHTWt9zTbAoJCWeZoFTXVqRh2NEuYwp7nFrhdQRHMWEL+DWW78DqxxNGXsraWEY2B
         iIfKmkrNAWw+gkTw1KIUQ35l0KqjQc3NPe4nqpkxgqfu66VZ9U8zxa77w/U3IDkISfJx
         fRtrPLxpZkMUNIHgxCKChtGmDqTM03YD0JmSHmx7GW/ATZf4mJ+JW+3+HD+tHp9llGpZ
         BEa8mDFF+N5r+G/E4LIVZTRYYHeebr2YtXNadeEOemlDm89yx/ExRl+r/Q0d8e/0966+
         KXCQ==
X-Gm-Message-State: AO0yUKWgQ773g+v3Of45iXrISKEAsUZaWi9emPh/Uqf3pHBsAViQ291C
        EgsQH31cyJCcN8P6DCD82CRIHYLuoj7r2VDK5KU=
X-Google-Smtp-Source: AK7set86anSvfiXLykDPIZ+7CAlxpnSljgTl7iyZJZnzmy9NbpgqfbpEahUyyxMd04RymwBlbI7P6pE5EGISxlAdHV4=
X-Received: by 2002:a17:90a:7c44:b0:230:8f38:a4ab with SMTP id
 e4-20020a17090a7c4400b002308f38a4abmr1679601pjl.26.1675965567019; Thu, 09 Feb
 2023 09:59:27 -0800 (PST)
MIME-Version: 1.0
References: <CAMxBKG1RwbRJMG0cKcnbyKgznXeZLL+Zp1zXeOnxpYU0NkOO8A@mail.gmail.com>
 <CAMxBKG3o_6R7M0gaUHXA5yGgSe6HBWYK25fwF=8mN+JTno9t7Q@mail.gmail.com>
 <CAMxBKG0wDi-XwMZwMHq_DbFXt3pgK-CV-G7iT9BNftiXBoUHzQ@mail.gmail.com>
 <20230209153600.jtj6deqhgfocvwgc@houat> <cefe5482-f30f-e5cc-8722-1f60d610f059@redhat.com>
In-Reply-To: <cefe5482-f30f-e5cc-8722-1f60d610f059@redhat.com>
From:   Darrell Kavanagh <darrell.kavanagh@gmail.com>
Date:   Thu, 9 Feb 2023 17:59:15 +0000
Message-ID: <CAMxBKG2sFu_e4rQ_-ZyJN5+C6YDLMhSoCYgDpaFpBddHZjwwEw@mail.gmail.com>
Subject: Re: drm: panel-orientation-quirks: Add quirk for Lenovo IdeaPad Duet
 3 10IGL5
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
        airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

It certainly is a learning process! Let me try to get things together
properly myself, will be useful in the long run.

Darrell

On Thu, 9 Feb 2023 at 15:53, Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 2/9/23 16:36, Maxime Ripard wrote:
> > Hi,
> >
> > On Wed, Feb 08, 2023 at 07:04:58PM +0000, Darrell Kavanagh wrote:
> >> I've resolved this by adding a matching quirk in
> >> drivers/firmware/efi/sysfb_efi.c - see below.
>
> Right, this is a known issue on Lenovo 2-in-1s with
> the panel mounted 90 degree rotated issue. For some reason
> the efifb info still gives a landscape resolution even though
> the actual resolution really is portrait. This also messes
> up the pitch of the framebuffer leading to the weird corrupted
> looking output you saw.
>
> >> I've resolved this by adding a matching quirk in
> >> drivers/firmware/efi/sysfb_efi.c - see below.
> >>
> >> Are you the right people to be notifying about this?
> >
> > Yes, we are.
> >
> > Howewer, please follow
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> >
> > In particular, a proper commit log and your Signed-off-By tag is missing.
>
> Are we, do patches to that file go through drm-misc ?  :
>
> [hans@shalem linux]$ scripts/get_maintainer.pl -f drivers/firmware/efi/sysfb_efi.c
> Ard Biesheuvel <ardb@kernel.org> (maintainer:EXTENSIBLE FIRMWARE INTERFACE (EFI))
> linux-efi@vger.kernel.org (open list:EXTENSIBLE FIRMWARE INTERFACE (EFI))
> linux-kernel@vger.kernel.org (open list)
>
> Either way this should be turned into a proper patch with a proper
> Signed-off-By message as Maxime mentioned.
>
> My offer for the drm_panel_orientation_quirks.c patch to turn it into
> a proper patch for you also extends to this one. If you want that,
> please let me know and again add your Signed-off-by as a standalone
> separate line in your reply so that I can use it for the commit message.
>
> Regards,
>
> Hans
>
>

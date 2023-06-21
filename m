Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FBC737813
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 02:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjFUAFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 20:05:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjFUAF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 20:05:29 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F162198
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:05:28 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-62ffc10180aso41492326d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 17:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687305927; x=1689897927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cjAEk3SFfE2ymUddfpoaH0qHmadccwe2hQx1JcYGhDY=;
        b=6psugu+Y46150DvCzAVTofS0dUPrbRh/OPX8w0ihINFF6XXeU/SgXxOrhlRf6tj8WR
         Cpe5I7PiYgJy/4oy3stiM7/5boiYg2eLoJksjFEBFlMw5wiS0kQIt8aTSfMhYALhNSzH
         NjTZ023j5fsqHoU+XDwVDMGcmIytOXOLCF8PFzI5UY7LY12fGWAb8D0G+uWR62ZVJfEA
         K5+U2OeNXDVpVZj2V/EKv0h1hdT8e0MDTX3/m2kAQe8sMF1CpfRCmeKrBPBO7rOcOh5h
         jNHWieetamRaM1gzLqiaWjTOOuQLOelLCnq9IIhYeAx9rHwAKlA0qpJgVlWFvYFHLsAU
         RkCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687305927; x=1689897927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cjAEk3SFfE2ymUddfpoaH0qHmadccwe2hQx1JcYGhDY=;
        b=E2p7D8y7W9WwtYnC4ezQh7x/1Bp1c43B0uw0OLilq5Bsth+7Ol11KCjFpexpdkHKee
         mtFnX4jn+myB3w9oKgeiRUgERE6G/+kICO23QN3TsGC30XECUr73gOztP9xVF6qzwrxe
         LoHjpYcGlL2ksUi2DrcrCL0b2ECbUpkMHXvEzayjXjJBL0A76r6wAsNpAK5Vqe3ZSi7M
         9E7q0ogLCh7T1FiBKAuSWoaWs4ia1s4ebSZs0kx6qb/pks+SepUWEZ0RJjZOmxgLyhto
         WGyUQdY8iEkRc9eU+OAYkn6XyB1GqLLuRfZ/3Is4onRvzrve/W15AA4bmYQ+AZqkydAK
         Pmsg==
X-Gm-Message-State: AC+VfDy7oSrpIHaNvwMZDBmwjLMvFeaUfTjFUahCmfTm1LHZxnHR0Oxb
        6K7UL+S73p1HFt6fH5bx/J0WvgVrojvMHXkdjfpayQ==
X-Google-Smtp-Source: ACHHUZ7jbjfz/6+WqI379nVPbeTd8F1S09A+p3YjzMSTmMOGu3rNoTAg3lcpI1GlIptvP4sxRp8G7re9/xrgdUCyPGE=
X-Received: by 2002:ad4:5cca:0:b0:62f:ea7b:2911 with SMTP id
 iu10-20020ad45cca000000b0062fea7b2911mr19387534qvb.56.1687305927333; Tue, 20
 Jun 2023 17:05:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230615193546.949657149@infradead.org> <20230615193722.194131053@infradead.org>
 <202306201454.0A2E875F@keescook>
In-Reply-To: <202306201454.0A2E875F@keescook>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Tue, 20 Jun 2023 17:04:50 -0700
Message-ID: <CABCJKucbBfpwPYnKoEpAx1xe58uShKsxBhX5y8JyaTRs3eWanQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86/fineibt: Poison ENDBR at +0
To:     Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        alyssa.milburn@linux.intel.com, linux-kernel@vger.kernel.org,
        jpoimboe@kernel.org, joao@overdrivepizza.com,
        tim.c.chen@linux.intel.com
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

On Tue, Jun 20, 2023 at 2:55=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Thu, Jun 15, 2023 at 09:35:48PM +0200, Peter Zijlstra wrote:
> > Alyssa noticed that when building the kernel with CFI_CLANG+IBT and
> > booting on IBT enabled hardware obtain FineIBT, the indirect functions
> > look like:
> >
> >   __cfi_foo:
> >       endbr64
> >       subl    $hash, %r10d
> >       jz      1f
> >       ud2
> >       nop
> >   1:
> >   foo:
> >       endbr64
> >
> > This is because clang currently does not supress ENDBR emission for
> > functions it provides a __cfi prologue symbol for.
>
> Should this be considered a bug in Clang?

The endbr is needed with KCFI if we have FineIBT disabled for some
reason. There's some discussion here:

https://github.com/ClangBuiltLinux/linux/issues/1735

However, since the kernel handles FineIBT patching, it might be
cleaner to let it also poison the extra endbr.

Sami

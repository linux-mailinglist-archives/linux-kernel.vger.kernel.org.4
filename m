Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7D5B3912
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiIINfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiIINfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:35:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47F45B72BC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:35:19 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id y9so1221986qvo.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JowtK10yvVmyUpTESi/zVeCC2TkAptyeECG562T7tNo=;
        b=kkoh2qFvdpskjcO3O9CspqSrm+Wuc1/hOeiZjsnq3rNju1rfqdoOhvtJUOvkzIqr98
         wTnfqyDwIntAXt6osUowan3L9rhZZyuME5qPACRgQCjoFRYtI3jzbtnSzIeov/g87UTD
         /eh4u/OBZfKgMEqttI/k13/ERI0pNjfYIZlmWlaK3yc6gEMQDGBbd58yz50W95FL3M8a
         9JGJGqJKb4A7daZpC1B3dsXNQnA0hgg4UP2r1VsVLY1wzXYGLIINA6MnKIxHJp2b7lbr
         lLvZJNqVLt5MVXehr0DuSi/n41P0s0Tka8LacU4yKBmbrf6LsGreHTOaQagB+o3gXtxU
         q2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JowtK10yvVmyUpTESi/zVeCC2TkAptyeECG562T7tNo=;
        b=GQl+tYo0SRpd0NrjGcYSWYB/gcgMcGk4vehrnUwHuvQ1g49TwXy+ALyWBj4ZO7XTxu
         AhBcKQj8r1GTIQ7M/5DAxPSW2oCRbliK/6Yc7Hypl76ZztN0sS6IfRQK5xJ9tp9zU4DK
         Ahbzkdlbd7Oei5ypvmF33aEh2xgzz0imJ5RlcLjUOkL2PdXU2x/oD+pElnRo4NbXJWt3
         I0Yosr5lf/Jd3dz4X+Xj/jfA0uxY8m+SSkzFXLIMooHXs2IIUm1hz/ihsRpOcTLqSZc1
         BE8rEV4huiXF/Sv7qFg1xLBY1ycIZR3R6/6mpfMws1/VazGf38gj1e6JM5N/yjf3v3EO
         gg6Q==
X-Gm-Message-State: ACgBeo3OUKhECqmRGGA5ARyy88uaB4umpD9h2G1cl5CW9RRupFU7322n
        afX5zbL6agEbBcX1bQsSMy3LKQxSPsSxi7bOBZo=
X-Google-Smtp-Source: AA6agR7YMsTtgJFIi7UbUzLeHKPkUeVDEUvCuHO7Yfi7TfUL6dmtKcBrILqT8YrI6z6mvf14yS66NhsLhhhwSxCEli0=
X-Received: by 2002:ad4:5bc1:0:b0:496:fd12:3ece with SMTP id
 t1-20020ad45bc1000000b00496fd123ecemr12060263qvt.27.1662730518310; Fri, 09
 Sep 2022 06:35:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220901141307.2361752-1-georgepee@gmail.com> <Yxsl5PaioteeAcnh@arm.com>
In-Reply-To: <Yxsl5PaioteeAcnh@arm.com>
From:   George Pee <georgepee@gmail.com>
Date:   Fri, 9 Sep 2022 08:35:07 -0500
Message-ID: <CAKj0CMs5S8RWJ6FU8wGda8fZzoFZCxjCQ6=dgz1pX-v2D+p6tw@mail.gmail.com>
Subject: Re: [PATCH] Report support for optional ARMv8.2 half-precision
 floating point extension
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        "Kirill A. Shutemov" <kirill.shtuemov@linux.intel.com>,
        Austin Kim <austindh.kim@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use case is really being able to tell, from userspace on a 32-bit
kernel, if FPHP is supported. It's really just reporting for
convenience.

It wasn't clear to me why HWCAP2 was used in some cases and not
others.  I can add FPHP to HWCAP2 if that's the right thing to do
here.

On Fri, Sep 9, 2022 at 6:39 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Thu, Sep 01, 2022 at 09:13:05AM -0500, george pee wrote:
> > Report as fphp to be consistent with arm64
>
> Do you have a use-case as well? It may help deciding what to do with
> this.
>
> > diff --git a/arch/arm/include/uapi/asm/hwcap.h b/arch/arm/include/uapi/asm/hwcap.h
> > index 990199d8b7c6..f975845ce5d3 100644
> > --- a/arch/arm/include/uapi/asm/hwcap.h
> > +++ b/arch/arm/include/uapi/asm/hwcap.h
> > @@ -28,6 +28,7 @@
> >  #define HWCAP_IDIV   (HWCAP_IDIVA | HWCAP_IDIVT)
> >  #define HWCAP_LPAE   (1 << 20)
> >  #define HWCAP_EVTSTRM        (1 << 21)
> > +#define HWCAP_FPHP   (1 << 22)
>
> I think with ARMv8 features on the arm32 kernel we tend to add them to
> HWCAP2_*. With such change:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>
> I'll leave the decision to Russell on whether he wants this merged. An
> argument may be that people still want to run 32-bit user-space and even
> if they use am arm64 kernel, we can't add a COMPAT_HWCAP2_FPHP until we
> have the arm32 counterpart. An alternative may be to only add the uapi
> definition under arch/arm but without any functionality (so never
> exposed to user). The arm64 kernel could expose it to compat tasks.
>
> So, if Russell is ok with any of the options above, please also add the
> compat arm64 support ;).
>
> --
> Catalin

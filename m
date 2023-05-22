Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519FE70B798
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjEVI2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbjEVI2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:28:43 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A76B7
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:28:40 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2afb2874e83so12333191fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1684744119; x=1687336119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CKYPMbp630qRmaM4E26ANDSF3jxKcu+IzgA8/biQrNQ=;
        b=Pwnm0Tm/WkzNFp/fY6TUyeZT5Dh261RCGr0eDEZxuSAJMDpS/euyadlSYfcDip4Z8y
         bVSEcvBhEQsKivOG9F4pylBfrRMUq06HX/x7iaHCdKCdwzbaGUdpZ+yEo6hcEOFkREeH
         mEgN35bB2FAQ/dxUHils0fEjePajUBnJDYdXGvNVvDo9xamL+LPmigMiuKcsFPJrkfb5
         UhUzLXVYiJ44gg+SnRBfGIMTmtZgPjfKEq4WKb9veT1C6Hw2v8qzOIhKeJNz73xC8Ugh
         VAww1kS+SmB8deTBmzfaPkmDUp/DLUbas5FqUmOT63jHYtBKnMUaNvqx4hmx/p7Tb/Fm
         yJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684744119; x=1687336119;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CKYPMbp630qRmaM4E26ANDSF3jxKcu+IzgA8/biQrNQ=;
        b=J7orfkHuHiyxn4RzvJljw53N9ktpIebtJ5T3zntOuw2l1iS9TTwLicr2+W66bvAZhp
         vpApFxYyY+NpFrO13jSaPP6I577wDyGbKDTrtbr4Tay+b3+jNRWd8nfMAkq3F2AjeM/Q
         60Li9NIfNitaAKpJyTghmzfRidB8KD9aWN5m9c/SfzoXEmAk00TU/eNQ8eFb5qnvnziv
         eQVjCeY1JvMdYo/KkhyCTINQ3lLxmOHhLScEoy+QbOmnze1s+20GXWUWAlp0HHhh6YZK
         xRYloZteZtr8GOulagHunIykg1R+Mnk20Ha9NQFRAmcv47Cu40uvigsUhP1ITJ3sUgGE
         HPQg==
X-Gm-Message-State: AC+VfDwgZ/JPxxn2MZDu3eyxKAL1aTTQANCgX1KWgOWMtLvAYlTsP/Rg
        rB0ChVMSN8nL3k3EhXpA9m0Bi12mHddsf5Q7KCNOgg==
X-Google-Smtp-Source: ACHHUZ4H/n8LyJZKrrrTCdulrMsNzulqQBwkXUdqJqaOucvQyBqwQPSaZGg22TL+3dKhN/zIE0PFmrieJWgLDO5PIfA=
X-Received: by 2002:a2e:9609:0:b0:2af:2908:8ff3 with SMTP id
 v9-20020a2e9609000000b002af29088ff3mr2980646ljh.33.1684744119136; Mon, 22 May
 2023 01:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230518161949.11203-1-andy.chiu@sifive.com> <20230518161949.11203-21-andy.chiu@sifive.com>
 <5677700.DvuYhMxLoT@basile.remlab.net>
In-Reply-To: <5677700.DvuYhMxLoT@basile.remlab.net>
From:   Andy Chiu <andy.chiu@sifive.com>
Date:   Mon, 22 May 2023 16:28:28 +0800
Message-ID: <CABgGipW9xtZp-c2xWakz+EzrMbviN_9iAEtmfx73L4TJAn3K8Q@mail.gmail.com>
Subject: Re: [PATCH -next v20 20/26] riscv: Add prctl controls for userspace
 vector management
To:     =?UTF-8?Q?R=C3=A9mi_Denis=2DCourmont?= <remi@remlab.net>
Cc:     linux-riscv@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 1:41=E2=80=AFPM R=C3=A9mi Denis-Courmont <remi@reml=
ab.net> wrote:
>
>         Hi all,
>
> Le torstaina 18. toukokuuta 2023 19.19.43 EEST, vous avez =C3=A9crit :
> > This patch add two riscv-specific prctls, to allow usespace control the
> > use of vector unit:
> >
> >  * PR_RISCV_V_SET_CONTROL: control the permission to use Vector at next=
,
> >    or all following execve for a thread. Turning off a thread's Vector
> >    live is not possible since libraries may have registered ifunc that
> >    may execute Vector instructions.
> >  * PR_RISCV_V_GET_CONTROL: get the same permission setting for the
> >    current thread, and the setting for following execve(s).
>
> So far the story was that if the nth bit in the ELF HWCAP auxillary vecto=
r was
> set, then the nth single lettered extension was supported. There is alrea=
dy
> userspace code out there that expects this of the V bit. (I know I have
> written such code, and I also know others did likewise.) This is how it
> already works for the D and F bits.

Yes, the V bit in ELF_HWCAP becomes vague in this series.

>
> Admittedly, upstream Linux has never ever set that bit to this day. But s=
till,
> if we end up with the bit set in a process that has had V support disable=
d by
> the parent (or the sysctl), existing userspace will encounter SIGILL and
> break.
>
> IMO, the bit must be masked not only whence the kernel lacks V support (a=
s
> PATCH 02 does), but also if the process starts with V disabled.

This is going to change ELF_HWCAP from a macro to a function. The
function will turn on COMPAT_HWCAP_ISA_V iff V is supported and
allowed. I am going to do this in v21 If this looks sane. i.e.
Currently I don't see other architectures which give different
ELF_HWCAP values on each execve. If ELF_HWCAP is not a right place to
encode the information then userspace has to make the prctl() call to
be certain on whether V is usable.

>
> There are two ways to achieve this:
> 1) V is never ever set, and userspace is forced to use hwprobe() instead.
> 2) V is set only in processes starting with V enabled (and it's their own
> fault if they disabled it in future child threads).

The prctl() interface does not allow processes to turn off V once it
is enabled in its current (execve) context. The process can only
disable V when the next execve() happens. Then, if we implement
ELF_HWCAP as mentioned above, the kernel will reload a new HWCAP for
the process. By then, the new HWCAP will have V masked since it is not
allowed.

>
> Br,
>
> --
> =E3=83=AC=E3=83=9F=E3=83=BB=E3=83=87=E3=83=8B-=E3=82=AF=E3=83=BC=E3=83=AB=
=E3=83=A2=E3=83=B3
> http://www.remlab.net/
>
>
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

Thanks,
Andy

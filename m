Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5684A612354
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiJ2NgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbiJ2Nf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:35:56 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00EB5B7A1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:35:53 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id f140so7070021pfa.1
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 06:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PYT2H+asttmGrnTEbtBs6S26N69cVRe/oe+P3/aHN04=;
        b=JxoNvEi/7SInu7EfRCCtxS3rAffvOFXRChbpSPf5S77yHi6xffAsqVQlmpRu9GVqW/
         0jYhUEtgj1YkK+vZOAQ6iF6mhir6+1o8caGfeVBQsLIMw9VuoZWF2U9De8ZyXZKOcira
         9vqzsi9T4MZMimg0kbRDoNSBXyWu+b7Cv9iVZ8RFk58y5VVbxle67SJUyYVU5d8gf72E
         Ys/4uAK7sUp/GPxY+XVFzfFP5dy2d4sUWrlRXxLa8HQvs75oBFbgHNMvrD+E/3zntpZ1
         ZbpdeY+lSec9seex4aMOsBA4Klvf5jJ9WXwy1nE8xW2j/T6xTevNMxeP2nXMZEr/offt
         tO3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYT2H+asttmGrnTEbtBs6S26N69cVRe/oe+P3/aHN04=;
        b=VuUu+vGL6w6OUIGizwiHSVsetf3Hnk1EKWYxv4qfxhCbUnQ4VznJQ0EaXfTTVAadF/
         1Rp6kIxX3afMDZyZBx+mo/ovaeGqj45RhbZKsl4DfJOFJcjV8/cIjb7XBen+Opfy+MdL
         Br9spAxTta8GjuMbymWV8aOJRzoldbGDXoaW+UgeKDvQfAnRcbC55KVAhfoqd8ID6O5c
         fTmdu1epI7RLF7Ctrf1V/WzJezhhGgoP+q9uWkGS4zaIgfpMmdFHeBOBho5f/zRW/ePJ
         vi8a07mKeJAzjDlYn15hqfeFniJdWfR/JkZcG7jZ/elmO+kBbU6vVqRqaUGLO9ruMC3Q
         WQ7Q==
X-Gm-Message-State: ACrzQf22YJLuR2vcDmnUl+1/cHEnW745VYtN7S/UOLKRRBsMz/ECA8Hr
        yz9wY3x9lwNp6YGMcomHfeDvc9tQYOOW7iQs
X-Google-Smtp-Source: AMsMyM7T5oMuG1G25BLrr8bFnwqtikZdyyDBCaGum9l7T2BEsORdo6iv+Yrdvtsd64TaUA3mA2sMkg==
X-Received: by 2002:a05:6a00:cd1:b0:563:8df5:2b8b with SMTP id b17-20020a056a000cd100b005638df52b8bmr4495137pfv.67.1667050553274;
        Sat, 29 Oct 2022 06:35:53 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-19.three.co.id. [180.214.233.19])
        by smtp.gmail.com with ESMTPSA id m1-20020a170902db0100b00186a2274382sm1297027plx.76.2022.10.29.06.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 06:35:52 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 246EE103D9A; Sat, 29 Oct 2022 20:35:50 +0700 (WIB)
Date:   Sat, 29 Oct 2022 20:35:49 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: entry: Fix typo
Message-ID: <Y10sNSE6/B2p95+I@debian.me>
References: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jd+hTkK2iZEDLYlo"
Content-Disposition: inline
In-Reply-To: <1667027268-1255-1-git-send-email-quic_mojha@quicinc.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jd+hTkK2iZEDLYlo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 29, 2022 at 12:37:48PM +0530, Mukesh Ojha wrote:
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-c=
ommon.c
> index 9173fad..b694d8f 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -30,7 +30,7 @@
>  /*
>   * Handle IRQ/context state management when entering from kernel mode.
>   * Before this function is called it is not safe to call regular kernel =
code,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   *
>   * This is intended to match the logic in irqentry_enter(), handling the=
 kernel
>   * mode transitions only.
> @@ -63,7 +63,7 @@ static void noinstr enter_from_kernel_mode(struct pt_re=
gs *regs)
>  /*
>   * Handle IRQ/context state management when exiting to kernel mode.
>   * After this function returns it is not safe to call regular kernel cod=
e,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   *
>   * This is intended to match the logic in irqentry_exit(), handling the =
kernel
>   * mode transitions only, and with preemption handled elsewhere.
> @@ -97,7 +97,7 @@ static void noinstr exit_to_kernel_mode(struct pt_regs =
*regs)
>  /*
>   * Handle IRQ/context state management when entering from user mode.
>   * Before this function is called it is not safe to call regular kernel =
code,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   */
>  static __always_inline void __enter_from_user_mode(void)
>  {
> @@ -116,7 +116,7 @@ static __always_inline void enter_from_user_mode(stru=
ct pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when exiting to user mode.
>   * After this function returns it is not safe to call regular kernel cod=
e,
> - * intrumentable code, or any code which may trigger an exception.
> + * instrumentable code, or any code which may trigger an exception.
>   */
>  static __always_inline void __exit_to_user_mode(void)
>  {
> @@ -152,7 +152,7 @@ asmlinkage void noinstr asm_exit_to_user_mode(struct =
pt_regs *regs)
>  /*
>   * Handle IRQ/context state management when entering an NMI from user/ke=
rnel
>   * mode. Before this function is called it is not safe to call regular k=
ernel
> - * code, intrumentable code, or any code which may trigger an exception.
> + * code, instrumentable code, or any code which may trigger an exception.
>   */
>  static void noinstr arm64_enter_nmi(struct pt_regs *regs)
>  {
> @@ -170,7 +170,7 @@ static void noinstr arm64_enter_nmi(struct pt_regs *r=
egs)
>  /*
>   * Handle IRQ/context state management when exiting an NMI from user/ker=
nel
>   * mode. After this function returns it is not safe to call regular kern=
el
> - * code, intrumentable code, or any code which may trigger an exception.
> + * code, instrumentable code, or any code which may trigger an exception.
>   */
>  static void noinstr arm64_exit_nmi(struct pt_regs *regs)
>  {
> @@ -192,7 +192,7 @@ static void noinstr arm64_exit_nmi(struct pt_regs *re=
gs)
>  /*
>   * Handle IRQ/context state management when entering a debug exception f=
rom
>   * kernel mode. Before this function is called it is not safe to call re=
gular
> - * kernel code, intrumentable code, or any code which may trigger an exc=
eption.
> + * kernel code, instrumentable code, or any code which may trigger an ex=
ception.
>   */
>  static void noinstr arm64_enter_el1_dbg(struct pt_regs *regs)
>  {
> @@ -207,7 +207,7 @@ static void noinstr arm64_enter_el1_dbg(struct pt_reg=
s *regs)
>  /*
>   * Handle IRQ/context state management when exiting a debug exception fr=
om
>   * kernel mode. After this function returns it is not safe to call regul=
ar
> - * kernel code, intrumentable code, or any code which may trigger an exc=
eption.
> + * kernel code, instrumentable code, or any code which may trigger an ex=
ception.
>   */
>  static void noinstr arm64_exit_el1_dbg(struct pt_regs *regs)
>  {

What about "... it is unsafe to call regular kernel, instrumentable, or
any other code ..." instead?

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--jd+hTkK2iZEDLYlo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY10sMgAKCRD2uYlJVVFO
o2znAQDROD4B4MW/h2UtIpvM/S8ULS2o+L+Q6c5XC6UzJV6Y8gEA/or0r7pjXDwN
IfH5LgYp0u+3xs/bzhUc3SakWtYtKgA=
=mREl
-----END PGP SIGNATURE-----

--jd+hTkK2iZEDLYlo--

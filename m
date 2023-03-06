Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE146AB8C3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:48:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbjCFIsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:48:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:48:41 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD15449E;
        Mon,  6 Mar 2023 00:48:39 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id y2so9020528pjg.3;
        Mon, 06 Mar 2023 00:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678092519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QL3D3IFssfqAcoz9U5L3ra97LeXFC8PAa9Bxh4q7krk=;
        b=kInJZia6jXpz4sGTiwT3kN9m3USfoq4YOvN1MahB6MW7+J3QBFlBhdXd+WY3WsPgov
         ZpL+jvBDgyswYuIGAlnkXRv2dD4GZapO7NidAP3EWa4rq/QrO/xYC0kmSnTq/0B5iZVO
         u5wqRGc7NR8a2wqPu9uq6n+u9L9uLj6mSgHtIte/UPEMk3U0xslI5WX0HvYBz0K21CAb
         axyoyyuC0WzeJYl6Xggx6fniXJ3ZOCvyLHamEN/REI0TOUiL9ECAahALVOinpH0c8nU+
         t4rdmA6Wa+GqzqQBoRF0JCa3BX61tHy380xkm2orG+uhVzIBzfJ+DVgVFEG+A7XVhcoU
         ucBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL3D3IFssfqAcoz9U5L3ra97LeXFC8PAa9Bxh4q7krk=;
        b=QQcjS4Jk+9LN9LXTKYWL8kDyIwBcj/T5mq2+JmARhuQT0Laku7RcWqvmMf/COChJEk
         dbkh4tsAatKDLWNvr/f3JwhrlnOE5djIR/sNwfwXpfrZknDR+T5Hg4PV1BBor8wLMERn
         /3FAhB9z5rrgUpq+i+K0gkf+GAW2uxO1D8DSQe4b4ZE3wljemRy2a/Y0xfqa0/+xI/PV
         wDTiVFrz32rA74lupgw/yBnYjxTo+jmWhcmX2zW76RPxVrnh4Ow55Z3ALYjmQuBf1yAs
         875JYOV0rEi9BVH1YoQR0VNpUxQJlYF5duaFQOKOsgOfV8T/BVVUxVargObNxuK+bwnT
         Y8Rg==
X-Gm-Message-State: AO0yUKWHLOsuL3EDlKSnux3SqE9XkYLyWm8jnz7ID+Bj4xxxVFRRG48P
        PIrYVbioKKz9S4Y5pOepUtQ=
X-Google-Smtp-Source: AK7set9ckGHLdbVf+/Cm+9akHzUlyw9lUKHzYuQYd9IdP0H9Msr9rxBucnt1pfh2hjkANMRshctdKw==
X-Received: by 2002:a17:902:ea02:b0:19d:2a3:f017 with SMTP id s2-20020a170902ea0200b0019d02a3f017mr12474545plg.62.1678092519375;
        Mon, 06 Mar 2023 00:48:39 -0800 (PST)
Received: from debian.me (subs03-180-214-233-82.three.co.id. [180.214.233.82])
        by smtp.gmail.com with ESMTPSA id lf15-20020a170902fb4f00b00194ac38bc86sm2206992plb.131.2023.03.06.00.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Mar 2023 00:48:38 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 7236C1062E0; Mon,  6 Mar 2023 15:48:36 +0700 (WIB)
Date:   Mon, 6 Mar 2023 15:48:36 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Vegard Nossum <vegard.nossum@oracle.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Jiri Kosina <jkosina@suse.cz>,
        Solar Designer <solar@openwall.com>,
        Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Amit Shah <aams@amazon.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Subject: Re: [PATCH v3 0/7] Documentation/security-bugs: overhaul
Message-ID: <ZAWo5BEPmNTkC2Gf@debian.me>
References: <20230305220010.20895-1-vegard.nossum@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="L2+HyKnihq8gts0j"
Content-Disposition: inline
In-Reply-To: <20230305220010.20895-1-vegard.nossum@oracle.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--L2+HyKnihq8gts0j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 05, 2023 at 11:00:03PM +0100, Vegard Nossum wrote:
> Hi,
>=20
> This is v3 of clarifying our documentation for reporting security
> issues.
>=20
> The current document is not clear enough, in particular the process of
> disclosure and requesting CVEs, and what the roles of the different
> lists are and how exactly to report to each of them.
>=20
> Lots of people have been confused about the 7/14 days of the kernel list
> vs. the 7/14 days of the distros list, the fact that these are two
> separate lists, etc. Many reporters contact distros first, or submit
> their report to both lists at the same time (which has the unfortunate
> effect of starting off the disclosure countdown for the distros list
> before s@k.o has had a chance to look at the report). I've shared the v2
> document with a couple of people who submitted reports and they said
> they found it a lot clearer.=20
>=20

The docs LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--L2+HyKnihq8gts0j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZAWo5AAKCRD2uYlJVVFO
oy9UAQCcdhC6kNEb/Ch1VdBnFbItrrJIHkj953sjJx6TkqlZdwEA7JHcMEkcUGLj
5C22FvhMyVeMAlg73eSmH04v+m/0hQg=
=rHOT
-----END PGP SIGNATURE-----

--L2+HyKnihq8gts0j--

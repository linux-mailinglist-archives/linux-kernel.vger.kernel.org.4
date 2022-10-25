Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB3E60C257
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 05:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbiJYDqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 23:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJYDq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 23:46:29 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2446E13DDF;
        Mon, 24 Oct 2022 20:46:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 3-20020a17090a0f8300b00212d5cd4e5eso9284712pjz.4;
        Mon, 24 Oct 2022 20:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PQa2XbdoWOe8eLkhZL1464PTK/1SKONGLnog+Alr8n4=;
        b=ePRePWJAH6OEEbCx78aGDx9EputeX5MnDTAcOh5BbsNeRqZ+eBRc2Du66WK2+u+61t
         GoRpgNY1k8lXU4ALP0pIFwm9pUQJ6psuUsEA3EoPzCxvoR+1qooZg/At6PBcqSXciILD
         QGNXRy9l1iVHZYiitVYuYfJ+xOtWRXoeWsiiZiswHHiyv47IS13Y+82kHPDdyi/ZvyHV
         lLHnDyDZBwYba1AwQbcA44LMTme2XAwGdSmmEd1OEhO2HXGTtfywV8QSmZNxhT0Iukbf
         huyEAeRAbRsaLc877EaBYWyUmeXbWnNeFqMwsEp6uxB9qfmUJaq8d7604BfpI3jZVVKb
         sgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PQa2XbdoWOe8eLkhZL1464PTK/1SKONGLnog+Alr8n4=;
        b=FWsj8+dbC9cJyFvUN1B3ChJy7J1n+LG/lSJt96a+/C0eYXV+oH3ROVmqyJeS402uFO
         WKgZg0dF0qviHdqeKpx7DpkmSvSUER2EPJh2Ra4SKVmZBYmp66WBTJD173YYPD4YUX4S
         WB5ZGM7vbQlGEePVSPPQAENV+1noXfBSYP4SFR46LIylI2xlRHc2Ii5uQ5zHSdWgzGn0
         NXNUzijc95zwZW7vxjNhEegPAJ/uQTZUd5vCdABoAhayNOqPyE/ggBCltcqGFoLmKcEo
         T9D5g1/E6HZKO7hyTvSWU7hjfmmLP7oNVs5l30T1ZNCDueWWFLcL+pozTo3e8q08D+yr
         qS+Q==
X-Gm-Message-State: ACrzQf2N2j8UygqM9y6mIlZwpJ2YboBw4KlkC0Ql64VdBQXXRnnVBRGN
        Gdr59AQVDZ0RmakY961/iH8=
X-Google-Smtp-Source: AMsMyM7VS1IZg3JqFMCzc/CNgaTyd/cEs0WsDJIMzIUscUv6eT5Vdd2nTWP8JVLDH79qQH0Y5fxvTA==
X-Received: by 2002:a17:902:e552:b0:179:e796:b432 with SMTP id n18-20020a170902e55200b00179e796b432mr36074043plf.21.1666669586600;
        Mon, 24 Oct 2022 20:46:26 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id w8-20020a63f508000000b00462612c2699sm445722pgh.86.2022.10.24.20.46.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 20:46:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ED14A1002B9; Tue, 25 Oct 2022 10:46:22 +0700 (WIB)
Date:   Tue, 25 Oct 2022 10:46:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, luto@kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Fenghua Yu <fenghua.yu@intel.com>,
        Joshua Ashton <joshua@froggi.es>,
        Melissa Wen <mwen@igalia.com>,
        Paul Gofman <pgofman@codeweavers.com>,
        Pavel Machek <pavel@denx.de>,
        Pierre-Loup Griffais <pgriffais@valvesoftware.com>,
        Tony Luck <tony.luck@intel.com>,
        Zebediah Figura <zfigura@codeweavers.com>,
        Andre Almeida <andrealmeid@igalia.com>
Subject: Re: [PATCH V3] x86/split_lock: Add sysctl to control the misery mode
Message-ID: <Y1dcDmmIu8gSX4Rb@debian.me>
References: <20221024200254.635256-1-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfEdKcxEziDo6DYw"
Content-Disposition: inline
In-Reply-To: <20221024200254.635256-1-gpiccoli@igalia.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xfEdKcxEziDo6DYw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 24, 2022 at 05:02:54PM -0300, Guilherme G. Piccoli wrote:
> +split_lock_mitigate (x86 only)
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +On x86, each "split lock" imposes a system-wide performance penalty. On =
larger
> +systems, large numbers of split locks from unprivileged users can result=
 in
> +denials of service to well-behaved and potentially more important users.
> +

DoS which harms legitimate users?

> +The kernel mitigates these bad users by detecting split locks and imposi=
ng
> +penalties: forcing them to wait and only allowing one core to execute sp=
lit
> +locks at a time.
> +
> +These mitigations can make those bad applications unbearably slow. Setti=
ng
> +split_lock_mitigate=3D0 may restore some application performance, but wi=
ll also
> +increase system exposure to denial of service attacks from split lock us=
ers.
> +
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0 Disable the mitigation mode - just warns the split lock on kernel log
> +  and exposes the system to denials of service from the split lockers.
> +1 Enable the mitigation mode (this is the default) - penalizes the split
> +  lockers with intentional performance degradation.
> +=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +

The prose can be improved:

---- >8 ----

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/ad=
min-guide/sysctl/kernel.rst
index c2c64c1b706ff6..cdc5b75adb4633 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -1319,22 +1319,21 @@ split_lock_mitigate (x86 only)
=20
 On x86, each "split lock" imposes a system-wide performance penalty. On la=
rger
 systems, large numbers of split locks from unprivileged users can result in
-denials of service to well-behaved and potentially more important users.
+denials of service attack.
=20
-The kernel mitigates these bad users by detecting split locks and imposing
+The kernel mitigates that condition by detecting split locks and imposing
 penalties: forcing them to wait and only allowing one core to execute split
 locks at a time.
=20
-These mitigations can make those bad applications unbearably slow. Setting
-split_lock_mitigate=3D0 may restore some application performance, but will=
 also
-increase system exposure to denial of service attacks from split lock user=
s.
+These mitigations can make applications which rely on split locks unbearab=
ly
+slow. Setting split_lock_mitigate=3D0 may restore performance, but will al=
so
+increase likelihood of DoS caused by split locks.
=20
-=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-0 Disable the mitigation mode - just warns the split lock on kernel log
-  and exposes the system to denials of service from the split lockers.
-1 Enable the mitigation mode (this is the default) - penalizes the split
-  lockers with intentional performance degradation.
-=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+0 Disable the mitigation - just warns the split lock on kernel log.
+1 Enable the mitigation (default) - penalizes the split lockers with
+  intentional performance degradation.
+=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
=20
 stack_erasing

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--xfEdKcxEziDo6DYw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1dcCQAKCRD2uYlJVVFO
o+EtAP9+GTeOxlKLSNzv4wuEwiXF7IthCm5gIYEbzimGdYpnZAD+Mma/tg4Q/zsz
nTOX7YKvlDMna74Q1+RjoOqF/lvUtwI=
=Hrez
-----END PGP SIGNATURE-----

--xfEdKcxEziDo6DYw--

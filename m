Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA012646767
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 04:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiLHDA1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 22:00:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiLHC76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:59:58 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E7098969;
        Wed,  7 Dec 2022 18:59:44 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c7so202609pfc.12;
        Wed, 07 Dec 2022 18:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ufBqNuhKpdmINsIT2AuDETk3f8xiEIq/4Et5u9ZmeT0=;
        b=AJJuyEs8o3C+1ZzbTLOJxPFvfBHqcMYvVVU/Ze85J80RSvNEJC1tT7ibe/I8T77Zbv
         ttORwzcONAMqd0xaOsqUV1VVNlA7aj3PeZP8yQoU9bMZi/rc62YUGySRUxhxYTf++Lqf
         yxgjYXyNtcF59jLCnuJdiW7XWcghLxB5zKgum0yC7RVQrFPQ+Szx4UhBKGLajriFXl1w
         CLxkpIoP9ujp9t4tqkoqMo92eJ7YzkWQ5jKkKRnfDECJTmo6WGq/R6xzrXaMviEK+VMC
         SREDPH2FPkSK29Fujt5AtAOI/ZR5TQg1j2t3sqYhG0RnkFXptWWSXty6OEktwAr60lYn
         HsKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ufBqNuhKpdmINsIT2AuDETk3f8xiEIq/4Et5u9ZmeT0=;
        b=nJRDMCKJULEz1o15x3Pz67goG8+l7t3aOo+PBztybRTGfSWXKGpw6cC3mgejxLlIbo
         xnater/0USA649lH2DO3x5Ok+zqEKuZlLTywVIEzj/Noij7/+IjOKZAlEjJoIpK5srAs
         K3SDpZJubC7CYVZm8BQvt8LLdG7hOeJc1x/J0GHIks3/WpImb3p4gOIVRahNx4cRkCtZ
         Bb6kequu0b09HhEaGm6lXwYA+M0hN9YNQADZb+mb0UR5nd2XKyCsd4ix4JWMHQKc4O7C
         5hLav/CcQIWD8UQlggt+1fayrEqsvntEGe8ECXUI8q7gnZ/tKjO1NUCPNtZEz/up74nP
         Pz8g==
X-Gm-Message-State: ANoB5pmkGfYNsftYtZcfVY94i9BSyiwXLlaK8U75TbjofhxXXcR6d8jZ
        EVz0sCLqrzMXTMIhMGkZxb8=
X-Google-Smtp-Source: AA0mqf7ME3EwFa+0up66g1p7HCAw30RkByxDfhaWymUJP2UKE3ijU+vKE+UeTIt1uI4H6j7CSP65Nw==
X-Received: by 2002:a63:ea15:0:b0:457:7285:fd2d with SMTP id c21-20020a63ea15000000b004577285fd2dmr67222477pgi.580.1670468383924;
        Wed, 07 Dec 2022 18:59:43 -0800 (PST)
Received: from debian.me (subs02-180-214-232-5.three.co.id. [180.214.232.5])
        by smtp.gmail.com with ESMTPSA id c133-20020a621c8b000000b00575cdd7c0adsm14176211pfc.80.2022.12.07.18.59.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:59:43 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id B4C58104460; Thu,  8 Dec 2022 09:59:40 +0700 (WIB)
Date:   Thu, 8 Dec 2022 09:59:40 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wyes Karny <wyes.karny@amd.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Subject: Re: [PATCH 4/4] Documentation: amd_pstate: Add amd_pstate state
 sysfs file
Message-ID: <Y5FTHGsezkdzwvUa@debian.me>
References: <20221207154648.233759-1-wyes.karny@amd.com>
 <20221207154648.233759-5-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w3Iq/EiQLaZI2tbc"
Content-Disposition: inline
In-Reply-To: <20221207154648.233759-5-wyes.karny@amd.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w3Iq/EiQLaZI2tbc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:46:48PM +0000, Wyes Karny wrote:
> +``state``
> +
> +``amd_pstate`` also exposes a sysfs interface to view and control the dr=
iver state.
> +The driver state can be one of the following:
> +``disable``     : indicates driver is in unloaded state.
> +``passive``     : indicates driver is loaded and currently in passive mo=
de.
> +``guided`` : indicates driver is loaded and currenlty in guided autonomo=
us mode.

Use bullet lists for above:

---- >8 ----

diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/ad=
min-guide/pm/amd-pstate.rst
index 4d3783516ddc2c..0d0e0affa3adb2 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -269,9 +269,12 @@ Other performance and frequency values can be read bac=
k from
=20
 ``amd_pstate`` also exposes a sysfs interface to view and control the driv=
er state.
 The driver state can be one of the following:
-``disable``     : indicates driver is in unloaded state.
-``passive``     : indicates driver is loaded and currently in passive mode.
-``guided`` : indicates driver is loaded and currenlty in guided autonomous=
 mode.
+
+  - ``disable``     : indicates driver is in unloaded state.
+  - ``passive``     : indicates driver is loaded and currently in passive =
mode.
+  - ``guided``      : indicates driver is loaded and currenlty in guided
+    autonomous mode.
+
 This file can be found here: ``/sys/devices/system/cpu/amd_pstate/state``.
=20
 To switch to passive mode: ``echo passive > /sys/devices/system/cpu/amd_ps=
tate/state``

> +This file can be found here: ``/sys/devices/system/cpu/amd_pstate/state`=
`.
> +
> +To switch to passive mode: ``echo passive > /sys/devices/system/cpu/amd_=
pstate/state``
> +To switch to guided mode: ``echo guided > /sys/devices/system/cpu/amd_ps=
tate/state``
> =20

What about these wordings instead?

---- >8 ----
=20
diff --git a/Documentation/admin-guide/pm/amd-pstate.rst b/Documentation/ad=
min-guide/pm/amd-pstate.rst
index 4d3783516ddc2c..6465bd39b7dcbc 100644
--- a/Documentation/admin-guide/pm/amd-pstate.rst
+++ b/Documentation/admin-guide/pm/amd-pstate.rst
@@ -267,15 +267,16 @@ Other performance and frequency values can be read ba=
ck from
=20
 ``state``
=20
-``amd_pstate`` also exposes a sysfs interface to view and control the driv=
er state.
-The driver state can be one of the following:
-``disable``     : indicates driver is in unloaded state.
-``passive``     : indicates driver is loaded and currently in passive mode.
-``guided`` : indicates driver is loaded and currenlty in guided autonomous=
 mode.
-This file can be found here: ``/sys/devices/system/cpu/amd_pstate/state``.
+``amd_pstate`` also exposes a sysfs interface to view and control the driv=
er
+state, named ``/sys/devices/system/cpu/amd_pstate/state``. The driver state
+can be one of the following:
=20
-To switch to passive mode: ``echo passive > /sys/devices/system/cpu/amd_ps=
tate/state``
-To switch to guided mode: ``echo guided > /sys/devices/system/cpu/amd_psta=
te/state``
+  - ``disable``     : the driver is disabled
+  - ``passive``     : the driver is in passive mode.
+  - ``guided``      : the driver is in guided autonomous mode.
+
+To switch between these modes above, write the appropriate value to the
+aforementioned sysfs file.
=20
 ``amd-pstate`` vs ``acpi-cpufreq``
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--w3Iq/EiQLaZI2tbc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5FTFwAKCRD2uYlJVVFO
o7/DAQDPXGzLP5B1ne8T+5hevkqKMCiwgB/oB/HYAhJZ1jExZwD9HbebcQeg02sU
qzgZxy4OPhhoERSe5BwnLYt0kWYvJgk=
=x2DH
-----END PGP SIGNATURE-----

--w3Iq/EiQLaZI2tbc--

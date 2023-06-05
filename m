Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBAC721CC4
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjFEEE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:04:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFEEEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:04:53 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 007E9A6;
        Sun,  4 Jun 2023 21:04:50 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-558cf19575dso438021eaf.3;
        Sun, 04 Jun 2023 21:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685937890; x=1688529890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BejdeN65cIxZZ5H8/q76yXRvLbBZnUEUFMfNrLcKLjg=;
        b=kYL6+WZlXbw3DT9neTHAET6dXWiNQL8onDCOQ9SJl9YmG/CRUpCkqb5z+fbPDO5YWv
         3SrO5oH2K5txcuk0sVefNap9Qo8hVFk0My2R+oi1wO+bY9Nc+xo9u7BXo5aA9DOD1khh
         U+fSd/xsU9IH4D8jY3VIIdOaYfF64MqUdDLdobLoGsAd8ofHmvsUi2joDiHxy7pZGMri
         zytRXdtDbgDHZUyncrOB7RG6cGTdT7rSkMkWQu03zE+VXcuTHidvSlI6lVkeGY6Qo+Ve
         ngmyvs6X63aR7/oDLWetxeSaMVj5H2oHAhdvZekrSN9ljgQH5GXclh3TbhEEjdumCBh0
         BJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685937890; x=1688529890;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BejdeN65cIxZZ5H8/q76yXRvLbBZnUEUFMfNrLcKLjg=;
        b=SPnsv/+59NQebjKSzVQ+n/dfwT1+wdyU63FwuCIVpN0zor82lhFPK8ObwUHG81sJT2
         SyoBtksk5pWq4HLrqIuzTUcFK/rySt25JBaUYOBpQFoAIDE5MkPut0TzJBoOQxkXuGAZ
         BhPTCe9CzxN5txhJGCdiABWHf/xeQI+U39L4oeDPsILyLQOaX6kJGwtUuaOQY2JKbYEp
         igSAY7Gf7CI3j7Npk0XoXXr1026daKLEjyFAooecrOAMvFFouUT2F9gSZNNnXh4bLRQB
         fCY+9IUGjqbrxJjrFBB5OCoRVQ7NwhZbJHdQv8+ZR96L8a/twJJ9FzjCjClSKVl72+BD
         0gJQ==
X-Gm-Message-State: AC+VfDyn/nl8+MoS2vRpqcAKhkzRJhuvKLcg1b9J1RPQ3cXvfQh2Sw5D
        +03qEMKcoLS4duDwD1bWYWc=
X-Google-Smtp-Source: ACHHUZ7xQ5UHuNXVnYA+wIKMpVoBYfIiAikygCaqkhkFI66OzcXP9cGpWXKdLNFGAY0N/Fea6VtlXQ==
X-Received: by 2002:a05:6358:8a5:b0:125:8fac:399f with SMTP id m37-20020a05635808a500b001258fac399fmr25174485rwj.17.1685937889921;
        Sun, 04 Jun 2023 21:04:49 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id n19-20020aa78a53000000b0065017055cb4sm4223079pfa.203.2023.06.04.21.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jun 2023 21:04:49 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id A1EF0106291; Mon,  5 Jun 2023 11:04:46 +0700 (WIB)
Date:   Mon, 5 Jun 2023 11:04:46 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>, linux@armlinux.org.uk,
        gregkh@linuxfoundation.org, jirislaby@kernel.org, corbet@lwn.net
Cc:     rdunlap@infradead.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, xy521521@gmail.com,
        oe-kbuild-all@lists.linux.dev, lkp@intel.com,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3 -next] tty: serial: add panic serial helper
Message-ID: <ZH1e3tuuie3bGhPj@debian.me>
References: <20230605015957.730085-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BFv1gQA3P/g+VqqO"
Content-Disposition: inline
In-Reply-To: <20230605015957.730085-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BFv1gQA3P/g+VqqO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2023 at 09:59:57AM +0800, Hongyu Xie wrote:
> Tested on an arm64 device.

Tested on what device?

> diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentat=
ion/dev-tools/panic_serial_helper.rst
> new file mode 100644
> index 000000000000..fc5b6e9103bc
> --- /dev/null
> +++ b/Documentation/dev-tools/panic_serial_helper.rst

The file name convention is using hyphens (like
panic-serial-helper.rst).

The wording below really confuses me, but I try my best reviewing here.

> @@ -0,0 +1,148 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +Using panic serial helper to get kernel logs after panic
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> +
> +:Author: Hongyu Xie <xiehongyu1@kylinos.cn>
> +
> +What is this?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +A debug module inspired by kgdboc that allows you to get all kernel logs
> +after panic.
> +
> +When do you need it and why?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> +
> +When
> +--------------
> +
> +Didn't enable debugging tool like Kdump and didn't connect a USB-to-UART
> +tool to the debug UART port on your PC before panic.

This section is unnecessary.

> +
> +Why
> +--------------
> +
> +There are many debugging methods to know what was going on before panic.
> +
> +Kdump, for example. If Kdump is enabled, you can get a core image after
"The first is Kdump. When it is enabled, ... . Then you can use GDB ..."
> +panic. Then use GDB or Crash to debug that core image to know what happe=
ned
> +before panic (see ``Documentation/admin-guide/kdump/kdump.rst`` for more
> +information about Kdump).
"(see ``Documentation/admin-guide/kdump/kdump.rst for Kdump
documentation)."
> +
> +Another way is to connect the UART side of a USB-to-UART tool to the
> +debugging UART port (normally a 3 pin slot on the motherborad or a RS232
> +port on the back panel of your PC) before panic happens. Then connect the
> +USB side of a USB-to-UART tool to another PC. You can read all the kernel
> +logs coming from that UART port through apps like minicom on another PC.
> +So when panic happens you'll know what was going on.
> +
> +What if Kdump hasn't been enabled? And in production environment you don=
't
> +always connect a USB-to-UART tool before panic happens.

"... And yet the panic happens in production where you don't have access
to USB-to-UART device?"

> +
> +So if Kdump is not enabled, you can use this module to get all the kernel
> +logs if this module is loaded prior to the panic.

"For both situations, you can use panic_serial_helper module to get all nec=
cessary kernel logs once it is loaded."

> +
> +How to use it?
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Prerequisites
> +--------------
> +
> +1. Same as kgdboc, the UART driver must implement two callbacks in the
> +struct uart_ops. See ``Documentation/dev-tools/kgdb.rst`` section
> +``kgdboc and uart_ops``
> +
> +2. Your PC has an UART port and it's working.
> +
> +How
> +--------------
> +
> +First you need to enable ``CONFIG_PANIC_SERIAL_HELPER`` in your
> +config. To enable ``CONFIG_PANIC_SERIAL_HELPER`` you should look under
"To enable it, go to ..."
> +:menuselection:`Device Drivers-->Character devices-->Enable TTY (TTY [=
=3Dy])-->Serial drivers`
> +and select :menuselection:`debug through UART after panic`.
> +
> +Second, build and update the kernel image. Then wait for panic.
"Then build and deploy the kernel as usual."
> +
> +After panic, you need to do the following,
"When the panic occurs, you need to do the following:"
> +1. connect the UART side of an USB-to-UART tool to any UART
> +port on your device (PC, server, Laptop, etc...).
> +Connect the USB side of that tool to another PC. Open
> +minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
> +"/dev/ttyUSB1 if there is already another USB-to-UART tool
> +connected to your device) with "115200 8N1".
> +
> +It automatically selects the port where you first press the
> +"Enter" key (some keyboard labeled this with "Return").
> +
> +2. press "Enter" (or "Return") in that
> +minicom window; you'll get a help menu:
"Press Enter and the help menu will appear."
> +help:::
> +
> +    -a      show all kernel msg
> +
> +    -3      show S3 msg
> +
> +    -4      show S4 msg
> +
> +    -filter-[string]        show msg containing [string]
> +
> +    -q-     quit
> +
> +see ``Help menu options`` for details.
> +
> +3. finally, type 'a', '3', '4', 'q' or "filter-xxx" then press
> +"Enter" to get what you want.

Do I have to pass ``-a`` or ``a``? Or is it command-line program or TUI
interface?

Anyway,

"3. Select one of above options and happy hacking!"

> +
> +Help menu options
> +-----------------
> +Available options:
> +
> + - a
> +
> +   Show all the messages starting from ``Booting Linux on ...``
> +
> + - 3
> +
> +   If STR happened before panic, this will show messages starting from
> +   ``PM: suspend entry...``
> +
> + - 4
> +
> +   If STD happened before panic, this will show messages starting from
> +   ``PM: hibernation entry...``
> +
> + - filter-[string]
> +
> +   Provide case-ignored filter matching. Only show messages that contain=
ing
> +   ``string``. For example, if you're only interesting in message lines
> +   that containing ``CPU`` or ``cpu``, you just input
> +   ``filter-CPU`` or ``filter-cpu``.
> +   Here is an output example for filtering ``CPU``::
"For example, if you'd like to see message lines that contain ``CPU`` or
``cpu``, you can pass either ``filter-CPU`` or ``filter-cpu``. The
corresponding output would be like::"
> +
> +   <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6=
633
> +   <6>[    0.000000] Detected PIPT I-cache on CPU0
> +   <6>[    0.000000] CPU features: detected: Kernel page table isolation=
 (K
> +
> +   ...
> +
> +   <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0=
000
> +   <6>[    0.002411] smp: Bringing up secondary CPUs ...
> +   <6>[    0.039105] Detected PIPT I-cache on CPU1
> +
> +   ...
> +
> +   <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
> +   <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
> +
> +   ...
> +
> +   <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
> +   <2>[  225.297909] SMP: stopping secondary CPUs
> +   <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
> +
> + - q
> +
> +  Return to help menu.

The doc syntax looks messy, so I have to fix it up:

---- >8 ----
diff --git a/Documentation/dev-tools/panic_serial_helper.rst b/Documentatio=
n/dev-tools/panic_serial_helper.rst
index fc5b6e9103bc2d..1ed841d03ab1c2 100644
--- a/Documentation/dev-tools/panic_serial_helper.rst
+++ b/Documentation/dev-tools/panic_serial_helper.rst
@@ -28,7 +28,7 @@ There are many debugging methods to know what was going o=
n before panic.
=20
 Kdump, for example. If Kdump is enabled, you can get a core image after
 panic. Then use GDB or Crash to debug that core image to know what happened
-before panic (see ``Documentation/admin-guide/kdump/kdump.rst`` for more
+before panic (see Documentation/admin-guide/kdump/kdump.rst for more
 information about Kdump).
=20
 Another way is to connect the UART side of a USB-to-UART tool to the
@@ -51,8 +51,7 @@ Prerequisites
 --------------
=20
 1. Same as kgdboc, the UART driver must implement two callbacks in the
-struct uart_ops. See ``Documentation/dev-tools/kgdb.rst`` section
-``kgdboc and uart_ops``
+   struct uart_ops. See Documentation/dev-tools/kgdb.rst for details.
=20
 2. Your PC has an UART port and it's working.
=20
@@ -66,20 +65,20 @@ and select :menuselection:`debug through UART after pan=
ic`.
=20
 Second, build and update the kernel image. Then wait for panic.
=20
-After panic, you need to do the following,
+After panic, you need to do the following:
+
 1. connect the UART side of an USB-to-UART tool to any UART
-port on your device (PC, server, Laptop, etc...).
-Connect the USB side of that tool to another PC. Open
-minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
-"/dev/ttyUSB1 if there is already another USB-to-UART tool
-connected to your device) with "115200 8N1".
+   port on your device (PC, server, Laptop, etc...).
+   Connect the USB side of that tool to another PC. Open
+   minicom (or other app) on that PC, and set "/dev/ttyUSB0"(or
+   "/dev/ttyUSB1 if there is already another USB-to-UART tool
+   connected to your device) with "115200 8N1".
=20
-It automatically selects the port where you first press the
-"Enter" key (some keyboard labeled this with "Return").
+   It automatically selects the port where you first press the
+   "Enter" key (some keyboard labeled this with "Return").
=20
-2. press "Enter" (or "Return") in that
-minicom window; you'll get a help menu:
-help:::
+2. press "Enter" (or "Return") in that minicom window; you'll get a help m=
enu
+   like::
=20
     -a      show all kernel msg
=20
@@ -94,7 +93,7 @@ help:::
 see ``Help menu options`` for details.
=20
 3. finally, type 'a', '3', '4', 'q' or "filter-xxx" then press
-"Enter" to get what you want.
+   "Enter" to get what you want.
=20
 Help menu options
 -----------------
@@ -122,27 +121,27 @@ Available options:
    ``filter-CPU`` or ``filter-cpu``.
    Here is an output example for filtering ``CPU``::
=20
-   <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6633
-   <6>[    0.000000] Detected PIPT I-cache on CPU0
-   <6>[    0.000000] CPU features: detected: Kernel page table isolation (K
+     <6>[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x701f6=
633
+     <6>[    0.000000] Detected PIPT I-cache on CPU0
+     <6>[    0.000000] CPU features: detected: Kernel page table isolation=
 (K
=20
-   ...
+     ...
=20
-   <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0000
-   <6>[    0.002411] smp: Bringing up secondary CPUs ...
-   <6>[    0.039105] Detected PIPT I-cache on CPU1
+     <6>[    0.000000] GICv3: CPU0: using allocated LPI pending table @0x0=
000
+     <6>[    0.002411] smp: Bringing up secondary CPUs ...
+     <6>[    0.039105] Detected PIPT I-cache on CPU1
=20
-   ...
+     ...
=20
-   <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
-   <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
+     <4>[    6.432129] CPU: 3 PID: 392 Comm: (crub_all) Tainted: G        W
+     <4>[    6.560279] CPU: 2 PID: 478 Comm: (ostnamed) Tainted: G        W
=20
-   ...
+     ...
=20
-   <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
-   <2>[  225.297909] SMP: stopping secondary CPUs
-   <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
+     <4>[  225.297828] CPU: 4 PID: 0 Comm: swapper/4 Tainted: G        W
+     <2>[  225.297909] SMP: stopping secondary CPUs
+     <0>[  225.297919] CPU features: 0x000000,02000800,0400421b
=20
  - q
=20
-  Return to help menu.
+   Return to help menu.

Then apply my wording improves on top of above diff.

> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 3e3fb377d90d..86a2c1884b04 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -198,6 +198,31 @@ config SERIAL_KGDB_NMI
> =20
>  	  If unsure, say N.
> =20
> +config PANIC_SERIAL_HELPER
> +	tristate "debug through UART after panic"
> +	depends on PANIC_TIMEOUT=3D0
> +	select CONSOLE_POLL
> +	help
> +	  This is a debug module that allows you to get all kernel logs
> +	  after panic.
> +
> +	  Normally you need to attach a USB-to-UART tool or enable kdump
> +	  before panic happens to get log from kernel after panic. If you
> +	  didn't do that and kdump is not working, you can't get any log to
> +	  know what happened before panic. If you have a USB-to-UART tool
> +	  and the UART port on your computer is working, this module helps
> +	  you to get all kernel log after panic() is called.
> +
> +	  This module uses serial port in poll mode, so it's more stable
> +	  than other debugging methods.
> +
> +	  Read <file:Documentation/dev-tools/panic_serial_helper.rst> for
> +	  usage.
> +
> +	  Say Y if you have an UART port that is working. If unsure, say N.
> +	  Say M if you want add this as a module driver.
"Say Y if you have a working UART port and you want to gather kernel
logs. To compile this as module (which will be called panic_serial_helper),
say M. If unsure, say N."

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--BFv1gQA3P/g+VqqO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZH1e1wAKCRD2uYlJVVFO
o+TpAQCsMnMPIL59p67dbqDE9czzcxu+Q+IgBPvP5Z/OJuNSegD9Hv5a3dQJQGcr
LXzMdtJCndinoo0f1zIemWztrhuPxww=
=VzBO
-----END PGP SIGNATURE-----

--BFv1gQA3P/g+VqqO--

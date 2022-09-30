Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453C55F078F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 11:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiI3J2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 05:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiI3J2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 05:28:11 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F01E319C;
        Fri, 30 Sep 2022 02:28:03 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id d1-20020a17090a6a4100b002095b319b9aso2588909pjm.0;
        Fri, 30 Sep 2022 02:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=3IXMulE4oFMGsJB0VDcz6W+21SMNhKUHzpPjIK+JEMc=;
        b=YLOneGW8Z02gT3eKcFzrAOlWOgEd5Jv6jNt2xbYgjz1qZmSvfcmi1WCtdw9DbxQKTd
         USUmM7C6VJ6AVyHhRAdWm/lubv8yu7b2c4ZVtRO4Vi/AxVtZs9z986+vbWDnK64I5fGt
         RDGhXk38uOujQfpoFno9ic7j4mNQ/ljrLsvckqXjS2M6x3qjO6LeF6cvMq5W3+hFCfoJ
         gDqH+p9tX1Qu0DrAtakDYGsFRoTu/w7EGxwXNpAwIZ3nDj+RPU8RdD1UZSbtCWAzKY/X
         II5is/EG3kM6IhDz7KDkwxGjpS5qJzxLSacdkptY0o+WCORfOmCTEa+NwcSX4eH3acyF
         HnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=3IXMulE4oFMGsJB0VDcz6W+21SMNhKUHzpPjIK+JEMc=;
        b=tINqrsLWiOZHG8g/E8MaWo8bpGzAyglLfIhQkSb4bAn/wa+UM1WY9FZ9AreV7mnBCO
         PJbeQVz6KY0FknYtUZkYz/579kyJuQpIq23LzpVyfo8LRepPsFc0eB9IUa9YF+pI8JkY
         gl2rfa7u/b4NUl3af2YJqOXdqTNAnKAtoMdgXhmpP618QRRSp/BsQjYvfYLW35s2lq6O
         Ly+2v3h3B7kHgF55GVl8O9Lg2/G64x8YPtDJMsMPUqSIe0s8ptbTDEDbeg5H1PSfDRtL
         IWE+0lDB5niPDPMCuZMcmf08NlYjt6QRoNgawKg6QHD/S8fEISZ5M9UmUYkOPpiraI6n
         0p9Q==
X-Gm-Message-State: ACrzQf105eDLbOwPRiwEbJ37eznl4jShKPyixljOxTcSRVmm+EWnvcPB
        RMdOWmKzwRzcUcou2v9CVwk=
X-Google-Smtp-Source: AMsMyM5tqchW9FvTPDXBlJifjVF8ehV7gN5OeYKFlTPY4u2M6ro5MhWj/+kT3X5fI0yLOWlUZiOZWA==
X-Received: by 2002:a17:902:76c7:b0:178:ab0a:19af with SMTP id j7-20020a17090276c700b00178ab0a19afmr7872056plt.164.1664530082627;
        Fri, 30 Sep 2022 02:28:02 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-35.three.co.id. [116.206.28.35])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902714c00b00178323e689fsm1384487plm.171.2022.09.30.02.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 02:28:01 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id EA57B1005BB; Fri, 30 Sep 2022 16:27:57 +0700 (WIB)
Date:   Fri, 30 Sep 2022 16:27:57 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] serial: Convert serial_rs485 to kernel doc
Message-ID: <Yza2nRxJ6MXWy/xa@debian.me>
References: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
 <20220929093148.9468-2-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tzHsB+Sj21QVvgtY"
Content-Disposition: inline
In-Reply-To: <20220929093148.9468-2-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tzHsB+Sj21QVvgtY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 29, 2022 at 12:31:45PM +0300, Ilpo J=C3=A4rvinen wrote:
> diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documenta=
tion/driver-api/serial/serial-rs485.rst
> index 6ebad75c74ed..264e4b753713 100644
> --- a/Documentation/driver-api/serial/serial-rs485.rst
> +++ b/Documentation/driver-api/serial/serial-rs485.rst
> @@ -29,11 +29,11 @@ RS485 Serial Communications
>  3. Data Structures Already Available in the Kernel
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> =20
> -   The Linux kernel provides the serial_rs485 structure (see [1]) to han=
dle
> -   RS485 communications. This data structure is used to set and configur=
e RS485
> +   The Linux kernel provides the serial_rs485 structure to handle RS485
> +   communications. This data structure is used to set and configure RS485
>     parameters in the platform data and in ioctls.
> =20
> -   The device tree can also provide RS485 boot time parameters (see [2]
> +   The device tree can also provide RS485 boot time parameters (see [1]
>     for bindings). The driver is in charge of filling this data structure=
 from
>     the values given by the device tree.
> =20
> @@ -47,6 +47,9 @@ RS485 Serial Communications
>     for the uart_port. TIOCGRS485 ioctl can be used to read back the
>     serial_rs485 structure matching to the current configuration.
> =20
> +.. kernel-doc:: include/uapi/linux/serial.h
> +   :identifiers: serial_rs485
> +
>  4. Usage from user-level
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> @@ -126,6 +129,4 @@ RS485 Serial Communications
>  6. References
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> - [1]	include/uapi/linux/serial.h
> -
> - [2]	Documentation/devicetree/bindings/serial/rs485.txt
> + [1]	Documentation/devicetree/bindings/serial/rs485.txt

For formatting consistency with kernel-doc comment of the struct below,
the code keywords should be in inline code samples:

---- >8 ----
diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentati=
on/driver-api/serial/serial-rs485.rst
index e53aa291bcd7df..3d48c8b5a3e6f8 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -39,15 +39,15 @@ RS485 Serial Communications
    uart_get_rs485_mode().
=20
    Any driver for devices capable of working both as RS232 and RS485 should
-   implement the rs485_config callback and provide rs485_supported in the
-   struct uart_port. The serial core calls rs485_config to do the device
-   specific part in response to TIOCSRS485 ioctl (see below). The
-   rs485_config callback receives a pointer to a sanitizated struct
+   implement the ``rs485_config`` callback and provide ``rs485_supported``=
 in
+   the ``struct uart_port``. The serial core calls ``rs485_config`` to do =
the
+   device specific part in response to TIOCSRS485 ioctl (see below). The
+   ``rs485_config`` callback receives a pointer to a sanitizated struct
    serial_rs485. The struct serial_rs485 userspace provides is sanitized
-   before calling rs485_config using rs485_supported that indicates what
-   RS485 features the driver supports for the struct uart_port. TIOCGRS485
-   ioctl can be used to read back the struct serial_rs485 matching to the
-   current configuration.
+   before calling ``rs485_config`` using ``rs485_supported`` that indicates
+   what RS485 features the driver supports for the struct uart_port.
+   TIOCGRS485 ioctl can be used to read back the struct serial_rs485 match=
ing
+   to the current configuration.
=20
 .. kernel-doc:: include/uapi/linux/serial.h
    :identifiers: serial_rs485 uart_get_rs485_mode
@@ -108,23 +108,26 @@ RS485 Serial Communications
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
    The Linux kernel provides addressing mode for multipoint RS-485 serial
-   communications line. The addressing mode is enabled with SER_RS485_ADDRB
+   communications line. The addressing mode is enabled with ``SER_RS485_AD=
DRB``
    flag in struct serial_rs485. The struct serial_rs485 has two additional
    flags and fields for enabling receive and destination addresses.
=20
    Address mode flags:
-	- SER_RS485_ADDRB: Enabled addressing mode (sets also ADDRB in termios).
-	- SER_RS485_ADDR_RECV: Receive (filter) address enabled.
-	- SER_RS485_ADDR_DEST: Set destination address.
=20
-   Address fields (enabled with corresponding SER_RS485_ADDR_* flag):
-	- addr_recv: Receive address.
-	- addr_dest: Destination address.
+	- ``SER_RS485_ADDRB``: Enabled addressing mode (sets also ADDRB in
+          termios).
+	- ``SER_RS485_ADDR_RECV``: Receive (filter) address enabled.
+	- ``SER_RS485_ADDR_DEST``: Set destination address.
+
+   Address fields (enabled with corresponding ``SER_RS485_ADDR_*`` flag):
+
+	- ``addr_recv``: Receive address.
+	- ``addr_dest``: Destination address.
=20
    Once a receive address is set, the communication can occur only with the
    particular device and other peers are filtered out. It is left up to the
    receiver side to enforce the filtering. Receive address will be cleared
-   if SER_RS485_ADDR_RECV is not set.
+   if ``SER_RS485_ADDR_RECV`` is not set.
=20
    Note: not all devices supporting RS485 support multipoint addressing.
=20

> diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
> index cea06924b295..4634c913f16a 100644
> --- a/include/uapi/linux/serial.h
> +++ b/include/uapi/linux/serial.h
> @@ -107,33 +107,50 @@ struct serial_icounter_struct {
>  	int reserved[9];
>  };
> =20
> -/*
> +/**
> + * struct serial_rs485 - serial interface for controlling RS485 settings.
> + * @flags:			RS485 feature flags.
> + * @delay_rts_before_send:	Delay before send (milliseconds).
> + * @delay_rts_after_send:	Delay after send (milliseconds).
> + * @addr_recv:			Receive filter for RS485 addressing mode
> + *				(used only when %SER_RS485_ADDR_RECV is set).
> + * @addr_dest:			Destination address for RS485 addressing mode
> + *				(used only when %SER_RS485_ADDR_DEST is set).
> + * @padding0:			Padding (set to zero).
> + * @padding1:			Padding (set to zero).
> + * @padding:			Deprecated, use @padding0 and @padding1 instead.
> + *				Do not use with @addr_recv and @addr_dest (due to
> + *				overlap).
> + *
>   * Serial interface for controlling RS485 settings on chips with suitable
>   * support. Set with TIOCSRS485 and get with TIOCGRS485 if supported by =
your
>   * platform. The set function returns the new state, with any unsupporte=
d bits
>   * reverted appropriately.
> + *
> + * serial_rs485::flags bits are:
> + *

Maybe better say "The flag bits are:"?

> + * * %SER_RS485_ENABLED		- RS485 enabled.
> + * * %SER_RS485_RTS_ON_SEND	- Logical level for RTS pin when sending.
> + * * %SER_RS485_RTS_AFTER_SEND	- Logical level for RTS pin after sent.
> + * * %SER_RS485_RX_DURING_TX	- Full-duplex RS485 line.
> + * * %SER_RS485_TERMINATE_BUS	- Enable bus termination (if supported).
> + * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
> + * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv).=
 Requires %SER_RS485_ADDRB.
> + * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Re=
quires %SER_RS485_ADDRB.
>   */
> -
>  struct serial_rs485 {
> -	__u32	flags;			/* RS485 feature flags */
> -#define SER_RS485_ENABLED		(1 << 0)	/* If enabled */
> -#define SER_RS485_RTS_ON_SEND		(1 << 1)	/* Logical level for
> -							   RTS pin when
> -							   sending */
> -#define SER_RS485_RTS_AFTER_SEND	(1 << 2)	/* Logical level for
> -							   RTS pin after sent*/
> +	__u32	flags;
> +#define SER_RS485_ENABLED		(1 << 0)
> +#define SER_RS485_RTS_ON_SEND		(1 << 1)
> +#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
>  #define SER_RS485_RX_DURING_TX		(1 << 4)
> -#define SER_RS485_TERMINATE_BUS		(1 << 5)	/* Enable bus
> -							   termination
> -							   (if supported) */
> -
> -/* RS-485 addressing mode */
> -#define SER_RS485_ADDRB			(1 << 6)	/* Enable addressing mode */
> -#define SER_RS485_ADDR_RECV		(1 << 7)	/* Receive address filter */
> -#define SER_RS485_ADDR_DEST		(1 << 8)	/* Destination address */
> +#define SER_RS485_TERMINATE_BUS		(1 << 5)
> +#define SER_RS485_ADDRB			(1 << 6)
> +#define SER_RS485_ADDR_RECV		(1 << 7)
> +#define SER_RS485_ADDR_DEST		(1 << 8)
> =20
> -	__u32	delay_rts_before_send;	/* Delay before send (milliseconds) */
> -	__u32	delay_rts_after_send;	/* Delay after send (milliseconds) */
> +	__u32	delay_rts_before_send;
> +	__u32	delay_rts_after_send;
> =20
>  	/* The fields below are defined by flags */
>  	union {

All struct members are described in htmldocs output, thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--tzHsB+Sj21QVvgtY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYza2lgAKCRD2uYlJVVFO
o2cZAQDE3tRS/nbiVvgR9eWjEEXbu5ozDBpWZf/ULFFvdygNXgD+LXn3FlB5jZx+
GEJ8TJwz3a75J120ey+R3f9gCNJC7wI=
=fkEH
-----END PGP SIGNATURE-----

--tzHsB+Sj21QVvgtY--

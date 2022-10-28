Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE7A610B75
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 09:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiJ1Hla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 03:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJ1HlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 03:41:17 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94E31B4C5E
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:41:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id 192so4156924pfx.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 00:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nZcVVJXKTudcoaW1Xnbq9pVmL+jhwnIjYb5pjiAaeoA=;
        b=QaXhQr7GVmG5cXT3xnRLXJMwMfritNwyKut8TX/b+3+SMMuVyy1s5IKBWNANIpT8w/
         aGx1CRVj7MR8Hz+CNU9CkPqF3TjoL3yChYRfXvbUCDc+aNIsW+xRcNd2lREvOa/+AZMs
         MS0Zl6Opbc8GriOEpfGXSfk8LTLtGLGThCnhdjxvn4aknIGNErqGd0O0NFTg2spAmxJO
         90tBe5AbaYRvAegmHdj3D/EKq9nPWrcadb9jPwhCBQnEsEr/vwj/cwGXSnamBehP/tyG
         0egUXidjWo5N+DplZfc8r7wIc2HLnxNICeQ85JPHVQzYFN7AVJgN/2/oNN0xQ/4xo7EH
         rfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZcVVJXKTudcoaW1Xnbq9pVmL+jhwnIjYb5pjiAaeoA=;
        b=Jzsuy2U34BeGVPgvofpJl3435YutCn1yRLM6DslqxSCOWF3MM6q58cIMVpvdur204e
         m7YXQwMqUniu8s0iBZRnxsDV/iQ9KOSlFOfWIcjwv9QKU/a4OWWNcVx12KNE4mUwSF5c
         d/uuX3Sj7zusl24v65eSXcIDm6o9u8YI8vCxWZ+NaWov9H/lIAzA3LmvY5DOkCgDyz+v
         QUFxe5qlqhHkm+JNfMeX9nIseibRcLsTgs/bKOlxLgE2pe/XgPAW5hX1xh2nwDXhQTwF
         oBs36eE4UpRppaXT5V2/7eNcjWYDYAni2itBZV+oJxATsvbrPv6+qaKiqeZXv8i4ePjC
         40/w==
X-Gm-Message-State: ACrzQf299MtTrEM0U+DSTnf26B7UjeRI/Yd54xOhOB3PgThOZIiJtoIx
        VnQEWO60mDjA7e5Yche10DE=
X-Google-Smtp-Source: AMsMyM6uGmuwwathfUeizITkDy/6ZqZ8PnQv1b/pvPaOhTv12ET7Tgufmbiy+GBk3WfsTUx64ZAkzw==
X-Received: by 2002:a63:2b53:0:b0:439:34d9:5d47 with SMTP id r80-20020a632b53000000b0043934d95d47mr44910652pgr.283.1666942876329;
        Fri, 28 Oct 2022 00:41:16 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-85.three.co.id. [180.214.233.85])
        by smtp.gmail.com with ESMTPSA id k137-20020a62848f000000b0056bb21cd7basm2303639pfd.51.2022.10.28.00.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 00:41:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5396810411D; Fri, 28 Oct 2022 14:41:12 +0700 (WIB)
Date:   Fri, 28 Oct 2022 14:41:11 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     UMWARI JOVIAL <umwarijovial@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy@lists.linux.dev
Subject: Re: [PATCH]  Possible repeated word: 'very'
Message-ID: <Y1uHl4di6R0pFA/i@debian.me>
References: <20221028070439.GA36889@rdm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5AHVENxkMm6djXWN"
Content-Disposition: inline
In-Reply-To: <20221028070439.GA36889@rdm>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5AHVENxkMm6djXWN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 28, 2022 at 10:04:39AM +0300, UMWARI JOVIAL wrote:
> Reported By checkpatch.pl script
>=20
> WARNING: Possible repeated word: 'very'
>=20
> Repetition of the same word in one sentence same line
>=20
> Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> ---
>  drivers/staging/rtl8712/rtl871x_xmit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/rtl8712/rtl871x_xmit.c b/drivers/staging/rtl=
8712/rtl871x_xmit.c
> index 090345bad223..30a0276b8b58 100644
> --- a/drivers/staging/rtl8712/rtl871x_xmit.c
> +++ b/drivers/staging/rtl8712/rtl871x_xmit.c
> @@ -766,7 +766,7 @@ void r8712_free_xmitbuf(struct xmit_priv *pxmitpriv, =
struct xmit_buf *pxmitbuf)
>   * If we turn on USE_RXTHREAD, then, no need for critical section.
>   * Otherwise, we must use _enter/_exit critical to protect free_xmit_que=
ue...
>   *
> - * Must be very very cautious...
> + * Must be very cautious...
>   *
>   */
>  struct xmit_frame *r8712_alloc_xmitframe(struct xmit_priv *pxmitpriv)

NAK!

You send patch with the same content as [1], for which Greg already replied
as [2].

The code and its comments imply that calling r8712_alloc_xmitframe() must be
done with extreme caution, isn't it?

Thanks.

[1]: https://lore.kernel.org/lkml/20221028051420.GA30073@rdm/
[2]: https://lore.kernel.org/lkml/Y1tx8XjmR5QKV9lQ@kroah.com/
--=20
An old man doll... just what I always wanted! - Clara

--5AHVENxkMm6djXWN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY1uHkgAKCRD2uYlJVVFO
ozJfAP98k83IoBbLOqKYVGBcCIKTV1wDGbH2y5M14189nsgH0QD6AzbdUjKDI/UW
jvhe3t0vTOYRclrj8RRDIG2ttn2iNQQ=
=jU/M
-----END PGP SIGNATURE-----

--5AHVENxkMm6djXWN--

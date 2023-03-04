Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A82AE6AAC46
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjCDT6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:58:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjCDT6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:58:51 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70ABCF96A
        for <linux-kernel@vger.kernel.org>; Sat,  4 Mar 2023 11:58:50 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id nv15so4056357qvb.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Mar 2023 11:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677959929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=q63Ai1i/9UPUOlnOyilqU1QWRHEjKtIUl21gSmzfwj0=;
        b=qtYu46HJFLXbZY5dV68LdXYCHvbl4UgtutL5ldkp8ASsZBTzmfMFIXc4zI2dfExpN0
         YVtY7R8Fp4GTiZX7xvbLF7oc29Z9cLA6Q/qB7cQ31wBipkuFnw2nH1oc1eEj8mQdK9Qi
         nPFIN6msNwg11Lp9J1AuCmNUHDQBVWtqOpN5Q/sV5vTdSt5q8K6U3IL4sj7g4jF/9HjD
         gxa1EV6t2JdcExsz9n3dAdU4VeVFWGlM0zwRv6hGZsN+beH13nHcrrs5qbr4Ap+ztp4P
         ns483WTEvwgFI2+PoP2SKIZNehtlBiJ8UuI3Kkdbj4I3wXOIVrcfF+T8eZuXOg0fCLTW
         MbYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677959929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q63Ai1i/9UPUOlnOyilqU1QWRHEjKtIUl21gSmzfwj0=;
        b=eA01R0N2jsXc0xAMdk6sYmRawPpwe7UJpQ8jb5dcqzG8QkddiSGfn+p5iQOU0nvrjo
         0NxenqopHJdQLSv8UBJbPCQwnvxA1xbfkMP11B65Bj4fhwK4st1Ex2RqXD6tYf7Zd6cZ
         7Us/34lsbIyqT+EQzte/D51nvFTbN2c8tv86FsqpvstH27AXUKcB6HE3ijv+n3xZ2ect
         toWr6JwOpsk0/EDmp2JOc8SLhxL08rbJ2z5bCKioVkPk8X77X0qFbQMZqiSpzv/aerw0
         DWCA7Aej/fLA/ehdozn3ilth6oS61Tqu1UxIIJvnKZU4VDDvrCPic5n8Z4rD8MUXXDiv
         EkfQ==
X-Gm-Message-State: AO0yUKVv1LzsUU6YWzeAJPcb/3FvXJ80F3xIMR1+01QrTlgo1qwuVIBX
        9UeUJVo60SApG+9ZCDiRIeCHqLiKAog=
X-Google-Smtp-Source: AK7set8KlQ0XwcKdFVihnuD03zjT+6vDf6MpPWQQZNJAsmZ/W3wsRWi76P/igds+TaommT5I3inM2Q==
X-Received: by 2002:a05:6214:c46:b0:56e:aa11:daa3 with SMTP id r6-20020a0562140c4600b0056eaa11daa3mr9765239qvj.14.1677959929522;
        Sat, 04 Mar 2023 11:58:49 -0800 (PST)
Received: from hotmail.com ([137.118.186.11])
        by smtp.gmail.com with ESMTPSA id r3-20020ae9d603000000b007423a4ae27esm4291745qkk.12.2023.03.04.11.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 11:58:48 -0800 (PST)
Date:   Sat, 4 Mar 2023 14:58:46 -0500
From:   Storm Dragon <stormdragon2976@gmail.com>
To:     Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] vc_screen: don't clobber return value in vcs_read
Message-ID: <ZAOi9hDBTYqoAZuI@hotmail.com>
References: <Y/KtG9vK0oz0nQrN@hotmail.com>
 <20230220064612.1783-1-linux@weissschuh.net>
 <Y/OacHw6nL/ZtrH3@hotmail.com>
 <00e5aee7-c7b3-4077-8c9f-4f28ec220567@t-8ch.de>
 <ZAJqrfcfoM2eO5VL@mjollnir>
 <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nxu0+L+82/Uw6Rsy"
Content-Disposition: inline
In-Reply-To: <ce24d06b-7967-4b50-8913-ad42717e4c05@t-8ch.de>
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NO_RDNS_DOTCOM_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nxu0+L+82/Uw6Rsy
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2023 at 11:25:00PM +0000, Thomas Wei=C3=9Fschuh wrote:

>Does this mean the screenreader now works correctly or is it still
>broken somehow?
>
>Thomas

I have still been testing this kernel. Most things work as expected, but
the pasting functionality for Fenrir's clipboard is broken. After
checking into the problem, it seems that tiocsti is disabled, and that
is causing the problem. Was that something done in this test kernel
only, or will that be the default for all new Arch kernels? If it is the
default, is there a way to turn it back on? I tried the following:

[storm@mjollnir ~] $ sudo sysctl dev.tty.legacy_tiocsti=3D1
sysctl: setting key "dev.tty.legacy_tiocsti": Invalid argument

Thanks,
Storm

--nxu0+L+82/Uw6Rsy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEjjImGMhZhYoKESBfW+ojcUPdwZMFAmQDovMACgkQW+ojcUPd
wZP08hAAjuseTCmUJhs8OcS3scbgYFakLLEoIhn9HC29EoIBKUaOuXStMStkYXgf
9iZsgkpHXHK9j0gRNtMVutFV+Oi7jc0GXOOZh2ulPu/cTVdyt6QHbtaTDqOx/ewH
YY4qKiWdjcH5e3AuwSKLF7fRHNLcWRSVtIicpqGKi1PU3ogzg6apVzt055/O74wn
KEaVgY/hnAP6whpHpF5VyL23A0/Z65gkIK/YFevVc2qXsJSbd2c+RLBwsD97wFlc
LUot+vEOyW7oeyK/VFf5C1qeRIATQhUip/T+om8Dg57mz5LRTruf6owjrGkMd4uc
CNuJKqVAl/GcoN4McsVN887Ley6mhQ2P2cWaHMBqHxIGsRZdWtqD8QCV4mfe3MJg
BT4R4YqIQRa7jN4ISWSRjHI7Nu0htgdk756QBKXG+ksIw3hBbLUFlQMRd9BMoadL
juaeZLceeiH1eYxoTEs3Dkh8lksmpIUOobcIFnMAsT06VndQ45DVcs4UZwqjKpoh
M8Avp7/Msiw0gYlzzOY/yHK+OVnbgnm0ZltUJKsrT/DHt7mVBP6L7dpMgm73SFSt
PeEkVcfyub2GaboQCq52EosKfdzUK9FZNa69wzJmbeD3eJLjgq7tx0Pf+BifKfE9
089ZIPAaVmw51OJDhyZrhvA4C3wtMB+gyy91SqTHZzDsXpjJ5OQ=
=Vhk8
-----END PGP SIGNATURE-----

--nxu0+L+82/Uw6Rsy--

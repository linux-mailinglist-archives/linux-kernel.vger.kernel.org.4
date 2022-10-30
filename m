Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E338612AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 14:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJ3NF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 09:05:27 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FBCF23B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 06:05:26 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so8583400pgb.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 06:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WW41LFvv02s6JX5NVuQc7KiMNpSe68lS8g/dJivUNoU=;
        b=nomg6wFSJ5x/qxj/PihlJa7vo5DnqvOZ39nSi6i5GoFr7DBdT/qdH4Xt+yYWQ1nMnC
         OHWnTvqHaQQrS/t8WgI4xo0sWstY6LiEFjEYFhdJefKF2AaqdqwAP16syN07opXw1WpY
         KqRklc2vTGh+vPmDlrkC5EOztZngdDEXtJRSYU0Z9cRLW5lRL6JtAVC215pRq4cZAf57
         fLhvWjRPGe0RZx8bdij6nbHMX586hHJxa16m7Bsh8seSth5krBSbvqCI7iJncOWmhTxn
         YjRudbdZk0KPwMWMiCEwn+r6BA3nUNXQ9tJoNFz68lDx4IIEfqwx+xVeeruNKhraGe5T
         q60A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WW41LFvv02s6JX5NVuQc7KiMNpSe68lS8g/dJivUNoU=;
        b=uwO/DZUtO1IZ1dkbwuuPxM5WzOPPdpMMiU/jIiPkJPdSLR1yuxqJ0h8jv73K1Bw/J2
         chHUlMs6ONTuGWCIkmWTkkvbG1FbZNFRwhCjf5za1klqS8nwHE46WSYciJn7vxjMkjBc
         5BpigitEY6rDLN/aVn+eN0BEBfcNCH61vin2InUomXGJp5TOrQsJ3A/+buwtwlJVNuit
         s1MBRnOnzOuHLx7qFxXySq76yAKcevDr5B6ROBQuxdaNDSOEFoEOg5CA34jFwMMLieF9
         0fB0UHVMn2IofDQu/XCMrOZfauL05AxQRjYzVIh5z55aPs9MKadL3BBgsoDCg7jCg110
         tRgA==
X-Gm-Message-State: ACrzQf2Vrtvfjh6w0hrTP9OOK2bmXMax/jT1z9Rm/SMXNatm/9jTdZMO
        LObANvg8WJ4iP1IyCPHrSeM=
X-Google-Smtp-Source: AMsMyM6Vg1M282U7rq1qWngHa7fThDW+JjuXm6gWpQFPfhnBf3DpRaBvnxRenQF98WH5W3A0TcF/9A==
X-Received: by 2002:aa7:809a:0:b0:567:6e2c:2e2a with SMTP id v26-20020aa7809a000000b005676e2c2e2amr9201502pff.56.1667135125924;
        Sun, 30 Oct 2022 06:05:25 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-87.three.co.id. [180.214.233.87])
        by smtp.gmail.com with ESMTPSA id k76-20020a62844f000000b0056bbba4302dsm2589533pfd.119.2022.10.30.06.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 06:05:25 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 6B927103D98; Sun, 30 Oct 2022 20:05:21 +0700 (WIB)
Date:   Sun, 30 Oct 2022 20:05:21 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     antoniospg <antoniospg100@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR NVIDIA GEFORCE/QUADRO GPUS" 
        <nouveau@lists.freedesktop.org>
Subject: Re: [PATCH] drm/nouveau: Adding support to control backlight using
 bl_power for nva3.
Message-ID: <Y152kbkeIFnz/cbE@debian.me>
References: <20221029184851.25340-1-antoniospg100@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zkq+an0wUo19EgpH"
Content-Disposition: inline
In-Reply-To: <20221029184851.25340-1-antoniospg100@gmail.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zkq+an0wUo19EgpH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 29, 2022 at 03:48:50PM -0300, antoniospg wrote:
> Test plan:
>=20
> * Turn off:
> echo 1 > /sys/class/backlight/nv_backlight/bl_power
>=20
> * Turn on:
> echo 0 > /sys/class/backlight/nv_backlight/bl_power
>=20

You sent this patch twice, so I reply to the latest one.

What is it doing? Please describe the patch. Remember to write the
description in imperative mood.

--=20
An old man doll... just what I always wanted! - Clara

--zkq+an0wUo19EgpH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY152kQAKCRD2uYlJVVFO
o8dmAP9B8377yd62wSurH1C9reAvl5ipEFFQbVFG+b2Zayub9QEAlnaK7b5XMN4r
j9L4LEizVKSH/X8VQj5nEP93wM/Oaw0=
=hrUz
-----END PGP SIGNATURE-----

--zkq+an0wUo19EgpH--

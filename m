Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D13E5F8B94
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 15:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJINgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 09:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbiJINg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 09:36:29 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7240D2A277;
        Sun,  9 Oct 2022 06:36:27 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 2so8374672pgl.7;
        Sun, 09 Oct 2022 06:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BPRUb5fXBvpUrUoLBXNgAFQk1VijQRqMyh2TnAMTGtg=;
        b=beTouj+LzjAy8bHGQMDqKT9uxR7+7XKjjMVtkF5HUjZjFOyWy5MDeNI0sbikopgIIR
         b853xvaVfPCinMZcjhK3cK9ZxbH48csvVi4Q+kS9WXDK2k6+72s0hGK1qNUUK05AjBaE
         jZBiYyaQbnQyHvOCjpcpD0mxGfUNbrEZH2YwoOVVEPtvu+MBqiUINPqUVhyO9wuQsfHO
         4oG4OHGOG6DSnGHTk918cYqYMXiOHOjL45kdhlgEbPtr8lW0f8WjdidP1pmcZkibX89d
         iov0kHe+ZZa0qBmA042j2VMWtIS6apB+vSd6m2sgkXzzUOeiJshDMDHL1VLdE4c6IEws
         QJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BPRUb5fXBvpUrUoLBXNgAFQk1VijQRqMyh2TnAMTGtg=;
        b=e+tHrEJdasVyp4iCx9ibiRP3tX+eiWvKv362kHHXYwnMDIwrl0Mu1Wk93rlEPlicmI
         iRwyhZYsKq09bxzA0CXuKEfABIIYmoSct6yvkXK12a0KGyP5zLuNiJlFTyxEDCEYgfsf
         ob2dA01DREA5LR0B+iRYvTamtf+CytbVp7MwPdYWGIiS2d76B0qfsora9svlfIH2Fkln
         aJqmNtidQEFKOZ8ooEqtwzyCZh/ExRYGVm85j81hG7HoVZ81LMebfXOu7E5SW0KQR2p8
         wIMafByIq1MpSrhPVPAVwoXqYvN5VLHjKqcvKs09jgT6/zRLnToh/il6YyjwS/MHzNLD
         HN4w==
X-Gm-Message-State: ACrzQf1cObvNro71WNr2SoUZFN4qOpEHjLc7jTyb31s5wZ8gnJSrboF2
        oyGYAEB6bHG9TpEj5YCnXcN2mpH1wAWr7A==
X-Google-Smtp-Source: AMsMyM7qirq+CTtzxgDgLaxC/gCx4mvSFpalSIjpkC4n504fPbAnHr170mHWnY2T6hWKZyD6AXF5JA==
X-Received: by 2002:a05:6a00:179c:b0:561:64fc:3037 with SMTP id s28-20020a056a00179c00b0056164fc3037mr14842409pfg.76.1665322586893;
        Sun, 09 Oct 2022 06:36:26 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-66.three.co.id. [180.214.233.66])
        by smtp.gmail.com with ESMTPSA id u1-20020a17090ae00100b0020a7d076bfesm4469527pjy.2.2022.10.09.06.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 06:36:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id ED98F1039BF; Sun,  9 Oct 2022 20:36:22 +0700 (WIB)
Date:   Sun, 9 Oct 2022 20:36:22 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Jiangshan Yi <13667453960@163.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] staging: sm750fb: fix spelling typo in comment
Message-ID: <Y0LOVuL8uNJ19bjV@debian.me>
References: <20221009094809.3171319-1-13667453960@163.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dZhQDIkS5gtuuN7K"
Content-Disposition: inline
In-Reply-To: <20221009094809.3171319-1-13667453960@163.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dZhQDIkS5gtuuN7K
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 09, 2022 at 05:48:09PM +0800, Jiangshan Yi wrote:
> From: Jiangshan Yi <yijiangshan@kylinos.cn>
>=20
> Fix spelling typo in comment.
>=20

What comment are you trying to do this typofix? Even seeing the diff
below, I can't figure out that due to insufficient context.

> K2CI (Kylin Kernel Continuous Integration) is a code pre-verification tool
> independently developed by KylinSoft, which is used for ensuring the
> code quality of code submission. K2CI includes the comment check tool
> notes_check.
>=20
> This spelling typo was found using notes_check tool.
>=20

For CI bot like this, I'd like to see publicly-accessible reports (like
build status), just like what kernel test robot (aka LKP aka 01-DAY CI)
does (try searching LKML for recent report by it). Don't forget to add
Link: tag to the report.

> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750=
fb/ddk750_dvi.h
> index c2518b73bdbd..afdfdb17ffce 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.h
> +++ b/drivers/staging/sm750fb/ddk750_dvi.h
> @@ -2,7 +2,7 @@
>  #ifndef DDK750_DVI_H__
>  #define DDK750_DVI_H__
> =20
> -/* dvi chip stuffs structros */
> +/* dvi chip stuffs structures */
> =20
>  typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
>  				 unsigned char bus_select,

Are the structures really plural (many instances of the struct)?

--=20
An old man doll... just what I always wanted! - Clara

--dZhQDIkS5gtuuN7K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0LOUgAKCRD2uYlJVVFO
o5abAQDCCPg+8fcvsOLmLonB7xsYw1IuPRjkPfOSqr/8ap6WEwEAn5L6/13EPykf
a2SW0VQuhr/iphjQnmqDUEb/ftTmHgM=
=zi0w
-----END PGP SIGNATURE-----

--dZhQDIkS5gtuuN7K--

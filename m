Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5D36C2C1C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:17:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjCUIRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCUIQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:16:21 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A282B14997
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:15:54 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id u5so15206308plq.7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679386554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qc+ig8kLY6tOXJD14pTktQqDfjz/ghEuvLqsjQLjDjw=;
        b=mjo02WB1eE5KxpQPswIHH8hkXspC3KhxJ+HejaV6PT7gmEiRPKVrcnWrBXPJ01xReM
         rnFZZSrvHJm5U7zOI0mLjlzk718BXJAR5uK6Ux31mwxFWpxs+fHGov9G8QZRVeusMwV/
         UKihSgzDTa2CKiYhYZs39R/qSWNtCJyn8onpkclbVbcaRkFiGbpQueaJgesTF39iGm5n
         Yp7eiEPQMG+rCWG12c/j6lgxKn7dnBh6W5EVWtEF2BCNQfAvvPj0/wq2iFxcSLfAWcJB
         HH4vDBxYOiOGUWy//099ZbiMp5H3+QSUWu7rVTjRaZk0xhZmLCEblIv+Raqiaajn34Ls
         1MEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679386554;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qc+ig8kLY6tOXJD14pTktQqDfjz/ghEuvLqsjQLjDjw=;
        b=HdSNZ8SMDONdV9XuQA7KUnRrB6HrlhU/hRpHg64G3Lqpg1Bu7TF2OCO9cTIJJ9S7xr
         KY5muPNMjKi36iwtW+ipab+6sO42Mg4xbEArjEf+q+jXNP8geqbyTlPP0SuphtU0dGus
         uFHisFxDlc0/rbGfDd6+Zw+3L2wgOl1DYzqyWEv07DHKgQabK/eYOrreLV01LqxZKvtk
         H+XJgLWWzR6RKxbiNNraF/EIn6c1FZubbbWTFgd6ewZkVNCc5h+BRzHM0tfvXewh7Ceg
         ZJ/0HNKG41jJVGoB3H51JHiIkm6xUK40wl6STNSBOFN5vFpiSpIbtv689yuzcQNozbWw
         mxxQ==
X-Gm-Message-State: AO0yUKWsv6+GbWX+aV6wVdJIrY89x0JALzueI8Xjtetf+h2liLMliNRC
        onlEB3e4PQyIaTqGZFJ2KlI=
X-Google-Smtp-Source: AK7set9Fq22KfLKmE8rFcPm5t+HaG7isbKh9iUsCvJF6fQjzxw3oEhvaPt3nlUt6UiyYXsAAHNU1pA==
X-Received: by 2002:a17:902:d10b:b0:1a1:b9e6:28a8 with SMTP id w11-20020a170902d10b00b001a1b9e628a8mr1122837plw.45.1679386553962;
        Tue, 21 Mar 2023 01:15:53 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-83.three.co.id. [180.214.233.83])
        by smtp.gmail.com with ESMTPSA id x13-20020a1709027c0d00b001a06677948dsm8038469pll.293.2023.03.21.01.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 01:15:53 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 5967B106646; Tue, 21 Mar 2023 15:15:42 +0700 (WIB)
Date:   Tue, 21 Mar 2023 15:15:41 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Deepak R Varma <drv@mailo.com>,
        Kloudifold <cloudifold.3125@gmail.com>
Cc:     outreachy@lists.linux.dev, teddy.wang@siliconmotion.com,
        sudipm.mukherjee@gmail.com, gregkh@linuxfoundation.org,
        alison.schofield@intel.com, linuxstaging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: sm750: Rename sm750_hw_cursor_* functions to
 snake_case
Message-ID: <ZBlnrWywCfDftf0+@debian.me>
References: <ZBfpbgvYguJnzIOx@CloudiRingWorld>
 <ZBiEnFxlHb/OES0B@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="65kqxN6J33eatIsv"
Content-Disposition: inline
In-Reply-To: <ZBiEnFxlHb/OES0B@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--65kqxN6J33eatIsv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 20, 2023 at 09:36:52PM +0530, Deepak R Varma wrote:
> Hello,
> Looks like you missed some maintainer list recipients in your to/cc of th=
is
> patch. How are you extracting the maintainer list?

The easiest way to copy the list is by passing `--norolestats
--separator , ` to get_maintainer.pl.

--=20
An old man doll... just what I always wanted! - Clara

--65kqxN6J33eatIsv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZBlnmQAKCRD2uYlJVVFO
oxaOAP9AN60wajhBoFfVPevHYzRMIx3MBX/Xypuk1FDBeNIbGwEA2iVt9xG2+wrL
wsPxfAT3wzZHBWY7x2b378Rm7eXYGwo=
=cCg8
-----END PGP SIGNATURE-----

--65kqxN6J33eatIsv--

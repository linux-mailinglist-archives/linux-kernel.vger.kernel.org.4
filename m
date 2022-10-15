Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1455FF84B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJODiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJODh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:37:58 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A16C964;
        Fri, 14 Oct 2022 20:37:49 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id g28so6542820pfk.8;
        Fri, 14 Oct 2022 20:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tsCSKy4B37LC3LdT6xzdkdYMhoq/qRTC8aLZQbiPLn8=;
        b=e0WKsZkXnglxjr77BY1XCeVu7XO8nB5vx4z+yM17nEdwKEtnXtpWZyAIKC52zDODop
         K0Z5Vx8jgPsmX1UTlf2URf+6E+PBbjrqW0FaV9YBmcp7tL1Ar1evIxE5mLJjfTRQHrxg
         axd8oQFFE6jjmtjnohLlqj5xuGM7hwtoq8IchIpYl/n6yz85c8y8P4l/bx3a5f8RqEw5
         RDoVVs619Zri2/8t/0lnFBdZGMBG0A8LyHLfHrEQQBEXR/6O85ZlKcyRqqsCQ9ATaUbo
         TpMmOKOrp17+c88hckc9FeKm8j3/e9gksQauCGA2XGO0xoCndGngf4fhNpkDW/YodAh8
         d37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tsCSKy4B37LC3LdT6xzdkdYMhoq/qRTC8aLZQbiPLn8=;
        b=Jeitz0M+Ji5/Tfn/4UdTMlR68zmT9+612c1KZ/cI+L1emd0Vfe/5mYgkSy2Bgks8nl
         PEP7NFc5HI1Wo6wY2YCvK8khZOoYjT08z24lAhV2T3Jvz/oLC/kdu8Wk1W+QcyX7Lpm1
         6kPSfEglebOo1fPFiSi8Knn3M3xVV3CmIaWp9J7Vtbnv3UNsYLkQ51lWF/NZi1sNRjTW
         u/1zRRVvXKoQ1BtRv4fLvVvOZ4AZNOCO36e3hugmukiJui1wK8w5dxXxBDI4QXR/ynb8
         +c23eMNp3t7EDYBnVEoAqCQoZkIQkQ/ibuibArNUAx4HI9gOblX9/RwbcLXB5wQ2J6Wh
         oCVw==
X-Gm-Message-State: ACrzQf3dhoHN63EJasO7mxxBNQN/CRNgBdnN69num7IQXk07G4B2Goq4
        z9ZqbV3mz8cBoIL62dXuPNo=
X-Google-Smtp-Source: AMsMyM4H2GusEv8cFt9WngQWviT9775eriGBEk+OYGhO/QZepLrcS/Pijv9Mxw4zyztSGhV0nMlYOA==
X-Received: by 2002:a63:5141:0:b0:43c:e1de:eeab with SMTP id r1-20020a635141000000b0043ce1deeeabmr979280pgl.155.1665805069248;
        Fri, 14 Oct 2022 20:37:49 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-28.three.co.id. [116.206.28.28])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902f14900b001780a528540sm2377824plb.93.2022.10.14.20.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 20:37:48 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B4E5E103A91; Sat, 15 Oct 2022 10:37:45 +0700 (WIB)
Date:   Sat, 15 Oct 2022 10:37:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH v2 2/2] Documentation: Add HOWTO Spanish translation into
 rst based build system
Message-ID: <Y0orCdXXwOstrRDG@debian.me>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com>
 <20221014142454.871196-3-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XYxl0E/2PDAohEv6"
Content-Disposition: inline
In-Reply-To: <20221014142454.871196-3-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XYxl0E/2PDAohEv6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 09:24:54AM -0500, Carlos Bilbao wrote:
> Add Spanish translation of HOWTO document into rst based documentation
> build system.
>=20

LGTM (all warnings in v1 are fixed), gracias. I left the review on
wordings to actual native speakers.

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--XYxl0E/2PDAohEv6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0orBAAKCRD2uYlJVVFO
o8r9AQCopnNdLM58e0s/pIuxTwB3iHt55DgjXBsnCPYdAuB7BwD/TyFKlURN73LQ
DsycCQOWSdyA8VSHRWyjlHxf9nlpOgA=
=FoTP
-----END PGP SIGNATURE-----

--XYxl0E/2PDAohEv6--

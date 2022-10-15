Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505F85FF84F
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbiJODkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJODkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:40:08 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C36205CB;
        Fri, 14 Oct 2022 20:40:06 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id q1so5898667pgl.11;
        Fri, 14 Oct 2022 20:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TlYSrLiQ2Fck3kmwqGPusY9avwqaM0QIj3WQTctmCKg=;
        b=JPGrMGILLqfYeZ2/4DQtzQn5vqkFgMHKfVzHFwcK1uB66JY5Q01nYuWc3UTWSJsMWk
         oRLICppEf5jKW7qbMyWjb51j0QC3B0ki2SBfT2AP8ASPOj986NHJtMY+SWDY0kPJog7e
         aRN4GTR5Nndm3Lp8UJIoaySYoqy8EDk5jKzsISAFau6512ufP3vkup6Deme9J8Bh9sWE
         E4sHdeBmiixTGmxCv1HimNwwgqQSeQAUDayA5Ign8CQexd9BplWxU1o7EVEtIQHotQml
         7MiZm/yNYUHN2jT6CquLCZu0h0dDF3sy0nn7vdr+hU1bwuE08fbqFdhBPClQCiYG4E+J
         uXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TlYSrLiQ2Fck3kmwqGPusY9avwqaM0QIj3WQTctmCKg=;
        b=5sD0nMzlfrjF+WScnzRnxLF+guz2+hl0SORQ7DgBP+SnmtBNGpR84k9O/5zXDCQxYW
         kXC0YEuNJFJOd7+FQtZtt/W8RiYsueofbjojBHs9Db36gc1PmS8uzTeB0Pv3DYEjIue3
         n0oSaWhD2hhc2M2+owq7Slo8bSAr8bDim3ejsk8eQOoIiWrs0NvJSzMMlNPO7dAcovnQ
         2nH2wWJhU1WfwseBO7w44eNW4tbf7qcfTYyes1JR+qigWAQA121Dr9gh5ARtvSVCud+t
         sZbcvJXM/D5+Xt30kkf7PnS3ipqlVrsVCQPMRZdPBOCiVeUANLH6OIc6qxoxMYq997TI
         9Rdw==
X-Gm-Message-State: ACrzQf2VS4EZh3/m7l/EmBThw5ysHvCunUu36Qxz+3Td9vXCIfXYloax
        KoaOLjLvawY+v9JCQtZ1cpbo4Fywga0=
X-Google-Smtp-Source: AMsMyM45kPh0Dp5bMAXAyte6FO23TitdGjvW4QDpK9nCRie2Gy4DtgNnxG6l7/4URbA5/zAZQ2/7aw==
X-Received: by 2002:a63:1a60:0:b0:43c:9bcd:6c37 with SMTP id a32-20020a631a60000000b0043c9bcd6c37mr954256pgm.125.1665805206183;
        Fri, 14 Oct 2022 20:40:06 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-28.three.co.id. [116.206.28.28])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902e54500b0017f73dc1549sm2362278plf.263.2022.10.14.20.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 20:40:05 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 3228A103A91; Sat, 15 Oct 2022 10:40:03 +0700 (WIB)
Date:   Sat, 15 Oct 2022 10:40:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, bilbao@vt.edu
Subject: Re: [PATCH v2 0/2] Documentation: Start Spanish translation and
 include HOWTO
Message-ID: <Y0ork19pGMhZq8qn@debian.me>
References: <20221013184816.354278-1-carlos.bilbao@amd.com>
 <20221014142454.871196-1-carlos.bilbao@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="IVjoyMg6onV0tz3V"
Content-Disposition: inline
In-Reply-To: <20221014142454.871196-1-carlos.bilbao@amd.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IVjoyMg6onV0tz3V
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 14, 2022 at 09:24:52AM -0500, Carlos Bilbao wrote:
>   Documentation/translations/index.rst          |   1 +
>   .../translations/sp_SP/disclaimer-sp.rst      |   6 +
>   Documentation/translations/sp_SP/howto.rst    | 617 ++++++++++++++++++
>   Documentation/translations/sp_SP/index.rst    |  80 +++
>   MAINTAINERS                                   |   5 +
>   5 files changed, 709 insertions(+)
>   create mode 100644 Documentation/translations/sp_SP/disclaimer-sp.rst
>   create mode 100644 Documentation/translations/sp_SP/howto.rst
>   create mode 100644 Documentation/translations/sp_SP/index.rst

Why not es_ES locale slug instead?

--=20
An old man doll... just what I always wanted! - Clara

--IVjoyMg6onV0tz3V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY0orkgAKCRD2uYlJVVFO
ozRxAQDJ5ZunDh/jkq0AUdir4LmxedIjhkJt51ObtdMCBvoiGAD/RBNAUEOoeQ+A
ov067EkjY2Ph80sXKkT6LPvMtujwqgk=
=luSw
-----END PGP SIGNATURE-----

--IVjoyMg6onV0tz3V--

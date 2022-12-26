Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6766562F1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 14:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbiLZNwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 08:52:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiLZNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 08:52:11 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1AA216
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:52:10 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id u7so10738128plq.11
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 05:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjL2/QXvUTUImqlJSUAW7Up4yT5vjNcXbyqaxlSaQu0=;
        b=fZSvMMahnYALrXRZSTcnsYyteUmHTGr0EvUnOnUr5aP8LtcWkq8CwmZfQwYH0OYM2d
         10Y52lVBmgbTsf+DTdudWQCgjlMEhfSMklw0biwNK+x79HzQrAXA0DAxaHRyemErIeux
         wqKikay4+vQ+7WyuDk0iMJeTH65YhMV+SaLrVWd//6eaP6wrskuVtszS7QO0MS1doRuR
         Fr/lL5mga+jmbCYxIg0NOo2YnSJPeb7JJFXb7CY3aKWpz9J7RXVapFRB/3zOVumL2ek8
         SVca+Gj1HXrp2KTHnAc17s+h6MYufSq8SNufztqRk1fLa57GeP2S86ap2YxmB1by1Z6Z
         Vx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjL2/QXvUTUImqlJSUAW7Up4yT5vjNcXbyqaxlSaQu0=;
        b=MKvQFHKA6/mXPshbH4CN5vnVjjgJDAdBl7WsHqeQ9g/mQqB7EMDBXI2Jq52srU7UZH
         vwk+X/DlL6A2MLZlRg5shwcupguZf4z6NJKRmMHbNvUs68Ag6wf4cURvZbQpOI/a+hQM
         egUs9LemPRkXXfuY2ykV03/mgayMhUW1R8SYTrD64tCgcTkrYmc2UsVgNcFlgWJUgFnZ
         +EPdRKh0/0OIRI19jvG/hH2MrNexGSIdJkvfty8roQVAlNg3MLMi24QqTf00GZoQRhOp
         tGmvJ3zN3Hx9Kkp/Iqr22h1HGk1V+nvt3XF/6u7MKuqedwuyJd10+NVV2BdLVUSCDbhF
         buIw==
X-Gm-Message-State: AFqh2kqX6phAY0HtGqZFjedtOJxbneFVfRYbY69A2comdEGMLKtfsvY2
        5RrFqc6kbvADl2hkuexkSK8=
X-Google-Smtp-Source: AMrXdXtF0CJT5TEImdqLT6P+vfkloyP/APJlg1ZZj6LY+WRnq+l6XueMTfjmmAwah3QVkuNaY6Y0kA==
X-Received: by 2002:a17:902:aa49:b0:18f:5bc0:8f0 with SMTP id c9-20020a170902aa4900b0018f5bc008f0mr21628881plr.69.1672062729500;
        Mon, 26 Dec 2022 05:52:09 -0800 (PST)
Received: from debian.me (subs03-180-214-233-70.three.co.id. [180.214.233.70])
        by smtp.gmail.com with ESMTPSA id b3-20020a170903228300b00179e1f08634sm7170091plh.222.2022.12.26.05.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Dec 2022 05:52:08 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 794CC10381D; Mon, 26 Dec 2022 20:52:05 +0700 (WIB)
Date:   Mon, 26 Dec 2022 20:52:05 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Anup Sharma <anupnewsmail@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: hal: Fix spelling mistakes in
 comments
Message-ID: <Y6mnBSg6i5wMCKUV@debian.me>
References: <Y6mYdPlqIK1VgQ0Z@local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/cuFQ4lObo4YSjvd"
Content-Disposition: inline
In-Reply-To: <Y6mYdPlqIK1VgQ0Z@local>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/cuFQ4lObo4YSjvd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2022 at 06:19:56PM +0530, Anup Sharma wrote:
> They are appear to be spelling mistakes, initially identified in a codesp=
ell report and never been addressed so far.

Then where is the report, and what are the reported diagnostics?

--=20
An old man doll... just what I always wanted! - Clara

--/cuFQ4lObo4YSjvd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY6mnAAAKCRD2uYlJVVFO
o89DAQCXF8F+MsHSscJA6zxoux/LDtVSTtKiXkrWzo448DJ/pQD/Y/zf/Fd/teoG
pylsRaLivJ3NrfIfxAaWQUyITqqvbA8=
=oYZ+
-----END PGP SIGNATURE-----

--/cuFQ4lObo4YSjvd--

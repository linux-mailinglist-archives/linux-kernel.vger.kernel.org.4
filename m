Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7B856280DD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 14:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbiKNNL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 08:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237909AbiKNNLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 08:11:55 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D54F317899;
        Mon, 14 Nov 2022 05:11:51 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id b62so10246449pgc.0;
        Mon, 14 Nov 2022 05:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=itwylVtul7Z49JKkp9kyK5X/B4iweq+ayVxXXotYQJw=;
        b=MhmYxowk5DwtJgYGp8dCt9DBse6IZR1/QsPRPK0Xelm6pisV3yfUoD4CTsa+dinrge
         cCwlff3pZMlBTXU/UMzhdVbGftM/n1A+azTXLAt99AkOPpb+rroZ08Ko+CHLI6wTBD0g
         CqJ1fh8ASbfN7E9l6t16+7WPeuQtR9z1doqXcgOJGx7US+/u/QOWhMEQ4PTraMy9rIZM
         jDorNtoXLX31vjleS9m/c6D1DGyOB0aiJTBy0B3zYzpUPupsd6hHueIH8UwBSU8Uc43z
         SK0ofefxNq21dBXovbGvssLeytLO6I4d3VPth8zh+RIBcFDwPQVXdZCgraPo/25mYkxw
         e9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itwylVtul7Z49JKkp9kyK5X/B4iweq+ayVxXXotYQJw=;
        b=fgqEtajlm9Kr/M8KZtgausdwJiRnHPqUXKT5NQwzu/NoMksYaBJSomaCWYvCSS62QS
         jcPnGjyfVPz1zRt1do3akyDtbo1rpMnyha00N4ZaEq/BD51Vc5eoGG2bjtVBTqFidHWB
         cnkosmDH930M1/c6J1hCN+UJr+9yxTUOLS2yJ5N1lNnflmnf+/oXAVMYCiEbfPuyUVVq
         jmmki2JH6unaFbA3VoxUF/9lOWTbwX4ibIfQSXKebJ7DEtLacLdf86q7JbeMCrY5b9iT
         LfX2n/Iwp7zYG4RRaBHmE53n2bwGVpvy0ARMMz51AMUfeEHb5IU8poZVAtNi+APLMEse
         sc6Q==
X-Gm-Message-State: ANoB5pklesqQZHn9ZRQVgXtBcHVv5aeDcvdENu/oq1tcmRE8zL8R7Rge
        3+FqojWnitHPaSexyeY+8RA=
X-Google-Smtp-Source: AA0mqf4BFVRB9+AMFDzK0Shf5FC49MuYofaTxw1/kzlGKOh8F5lY9AHUO8LwfsFYia6t7oYj5cP+1A==
X-Received: by 2002:a05:6a00:d78:b0:56c:8dbc:f83e with SMTP id n56-20020a056a000d7800b0056c8dbcf83emr13675256pfv.41.1668431511318;
        Mon, 14 Nov 2022 05:11:51 -0800 (PST)
Received: from debian.me (subs02-180-214-232-86.three.co.id. [180.214.232.86])
        by smtp.gmail.com with ESMTPSA id y28-20020aa793dc000000b0056c0d129edfsm6617533pff.121.2022.11.14.05.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 05:11:50 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 326211042EC; Mon, 14 Nov 2022 20:11:46 +0700 (WIB)
Date:   Mon, 14 Nov 2022 20:11:45 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Junhao He <hejunhao3@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, john.garry@huawei.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        lpieralisi@kernel.org, linuxarm@huawei.com, yangyicong@huawei.com,
        liuqi115@huawei.com, f.fangjian@huawei.com,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH v13 0/2] Add support for UltraSoc System Memory Buffer
Message-ID: <Y3I+kaZOe4TPNsd/@debian.me>
References: <20221114090316.63157-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="v3CYsDSexBSkad/c"
Content-Disposition: inline
In-Reply-To: <20221114090316.63157-1-hejunhao3@huawei.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--v3CYsDSexBSkad/c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 05:03:14PM +0800, Junhao He wrote:
> Add support for UltraSoc System Memory Buffer.
>=20

The cover letter message (aside changelogs) is short but LGTM. However,
for individual patches description, please write in imperative mood
(that is, no "This patch/commit does foo" but "Do foo" instead).

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--v3CYsDSexBSkad/c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY3I+igAKCRD2uYlJVVFO
o1UsAQC84UBCE7LcNm7rlFcJmsg5bIyUFwl1f5xkMLKP1kpS3AEAmqD8k+1nTJGa
gxmYpWJx+6+dp8zsZXEhYNNQMUgYSAY=
=xa7E
-----END PGP SIGNATURE-----

--v3CYsDSexBSkad/c--

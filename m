Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4437D64672B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 03:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiLHCmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 21:42:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiLHCmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 21:42:18 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2CB9491E;
        Wed,  7 Dec 2022 18:42:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so163576pjm.2;
        Wed, 07 Dec 2022 18:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=achaGfwLVcz//s9rN8HUEx5yTqaG6dusI+1bnuC2BJ8=;
        b=YF2alemNOqW+b4n6/YaV+HM7qLtzzD0fB0oaLMUgDCRkTb0a9ByBtqr6uBUeBQlzjJ
         WSDel6JjgSY593zI26HUeZQDjwo1B2eb8CcdNNJSpIkA3eoCWioIOO+Ap9YRnC1feILL
         T4aD9GGYoh6k8JeJ5HnMZo59kJq0K+lgcCpdY4hsj5DUrSHs8NLvn8TuBspZwTyN96nl
         jYEKKP2sU5bzzpCrORxfUGgadn7npFXE3N0QRbvXt5UQHRrJAydpPmlgKVvjNtezb2Up
         2Axr1sNX1LGk8JQ5r+LU0Bi2leDORjQdR6A1uG2S3126B3MeeJnfQbad5IyOWmC4AYDC
         haDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=achaGfwLVcz//s9rN8HUEx5yTqaG6dusI+1bnuC2BJ8=;
        b=wtkVPel5UDcULJkctj9Z+jKmIn724PUgz1fTtb+1/9p3MA+meV3iPoQsf2n+4QNrNs
         E9brk+EL8el0pIZiSsJjIkk9b78eRjkWSsy2b24y4ysuPQx6/A1XoWdrqRkILZPbqkr+
         l4ktjyc6KiO5dNae8NIiX58qbW/jOVq8Pklmj4USHRt2Xf3iVG+YNDQI0e7gvnlWXv+n
         5760o/I3mIWr26fvbHHZOUdQgH49z5lViRXtcxhdHdITUaiFy+jGFKaTzBIBJlGj+pZo
         nB/NPJVrd1O7s6BewrtOWkMn0W9YUAfsxSvwCgQiE5Cc4ijYoqOV4RIs3oRmgxDEo2IP
         X3tg==
X-Gm-Message-State: ANoB5pmCISF1850SAOVwU7GEzq87HkxYujfQW7kYsDadFsNbEl9RuljX
        vmObxhCqZB8Z4gtuZABq9AU=
X-Google-Smtp-Source: AA0mqf7xBj7Zgb8jxIMAmYlRVl5PSaTTre7/DjyExaucIS8pUSvSq2AcaRXmTuX6p+sMqWaq8Mj6bA==
X-Received: by 2002:a17:902:efd6:b0:186:9c25:7ef0 with SMTP id ja22-20020a170902efd600b001869c257ef0mr16824893plb.164.1670467337250;
        Wed, 07 Dec 2022 18:42:17 -0800 (PST)
Received: from debian.me (subs02-180-214-232-5.three.co.id. [180.214.232.5])
        by smtp.gmail.com with ESMTPSA id iw1-20020a170903044100b0017f5ad327casm15224298plb.103.2022.12.07.18.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 18:42:16 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id AF8EC104460; Thu,  8 Dec 2022 09:42:12 +0700 (WIB)
Date:   Thu, 8 Dec 2022 09:42:12 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Wyes Karny <wyes.karny@amd.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     Jonathan Corbet <corbet@lwn.net>, Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Mario.Limonciello@amd.com, Perry.Yuan@amd.com,
        Ananth Narayan <ananth.narayan@amd.com>, gautham.shenoy@amd.com
Subject: Re: [PATCH 2/4] Documentation: amd_pstate: Move amd_pstate param to
 alphabetical order
Message-ID: <Y5FPBNawZgvk7GBe@debian.me>
References: <20221207154648.233759-1-wyes.karny@amd.com>
 <20221207154648.233759-3-wyes.karny@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0HevvGWFK2mj9IxW"
Content-Disposition: inline
In-Reply-To: <20221207154648.233759-3-wyes.karny@amd.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0HevvGWFK2mj9IxW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2022 at 03:46:46PM +0000, Wyes Karny wrote:
> +	amd_pstate=3D	[X86]
> +			disable
> +			  Do not enable amd_pstate as the default
> +			  scaling driver for the supported processors
> +			passive
> +			  Use amd_pstate as a scaling driver, driver requests a
> +			  desired performance on this abstract scale and the power
> +			  management firmware translates the requests into actual
> +			  hardware states (core frequency, data fabric and memory
> +			  clocks etc.)

Device drivers request certain performance level?

> +			guided
> +			  Activate guided autonomous mode. Driver requests minimum
> +			  performance and maximum performance and the PMFW autonomously
> +			  selects frequencies in this range.

Same here.

Thanks.=20

--=20
An old man doll... just what I always wanted! - Clara

--0HevvGWFK2mj9IxW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY5FO/gAKCRD2uYlJVVFO
oyFTAQCc1iBOvpPXJWhiJOB4d7tHPqf2UWT/kzSYLg1ZnMO1owEAtAICze7VaJF/
HQBuzhbrneFSnRB6H8zJox4xQTxRnwU=
=O3T7
-----END PGP SIGNATURE-----

--0HevvGWFK2mj9IxW--

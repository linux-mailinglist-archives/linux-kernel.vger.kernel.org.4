Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02F2C6E7899
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbjDSL1Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:27:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232292AbjDSL1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:27:22 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C30170A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:27:21 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-54c12009c30so602896697b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 04:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681903640; x=1684495640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bhVigfqWGFmXRTZ2TxchBXXZPO5znPNHgJBAx9rqfOM=;
        b=e8GuTfmtxGy3rVdST65/SUmuDcz2TBIMvlQdBsEi2Qy0V1Vlohqj95UzjVo/8EKbWe
         kzu9ReFQNStSS3sLwPqDlycEO7hQZnKceeHXUKX2rCMwykdtra2pC/rhYkXJPKzeV8CU
         +HsIS7FTa7TBvreyUZ7rJpLhuSl09kpa1XyW8xeO63LswXyUK0rjIj2vOQQW/5fiNgjQ
         w9RCxNPrMMdRqkUVHDs7ViNUFO+iWjMY0KDN6MR94iykeI9UmZyff2LxKVQCFWMLHxND
         bjIGhagifMWZXWhooKc5Y1J3+c1sQWUMzUq7R8xeLReNeEdmEtFopsrqs0d3EL7sttcG
         vkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681903640; x=1684495640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bhVigfqWGFmXRTZ2TxchBXXZPO5znPNHgJBAx9rqfOM=;
        b=elE9/X3JY9sarG6UGEv0/6lq0v+tERQLIPhy/gRo70wxJkjaNzx8gVZFGSosk6VfIg
         FEnJp87qqfo80PLEaFZFa11X91vppgj/1LqUr1XlaCYxjhJjqiFIMMmvSLANxOV7HvD/
         evMff8S2FSrbWc2A38cvKQSmzYCcVYZtl5iYSgIBQxR0dip4QAyeM++DpqoMnB0qnz+W
         xQXptEs8jx3apGlxLWc/l1CbZZRgTCyu3JDICaD9A3gAuUNmEV2X7EQRHw/JLyeCfs3n
         yLhJGQGMnPkpxid8zxFhK+19KaTw0cTsLi1+u6geGzBBn8NeIWowsoCN1B7IGe0Vgr/8
         9dbw==
X-Gm-Message-State: AAQBX9fbx7SToZh2muEZa8rBgQJl1x9RYwRDUdFgPlctdKBTkxFnQQRT
        MQNICqoB7VWWAknhcqe60/bOmg==
X-Google-Smtp-Source: AKy350aCHo9tGX/AhB2YJtQy37liXLhjsJ5xVCbmC+mZcCRK1RVGP8OoKjxjx34Eqq8cp/BS7cWD5g==
X-Received: by 2002:a81:5445:0:b0:54f:e2ae:21d8 with SMTP id i66-20020a815445000000b0054fe2ae21d8mr2747868ywb.28.1681903640359;
        Wed, 19 Apr 2023 04:27:20 -0700 (PDT)
Received: from fedora (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id y125-20020a81a183000000b0054fa1fbda6fsm4409159ywg.25.2023.04.19.04.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 04:27:19 -0700 (PDT)
Date:   Wed, 19 Apr 2023 07:27:17 -0400
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH v4 4/4] counter: 104-quad-8: Migrate to the regmap API
Message-ID: <ZD/QFa+2cU/tFivr@fedora>
References: <cover.1681753140.git.william.gray@linaro.org>
 <1f1f7920d2be94aedb6fdf49f429fe6137c8cb24.1681753140.git.william.gray@linaro.org>
 <ZD5KeYJoIZ1PFKud@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eaU7fGgbrcA6c2RU"
Content-Disposition: inline
In-Reply-To: <ZD5KeYJoIZ1PFKud@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eaU7fGgbrcA6c2RU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 18, 2023 at 10:44:57AM +0300, Andy Shevchenko wrote:
> On Mon, Apr 17, 2023 at 03:50:50PM -0400, William Breathitt Gray wrote:
> > The regmap API supports IO port accessors so we can take advantage of
> > regmap abstractions rather than handling access to the device registers
> > directly in the driver. With regmap we get boundary checks, read-write
> > permissions, operation synchronization locks, and more for free. Most
> > important of all, rather than rolling our own we utilize implementations
> > that are known to work and gain from any future improvements and fixes
> > that come.
>=20
> ...
>=20
> >  - Use "int ret" for regmap_* return values throughout for consistency
>=20
> Looking into it I would think it might be better to have a precursor patc=
h.
> But it's up to you. It looks good now.
>=20
> --=20
> With Best Regards,
> Andy Shevchenko

Yes, there are a few unrelated changes in this patch just to adjust from
the "err" to "ret" symbol. It's relatively minor, so if I send a v5 of
this series, I'll separate those changes to their own precursor patch to
reduce the noise here. Regardless, would you like me to add a
Reviewed-by tag for you for the changes in this patch?

William Breathitt Gray

--eaU7fGgbrcA6c2RU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZD/QFQAKCRC1SFbKvhIj
K4SOAP9f5EGJvGYHYKsTOfB7EmLLtOOhzZHRVzg5qgY55LWSugEArh/RYJZlvfHZ
P7D6kDPIpDSGZ5ZnyCpOKgsnVXXEvAQ=
=zdkT
-----END PGP SIGNATURE-----

--eaU7fGgbrcA6c2RU--

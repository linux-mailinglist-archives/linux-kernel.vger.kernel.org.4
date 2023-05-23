Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3065770D295
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 05:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjEWDzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 23:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEWDz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 23:55:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5624890;
        Mon, 22 May 2023 20:55:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64d3bc502ddso4525039b3a.0;
        Mon, 22 May 2023 20:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684814127; x=1687406127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VYUV13lroZp21dQZ+l6oL2IK7f4ffhF2cxU5Id8N1nc=;
        b=TWA2auq8EoZHsc0IWEG+GTa1YYtelvjAkAyS75mXLBeO6ThewGIi+SOWxBdqV/g+a+
         kBeNBPR3ifUwvsqGOFPmxlmIb0uEyx0MiDBxm1uXubJ/ODqi5PqEYv8VmG7psMcG0Xyu
         WNfyfql0sQ4eajwlM9CF3pUNVj7LWRARg6DvSZsJX5goOwOp4HAykN3gQ4TYHARqViOE
         SwkTgZDa4r6f7Nfas2a32nbQCLOrLf5nRRVRrK/4RCPzWrG0RyET2bnMDuDyeMbaXTzC
         vj4qFE+i+mnyQSE9r66CQU0l+S6fozfPl+lvy2I8LotwctT5V14TCLk9VtT3hN6JiZMb
         VnVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684814127; x=1687406127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VYUV13lroZp21dQZ+l6oL2IK7f4ffhF2cxU5Id8N1nc=;
        b=JsFMHdAoRRN3JyU5JHXvllUXDyX417IlHi3FIamKVyESg7GDkjpRtn2u1bL9o2PIGj
         XiGIiN8vdmTON3c+9C2qs3JYcdH9KDu89YXzbgQTBCRW70+wIbjnHjP6XSTVk2i89Wco
         WrBywsqLcytv7Jz68AOHsYLUgLerDzzO7KCLYV+4iuGR3R52tcElP5QnjuxypQUpiw5l
         MEFljtUmM0Bvxdq9qEOGXQEyUrtCrTHbxbCOI5B7H3zIg6GmlJo9LKCq1digSoKthgq3
         X9/t/5aMjj6vnjE4Rg+5SzMoFJgTciJSc6wkMeBBg6AsplJ09qOlygox1F4xVaa7DtTJ
         1brA==
X-Gm-Message-State: AC+VfDxVuwxjSqLP6lJiSyw2Xvt18yl1Y9Zhm+cU4tAi6OZC/sa0bS8y
        ifwCccNS8IhX2gaduI2JtgU=
X-Google-Smtp-Source: ACHHUZ4yWm+Gds5T21fDkBCEa4+bbSuphFCPX5GkZtzDfhgq19xGuzk5abEXhDaLZTfchNY0HtwD4Q==
X-Received: by 2002:a05:6a20:9388:b0:109:2f11:8b77 with SMTP id x8-20020a056a20938800b001092f118b77mr14627725pzh.1.1684814126812;
        Mon, 22 May 2023 20:55:26 -0700 (PDT)
Received: from debian.me (subs32-116-206-28-32.three.co.id. [116.206.28.32])
        by smtp.gmail.com with ESMTPSA id f17-20020a170902f39100b001a6b2813c13sm5617664ple.172.2023.05.22.20.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 20:55:26 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 716681069AF; Tue, 23 May 2023 10:55:23 +0700 (WIB)
Date:   Tue, 23 May 2023 10:55:23 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.3 000/364] 6.3.4-rc1 review
Message-ID: <ZGw5K+jBGakV3drJ@debian.me>
References: <20230522190412.801391872@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gXelIhH+DZCq6xQ9"
Content-Disposition: inline
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gXelIhH+DZCq6xQ9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2023 at 08:05:05PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.3.4 release.
> There are 364 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully compiled and installed bindeb-pkgs on my computer (Acer
Aspire E15, Intel Core i3 Haswell). No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--gXelIhH+DZCq6xQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZGw5JwAKCRD2uYlJVVFO
o88JAQDO6fCyEAOEgzx/1/IP3dyUgYGqaGkw6cH/IRxzCDDImAD+NpaBg/sZoXc2
U5OTNIsoOGL2huE/a7TdC25I8KKisgg=
=5vo3
-----END PGP SIGNATURE-----

--gXelIhH+DZCq6xQ9--

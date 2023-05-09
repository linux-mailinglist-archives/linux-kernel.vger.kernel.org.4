Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5CC6FBD29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 04:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbjEIC32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 22:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbjEIC30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 22:29:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 473381A7;
        Mon,  8 May 2023 19:29:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1aaea43def7so36239505ad.2;
        Mon, 08 May 2023 19:29:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683599365; x=1686191365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yYecKSQe0iHULW5+as1tqxFG/5MQ0oTCbV2Qpn62HZ8=;
        b=MsESL2Rr8Ou1aZdR1g6AT5S45QrhYl+vb0O4krEYhLp2J1PmbuyglmdFOvyjUEBJ+B
         r31pKbMZHAWnlILyZo4KZHRhh1pPACT9UzAsDi3fgwLGTHD9AGDYpZN/3Ltv+BxFJdDx
         2ekKk6k9lHbhnasy2ap9Y8dL/LloAGdnkPKt5nnYzvi5kWjUjQ5cx4PZODiLbRbOh3TJ
         SSVustgNJ/QrSfi39zgGtU+T4xL+wElZZB3zPpA03V8xZiGUAFRN15gQxUEDZfKP96IK
         WZhnXDUtvCPVfbFXK2xGmESZklJFC/2Uk9Ed0qUIDB2qkuJ1zTD1Uz7KrJyP34I1ZKTm
         dL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683599365; x=1686191365;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yYecKSQe0iHULW5+as1tqxFG/5MQ0oTCbV2Qpn62HZ8=;
        b=aUdNPuTjnldc3vP3wQnihpOvO66+veuenG6kcQvgm3HiTZ7XlPVRZ6w21EhmKDfuxv
         SWnOUm7XFe6oCpJ88Tjmx6KUTxCN/XX5+DeajZKuYWLsU8J2rIsI/iSJvpmWDJYDj3vt
         qWL87Afi4vNAO9bDjAbzRxTwa7gbRqLn2jkifZ5ojgKxCG4Rwz3NTCmGCMzzVO8BWnR3
         Aax37lVXQ+Q+h/d1TTqMujRnzMSfXYHP0kRqWr4BAhoL/XfWem8GoSqZvskWZgzViKaz
         bJblFkKjhVB0bKkaeeocNRfSLuwqscvQoiDy9vFtAZ4euGX/cjTLaaSEdpsGhXB/K+Lt
         gIgA==
X-Gm-Message-State: AC+VfDzWzxWJGGfyLoDzboyISthRErb1dFSuTe+xqsdfQul17qCAkABV
        cxgfgqfDQNMxjnwFHKVMcA4=
X-Google-Smtp-Source: ACHHUZ4TY4UAW/s5ebdXDXFLOwlQUEaucFRj90lKQB3ABYpsjkZLBsNoIOkuLXzBgYOutf7yWiFhfQ==
X-Received: by 2002:a17:903:191:b0:1ac:750e:33f4 with SMTP id z17-20020a170903019100b001ac750e33f4mr7560399plg.32.1683599364641;
        Mon, 08 May 2023 19:29:24 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-7.three.co.id. [180.214.232.7])
        by smtp.gmail.com with ESMTPSA id jh19-20020a170903329300b001ac7af57fd4sm195050plb.86.2023.05.08.19.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 19:29:24 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 0253F10628F; Tue,  9 May 2023 09:29:20 +0700 (WIB)
Date:   Tue, 9 May 2023 09:29:20 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
Subject: Re: [PATCH 6.1 000/611] 6.1.28-rc1 review
Message-ID: <ZFmwAPqX8KggE6gj@debian.me>
References: <20230508094421.513073170@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WmofWIXPgBjLJT1v"
Content-Disposition: inline
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WmofWIXPgBjLJT1v
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2023 at 11:37:22AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.28 release.
> There are 611 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>=20

Successfully built bindeb-pkgs for my computer (Acer Aspire E15, Intel
Core i3 Haswell) and booted. No noticeable regressions.

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--WmofWIXPgBjLJT1v
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZFmv/QAKCRD2uYlJVVFO
o3TpAQCpc/XxsFVKYShtj/EoFmBsye/Okd166oEsvrPvj/mqFQD/bcgjMkjZskRf
o/bEM36lf4KLJmCrO3rcI9/7s4jlWQU=
=beRO
-----END PGP SIGNATURE-----

--WmofWIXPgBjLJT1v--

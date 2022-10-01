Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBA55F1C53
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 15:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbiJANNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 09:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJANNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 09:13:08 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE7543173
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 06:13:07 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y136so6512993pfb.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Oct 2022 06:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ONPgsBrJdUJdEzqlEP28WQjgrbP87OyCPyb+CbEgAZ0=;
        b=iC8YCjrPbnGXnyJJ2pLeTLEKWcTYf4rydOcy3lMd3ZI9LLAzJkyY7FmglC9eLTppTY
         gUps7llsJgAkcksJ+wMaSr6ijYz9rhvPFN1QFaDNsq0oXYR8wNQvCPqZ1AEWaCU+1IhL
         9mxx73qDvojWM5dXoCHbejTFn5JvdF+82gxXG3Nk6tvO1f6AdyXKRdkte0sF+zpfnvNs
         g/sE/LcJ12gmCccBIy6RsBFEkXifJmbGT8ewWvQt4hBQvxV9MBxnMKzZso426qNg7d+d
         DWmEHKGVgPLfp6nCzSG5Ov61NQotfu7Nvrdz1CGnmf9k2suOO5R3sCQBWYKBPH9T8vAB
         JGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ONPgsBrJdUJdEzqlEP28WQjgrbP87OyCPyb+CbEgAZ0=;
        b=GEl1azzYsyH8rzPBKi0diJDjAQtvl+EoMupDmiYcTMYNpRCfIn1Tu7HrUDbC0bD2eD
         z8eNloFvKSZGcaFgvokZHXQ7SA0FTNTQ0QX6Wekz3tjK014pUENub0brbfKdqpC7gpga
         45krmwikVLYO1tAbG4PJYA7M3Zgoj+OAnhzPayLr5fg2gKr9EhCXYGjzUM87zPvPui4q
         WR17RJ46tdjwoRlXxL0ywj4TxkBpDj3GppDkYxKIvxHmbTuQ7CkWytizj54FvOG771Qf
         5xvHImuO3Pmmau9UkgwIqiDe17oSnJ7DVnVczJoelMP7eXKJU1u8btZHgCOxN0IdiVSw
         9xsA==
X-Gm-Message-State: ACrzQf2JP8guDgPDOav08zywcbwCKXGiiKOf9M1Rop5+CQekCJI1qWIs
        1TrVbpIYCTEI+M2op0JEfuk=
X-Google-Smtp-Source: AMsMyM5FLyvoWPsLYE7qh9tTr5aYyhRWfSKwUkw0jN7G3X5SJ0Awoc7w5kOOm9Tly9O1yugEthoo/A==
X-Received: by 2002:a62:ab19:0:b0:55f:a756:e665 with SMTP id p25-20020a62ab19000000b0055fa756e665mr2349707pff.58.1664629986769;
        Sat, 01 Oct 2022 06:13:06 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-9.three.co.id. [180.214.232.9])
        by smtp.gmail.com with ESMTPSA id x69-20020a628648000000b005608fbd3285sm15128pfd.163.2022.10.01.06.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 06:13:06 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 52D16103748; Sat,  1 Oct 2022 20:13:03 +0700 (WIB)
Date:   Sat, 1 Oct 2022 20:13:03 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     William Zijl <postmaster@gusted.xyz>
Cc:     Jason@zx2c4.com, tytso@mit.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Improve comment of get_random_bytes function
Message-ID: <Yzg830EwxT8f1Ahv@debian.me>
References: <20221001001831.46355-1-postmaster@gusted.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="a1UH8gy3wfXgJUSu"
Content-Disposition: inline
In-Reply-To: <20221001001831.46355-1-postmaster@gusted.xyz>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--a1UH8gy3wfXgJUSu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 01, 2022 at 02:18:31AM +0200, William Zijl wrote:
> The old comment of this function had a double whitespace and contained
> grammatical errors, such as: `the randomness by this function`, `at
> least once at any point prior`. This patch replaces those sentenced with
> `the randomness of this function`, `at any point prior to this`
> respectively.

s/This patch replaces/Replace/

Why? See Documentation/process/submitting-patches.rst.

--=20
An old man doll... just what I always wanted! - Clara

--a1UH8gy3wfXgJUSu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYzg82wAKCRD2uYlJVVFO
o6EAAP9/CEuGAQfBnm3UMnpWwyfQmGgHvbVpr3S9YndP+1dnOQEA9C5T6rSyn13O
jDqeWbD0UU67zmBw6AuZ5fqkPipXBgU=
=EpVg
-----END PGP SIGNATURE-----

--a1UH8gy3wfXgJUSu--

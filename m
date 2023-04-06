Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E8D6D8DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235176AbjDFD2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:28:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjDFD2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:28:01 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293221701
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:28:00 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id m6so27734131qvq.0
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 20:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680751679; x=1683343679;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7exQMg8RF8/DHRsTNojhOJZnK3THgVkfQJB/jXiE+DE=;
        b=W/YamV4sOSzc+l3jhXPBKF1I079lJ9iIH16zzexlcJVcL3IPmp4TuiFWl16kc6R3hK
         Myj0Dv722LSRisflBbcf77GZgqUUKafoJmFF6GY8w+hrYMr5f3zhrGwMqf5bj7HZq6pr
         +deNEKNhOnF1RqYzUBxjOhrUxXi5c2ernc2bp8pqGujGncB37FSSlp6h/wfJ57jiohcO
         GWl6eHIQFtm69m5XfJ7G7orfVAiBZg01k1EEYDBiVBfWiBROEa1i+OvMeBgY/+ydc7J1
         OJPsbbPzjSOYnOm+CK1rrME9kQZf3wc30cyQF1ZUbOXEe7h54gmEzx/LqDixUnBJRk2o
         rgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680751679; x=1683343679;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7exQMg8RF8/DHRsTNojhOJZnK3THgVkfQJB/jXiE+DE=;
        b=lWQ1SgKMErqgX/2ZjhtH13ldPgYK6nPbdoAYPAKUdBjQU+PjaZi8rDLHaOWHwJ8Ro2
         LH9ZEvIhZ6LMml5T+EyPOMMAywsO2gqjTUv/klUjSlWG7SEvU5RQC0GF+3CJbuZGHFty
         jiutfLmmusv8aZX6255vjhf4p3C6VCPlbcRaBHRnacOPz80p9CyxYwG+aFgIo0ufsu4e
         WnKtlpbH4/F55n/BMilX6zTx41tq9MjW1ouSPwmbFovrvP6VUAM5dbrU5miwoXkpT/dc
         /SvM3IVbMD/GPHP+zagM8GPDhHF0mPbhK/20pIt9g9peF4Nmuu94bG9WNnFtn1c9LRHK
         U5Kw==
X-Gm-Message-State: AAQBX9c7QOFNb3qzrOWukpgAH/7gDIQuVtzw9/HRIHqDmfwxwpBwRnBw
        ZeYfLeIc+byHhZuivjEXoZtT1OrvXG0=
X-Google-Smtp-Source: AKy350YNT6s+D3654vCH0sED8S9QdFo7wAa1VQoxz3QPrLsyYYWKcEHNFAjb0aW5yuRRa9eLXOL5ZA==
X-Received: by 2002:a05:6214:d01:b0:5ba:168d:d3fc with SMTP id 1-20020a0562140d0100b005ba168dd3fcmr2350396qvh.4.1680751678927;
        Wed, 05 Apr 2023 20:27:58 -0700 (PDT)
Received: from Gentoo ([191.96.227.90])
        by smtp.gmail.com with ESMTPSA id 65-20020a370744000000b0074a29c9d8b7sm146896qkh.134.2023.04.05.20.27.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 20:27:58 -0700 (PDT)
Date:   Thu, 6 Apr 2023 08:57:42 +0530
From:   Bhaskar Chowdhury <bhaskarlinux73@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject:  testing I am a genuine human , please don't block by spamassiain
 rule
Message-ID: <ZC48LikauSUu03Nb@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <bhaskarlinux73@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ULK8sQ2TDIzwxCpq"
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ULK8sQ2TDIzwxCpq
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

testing ....

--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--ULK8sQ2TDIzwxCpq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEs7FAjU4eq1yogJSEAkGeLcGNq5MFAmQuPC4ACgkQAkGeLcGN
q5PJaQv+Kz7fVsyIPYG2iALhkecXxL6Jrv9Uxs7g5QYgbLcA9ZNfkChRALClXFYC
W1YJ3/fyh09KyYC++6LLkCGPmaqQD0z0PUAYCALY2KDDPvZml+C96Ac4Yx9t1siz
WniMIdqSJ91r+7QfmatUIPlbw17AB0hR7H3C0OtUrUuQjqMdmA0kJlckyzWbbg/M
3FfYfXUJUxe78RcQPYVfwq0vc2Kb3Yg1BMpkJ583me1Ryei6tO1qffcupFN+XOhv
Coydun7xFmHXFjuMRk8OSEQgVXKs0n4YQRaPuzJbfKp0SdEHeq6G62Muz3tDkYT6
/LT7rTbeOM19imYR8ddhqCtYdq5+dDOK49n86Mzp2l9w3YC8nNGikHfLaEQFCswa
OoCuwiLKWU6PaUyltJrZ1JwAH2GZS3ZIa/CRVldnHIaq04JS+bIwf4hfSJseNmHc
8V5ZWm3ioKDn9TBV3xfoec0cJjcvffkLnz69uq/goll+5SOm3IU3pEJfulDR+X1H
DwmjVnGr
=zdXR
-----END PGP SIGNATURE-----

--ULK8sQ2TDIzwxCpq--

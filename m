Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094025B4B6C
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 05:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbiIKDZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 23:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiIKDZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 23:25:08 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453751B7A4;
        Sat, 10 Sep 2022 20:25:04 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id c2so5452202plo.3;
        Sat, 10 Sep 2022 20:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=g1YJLc5z0WaEtu65y0i/ZKRdnjxQt85hQV5pQSDFUrA=;
        b=NakaKVgAM4/G8p21ziwOjOqoOLiBZyUnbhi7I9SWZnMO56q0AYAjejYTfq2cFOQ8af
         I+QzRqPK/NxLDTTtl184AbLmvdZywJmVZwHDYEKzk2XUHQH01+Dg7xu+Ju5ArPK7vdJf
         nBUZo4TWekHlSH6QnxU79cVa7SW5t9gdU99XtR5t3mZHPXchVnAN4aHdE4GdV2diSK42
         UznpSOufkpufk9HSae/EPfBbhP3eWd3KPqezu/cA8saNNZOVuELz/DrRwXPx8xJVV5IW
         7rAATzNpbgNEStgiKFgTAn4Vfs+uLxkX7WjXIlMSJ6qGyXnw/Oehdfhc2QEYDKw2Y4F/
         04GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=g1YJLc5z0WaEtu65y0i/ZKRdnjxQt85hQV5pQSDFUrA=;
        b=xMZ3qdNH/B2uAe74iUpLOXMkidS4UCaX3tavwyojuRF6RjBEAm5dhcgMZ9OB1m5/wd
         jHAZlPJbGQXm+BxyJPmguPJLJQkGjUAaSVGp4pEkcjDN5Js6cTezkO6sKHe06Wk/R7E3
         tFVySwluo163fhYe1Xq64SMBu4izTnh/YGf9oetVm9c+vIUsHOG8PQzy4RpWw3RUpVvn
         hL2xNd64ILt0IGNQdUooazJ7o4+ManY6RkijfRLi3F1OzLobxFx4wEYCX9aRv3NqZCm5
         jQPt9MrE/iV6aRUM3JLqIg1j9tnWe/OTVM1cabv+vv0jQfTg6dssLAQs14pieCIceca7
         G4Ng==
X-Gm-Message-State: ACgBeo0G/XyKOLHeOJRdSRBPTHWwMB9pe3jOx08RKAh2T88vWbicr5SX
        Kz1e1byN47/zCdqyPbC+wimTh2/33Zq47w==
X-Google-Smtp-Source: AA6agR5WK9Zv5xuj9zDz3zi/vUKWOkbROy3/swpZu9N37zUN9Ad5+Z8Mq13MnluUN2HVRZHTnQbJPw==
X-Received: by 2002:a17:902:dacd:b0:174:e43b:a235 with SMTP id q13-20020a170902dacd00b00174e43ba235mr21030072plx.37.1662866704037;
        Sat, 10 Sep 2022 20:25:04 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-78.three.co.id. [180.214.233.78])
        by smtp.gmail.com with ESMTPSA id n68-20020a622747000000b0053e599d7032sm2467023pfn.54.2022.09.10.20.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Sep 2022 20:25:03 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id F3C40103990; Sun, 11 Sep 2022 10:24:58 +0700 (WIB)
Date:   Sun, 11 Sep 2022 10:24:58 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     alexlzhu@fb.com
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kernel-team@fb.com
Subject: Re: [PATCH] docs/mm: Improve grammar on mmu_notifier documentation
Message-ID: <Yx1VCtoJzJGwWLF0@debian.me>
References: <20220908001948.3014216-1-alexlzhu@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="krJoGUX3JHCMjCSM"
Content-Disposition: inline
In-Reply-To: <20220908001948.3014216-1-alexlzhu@fb.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--krJoGUX3JHCMjCSM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2022 at 05:19:48PM -0700, alexlzhu@fb.com wrote:
> @@ -86,14 +87,13 @@ they are write protected for COW (other case of B app=
ly too).
>   CPU-thread-3  {}
>   DEV-thread-0  {read addrA from old page}
>   DEV-thread-2  {read addrB from new page}
> -
> -So here because at time N+2 the clear page table entry was not pair with=
 a
> -notification to invalidate the secondary TLB, the device see the new val=
ue for
> -addrB before seeing the new value for addrA. This break total memory ord=
ering
> +Here because at time N+2 the clear page table entry was not paired with a
> +notification to invalidate the secondary TLB, the device sees the new va=
lue for
> +addrB before seeing the new value for addrA. This breaks total memory or=
dering

You remove the blank line separator between the code block and
paragraph, which kernel test robot (and Sphinx) complains; so you need
to keep it:

---- >8 ----
diff --git a/Documentation/mm/mmu_notifier.rst b/Documentation/mm/mmu_notif=
ier.rst
index e22b591fc4061f..751b6eaf456e52 100644
--- a/Documentation/mm/mmu_notifier.rst
+++ b/Documentation/mm/mmu_notifier.rst
@@ -87,6 +87,7 @@ they are write protected for COW (other case of B applies=
 as well).
  CPU-thread-3  {}
  DEV-thread-0  {read addrA from old page}
  DEV-thread-2  {read addrB from new page}
+
 Here because at time N+2 the clear page table entry was not paired with a
 notification to invalidate the secondary TLB, the device sees the new valu=
e for
 addrB before seeing the new value for addrA. This breaks total memory orde=
ring

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--krJoGUX3JHCMjCSM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCYx1VBAAKCRD2uYlJVVFO
o++dAP4pXGa5ossOKkNSjQEYDTxVMhNZLYZFSt1AhiC7OJFvMgEA3Iab+k8i32LL
lv3y50CVIQ9rO8sDKawhraNWAXzzngc=
=vpHt
-----END PGP SIGNATURE-----

--krJoGUX3JHCMjCSM--

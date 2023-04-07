Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0470A6DA76C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239506AbjDGCGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240425AbjDGCGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:06:36 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81286A5FB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:05:08 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id ga7so39709669qtb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680833092; x=1683425092;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7rGNAgzABpHLdw0Cq+fud5H0yqLB2bsiAByjw02Wvjg=;
        b=GYVHjjRcdki4w9Wd0boemo4c+Wqwf1lzDB/mjYCEGt6kN7MO+9ceQ6sCkdH1avOCCV
         Q0m6sW7kFnAFIx6SAb/3lmGOTbDSJxXF2T04smxi+FUvhvtejsET998ocMDEt7Po+85q
         6M+VuEZxrV4r83IhVpwQm3r/QXbEvP4JAMi2IXb/SrlRO0adN952JhQoygb4Mh2oOQOj
         xb9jkhirLvUoWfD4/Wg1cAxYvblhkBdoF/j1O7fk59RnQ7dhwTHvJgBqIb4ztcLp5pHL
         mjfpQmboANDVeqbgdSwsfrofTWzDOUMAi8wGnQqM+tDUse5QdxAUkZVL5JTCxkO53Kyx
         T/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680833092; x=1683425092;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7rGNAgzABpHLdw0Cq+fud5H0yqLB2bsiAByjw02Wvjg=;
        b=qcmA+k5j3ClHa3qoQvGyLDAEkzy689MsauIl8HkS56ZfEdFMQL/PCTt2odsdVnba56
         UgtjNf4uUXkITOmMmlOlrrPb8qytr4BTJ0sNomzt63M1RaiQUdiiQIxt4IY6tCBhVQ+Y
         HCXw/J2o1BH8DLkg9pNke1RpagWwGiI9edPb8Q3fI4SBbh5qGPWofzvgnJdGXdufySXg
         AumxboBLkk0I5EajkOYR+S0LpY919Jak2wKWHE2tREX+2hEgU5D6YI2H1gwolyQk1AJ4
         KhOPx4WJuDdZvBeBIw9NOztlOTUNkxgqJDDqlWpDpyN4hsifapjqjUHR+PdWwwI5w1Om
         xTsA==
X-Gm-Message-State: AAQBX9faJ0BoJqy8BmJgwvXSixbLSU6VlAOE8UF+3DnFHeCyoXW7eILJ
        HOkYz/2pQTobTQfQ1JvDeUNmG3LGvnV6xQ==
X-Google-Smtp-Source: AKy350aL3QyKsKUleQ++sSc0TiCSHPOGZ93lEYFb2qmE2GYWEufzhCJqnGlqgyeSG7lQtj2VXsuuqQ==
X-Received: by 2002:ac8:7d95:0:b0:3dd:2a03:63c6 with SMTP id c21-20020ac87d95000000b003dd2a0363c6mr1234013qtd.56.1680833091994;
        Thu, 06 Apr 2023 19:04:51 -0700 (PDT)
Received: from Gentoo ([191.96.227.146])
        by smtp.gmail.com with ESMTPSA id h12-20020ac8514c000000b003e635f80e72sm849109qtn.48.2023.04.06.19.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:04:51 -0700 (PDT)
Date:   Fri, 7 Apr 2023 07:34:32 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: why my mail to any_body@kernel.org getting block by spamassassain
 rules???? 
Message-ID: <ZC96MEn3gdJd0epx@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="DQIFjzfWb+lwKI0d"
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--DQIFjzfWb+lwKI0d
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Hey,
What's going on ...why it is blocking my mail to send mail to the person
having mail@kernel.org by spam filter??

What changes recently?? Why it is happening??

Konstantin.......any clue?

--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--DQIFjzfWb+lwKI0d
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmQveiwACgkQsjqdtxFL
KRWUdgf/U9SZEuQ88eNF4/lfjD1Z7mjx/VVhG/V/ryAYNfi8yB2h96UtSFqAj+8g
F80Rpi4KW5csfP0vHlrcETIE92oEe+JsRWr2TTbXoxaEdcj7r+oODIL7s0Sq05DR
+PLtdg/NaM+QamlbERY+bGzP2muyvK/xdrSVG7xT88/zUeRA/ltrswU9bIhCmCkt
4lZi+MjeB30gteYnfrV4Ex02zDg3msrS10X0u8Niob7VeBelg+TT5TNto0M7pand
51QtxsX2++/pz6YnF8oCdCFxBiX5t/hvUGIANQHk9QU2C+8TAuJnsQJrL2u8VOxZ
N41iv/FFch8oDs1/o8gRTs7KnJNaEQ==
=uQcr
-----END PGP SIGNATURE-----

--DQIFjzfWb+lwKI0d--

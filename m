Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7F826D8DDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbjDFDHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235408AbjDFDG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:06:27 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2360900A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:06:26 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id cu4so27621668qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 20:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680750386; x=1683342386;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOeBIQkfyU+qsb7iIPWyZcajPEmOkYJng1DKgvioxsg=;
        b=JXTIzUx0NzRub7RfjnLTXzSQP/KtlOU4gBJAf3TDu2lFlEXnkjgTWJAx4JSe5skTL6
         EH5r/kVg0bAX+gfnnuVsKbXE20ibNuIHJjosZK9RSPH3oQg3PloizykW89HiC0NVtemw
         eW+z8gFqBq21FfKhzTz1sQsLR4gf3/Vbc7FtcOmQZcRc6IuuXHa94bbYErDQ5BwL8tJC
         Lxed/7CUe8+bZNgLh/NsuXnjDrU0baMNnp9417A+Vts4hOAu/3AbfF2EsHhYtP4MVNkl
         qYCgBLNU0BxkHG3jhGWzy7Zjv3d+Y+qlqktw8Q9UTb8Yvus1BcHAgRiQhn57hVdHGGLZ
         1iew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680750386; x=1683342386;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UOeBIQkfyU+qsb7iIPWyZcajPEmOkYJng1DKgvioxsg=;
        b=BmpPXZnaqULjR/dqeaTytIuGhUVMn0U95PShsPvTbyoVMZgE+Hrh2yZfZSvmkSBvna
         iVTbIKbn22EzSG/5tVBSe5lQl8lq7fVTqym1XjQ5c4l19zttluxxqAIzDPv+rS79iLyk
         YHgSFVLWBbd9c/Qv+bf55Vrl2f2qPGJH42ty1QoRuEMujF8Oku6qTDZP88CIYPBDssH4
         0MlEodtdELgLmbcnQeZsmmM58Boh0ZfSRZTkzI9tEFVBL4IklSeYR7hJPUrZnbO63/wy
         cnweAmDpQf8F98UodpQ2S5AfPNQwvPa3vgEMC4jxnubkjhuLB7QhXH378rU1G5kQgthH
         BxkA==
X-Gm-Message-State: AAQBX9dfPX0zat05V+IVR4AbeQWjp7qBiAsKRdSGI/a1dB3nldwwwrlY
        WaCtm7SiUZzTW/hjhfjvy97jcXuIaOs/Gg==
X-Google-Smtp-Source: AKy350bLz3ijR+pGaEa3wVXJMQjLo8O/8o2uST/ZMvMcSky7qpCFH7uKA8cBCXt7poJV2zANanMxzg==
X-Received: by 2002:ad4:5e88:0:b0:5a3:85dd:ecce with SMTP id jl8-20020ad45e88000000b005a385ddeccemr2489377qvb.8.1680750385906;
        Wed, 05 Apr 2023 20:06:25 -0700 (PDT)
Received: from Gentoo ([191.96.227.90])
        by smtp.gmail.com with ESMTPSA id lx2-20020a0562145f0200b005dd8b9345aasm185567qvb.66.2023.04.05.20.06.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 20:06:25 -0700 (PDT)
Date:   Thu, 6 Apr 2023 08:36:09 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: testing...
Message-ID: <ZC43Ieg2Fu6vN7lH@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="L4KEEe+aQCG8J1Uc"
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


--L4KEEe+aQCG8J1Uc
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

testing...
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--L4KEEe+aQCG8J1Uc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmQuNyEACgkQsjqdtxFL
KRV8hAf+KzuSZr5x35kpRevgX9zfOwfmJIOtK0ivmThxgZOBOeAObtxPv2qO4j1/
oh3hVvJShFpZayfKHK76xZh+P4kEtvVwLiWluFDx9ZES/Ou8Ibqo1mJKPL0xomqH
FXEFTUQwmX4797inclTOXkYuKoHoEykX0lKtXdrBsgLp8UiB29DO9/9f8TR6Z5tc
BpbURLMKtOM0T2G59dvwcj0q2+3zooMi6UCTvW9SiLV9AOVCs5tHosbR3LI3uFN/
CG6r3distRz9hWc13WHx5XmEng/pWcyYngVZNaNv+GUHAKMTQrOskiYoifrZGgqj
8kOH8I4QeJn2rZkaFsrwXAwjr5Xqvw==
=7myq
-----END PGP SIGNATURE-----

--L4KEEe+aQCG8J1Uc--

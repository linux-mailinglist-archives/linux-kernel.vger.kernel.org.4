Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159466DA7B2
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjDGCZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjDGCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:25:34 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628197ECB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:25:33 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id s12so36105146qtx.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680834332; x=1683426332;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVV8yTepfl334PGqSY1ZvgAce+MifxI6ei+eam7TFTc=;
        b=X26V2cSRSIu8hrjYe55v/CTLuQmuVLt5RVJHz3Z/itbf5SuGOfAF+Kpw14UHLrGKVM
         ujKhLXk5B6bFm9XKpbQrsQjowLPCv9eG+X5jqQ1GoqVzu02p/ogIDIt2nOsJF5hDY/9l
         dSOIL0zyef0QU9xcQzuzVYpmrQ9jlgf2l2E2JuSKO17Pdlg9BgcNq6ulvrXDxABgo5o6
         LF38f0LB1lfDq09eo88uhGDJM4sTpJGuIKYWBwvcZbgp6dCYK/b6xH6u/7+DoVU2rxhH
         XW1QnWsiTNrQBAnmmlxlzoyiPJH/RP/k6l5xDgIZ3ZDzdr26unz/aE4pttjTd6AniJFa
         gJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680834332; x=1683426332;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVV8yTepfl334PGqSY1ZvgAce+MifxI6ei+eam7TFTc=;
        b=eC8meHblzKgEX3tSejQM8kKBKhM+12ERRyGpFWUbYCCjnhrotSeEOfHlNvJWKMBYyt
         /iu5vFnNF+9bx5I7MmDIjEuxt/wCwyiKAeclDbwTEveAkjqRU2mqZ67pLJLH2QrCpn32
         YFasSpQvHaDm97+5dXAEqnMM05dGDGZcWSYGY5bqDgL+a+EK8wvFTHb9q11nmafwriYm
         grNfzsmMu24jwkjvOYl3/xMMY9/gQR4M6Aavoze8Ja8ElsYLHZ12vv8+8jzdhMp7+24h
         61XdzTlKxCRVZqG8V93rIE3u7xqHUtgQwIwwog6UZuyijz4oMYf2IeZPwCxhi02D0GMT
         0dvA==
X-Gm-Message-State: AAQBX9fc1Chv7rt97k0FCso1jXb/qMAMfgD7W3P7FFL3E3EDxToJP1Dz
        Fx/AMYusVdusj+b8pvxxTrV3wCZF7z/FVQ==
X-Google-Smtp-Source: AKy350ZH55MIc+2c9/Fsc3yEjirR67OI+cXgWbzPE8H4N80714T6wm3COsbKLYZzVfwSy9pZUkFP5A==
X-Received: by 2002:a05:622a:11c3:b0:3e3:9199:d27 with SMTP id n3-20020a05622a11c300b003e391990d27mr1748650qtk.53.1680834332153;
        Thu, 06 Apr 2023 19:25:32 -0700 (PDT)
Received: from Gentoo ([191.96.227.146])
        by smtp.gmail.com with ESMTPSA id 69-20020a370548000000b00748448d9a7dsm942190qkf.106.2023.04.06.19.25.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:25:31 -0700 (PDT)
Date:   Fri, 7 Apr 2023 07:55:12 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Still testing ...please bear with me..
Message-ID: <ZC9/CKOJJnZigbOF@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BMx4XUMxzR4GQr3t"
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


--BMx4XUMxzR4GQr3t
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

what's going on????
--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--BMx4XUMxzR4GQr3t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAmQvfwgACgkQsjqdtxFL
KRViTwf+O7c/x5Aks/8821MZbVAjzwEfbTX6wH1DKUZ6HPw9QVIT7lF8DoozpWIU
86xcDL4rUF9xxKxVhEcm7PFZ3JZr9qLKOjwYkjy8Mz96Duq2SJwmCzTXCwFPNQMp
ztPc86omn9n31H7PiPUImEJdQ/Ep98pTjDr+e+lC3P63GSE2SGegbbzEAXCtkPVC
atabGCMGrYFU5XRPkA9uSbBdkJEfZozfZWfct+r6nbwjCp8bBFJOiCReklfz12Hk
fTTk4vYruDS/OuiChHWqWToPTyp5tOXIWfzZRroflOcyt/al/AlnfsGS9uM87TeD
Dpb65JSn8zvuU5+UbNuTOk+m7rTu3w==
=z5s9
-----END PGP SIGNATURE-----

--BMx4XUMxzR4GQr3t--

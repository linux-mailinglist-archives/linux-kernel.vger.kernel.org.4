Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4E56DA7C1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 04:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239429AbjDGCjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 22:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237561AbjDGCjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 22:39:40 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BA17EEF
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 19:39:38 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id ld14so502560qvb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 19:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680835177; x=1683427177;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3lg03Fx9M58a8zrdAMX/i/k4eX3rOvE2K/uXmBvQmE=;
        b=IZX6tW4jn/EiWG8GMSdDCbtYXjRu0q9w3S8TKcMo+mQPo5D3kjv40Inf4pK+LcJoe7
         gUhShBL+18eo7GsiUg1v/ZRmIX/tzcxxs+rJHhmE0UB39dbLuo4YEjaG+XHtZiuNw1Vn
         K4OUOP0xbCj7pxG7JesCYPgudB3ST5OWvf9UaHTYfLMOWelMljKUJu38LhO21M1cr2wq
         wHVtfYExoWDKJrDa7yY2jEiUewpzHYEmpyGinL+ORVSYtWOowKC9QTj8A6Gu9Xi4Qtki
         bcz7RtDc4mAohyMSBfTspRdBLpDjNHDxvQWK3/RkClTDSvmLgsPgj5D9kAuDFSBlnitT
         i++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680835177; x=1683427177;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o3lg03Fx9M58a8zrdAMX/i/k4eX3rOvE2K/uXmBvQmE=;
        b=2Avxtjfeqo8JCFQidihFxZoK1/TcQi4/Jv3HPcr+4ZHjo1fSfGp4oMOX3xSuoFelAY
         diEKNywIe0WQrhma6Prf2Qtqorjm0BJ+St9FcxVWdQ8OS4k6x8+5vIFlhoQp5ZPKULLs
         szdbF3U92ClYAPlvjg+G/I0pdn5vTvhI9KNppGrsEzO2RviGPqJDVfiExL6XP09/lMiU
         gkg76/54jLM6F2nMhWEoOy2f5haB6zIM3IPDI6NIrM3NC8TJlgjGz4q16W2yawxn0AwR
         m8Kt6ktIUGSW1qMci6IQnnZXfdk27MwQAu2MZv2b2u1dKlg3rZsnwgQYB/S9dzWPlOxu
         DPhA==
X-Gm-Message-State: AAQBX9eFUDhRZbxXJEL57SpyxrnskzboZUW+Ie2vusgHapTE49B6CEHT
        LkVcABq7ZJ/7jvP0QbzwbZF6/0HTDIg=
X-Google-Smtp-Source: AKy350YN1Zw7OEesBk7+Yrbbt0spBmC9aSLcjMFlhj/Je5xQRdXpQZ+AcNsCjIOwp2tXBAaylgY22A==
X-Received: by 2002:a05:6214:2129:b0:5c8:403a:22f8 with SMTP id r9-20020a056214212900b005c8403a22f8mr2350699qvc.5.1680835177226;
        Thu, 06 Apr 2023 19:39:37 -0700 (PDT)
Received: from Gentoo ([191.96.227.146])
        by smtp.gmail.com with ESMTPSA id om8-20020a0562143d8800b005dd8b934587sm999735qvb.31.2023.04.06.19.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 19:39:36 -0700 (PDT)
Date:   Fri, 7 Apr 2023 08:09:17 +0530
From:   Bhaskar Chowdhury <bhaskarlinux73@gmail.com>
To:     LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: I can not send mail from my primary mail address
 unixbhaskar@gmail.com to lkml and anybody having kernel.org mail domain
Message-ID: <ZC+CVYgKzer4NElF@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <bhaskarlinux73@gmail.com>,
        LinuxKernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HwrqS2W4iGHQmaZv"
Content-Disposition: inline
X-Spam-Status: No, score=1.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HwrqS2W4iGHQmaZv
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

  THIS IS A REAL HUMAN HERE..and who is concerned about blocking..

  I am getting spamassassain blocking for sending mail to kernel.org mail address and
  the mail to list not showing.

  It's been happening for last 2 days.

  What is going on?? Why my primary mail id get blocked???

  My primary mail id IS: unixbhaskar@gmail.com

  It also led me to think, what have I done to get blocked here??

--
Thanks,
Bhaskar

"Here's looking at you kid"-- Casablanca
https://about.me/unixbhaskar

--HwrqS2W4iGHQmaZv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCAAdFiEEs7FAjU4eq1yogJSEAkGeLcGNq5MFAmQvgk4ACgkQAkGeLcGN
q5NUDAwA0kMvGq+q65Lgk2vvEoBKB88yQRU6jjU36iPJZ6cOt+PqXdl391iEKpqk
YhlfK7aaPKb4CiUcsw+h0ofwMqZhjOCRie2ltUSmTtanghnwMZN0JRvm0S6JPzvt
+TtRtXylUjwYcnIX+J32+btGGB+dRqarLXsk6Yx2n8Z1wJLIPPUMe6L/tz8vxi2n
b3s/Axx7oV1EoJX+RJF0kvTFbvqmH9WuPHoh953v0+VSPxMzvFT5Aalv0AKEpL73
/prCfTZgSnRtEQ64use7DlFRT8BEhsCjLW6Z5Z1owqHnO1FPaubUybN+FYJyrqFh
/jOpfMVzhoVHV+98dhLdwzUTbotqS/yGhY6OBF7JQxU52oCIwCLZSDNM/79M/9OW
oHzmvKMCv30O8St1Jn9EG0HKSp194bwnuOqj8dXONHmD6aYEaN5jX36fsrcm18Vu
upfIbOd5F/K3eOnwNbeGfRjOI4RDFWZ4CtaMQux5t1DKcFrNuNRCKbprRIMsIbPZ
hV4Ozdve
=8m7I
-----END PGP SIGNATURE-----

--HwrqS2W4iGHQmaZv--

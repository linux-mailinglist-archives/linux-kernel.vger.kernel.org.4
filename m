Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E61D6EA8ED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:16:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjDULQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjDULQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:16:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D732FAD2D;
        Fri, 21 Apr 2023 04:16:12 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a6762fd23cso19127635ad.3;
        Fri, 21 Apr 2023 04:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682075772; x=1684667772;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nLyI8n2EIYCzaga9mHTo9ny1vntDxc/WNMmKD+wBoE=;
        b=MaeyHnEnghEPS5HaunQS+Za4oJYQf0mYSoyCfLDDXjXq2TMF7J3P6pK2Knw3A75FYN
         drvir4k/cHvOaAwUvoaVYBxhj/AF+nS7t+w7w2t6ddOAF7Fn12eTlZR6bxXHvWHpb1vJ
         xrUgYCRH2g1J0ZiSursfOLGFBpqc72I+1R9w4pCgzRgXFahJ3XxiaSVYS2kr6ES9NNSw
         yDu8hlWvf7MpgSl1yXy8ovrPWQim3eqvqsGe3z1SfA4W4z5MIeHUpAGJGyQxp7l24nXH
         fNLcuMfQOaCaO6OLdCOWT6uYsbdYlk0uHHBk3dTtEOZJkStuRx8j9a6wdqjbrTRHaa64
         4fSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682075772; x=1684667772;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6nLyI8n2EIYCzaga9mHTo9ny1vntDxc/WNMmKD+wBoE=;
        b=WthNEAKNlV4VpSwP23Fr9cSik+9ImduPkLe/dBxZfve/0kzve1hP2syL8b+l4dkT0Z
         UjIyAKoWWLtsTprO6GMu36CO3NtmSZIShiErCPz4K5fjaxEb262Rl6Lt7maHnFX14QHK
         vLieCykxAAQvKJb115tbRC0P6c1AUT7RsWrdmNRSE5paCmpBOSv0v/sdkul+CLu9S8SZ
         mSXOtYD/0KeYfHYO+AJ9fk+zyyQHxA189jdZAjwzqtKJPnZW6lBn42LBpboRmZT/wHe3
         RRWa4oKL2kDlfEo+pmNjFcLFpr1Ur5crz4JVgr+RZ0UkhmcbQIGa7OM8m3b2cH3C6TSy
         7kRA==
X-Gm-Message-State: AAQBX9clIl+nizCuHlLHB9+0XJEJDGkV7ntnfGMnxTUFW4IRTVO09Zfy
        Vg/8yIGrVXooIgq9mjwqJos=
X-Google-Smtp-Source: AKy350bbtHyY5+u4pqiC1wYt1bDFFkM7ZKTqmXhgR2zv354ThtU3BSor2q+V0Lyvy2jcC4aEt0igsg==
X-Received: by 2002:a17:90a:d517:b0:237:97a3:1479 with SMTP id t23-20020a17090ad51700b0023797a31479mr4889640pju.28.1682075772173;
        Fri, 21 Apr 2023 04:16:12 -0700 (PDT)
Received: from [192.168.43.232] (M111108020212.v4.enabler.ne.jp. [111.108.20.212])
        by smtp.gmail.com with ESMTPSA id iz12-20020a170902ef8c00b001a212a93295sm2559260plb.189.2023.04.21.04.16.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Apr 2023 04:16:11 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.7\))
Subject: Re: [PATCH v3] sh: Use generic GCC library routines
From:   "D. Jeff Dionne" <djeffdionne@gmail.com>
In-Reply-To: <434fe02c2c774ae4d1694ff222884bc5d5fc25e6.camel@physik.fu-berlin.de>
Date:   Fri, 21 Apr 2023 20:16:06 +0900
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E21A1070-ABD7-4D33-90BF-AB44E584AE7F@gmail.com>
References: <74dbe68dc8e2ffb6180092f73723fe21ab692c7a.1679566500.git.geert+renesas@glider.be>
 <434fe02c2c774ae4d1694ff222884bc5d5fc25e6.camel@physik.fu-berlin.de>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
X-Mailer: Apple Mail (2.3608.120.23.2.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 21, 2023, at 20:03, John Paul Adrian Glaubitz =
<glaubitz@physik.fu-berlin.de> wrote:
>=20
> Hi Geert!
>=20
> On Thu, 2023-03-23 at 11:18 +0100, Geert Uytterhoeven wrote:
>> The C implementations of __ashldi3(), __ashrdi3__(), and __lshrdi3() =
in
>> arch/sh/lib/ are identical to the generic C implementations in lib/.
>> Reduce duplication by switching SH to the generic versions.
...
>=20
> Why are the single-precision (denoted as "si") variants not being =
replaced?
>=20
> Don't we have generic versions for these?

The SH arch versions of si variants are optimized assembler, which is =
pretty important=E2=80=A6 these are things like bit shifts.

Actually, it would be better to have the di variants be hand coded asm =
also=E2=80=A6 I=E2=80=99m not sure how much use the kernel makes of =
those, and I=E2=80=99ve not looked if there is a good source of =
optimized SH versions those with the right license.

J.

>=20
> Adrian
>=20
> --=20
> .''`.  John Paul Adrian Glaubitz
> : :' :  Debian Developer
> `. `'   Physicist
>  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913


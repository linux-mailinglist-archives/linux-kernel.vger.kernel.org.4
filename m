Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355F76CD901
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjC2MAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjC2L77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 07:59:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EBF46B3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:59:38 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so62211053edd.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 04:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680091177;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZnY05NtEWyHjR6iocxGjNb46QdSIoEtvVmzDgLL6/nY=;
        b=Ag5n18VWAKaUlomjRZXe632B0aFi2u1C4ikX3hvGzajvS/m7OCRCytzktbRJdBEKWt
         Jc6Zf6DmPZ5KZ5ih/dAX/A4yQMywipE/ZEQRj0LT+4V0xUb0AmO/JYXNbGfDcs1D8loD
         VmcXQWYNcSsTDk5eZNSAIyWlBib+L4mqKo3bZO1HmTehUGIq8rM4Ezoqn0xLmwbe/TTp
         42tm/niSvSb+5vUNSAkQTZ/EnXVL1VpBJjBEnuY2ayyWkVV+nRUl2oY20o3UA1VBGrLm
         Qz+sw2MCblrO1ywqqHdYINqm2GqW2COHNDPfNpfKWS2ssDIlrzjydjKTwwyYBb/7aM07
         IWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680091177;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZnY05NtEWyHjR6iocxGjNb46QdSIoEtvVmzDgLL6/nY=;
        b=y6rLrujHTuzKJx7T0NxpG7koiL+MTKkUJrM3eU7uXI6vEqgpGEeFjLjRycl2uMIx5o
         nwdk3YodptjqKlp//+Uifa3XVqOQowIZt4+2jeg5IVmXhn8to9aeVg9aYZGgTVE9hhpT
         Mi3RJQuLaCRUzuNZ1AGPr1QhjV1/VVnQYp7+j0fO1wzn1S8ZfGho2lhBq4Dbc/Ctcrv1
         1QO1I1LIG/87Go0Yo9tN3Mb60BqgegNsk1ROpLJ9q2MOOXLxJR2OhkClnjAr0qf+c7h0
         RSKABovaIz7NIhWrh4I8UoHMRnb88RqM88zXIyUKpvo02jgsvk0ithgTqTZk6otr/YBc
         cW8Q==
X-Gm-Message-State: AAQBX9ejkNLZkXFSZQBUe3551rOjXWDHdWYSIX0YRPIv8dwH1aaBuiSQ
        m340YqaLgWeJgMmA7O8CL/89wSsRFfpwmqc7Ba8=
X-Google-Smtp-Source: AKy350ZnnTQ02Xom5stHiVAsWVUGwgg16p325cQZphgoapnEbfdZPsr7VsQfDm/wYgQjV9geQiEcrAZqkFkVIxbNz7g=
X-Received: by 2002:a50:a444:0:b0:4fc:6494:81c3 with SMTP id
 v4-20020a50a444000000b004fc649481c3mr9152472edb.1.1680091176707; Wed, 29 Mar
 2023 04:59:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:640c:34b:b0:1be:bc76:f97a with HTTP; Wed, 29 Mar 2023
 04:59:34 -0700 (PDT)
Reply-To: georgebrown0004@gmail.com
From:   george brown <crepinak.vainqueur@gmail.com>
Date:   Wed, 29 Mar 2023 13:59:34 +0200
Message-ID: <CAHwNn8LJ7vyztrFTNhn_4bWEkVp4MRig=druy5mvX-Q5L2cfpg@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahoj

Vol=C3=A1m sa George Brown, povolan=C3=ADm som pr=C3=A1vnik. Chcem v=C3=A1m=
 pon=C3=BAknu=C5=A5
najbli=C5=BE=C5=A1=C3=AD pr=C3=ADbuzn=C3=BD m=C3=B4jho klienta. Zded=C3=ADt=
e sumu (8,5 mili=C3=B3na dol=C3=A1rov)
dol=C3=A1rov, ktor=C3=A9 m=C3=B4j klient nechal v banke pred svojou smr=C5=
=A5ou.

M=C3=B4j klient je ob=C4=8Dan va=C5=A1ej krajiny, ktor=C3=BD zomrel pri aut=
onehode so
svojou man=C5=BEelkou
a jedin=C3=BD syn. Budem ma=C5=A5 n=C3=A1rok na 50 % z celkov=C3=A9ho fondu=
, zatia=C4=BE =C4=8Do 50 % =C3=A1no
by=C5=A5 pre teba.
Pros=C3=ADm, kontaktujte m=C3=B4j s=C3=BAkromn=C3=BD e-mail tu pre =C4=8Fal=
=C5=A1ie podrobnosti:
georgebrown0004@gmail.com

Mnohokr=C3=A1t =C4=8Fakujem vopred,
p=C3=A1n George Brown,

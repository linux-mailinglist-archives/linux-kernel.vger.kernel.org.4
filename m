Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE56B5F9F14
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbiJJNFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbiJJNE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:04:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9434419C28
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:04:58 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 203so12902120ybc.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfebC1hNG9FGT+3Pe0PgBda4mQUCoivjL2qFGZ8lp7A=;
        b=dFPRnKW8OTYUCMy95MAyNvGuQxuL3tx/3eHKJ36wQBKxDPUn2u3Tc22+Xu8wlXiWy5
         mssecKUfs7XypZkVo8rJwYpyuWpX8B3ZvdecqO7r11YAxcbEXknHSF0DBNSGyvMC0mww
         7x4NgncrgjcSaSctUuRDnJboMRcggVsaoJB2cHItMxEQq1iQIU5hZoLZnbM30hEkqmF6
         7emlN0eBIGNHskTVf4co7W4C1r3oOAikov3NRplcpEgX73aR8bsfIGk2Br7b4EjXvrJt
         isycCVKsqz0O0kSQz0VX4tdS4iiGgapZaau7e87PGfxci1bstJwEYjeZQE1R2IiY6VnP
         Hn7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfebC1hNG9FGT+3Pe0PgBda4mQUCoivjL2qFGZ8lp7A=;
        b=H8tDwKTcByF1xaL/rtLpCnjo1lUJp4kKcRBrJisXzDCVSfKNj2bAlrMK62zs8K1RiJ
         NFBwRGBtHxPo1Gule1hbgxe9jCSfDhk3jXDrEeOSTarsRZgez78RjT2F0ifd058Zc3Sy
         s1y50Cd8UTArHd02PzvP/gOr++chTKyG3OueHJ+63ZzkySotaAdgRy026eFh+hsjFii1
         mtWnG6gelrdKcO0X5PgbldSDxjdaUNVPJqMpDOwAdbVPpOrhzZoYrTwpO7CPuzPfupEK
         7LMETebgFLkvIuiFyPSDN5oeZyUMCKl/vkfw2A42i66F7P1VPJTTTtVF/W9OGNtWzFhX
         5OUA==
X-Gm-Message-State: ACrzQf19sMbpr3vFjGsKinAoTNf9LfPDYcyLxy0mKl3wZgpALwpwIEut
        btAlFhBgB3xI4noFhFqgDm5TV8wmBZGa3LMHUa0=
X-Google-Smtp-Source: AMsMyM4LclOS9EUwQwLWg2yno0no/woM/n3BfCQi8F5O1ezS1mcipm1ErkWvNBJVppRDVEhklxdlou8PuKo9o4sQdhc=
X-Received: by 2002:a25:e7c2:0:b0:6be:f56a:bfcc with SMTP id
 e185-20020a25e7c2000000b006bef56abfccmr17998125ybh.126.1665407097382; Mon, 10
 Oct 2022 06:04:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7000:af29:0:0:0:0 with HTTP; Mon, 10 Oct 2022 06:04:57
 -0700 (PDT)
Reply-To: contact@ammico.it
From:   =?UTF-8?Q?Mrs=2E_Monika_Everenov=C3=A1?= <kassadoctoro@gmail.com>
Date:   Mon, 10 Oct 2022 14:04:57 +0100
Message-ID: <CAHp58ihMpRO_K9tsSjhJnG_aPMea6qq3Hbhaym+D_fTAwGf-sg@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.3 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tere ja kuidas l=C3=A4heb?
Minu nimi on proua Evereen, saadan selle s=C3=B5numi suure lootusega
kohese vastuse, kuna pean l=C3=A4bima s=C3=BCdame kordusoperatsiooni
praegune kehv tervis ja v=C3=A4heste elluj=C3=A4=C3=A4misv=C3=B5imalustega.=
 Aga enne kui ma
tehke teine ohtlik operatsioon, annan teile selle
Mul on USA pangakontol 6 550 000 dollarit, et h=C3=A4sti investeerida,
hallata ja kasutada
kasum heategevusprojekti juhtimiseks. Ma arvan haigete aitamist
ja vaesed on mu viimane soov maa peal, sest mul pole kedagi
kellelt raha p=C3=A4rima.
Palun vastake mulle kiiresti
tervitustega
Proua Monika Evereen
Florida, Ameerika =C3=9Chendriigid
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Hi and how are you?
My name is Mrs. Evereen, I am sending this message with great hope for
an immediate response, as I have to undergo heart reoperation in my
current poor health with little chance of survival. But before I
undertake the second dangerous operation, I will give you the
$6,550,000 I have in my US bank account to invest well, manage and use
the profits to run a charity project for me. I count helping the sick
and the poor as my last wish on earth, because I have no one to
inherit money from.
Please give me a quick reply
regards
Mrs. Monika Evereen
Florida, United States of America

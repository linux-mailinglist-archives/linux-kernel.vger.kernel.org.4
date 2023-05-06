Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624A36F9371
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 19:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjEFRv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 13:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjEFRvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 13:51:25 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D817F1816D
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 10:51:24 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-545d82e1a1bso969684eaf.2
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 10:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683395484; x=1685987484;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXZd/Ira+adnXziXnGW6M5sQnvyHtw9vcvOhDf0qCyY=;
        b=p2kciDhPmWQZIGy2V+VuXQ9ZvO5n1eSHNps/jb1C/6jrSDSgKcTxBvrUBlsVgkYogl
         0bY2BngXMQIKGyQZONm0xfDH8azD3DovrHOjIT6SPFtUXrsbwXzyFAQq2wB3TzijZ7em
         LuelvtoI0uBycp2Olm56MrlKoVhyXoxvwO9E9DG5hAQ9mG/zTKfUjR/FdAsmJ75loOYM
         Spk5F1XR4Ja59Fbvj1gY6BYIySw47NSgw+bWewzHEMdgQltd4AvtiqcQNxsgAHWgtXSC
         0sbtfNEmfmzPkVyLG3gwakmWn81m5mnYxmUpugsULToLzbkC4AQS/Jva9KRwxstono1P
         a9UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683395484; x=1685987484;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXZd/Ira+adnXziXnGW6M5sQnvyHtw9vcvOhDf0qCyY=;
        b=efOo9cpTMipOfCrYdIbUIFC7cZHLpeTHkQDadFr3PXwwk3e/YqlKyuHZ2rBBwyZT/+
         YgV12xnvxP4HZUWTmawp94es7kj/PAgAJp6ZOfmAw+3xhzj4zGTJJAbySrkplPJPziUt
         HwD4kUnPB6MR9uG/iHM8DRO10x+ZHxdrn+1nr69sZO5Vuwy2Rh1uhDapEVYXEm2OOsFl
         5gH9rS6ISZslE6iIXMaLXMlbRNw6jaoz8oWHGlP//EE5etPpZ7ImAXKsxSv8vImYFXPv
         LWmYVI0lu5XIbF86okaa9i+aUYgAjGThFGR27OS5eL7LJGlsFsP1gC6RYiLJol58bi6m
         WNww==
X-Gm-Message-State: AC+VfDwBLeJWaWS+onOFbc4LNdqN2EeSsR9j91DCJVKtmmN3FUy400NH
        N0U3bZLOlxbW+xLPv1k2ZURP3g2q5UTcmAn7G6A=
X-Google-Smtp-Source: ACHHUZ64UvqQPwJRqi26s/Qi6BAU9Y9x1z05b8FkNcsaKlwUBUS+wQtTeY6L9IqUE01jixLTXheuyfUG309ij7OmcCc=
X-Received: by 2002:a4a:d217:0:b0:547:4f42:8ef9 with SMTP id
 c23-20020a4ad217000000b005474f428ef9mr2497568oos.6.1683395484203; Sat, 06 May
 2023 10:51:24 -0700 (PDT)
MIME-Version: 1.0
Sender: issoufd295@gmail.com
Received: by 2002:a8a:54e:0:b0:4d7:2d9c:8f96 with HTTP; Sat, 6 May 2023
 10:51:23 -0700 (PDT)
From:   Miss Reacheal <Reacheal4u@gmail.com>
Date:   Sat, 6 May 2023 17:51:23 +0000
X-Google-Sender-Auth: 8Bx4jVsKSUeXafkzV6WQe4HQX2A
Message-ID: <CAOzFqiMVAxXwAwM-wVF8by8_4GGh8aajszLamrpG4NnA4hT3Gw@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hell=C3=B3,

Megkaptad az el=C5=91z=C5=91 =C3=BCzenetem? M=C3=A1r kor=C3=A1bban felvette=
m =C3=96nnel a
kapcsolatot, de az =C3=BCzenet nem siker=C3=BClt visszak=C3=BCldeni, ez=C3=
=A9rt =C3=BAgy
d=C3=B6nt=C3=B6ttem, hogy =C3=BAjra =C3=ADrok. K=C3=A9rem, er=C5=91s=C3=ADt=
se meg, ha megkapja ezt, hogy
folytathassam.

V=C3=A1rok a v=C3=A1laszodra.

=C3=9Cdv=C3=B6zlettel,
Reacheal kisasszony

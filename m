Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77A75F51BD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 11:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJEJae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 05:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJEJac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 05:30:32 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D9E1D31D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 02:30:27 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n198so1057584iod.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 02:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=X7UEsEgJjqoNOvLJY6FO8Tvqtxut8IYL1K1nWtA4Ui76fyc6YdbJ4dnle9IV0O9KA2
         vNcjVtJDxEAyNrcYdDn4Hh058EhNW+hV35PRDyoVvQhplRT2cxek5UOFLXX8KDVN+e1L
         wcxI50AMEzfnCxpRPvIcVLWa6rKPNFL/tTjeowkFHNJN6nWe70CusOrgfyRAeNfAi4Ch
         CNkPMVSxXUIo7GYepknInryuIakQxoXU6vtEfVk3N5ZeT3nFcnr/UzX3hDb8F6KXiAsB
         heOw8t0vuhx8PLP+/WndBfEYY3BvLw1VBxYvho+kBEt4NkHrdE5edzJBMXB12mxboq/l
         2y8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=5N+aMihLorZXBHcklDfHgYNT/W4ZQvt0cLc1vwY1KVE=;
        b=Tvz33D+2dQ0JzHFblkwvE/WldiD6Rtfs3/TIQ2fcrhflEesSIPm5T0JRDiIh7n2MNL
         GiawCztGL3PzNBWM8Phr94RfzTp6cCPmoKi/XmLrverRD8q3vqvQ/POnB7FwWmYygBqq
         0PsRrpUzGjvPfc0H1oIszF7dpXhe2cOqYy27o6Jc26ZTd6rUKmD2PCh3EER8NQva08l2
         J5gLvm/N6jr/RXQvkYzCBtEj9IvGcAO9J9lAc2gd1hSdSeGXCgfTF31fNpo3GOPhHwyX
         /Gozo/7jeBjGhGeZ6N6BfRa3gV1XPi5ggHaSm0AaFmANzR4q0tN/uymraIcnxm9FzXyJ
         qTIQ==
X-Gm-Message-State: ACrzQf0uh+2d2uqmbW533Fix6N/C1LhivaOStmlCYRPvLezH9N6EfrCd
        G/aD28yk8+qy+W0evWZe4fMLjtuRFC6LKTRpLds=
X-Google-Smtp-Source: AMsMyM6p12i9TE1fLu8jd0RqnEy2qUSJ3sW8kJdZfnbWU2aUQgzklK9lcu5J3Qx/PTHy5ExjtF6H4R8icl5tetL/aA4=
X-Received: by 2002:a05:6638:238a:b0:35a:25b7:a1a7 with SMTP id
 q10-20020a056638238a00b0035a25b7a1a7mr15697554jat.92.1664962226512; Wed, 05
 Oct 2022 02:30:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:174b:0:0:0:0 with HTTP; Wed, 5 Oct 2022 02:30:26
 -0700 (PDT)
Reply-To: jennifermbaya036@gmail.com
From:   "Mrs.Jennifer Mbaya" <ezechielgnonlonfoun@gmail.com>
Date:   Wed, 5 Oct 2022 10:30:26 +0100
Message-ID: <CA+=aNsgDsCCsCaJfm8p1AVDzwM=z4gZxSVrY=VnUkrScNfqoqw@mail.gmail.com>
Subject: Edunsaaja
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edunsaaja

Nimess=C3=A4si on palkinto Yhdistyneilt=C3=A4 Kansakunnilta ja Maailman
terveysj=C3=A4rjest=C3=B6lt=C3=A4, joka on osa kansainv=C3=A4list=C3=A4 val=
uuttarahastoa, johon
s=C3=A4hk=C3=B6postisi, osoite ja raha on luovutettu meille siirtoa varten,
vahvista yst=C3=A4v=C3=A4llisesti tietosi siirtoa varten.
Meit=C3=A4 kehotettiin siirt=C3=A4m=C3=A4=C3=A4n kaikki vireill=C3=A4 oleva=
t tapahtumat
seuraavien kahden aikana, mutta jos olet vastaanottanut rahasi, j=C3=A4t=C3=
=A4
t=C3=A4m=C3=A4 viesti huomioimatta, jos et toimi heti.
Tarvitsemme kiireellist=C3=A4 vastausta t=C3=A4h=C3=A4n viestiin, t=C3=A4m=
=C3=A4 ei ole yksi
niist=C3=A4 Internet-huijareista, se on pandemiaapu.
Jennifer

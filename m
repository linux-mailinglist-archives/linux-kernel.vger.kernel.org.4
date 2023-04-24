Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27076ED2E6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjDXQyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjDXQyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 12:54:14 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE835263
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:54:11 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso2711698e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 09:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355250; x=1684947250;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2KUDEFZP19wZ14mcVH8LRkJBsOjUx+pJbT62cIKAEA=;
        b=HYh0mxk1fFJTAFCAQM0CXTz2mIiSD2jDu5CPPLEASrvS2cv5tqDhG4/wBo3VlfjO2c
         0Mis1F+BpgcOxIiUNHDwT3q00gf28ozV0EvPiWeo9kckglDlCUKRPKOd6g8Uso0G5dno
         K7a41tcfOU66hE61hos+YcE6DDRKFRfspBH1FcG+2F9ftEkKjNrmIisGKavHhGXvKLnZ
         KDbjdebbhIz46sKphuU2X2J4uJozqthLW7R80YOrHMWSjPQlAcaRXo5OuMB8sDHKUrKN
         q1lIMLEzDm+2OBggowjDIgu4054IY/ETrpmKRRI+453LrtUIEN2UYXdXC0B7GFOthjj3
         4wXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355250; x=1684947250;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O2KUDEFZP19wZ14mcVH8LRkJBsOjUx+pJbT62cIKAEA=;
        b=GBKhqE38puwriW/DgorUEJjIXKFcD5+/1c9LilfeQiPU/Cx3e9ENeDmT4ofngBfsVl
         Frv2S7UgArkexrGwkcUad19ougqflzhSW3MUNcWXCaHGODp/X/YudsCByAUSMfO1e2kV
         L5Qh5OP297qS21QYM/y3w6pxxgbjX2r1P4Q/s5r0yQTGoa/mmxNdPBbGaBjhf7m90TCP
         RSc8B4Zq3qLm3z/GZ1ZdRcusYKWmdc2BrkBWcIPIm3F013O3+HCj1xtSLG3HW5831LJr
         9AV4xqsa4U8vSFBnXaFM1uOQZp/gB2TTv0Xx8GrfTnKnsV7O9nSUUNaAb930UsvZ/pgt
         k5Wg==
X-Gm-Message-State: AAQBX9dxEdPzuIDR9lAiALB/O5deqykagdJ8IQ2yfjDJmlJs1bVNhldb
        /ivD66cE7Yv/h1uWCXEMlqf4hsMOZTRDr+w9Cko=
X-Google-Smtp-Source: AKy350aqiTwwGE8xWC+dlBb76QxS61oxL79ICrhcAHV6vrxQcXKETQQdy89jYPhp0okAmUCWoFjXeU6xGiPPkDgv36Y=
X-Received: by 2002:a05:6512:38af:b0:4ed:d216:8217 with SMTP id
 o15-20020a05651238af00b004edd2168217mr2900350lft.11.1682355249818; Mon, 24
 Apr 2023 09:54:09 -0700 (PDT)
MIME-Version: 1.0
Sender: fsgsdgdgd@gmail.com
Received: by 2002:a05:6520:3852:b0:25a:2871:16aa with HTTP; Mon, 24 Apr 2023
 09:54:08 -0700 (PDT)
From:   neemakimjohn <neemakimjohn@gmail.com>
Date:   Mon, 24 Apr 2023 16:54:08 +0000
X-Google-Sender-Auth: U8N-1XYHztC2fWecGCph2DuvoOs
Message-ID: <CAAp39bNTc7=+jKi4rKPDd=AwDY5VJgnW-LSvb7cexT_Ju83M2Q@mail.gmail.com>
Subject: My Dearest,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_RANDOM_ENVFROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dearest,

  CHARITY DONATION Please read carefully, I know it is true that this
letter may come to you as a surprise. i came across your e-mail
contact through a private search while in need of your assistance. i'm
writing this mail to you with heavy sorrow in my heart, I have chose
to reach out to you through internet because it still remains the
fastest medium of communication, I sent this mail praying it will
found you in a good condition of health, since I myself are in a very
critical health condition in which I sleep every night without knowing
if I may be alive to see the next day,

i'M Mrs.Neema John Carlsen, wife of late Mr John Carlsen, a widow
suffering from long time illness. I have some funds I inherited from
my late husband, the sum of ($11.000.000,eleven million dollars) my
Doctor told me recently that I have serious sickness which is cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way i'm going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained,

I do not want a situation where this money will be used in an ungodly
manners. That's why i'm taking this decision. i'm not afraid of death
so I know where i'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincerely and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. i'm waiting for your
reply,

Best Regards,
Mrs.Neema John Carlsen,

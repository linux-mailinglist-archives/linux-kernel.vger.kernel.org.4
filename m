Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0171557B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 08:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjE3GX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 02:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjE3GX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 02:23:56 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BD7BF
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:23:55 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id a1e0cc1a2514c-786d1095270so3144122241.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685427835; x=1688019835;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gqfo1z1GAuJQ5yt1dj3tj0LVg71YTLGwlu3xzsK7YUw=;
        b=S79w1+8U7BMH42kVmf6bTfm9N4w04aGPR5FrUOMX1MHu3QvIJb12j3ZzFb+Y20ZEAW
         7vkS8e4Mf/aMt/G3GvmzYSgBSntdQLAxCn/zcZq5/0smkSSGvnVzILAQRHszK0xHqMLD
         TzLKKTk6Rag11sohAOaKr79L9Bf8Vn3RRcYGriHwupBUhyQAemVDfquQ3uIc/AUZAJpu
         ZBGtlBfNucmvBu6UcUfWF4/N1LLg/PgCQZIPkm2uRPoC3bpn9pgWBW5J017jjwz7FUEf
         RFPhxkGCl4yLfPSEZmVJb60iNEIjL+W75eb238w7nWKeYXwJOdQCg/URwMIrNCMhGtVd
         XO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685427835; x=1688019835;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gqfo1z1GAuJQ5yt1dj3tj0LVg71YTLGwlu3xzsK7YUw=;
        b=SXaVItdyXkcldsqnxlw/CQvEN9owMmGQZfTk6Q4XPyVyg3aa25qHtjy5M+tUYLibPJ
         QIJQzvWJfkiQ58gH6McXHmjbAPE5C6a4yL10zr1gyC1CaU8nILHw8jdFW1saUetP23Qb
         j8v82d1/9LnMVWXo1SDpKOwZwC1bEwZP8ABAyt2NBAqljojwRd9V+dAjHSiB8rwnW/oK
         SdA+ShPQTy7LrYjPNKa38uadwU859C8UAbfeUZ7XPQ1MySOPYLKZe8nlocr0KgSOirgV
         uE4XFT/ewpWAeamE0Bv7eTQ5eQAnhLZLli2GPOrfjmLmanEOtxRYk04LI6ES+bpuvKFk
         wowg==
X-Gm-Message-State: AC+VfDzlK7VOSDJLbc61YeVjdruxbUYm+Au1AyFcbC0PAlctZxpiks8U
        0AJa7YiAEECEMiPvZ/lMwlu+eypGuFqkd1vgr+I=
X-Google-Smtp-Source: ACHHUZ6tuYYHX4ICEWdWdKXu3RetrdmjbVJ86ts6bcNbTaUDSr6IoxCLkN+ehabPhk1WC41WwfjuN2xzbXYBRuR3/Js=
X-Received: by 2002:a67:f6c1:0:b0:439:5ba6:17f0 with SMTP id
 v1-20020a67f6c1000000b004395ba617f0mr377888vso.5.1685427834766; Mon, 29 May
 2023 23:23:54 -0700 (PDT)
MIME-Version: 1.0
Sender: kalunjokukk@gmail.com
Received: by 2002:a59:ab0d:0:b0:3b7:3490:819b with HTTP; Mon, 29 May 2023
 23:23:54 -0700 (PDT)
From:   Hannah Wilson <hannahdavid5578@gmail.com>
Date:   Tue, 30 May 2023 06:23:54 +0000
X-Google-Sender-Auth: m3gEBRoEXDGceJRvO-8MQM8kiYo
Message-ID: <CAHTzh19A+1XifdWwwbkZANFQg8p-NQ4JYqAEnekX7CoCHBqfWw@mail.gmail.com>
Subject: Good Day My beloved,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:936 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kalunjokukk[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

please i really need your urgent assistance.

Please do not feel disturbed for contacting =C2=A0you in this regards, It
was based on the critical health condition I find mine self. =C2=A0My names
 are Mrs.Hannah Wilson David, a widow and I=E2=80=99m suffering from brain
tumor disease and this illness has gotten to a very bad stage, I
 married my husband for Ten years without any family members and no
child. =C2=A0My husband died after a brief illness that lasted for few
days.
Since the death of my husband, I decided not to remarry again, When my
late husband was alive he deposited the sum of =C2=A0($12.000.000.) with
the Bank. Presently this money is still in bank. And My  Doctor told
me that I don't have much time to live because my illness has gotten
to a very bad stage, Having known my condition I  decided to entrust
over the deposited fund under your custody to take care of the
less-privileged ones therein your country or position,
which i believe that you will utilize this money the way I am going to
instruct herein.
However all I need and required from you is your sincerity and ability
to carry out the transaction successfully and fulfill my final wish in
implementing the charitable project as it requires absolute trust and
devotion without any failure and I will be glad to see that the bank
finally release and transfer the fund into your bank account in your
country even before I die here in the hospital, because my present
health condition is very critical at the moment everything needs to be
process rapidly as soon as possible.
It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total fund for your effort in
 handling the transaction, 5 % percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country
for the mutual benefit of the orphans and the less privileges ones.
Meanwhile I am waiting for your prompt respond, if only you are
interested for further details of the transaction and execution of
this  humanitarian project for the glory and honor of God the merciful
compassionate.
May God bless you and your family.
Regards,
Mrs.Hannah Wilson David.
written from Hospital.

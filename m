Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22E806D9363
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 11:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236373AbjDFJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 05:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbjDFJ5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 05:57:02 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 883DE213C
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 02:54:57 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54bfce685c1so60507577b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 02:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680774896;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RL1TOmbfDQsCZo4rWR1Lv+Dsrw4YXyc8lTl3EBbobLk=;
        b=nK7zpsJkD56xOUrSbcARIuqCP+FTg3XLvWi0tQxPnrtfe50Nln0AxWrKYznVWe44/x
         azKQ7EtAoIwd7lzy1RKIKaZlYpeG2LciCeLXdtZTEMy9tLjqB3FE4xVIast/jQlHjpTH
         ZgvD8Mu4BOFwWt3lbWrj2CAml89tmedOtKfqTXwBoZQUcEAfWEdfjkJyy8/bBq5BCIsT
         BrCh6Q42oUCoGmf05nmt6LMSt0hJ3vQb8s/y+QB/KJss53Y4oNrjFKrvqaWQ++zwwdFH
         IMFRW2AFznPqHBSOWZBnF/yOYU5fV6uavSxSVC+b0YSJyXyvGzCwodBnlQ9tdvLgBSST
         jMbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680774896;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RL1TOmbfDQsCZo4rWR1Lv+Dsrw4YXyc8lTl3EBbobLk=;
        b=Ocsi8dhSX6H6tj5LjkDPpw08gXMDHSbjlpgzylHK99DQYfFZikxS9Bi/xTOYm3oroO
         K6YgCbGG/B6fM5yPn2hZzJWDzh4iklgWdvzpomZ6+EQhqM49HB6vsQY+tDWL3Gx9pTrm
         sLrCGC7vcHXn3E5WTq8n79KTixwBiRLRxC3qdO+YYGSB1/e+pIOFR8mTNL9KopuJAtwO
         DLG7e0OcnZjr7bqrFBRM8qCrGzpqZIUOvsYLPC4GEiFT+5jpMiA4qVc29A27cTRUlWyH
         QL9tgks887nyW3XIcPVeIKkXK4ZmdVzt3m+BZu/nDf0G2tZ34wBQiXZ6LOyQtBy/nAPS
         rJGA==
X-Gm-Message-State: AAQBX9dt7GsMbj/z6B1goVcOdCEJOn3ixgEwTrVi5dYaKBK+fxMGVgCA
        se8Kb1e5QyubIXygH6kFE9gnEu/ZwCV9Jo2hHL0=
X-Google-Smtp-Source: AKy350ZMVzrsoEbaV31+8rDDAWAzes0BAdtHPyVvLxosPUoR64i8CjZdvkPVBNC0FhfDICgBZibtlYGzW00pCz4Ls8U=
X-Received: by 2002:a05:620a:2909:b0:745:3e2c:3d5a with SMTP id
 m9-20020a05620a290900b007453e2c3d5amr2392509qkp.12.1680774413971; Thu, 06 Apr
 2023 02:46:53 -0700 (PDT)
MIME-Version: 1.0
Sender: drjusticekelvin@gmail.com
Received: by 2002:a0c:e2c5:0:b0:5b0:ea35:a935 with HTTP; Thu, 6 Apr 2023
 02:46:53 -0700 (PDT)
From:   revfatherjames <nancyibrahim324@gmail.com>
Date:   Thu, 6 Apr 2023 09:46:53 +0000
X-Google-Sender-Auth: 4mOma6EaDLLqJJ35Z_9JSXT8Qws
Message-ID: <CA+69S51KT5Tf-c-foVzQ27utdCBG9zmgr-CyEyzKJ-J5dhjH8A@mail.gmail.com>
Subject: My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1134 listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [nancyibrahim324[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 HK_SCAM No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dear,


Please bear with me, I am writing this mail to you with tears and sorrow
from my heart.

 I am Miss Nancy Warlord Ibrahim Coulibaly, I am a 24 years old female and
also a medical student from the Republic of Ivory Coast, West Africa, I am
the Daughter of Late Chief Sgt.Warlord Ibrahim Coulibaly (a.k.a General
IB). My late beloved father was a well known Ivory Coast militia leader. He
died on Thursday 28 April 2011 following a fight with the Republican Forces
of Ivory Coast (FRCI).

https://en.wikipedia.org/wiki/Ibrahim_Coulibaly

Nevertheless, I want you to understand that there are still genuine and
legitimate business class persons in the internet world today so I am
assuring you that this transaction is 100% genuine. You can give it a trial=
.

I am constrained to contact you because of the maltreatment which I am
receiving from my step mother. After several years of the death of my
beloved father passed, One faithful morning I was cleaning my father=E2=80=
=99s bed
room when I discovered a brief case containing some valuable documents that
states that I am the next of kin to an account deposit in the neighboring
country Burkina Faso with the total sum of US$12.8 Million. Ignorantly out
of excitement, I rushed and informed my step mother and that was when my
problem started. She conspired with my uncles to kill me by all means but
failed, my wicked step mother tried to poison me twice but I survived it
all. After which I escaped to Burkina Faso by road because she seized all
my travelling documents.


Now I am passing through a very difficult situation in the refugee camp
here in Burkina Faso where I am hiding with total fear and agony because my
wicked step mother can go to any length to achieve her motives. I have
contacted the Bank to clear the deposit but the Branch Director told me
that being a refugee in the country, my status according to the local law
does not authorize me to carry out the operation, and insist that I will
have to appoint or present someone to stand for me for the claim. However I
am seeking for a long term relationship and investment assistance from you
to stand as my trustee and partner so that the bank can transfer the fund
to your account in your country, And for you to also help me to come over
to your country for investment and to start a new life again as well as
complete my studies in the school of medicine which have been the wish of
my beloved late father. As soon as I receive a positive response from you,
I will not hesitate to send across to you all the information concerning
the deposit. And I promise to give you 40% of the total sum for your help
and assistant.please contact me via this E-mail=3D(nancyibrahim324@gmail.co=
m)

Waiting to hear from you soonest.

Yours sincerely,
Miss Nancy Warlord Ibrahim

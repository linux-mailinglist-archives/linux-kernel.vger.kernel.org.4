Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B180D5B50AF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 20:41:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiIKSl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 14:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIKSlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 14:41:23 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB42127FC9
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:41:22 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3450a7358baso76219107b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 11:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=WG+RdUuUEyk7LRTVM31iORwh9ysLyZm3eQt+kO0Z8AE=;
        b=JQFtZxpsmN/1ojPn8NUziq8h5g2YeaFh3cUtuzkrDbelgKf9JNGGxsrqaqcoNemahJ
         VFg+/Dpw2zP+8s4jlGr5E3kD6aZKrF77S/qExhg3QGv99052mObhs+/9RL76mBV8NZ+v
         Xy5ZYyeIXDCGvgrSbIk0QhvzVUG4m6FTo/k8SnjiA2GJdzcE85MT21vrw5Eh+hel+KFj
         JIXTRMuPCF2/SCSJQcYpUrsCW/MCTg0iiHm3STAVGV999L8kfRf/Esnf0DnYWjtOsOBg
         Q8GGHC9sat8xbHVJm2OVpG+Vy45l43N1ymhq64Vf1EiZEMB6QiNpqN+q8t4upIzrwbnX
         NVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WG+RdUuUEyk7LRTVM31iORwh9ysLyZm3eQt+kO0Z8AE=;
        b=65qKxwyPEAGxwfcxoOrR/mDviXDwsBaBTfqt6K9V0+KaU9+mUGI9mVzwd4fQU/+jIx
         2IIOn2Sh6wtf9VbpeLPZNC0PzLLpFm109OHVUWjiNGiAWC2NGoYpWR1rfYghYWNxSuEF
         tBfVvCk1YgdHvA6usq1gtDLYZm4TzPhnlbHgucWW0Iz29CDxlk3t+VEpp0ylW6KfQ60C
         P/yemMDrVhukTHjA6wM6FKafYP1iASniPQiW3/POi7dAz47Y5pk+vQXGelAlc9AcMCBU
         /M6Q816Q2/MwR8V7ISQEYHpXH8AeVRhhcOK6mlu9yTEmsD4lFIj4gsYJdV/2jvQOeq8f
         ERmg==
X-Gm-Message-State: ACgBeo3U86F/GYnM2tQ3lv31rMeu5inNOnnmJrW8q97nH0d+2dphf3Bk
        Le6sBnegco0bJEOBI8ePe9QOueNIZUOiyk3nwVU=
X-Google-Smtp-Source: AA6agR7bVyjgpvFYGsgHBvLM2GNafrRqv68R0NNYD4U5DM4X5ig7iBS0SdLGGt4DCFZZeRKSzZjl0ngF+arflVHc58c=
X-Received: by 2002:a0d:d2c1:0:b0:33e:e1f4:4bb0 with SMTP id
 u184-20020a0dd2c1000000b0033ee1f44bb0mr18820406ywd.234.1662921681926; Sun, 11
 Sep 2022 11:41:21 -0700 (PDT)
MIME-Version: 1.0
Sender: a.ragnvar50@gmail.com
Received: by 2002:a05:7000:bd91:0:0:0:0 with HTTP; Sun, 11 Sep 2022 11:41:21
 -0700 (PDT)
From:   Mrs Aisha Al-Gaddafi <mrsaishagaddafii46@gmail.com>
Date:   Sun, 11 Sep 2022 18:41:21 +0000
X-Google-Sender-Auth: koRuNlrVjIZtnEKm5AdJfVDWjFE
Message-ID: <CADmpa4H5BA0L=A_=vCvA_0JX2LRvqLFH-GEtV=--z8aVEjUUKA@mail.gmail.com>
Subject: Please I really need your urgent Help Now
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_99,BAYES_999,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112d listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 0.9997]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 0.9997]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsaishagaddafii46[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [a.ragnvar50[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good Day To You My Beloved Friend,

How are you together with your lovely family?

With due respect to your person and much sincerity of purpose I wish
to write to you today for our mutual benefit in this investment
transaction,


I'm Mss Aisha Gaddafi presently residing herein Oman the
Southeastern coast of the Arabian Peninsula in Western Asia, I'm a
single Mother and a widow with three Children, I am the only
biological Daughter of the late Libyan President (Late Colonel
Muammar Gaddafi) I have an investment funds worth Twenty Seven
Million Five Hundred Thousand United State Dollars ($27.500.000.00 )
and i need an investment Manager/Partner and because of my Asylum
Status I will authorize you the ownership of the investment funds,
However I am interested in you for investment project assistance in
your country or in any good business that will give us a good profit or in
your company there in your country or in any part of the world, hoping
from there we can
build a business relationship in the nearest future.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds,

Your urgent reply and help will be appreciated if only you are interested in
this investment project and helping us out,

Sorry if you received this letter in your spam, is due to our recent
connection/network error here in the country.


Best Regards,
Mss Aisha Gaddafi.

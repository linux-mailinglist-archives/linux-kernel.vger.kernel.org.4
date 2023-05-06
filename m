Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B0C6F928C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 16:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbjEFOoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 10:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjEFOoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 10:44:07 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523761C0CC
        for <linux-kernel@vger.kernel.org>; Sat,  6 May 2023 07:44:06 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id 6a1803df08f44-61b72fd8cc0so14333356d6.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 May 2023 07:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683384245; x=1685976245;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=gcr5Ita/y5v0LlvW7jUeJcjD0k1RFvfOg/69JE90noZJdn09hmLafEZW9YwmoLX0T6
         Ud+XeJ50LGHNK/xOAY0nj40TKcfuFxPQ69AVvVNlegs7ywqvA5byT5pl2xf4CH6F99S/
         b2rvsq5c9jJUhY7UYLo0xEPD+2abNrqHYE+hwgTQK2I1oZPenYCdtvxDCMr5LYltC1gm
         zXiiMYkjai/iU+KrPPS5IkGNDjMqKJ+U8aPH9vhl6YkfT1LWYOBQ084KZqS+8f5kmPBx
         OcSdUYQKaZP9+4KQhAoMNyuAmPvjyPueKZRibYG4a3jN6NwC0wnoqz2PlC7BPHJflq3U
         ltMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683384245; x=1685976245;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rHWukX/982VVQshnDvvj6GQbQddSOFHJAD6q40l/44=;
        b=UfeVbor6NNIkXrLREwyRUtw73VPhGqTzJUmJXNRJ0wjLlGO25swF76EwXmZl28arLa
         o8jfFtqRJj/sObNWftm3bsptt0N+Tor60PWkjyTnsaUiuVFMfBcsMQFrH7ACf/lotyH/
         l3G6UERy0p7uHp9EnMTCx6aAi1s4uR3nT2b8x9C1s3FZGjqUkcpAUST20ANTtc6KTmSg
         QF9iCQAdIJCg2EivUvcQDyF+fSDz9XxC2Y4//sX0L9miwtRQprLuE1IOcVmLWLgsBSLO
         q0Slu636q7rQOawXf5RRW0fA7J7MwxYUcRNHv7PF8KTLtsFi0x5ZvDq3RvH3YU1FEsmL
         dQ4Q==
X-Gm-Message-State: AC+VfDwAYUt4uZBLMGFecqYPI/xpZJyflNj9XZ/k7+/Htb6ygU6dm9yj
        oXb7jZ15AeMgdXecFYJKMLii9cf7dEr+UE140mE=
X-Google-Smtp-Source: ACHHUZ4iCUbQRfJ6cAzxhdJOX1dZIPO1qfNCY/9V2bC4v4vtURNntJQ/sqXOsFAASxtqmHlGAG//BOMRUmoNyesn24U=
X-Received: by 2002:ad4:5ecf:0:b0:5ef:4233:ee7a with SMTP id
 jm15-20020ad45ecf000000b005ef4233ee7amr8092705qvb.2.1683384245365; Sat, 06
 May 2023 07:44:05 -0700 (PDT)
MIME-Version: 1.0
Sender: yesminesamih111@gmail.com
Received: by 2002:a0c:a942:0:b0:5ad:a8e0:f384 with HTTP; Sat, 6 May 2023
 07:44:05 -0700 (PDT)
From:   Juliette Morgan <juliettemorgan21@gmail.com>
Date:   Sat, 6 May 2023 16:44:05 +0200
X-Google-Sender-Auth: CceBGFKh06Dwhk3wixTx6jUMYZc
Message-ID: <CAC+tdQg_ceT2Sk4r3n+VUp2hwhivtFd60dJQE_dsfr+YT9XEuA@mail.gmail.com>
Subject: READ AND REPLY URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [juliettemorgan21[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yesminesamih111[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dear God,s Select Good Day,

I apologized, If this mail find's you disturbing, It might not be the
best way to approach you as we have not met before, but due to the
urgency of my present situation i decided  to communicate this way, so
please pardon my manna, I am writing this mail to you with heavy tears
In my eyes and great sorrow in my heart, My Name is Mrs.Juliette
Morgan, and I am contacting you from my country Norway, I want to tell
you this because I don't have any other option than to tell you as I
was touched to open up to you,

I married to Mr.sami Morgan. Who worked with Norway embassy in Burkina
Faso for nine years before he died in the year 2020.We were married
for eleven years without a child He died after a brief illness that
lasted for only five days. Since his death I decided not to remarry,
When my late husband was alive he deposited the sum of =E2=82=AC 8.5 Millio=
n
Euro (Eight million, Five hundred thousand Euros) in a bank in
Ouagadougou the capital city of Burkina Faso in west Africa Presently
this money is still in bank. He made this money available for
exportation of Gold from Burkina Faso mining.

Recently, My Doctor told me that I would not last for the period of
seven months due to cancer problem. The one that disturbs me most is
my stroke sickness.Having known my condition I decided to hand you
over this money to take care of the less-privileged people, you will
utilize this money the way I am going to instruct herein.

I want you to take 30 Percent of the total money for your personal use
While 70% of the money will go to charity, people in the street and
helping the orphanage. I grew up as an Orphan and I don't have any
body as my family member, just to endeavour that the house of God is
maintained. Am doing this so that God will forgive my sins and accept
my soul because these sicknesses have suffered me so much.

As soon as I receive your reply I shall give you the contact of the
bank in Burkina Faso and I will also instruct the Bank Manager to
issue you an authority letter that will prove you the present
beneficiary of the money in the bank that is if you assure me that you
will act accordingly as I Stated herein.

Always reply to my alternative for security purposes

Hoping to receive your reply:
From Mrs.Juliette Morgan,

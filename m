Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273916E209D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjDNKVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDNKVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:21:01 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C205F4C0A
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:20:58 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id q26so10544962lfe.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 03:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681467657; x=1684059657;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c5/kW0JzoFw+YKbeFST8xZQgociR8TLzS9I3yw2B+4M=;
        b=CQkSEATqmnjm/pqVeGXxndwBXMa5jdmbWDgffkjHhREBkoZ6LDJUmNDizI7It4hTgI
         ik6eXWFNxzfiNlpXSZ+k6mfov6otcGyUL6yzANtkzyFRnI5Dxcll7LRTek4bq2asAUvv
         +24up35KHwE+r8SdFe3B2gHjCEHSZHZorAC7yE2luH2GhCRgobx/2/0E1D+Mgi2rRhwI
         ZUOVTx3QAovOQGc6JGM2gHuXiYDuHGA+H/mmBZaDHrAIR5+gqJGyl0I2RCfJOXicCvN/
         VcdakfEgJVyw88YXaP4VrOdY2MZuf8R9ZpVs7W9B9OgxMmbrgYgZz21voURd++8inAPc
         qp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681467657; x=1684059657;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c5/kW0JzoFw+YKbeFST8xZQgociR8TLzS9I3yw2B+4M=;
        b=gkWL/QZF4dgIToA+yLcqo+7YES7dW+COLp6QcpHKFOuBBQEi+zXZc+0sO4eQygTsRL
         hAklvxzaAMTrfp/0XAM9G6gPW+eoGiAWIiP9lJZACFYPwZBNnCKw2U+s6cGdNRLhVVTj
         P2cUm2iOUjW1oT+mMISA5kdZZHhr7TPANYfrq/HHyB5TorjHezeQdkBGSj2wYnVnEu7o
         kYvKjeDi4cBOZJHOS6v1cCLy1q7SPhRVUOHE7uI6909+ecmSOaL4awujdi0777smO01K
         ZeTq7kvGySNa0J19rRDhFWg6LKQXZ4zfXlBTFKefwxKKTK+0yoi+igtsDF0WZbYRvI9X
         2hyg==
X-Gm-Message-State: AAQBX9coRtwWmvevWdPughPevkJ496cbdSYDWDe5Lg5spY02UKtPFuC3
        yvDBzne/rfIZe2yO0oXAS4OMRh78+mQY7iuSXGk=
X-Google-Smtp-Source: AKy350YSBgI++YOnR9PO1/ffG5scloNSnnCezGOpqvT/m7ePw3fjRe5x99JVlYjU8+C5cL4wHxT86HXrY4chlVuFSmA=
X-Received: by 2002:ac2:5931:0:b0:4d5:ca42:e438 with SMTP id
 v17-20020ac25931000000b004d5ca42e438mr1761806lfi.1.1681467656735; Fri, 14 Apr
 2023 03:20:56 -0700 (PDT)
MIME-Version: 1.0
Sender: kelvinmorrison60139@gmail.com
Received: by 2002:a2e:9019:0:b0:298:594e:8a76 with HTTP; Fri, 14 Apr 2023
 03:20:56 -0700 (PDT)
From:   Ms Alina Serhiy koval <alinaserhiykoval739@gmail.com>
Date:   Fri, 14 Apr 2023 03:20:56 -0700
X-Google-Sender-Auth: k5xPVBdJFlcSeOUO_-QQAYHDoTw
Message-ID: <CAKZ1qY+bJn8j6BVx59MYeo70iZNp_6-1tcxsx=DESLsWWQa1jw@mail.gmail.com>
Subject: Dearest
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,YOU_INHERIT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12e listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kelvinmorrison60139[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kelvinmorrison60139[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.0 HK_SCAM No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.2 YOU_INHERIT Discussing your inheritance
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest,

Good day . I'm really delighted to communicate with you and I believe
we can achieve everything together and create something great . My
name is Ms. Alina Serhiy koval.  and I'm a young girl of 24 year old
from Kamianets-Podilskyi  a city in the Smotrych River in western
Ukraine and presently I am residing in the Republic of Burkina Faso as
a refugee due to killing of my father by the Russian forces firepower
. My mother died 8years of ovarian cancers .My beloved
father(Lieutenant Colonel Serhiy Koval) was a Ukrainian military with
the 10th Mountain Infantry Brigade and also the top minesweeper with
Ukraine=E2=80=99s 143rd Landmine Defusing Center as well as the Head of
western Ukraine Investment Authority.

The brutal killing of my father took place on  April 30, 2022 by the
Russia soldiers in Donbas city  as a result of the ongoing
Russia-Ukraine war in Ukraine. I was in my first year in the West
Ukrainian National University (WUNU) studying Arts & humanities before
the sad incident and that led to the death of my beloved father.
Darling, I know that it is too early to disclose my life story to you
but please bear with me. My living condition is very critical, please
I need your possible help to reclaim my inheritance and start a new
life. My uncle have sought to kill me so that he will have full
control of my father's estate but I am happy that all his evil failed.

Meanwhile, I decided to travel abroad in order to secure my future but
the problem is that since I don't have an international passport, I
cannot be allowed to enter any Country freely and legally. However,
the only choice for me was to enter Poland, because it is not far from
Kamianets-Podilskyi as many people are crossing to Poland so I joined
them and crossed over to Poland. It was in my presence that the Poland
soldiers gunned down Nechai Dmytruk a famous activist at the Poland
and Ukraine border. A lot happened during this conflict, it was awful,
I only thank God that I'm alive today.

I arrived to Burkina Faso through the help of International Red Cross
and Red Crescent Movement, they were moving people away from the
Poland border because of the too much crowd and insecurity of the
border, so they moved some people to Slovakia, some to Moldova and
Turkey and few to Morroco and Burkina Faso. I decided to come to
Burkina Faso, because when my beloved father was alive, he revealed to
me about the sum of $27.5 Million which he deposited in one of the
Banks in Burkina Faso with my name as his next of kin. On my arrival
to Ouagadougou, where the Bank is located, I contacted them to clear
the money, but the Branch operation Manager who confirmed the
deposited amount of money told me that my status as a refugee
according to the Laws of Burkina Faso does not permit me to engage in
any Bank transaction. He advised me to nominate a trustee who will
stand on my behalf and carry out the operation. This has become
necessary after I have been denied the right to own a Bank account or
perform other forms of financial transaction here because I am a
political asylum seeker. So, I decided to get in touch with you so
that you will help me with the transfer of this money into your Bank
account for investment in your Country. After you have received the
money in your Bank account, you will send me some amount of money to
process my traveling papers because I want to relocate to your Country
where I will start a new life with you. And I intend to complete my
academic studies in your Country. I accept to share my life with you
and give you all my attention from day one of the meetings.

Immediately you confirm your interest to help me, then I will give you
more details as to how we shall conclude this transaction. Please do
let me know if you are interested in helping me with the transfer of
the money into your bank account for possible investment in your
Country so that I will send you more details on how you will stand as
my trustee and finalize the transaction with the Bank where my dad
deposited the money. I beg you please to keep this as a top secret
between us for confidential reasons. At the moment I am living in the
Mission House. Life in this place is very unbearable because we are
not allowed to go out and we are monitored by the Church security
guard. Please help me because I want to leave this place quickly to
live my normal with you.Reply me on my email address
(alinaserhiykoval739@gmail.com)


I look forward to hearing from you soon.

Yours truly
Ms. Alina Serhiy koval
(alinaserhiykoval739@gmail.com)

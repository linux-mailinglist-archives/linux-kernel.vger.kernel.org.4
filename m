Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0E063BCB2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 10:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbiK2JP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 04:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiK2JP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 04:15:26 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3854FFB4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:15:25 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id l2so8463504qtq.11
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 01:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+7MBpQKLL8OmJu5cggvE3gGtXKaySkUPtB/3mMasiDQ=;
        b=STqM0lyt6v6Wj9u7PVl2nTKgWEQ7nN3b+sFiXtsVvISEIMVG9lqXqLuk+B2BrFqtcJ
         pSGe6LMAMHLrmqcXoZjxQcmLMze480Gq4JlmQ6o+I+j3dXJyVBm9tlgIt0lX4qgK6rdx
         qJOgHi8eq7Q2fmW+kqVcSeS+luYj1x4dfFOAs9uj1171Xe0YsqwYE5LAcPxP+6faPDQQ
         M5FGOAeq8COJ+16JvMW9EQsFN5gytPfLs9Bj1hJn+6jmfRO3QouwmixBPYDmvPzE+sA7
         QvweDceRfReA1JKDY0PB6jwkStGoT0aYpCMn8UJjnP/vAA4xFvJ4BC8J4wwJI+4lBWiv
         UIUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+7MBpQKLL8OmJu5cggvE3gGtXKaySkUPtB/3mMasiDQ=;
        b=z2nx3Eu0cSja0AnHxZ32xwJU3/lvaxh/DxCMyKqac+3WNGj1UyXw5MT+qWFXk9lJ6B
         HQvENR/fXIjf7t9EuAi6aUfD6mFuv8oCyvF4DHpxPysghdX+RFIOn6KwvzaJD32ZUP7v
         bRIs2AR/mrVq58Ouo4t3w3NWUxmBmBw9aGJeApSQBBEzlTK9s4WOzuuXrEhgeKwUaLV4
         K9lcTlW4uTO25knT6Gd7es81JVgB/vHTq7WT1Wws6Mt729wOoAKOf+0Hci8ONJwJTY2e
         TjFoYtMWnc3Lrr174UqWO+OlkNdByfTT4b6t/BFZXxZ2KmqPxQiA0AKevwe4fSA5q75Y
         rSig==
X-Gm-Message-State: ANoB5pkBK63BVGRkZqby1xusdiyoqMYmbRdd/7jPI+mHau5mDcwGVl+V
        1ShUd56enwUKWsbKJIXHM2c1YYg5blffEluqnhk=
X-Google-Smtp-Source: AA0mqf7JgGPhukXPDQsIoC3rtrtDj6YyPPxWrM7S7mUlmnnAVovSYhBFPn465hw6LjDQNUB6v3WFqpXyZS8DnrPHpHc=
X-Received: by 2002:ac8:4b66:0:b0:3a6:7a7c:a417 with SMTP id
 g6-20020ac84b66000000b003a67a7ca417mr7577815qts.296.1669713324531; Tue, 29
 Nov 2022 01:15:24 -0800 (PST)
MIME-Version: 1.0
Sender: kaboreseniks@gmail.com
Received: by 2002:a05:622a:188e:b0:3a5:c2d0:3ece with HTTP; Tue, 29 Nov 2022
 01:15:23 -0800 (PST)
From:   "helen.carlsen" <idrissuleiman01010@gmail.com>
Date:   Tue, 29 Nov 2022 10:15:23 +0100
X-Google-Sender-Auth: LcGAx-jrcU-z0WRD2uKTTVAUgpo
Message-ID: <CABBmOo+n=Tv3YnL6szvEAUntBaec+dqTKf7ObFtGAf=-3k=fiw@mail.gmail.com>
Subject: Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.8 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_FROM,LOTS_OF_MONEY,
        MONEY_FORM,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:82c listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kaboreseniks[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest One,

With due respect to your personality and much sincerity of this
purpose, I make this contact with you believing that you can be of
great assistance to me. My name is Mr. Idris Ibrahim, from Burkina
Faso, I'm the Director of Foreign Remittance Department of African
Development Bank (ADB) Burkina Faso, Please see this as a confidential
message and do not reveal it to another person because it=E2=80=99s a top
secret.

It is with trust that I wish to contact you on this matter concerning
the transfer of US$17.4 Million Dollars. This money came out from
Contract that was awarded to a foreign company for Maintenance of OIL
REFINERY PLANT in Burkina Faso years back. Contract
No;SONABHY/EPR/104/PED/2004, The contract was over-invoiced by me to
the tune of US$17.4 million Only, and this fund is in our bank here in
Burkina Faso and that is why I contacted you to seek for your
assistance in helping me to claim the fund from our bank as the
beneficiary of the contract sum as the intermediary company so that
they'll transfer the funds to your bank account, i will give you 40%
for you and 60% for me ok.

(1) my  full name: Mr.Idris Ibrahim
(2) my  age: 52 years
(3) my occupation: Banker
(4) my marital status: Married with 4children
(5) my  full residential address and country: Pascal Zagr=C3=A9 Avenue 01,
BP 1603 OUAGA 2000 Ouagadougou, Burkina Faso.
(6) my direct phone whatsapp +226 77 88 3617.


Meanwhile I shall also expect to receive your personal information as
well as I requested below.


(1) Your complete names/company names
(2) Your age
(3)Your occupation
(4)Your marital status
(5)Your full residential address
(6)Your direct phone numbers

note that this transaction needs utmost Confidentiality pending when
the money is credited into your account. I'm looking forward to your
favorable response in this matter


Thank you for understanding,
I am waiting for your positive response,
Mr.Idris

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38A027238D1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbjFFHUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjFFHUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 03:20:37 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6DDE6D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 00:20:30 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id 5614622812f47-39a55e706deso2331389b6e.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 00:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686036030; x=1688628030;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=G9r2yweUHQ3JXpA9GWafJKmfTXMb1iWwfMGEfaRRLuEYd+F0buueuhe1vrSLl+bwSH
         3xsi/8QuvvFrkbHbRpvv0cjZFjo03ysuwM0/1sVyO0VsoiDSTBrMV4H+Ulk3ixXVgRKC
         LrTP0sCEY5SdopxwdTRoOJvasbUzWBy3hBAQ4yF9+ifHRhf4c47EjzGD7r4iuGnaAbYR
         YG+ACOvs8OIiOUwwWpYwEcvOEwVGM29R7yyCkVQev6VkH47fdcF6goRPk/FAx7kNZteN
         MJCda1Xz8h/FRIG3eJiuLb/yQjuwAIHVD4jnkc9vSL8Vv2j3MzUe+4+UyD5t0k/0Y1vw
         E6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686036030; x=1688628030;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=SS6mBzKxBta2dL4zxW4RMpvDldOq08dKAfWK0nce+ag64e+mDkFAQDl5EPYuJjhmst
         LOz96Lh1qn5NpYYDVEslUSqwZFBlMp1b/89B7R8UrYWMb3+bCFaQlDF5d3uzo9xJjdri
         FXwYOzEDsP0vh+mFTlba5PrH77JN/jtjqTxoZGSHHzmLyjBiY8IvFrBTmtwuU7OP/jtv
         1QkqQxnUoaMzXGARtPQICxCNYu5hvjo0RTLIDNrOfC4ju8FvgiGnqQI7F9n0xsixZ738
         sO2WF+Dpg/9Tk32MyNJ7JgLoy1NACoQ8de1opVh9T8kLxh/4Jl88nLivF/yZtQmV6dkI
         PjiQ==
X-Gm-Message-State: AC+VfDwoMwehVdEbziA29KQ/8S1mjGjEoDkknczEPiqHyimxkZwpvT3z
        yrpj4m4pF/h83xmIJm3fpV5zRIihnQypEGhS98c=
X-Google-Smtp-Source: ACHHUZ5ARCJ6qd9Cj9sKgs74TD5SizgBBqpD7OYHGg5RRuC1FEqI0KORmsEKlGWsqKVO8fOUE9sc11VaprqzMkKjzLc=
X-Received: by 2002:aca:1908:0:b0:395:eed6:5193 with SMTP id
 l8-20020aca1908000000b00395eed65193mr554085oii.10.1686036029852; Tue, 06 Jun
 2023 00:20:29 -0700 (PDT)
MIME-Version: 1.0
Sender: mrslila67hber@gmail.com
Received: by 2002:a05:6358:ee8c:b0:125:9468:d123 with HTTP; Tue, 6 Jun 2023
 00:20:29 -0700 (PDT)
From:   "Mrs. Lenny Tatiana" <mrslenytati44@gmail.com>
Date:   Tue, 6 Jun 2023 08:20:29 +0100
X-Google-Sender-Auth: m0G87F7YVkmBC_Jd8duGbtDsNuM
Message-ID: <CAGq_i_1yi504yG+BM_xK9R-Z_yj2xWk1kuHwNie6JX0EiVhAJg@mail.gmail.com>
Subject: Greetings dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        RISK_FREE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrslenytati44[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 RISK_FREE No risk!
        *  0.4 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings dear friend,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS
CHRIST the giver of every good thing. Good day and compliments of the
seasons, i know this letter will definitely come to you as a huge
surprise, but I implore you to take the time to go through it
carefully as the decision you make will go off a long way to determine
my future and continued existence. I am Mrs. Lenny Tatiana aging widow
of
57 years old suffering from long time illness.I have some funds I
inherited from my late husband, the sum of (19.2Million Dollars) and I
needed a very honest and God fearing who can withdraw this money then
use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR
CHARITY WORKS. I found your email address from the internet after
honest prayers to the LORD to bring me a helper and i decided to
contact you if you may be willing and interested to handle these trust
funds in good faith before anything happens to me.

I accept this decision because I do not have any child who will
inherit this money after I die. I want your urgent reply to me so that
I will give you the deposit receipt which the SECURITY COMPANY issued
to me as next of kin for immediate transfer of the money to your
account in your country, to start the good work of God, I want you to
use the 25/percent of the total amount to help yourself in doing the
project. I am desperately in keen need of assistance and I have
summoned up courage to contact you for this task, you must not fail me
and the millions of the poor people in our todays WORLD. This is no
stolen money and there are no dangers involved,100% RISK FREE with
full legal proof. Please if you would be able to use the funds for the
Charity works kindly let me know immediately.I will appreciate your
utmost confidentiality and trust in this matter to accomplish my heart
desire, as I don't want anything that will jeopardize my last wish.

Please kindly respond quickly for further details.

best Regards,
Mrs. Lenny Tatiana

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF286FE307
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 19:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjEJRKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 13:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236483AbjEJRJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 13:09:59 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F94D8
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:09:57 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso11250115a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 10:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683738596; x=1686330596;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=UyyEaTdb5BpcwZnZnJzSB6wB4frOIXUGbpKzjD53AFai3vOICAa9/kvwC0jSSb5BvD
         pVi9dzIcy1lCdVFTJmnRa+0RgrMjAaZgwBO0A2kV0NgXI+TrIiPwJmU6qVML8vin6kNz
         cKAXOh5tBN+DehjdD11CaupuAKx7AZly541sZchluEE+TJhfG7+XgiGlqhYjx2SxHMMZ
         Y38wQPtJypWVw5YDZPElL7osxu/Q4jjnkNjPqvyLVS96PaUoWrBYelEAfQPPFCg0lwTP
         DL6sZxo2BDM1DHl9Uoj4tcleJWkZHVbpYqfAhhdguZG3M7zEUUW6rK4gEnkg7vX9sRbN
         Pp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683738596; x=1686330596;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGuPs2HAW5Kc9EAlBZmlCe2PoQii+LuASoE3r9n3wKk=;
        b=Wu0hrl7mIxkkWpFm/X/4Ey5iwHRZ9TUbVb8VT85J7ksUoZrrIqnK276rDadygJoj3W
         kQf0/046B7Wtlwb20ddXgHJ1IuzWfTo1SUBdJacNnoh+r/7JtPFO2Oc81om/9JDzMrVd
         ULqgUTKHVto1PK7SNOI0LEfcvBfl8F/QyN7XC9BLwFd2etF+uSUD5DHAqbEzrcVGKjRW
         WNLGdXbYLT90OO7vTFRABnYuCwQoXNC4dnuCsMlY5X4gPsQbXTmrMejcyt3y6trZnNtY
         DfQMQyUuAeb+RKGafczBv80RrxmJ1ZWSOOPdR/QCUCUPHih81C2dR896nBcIUm01OnoZ
         Uhqw==
X-Gm-Message-State: AC+VfDwMLPUo1pky45BPxQJ8NzN/pFaaVPefDli8otkPFcSqWHZ5bjMf
        OrLLGK5hUO/iq1htU1/kG1HX6q8O2mt5gBg3+Ug=
X-Google-Smtp-Source: ACHHUZ5/R0wIbXWCgFbcWHXlF6Np6DsKEbNxxefVcr7W6+IoOWQ6sSxP+/28rPPRAyH+C2NWM/5qPcre/uy1c8nVlYI=
X-Received: by 2002:a50:ed0b:0:b0:506:943a:6a5f with SMTP id
 j11-20020a50ed0b000000b00506943a6a5fmr13306151eds.36.1683738596164; Wed, 10
 May 2023 10:09:56 -0700 (PDT)
MIME-Version: 1.0
Sender: mrselisabeth73peter@gmail.com
Received: by 2002:a05:7412:619f:b0:cf:b94c:e2f2 with HTTP; Wed, 10 May 2023
 10:09:55 -0700 (PDT)
From:   "Mrs. Lenny Tatiana" <mrslenytati44@gmail.com>
Date:   Wed, 10 May 2023 18:09:55 +0100
X-Google-Sender-Auth: g9CZ90duo4csCMl82TZibUqhaV8
Message-ID: <CAHZyUciwUhPz81Oao+q0otm1-1NBYRciwCxGRRcMe=_-nbAa5g@mail.gmail.com>
Subject: Greetings dear friend
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:541 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrselisabeth73peter[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.4 HK_SCAM No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
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

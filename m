Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6511709C12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjESQLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjESQLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:11:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 634681AB
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:11:12 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-561bcd35117so43846967b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684512671; x=1687104671;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MAMP5T5pfCs0g8WwRKcMxs6XnL4M1eIwb310ADtqdX4=;
        b=sVqJOMav7Wn+PB0kChvCod48x7MpzOFPxykLZl5/nFlbZrdRrSzpoNU3JE10/vsjnY
         Tsn+tukpIJOQfutuX057fJjAm1Tu7zuj9aDMbQrLlEB+3hUPSj9AlE3C6k2tqoDD2kEG
         sSh6BPhACj8Ge7beBNfAfywG99PTU39YJYmebjanofYisAI+LMmZoBvgiB1X8n3AmtEg
         nMctmaZfXIiPKwrl8proBZQVrA1J/iWtUrP4fZ5G0tk57uDeAdjHdTlKo+Rd3J2akVnW
         aJrRx6sJj21fNxiRi/9Ul+xctWhtwmsI2hJrSfMTR4C/JBYdSfDTfmg9YMzDK9MguxFv
         lFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684512671; x=1687104671;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MAMP5T5pfCs0g8WwRKcMxs6XnL4M1eIwb310ADtqdX4=;
        b=Qy+gmwfPd/SoniVG2sCE+gz5I3hL9pdlxsIrQ2/twC145DxRpjuAJvJ89wM10yeT7p
         OEmwLtwf5OUp5VaBNGlQeEHJPFh6G6XWdW5B+t91dPUnozQoKZScYatAynDvN3PKl1Pu
         7OYA/bwH0FFdKBJc1TtEIK/UIXejNqjaCIS6HXpF72DP+RH01LoXRaF79TcmRbRhhWbW
         XpVdpYUddAUSlmEYgwva3mi2cdMQ8veizTjEt61phwWQMzY5XLxZkrIrzMrP5RKDLjgz
         B+/6Hhc+llo637VNBpUpJWKJnxdjM7UKdGi+aEyb0kWkzeBWsymdZMeUU68IkaroOK69
         QIzQ==
X-Gm-Message-State: AC+VfDwE1QVmTBMf9eJuM2lsgBgu/hvgcbkcwt0E2/bkOo8SkRnbVNFw
        mPNLIR59wFEIEuEEnNzeGfCSgsG1VBGhYq6Hur8=
X-Google-Smtp-Source: ACHHUZ7L7eQ2lv55fqEFG4U+8JE2H76UVGIxmjme4S2ZyZPoYSkCGZp5ZVe00S7oX49j95LYxsNVEleS3YGFRAOJtbc=
X-Received: by 2002:a81:d548:0:b0:561:949d:f9a7 with SMTP id
 l8-20020a81d548000000b00561949df9a7mr2981009ywj.20.1684512671004; Fri, 19 May
 2023 09:11:11 -0700 (PDT)
MIME-Version: 1.0
Sender: bamounipatrick@gmail.com
Received: by 2002:a05:7108:9c94:b0:301:574f:69d7 with HTTP; Fri, 19 May 2023
 09:11:10 -0700 (PDT)
From:   neemakimjohn <neemakimjohn@gmail.com>
Date:   Fri, 19 May 2023 09:11:10 -0700
X-Google-Sender-Auth: tD1BZeNH0VDaXLiCl1_aE7a0Xs0
Message-ID: <CAD+XN97tYhquhoF+pHAKrXR-GsUGPzSHDDK0VBAPPzjjtd7s6A@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:112e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bamounipatrick[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

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

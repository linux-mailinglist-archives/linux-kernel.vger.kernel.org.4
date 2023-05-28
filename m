Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111E7713923
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 13:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjE1LH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1LHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 07:07:25 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E1E0B8
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 04:07:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so1767943a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 04:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685272043; x=1687864043;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2QjYJBbpdaNIR88F6Zdute/I4LnMv0OvSgm8fjcmD60=;
        b=pT3F1pSGFjoI7UxvT33ioMvdIdUk/Jwmeiln52qhj1oH4lxdZGECgpv2tSn3Efry/Z
         TeTf/t+lqPbLb7K380z+lnYbcrAt+K+ryAcoI+G8oFUyO3Qx3jjA42oY9/7a722/cOlY
         7vCn4E9cI/gdkr0Kx+7WuBI0skqFHvOcpZVNQpImS+qEUnH066twAWQBJzEa84t+W04J
         IqvOxEuFiaDO/u9HaVST6SCypiRZW7V8aMVl3P9pOJ/uJM87tamGWjvMK8LdvnqEuIOe
         xWl2QARMOHG5K/xknC3lm12qBj8xlP5KXc/TxdMaGjMX4a5Rk1KwjwDYdlpBMC4KtNKd
         lqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685272043; x=1687864043;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QjYJBbpdaNIR88F6Zdute/I4LnMv0OvSgm8fjcmD60=;
        b=dfO/cKKe8C99hWFWZqASbWU37XXxvYvxN67p5DQn9RxFdUR4YHeP6zGoj/zAMc71YQ
         R6J5LITQ75FGLFlcViBV9tRF2wj3mJGcrhBgvv8K9prV7G0AXNJ+PiQZqqhtrM6TAOeZ
         hxya1jilteVYR83kFSeEheBmSDDs/Qm0FWIjSC7xD3mLWLnEfHuwFjBJ1FoowVOQODq0
         tSH+MAPOuiFl3PS+5teNpRQ4lWGIlwN/faSZB449kFNWeGUPnzWZtH1Nu+rJZDO4CSy/
         FNMP45gNcnbpXdpTIH8uPAyjtx3IqY0QLNpAKVAcBZKrQEdyte+zsGh4YQBP8E1B6o9R
         LONw==
X-Gm-Message-State: AC+VfDxzkhYOSZjmiFpj7psLhlAxWsZDhOLJdQeQ3++SOVbJ+IVNZogd
        gp5Y9CAxqrUH9RkhMColgMYkDjbIP6QXuPGB80Y=
X-Google-Smtp-Source: ACHHUZ5RsK4yaxGGJnJWXbt2oAPHnAWWyCgZebdR5tCpsSwCck1TtAPx8Og3Ox5lafalvebvBm0A5o7BXqHnEjkdwXw=
X-Received: by 2002:a17:907:3f27:b0:961:be96:b0e6 with SMTP id
 hq39-20020a1709073f2700b00961be96b0e6mr7587653ejc.68.1685272042484; Sun, 28
 May 2023 04:07:22 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrselizabethedward46@gmail.com
Sender: deliveryd150@gmail.com
Received: by 2002:a17:907:9802:b0:972:3e50:8812 with HTTP; Sun, 28 May 2023
 04:07:21 -0700 (PDT)
From:   "Mrs. Elizabeth" <mrselizabethedward46@gmail.com>
Date:   Sun, 28 May 2023 04:07:21 -0700
X-Google-Sender-Auth: ut0lxrqXEmz9GVY3P5T19e_j8nM
Message-ID: <CAOx+F8fUNof4nnwyw-9UVxhhQe-1Bh1dw7Kg257rmL70GE6A8A@mail.gmail.com>
Subject: Am Expecting Your Response
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO_END_DIGIT,LOTS_OF_MONEY,MONEY_FRAUD_8,
        MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RISK_FREE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:532 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [deliveryd150[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrselizabethedward46[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrselizabethedward46[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.6 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 RISK_FREE No risk!
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Dear Friend,

I am Mrs. Elizabeth Edward, 63 years, from USA, I am childless and I
am suffering from a pro-long critical cancer, my doctors confirmed I
may not live beyond two months from now as my ill health has defile
all forms of medical treatment.

Please forgive me for stressing you with my predicaments and am sorry
to approach you through this media, it is because it serves the
fastest means of communication. I came across your E-mail from my
personal search and I decided to contact you believing you will be
honest to fulfill my final wish before I die.


Since my days are numbered, I=E2=80=99ve decided, willingly to fulfill my l=
ong
time promise to donate you the sum(=E2=82=AC9.5 Million Euros) I nherited f=
rom
my late husband Mr. Edward Herbart, foreign bank account over years. I
need a very honest person who can assist in transfer of this money to
his or her account and use the funds for charities work of God while
you use 50% for yourself. I want you to know there are no risks
involved; it is 100% hitch free & safe. If you will be interesting to
assist in getting this fund into your account for charity project to
fulfill my promise before I die please let me know immediately. I will
appreciate your utmost confidentiality as I wait for your reply.

Best Regards

Mrs. Elizabeth Edward.

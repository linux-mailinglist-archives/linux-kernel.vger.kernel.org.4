Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92A070AD8A
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbjEULFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232135AbjEULBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:01:34 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB24E1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:01:33 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3945180bef1so2996541b6e.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 04:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684666892; x=1687258892;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BEVVgF6fRqcDcGbTpPr+QMQIBhdEVGHu/g9nl9l3kAo=;
        b=ZatrjIX6XBKp87w3IlH1+vp1iRu8f0EGtZKtOU0m8C7sa50wWNJzmmT8i4P/a3COAD
         bxtqNHuByVuYqjNwcye+bHBiIPcxe95vedpJOHao4lA0HL3aZklSaoDBup3/X0Z3ZBSG
         m54ivKDu0Ct6u9v+PbWLggTpgyiFl2xT7alWJhRHUVFbIGJa4tgYan6YQ9ayD0qCns5+
         b0JMMYErbK03/oZ9X9WPGyjGyLivD78U8hLPHXQ2GMrl7QYoEkufgW+coU7J4045KUdb
         EyJ3SvgwY7Y6DEQi+tmhDDF7a3fUL/ueEWTnr9zhmXuUBv5u/Jm1Dur/t7fnSR5aNyic
         stNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684666892; x=1687258892;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BEVVgF6fRqcDcGbTpPr+QMQIBhdEVGHu/g9nl9l3kAo=;
        b=aGtC4deTBnsFBx+ik//O7wX4JQBz0p+zgRvT4pMBShuJI5bxq6wu9ATE/KVb9PAY7J
         bztPpl20WhkF+92wtcZeEJ0j8IbTEycrEsuQFpEUwGCemt2tajluIfeT0+OqrW6Uc48F
         t5nX3RoV+lSsHcZFUde86WE5il72uRoNxh1cUt/cMxiUem5oaIgwGrYPXEFuvXkAXak4
         1IhSq9vF1bFhuuRAk3ll9eC+C7Qf0oLMl50KL3YO3j/Tm5I6GaARZRsR6hx1SG9fHmOG
         yOk4wE/AKhoH1FzeEW39/NS7K/MVvLbEFpyp3K9l0OC9UDAiDgSZ+7mzvL5vQ+kWLgT3
         c9BA==
X-Gm-Message-State: AC+VfDxoMONfOr8qaTvhCT9RQRHoWuDdJM7q/Z3nuddiNdhjFS7pEeop
        DelpkPg4VJI/8GgtJ2TwJ8XiBbtnG0VVu+2K3fA=
X-Google-Smtp-Source: ACHHUZ7E0zJVT/sc8m3kRGBn1JE212p2WeIluch0hWHDQ0fIANfng29eEF3EW4kAY7vqmecDgcCAS/jauAlUydP9uMM=
X-Received: by 2002:a05:6808:614e:b0:397:ee99:a616 with SMTP id
 dl14-20020a056808614e00b00397ee99a616mr1383087oib.15.1684666892424; Sun, 21
 May 2023 04:01:32 -0700 (PDT)
MIME-Version: 1.0
Sender: tombobolo3@gmail.com
Received: by 2002:a8a:54a:0:b0:4dc:b40a:643e with HTTP; Sun, 21 May 2023
 04:01:31 -0700 (PDT)
From:   Tom Bobo <btom7210@gmail.com>
Date:   Sun, 21 May 2023 04:01:31 -0700
X-Google-Sender-Auth: Jhm8oRYqo6FwtcfeZPzH1aBosig
Message-ID: <CAEgAAzLO-oW6FuZp4x-zujby1C0qWxSo2aEiqXad5ecHkyJGmw@mail.gmail.com>
Subject: I NEED A TRUSTED PERSON
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.3 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FORM,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_FRAUD_PHISH,T_FILL_THIS_FORM_LOAN,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:236 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5650]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tombobolo3[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tombobolo3[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  1.2 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.0 T_FILL_THIS_FORM_FRAUD_PHISH Answer suspicious question(s)
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm Mr Tom Bobolo from West Africa,i am very sorry to intrude into
your privacy,i got your email address through internet computerized
search and after my prayers over it,i have to consult you for this
wonderful opportunity. I have a business deal to share with you in the
sum of 10. 2 Million USD Dollars that has been held here in (B.O.A)
bank of Africa. The fund mentioned above rightfully belongs to one of
our late clients who deposited the money in our bank here in Burkina
Faso, ever since he died nobody has been able to apply to claim the
fund. So I hope that you will come and assume as his foreign business
partner.
Also note this business is risk free, you do not have to be scared or
doubtful of its reality. Please my dearest one also note this, once we
succeed in transferring this fund to your provided account in your
country it will be shared among us in-agreement of 60% to 40. I
believe that after this deal joy and happiness will be on our faces
and families. Please reply to me with your details so we can move on
with this great plan okay.
REPLY TO-- ( btom7210@gmail.com )
Your Full Name.......
Your Age&Sex........
Your Marital Status......
Your Country Name.......
Your Phone Number......
Your Occupation.....
Your Bank Name......
Your Account Number.....
Thanks Yours Brotherly
Mr. Tom Bobolo

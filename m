Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6FC6465D9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 01:27:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiLHA11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 19:27:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiLHA1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:27:23 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748808D657
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 16:27:18 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so12337656otl.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 16:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=lKrpFJ/RscOY16puD9bJw8cUQNcmdan5jZHLTcFX4gY=;
        b=AiyHdZ/1tqvGRBe3k9j/pgzUZJNkwlcP7gfmw8oWfj/PEnx0/r3EaFSKjiFdkQObh+
         EeRSpdk1mgcuRzCdJGjWFyHcfyVMqAlRlXapqX18P6hNyNopvSOaThZ1OGbhGH+WJUis
         XoBJ8kjnPsaUixnl36P5hj5xaQj/WeZlj9EWCvxgaPWs40lU2gPjE7l1/r+CPNBqgAh5
         BOn5CVGL37cH4fuJsI2nrDS/tq2Aa/cvA2Jy7bk1NJr8FpJpGjkzQ3LiABDF36KK23EQ
         iQNML61X7voS67plSbKLWrJvS3bXnrIHPUd3WklHg5IiUtcgEpxWc/CG2EAWdX1bvzbF
         N1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lKrpFJ/RscOY16puD9bJw8cUQNcmdan5jZHLTcFX4gY=;
        b=u50U39ZKmVR6LJgMDDMdkCBvZJitTLXsiqgDWmCPwB6i83Jif67GHxaSI0UDLhyH1G
         W7I00WNOaYg63ykHq3MyDODgmGQ+L4YhDkLEtAyq3bMeIZ0Mk1oEox5ada3pig3LWcjB
         b8dRysAermtL7Zqc6M3YJlStIZTS5dmFjW1R3nedbmCnoCIsouXMSn/jnPY24+z9KByQ
         rMMOFYTRcPaBnk9XKgWu0vkQ+a2gaCggwSgHgVNnuY/s6HW2nu8QOTtQ0bXgYigUov9n
         ylSvzMJs9k7PrqeHJV6W3hstUhMl99n09NB29Ok9UzJiMVEqB4Y5ZxsuNqQwMNekos/V
         gjhA==
X-Gm-Message-State: ANoB5plFG3Wgsk4vJ1i9UkIObrrr7oQfOGNHCYN8vsQYSnqOwxBD0CEl
        XlKl3V8EzuwYZrcpfKAttJL5i3VFZs11ez734kk=
X-Google-Smtp-Source: AA0mqf778OrHH/8Pjt5+Bk2jkx+LeKEcRr87qZbp20gjxjhhPlrLVojH7WrzQaqX0zZgwHU7hlmfOKvCMGeulEDfn0I=
X-Received: by 2002:a9d:6a42:0:b0:66d:a838:aa60 with SMTP id
 h2-20020a9d6a42000000b0066da838aa60mr44365993otn.104.1670459237785; Wed, 07
 Dec 2022 16:27:17 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6358:3801:b0:dd:706e:8c93 with HTTP; Wed, 7 Dec 2022
 16:27:16 -0800 (PST)
From:   ryan johnson <bosranjo670@gmail.com>
Date:   Wed, 7 Dec 2022 16:27:16 -0800
Message-ID: <CAL-LBhAA0zGG5nt=vkOYuvkz5Lq1dt9CDOWBPixcM-nTpVc4FA@mail.gmail.com>
Subject: Good day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        NA_DOLLARS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:343 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [bosranjo670[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [bosranjo670[at]gmail.com]
        *  1.5 NA_DOLLARS BODY: Talks about a million North American dollars
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 I am Mr. Ryan I have investment project of $58.7Million Us Dollars
 which I will like you to support me so that the fund will be transfer
 into your bank account.

 Please if you are capable and willing , kindly reply back to me so
 that i will give more details about this project. my private e-mail at
 (mr.alfanuru01@gmail.com)

 Sorry if you received this letter in your spam or junk Email, is due to
 recent  connection error here in the country.

 further details of the Project will be forwarded to you as soon as I
 receive your wiliness to join hand with me.

 Am awaiting your urgent response with this information


 Have a nice day!!

 Mr. Ryan
 I am Mr. Ryan I have investment project of $58.7Million Us Dollars
 which I will like you to support me so that the fund will be transfer
 into your bank account.

 Please if you are capable and willing , kindly reply back to me so
 that i will give more details about this project. my private e-mail at
 (mr.alfanuru01@gmail.com)

 Sorry if you received this letter in your spam or junk Email, is due to
 recent  connection error here in the country.

 further details of the Project will be forwarded to you as soon as I
 receive your wiliness to join hand with me.

 Am awaiting your urgent response with this information


 Have a nice day!!

 Mr. Ryan
 I am Mr. Ryan I have investment project of $58.7Million Us Dollars
 which I will like you to support me so that the fund will be transfer
 into your bank account.

 Please if you are capable and willing , kindly reply back to me so
 that i will give more details about this project. my private e-mail at
 (mr.alfanuru01@gmail.com)

 Sorry if you received this letter in your spam or junk Email, is due to
 recent  connection error here in the country.

 further details of the Project will be forwarded to you as soon as I
 receive your wiliness to join hand with me.

 Am awaiting your urgent response with this information


 Have a nice day!!

 Mr. Ryan
 I am Mr. Ryan I have investment project of $58.7Million Us Dollars
 which I will like you to support me so that the fund will be transfer
 into your bank account.

 Please if you are capable and willing , kindly reply back to me so
 that i will give more details about this project. my private e-mail at
 (mr.alfanuru01@gmail.com)

 Sorry if you received this letter in your spam or junk Email, is due to
 recent  connection error here in the country.

 further details of the Project will be forwarded to you as soon as I
 receive your wiliness to join hand with me.

 Am awaiting your urgent response with this information


 Have a nice day!!

 Mr. Ryan
 I am Mr. Ryan I have investment project of $58.7Million Us Dollars
 which I will like you to support me so that the fund will be transfer
 into your bank account.

 Please if you are capable and willing , kindly reply back to me so
 that i will give more details about this project. my private e-mail at
 (mr.alfanuru01@gmail.com)

 Sorry if you received this letter in your spam or junk Email, is due to
 recent  connection error here in the country.

 further details of the Project will be forwarded to you as soon as I
 receive your wiliness to join hand with me.

 Am awaiting your urgent response with this information


 Have a nice day!!

 Mr. Ryan
 I am Mr. Ryan I have investment project of $58.7Million Us Dollars
 which I will like you to support me so that the fund will be transfer
 into your bank account.

 Please if you are capable and willing , kindly reply back to me so
 that i will give more details about this project. my private e-mail at
 (mr.alfanuru01@gmail.com)

 Sorry if you received this letter in your spam or junk Email, is due to
 recent  connection error here in the country.

 further details of the Project will be forwarded to you as soon as I
 receive your wiliness to join hand with me.

 Am awaiting your urgent response with this information


 Have a nice day!!

 Mr. Ryan
 I am Mr. Ryan I have investment project of $58.7Million Us Dollars
 which I will like you to support me so that the fund will be transfer
 into your bank account.

 Please if you are capable and willing , kindly reply back to me so
 that i will give more details about this project. my private e-mail at
 (mr.alfanuru01@gmail.com)

 Sorry if you received this letter in your spam or junk Email, is due to
 recent  connection error here in the country.

 further details of the Project will be forwarded to you as soon as I
 receive your wiliness to join hand with me.

 Am awaiting your urgent response with this information


 Have a nice day!!

 Mr. Ryan

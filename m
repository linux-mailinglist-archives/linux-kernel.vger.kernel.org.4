Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5527F5B9EC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIOP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiIOP1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 11:27:02 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DCC3686C
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:27:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z13so13498446edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 08:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date;
        bh=WS4wMSByWryX8P5xXNg6/F9cuXaZcQ/JDEQQ6/oYhcI=;
        b=dSkLAUTEGl6h7ZYBvGadykV7fxVGFJN9GK0QDu4xAZZfzifQF3la5RtYcSTNgLOa+a
         8PfjudDoc40/LTevDz77QJdfVOLcO6HFl/aR50/2EUfIkHMSuYcy7xGqYD3VYEoJjz5Z
         5eGo1d2K0DY7o42udMddnFG82AMQFKtvO4Ak8paLn1jD0wCWi/mWE9pPixphtM1R5KZ8
         nYzVfMzn5sq+p0NoaHcQZ1bQboqS3M97JPr9PhGuICXDCzl+0EWeCmLEQuoi63PeZGQU
         t2H7zsLxIZxa9yN8m40Sak1DM6i3ajBgaURepMDTUwufsas36/iRNOAx+nArJ+SPoYwr
         NxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date;
        bh=WS4wMSByWryX8P5xXNg6/F9cuXaZcQ/JDEQQ6/oYhcI=;
        b=UruuTe6ppLiNCBylrZxP65p28tu3rEtGxvldTzWKTcRCqVYLVDsVg4gJHF+eD54f3H
         hCUfye5ZeFL23s6diLLWPbqXmIhHo+MoheCL9mDnqQwHjPGa80olqGxa4O5Ixlql/SqX
         iB7z2rIWIHVqb5jzcwJxIp35G9MJFtU5ZdHQkJTBSp875laMvHpDQGUuANjsiqrruwAp
         xCuJ2DPdg91B4a6sQW+5JGrogVC2hyAVOJwSOO6BAG8so/K/S7I9RL9OOFbf8jLnWt+O
         72P8lUcJHoklLUdDX2D5BmPvA2fFiUOoJEtHrOSiaBMkBG7/rDd2eqiHjgoMQizZAFQM
         v5Qw==
X-Gm-Message-State: ACrzQf283vqYSwnY6ZxC7dgobWiQ/rGbXEGFLgN7/AaIFB7bTPVfIVZu
        MtfDS9qoReeiG2Cv+N1D/eqhkyFCd0i+5WRrnWs=
X-Google-Smtp-Source: AMsMyM67Zslo5w/S70ISOliYf+eILhgE4U4gMxyTUCKYcHSc2TZlaRbUin/Xc9iwZ/eubYo+2E+U3cWoLSLqJwgWUv0=
X-Received: by 2002:aa7:da86:0:b0:44e:91c8:eb4f with SMTP id
 q6-20020aa7da86000000b0044e91c8eb4fmr377013eds.252.1663255619684; Thu, 15 Sep
 2022 08:26:59 -0700 (PDT)
MIME-Version: 1.0
Sender: djmacdon5@gmail.com
Received: by 2002:a54:2d45:0:0:0:0:0 with HTTP; Thu, 15 Sep 2022 08:26:59
 -0700 (PDT)
From:   Aisha Gaddafi <aishagaddafi6604@gmail.com>
Date:   Thu, 15 Sep 2022 15:26:59 +0000
X-Google-Sender-Auth: 0hKJR3LjiaUJ_eaM5gFDDKHCoI0
Message-ID: <CAKGPEqjPa9_B6ki-=EGt9wUmVT06qUwUSN_JxWn0R4_ad0ARyw@mail.gmail.com>
Subject: Investment proposal,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.3 required=5.0 tests=BAYES_99,BAYES_999,
        DEAR_FRIEND,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_HUNDRED,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [djmacdon5[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [djmacdon5[at]gmail.com]
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        *  0.0 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend.,

With sincerity of purpose I wish to communicate with you seeking your
acceptance towards investing in your country under your Management as
my foreign investor/business partner I'm Mrs. Aisha Al-Gaddafi, the
only biological Daughter of the late Libyan President (Late Colonel
Muammar. Gaddafi) I'm a single Mother and a widow with three Children,
presently residing herein Oman the Southeastern coast of the Arabian
Peninsula in Western Asia. I have an investment funds worth Twenty
Seven Million Five Hundred Thousand United State Dollars (
$27.500.000.00) which I want to entrust on you for investment project
in your country as my investment Manager/Partner.

I am willing to negotiate an investment/business profit sharing ratio
with you based on the future investment earning profits. If you are
willing to handle this project kindly reply urgently to enable me to
provide you more information about the investment funds..

Best Regards
Mrs. Aisha Muammar. Al-Gaddafi..

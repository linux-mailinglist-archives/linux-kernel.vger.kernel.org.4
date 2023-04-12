Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DE36E022F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 00:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjDLWxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 18:53:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDLWxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 18:53:45 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B9CF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:53:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id t16so653452ybi.13
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 15:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681340024; x=1683932024;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VT7lskgQghdhDyl36NA8tv4q50wwFOzrNWbYkQveF2c=;
        b=COkNgwdu2nLYVjot3mFE9Qh0REPnin5qoh1uUFIlbu7p6GB6HohoXFSIklnh87WohI
         Ti2RgMxZW6ByxgRc00tAv8utIXlDljMMMUqelPwsPfUgppvCjdolaaFkmK75sElcAWoV
         Vo1WiNVr/fO/v7GcFkTficGOt076By+Oj0O+AHZOgOchqzPl1wvmQ1JLX1BNHpHMjWvs
         TGEfUmMzKfDIkxlCq49WOBEf2R3tvTdp7IP+YKM0Fbf/hB8HCpI4EVAYVtWYBpg8Tasl
         eG3H7L/rN+9mUMeOTyLRmtizkMsHVbBuY2hGmCnNO8U/7wTJeqDssG7//TPOZU9L7DMP
         w1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681340024; x=1683932024;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VT7lskgQghdhDyl36NA8tv4q50wwFOzrNWbYkQveF2c=;
        b=Jcjl522OHww9RS1JLTJ7vDJI6boBpFwdOTAoUAfwq+on/4PXLuU1SYhfytSkYzGGeR
         dNG4i2rMXG3ts0IuoC6VmJXnXhAJEOjIIRgX9hoWQI2iTj2Ef2N+uVuKa1INK2ZnaR0J
         +fpyM7+sPI+KGC5Qw/LNQ7E7nLU5fsCv1I+2eREmwR3KgfR69kYdJazTnb1hjgusWX6G
         hN6vyhbQSYFSKfeEEay8Gx8Y4kNSCYbsnSlC5jqUxofwRUfylBOAHR60bdRxROpbVpf7
         /Ksc+kzcHLje4Meq0/bkef8S5QEvz0gB0HdGCN4/4wQT3/JAQV+NCqPm7Kc+BsfvU/Q4
         b97A==
X-Gm-Message-State: AAQBX9ddITdpezx56GE//ZbcNyzlKVxOta8EP+QXze+5WIR5DWlP/RcS
        bPZ05Vb4vcWgEkwrbHjNSbHdacQ1f851WprzXk8=
X-Google-Smtp-Source: AKy350ZHZ4ehYc0YyMwvqP60FkJnny9so2CjLBjBhTiItCLQLQHkSPPLK3jpCLr5xgQW5E2aZ87EcSYuQiW3ibXaWmM=
X-Received: by 2002:a25:da91:0:b0:b8f:5519:74b with SMTP id
 n139-20020a25da91000000b00b8f5519074bmr595935ybf.0.1681340024092; Wed, 12 Apr
 2023 15:53:44 -0700 (PDT)
MIME-Version: 1.0
Sender: razackyanogo53@gmail.com
Received: by 2002:a05:7000:8245:b0:47c:df0c:466b with HTTP; Wed, 12 Apr 2023
 15:53:43 -0700 (PDT)
From:   marilyn carlsen <marilyncarlsen008@gmail.com>
Date:   Thu, 13 Apr 2023 00:53:43 +0200
X-Google-Sender-Auth: i8xp56IqlyVO8oVT2x1VWS9nNyY
Message-ID: <CAPAwcQh3d_e0cTjtByCFL-6gWejvhLtkTaaCbERk-sGBOCkDyg@mail.gmail.com>
Subject: My Dearest One,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_00,DEAR_FRIEND,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b30 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [razackyanogo53[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [razackyanogo53[at]gmail.com]
        *  2.0 MILLION_USD BODY: Talks about millions of dollars
        *  2.6 DEAR_FRIEND BODY: Dear Friend? That's not very dear!
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend

  It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs.Marilyn John Carlsen, I am
diagnosed with ovarian cancer which my doctor have confirmed that I
have only some weeks to live so I have decided to handover the sum
of($11,000.000 Million United States Dollars) through I decided
handover the money in my account to you for help of the orphanage
homes and the needy ones.

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my bank to you please
assure me that you will only take 40%  of the money and share the rest
of 60% to the poor orphanage home and the needy once, thank you am
waiting to hear from you

Mrs Marilyn John Carlsen.

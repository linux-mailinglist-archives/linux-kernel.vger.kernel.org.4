Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812066E4BD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:20:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbjAQRUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:20:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbjAQRT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:19:56 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A4C4B767
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:19:11 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id x26so3318697qkj.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=06UlRa9qoCSN0KxTaeOEMXbLBq36exmUoY5DZI2ecZ0=;
        b=pPnAHaRiZz2oMe5Yon/YcD/l34YoYVe7lYC8X8CeMN1X+Vj7PUIUAlkFbVEQ4R2qbH
         Eow/19XdM9p/GmXXF16h4Qzcs+mP7YVR5obqZY0BGUw4oo+W+BQeJ34YIPekQIcAChy6
         BROSiSElXgqj8yAkhpQVM6cntfhTlpJGIqr3jo+6MmV3zVT1n7lvzZR8J1lJnuxDEHjc
         FMKtBYDoXlpSEbTHPHHPwYXTw8k7fvGyqct78MOw/VJT1n/ht8WfX4o9iRq8MbJLROyj
         R8hfjO5tyKUaoUR37ZhoVjhamEsvv8/AfT9HRvGfp+bF4HoJlXIISWgUgYinKY/CQG9k
         ZfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=06UlRa9qoCSN0KxTaeOEMXbLBq36exmUoY5DZI2ecZ0=;
        b=z06sSwq05L/oc7ilTM9AIYOyrY6z2vbUvDHW5Xc81H0zPWek3DCVLzV0xsptqqcfo1
         Qm1KneSdzhOTKN7lVwSH3OFxyUXkXvdoRXpWe6wrz7j7g7sM/lg/hc8JkfWo+WL/Yyti
         j2u+l8qVcjmRekHQiSeUJJwfE/0CbjIDJdNADuZAyqUGFY8kDk75HuaCXU4FUam2iVQf
         sIhXW/IjltAT1KzE7IXyk7b5fTTyuY7V5dPaY31+Qq5NzJeatJG1GfHsxReLwk8pItQ8
         eud7olYToRUV5c+qz2ktD7UnUhp9Aelh+C50qVM8kh/Gy/ozIf76W4wFfToF6BmLO2Wz
         GQPQ==
X-Gm-Message-State: AFqh2koAeuxfT7TC20qf7pS3ifKAvjBxuVOyKNaQ/NWWpsBKTXRc1re6
        WmvmpysfXOWc2lJCKDtK0Ju2BIOghrKP2Gt8W5k=
X-Google-Smtp-Source: AMrXdXtka5YaMVLNI+mzHwlBB3TJF0Ykj9QFK6P0G2icoLGL2NRSxu+br/z0FrhZampkgecCjVUIG6WkPXwfNqHgqHE=
X-Received: by 2002:a05:620a:66d:b0:706:17d4:aac1 with SMTP id
 a13-20020a05620a066d00b0070617d4aac1mr215240qkh.13.1673975950642; Tue, 17 Jan
 2023 09:19:10 -0800 (PST)
MIME-Version: 1.0
Sender: belloabubakar20002@gmail.com
Received: by 2002:ac8:4e56:0:0:0:0:0 with HTTP; Tue, 17 Jan 2023 09:19:10
 -0800 (PST)
From:   Bello Abubakar <belloabubaka94@gmail.com>
Date:   Tue, 17 Jan 2023 09:19:10 -0800
X-Google-Sender-Auth: J9JzNJ-lAQnAZPXEKR_MTjY2xOg
Message-ID: <CAM5VdHHj3jP1Zpo-L7DmzL9itdWsDaAXqSOZ5ekKXF0YFCR5dQ@mail.gmail.com>
Subject: URGENT REPLY
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_MONEY,
        URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:732 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5468]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [belloabubakar20002[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [belloabubaka94[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello
I am a relative of a politically exposed person (PEP) that is in
financial regulation. Due to my present health condition, I'd decided
to write through this email for the security reason.

Therefore, kindly treat this as top secret for the security reason.
I'd after fasting and prayer choose to write not you particularly but
I believing in probability of you being a confidant chosen by chance;
luck to help and share in this noble cause.

I need your assistant to conduct secret transfers of family's funds
worth =E2=82=AC90.5 millions Euros. It was deposited in bank clandestinely.

I am in grave condition and I expect my death any moment now and I
want to donate the fund to less privilege and you will be rewarded
with reasonable percentage of the fund if you can assist.

Please contact me back for more details,

Yours truly,
Bello Abubakar

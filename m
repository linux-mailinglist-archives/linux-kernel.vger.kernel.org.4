Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92D556D1B3A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231981AbjCaJFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbjCaJEq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:04:46 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51481E737
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:04:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e15-20020a17090ac20f00b0023d1b009f52so24751735pjt.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 02:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680253458; x=1682845458;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5ZRVJJnnKuF3/gZsjI650IWzA47oVyxqnjdVwKXVcfg=;
        b=LJBy9VaxEG/P+6fNgbeR8WBGUxTb26T/1fnV54xcOSaYm1MezmrNbknIQOMpb5f7rH
         TWcHlISPSF2vulL6UKy1e9lqIZ9dcUw31Amn1Iwhn03cTsuIzAEQeFT8iKpPPZb/QVOV
         7E24TpzWWrp2h6HTVk9MciDrMHWHVfygjtW+XYvnGbSalRA47OidjKRJf75UHV5dYhzj
         hWTixNn5ogupCzfeY73hby1e8GJcMTkkgnlQoB+VXC+sKTNfE3mNa3YCU4NnaatTutSX
         Qz7pqT/StQNrAPgDwqMqIjGi4NjcY2fYslHX0udGphmmbw/vxRI10okOQ+/n3TH/7Dfo
         IjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680253458; x=1682845458;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZRVJJnnKuF3/gZsjI650IWzA47oVyxqnjdVwKXVcfg=;
        b=3XqIGywqTcIcKcGOq4bOOlqAOW2EGTE52oUIXbyuPC76t0Z8scaowX3wkB/FHL2iYm
         FHSwrU4VYoj/vHBxvvK9bksywKb2iqmOA332e20CnShrUu10HgyUTVyL4eRfKiJKnOjV
         3LGnJhVSAb3U8YnIXpG2UnCeyDI3V4ZPYZVaBvOT5obxoxVWAERLU66sVQDtCvPZfvAr
         XrSTehi+mWRhptq6AnUhZtENtku/YKtjc9fzPSDksAUxVKqeO4fwVIvaTHnx8m3ob8Yq
         dOzRlOmxndfOTxfQ6vuvZiIH+4jLOsTTe/6IRa9csFXq2+9F+OhFNvDcLsotgk8QRrdw
         ZekQ==
X-Gm-Message-State: AAQBX9cFiAglQG5Md8UDz/i8yOl/vna71FSTvxS2wHjxorBnzPwPlSHk
        sPr1Uxbc3dG6lqvSLlVYQxCxqO+i/CBYy0Rjb0E=
X-Google-Smtp-Source: AKy350bkTOrmEG+wgOeFWs48PhDSkjNeU2qh6BXd1zC6QvIkWnM+1qG5w2Bq2eTXFouDge1RayUHuQ6QrHSgGnaibfc=
X-Received: by 2002:a17:902:b612:b0:1a1:f6d9:2c27 with SMTP id
 b18-20020a170902b61200b001a1f6d92c27mr8744698pls.5.1680253458087; Fri, 31 Mar
 2023 02:04:18 -0700 (PDT)
MIME-Version: 1.0
Sender: burkinafaso.interpool123456@gmail.com
Received: by 2002:a05:7300:572a:b0:a7:f9f6:ccae with HTTP; Fri, 31 Mar 2023
 02:04:17 -0700 (PDT)
From:   Mrs Amina mohammed <mrsaminamohammed87@gmail.com>
Date:   Fri, 31 Mar 2023 03:04:17 -0600
X-Google-Sender-Auth: QFL7BqiGBMkdOZ6wse8vE7FcHM0
Message-ID: <CAFCoA01JR0D7cSbZv6py5ffw+0-+2Tq0_C=+uyyZbJVGuC7-CQ@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_2_NEW_FRM_MNY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLY,LOTS_OF_MONEY,MONEY_FORM,MONEY_FRAUD_3,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_FRAUD_PHISH,
        T_FILL_THIS_FORM_LOAN,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1033 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [burkinafaso.interpool123456[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrsaminamohammed87[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  0.0 MONEY_FORM Lots of money if you fill out a form
        *  0.0 T_FILL_THIS_FORM_FRAUD_PHISH Answer suspicious question(s)
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  1.0 ADVANCE_FEE_2_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  1.2 MONEY_FRAUD_3 Lots of money and several fraud phrases
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is to officially inform you that we have been having meetings for
the past months now which ended three weeks ago with Mr. David Malpass
the World Bank president and other seven continent presidents in the
Congress we discussed solutions to Scam victim problems.

Note: we have decided to contact you following the reports we received
from Anti-Fraud International Monitoring Group your name/email has
been submitted to us therefore the United Nations have agreed to
compensate you with the sum of (USD$1.500,000.00) this compensation is
also including international business that failed due to Government
problems etc.

We have arranged your payment through ATM MasterCard which is the
latest instruction from the World Bank president Mr. David Malpass,
therefore be advice to contact our Representative Agent, Rev. Pastor
Richard Hilson who is in position to release your ATM MasterCard
contact him with the below email & phone number and make sure you
forwards your full details to him.

Your  full name......
Your  country/city........
Your  delivery address......
Your  Occupation.......
Your  telephone number.........
Your identity card or passport.........

Contact him through E-mail:
CONTACT NAME: Rev. Pastor Richard Hilson
E-MAIL: revpastorerichardhilson90@gmail.com
TEL/NUM: +22678638815

Once again for the collection of your MasterCard contact our
representative Rev. Pastor Richard Hilson to enable you to confirm
your ATM MasterCard without further delay and note that any other
contact you made outside his office is at your own risk.

Thanks,
Best Regards,
MRS. AMINA MOHAMMED,
Deputy Secretary-General of the United Nations

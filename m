Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8EC671C90
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 13:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbjARMvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 07:51:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbjARMvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:51:35 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF133474ED
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:12:40 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hw16so70889998ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 04:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HJcZxpyrwGsFLd0khHQDpi2RJfK7qh9/a4UC27izsOk=;
        b=At6V6LmpVZCQl1TGLLCGaCq8nvSvnGDown+WFGhJ0CWr7aZoHMRiesTxgBG6ajdw21
         iuU3MXlRWvfzbZSS0VFw0RdIfyeUtjfYHS/IAmRk6lWU+dDrZCMr/qTJJHQ12aQW8suR
         gk8MewMS9bS9WQJu68PePXX4tMJSpEUVsbaGORMO/zBq+owLRYTQl9zD2SspoVAaNPZN
         d9AT8VekWlPSM+CwgiaY1mm+ZZXG0JAwKiWsx9eW04Xx6R9uxa7xdvC+COjNBsz59cU1
         Ja29RThY2FUX/QfqRXkBjL1LQ/iqy5z0nOsfhkmVFu8XICVKC/qStqD4BdNWoRlUpaVg
         EXWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HJcZxpyrwGsFLd0khHQDpi2RJfK7qh9/a4UC27izsOk=;
        b=C3qvz5rmOqEGH2+9SyZkIyrkOks3M5O3dHhge4aAadUbOu9ng9TfiOvU2ZR4u22OW3
         WvBQre9nHHsMulGJRKi8whT/bFVhBERUecDlWKsfyrQXhlCCekxeRPm0x2hyfH4P3fEA
         39SN4x802nl0vvPQDvwMh9aMW3ldeJ4SPX+pzDEdztL2fZCzW56zzZgt0H4v6NmInUGZ
         O4Yx39hjoawVK5hdBtGPBXMYW6AsDGrFW2MK++Z+hGSd6A8cdiyxVAdrfX3zsjclMHiB
         9uaHfmq/vIHDAIhAS2+AOQcPrg3I2w1p1MOaDXhAGtWLwIw9uiEcw3B0UAbu8GnXxnJS
         jK8Q==
X-Gm-Message-State: AFqh2koeMP+TB9914uiSDdQ7qeRQQbYLS/5VWrKAZHYKMAb8caCVoTl3
        H+hg5vBOOsUaqhN8Zo+lsxK5SxRFZOcSAFuuW+s=
X-Google-Smtp-Source: AMrXdXtBBaNCK2uM/GK+BilgvXJEf+ppiEwQ990VrL74XgKcaLTs+p+Zndq5y9e/gO/Lg0SEDPRmyv+q4KYpyUt4fz0=
X-Received: by 2002:a17:906:f0c6:b0:7c0:deb6:e13c with SMTP id
 dk6-20020a170906f0c600b007c0deb6e13cmr534873ejb.457.1674043958948; Wed, 18
 Jan 2023 04:12:38 -0800 (PST)
MIME-Version: 1.0
Sender: johncliff888@gmail.com
Received: by 2002:a05:640c:1fca:b0:1a0:53e4:7117 with HTTP; Wed, 18 Jan 2023
 04:12:38 -0800 (PST)
From:   "Mr. Omar Ousman" <mromarousman@gmail.com>
Date:   Wed, 18 Jan 2023 04:12:38 -0800
X-Google-Sender-Auth: fkOPEan5-5fOF_qDNMgHo2pF7KI
Message-ID: <CABmh+1k9zGYdP+eYo6OU+=rmmB1PBYTGZB1r0XqAv9chHZ+v7A@mail.gmail.com>
Subject: GREETINGS TO YOU., ...
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.5 required=5.0 tests=BAYES_80,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,MONEY_FORM_SHORT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_FILL_THIS_FORM_SHORT,T_HK_NAME_FM_MR_MRS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:630 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8094]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [johncliff888[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [johncliff888[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.0 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm Mr. Omar a regional managing director (CORIS BANK INTERNATIONAL)
Ouagadougou Burkina Faso, in my department we have US$ 9.5 million
united state dollars, to transfer into your account as a dormant
fund,If you are interested to use this fund to help the orphans around
the world contact me with my email address (mromarousman@gmail.com)
and your personal information's below

Your Full names.
Your Country of origin.
Your Occupation
Your Mobile Number

My Regards

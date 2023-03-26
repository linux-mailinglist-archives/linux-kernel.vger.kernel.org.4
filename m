Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E55606C989A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 01:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjCZXBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 19:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZXA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 19:00:58 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB63859C5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:00:57 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id p204so8271137ybc.12
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 16:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679871657;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vL7p+yMRDcu95dPquXTN/oirNrGftivSHJLWDCU0Yo=;
        b=WX0JkSipYIdr3rjXdP5WlI6l/bFV+UVS8L06GIYrSAQfbPJiqjlgO7kLLOenTeVJSf
         rbfb1LROAm2F5xwWuy4Lw0T5PjyEyCtTolM7G8cfiXrvlzUtLJOowbviIMwCxfrpD9ne
         C2u17SGV2aEbvjBOtswXIUDzzv/BPUkmA4BVFegZLLdFOXA9fWI1G6IXPrpGXi34HZx9
         256RjoRuKajJX4LnizbIJFeqvz40poLZCnSYyFnYP4MDrr7az/F1Gx72ajmb3D6J3bsu
         LCEkU18KWdA+W3Tz0tdSqEzKbrKzLbsxKg02UpPvBkctfMu9UC+o/RdXYgpENUpa229Q
         /u1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679871657;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7vL7p+yMRDcu95dPquXTN/oirNrGftivSHJLWDCU0Yo=;
        b=UsuYq9vGpH8m93N4AxiMRYo5qZ1YVKhluMgdbvUr+GoR/QGypzT757h1rK6wXZyqUP
         vmlrg3MSqLoIZOSqIoNZydk67cjDUoljMuh2mXnchJbnqvEr5TArkiuHW8XDcBrm7/GL
         PonoqQodvYj+AZTJhGnNFLDzMhMO7gCoBesKXgN40h+zan20oBOtwplsyMbdj2KNmhra
         ENALoVoPirzoy3BTBeaYTMNjCZ875sFkKidsvq2gmBZ7160vNouNddmL62oZpaNMDJxL
         DAjCSNboMCKgQseTMGaXUTaLKp0YQPC35WeQfLEDV3cznM9IVv2nLR56mBuxDtYL3cJc
         pg1Q==
X-Gm-Message-State: AAQBX9d9QAwhFHpN0KRisheL3u7WaP6vv50DqJKfJyOCrm58k7tFudYR
        sgiApna45YZQAwYK6F5C8vKk3rFebh8bbwE8ymo=
X-Google-Smtp-Source: AKy350bj2EfXcXzC8waieMmjMHiq0GCxC0eWKuRFw1Bj+WaKKtFMSH6u659Utoqb0zkW7bLUY+2cie6PtSz8Iwj6L5M=
X-Received: by 2002:a05:6902:10c2:b0:b6e:b924:b96f with SMTP id
 w2-20020a05690210c200b00b6eb924b96fmr7968497ybu.3.1679871656647; Sun, 26 Mar
 2023 16:00:56 -0700 (PDT)
MIME-Version: 1.0
Sender: gloriapauleric@gmail.com
Received: by 2002:a25:af42:0:b0:b01:28f6:dfb2 with HTTP; Sun, 26 Mar 2023
 16:00:56 -0700 (PDT)
From:   Dina Mckenna <dinamckenna9@gmail.com>
Date:   Sun, 26 Mar 2023 23:00:56 +0000
X-Google-Sender-Auth: 3IJqt3-kFX3d8TLh2PlPMD6-rX8
Message-ID: <CAEwunR8qD74SmD0kAM7VwCKVCEVo+16zx4P_A6dyg5ghEytcnw@mail.gmail.com>
Subject: Hello,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b30 listed in]
        [list.dnswl.org]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gloriapauleric[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.9 URG_BIZ Contains urgent matter
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello My Dear.,

 I am sending the same message to you. My names are Mrs. Dina Mckenna.
Howley, a widow diagnosed with brain tumor disease which has gotten to
a very bad stage, Please I want you to understand the most important
reason why I am contacting you through this medium is because I need
your sincerity and ability to carry out this transaction and fulfill
my final wish in implementing the charitable investment project in
your country as it requires absolute trust and devotion without any
failure, which i believe that you will not expose this to anyone or
betray this trust and confident that I am about to entrust on you for
the mutual benefit of the orphans and the less privilege. I have some
funds I inherited from my late husband, the sum of ($ 11,000,000.00.).
deposited with the Bank. Having known my present health condition, I
decided to entrust this fund to you believing that you will utilize it
the way i am going to instruct herein..

It will be my pleasure to compensate you as my Investment
Manager/Partner with 35 % percent of the total money for your effort
in handling the transaction, 5% percent for any expenses or processing
charges fee that will involve during this process while 60% of the
fund will be Invested into the charity project there in your country.
Therefore I am waiting for your prompt respond, if only you are
interested in this humanitarian project for further details of the
transaction and execution of this charitable project for the glory and
honor of God the merciful compassionate.. Your urgent reply will be
appreciated.

God bless you.
Sincerely Sister in Christ
Mrs. Dina Mckenna. Howley.

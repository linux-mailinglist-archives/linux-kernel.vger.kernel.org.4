Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BC76E229C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDNLt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjDNLt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:49:28 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05BA30FA
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:49:27 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso21386515pjs.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681472967; x=1684064967;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBGcORFlx3mmfZ9Ef5BjM/SdwRHzq8zieg/Y4xH2/5Q=;
        b=sjFfIzMrjWaABEOu7eTtLYLUtpjBVMEc2mJQ4WiVQ4aNf5MQAONZnjr+htlNcrEr43
         bKlNiI2UwLuHsJ4NqWFR1Caaz2pl2kAe3t7awWHgqGwOoc331GGS8C4Qhjn+htFfKAFG
         Pc4DP8htQnQBNKmufqACHStvdJMvcjhAyWKrAjXYJDKfPBYHnL0UKiwKRgvsp4OcoIcb
         r7iQeOvrRoKj/O5qb8NbnLXt2o2upStIrBsEYtf28HJqdSKXiRLNER+CQAF5Ap7dmRoh
         r6+kWWUy01FhFDHbdeVhl+rW7crnzFKGfzXFRTDDsoVpB3Mdu3HOMUMYqghJQeqpCvw2
         FA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681472967; x=1684064967;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eBGcORFlx3mmfZ9Ef5BjM/SdwRHzq8zieg/Y4xH2/5Q=;
        b=aoq5Lml9yxbImXeWRqas+/2Oza3FFGGViG2xkAMQC5yWFI2gmmc2W3xWgSygWFGkh3
         PGYSwDlJhhZP6emioiuoUuMahxdMKMdEoURm1pMX7ktmvgwZvEmqODCL7QjYuZnL8wuP
         QVtvAsirdz0CbopqV8RzAjhHzL9ASpzmlt00ku0lv8+SveQXuP8DhxLafw7fcP4W/Kyf
         I+taJQN3imHBnx9Qqe7aKDT7olBIhQjEhbn8pvQdm0InQ+j6qVj6+m9XWrPCF+Fu6TQb
         Np4/lVrtlmIYHIuBEn8DG4nGteCkaSU3cKGPCkBKz4d4hx7BNwnDCIno0qeB83I7l3W3
         eSbg==
X-Gm-Message-State: AAQBX9ewNLf35R4r2eH5sz3e29TlCXMcjd3k5TBBq3IGCCL4FBi0YWGc
        +iWqF3mCvmzUkEshKvYWZJ+QLpANEEKxdFZ287o=
X-Google-Smtp-Source: AKy350bTIJT2TzoYlTj36mjcFSsjCoFF6Wk9Uj7w7aSn9syvHv7pk4HuzeHsCunCb/f9bGDj5t6EWIsTUg8xJZ6NcWE=
X-Received: by 2002:a17:90a:6749:b0:246:696f:b1f1 with SMTP id
 c9-20020a17090a674900b00246696fb1f1mr5126942pjm.6.1681472966977; Fri, 14 Apr
 2023 04:49:26 -0700 (PDT)
MIME-Version: 1.0
Sender: morganford737@gmail.com
Received: by 2002:a05:7301:3d0e:b0:99:ad87:a211 with HTTP; Fri, 14 Apr 2023
 04:49:26 -0700 (PDT)
From:   Moon Lee Park <leeparkmoon14@gmail.com>
Date:   Fri, 14 Apr 2023 12:49:26 +0100
X-Google-Sender-Auth: bsNKn7bj1LWusROTouxBtJ1GqHA
Message-ID: <CAPVatJWKdOApumTYhc4VbpSPxyqOSwoAaGty39Xg+=UsZiZ0vg@mail.gmail.com>
Subject: YOUR URGENT RESPONDS IS NEEDED.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FORM_FRAUD_5,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,MONEY_FORM_SHORT,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_SHORT,
        T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:102b listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [morganford737[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [morganford737[at]gmail.com]
        *  1.1 MILLION_HUNDRED BODY: Million "One to Nine" Hundred
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  0.1 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 FORM_FRAUD_5 Fill a form and many fraud phrases
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm writing with tears and sorrow in my heart,My name is Moon Lee
Park. I am  24 year old girl and the only child of my deceased
parents. My father was an oil drilling engineer and he deposited the
sum of Two million five hundred thousand U.S Dollars in my name in
United kingdom bank  before he died in January 2019.

Please,I want you to help me and evacuate this money into the account
for investment purposes. After fter transfer, you will also help me to
get a student visa to come to your country to further my studies. I
made this decision because my uncle wants to kill me and take away my
inheritance!.I reported my uncle to the local Police here in my
country South Korea but nothing has been done to help me. My life is
in danger here in my country!

I am writing this letter to you from a local hotel where I am
currently hiding for my safety until i leave my country after my
transfer,I am willing to give you thirty percent of the money as
compensation.If you agree to help me. Please answer me quickly in my
private email address so that I can send you more information.

leeparkmoon14@gmail.com

Yours faithfully
Moon Lee Park.

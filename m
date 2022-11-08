Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBB3621BF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 19:34:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbiKHSeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 13:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiKHSeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 13:34:08 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A3B2B633
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 10:34:07 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id v27so23853796eda.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 10:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hqy8JgvSmMeBmN6qPM9idve8i9HkINbrdDKh4fUUfPk=;
        b=f06ww2chfKwiCXtEhjhs7a1qoUSK+XebfkyzkIVm3U2WvBsFKITfErNy1xZXPwqYg1
         cYYf09Z6501VtZTW0EwvOvuh0j311iDXgSaFpogeYF/Av2Efy0xrz8+Qku9EC22HsyDd
         bK+jSzl8OaENowaJvZ+Z/Jc6Os4gUnBCvfZXQMOwzi2A+MYphNslU0FQwyIYhGU7Th09
         /K2etgdv6ikE41m869KVgsL70eNWNhs7tukVMNpQIWUuhSh00sg4BEi2F9YK5AFaR/YF
         GFzBCnXvylK3rxr4PuJfeOGuk/oRr6A0TefpFjABS4qBdCVIAORa5sx0lQLtNZ9GRTfq
         ECQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hqy8JgvSmMeBmN6qPM9idve8i9HkINbrdDKh4fUUfPk=;
        b=vT5MxpjP3ae3ACS1Iv2cfOcpmYUzpaNd189nvo3jkY9Z0wMIwERtKugy/0xpR70N1F
         nFxX3keY9VwAqAle6Jl+2pzVE/N/GNChnYLVT/zgsNrVjYWz2nW/sap5PRkvGWpzOPaa
         /GCnxMuQNe4c8Pt1NijmAe47NdWQA17a1IkO4GdIbGZOlsKWSsqi+teXKBSID5euZ3i9
         hk+44QLyXixqLqq0zqjjwhai5GDVy7u589iMVh06ErBz+p5hZ3qNEc2X8Uvo3bC0gmlq
         7+IVlizttangAp2fOKwnfqnrraVGe12vIekgcGgH0BEB8DdLrPtA0hmpALrz30kdAdfi
         t+Cw==
X-Gm-Message-State: ACrzQf1ugvnAsNQK92Xu90VXXEDFd3RZY6y+HxaXZtBoaM4CO58NKjPN
        CVu3TV0J/WJiq35UfkO3nv7YTUTY3SITEBgBCLk=
X-Google-Smtp-Source: AMsMyM5bV3fgpyGAd3fJShXwK5CUenO1GV6PJAHHZ0he7BH8K0rmqW17GGwIvt74EszSAU9ZPEyQiaGK8YWKwmQzVw8=
X-Received: by 2002:a05:6402:40d0:b0:462:7b99:d424 with SMTP id
 z16-20020a05640240d000b004627b99d424mr56673307edb.62.1667932445299; Tue, 08
 Nov 2022 10:34:05 -0800 (PST)
MIME-Version: 1.0
Sender: ndersontheresa.24@gmail.com
Received: by 2002:a05:7208:56a9:b0:5c:ee1f:14be with HTTP; Tue, 8 Nov 2022
 10:34:04 -0800 (PST)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Tue, 8 Nov 2022 10:34:04 -0800
X-Google-Sender-Auth: 3jQeGRYd07Zi6X7JiOpCiyFCrEY
Message-ID: <CAEJT=xBrFGECu8xe3Hbmcq05GOBMn7sz2CMXv3Wbk5iYG3oeNA@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.2 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5044]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ndersontheresa.24[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ndersontheresa.24[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am
mrs.doris david, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I'making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
mrs.doris david,

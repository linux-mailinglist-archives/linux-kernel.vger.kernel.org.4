Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E68364EDD0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbiLPPYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 10:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiLPPYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:24:51 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A27D60374
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:24:50 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id j4so4030259lfk.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 07:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uZJQlztl4lvsQKxdHLWxG7Zzk/r0Lb2ClxI+AKIGcBE=;
        b=qQG6V6kiTPCQ0HJL8CdU5LdNSYGX7IKBc16WgH0a5PBIqCfLZ1ymGZIO8j/YW7EZGk
         NF8tF4VtFPd5cmQOUI6vYvWBGzGbjsP/jDlf8u67N587kDi8fPCp1U6nZ8m3jaSyH2QD
         1lQubTh1aYr8L8qfUlO7TXfXf0Uy1sd2pigsQDsPtUDnd080xxKT9LBLqlLCbrrEEjYN
         CWVEZ4YKJfrL7qeGHc/Qe+ZAxPJmCTDzdTGMbvk48yt9+wHbqjX0sEA0vZcwkxqJxj4+
         fG89q1dd+DIlhzIaTFaKVYRrLTIPUrlw9DChD6E80RRWTj5DEX5EkiBgFY7O5DVcyOyb
         hckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uZJQlztl4lvsQKxdHLWxG7Zzk/r0Lb2ClxI+AKIGcBE=;
        b=cMqbEsl8MShC2/f5MCciahp5ormPUzvf59qeuhgj3DFJfFGsqKdm88aMHSDMFYFFpq
         ojlQoy+f2luMgtGo6al5sQbcCvcrv+0R8CcfVttd9P5on4u0Ce/44muKLAradmoNgPnn
         ozG88pi7yMYa/ZIbwnoltAaWL7B5wgE09NvWYIGUQt1/ksMZCgzYr33eAeRBfFKogr3J
         P8Cr2ZGzJKLrvqmnT9C7JLmCQHp/gXohFiZ3slOcvtrPhRLSr2dNmZS3JSojKHjrI5kQ
         Iydbk+i0yGOc0f9ZvhGdbBoOZQKZObvHwb3Zhd+wszNtYNZRsE5Fnooc/NrAkDbKeJLQ
         2gog==
X-Gm-Message-State: ANoB5pkjeb6Q3Ep2wzu1YXDHSPsKbUEZ1y5WlTd2ZvN9N/vB10Tm+UaU
        /BYFukquMdx5Z4OZmGO750nevFXkxuaOjgp0d44=
X-Google-Smtp-Source: AA0mqf7a9dTp9L8Xlobshk4qucXr21vqP0hthy1d8bfiuD1UV2iVnN7fhYGXvVy+we4ZOfDqLr9sqkZE24X/73PlPsQ=
X-Received: by 2002:a05:6512:3990:b0:4b6:f1af:4263 with SMTP id
 j16-20020a056512399000b004b6f1af4263mr945776lfu.114.1671204288241; Fri, 16
 Dec 2022 07:24:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6520:25d6:b0:22f:2dde:6e8 with HTTP; Fri, 16 Dec 2022
 07:24:47 -0800 (PST)
From:   Wang Chen <wangc6084@gmail.com>
Date:   Fri, 16 Dec 2022 04:24:47 -1100
Message-ID: <CALuFy5GdNjPUNKYjmM1VqnORmDrJaomsjR3RBcs=oiXY+TvhHg@mail.gmail.com>
Subject: Greetings
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.0 required=5.0 tests=ADVANCE_FEE_2_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,
        MONEY_FORM_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_SHORT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:132 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5079]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [wangc6084[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [wangc6084[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.0 FREEMAIL_REPLY From and body contain different freemails
        *  0.0 T_FILL_THIS_FORM_SHORT Fill in a short form with personal
        *      information
        *  0.0 MONEY_FORM_SHORT Lots of money if you fill out a short form
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  2.0 ADVANCE_FEE_2_NEW_MONEY Advance Fee fraud and lots of money
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are writing this message to you from the World Health
Organization-Palliative Center meanwhile Your email Contact was
provided to us by the Network Service Provider and you have been
Chosen as our Representative in your Country to distribute the total
sum of ($600,000. US Dollars) For the yearly Empowerment Donation in
order to help the Sick people and Old people in your Country.

If you receive this message kindly send your CV or your Personal
Details Your Full Name, Your Address, Your Occupation, to ( Dr James
Edmond ) through this Email:
(drjames1890@yahoo.com) for more Details.

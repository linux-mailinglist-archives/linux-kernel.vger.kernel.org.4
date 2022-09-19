Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426705BCA2E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 13:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiISLBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 07:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiISLBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 07:01:18 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50383B21
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:00:42 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id o184so14131061oif.13
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 04:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date;
        bh=zfgByj3IuT6F6C8KDsKuFLjZLvEBVQhrDCRL0b9kb9g=;
        b=IVbrJ19Qu8U804smJv/zh+D9vZuCh6XMveL+m+Tes7kRPykRpaObP0+OaMfVeA+7EV
         VJ6P+A/NO63mDeNaAs5U38aog2AcS+7hQjMYYKA2u7yRyRF+QUCHNweMrztiqQq2l12K
         G+uPO2sI/cb9uAOZO7v67nGreY/QNDbTH9BSJebocwYMW3cGNb88y/g4oaO4Prs7+for
         XJPI8u8ufzyVzyXldu6c8mQSi/5YvugUd6bZ7OeKo57Kf2GcBNuet5gRC/jmzHWRj6+Z
         xRhfS3PUWFmiMNV6fvrggQSl7aSu7gjT8lfTaiq1o83xLTG58jN8UrKtOGavjUqL57f0
         9dzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zfgByj3IuT6F6C8KDsKuFLjZLvEBVQhrDCRL0b9kb9g=;
        b=insw455bte0EJaMSaW9XNz7avjQ4mKGoJowfrWdvLqCpPr0o5I85BCDZGHnAI2DF0L
         9URJsYvpNVRcFF55px9Av0T3xpCD31B7/bpLtEzUKTkdOUykREou0buI/h2jq8egy4y7
         /U/HfLp6lXFUQcAAp0h6nYAex/CjS6o9lLzLFbyHNCQZXs7198/jJbJTIki4rnQ5ayKB
         YwbJ2587koYraqSEzI8jWtHDcP4pG6Qq2HIYiJZHimHFFpBYtGDbLVxTwB6gOxyMqP5s
         iDR9iqFe4J3RrFLbZpAip27EzLmYABLkDcqWdnxb1zdIaOj3mNvKeYwvZPz+vH+4+HR0
         9Hkw==
X-Gm-Message-State: ACrzQf2jjYsiqf1z5kjcmbD1FNI4kCfjvQ4BtFtR7t/5EvWku4r8JfAB
        n7oTJT5p+mtCwmeOn6Rf8fz/vS6la3/MG5PomNg=
X-Google-Smtp-Source: AMsMyM43ZsQOrXosRY3OtOkLZZjlORSh2VE4lJRPfv4qByfpPc69Eu+4VIEfqniVj3GCdWsdsdw5CiFQzUq+0C6y3bM=
X-Received: by 2002:a05:6808:d4e:b0:350:9eed:4156 with SMTP id
 w14-20020a0568080d4e00b003509eed4156mr2464990oik.77.1663585241533; Mon, 19
 Sep 2022 04:00:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:7c2:0:0:0:0:0 with HTTP; Mon, 19 Sep 2022 04:00:41 -0700 (PDT)
From:   aristide anongba <aristideanongba56@gmail.com>
Date:   Mon, 19 Sep 2022 13:00:41 +0200
Message-ID: <CA+7HCDvdWoMnybWGrAipmo=W+v_FtNuPKy69A=Juk0Jv1Obq=w@mail.gmail.com>
Subject: Hello.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.5 required=5.0 tests=ADVANCE_FEE_4_NEW_MONEY,
        BAYES_95,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MILLION_USD,MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_MONEY_PERCENT,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:22a listed in]
        [list.dnswl.org]
        *  3.0 BAYES_95 BODY: Bayes spam probability is 95 to 99%
        *      [score: 0.9546]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aristideanongba56[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [aristideanongba56[at]gmail.com]
        *  0.1 MILLION_USD BODY: Talks about millions of dollars
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  1.3 HK_SCAM No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  2.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.0 ADVANCE_FEE_4_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
Good Day

My name is Mr. Aristide Anongba,  Regional Bank manager of UBA Bank
 ABIDJAN - C=C3=B4te d'  Ivoire. I discovered an excess of profits of ($1.8=
m),
 One Million, Eight Hundred Thousand United States Dollars  which I
have kept in a suspense account without any beneficiary.

That is why I am contacting you to work together to get the said
fund  transfer to your bank account and the percentage ratio is forty perce=
nt
 for you and sixty percent for me. All I need from you is to stand as the
depositor next of kin, so that our bank head office will order the
 transfer to your designated bank account.

 If you accept this offer to work with me, kindly  reply for full details.
Best Regards,
Mr. Aristide Anongba.

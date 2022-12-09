Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4631647FDE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 10:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiLIJJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 04:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiLIJJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 04:09:20 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2CA154771
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 01:09:18 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id p8so6032574lfu.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 01:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL7uZ+TBUyQGrNO0JXOoxWt3zEMOn9KaFZDKXAjlBBI=;
        b=RKO8xqGZwvFxOWHHlPrmdoPxe83bUH2V5mcoqpx/TZlxei3+y25jl9OH+K7l+uCxwy
         0Q2dCsG5hocs5CEfbPhn7TxX6nStlpxMrFJ/TPTQd+R+CEEVXvzPVaqSE8E5w1ZeZzpr
         VUb6JZ82fhYtFeJWEKfDfaSf1YdsSM/TUg1llU6csqpLJH/gMBr46rKXbDGkMPUtLBxv
         3aRo7O0aR7QwxsAEBU+lu11LQdr42V55LU1lghB/PNCbMDP+mxo7qafUEnwPCUsm4spK
         eYhCZGLBxu+icJKTn6efWLyxv8VWJLDGhP9dMSosuMOcN3mN2KcvBSYkH04JCqD34ZJc
         ymjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rL7uZ+TBUyQGrNO0JXOoxWt3zEMOn9KaFZDKXAjlBBI=;
        b=ls0Tf1KLLQ6xVC/qCUWQR8yP+ij5uyDEszP/L2g9OD2k8ZmKkQ77SiBt4H6ev3EPZW
         HGHl0QwLBRHeDKn7jA29LiigYcuVyVHogcdCqm75BKQbfVcAWWEfMMjm25T5sBR9eXbS
         CG10krJgf4XczU7EnAL6kmxxCokDbGRuSWMRdLVI92oXMsJXod6y8zwec97V0To9awWJ
         q7qSLESO8StrXsF6E9uOXaS2lPMgw0Rr1+v8u8zw1GAPszjhHlaN5xBieQbWtqgCjTE9
         1CJEo+3hpvTnWd88ythpbb8QeaMO3+Po1HoaFr0aP1heuj/vj2EgMIyPgYDHzvzoCcE3
         QvXQ==
X-Gm-Message-State: ANoB5pnb1PSUbOfpJQYEHob58NS0sa9zdY2hsI/cfBiECGIwTwFwDb+P
        /6tawxwkzY83a9zVgF495GjJZ8c1XTxcQegIcmI=
X-Google-Smtp-Source: AA0mqf43d5p45aIMYpEO85oFG6FpccTByQnjVvR50pMByemGWDOiyLhVt9fBusaMV9UdkyZjALnWTBi/uTLmm8wiLCs=
X-Received: by 2002:a05:6512:3f9a:b0:4b4:bcaf:5713 with SMTP id
 x26-20020a0565123f9a00b004b4bcaf5713mr24705782lfa.103.1670576956751; Fri, 09
 Dec 2022 01:09:16 -0800 (PST)
MIME-Version: 1.0
Sender: ojongonwa@gmail.com
Received: by 2002:a9a:48f:0:b0:22e:c328:fe2 with HTTP; Fri, 9 Dec 2022
 01:09:15 -0800 (PST)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Fri, 9 Dec 2022 01:09:15 -0800
X-Google-Sender-Auth: -BLKR14VltOpdutsELxLojMj0ZQ
Message-ID: <CAA-P_sN5KNUO4VAXnHJaoTDNVBVewcBRJVM3wxy8Sq1+s-hGZw@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.7900]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.doris.david02[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am Mrs
david doris, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000,00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very Honest God.

fearing a person who can claim this money and use it for Charity
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
Mrs david doris,

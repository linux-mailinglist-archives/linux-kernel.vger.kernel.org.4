Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7572B097
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 09:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjFKHPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 03:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKHPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 03:15:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A8130C0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 00:15:48 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-654f8b56807so3412704b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 00:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686467748; x=1689059748;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=piNs7cUaubO42kepKyYdnlwCWh8vcgVQftlGVPWVub4=;
        b=gHSTf1uZqxKv5KE5agX6W0dQGdSWfFnX6qD6Rwr6at7B8RcCp0mffIJIsswwCUZtPD
         ZSYN3hUYiJpHqIzCLLBuBUZlJBCCO2kUE/odAOJzqsczm3LV33FtNGspONsUiXl5N95/
         YLEFt9kl+gNf6TpyyDwtPkgqM1W1HWOSphAdV6NIZRv+PeGFdxbES2/J2Ry1vk0yxwPy
         ub8oIIdOHvgGlYYPe3cZ/WgMHP4GuxNy6ulWSe2ULRGK4n3E6KtAr4OdQr5tMR7nxXLr
         9rVl/PyNYIM+SkDNU5k1sZzcaGVxwBwhXHJ4viXX4enWrPSlCAayD+c8T/ILdEQ7D9Ab
         ta9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686467748; x=1689059748;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=piNs7cUaubO42kepKyYdnlwCWh8vcgVQftlGVPWVub4=;
        b=DCmNFZuKCAEL3RbtKy6xqo4QLzAX40vaKLgB5Iut6AfYWgz+5Tma2HOHv8bSqRLscJ
         xGlaF3A6XHdKsTeHZxMQvusTIMRd/vmbX/IuGj2chotFEUzGglMN8tBdea4ymfSyENWP
         3qKsYTtMxLr3Eu7WZrRim5C58STeNXoNhQxk0OkkeFNpPHfc6A6FwFdPtGRTrp1cno+7
         mDjhIWhMLL70H8XTxQD6BLMksfQV5/HLi6KD61yuITDqulAWco9Vy/IYlabF/bAwLjP/
         7Et7bfN2ib48HSBrfflRD9GEcSU4L3R7yOgLMXfkWbYRnFffRLGPmzgoFqs5SYb1dNOG
         ePEA==
X-Gm-Message-State: AC+VfDyutI0tyZNkAtfXhL3QAB8l/jCDGfHTW+LkRH/Ciofqpq/mYxhL
        J7Pm75GCMxmpM/Ex81L1g3vkIUBSShr7UYPvOjI=
X-Google-Smtp-Source: ACHHUZ7NR7g02b0PYvkGpPezpx8aJ2SrQEDgMRumDYQmo+jUfQ5+Vx+jmJaF/fn62AMrNso98wiEcGSEQbslbj2/08U=
X-Received: by 2002:a05:6a20:7d98:b0:10d:d0cd:c1c7 with SMTP id
 v24-20020a056a207d9800b0010dd0cdc1c7mr7640843pzj.15.1686467748198; Sun, 11
 Jun 2023 00:15:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6200:5382:b0:4f5:6e41:9eb with HTTP; Sun, 11 Jun 2023
 00:15:47 -0700 (PDT)
Reply-To: BlavatnikLen@hotmail.com
From:   Len Blavatnik <rosie.wong.edgewell.com@gmail.com>
Date:   Sun, 11 Jun 2023 08:15:47 +0100
Message-ID: <CAPw-1p-CYF1aHY=CTiiLQWAvzYzHhywhT47QFPdE9050ab85BA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:435 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5353]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rosie.wong.edgewell.com[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.2 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

   I am Sir. Leonard Valentinovich Blavatnik, UK businessman,
investor, philanthropist and Chairman (Access Industries). I donated
20% of my personal wealth to charity and I also pledged to donate 20%
of my wealth this year 2023 to individuals. I have decided to donate
$500,000.00 (Five Hundred Thousand Dollars). If you are interested in
my donation, please contact me for more information.

You can also read more about me through the following link

https://en.m.wikipedia.org/wiki/Len_Blavatnik


A cordial greeting
President (Access Industries)
Sir. Leonard Valentinovich Blavatnik

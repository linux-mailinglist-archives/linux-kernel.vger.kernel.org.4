Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05386EA66E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjDUJB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 05:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDUJBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 05:01:13 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFC86181
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:01:12 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-24781e23c27so1725944a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 02:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682067672; x=1684659672;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=htXlbzqp63+STkQngEOa7IRTrX4+CKs8+lkcj1zjuBA=;
        b=WfWdCg53KnsPK1wGGliG8omXQxaWB0yffD0IKbIUZr89Kh9g+sJUR9QNxKxpzh4Sxx
         NubArbgxzPail9qsXDWSJMp11b1PFdAGvMwlalYJ5F1VMYK/567ihse6IAYzMMrFYnNn
         3T1WWiQnaYf33fOHMrfZUvo8XGRmJjIWp4sc1FQJi2BZiENf0j3NuV7WreH4GlI19/sq
         mALaXwZGfg4ndD5ESt4gBtyq0ORk4HaEyn5ANmj1yfbYoA6uonLAN4k49dwlyevKvtJh
         WFmjK4nOwD5uviu3Nhen82d4CkLIYKZqei94ZHkKX7hYQJ/bhaU5VCbZZc3c+6OTa2y4
         AlfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682067672; x=1684659672;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htXlbzqp63+STkQngEOa7IRTrX4+CKs8+lkcj1zjuBA=;
        b=fXmph0tnkdC0DDW4l0tVTfnGws/gfPOVj4xzWcrEPPTvdQ5CaG8ua2moRAwU/P8PKO
         Corlom9VFXC6me3acrpNlC8faGofd9WH1xhP/+5PgUIXJF/3UZl85d9gJ6alQt4WZnY/
         K2NDYUANBOJy5oEt7qPrK1hWikRkZFlZpnnjJbtqzRe82VChbUY/1MGgnQtyq9ErVKOX
         TaJ/xtTwsMk3zi/I4Vr15mVRKLXx5FctZleG1P0kAkOL1du3GlqZ4XSLa93nTNR/67sX
         R+qbuVypyIH1Qka6mWandRBFqW0f4eKHhQUJjAU5RS0ARBKg+nZp1PLq1G8l8NwJPLrV
         l1zw==
X-Gm-Message-State: AAQBX9eXhLTpNr51Jlmxzwgy+6plaVdtfW8IRTj2SL2nPAsuo1aKiE40
        3XNCVhjwNTqaxgxiugPcsypBjJS3ujXrEAWHyoU=
X-Google-Smtp-Source: AKy350bGHA4FJDPyqC/ylZM3xcKwUdvmSKfc+X34Lqu/SYkkQ9amRFAm50zKcAuICkw4FO8kYf7ZJT92jgJDQTkClJE=
X-Received: by 2002:a17:90b:3912:b0:246:a599:1ccd with SMTP id
 ob18-20020a17090b391200b00246a5991ccdmr4491661pjb.16.1682067671850; Fri, 21
 Apr 2023 02:01:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f947:b0:474:921b:34cc with HTTP; Fri, 21 Apr 2023
 02:01:11 -0700 (PDT)
Reply-To: carse2020@aol.com
From:   Peter Boniface <kabocynthia1@gmail.com>
Date:   Fri, 21 Apr 2023 09:01:11 +0000
Message-ID: <CAG5ayEi=v28fPBZBWeBEj-10=PFaqY1ixcvGQNgWuj_hw7mDNg@mail.gmail.com>
Subject: Inquiry.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.6 required=5.0 tests=BAYES_00,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1034 listed in]
        [list.dnswl.org]
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kabocynthia1[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kabocynthia1[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [carse2020[at]aol.com]
        *  2.0 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  3.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,

              I'm Peter Boniface, in my region. we specialised in
cultivation and producing pure honey, cashew nut, groundnut, coconut,
cocoa nut, shea nut, shea butter, coconut oil, coffee nut, coconut
meat, palm kernel oil, palm oil, groundnut oil, cashew oil, garcinia,
kola nut. ginger here in Ivory Coast, West Africa.

However, I got your address during the searching for an international
buyer, and I decided to inform you that the above mentioned products
are available for sale, with attractive prices.If you're interested,
contact me for further information.

Best regards,
Peter Boniface.
Cel: +2250152163893.
Email: carse2020@aol.com

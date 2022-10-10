Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482CA5FA237
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 18:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJJQyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 12:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiJJQx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 12:53:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C7959248
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:53:56 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id c20so1306579plc.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PkFKxoPfujtFIL4f5fbXoQ1/V1fCWU98DNuyJHz6LT8=;
        b=bD2S9D/M4dvEw5nGGGYqaqYB68bsvB+NPHG/sAjf0/nUID9i/YCkYX2t7KQDb74N7H
         lrbl66zSxErGWzx7zsO/G6qCEaZ4OqexbZ56BXi/YikIVy+xERyiKAWok1hMYZPN+s6t
         Se6dIVsVzstWZqoRRLSd8AouUmWjugtklyAjJfB+JdBc0YK8EzI4PZexHr4JCPKFz+qM
         rEFZL+5sU0nwUzql9Yw4Z4HnlepPovGDYNrlsYgJRukEEstJarsWTxJp+adFVqmY84gJ
         Dclm63H6DAZJyNdQtvgTkWjKJkZgU7neD4H8DpialAlu0rSseTknZNJ/wr0V2OHffgNI
         Xc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PkFKxoPfujtFIL4f5fbXoQ1/V1fCWU98DNuyJHz6LT8=;
        b=d5va+U8D5SN2AvSlzruMyneYE5Dd+RgugKV2St6X2WoQTXFB0/+EOIrUXLhfDDWQdC
         ehWOGasQMOWtw+BEYdyDIvuuIrx4quAuOKNONMLUOWx4kk1upvXItwIZCUShAISAdycF
         PZn+5ZOcr8d5ruglab2eTwVeG9+ZGPIswWpK+pHiDROKGZWrANQ5jvbqC9+y45gu9X4d
         hWL0EB6cRuWhwfLbw9wLHyi+52silaSb8lMroPMAXoypnebVi9X6R2qOh6pl1RVJvqgM
         zHLHHv60Z6SQiLk6AhwodHeSDgWYUzvc9YokxtbAmHgei+FYPAqz3dP0zB/c9yh3qNem
         o3Mw==
X-Gm-Message-State: ACrzQf2HsmAeEDjBctf56OFYQ6einfvN85fJCj7AnPho+fuVfOTYActL
        IxRFb91/AcvT95bCkhdJckiVsnBprESyBDCi2Rs=
X-Google-Smtp-Source: AMsMyM5haRe+kF/vTjOFfjmxi7XYqgGZpl8q3oCotZI4XeT+u4uiNm45fcBxp2C3JywKkjyH28coN28Vr6a92DemIM8=
X-Received: by 2002:a17:90a:5915:b0:20a:d6d5:31bd with SMTP id
 k21-20020a17090a591500b0020ad6d531bdmr21810660pji.15.1665420835204; Mon, 10
 Oct 2022 09:53:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a10:6812:b0:2f4:321c:94e4 with HTTP; Mon, 10 Oct 2022
 09:53:54 -0700 (PDT)
Reply-To: lindabenson666666@gmail.com
From:   Ms Linda Benson <lindaben1456@gmail.com>
Date:   Mon, 10 Oct 2022 17:53:54 +0100
Message-ID: <CAOK_GkKngqQoBuh8dmk6CqQpiJN1RWdYZwJdkRMWXMScuSVg0g@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:635 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5018]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [lindaben1456[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [lindabenson666666[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [lindaben1456[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good friend,

Greetings of the day, please kindly give me your attention

I am an orphan child and only daughter I am looking for a reliable
person to help me out of my present predicament, I need your help and
assistance in the transfer of my inheritance fund to your bank account
I will give you full details on why I want to do this

Please reply soon, it is urgent
Ms. Linda Benson

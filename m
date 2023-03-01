Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 224EC6A759C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCAUvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjCAUvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:51:50 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09C44390A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:51:49 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id bw19so14555861wrb.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 12:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677703908;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B81xlViOcuY3fmYoSsyw/29AhQDJsJw7S4k495w2qRw=;
        b=mtyU+ByRTDKdCtDlbKC6sgXNGiY3osCAEWsHxQBlTCR97vK6ajJK70lvdOa7rvWJBO
         hDrZEf37hFzisWlJYGVu+RHvwdHcgnP0AqWYbpvf76dGUGXCCv8JgJhNC2cjLLi2iaJ8
         I001lumBBno5EAk6Ng2dxHiZ0LbRietfsybNsouwKEGo3YYNjncboXmFtls/gkxhc++e
         4vxCvKMmAiHkufSZ2H5IDcdwRCGKJVv8e9xjKuIS3JLgvb/01nb74wa7LaG4/3I2XIVT
         +IcfGHuZh6rWKnT9ruEKQ1faTRDNGdlVc9eGfOEJiZ89wqcCd6aHZj+WGud73JhZ9QNn
         mylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677703908;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B81xlViOcuY3fmYoSsyw/29AhQDJsJw7S4k495w2qRw=;
        b=OTkr46rl2q7UsfVnYwmHWB3vvcFoU8S1w3LIY0xt+SZmGuJ2YQ+rq6g6Wv5vIRNiVe
         njCCXOuZb9tVVrJE3lW96AEjzZFHY4MxCAUmghPIBNho0sae0xh076SemD95sKlRVja5
         Bif8E/lKdPTe/YrQ+6UlamDeQCc9pWlRzZo8XJpjbzwODW4Qsl4r7tjgW3ZQS3FbRLgH
         L9SC4szDLU8Z5QPrVYPXLpesQbTrIzJHdekiOmfVcEjGJ1t76XkbgpXQdYUTAu40cw6v
         T3tMeFYpzKJneUvoOW2IgXEl6L0O/+TvbF7rN/dbS1zygKNR2paL+dS0XGJTE5AerJPP
         jUBA==
X-Gm-Message-State: AO0yUKVxlgM0HjQsWiqxCP3zm+qQ/KOSAqVb5cR2rpylBQeUAJ7ucZHv
        7r0vk+khIt6fylFYcZbBh2LahIfPMkLaYyUFjOA=
X-Google-Smtp-Source: AK7set98GLXokY1XLmhGnv6VFSiTcDqdEI9Aq8gPpUs6KUQtTGBWomKuTUqTMB9LQSCBe3g2r0Myk6Me6VsPwHgs6tY=
X-Received: by 2002:a5d:42d2:0:b0:2cd:bc79:542c with SMTP id
 t18-20020a5d42d2000000b002cdbc79542cmr643643wrr.2.1677703908126; Wed, 01 Mar
 2023 12:51:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6020:e9cc:b0:259:afd4:1601 with HTTP; Wed, 1 Mar 2023
 12:51:47 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <joykekeli4@gmail.com>
Date:   Wed, 1 Mar 2023 21:51:47 +0100
Message-ID: <CAO4V9UG_WiZxE9BVwxJdcLdY_qQj_iMpR0Wm0Spi7=M=ofCuUQ@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:431 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4997]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [joykekeli4[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [joykekeli4[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  3.0 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham,

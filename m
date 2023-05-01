Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DED96F2F44
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 10:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjEAIGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 04:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjEAIGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 04:06:53 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78C41B9
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 01:06:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id ffacd0b85a97d-2f40b891420so2142469f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 May 2023 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682928410; x=1685520410;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJv/fJ1N9jilF17E3JtERDb5lS97I4U+7QcLu+oqNwQ=;
        b=XITFjH8mYTU4loFcpq8Sfn6rYG0M57sODOkNo+GUmf/gLuAj/QmEX8/lfMdKN/dJEs
         cpdkXSFEDK1XPUn1HzCZQTY3go+ScAaeEEyMhdjwNKfuQ+dZh1uHoFua+C8uT7IP16/V
         A5ZS7MX0Mvra6khwMpvQTeZGg9D/6gZssPxU4Ml8tVtRFuFncpGoH2MIBJlwIik9A6Rc
         /vaRsH0MQqSYLp3ROGUUn6svUkz7NwEhnbcvXnt3OsHY+Rh1Rc4cEb0DEMm2t0M2n+52
         hG+m79QUOHfLCzOjGTe562P8yXpF+kv84cuUKnDaCHGkR9VwEKKklK29u+RT9m1eJYYT
         DLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682928410; x=1685520410;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJv/fJ1N9jilF17E3JtERDb5lS97I4U+7QcLu+oqNwQ=;
        b=hUOouLwfYMzNTCM7v5TjuMmIFb63M1oIPneccmG7YdL0N4Vt/PeLLaHqhTlcYf3Y+E
         CNOiBaWU44T8apF7ngcBvejzrbmKpij1pj0NmL7qUQzwAWg2RgHnrh2LvCr15hn8qrRt
         ewTnCcDihI6Np30ABWfuDPstU9jn5W+DPc9UVG9WaNWx/500irS4wHDrYKe5yEfFDqVI
         XrcEmnO8QkUYRzBeeb5JgP1yAF2mVw1rNAPpQGQmHU3HiWiqR4m2x4WIzF2NMqK2/8uE
         7Y53lCXKY96a2NzR8JOF2IuOqh37e6zy69JoIBmLO8u11iXXhTXLgs9nc7QJmKPve3+g
         nvPg==
X-Gm-Message-State: AC+VfDwNS637QbPJywoZelaI6aWlSDcppnVxODKZMhSSHhMCEOuMYAiL
        Z8sxas5QlcfhGeMbBD8Jd4baEhjDMk0umLYbzu7iaCFnO+QKWA==
X-Google-Smtp-Source: ACHHUZ5WuldWKSwSzsUMTQQdRtLqbB7ZCnOZZnio9EpDgI/WEFLn3Boz4idzAH2yQ9jScSsWcfnYa4n0E4WB7kaHTo8=
X-Received: by 2002:a5d:6748:0:b0:2ce:a34b:2b0b with SMTP id
 l8-20020a5d6748000000b002cea34b2b0bmr9076775wrw.28.1682927912014; Mon, 01 May
 2023 00:58:32 -0700 (PDT)
MIME-Version: 1.0
Sender: mrs.mcompola333@gmail.com
Received: by 2002:adf:ea05:0:b0:306:31c8:dd4a with HTTP; Mon, 1 May 2023
 00:58:31 -0700 (PDT)
From:   Mrs Bill Chantal Lawrence <mrsbillchantallawrence58@gmail.com>
Date:   Mon, 1 May 2023 00:58:31 -0700
X-Google-Sender-Auth: iHW6VUZyFb4qhx6R0YR_PBAEFKg
Message-ID: <CAMw1Tj+YUGw5wFsL349RaSyWLLrofrb0BCBmY-CFhMcRXELj6A@mail.gmail.com>
Subject: Hello Good Day
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:442 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4972]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [mrs.mcompola333[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [mrs.mcompola333[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.5 HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Good Day, You have been compensated with the sum of 3.5 million
dollars in this united nation.

The payment will be issue into atm visa card and send to you from the
santander bank.

We need your address and your Whatsapp this my email.ID
(mrsbillchantallawrence58@gmail.com) contact  me

Thanks my

Mrs Bill Chantal Lawrence

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB1370A427
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 03:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjETBFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 21:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjETBFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 21:05:07 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84671FA
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:05:05 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 4fb4d7f45d1cf-510d9218506so2935800a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 18:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684544704; x=1687136704;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O7HlAEARWXacHZe2CUvQqsqGHJ815Kco+WM8X5uUNNY=;
        b=Tf3v6JOVpHwrXSPU5OMmaLYwFRMmtrl87vAu5l7lkbL9OcLFzFusB6FnMQIVeRgrnA
         xZ63VymV5L+QiKa3o8xOrXF36FAMtfGDmFIvwGuPPzJK7yJRWGp7H2hv6iSdB8aFYxiW
         h073NCPvZJAvbo09JGYnjqSpmuihsWshypzU1xYfN7n9YY/5PzpczID8Favccg2r+/dc
         +ZTubHQbuXMVGHaeGac3jNwtp83rJzbFRlxMdDynopOO1u7LxVgSRvG76p6s5BVvAmAp
         e1HcPKetdgMwheNdU3VNgHw8SZf8RFaR1+lla1wO/0U79gPJ91XFllwSTTdzNwvUyFc4
         sCXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684544704; x=1687136704;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O7HlAEARWXacHZe2CUvQqsqGHJ815Kco+WM8X5uUNNY=;
        b=lYh0jH+SM4ws9WlJ7ct5rEO/mw9LGN8FcrrmAqSRLii5MP/6J2alfUPvgYsPiVExCL
         WwIW9LZ0G2JobGoseGcBabX0787VdVaHnkPzqyRvkDN1Dw8gwvmnLrSIfgbAEGA+KTnA
         WeQoaRrwKbzWKxqfVwVBzWm2mgEGKJg4AQyLdGlDF67uyWgGeYGXLuAiXCZlxC27sr9P
         aS++oYH2X8N4qJGEI9xP8oE0lSZ2baU65QsI3WA+p9y1AJDos91txCzaBB0MhhBj/IuZ
         JITc/iQa09hQYRA2zVk/mSF2e1yjJjxRZP1ZVgrLiuNq+6t87ekZtWxOh6VAcr/6y9OX
         JkKA==
X-Gm-Message-State: AC+VfDy74kxSc5Zaixc6dBUhrfq9y8i0JI7t++5a6ELWJ5PellJibiT4
        eJ7Abcg2WQ/ouzomJ7EiAk3yan9d+Ae6GqlOKPs=
X-Google-Smtp-Source: ACHHUZ5bt69ayhGMwz/mxruCvwxPj2dLC7uQRHdnHnXum/Eh7rNzkdi7Y3dzKYSPlIZy+4YDNsQElWcmO187Jww6s4g=
X-Received: by 2002:a05:6402:1603:b0:4ad:738b:6706 with SMTP id
 f3-20020a056402160300b004ad738b6706mr4232670edv.2.1684544703857; Fri, 19 May
 2023 18:05:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6402:7da:b0:50b:ad89:1029 with HTTP; Fri, 19 May 2023
 18:05:03 -0700 (PDT)
Reply-To: americabnkcapitalloan@outlook.com
From:   Amadeo Giannini <l.biasiolamperauto@gmail.com>
Date:   Sat, 20 May 2023 02:05:03 +0100
Message-ID: <CAHPnz9HRWaxqDVtGagf7wE9irvNnhNyBe5iR7cBMAThKeBZu0Q@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looking for a loan? How much do you need and the time to pay it back?
Contact us now! Amadeo Giannini.

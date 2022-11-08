Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E858620CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 10:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiKHJsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 04:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233899AbiKHJsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 04:48:14 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0A42F53
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 01:47:31 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ft34so750916ejc.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 01:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WIm6378Nh4ItLM2aDQbKBBMlM1ow1uuLRa5aF3FbeU4=;
        b=pylIPN0L2MO4pihMliv9ZhV08GqCW1On5GFrBGIslE37scxAPSSlCt2Uj/TvbooSzj
         u12veVbiG1AvWZzwr20xJtVrRL4FPoYl8XFv1y/InBClnzAMoCp+kQMZADzSFsKz+kT+
         lL62uF/FpbVJstsXissYOi0Xo7Kz7h/bMLmZ6KHrCItJE89Wja01EqAN2a99Lc/uMk3D
         pRmTyodWH+jruMCGbBpgEwLpzHey/owA2bScDGrpEY3TorT2QRSZf5OFOdZ4//b8+kDR
         XKoXoWfKtQSrqmoZkHT8YCTKbtRmzNBDerX7of4RBWRyk/f29aBB0p+rYr8wkcvD83rw
         TYBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIm6378Nh4ItLM2aDQbKBBMlM1ow1uuLRa5aF3FbeU4=;
        b=AZtB0ersKo0QQbsFpsZtSPrjtbLHMzE2ilUr/PSDl77zrN+1hSd9ISFa9qwckto8Oo
         dLiedxrRRB+9au548+BjV6EBGWsQJByXb1UB8UcmQlTyWVMjOYRvsXhhdsQQcUKtwp7P
         i4F0i99cCm2cZt/MT6E5NDDymtzomCnlf/xe9KhKCmV0/5ExFjrrjoegJtt76TmnV1ir
         S9iCgMHP9B7775w5nYn64Nytnq+V9IyFbFhZb6/M8sDwnkWoFj8Q9oI8B7KKqb0d3g/O
         hnCl5dNH8+vs+3nwUZx4rSBqjfNmpibpQHbtG+5A4ASuhmWkiGC9WusjlEhDpJIS3UUf
         b++g==
X-Gm-Message-State: ANoB5pkpHuUt9FT5KwwjyhUoI4IELREoKXNOgcK+Id0hJuQCyHFVPxvw
        mEUc30/72X8sZPssG8NHnizTXHAKA81V51ur6xs=
X-Google-Smtp-Source: AA0mqf64WTSZVYl87B8/uKtpo4d0n1WbCA9OUUueJUb5VlRbBLt+yVFMg8CN9pCzDxw9xRKn+w9S0I6Pc5stzZlrbKE=
X-Received: by 2002:a17:906:f746:b0:7ae:6e4b:6bff with SMTP id
 jp6-20020a170906f74600b007ae6e4b6bffmr7395910ejb.46.1667900849696; Tue, 08
 Nov 2022 01:47:29 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:8c7:0:0:0:0 with HTTP; Tue, 8 Nov 2022 01:47:29
 -0800 (PST)
Reply-To: te463602@gmail.com
From:   "Prof. Do-Young Byun" <osane706@gmail.com>
Date:   Tue, 8 Nov 2022 01:47:29 -0800
Message-ID: <CAC7OyroMJ1t7sYFRWgXtdYYOYZvzreQCoWrJd=t+6LvFFcJCeA@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:633 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5005]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [osane706[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [osane706[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [te463602[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Greetings,
We are privileged and delighted to reach you via email" And we are
urgently waiting to hear from you. and again your number is not
connecting.

Best regards,
Prof. Do-Young Byun

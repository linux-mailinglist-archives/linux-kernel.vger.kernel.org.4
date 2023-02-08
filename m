Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E1168F8F0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 21:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjBHUjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 15:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjBHUjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 15:39:35 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216E8302A6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 12:39:26 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id b16so13028097ljr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 12:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHBMLXtkMDMuBmGxWJ5xKD6KTeIV58QP9tSrwZRgoHc=;
        b=UYT25/g3diV3Jq60eACmOjYWKzeUlN7xIlFvhQd0LhIfnA0s3fLLt8JuP8N/toHf8t
         nfNl0VORppwAhZXGkdbZrd9v4IFvW5TJ+vvR/O5IB/5olDIU0LSHSaD8ebHszq46bxiR
         QLyXefS0PyyvcrIiB0ET5FYn3fVGc/zIyRg78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHBMLXtkMDMuBmGxWJ5xKD6KTeIV58QP9tSrwZRgoHc=;
        b=6kDxllWcPRSb0LxJoKH0VIjjDMV9+TuXqtvdAMGeMt9xzghtbaA4Y/i19jvvnqO0ey
         LFM//qZeTELQmQmyaDfpstzT/oBKQBRNrjri2aTwCGQFxtvr+5f09tDYgMCIKgr6szei
         UbOmKpF8sRefgsjSz1G5hiko17nHysuACh85Fl/EcX3TDv+sAqA1gGXttwZG1NgqDaKF
         JHh6oyS4ejMUzyCNnYZD2ZS1pitXQU5/5N2821eficyz6Tehr4tj1ze8XDVANfHEKDMC
         2ZLoTBIUwMywmC9rLlPeJCGi1461n7lM7P5Ds6NQAL9pAzahdP7VEPcCYGMeZAokuK7J
         VkIw==
X-Gm-Message-State: AO0yUKVGBO1r/rjIPa3b0ahPAwLt4qpIfy4l9rU0li8MAW6BfDzoVt1l
        in70XX3jJuLg89Fsi8v7ZilsyGZR109Wbe2cHNEACA==
X-Google-Smtp-Source: AK7set/su4csPDm6Y8kHABC9mltJZzHg8OFQ8O69kscI/hl8JIKzjPP59FvrooV7TfPYdGAJoENWNUwYal1cEXgmXb4=
X-Received: by 2002:a2e:94cd:0:b0:292:7e94:82e2 with SMTP id
 r13-20020a2e94cd000000b002927e9482e2mr1851447ljh.78.1675888764474; Wed, 08
 Feb 2023 12:39:24 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 8 Feb 2023 12:39:23 -0800
MIME-Version: 1.0
In-Reply-To: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
References: <20230207081130.1.I657776750156793721efa247ce6293445137bc8a@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 8 Feb 2023 12:39:23 -0800
Message-ID: <CAE-0n50KzCB1tSAiPdKdh4G5kaZG9VQCN3VYycSsBedXynjr2A@mail.gmail.com>
Subject: Re: [PATCH] firmware: coreboot: Remove GOOGLE_COREBOOT_TABLE_ACPI/OF
 Kconfig entries
To:     Benson Leung <bleung@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        David Gow <davidgow@google.com>,
        Jack Rosenthal <jrosenth@chromium.org>,
        chrome-platform@lists.linux.dev,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2023-02-07 08:12:00)
> Ever since commit a28aad66da8b ("firmware: coreboot: Collapse platform
> drivers into bus core") the Kconfig entries GOOGLE_COREBOOT_TABLE_OF
> and GOOGLE_COREBOOT_TABLE_ACPI have been dead. They have no "help"
> text and thus aren't user choosable. They also aren't "select"ed by
> anything. They also control the compilation of no code.
>
> Let's remove them.
>
> Fixes: a28aad66da8b ("firmware: coreboot: Collapse platform drivers into bus core")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Acked-by: Stephen Boyd <swboyd@chromium.org>

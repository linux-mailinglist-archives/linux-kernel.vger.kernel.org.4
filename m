Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F55F8C6A
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 18:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJIQxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 12:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiJIQxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 12:53:02 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59BA1C43A;
        Sun,  9 Oct 2022 09:53:01 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n73so2136579iod.13;
        Sun, 09 Oct 2022 09:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4iRO+7/4lIu9eZ1/DziHCBOu7qOC4VfYPHIn9DnoOc=;
        b=nrCCUazwOwDw4sSzcEOqa+DrH/IPS9Sj1jExEri/AEbvIFPIVmQ9dJoBx5vV/N69tH
         ltLzNwbWw46/C2xAL5A0V9XcETv7L+zHZSIi/q9VMGYdhyKwohFuwC40gjOrUGPxn+Mu
         FVYpaPm7qlfDwFaU2fzS4bgkZ5PzuxSZf0IA5FDhNwDZXTsPOQitEy9Q+i8Fz5FMbRgb
         HooFAYiIDvqQ/ckCOE6bS93X/3EXy/sFbBdKyCv4W6LyJLRsQmEo0iSZQykgKWRdEa40
         Ep6+uHX4keWxW/4kI6siZkVA6iJ2evFqD9ZpZyy0Mv7LvWJW9ghEp+umOZBZGKMxykqL
         p47w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y4iRO+7/4lIu9eZ1/DziHCBOu7qOC4VfYPHIn9DnoOc=;
        b=OUF+jWHdngz7owIS07MzZZa2OVuX4rxpg3bW6J59BPiCYUQXvU14sadc9TJHn/Wpkd
         kxqDqeLZdaKg6xeoFL7FubFwVVvt3EuPyjwbExKDzTzqKIzYG9z0kZumSSGWct/bUv2G
         +nZUP7gd74GLRrOFjD7uukpvKhnhxiVfqtcGyZ56mejJLge6Y6Gxcm7LWQ4/EggIZnY9
         fQBnas2rmYKoN3dXesEJmqpkccnMXc8bDRzlffcNbyj+iGfWBqa4oL4NcWQFVi+v/9CA
         9qZOQSN08mrurTRCLcF63nnDhGoPC8AGEoggSoNcIss97t8/ZykMhNzJsgLRZeJ6Xtuj
         /+FA==
X-Gm-Message-State: ACrzQf07KfX29izhqzPXJEurb+f7C9w0/+HaB4jRrO8cBFisbR/Y0K5O
        +xC9FuywB8QiIsZWaKngB6rTyJcv16P/F9eXRX8/tf8gt/E=
X-Google-Smtp-Source: AMsMyM7A0mCGiQ1cLTEfCOgPGFKWaiAE3jrfEEyzpdC9qzYEJa0Hq+MHqt4wf22ILCINwm9i6LakopCdyyLMmtEt8Cc=
X-Received: by 2002:a02:cc6f:0:b0:363:98f2:347d with SMTP id
 j15-20020a02cc6f000000b0036398f2347dmr5990583jaq.199.1665334381049; Sun, 09
 Oct 2022 09:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <9ff662d738612f0ed2cea39266768a2eff21edc3.camel@perches.com>
In-Reply-To: <9ff662d738612f0ed2cea39266768a2eff21edc3.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Oct 2022 18:52:50 +0200
Message-ID: <CANiq72=duGy7Rakm=JG9ifB4D5qufemKvXMfvpW3Ky7wZ4bXcQ@mail.gmail.com>
Subject: Re: kernel style preference trivia: '* const' vs '*const' ?
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 9, 2022 at 6:21 PM Joe Perches <joe@perches.com> wrote:
>
> The kernel uses '* const' about 10:1 over '*const'

Yeah, going with the most commonly used one sounds best.

clang-format will be able to handle either way with
`SpaceAroundPointerQualifiers` as soon as the minimum is LLVM 12.

Cheers,
Miguel

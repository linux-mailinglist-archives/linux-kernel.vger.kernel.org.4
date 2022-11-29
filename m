Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446A863C0F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:24:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiK2NY3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:24:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiK2NY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:24:27 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C6C2BF9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:24:27 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id v13so344807oie.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gWtMAmUP9N3+Q5OvEhREu9a9b1gM1aNMJmjz1DilZiM=;
        b=Fk2vQ+zhuHImuAg8yoihnFsNYlNPEV7BGKzJDFQTIsS4g7Ar8DEQNkGQkRJcO4URjm
         wyTsnj+fSrf20KayigeXd9w32nNM1SHQ9iTvsnhmWqzRPOFxg7S1mvSI+p8znsPCS6Lr
         bJo60M0vvTVNAw2K/lr2AJfIVcSsWhNVDA+c6cJsVKmdJFAuI+4Ms1l+P8p4x9sm2QHA
         DPzkMrgZ7TSXDEpV4AUBj53qRZd4LPFcfdkpQi0+pC+AHgfJ+i/bad/pJV9FIThr9UMk
         F6Rv0sOwjchq0WbU54NPkDweCen/0wwOCDKFbgpI80Xew5kdD8GGDyU/sd2wVxg1ipR6
         iqeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gWtMAmUP9N3+Q5OvEhREu9a9b1gM1aNMJmjz1DilZiM=;
        b=06CmLCLpYaO0AyXRXzO2Z33EaKcpawT0ywcMBtIGlVIwUbXmJqFvzykMy25AbMUeYS
         +JkTufZ5PwAAOD43wE7Yyuh0NqToIroEBqTWqS7e+JrJ7iWYle1AtYaltklOzCJN4QE6
         hP9a0oFkDmal9Ods2j6fkDMvOHCJhNyoLiwv6vFjA9t65FZka9EQamiwDUEDsjaeYF9d
         RW+br+fn2ArKmGzyF8aqujO5F9wlieFtZhHmQlHPM1VEvR4eOdUgNIN+d6zU4QX4zslB
         XOnyfvdUnN0JGdpnYfrTwU9TdViZbtV7jBraN2ntTJcUoRVhUp3zg7nCn6+o4b3rASHY
         yiww==
X-Gm-Message-State: ANoB5plh6Nl9vQ3NAk7ZYShtWE8iwVp4/Ju/h2CDz+r49nAC9wo93hnH
        LgtzRCo7+lr85cEEG3YlGupMsvUiO46fHAxYeg==
X-Google-Smtp-Source: AA0mqf5PA3vm99zqPzb01dtKWQSWYeqNAAF/NwlNGGlh8G6JttPbl6Qbfxh5UhA8yUf25CN5VVMbeqCQq9JwC6+bKUk=
X-Received: by 2002:a05:6808:213:b0:35a:7b62:704 with SMTP id
 l19-20020a056808021300b0035a7b620704mr25659834oie.243.1669728266471; Tue, 29
 Nov 2022 05:24:26 -0800 (PST)
MIME-Version: 1.0
References: <20221104124546.196077-1-ubizjak@gmail.com> <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAMzpN2jY+m5amE-6JB_eYswG2tx1aT6U3EBdYEtc-KdXSHec0A@mail.gmail.com> <Y4XDlWc+2OvmW7kS@zn.tnic>
In-Reply-To: <Y4XDlWc+2OvmW7kS@zn.tnic>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Tue, 29 Nov 2022 08:24:14 -0500
Message-ID: <CAMzpN2iTaZ87OomAQ9cJ51osmXNLFsJTZ9f4RKg6ghLqP4gy5Q@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
To:     Borislav Petkov <bp@alien8.de>
Cc:     Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
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

On Tue, Nov 29, 2022 at 3:32 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Nov 28, 2022 at 10:41:11PM -0500, Brian Gerst wrote:
> > x86-64 uses a PIC register for the medium and large PIC code models,
> > where offsets can be larger than +/- 2GB.
>
> Right but 64-bit is built with -mcmodel=kernel which obviously generates
> rip-relative.

Correct.  He quoted the specific part of the GCC changelog that fixed
the issue for the 32-bit kernel, but it's not applicable to the 64-bit
kernel.  Perhaps the commit message should be more apparent that it's
quoting the GCC changelog verbatim, or better yet, reference the
specific commit or bug number instead of the general release notes.

--
Brian Gerst

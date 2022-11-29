Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1139463C0FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 14:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiK2N04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 08:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiK2N0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 08:26:53 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED86E627CB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:26:52 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 7so17400495ybp.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 05:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BXD8rPwJfbT3obe6yn8DpDXQSQBVojNONuMxydnM5lc=;
        b=f77y6aYLX6S23BUI4abNrh9SusYcRRRP385q5RAJcX+zVk+QMKBbtdOTX927Enfqlb
         EwdjQkAXdTiKy/NBFalEA/WbiVU7ghR9O5k8PZQj0HMP8BhajXgiMMQb5/sGqW6CLzx8
         KRJQKGTxQCRPXqO+ElQuZTdw8KsTCJi6C0Etfy1+yJAioNQs+ru1qspje40YlI4jdsZL
         J7MFVqKtbOc712WESs6cqC99PZMCWmIhxBZi8BqpGX9vvGig3B8M9OcrOBzp5NyGHelx
         YnR/mB4DXfwoue/u+2OciPQwal4f1Gj/rHlOlVkB8xR4dQX+l6KJXVvy82TLF/rFpJE3
         l0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BXD8rPwJfbT3obe6yn8DpDXQSQBVojNONuMxydnM5lc=;
        b=AhaDhzosftaW1tVQSoDg8Z3YhHgR6dE7uzotKzGf0m9jFy4Jcn7qYpwgi4pDT5v7sg
         3VfsXCCVrftCZbHf8e1OSeomLpWMfnsgy/AgXjC/xuYEoI9OWq2vPAopN2MCGbuNe0ZI
         dsEtVAY+YGyOsw9Bam3fxeKU2WMrnOD1uqsZkkfmucajgpjA2equPfrK7jDvqLm/w6lx
         Qwxy1t5CXIZHoSuUGf1hcctyu+xlwM5IKOZE1y2xx/axHJbDx/7GecAU52Ubcr9xIEu+
         BRpdZNtS8HDHp5CcnFflUcDnp9r88htku2Syw6Lt1e8cUk5dAJaZw6UjmVnokecU5O8A
         fjhA==
X-Gm-Message-State: ANoB5pmwkwuo30KqQBLqAz55pTG1IvUZJWKEf/ysx+w7CZjX5b4rEfe9
        X3ZEioitRXTHYiUZk2PjvYxwJfiWSN0fo4rX2tZFjo4MfzU=
X-Google-Smtp-Source: AA0mqf7BVq/20OL+2v+CK3IJPITF2mkt9NbBY7okz3O5vfc2T420onyQ08oZBocX9eqnpDE7VBlgCJpNcDq/9NkUXnA=
X-Received: by 2002:a25:ab73:0:b0:6f3:7b95:353 with SMTP id
 u106-20020a25ab73000000b006f37b950353mr19656791ybi.394.1669728412155; Tue, 29
 Nov 2022 05:26:52 -0800 (PST)
MIME-Version: 1.0
References: <20221104124546.196077-1-ubizjak@gmail.com> <Y4U0GwlLgAuxu3WF@zn.tnic>
 <CAMzpN2jY+m5amE-6JB_eYswG2tx1aT6U3EBdYEtc-KdXSHec0A@mail.gmail.com>
 <Y4XDlWc+2OvmW7kS@zn.tnic> <CAMzpN2iTaZ87OomAQ9cJ51osmXNLFsJTZ9f4RKg6ghLqP4gy5Q@mail.gmail.com>
In-Reply-To: <CAMzpN2iTaZ87OomAQ9cJ51osmXNLFsJTZ9f4RKg6ghLqP4gy5Q@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 29 Nov 2022 14:26:39 +0100
Message-ID: <CAFULd4Yx=GF-5McdP6ZbwYG=12-mHx0-zb3T1QA+DdPVYkrepQ@mail.gmail.com>
Subject: Re: [PATCH] x86/boot: Remove x86_32 PIC using ebx workaround
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
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

On Tue, Nov 29, 2022 at 2:24 PM Brian Gerst <brgerst@gmail.com> wrote:
>
> On Tue, Nov 29, 2022 at 3:32 AM Borislav Petkov <bp@alien8.de> wrote:
> >
> > On Mon, Nov 28, 2022 at 10:41:11PM -0500, Brian Gerst wrote:
> > > x86-64 uses a PIC register for the medium and large PIC code models,
> > > where offsets can be larger than +/- 2GB.
> >
> > Right but 64-bit is built with -mcmodel=kernel which obviously generates
> > rip-relative.
>
> Correct.  He quoted the specific part of the GCC changelog that fixed
> the issue for the 32-bit kernel, but it's not applicable to the 64-bit
> kernel.

It says so right in the summary.

Uros.

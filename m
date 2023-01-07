Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0409660AFF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbjAGAmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjAGAmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:42:37 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 543446AD8A;
        Fri,  6 Jan 2023 16:42:35 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4bf16baa865so42771587b3.13;
        Fri, 06 Jan 2023 16:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tkm822KFA7O70xjFUbGjoKrxdnp/lV7pa30aR+G6h6I=;
        b=o9W/gaM3fn47LOd7POMDZ8i9vl9f/OHcWzd7hBhPC0kLKq/s43yB/eN6TAGru9C4d1
         rUIU+Z+yCDI3L5ZXqRwJz0F6t98I+CEigg33clqSsu5vjSYCaG2516RqOPDslVN7Mr1k
         FQ+eTK9WRZBmYeCJmKKud2JOLA6BTNcG6aehDGF7EzUmy+HVW2bdwliVsDm0zMQQB5qz
         erqWjACw11azY4gNrN9djQfA+SJ5ZHU7r9LtT1TtG7NWfXjYS4tDsrPCAlW3DU/Eq+D+
         C36+Aw0wV4RH+icLmdNqRg2Im2alMtBwRvOVOIM7aY/L7Isf9WJ4f/HtYgFozSlQ+mje
         lcyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tkm822KFA7O70xjFUbGjoKrxdnp/lV7pa30aR+G6h6I=;
        b=TXX0O2/1lUCfKSVgQus6ScCn5GcZAHvf5haubQZOM0udE+qDR5q4q/9kZYLUOvZRhQ
         Ej8t3uhlL9iFmIIp6LfHwr6VPb4hPVi359CaF1WhiLugpRcmevhrNj4wKEGC1yh//Yfk
         lzDanmsP3iewu5DEXvGTIoRc/j+a4SHVMqU9FqzK2bgCdDPDdU2A2olpOQxN6vLe9bQU
         St/AM2+rfeqJ7qXLfgYfG4el7iYHFdsQLRnWSMxUxkl61KxHcqZwBIC4H9T+X7hopn6s
         o0tmzRIRLdTZytbCTkyrmb1A6IMy0AiE+ok7H1lzxrBopAZvKbNlRCMlpkMJviB1AuP7
         dm0g==
X-Gm-Message-State: AFqh2kpZ0j3aCHDJPCjDotwb5P35xIWAfTFpbfwHyIdE2yqQIT8nHrBB
        6RjKdwHqz/QZM90U8mm6Mrc6fenR3KltaL/cm4w=
X-Google-Smtp-Source: AMrXdXuRmVixv/9TM2vRgBkRFrqbpcZA4QypjP56433k+YSkWJljZtLiG6XZHpJg90uoSrb8bxQ20YmcdXFVROE8/n4=
X-Received: by 2002:a81:94d:0:b0:3bc:7270:cb70 with SMTP id
 74-20020a81094d000000b003bc7270cb70mr6962053ywj.83.1673052154532; Fri, 06 Jan
 2023 16:42:34 -0800 (PST)
MIME-Version: 1.0
References: <202212272003.rgQDX8DQ-lkp@intel.com> <Y6r4mXz5NS0+HVXo@zn.tnic> <Y6r+UbfkXruwHU2v@zn.tnic>
In-Reply-To: <Y6r+UbfkXruwHU2v@zn.tnic>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 7 Jan 2023 01:42:23 +0100
Message-ID: <CANiq72kqfva8ZcLSLbq7=yGdVUHra=eh3etUo5vh1rGbM+eZug@mail.gmail.com>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
To:     Borislav Petkov <bp@alien8.de>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        oe-kbuild-all@lists.linux.dev, rust-for-linux@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
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

On Tue, Dec 27, 2022 at 3:16 PM Borislav Petkov <bp@alien8.de> wrote:
>
> Resending because rust ML doesn't like big messages:
>
> Rust folks, you can check out the whole thing here:
>
> https://lore.kernel.org/all/202212272003.rgQDX8DQ-lkp@intel.com/
>
> (and maybe raise the limit on that ML of yours :))

Thanks for the resend, by the way! Yeah, we had trouble with the limit
for the big initial patches too... I can ask the vger admins if they
are willing to raise it given we get these reports now.

Cheers,
Miguel

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3E662B9E7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 11:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233507AbiKPKrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 05:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiKPKrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 05:47:05 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11B845A01
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:34:57 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id p8-20020a056830130800b0066bb73cf3bcso10131222otq.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UvHDrdWNJq6p+2GYaU9sc6HRRjXg7yWYn54epDm0dHI=;
        b=jknnzhc7h4x3wJA9jBdy+65pzdGdPdyylHFCtOvxW3Pw3KIbBsGz4fzgSZKDPXIVT1
         6a9ICbrfUODfviJcHgaGZMccDge6RvyanNLFQA9uCgSuKDQphcEvySdWLLi0YEwp+u0j
         G6qOGHBnddoo3cKZUIERPjc+tTuafkkcU85wvS23YhoZHjkw1pLJJRgvrP/O3EnlhABj
         Po/1o37x1riM7S3DbmQ8FG7LBL1BhD8sYhKwL84s9kX5vVVbDkOczE98D4JvkfsXUVi7
         H+e2g4jCLHMMpTD1hscvLtVJezH30OGiZRNecLgQwvmSfhxEbWvfYVkvGBGDhTIXnuGU
         n6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvHDrdWNJq6p+2GYaU9sc6HRRjXg7yWYn54epDm0dHI=;
        b=dR4hoTZMfzUktMnUdR4xkrVG6fahXg5hDvNrUBfYQc0Q5oSNgxTJC+WxtsYgJ4RZEf
         RuMgu/hSxoKxYMHNOupOLtqsJG6dWjbPifcdYI41j4HA4U7SJAVYwNRKpS9zSP1MFnQ8
         rQ8dW4QcxcimMh0oOt3AC4GKcYUv86ILKc/dL2GxETc0Va5ByN+lkqh2jagFrM6hQjr+
         8+ODFispZLJWTWbh/UQ8FFFs+XSsDDyruIcvJE5Svs+Q+AJGKhBa/mdRbHuURkhFHl/g
         cwQVEzJuG8hDC31BuyT01ERpuIAQg2+GkqsB7zUVnzLI0R3xVwK7LccrfkMCuAG5kBWj
         e4YQ==
X-Gm-Message-State: ANoB5plNfmtpJEpmRXh8WcawCJKsP6IEksyolfRH3TmXqEM7aThCtv8P
        RJXWHbJtaHVxU6p1QpiUOCvJxw0gEqONaKhXKIjtlQ==
X-Google-Smtp-Source: AA0mqf5uFDJIvoKh6oYwXem2Bw2v5rzobdymFcZkJUXvQ91kXntl6fLIfQ3vmWssZKwMpNvuUR9ZNcYbLbUc+9rEpA0=
X-Received: by 2002:a9d:3e4:0:b0:662:2458:3ef7 with SMTP id
 f91-20020a9d03e4000000b0066224583ef7mr10654090otf.150.1668594896741; Wed, 16
 Nov 2022 02:34:56 -0800 (PST)
MIME-Version: 1.0
References: <20221111044207.1478350-1-apatel@ventanamicro.com>
 <20221111044207.1478350-5-apatel@ventanamicro.com> <Y3EDuaW0zQSSfiQ/@spud>
 <CAK9=C2WDQCnVnxKR6SFspdwope2KffyASLJDF_Ygo_417ekJ5w@mail.gmail.com>
 <Y3QT5Vy3RnIXobHz@spud> <3037b4f9-268d-df03-380c-393a5d01f3ba@linaro.org>
In-Reply-To: <3037b4f9-268d-df03-380c-393a5d01f3ba@linaro.org>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Wed, 16 Nov 2022 16:04:45 +0530
Message-ID: <CAK9=C2UpiM=UC27Bgm+QqSc=27g__QLL3y-wMVJGjO-N-XKThw@mail.gmail.com>
Subject: Re: [PATCH 4/9] dt-bindings: Add RISC-V incoming MSI controller bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 2:30 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 15/11/2022 23:34, Conor Dooley wrote:
> > On Mon, Nov 14, 2022 at 05:59:00PM +0530, Anup Patel wrote:
> >> On Sun, Nov 13, 2022 at 8:18 PM Conor Dooley <conor@kernel.org> wrote:
> >
> >>> Also, the file name says "riscv,imsic", the description says "IMSIC" but
> >>> you've used "imsics" in the compatible. Is this a typo, or a plural?
> >>
> >> Yes, the file name should be consistent. I will update the file name.
> >
> > Is there a reason why the compatible is plural when all of the other
> > mentions etc do not have an "s"? It really did look like a typo to me.
> >
> > It's the "incoming MSI controller", so I am unsure as to where the "s"
> > actually even comes from. Why not just use "riscv,imsic"?
>
> Yep, should be rather consistent with all others, and IMSIC stands for
> Integrated Circuit?

This is intentionally plural because even though we have one
IMSIC per-CPU, Linux (and various OSes) expect one DT node
as MSI controller targeting all CPUs.

The plural compatible string "riscv,imsics" was chosen based
on consensus on RISC-V AIA Task Group meetings.

Regards,
Anup

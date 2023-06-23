Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C841A73B9A0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjFWOO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjFWOOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:14:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FF92137;
        Fri, 23 Jun 2023 07:14:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42EE161A3D;
        Fri, 23 Jun 2023 14:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0C69C433CB;
        Fri, 23 Jun 2023 14:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687529682;
        bh=Ntwqh09qmutd77sQNlmVOHd5bIfNAdcpB+jwd7Dvzlw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cIWGE/xYx6FhuOWo1rWD5adSy5SGN4jxMtKWmwu0imvbFbt3flRSYUdFL46YF5J7G
         LkMJeQI06jlBE8PdeGrIXhr/g+grnRs7bKXXuc52XiTjI2BgUNTUpqtTlkjwHnFXVH
         BMdaXs4E50oGmRWqwX+3euLV+3F4GwAa8+zkLVlTaV0BQ+0kyTZNfdGOQN5UXCgffu
         zs4OdZqA/PY8KgSsI5MhZCfOQlo5Z4Hr04/f/dEND3djtJ8BCW7U87dEXll9Kkmd0o
         fitS2ZiST0DHakHKjTxvg9xJjVDSQ6c4qE9Wo0TQ60nB5dNkgIYgtAnosQ4WNB5Mts
         9kv6kIxfcEa/Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b45e6e1b73so11950881fa.0;
        Fri, 23 Jun 2023 07:14:42 -0700 (PDT)
X-Gm-Message-State: AC+VfDzwgBIlqGlfL8kJAFu+hJ6gSqloM6lFHgwjgS2Z1mWvN/BWU09e
        8HeZIVQWI3g61XTkMmBo1k/F4LFccHgTqVHcEnk=
X-Google-Smtp-Source: ACHHUZ6j121/uUmv9VZ02vStSifRCtqhkFuWl4bjIhDNZ4UprfeA0HkFrvWSABiPLW1nzksW5LkbbQkrhi9/Kv7Py1Y=
X-Received: by 2002:a19:431e:0:b0:4f8:6dfd:faa0 with SMTP id
 q30-20020a19431e000000b004f86dfdfaa0mr9759749lfa.2.1687529680638; Fri, 23 Jun
 2023 07:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230621072234.9900-1-alexghiti@rivosinc.com> <mhng-8d50653b-2461-4020-be8c-be0b9afc6cfc@palmer-ri-x1c9a>
In-Reply-To: <mhng-8d50653b-2461-4020-be8c-be0b9afc6cfc@palmer-ri-x1c9a>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 23 Jun 2023 16:14:29 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFtJes-m78infhP9VDrHc9r=kFvLTsZ+NP5chxQwu5xqQ@mail.gmail.com>
Message-ID: <CAMj1kXFtJes-m78infhP9VDrHc9r=kFvLTsZ+NP5chxQwu5xqQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Documentation: arm: Add bootargs to the table of
 added DT parameters
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     alexghiti@rivosinc.com, corbet@lwn.net,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, Conor Dooley <conor.dooley@microchip.com>,
        sunilvl@ventanamicro.com, songshuaishuai@tinylab.org,
        linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023 at 16:39, Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Wed, 21 Jun 2023 00:22:32 PDT (-0700), alexghiti@rivosinc.com wrote:
> > The bootargs node is also added by the EFI stub in the function
> > update_fdt(), so add it to the table.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  Documentation/arm/uefi.rst | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/arm/uefi.rst b/Documentation/arm/uefi.rst
> > index baebe688a006..2b7ad9bd7cd2 100644
> > --- a/Documentation/arm/uefi.rst
> > +++ b/Documentation/arm/uefi.rst
> > @@ -50,7 +50,7 @@ The stub populates the FDT /chosen node with (and the kernel scans for) the
> >  following parameters:
> >
> >  ==========================  ======   ===========================================
> > -Name                        Size     Description
> > +Name                        Type     Description
> >  ==========================  ======   ===========================================
> >  linux,uefi-system-table     64-bit   Physical address of the UEFI System Table.
> >
> > @@ -67,4 +67,6 @@ linux,uefi-mmap-desc-ver    32-bit   Version of the mmap descriptor format.
> >
> >  kaslr-seed                  64-bit   Entropy used to randomize the kernel image
> >                                       base address location.
> > +
> > +bootargs                    String   Kernel command line
> >  ==========================  ======   ===========================================
>
> +Ard, who looks like he's the last one who touched this.
>
> I'm OK picking this up along with the RISC-V doc patches, but I don't
> know the Arm bits.

No objections from me.

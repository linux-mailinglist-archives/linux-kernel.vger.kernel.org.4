Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49FCD74AD7F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:05:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbjGGJF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGGJFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:05:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79AFE1FEB;
        Fri,  7 Jul 2023 02:05:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1423A618DE;
        Fri,  7 Jul 2023 09:05:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679E0C433A9;
        Fri,  7 Jul 2023 09:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688720751;
        bh=H0Yt/QPOuhegMlQh9ZqHcbAamA4k9i0Srfd9+tbm1G8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=W3+6rzO3gycmSMa5K3TChyvfuaC0n5xFNnj7DjdoU9ViG/22ZL+Yojxuas4bgKP6o
         EPkcSm9//+O9jQHZdgvkwiBEag1ETGerQMB7WJCfzi/42ew5+bGtIepCE3F/a3xkD+
         Fhptx1VxTbkuhn6LnydTeJ9pO6cZcwu8lqMj1EQDP+frOa2xZojMIG3hyXf9IQf9mH
         dltH53R2Ne3DdtQa3tPlkCjDNPzIlKLbqI7P8AXTyQAmmRDXVurSmw6myBRn1YRSyV
         +Ro4DLLY4uNM/Cxv6ZgH0hVKwTTr0Lba6LfAEHY1Aat8HjCZrFQaTB09uB0dVoJGhO
         zJ5hwYEwQeJvw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-977e0fbd742so203205966b.2;
        Fri, 07 Jul 2023 02:05:51 -0700 (PDT)
X-Gm-Message-State: ABy/qLbtSEdTBDYa/JRMHJAWxTEk+aKhBOQMj95Q/7TfNp7Kr/LR/T02
        mCYjGydmjjA7UPASCyw4/1gfkcgKF/gztrmruXI=
X-Google-Smtp-Source: APBJJlEuZouujhN2y56xMmNiKy4pjpvqYoqlZXspGPUXtBJ0MuTM6vGwzHWe40UkOunICEVcugS+h9ary17Ji1pDclo=
X-Received: by 2002:a17:906:224d:b0:982:84c9:96c4 with SMTP id
 13-20020a170906224d00b0098284c996c4mr3557280ejr.10.1688720749510; Fri, 07 Jul
 2023 02:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230702095735.860-1-cuiyunhui@bytedance.com> <20230703-71f67eb66a037f5c0fb825c6@orel>
 <CAEEQ3w=7tBHyG=CvuktPN5cvfpY6ayamnbry6eOYxMDrPN+oZg@mail.gmail.com>
 <CANBLGcwcvK55dZ1__wvWCtcw=XoKt=qki8g6C_QYo+TBqqJ=TA@mail.gmail.com>
 <50F3BD62-78F1-456E-A44A-0C7D9A2D4113@jrtc27.com> <87bkgql8rq.fsf@all.your.base.are.belong.to.us>
 <CAEEQ3wnaaMvJ3=7udvAjiP3q36nvqAwb8sh34f+nO8Ua_83yFw@mail.gmail.com>
 <87sfa1toap.fsf@all.your.base.are.belong.to.us> <CAP6exY+gTSxU95nDK14z-Y1suKeXPkLzZ_BZqr-vRVGO9qmcxg@mail.gmail.com>
In-Reply-To: <CAP6exY+gTSxU95nDK14z-Y1suKeXPkLzZ_BZqr-vRVGO9qmcxg@mail.gmail.com>
From:   =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Date:   Fri, 7 Jul 2023 11:05:37 +0200
X-Gmail-Original-Message-ID: <CAJ+HfNjgS0XHzG5G_cCsyO-TKRA4Q=KFkwxMZ2httiRGRyuc+w@mail.gmail.com>
Message-ID: <CAJ+HfNjgS0XHzG5G_cCsyO-TKRA4Q=KFkwxMZ2httiRGRyuc+w@mail.gmail.com>
Subject: Re: [External] [PATCH v2 1/3] riscv: obtain ACPI RSDP from FFI.
To:     ron minnich <rminnich@gmail.com>
Cc:     =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Emil Renner Berthing <emil.renner.berthing@gmail.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, jdelvare@suse.com,
        yc.hung@mediatek.com, angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org, geshijian@bytedance.com,
        weidong.wd@bytedance.com, graf@amazon.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ron,

On Thu, 6 Jul 2023 at 18:37, ron minnich <rminnich@gmail.com> wrote:

> I'm trying hard not to get sucked into this argument, but it is, at
> least, impolite, to accuse us of engaging in hand-wavery. There's
> probably more UEFI expertise in coreboot and oreboot than most
> places, and that's precisely why we want a non-UEFI
> option. Familiarity with UEFI did not breed respect.

If my reply was interpreted as rude, please accept my apologies. That
was not my intention.

> So can we get back to the business at hand? bytedance may be the
> company proposing this change, but they are certainly not the only
> company interested in seeing it happen. A project I'm involved in
> needs this work to go through.

I noted that the discussion continued from Ard's reply (which, no
surprise, resonates with my worldview :-)):
https://lore.kernel.org/linux-riscv/CAMj1kXFZren0Q19DimwQaETCLz64D4bZQC5B2N=
=3Di3SAWHygkTQ@mail.gmail.com/
Let's continue there.


Bj=C3=B6rn

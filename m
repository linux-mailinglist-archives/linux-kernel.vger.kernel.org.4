Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79CF7168FD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 18:15:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjE3QP2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 12:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbjE3QPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 12:15:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324D91B5
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:14:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71BDC6272E
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420BC433EF
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685463287;
        bh=Nw3U0ieXrITWif7BtfrdVhn0c6Tx1Kfx8ZbO3YPKFgY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P64THRMXqnP91VjfreERAMPu8he0s72QpMBcQNOwp3QtrAh9Swsp2LdA6zPKmhDIt
         X4LIe+6osBn1kN2tE+37UYQSG8QWdCcPrgFiSy7PkRQaR96bScw4yniiuJrA2wFuF/
         84ee96M4f92CIZGvI26wEhj++6o6ZMp32WbDC4Q9aI0pQmGVrjOVRhusuttoXRZCvN
         rcMwosYOh4KfTsGLDhNzfbhzi5emVdGclD/KMaSUdO2Bn9a0Bh+iTxuvj+3fr0Akja
         ioZd3H5pe3TMMcC8zzCSYiY4vDLotT+hv6rhRg/YBDnke8f+7JvnTDnE0Un2EsHMad
         LNYEGbh6Az2ZA==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51458e3af68so8071338a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 09:14:47 -0700 (PDT)
X-Gm-Message-State: AC+VfDxVHvx60WkKcMHPClAX2xGEtArIo/Y+F9eAfGd/yw+s4uc1nxiC
        8OiM8j2eTnbn/O6TTwa0F3keM3UHS4ipR/UsS0Q=
X-Google-Smtp-Source: ACHHUZ6OhDUvQebUTZpaJ3DceGZodA10IPc1+6QNRR0Yreq3kn60R67Dyn/3cUSFn3edT8OykgcBKVDphNPmd2aDI38=
X-Received: by 2002:aa7:d58d:0:b0:514:9df0:e3f3 with SMTP id
 r13-20020aa7d58d000000b005149df0e3f3mr2273778edq.0.1685463286138; Tue, 30 May
 2023 09:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230529073845.2859178-1-guoren@kernel.org> <20230529-jasmine-amigo-6d01f6852b35@wendy>
 <CAJF2gTRSoZbexqka=_7nf4+dHZW2FGf++BiTMypfTbeoGAbUiA@mail.gmail.com>
 <CAJF2gTTzUfp7xDr8myA+xMcxGNEQ+XLEYMfoR91NShdBAQMu7Q@mail.gmail.com>
 <CABgGipXu7iq-J5v6GVMPrnHiGVLuMxabB0_hPb+o+04T2MAwpw@mail.gmail.com>
 <CAJF2gTR2fAkk1532VWmsWP5DSYN17ib80wa5QwwT=DC0LY9gGw@mail.gmail.com> <20230530-static-smith-96cf543bfda2@spud>
In-Reply-To: <20230530-static-smith-96cf543bfda2@spud>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 31 May 2023 00:14:34 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTD-Qbp1bJ2EZgpBTzRrWtUEy7k644GzYES2qRWY3D3LQ@mail.gmail.com>
Message-ID: <CAJF2gTTD-Qbp1bJ2EZgpBTzRrWtUEy7k644GzYES2qRWY3D3LQ@mail.gmail.com>
Subject: Re: [PATCH] riscv: vector: Fixup modules compile error
To:     Conor Dooley <conor@kernel.org>
Cc:     Andy Chiu <andy.chiu@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        greentime.hu@sifive.com, vincent.chen@sifive.com,
        paul.walmsley@sifive.com, palmer@rivosinc.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:04=E2=80=AFAM Conor Dooley <conor@kernel.org> wr=
ote:
>
> On Tue, May 30, 2023 at 11:37:38PM +0800, Guo Ren wrote:
> > I just found Linux-next build is broken, so I sent the patch. It seems
> > you've solved that. That's okay.
>
> Are you sure that linux-next is broken because of this?
> This series should not be in linux-next...
I mean:

https://git.kernel.org/pub/scm/linux/kernel/git/palmer/linux.git/log/?h=3Df=
or-next



--=20
Best Regards
 Guo Ren

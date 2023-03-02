Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242126A8AEA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 22:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCBVDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 16:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjCBVDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 16:03:10 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9160125AD;
        Thu,  2 Mar 2023 13:03:05 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5384ff97993so5765977b3.2;
        Thu, 02 Mar 2023 13:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677790985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0e+M8lR2JG6NpLCRd1WCTH13OlQ8KKo1FJyWNWAWvw=;
        b=c6nm5fiXqllQvs36BosfqFB+6xsA9Z1k9PhyAFM9pKI+dBF7CmRo+bIwneA/0V8Sab
         CtmcVNohRYP5SITznCvI3kDP8p/Ix0DRsij7K+ArOJAtJ4an1PYGWEyqAAdZd35ryq24
         it9dzO8vYCUWKfeJ4Q4gFVPB4FB0wLxrqCmbUkmIDv20iijZKPUqWaHa3L3Hd372AT4l
         NzGD5nYbYKSw3ct5Ny/YWNIkKazmvoo21yypwwlaUYqPSAc+IhExDRvUFrAVOvaZlIdZ
         CNLrwHfBBAKi+VyhfDMalJuIQozgPIznWm1RACUCIi7CKSokFJseeJnpTli9cmPB37qB
         rCuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677790985;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0e+M8lR2JG6NpLCRd1WCTH13OlQ8KKo1FJyWNWAWvw=;
        b=44cFnVminRddFYNFEMz6ZgecfNvZM3JtJWQ9OphiBRD2oGqs9ts48bcDqbcLR5TSup
         daj4mFSZRqevtZVmO7pq4mJpziFi5e295cisfxNILTIdSmzbYKNzr+8X94ll4LhQboMD
         979szFA/fh7cmSazOqdaEXzAS2TqIN0WPBk/K5MC5PJm2I0LOavyOCIW1FJkGKHetv/c
         JRQvL4xHXagFK2j3O8ekSZBeY6AcLWNZ+BGac3N4ex1AgwL9q0Ej1fhK0Z43/LDbiwlt
         4rC9t5VtvMG3I9CA2nXXEqBebefVODtvfIWeAs66itoGLCq0aUT2VoRwV4NHwKrKfX+J
         8eUw==
X-Gm-Message-State: AO0yUKXXIWue/FTf4fT9LEBDkF4bb3CImSFw+bP0e/QWYBfD+zGoZ9hW
        mXo5StTTAmeYKcfEbNbvLhEplpPM87bZo+GPgg8=
X-Google-Smtp-Source: AK7set+UOO2x/FUKlfMt2Kcf7BBasRfyJxFZZYrhv3uDPWWLAYeML2RAIE7qu6JGPaGuplzMzbkqfXSVZXv8L9DaTqQ=
X-Received: by 2002:a81:b664:0:b0:52e:cea7:f6e3 with SMTP id
 h36-20020a81b664000000b0052ecea7f6e3mr7061692ywk.10.1677790985226; Thu, 02
 Mar 2023 13:03:05 -0800 (PST)
MIME-Version: 1.0
References: <ZACvxNOuuyifQ9Nx@kernel.org> <37578649-c696-f3b5-a216-196e210929e5@gmail.com>
In-Reply-To: <37578649-c696-f3b5-a216-196e210929e5@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 2 Mar 2023 22:02:54 +0100
Message-ID: <CANiq72=nvg3cU61zRYXxLUKvEib1qezRHGZSC=7sGah8aDH-dw@mail.gmail.com>
Subject: Re: [PATCH 1/1] rust: bindgen: Add `alt_instr` as opaque type
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Derek Barbosa <debarbos@redhat.com>,
        rust-for-linux@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 3:59=E2=80=AFPM Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> Still, we have to be careful if these kind of things appear in
> the future.

Not entirely sure what you mean -- do you mean if some Rust
abstractions used its fields? But if we were in that case, it would
not compile, so we would notice. Or what do you mean?

> And I notice that You haven't mentioned the version of Bindgen that
> You've used, including its linked libclang too. Otherwise I think this
> could be accepted.

I could reproduce this with the expected versions. Since, for now,
those are the only ones supported and the build system emits a warning
otherwise, I think it is fair to assume those versions were used
unless otherwise stated.

Cheers,
Miguel

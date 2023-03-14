Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0A2A6B88A7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 03:32:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjCNCcN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 22:32:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjCNCcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 22:32:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B4E76A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:31:56 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o38-20020a05600c512600b003e8320d1c11so43115wms.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 19:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678761114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVqrjJWKOJQpkjTANLPn8KQRzXiGXdLEFXoUa71hdA4=;
        b=pIx7QXAeRYGylvtHvk268YuD6xQ4GbxbNnaVpVucVenWXKPtYDu82tGM2DujabgovF
         XfiLXtMM6s4XveDO/+gICNZSbrAaNaRrdRO4tD9zxnKX9w0RbRBUKTrL/WJ5wI1MG0Mx
         pH+g6fKRO+cxiC1T3qI9f1PLJSGzDNrxUZir44V/97zUVaUbv5Rru47xqpU7XT4DISyn
         Z0h9FO46jI5K0NU+Jp6+Iz5SlBXUud7zTauZjQMUxgGYLYeXenAiEsPBoPXQ5t3t/zDX
         RN/qy2zweMyhBiTgEKmutED9xzucwy9ZxNuQPDwYsZAgvd/X5nSp9uzB2iKpM4i6JvXy
         de3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678761114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UVqrjJWKOJQpkjTANLPn8KQRzXiGXdLEFXoUa71hdA4=;
        b=VeozVrlmIIZr7U6i/0jeS1+84D363ZosVND7QPLZytwlZrtBSxxHqtDIhqSowNudAk
         GMU6jeHxvYsmR0D7+ajslec7Ji6zpX99xMM+UQ0QNOhUN4FCNvz8pFcV5kvaMdPGaAAf
         RVX68ArAt3HLnhOPz4m0DUVnnG59hnuXIlP3aHajA9M6aqtaOgrQdYuYNmRfO3LX6VjP
         TB2RHKAKVoiduEvvHbh+dpbrAe8Vq47E3uVD+el+C5OryePu8hPH23SvtnCFVk8JmVrZ
         FzYqga8J8v1pWy2raWH41UiHmAimY3OIHD/HMVL1L2dkGYEk2tnUNutPwAMM84HtrN9h
         VjRg==
X-Gm-Message-State: AO0yUKVAxrsz4RiFa/rGdNrXsX8B+URzKKooKijGKgOQPboAx17VYVqD
        GMe/sBV0vxfWhDpHzjC1rpvN9EXigswRIze3IamP+yekukk=
X-Google-Smtp-Source: AK7set8xu47/c2Rg6xNYsHfXvmcgUFSPZa2PugbE3L6OSDRGqiuynXNptP5n2Lk0hvimsLWexHiN27dFNJIgdPxZfII=
X-Received: by 2002:a05:600c:3b03:b0:3eb:4cbe:1e87 with SMTP id
 m3-20020a05600c3b0300b003eb4cbe1e87mr405320wms.3.1678761114192; Mon, 13 Mar
 2023 19:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
In-Reply-To: <CAJNi4rNSHf3N6KrBNcVXKo-wjSPmZa2xan9WPmrER8Ttir-MDA@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Tue, 14 Mar 2023 10:31:42 +0800
Message-ID: <CAJNi4rO6TiZFFKTcW3kGgha2Rc0nTsXRLyeqAyYrN3foLbExSQ@mail.gmail.com>
Subject: Re: Question about select and poll system call
To:     linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding linux-arm-kernel@lists.infradead.org ... for more possible feedback:=
)

On Tue, Mar 14, 2023 at 10:28=E2=80=AFAM richard clark
<richard.xnu.clark@gmail.com> wrote:
>
> Hi, (Sorry, not find the maintainers for this subsystem, so to the lkml)
>
> There're two questions about these system calls:
> 1. According to https://pubs.opengroup.org/onlinepubs/7908799/xsh/select.=
html:
> ERRORS
> [EINVAL]
>       The nfds argument is less than 0 or greater than FD_SETSIZE.
> But the current implementation in Linux like:
>        if (nfds > FD_SETSIZE)
>                nfds =3D FD_SETSIZE
> What's the rationale behind this?
>
> 2. Can we unify the two different system calls? For example, using
> poll(...) to implement the frontend select call(...), is there
> something I'm missing for current implementation? The Cons and Pros,
> etc
>
> Thanks,

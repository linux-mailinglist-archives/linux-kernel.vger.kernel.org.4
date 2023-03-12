Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE56B64F7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 11:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCLKij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 06:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCLKig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 06:38:36 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347742387A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:38:35 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id j19-20020a05600c191300b003eb3e1eb0caso9001722wmq.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678617513;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnXUvgY/lQbEIAhlEWITjQxBBwr5ulB+Ngn573yt/HI=;
        b=K++Sac4QXPb78WLLWM02GJThSsUv3qZfeOODf7zH2AwS8i+TW91re2iyfOp4znFqDY
         TMEl/CMOR7T2VBIorTE3Xek4DUJTXGc7BjiRMhyjzDYJGtR7WiAFr9KeZQAhqKvzw0+O
         XR7t72kD2BUjBfkXY+23K89GdgTeejTKGFXZ53eY1CHCq9smOQ5p/GnuvrQWqtdkB0U3
         XfOrilDJxT25DU71vQAGXZLOpr3TI1J9WWz+840jqH2M1k9QHf5jddOexbBqPyScmBK4
         msOJUElVhOnaM1UNc6NKJX6etPi5h6KOTUfap7ygMt/Xrk88z4nYWjrrhAiO3d1Drs9H
         X8qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678617513;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CnXUvgY/lQbEIAhlEWITjQxBBwr5ulB+Ngn573yt/HI=;
        b=0FdTnxgKzs/6wRFQGC7tZJGLRSFJxSGh3/in5mY1tjTXSH9iKyvxCklovVX8PG1rBn
         bfqLO/gZRXmKCbtWpLjBn0FclrO7C9EDSY7+8JKMjFt2o/LlzQ9ivNUb+TKY750ePElg
         r9s55dz2UKyYX8Y3lCcRooaR5INjMBXMX0IjPBsnRqbm9sNbSKv+/POK61Rbir5zNMTW
         dwm1hji3QDjnmBGfuxNmJhWGga9jFuyK3qMJKcOXDlWr+XA4ul2LAv0MEfGNbrAB0gOR
         wVMT5tb3I5RXuFbIdiQsrdfKDVRRdxQeRvgk+lTC3CrNNB3blxc8+2ALTiNuj8+Ygw/I
         8Lew==
X-Gm-Message-State: AO0yUKV3Fgh3nGW61Oc5IiLH4tpN35/1TkhCzanXBryhsNHEFS7UK018
        a6j+XvhH/iQ9rTnLgvbyMJc=
X-Google-Smtp-Source: AK7set8k890tWSm3x1zwHHcZ1fsnkgG8rK7caIZ4MvxJ1EDFfxtQOcnNYywc1mPxSE+XJ778iw+qJg==
X-Received: by 2002:a05:600c:314c:b0:3eb:2f06:c989 with SMTP id h12-20020a05600c314c00b003eb2f06c989mr7758660wmo.22.1678617513487;
        Sun, 12 Mar 2023 03:38:33 -0700 (PDT)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id f18-20020a7bcc12000000b003dc47d458cdsm5650478wmh.15.2023.03.12.03.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 03:38:33 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 12 Mar 2023 11:38:31 +0100
Message-Id: <CR4C8V5T7751.HT9WYT9LB7X1@vincent-arch>
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Ivan Orlov" <ivan.orlov0322@gmail.com>,
        "David Kahurani" <k.kahurani@gmail.com>
Cc:     <lucho@ionkov.net>, <ericvh@gmail.com>, <asmadeus@codewreck.org>,
        <linux_oss@crudebyte.com>, <linux-kernel@vger.kernel.org>,
        <syzbot+cb1d16facb3cc90de5fb@syzkaller.appspotmail.com>,
        <v9fs-developer@lists.sourceforge.net>,
        <linux-kernel-mentees@lists.linuxfoundation.org>
Subject: Re: [PATCH] 9P FS: Fix wild-memory-access write in v9fs_get_acl
X-Mailer: aerc 0.14.0
References: <20230310202619.433269-1-ivan.orlov0322@gmail.com>
 <CAAZOf24yhpSBd1926v7T=qDwqvFfLsWMJeMKTafeZ=69hJ4rdw@mail.gmail.com>
 <d5bb5ff0-1102-c7cd-c21b-c3a7f4f31717@gmail.com>
In-Reply-To: <d5bb5ff0-1102-c7cd-c21b-c3a7f4f31717@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Mar 11, 2023 at 6:35 PM CET, Ivan Orlov wrote:
>
> > I'm not sure what are the rules around here but I prefer to use bracket=
s=20
> > more generously.
>
> I think in this particular case they can just make the code less=20
> readable (considering they will not change the behavior in any way).=20
> However, this is eternal discussion and I saw examples of both in the=20
> kernel sources.
Maybe this can be a good reading [1], I think it is more a kernel rule?

[1] https://www.kernel.org/doc/html/latest/process/coding-style.html

Cheers

Vincent.

> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees


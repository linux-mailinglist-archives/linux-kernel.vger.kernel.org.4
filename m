Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8832B633B93
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 12:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbiKVLkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 06:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbiKVLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 06:39:40 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B8A5B5AF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:35:12 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id fz10so9053347qtb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 03:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yjcaEIU8aaszVdE2YJFXT5V87395aETVGSUxQ01ZdKA=;
        b=iGmNWndvUeaZGjqbr+ZMN0HCB7sowPojucwRe5nzbbkZjp2gkNI6GeOVVqdl2+XZQu
         bpgxuU1nTZ+O/CQ2xwq8g+ZxYDAQTkn/bo8sLC2gULM3gFHhr0+fiExG/57/5Qe1TMYB
         7UFKRmZtL2OUxyZwQsgRJXmqnh9vCK2Wf0CW89C6rk/1qgaCBGFQsW8MhGAAEnYpos69
         OIv9qlMf9r7uG1dMjFfHr/N9yL3AbZsq+A1QqLlW9QPFlUQudfZXhqPFMC3Fura0H91u
         De98fi3JvpFJ5YcJscDjA80WbQHcm+/ci0rZN3PSQNdQkkdPxkvySXRhgxb4Y4w29+cq
         RI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yjcaEIU8aaszVdE2YJFXT5V87395aETVGSUxQ01ZdKA=;
        b=z5QIJ1xCj2CYsm3MKoKu+C4CJ9VYB+chdTNz3kKdjaQ2L5Su3YOz5wvKCOv356Dl6W
         AVZOVnZjDehEeKNw4ZzsdhzIY2F0b97d5MIAYm7ODFVMlZKfYnB8/4CFWIshnNT0AD17
         8YUjehUn5Lot5a/yKoehpo9Zgsa352nit8CBGRy42RD2Q4CrdbA4VYuZjQDWU7pMW77S
         3rpff8NeGiYCaL/VuMM4L5Ym0/B03XBNYzEEQWyQdRLid9tGcO5XAvUW/22Fd2Frs1jQ
         5Avj+y4SMreNeyqUwUA07YFLdtK/KRaBCBkIbvHyaoYlCd0bgXJ02cswbUFDxhNK3uRK
         r2mQ==
X-Gm-Message-State: ANoB5pntW2SlTJuwEklhK3lGjSYmNGDhDn+g1pQp5Z8bq507KeuHIt6e
        ULIG5a4kXEf7WM3hrP60KzPjBtWvwSuXO+Vo3kv164uWmhIipxKUv60=
X-Google-Smtp-Source: AA0mqf4s/tmixJs7XFTUNXmYEIqSfZaZ+o3bkQmJ0pO+hCd0Zlcrm7DU5ubR77tUpZsMXto5dpdCfITM+2Ajbk4WwAI=
X-Received: by 2002:ac8:480c:0:b0:3a4:f1c1:49a9 with SMTP id
 g12-20020ac8480c000000b003a4f1c149a9mr5452589qtq.464.1669116911696; Tue, 22
 Nov 2022 03:35:11 -0800 (PST)
MIME-Version: 1.0
References: <CABXGCsNFRQ9A1Vx6_qsP7NqedhG7QScOG4-Eupvz3etgykJt=Q@mail.gmail.com>
In-Reply-To: <CABXGCsNFRQ9A1Vx6_qsP7NqedhG7QScOG4-Eupvz3etgykJt=Q@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 22 Nov 2022 16:35:00 +0500
Message-ID: <CABXGCsNvLzTMaYqcTM6Wn+uC__H3S94eiHTDLVqAeQByw3fqPg@mail.gmail.com>
Subject: Re: [regression][6.0] After commit b261509952bc19d1012cf732f853659be6ebc61e
 I see WARNING message at drivers/gpu/drm/drm_modeset_lock.c:276 drm_modeset_drop_locks+0x63/0x70
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Harry Wentland <hwentlan@amd.com>
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

On Thu, Oct 13, 2022 at 6:36 PM Mikhail Gavrilov
<mikhail.v.gavrilov@gmail.com> wrote:
>
> Hi!
> I bisected an issue of the 6.0 kernel which started happening after
> 6.0-rc7 on all my machines.
>
> Backtrace of this issue looks like as:
>
> [ 2807.339439] ------------[ cut here ]------------
> [ 2807.339445] WARNING: CPU: 11 PID: 2061 at
> drivers/gpu/drm/drm_modeset_lock.c:276
> drm_modeset_drop_locks+0x63/0x70
>
> bisect points to this commit: b261509952bc19d1012cf732f853659be6ebc61e.
>
> After reverting this commit the WARNING messages described here disappeared.
>

Hi Harry, Christian says that you can help with it.

Thanks.

-- 
Best Regards,
Mike Gavrilov.

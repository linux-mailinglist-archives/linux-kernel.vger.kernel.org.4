Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E41A613004
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 06:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiJaFzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 01:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJaFze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 01:55:34 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BDAAE6F
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:55:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t62so1092466oib.12
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 22:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPFP4CSpqd5q+2CG4kXtL2WhcO34WGcrI9E3V34tDE0=;
        b=QkEkSdFBR366gLc1s/4kVIIlMFMXpibfSJYkUhzo9LmEbqtpRh6WolWD0DS7XoZh4x
         ei1/oR0ZjKZWJAvkFAKiBgUhqZthSNtL3bMuWX5TFTSWbrSHvzGm5M+5GOggbZCvoLJu
         qK0XVq5ECH6/RJ5mdxw6IBIJasZ+xSass80/c/SpVd+5CNt/7R7HZy6StRsu0oQgoT6Q
         qYPXFdLr5j1nHcXExZPVQtGOzTV7jgC4FjjXNkmYx+Qoo2PLekURT7eW1yUS/Ri6aoyJ
         fFm9ALnI7jJQqmZK/og2iBgLyyg3j477Ts6TY604sK4ZzNZT8x57/qadozmuvX2OVEGB
         OhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fPFP4CSpqd5q+2CG4kXtL2WhcO34WGcrI9E3V34tDE0=;
        b=Jwo21ynZfA3hP4epWRRMMbes8CBUisdA4+IC6+FrLxw4xYUIHOPobDkL7DSwYnmACV
         nGvBV3dj5r4WlNqCAnQ8BsuAHKB06UcrTmc3zFrjomjILYHLuGimD0nZ1Oq7dGp0FyMx
         2I20bdoesLbYZlTih9kQciGJjORxfsoV7ayfrPoaJT8wVJXNNfAUucZaexC3VyuKHVca
         AINwNQtcp5q5uoSnWa7w2kp7TKrOLRgBTvIRRyKzrQoxRbD9Hg/TWq/NgErTJU8iYklL
         r/GVJ43SXVTcYSMR17VmlVD7tY59SKp21NvxBsu/a2IB45Y0zeHnq5LR3U2yF9vEoICe
         nuKQ==
X-Gm-Message-State: ACrzQf10PIVEZvLszmlHV5XfnwZK0eGzADn8iJTDJR3eDmUP/O44F+cq
        90k7zTciPaySTa8yB+TDCx1uJGpg/YUSxZ/YIeezFo1+uMw=
X-Google-Smtp-Source: AMsMyM6M29btsKyOFZnFUyvkWHuy4fArztzlJb0ZiH0Fx3gm396v//Om2xbQh1/e+++3ZfmDObHjVFLYPsiP2g+2sRI=
X-Received: by 2002:a05:6808:6cc:b0:355:24e0:854c with SMTP id
 m12-20020a05680806cc00b0035524e0854cmr14220671oih.167.1667195732019; Sun, 30
 Oct 2022 22:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221030111759.95092-1-wuchi.zero@gmail.com> <728c68cc-fef0-c48d-056b-6ed7352b443a@redhat.com>
In-Reply-To: <728c68cc-fef0-c48d-056b-6ed7352b443a@redhat.com>
From:   chi wu <wuchi.zero@gmail.com>
Date:   Mon, 31 Oct 2022 13:55:20 +0800
Message-ID: <CA+tQmHC73zSUfm1yRypjxXxpbZAoP8Bam0C__hF9Kts1XFh7GA@mail.gmail.com>
Subject: Re: [PATCH] locking/lockdep: Remove unused variable in __lockdep_count*()
To:     Waiman Long <longman@redhat.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
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

Waiman Long <longman@redhat.com> =E4=BA=8E2022=E5=B9=B410=E6=9C=8830=E6=97=
=A5=E5=91=A8=E6=97=A5 23:21=E5=86=99=E9=81=93=EF=BC=9A
>
> There is no target_entry NULL check in __bfs(), so target_entry is
> always expected to point to a valid memory location. You will need to
> add the NULL check if you want to remove it from these two functions.
>
Yes,  add code in __bfs() as follow?

if (match(lock, data)) {
    if (target_entry)
        *target_entry =3D lock;
     return BFS_RMATCH;
}

> BTW, have you actually exercised the code to make sure that there was no
> unexpected side effect from this change?
Yes, the code "check_irq_usage -> __bfs_backwards" is an example and the
primary callers lockdep_stats_show and l_show in lockdep_proc.c work well.

But I'm not sure I missed anything.
>
> Cheers,
> Longman
>
Thank you for reply

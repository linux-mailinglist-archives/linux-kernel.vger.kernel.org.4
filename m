Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6012D5ED5D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 09:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233269AbiI1HU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 03:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbiI1HU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 03:20:56 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423BCB0880
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:20:55 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-3511e80f908so58842547b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 00:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Y46AhQrIvASOUKEE8D2zpd1BuZhfdDfI2hx8Y1P3Sec=;
        b=Uc1GJT0GewnUk9Al7b6KHf0etEtz/CauJyPgQr1HoB5nK+2yswE+QRrVIXgm1HIbPT
         h5cAycnCbiRrmi88CBD9bmlMQvqCQ5ip77HlYO9d5LD+PUVooS3/KA/xhrDf00c+ZXxx
         ZGWobsOyf2y/Dxzir52uHxhbwpyFo7XOfxqKyLp8wUgH6VsKGEXGhPYZoMokVjlMmloe
         pef5QiEZtCNiHO53jHQcTk4+5kUyvXVpUBOPUnl68tfCwfMklgC1M4PzughwI3rYYdCu
         u0u4mQSSYh63L1rwkLYfPSw6i4uBNBa2NIkIP++dxVknxS5Pq64f/xSa1z3pNU8Jbvm3
         NsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Y46AhQrIvASOUKEE8D2zpd1BuZhfdDfI2hx8Y1P3Sec=;
        b=14GjwqfrALEfUg2LhtoyBkyNWnzquEVjlNIiNVTfqjXC3/bGHBTVYX/HSmAEFOZufO
         KP8ixtVj0n1o3wK1TsMgk+kUWfgcUk6n1v5nC0VBLYCpt89cxmOSHgzh9bMUg9zy7s1q
         HA1iwHbRiM5WPOM0E4cbkqoc2ME/XhM1MFXoFToIDQIEDG2WCQFTqo/Hy5hJ5rcQnaKl
         ZamJ+PPxInP/iBOgVokLMtrj92e1iWJwhTS9GhKkMY3+mSZe6R+d48dT36MmOvRjKdWr
         ZHejhaJP6DQbJaIm5CVATeTaHLaMXcRMvs/3/UDtN+I7N3qTlX6Rzu0Hq/R/jMB5R+18
         DjVQ==
X-Gm-Message-State: ACrzQf28Zj8Of3p0erPKoXNJ+z7+aJRUPnaYrYDBEa7n/kPU/RDttbwC
        LhcnNbmEVw/waInNDZAv0Wk0VKB+oSlD/w0df9w=
X-Google-Smtp-Source: AMsMyM5EMFWNIJBgGOdUGAh1DrizY058ajEYtFY+jf2w1s9f/oElkSJ25MYibZ5mc3rdiZryIhh1T39+fGqHc5OzsZE=
X-Received: by 2002:a0d:f905:0:b0:345:3b1b:a00d with SMTP id
 j5-20020a0df905000000b003453b1ba00dmr28932857ywf.510.1664349654305; Wed, 28
 Sep 2022 00:20:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220928064934.70867-1-renzhijie2@huawei.com> <YzPxMvjdjVEK1/b1@linutronix.de>
In-Reply-To: <YzPxMvjdjVEK1/b1@linutronix.de>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 28 Sep 2022 09:20:42 +0200
Message-ID: <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Ren Zhijie <renzhijie2@huawei.com>, akpm@linux-foundation.org,
        ndesaulniers@google.com, nathan@kernel.org, vbabka@suse.cz,
        masahiroy@kernel.org, arnd@arndb.de, seanjc@google.com,
        hannes@cmpxchg.org, ojeda@kernel.org, mhiramat@kernel.org,
        dmitry.torokhov@gmail.com, atomlin@redhat.com, ddiss@suse.de,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
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

On Wed, Sep 28, 2022 at 9:01 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2022-09-28 06:49:34 [+0000], Ren Zhijie wrote:
> > --- a/init/Kconfig
> > +++ b/init/Kconfig
> > @@ -1273,6 +1273,7 @@ endif # NAMESPACES
> >
> >  config CHECKPOINT_RESTORE
> >       bool "Checkpoint/restore support"
> > +     select PROC_FS
>
> Couldn't this become a depends?
>

It could also be a depends (to resolve the warning).

It is just the question whether:

When PROC_FS is not set, should the CHECKPOINT_RESTORE still be
visible as a config option to add (and then automatically add
PROC_FS)? Then select is right here.

or:

When PROC_FS is not set, should the CHECKPOINT_RESTORE not be visible
as a config option to add? Instead the user first needs to add
PROC_FS, then CHECKPOINT_RESTORE becomes visible as an option to add,
and then the user can add it. Then depends would be right.

For me, both seem reasonable. So, I assume Ren considered select the
better choice.

But maybe Ren can confirm.

A kernel build configuration without PROC_FS is quite special
anyway... and then being interested in CHECKPOINT_ RESTORE for such a
system is really really special. I wonder if that user then really
knows what he or she is configuring at that point.


Lukas

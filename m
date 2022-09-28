Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EE45ED894
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 11:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiI1JPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 05:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiI1JOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 05:14:50 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEF111154
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 02:14:40 -0700 (PDT)
Date:   Wed, 28 Sep 2022 11:14:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1664356478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+cXt2GTK5fkGLEpYOvvFvcpEf65u4EfwG1nI5xxG9E=;
        b=M69v6fUIJR8v0SwgS/7riV4UPE7sgnh5DnHLVhwpUQJmGFix2ZNsr2RZpUKR0eG8G42UxJ
        V8v57XB0aWaBXuMhANytMHiKgmCQGXCAcqgcAYXBlJIWPhV8TgmaCjLGo3woCrJjvQZeut
        8azt5J8+wmxb9JUJ2KrhK4Mh14MEzq4T3mhOfF0e+4qhR0Md+OnQN7pIGB+idbWpGuqvyj
        jhg3pr1IgPZbvDuKpNjBTLlIcyfthIRD+fWKiUOmPTqy2Zw4OUNG0nb7vRHUsUm0RPyjC3
        oHFoe01/NdgWyR+9uOwar0cGveYIKXS2aISs2p5qFDG7cyRTPVe8vTrXE6gyPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1664356478;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+cXt2GTK5fkGLEpYOvvFvcpEf65u4EfwG1nI5xxG9E=;
        b=qnhpD5BjT8brzRv+bX7u9Ok5Bm/smu9SJn+uK1/2Efp0LwGZePGhW/LZDkHB902sEo/xOt
        X1CzXWBDqUepLtAg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Ren Zhijie <renzhijie2@huawei.com>, akpm@linux-foundation.org,
        ndesaulniers@google.com, nathan@kernel.org, vbabka@suse.cz,
        masahiroy@kernel.org, arnd@arndb.de, seanjc@google.com,
        hannes@cmpxchg.org, ojeda@kernel.org, mhiramat@kernel.org,
        dmitry.torokhov@gmail.com, atomlin@redhat.com, ddiss@suse.de,
        christophe.leroy@csgroup.eu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
Message-ID: <YzQQfW3h70OIiT14@linutronix.de>
References: <20220928064934.70867-1-renzhijie2@huawei.com>
 <YzPxMvjdjVEK1/b1@linutronix.de>
 <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-28 09:20:42 [+0200], Lukas Bulwahn wrote:
> > Couldn't this become a depends?
> It could also be a depends (to resolve the warning).
=E2=80=A6
> It is just the question whether:
>=20
> When PROC_FS is not set, should the CHECKPOINT_RESTORE still be
> visible as a config option to add (and then automatically add
> PROC_FS)? Then select is right here.

then CHECKPOINT_RESTORE is the only option selecting PROC_FS while
everyone else depends on it _or_ avoids using it in the absence of
PROC_FS.

Sebastian

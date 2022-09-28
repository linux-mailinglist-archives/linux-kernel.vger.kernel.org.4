Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C013D5EDBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbiI1LoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232505AbiI1LoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:44:05 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E3D2CDE3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:44:03 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-351cee25568so45781377b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 04:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=oCgdYdX8RxCRPNJlugWhA9KFxo3jWga564opL2iXnYU=;
        b=Se4P1o6rys+8C3KizpDhjgWjwuL9BmpGqnMgOs8YWUwQ+gQG5C//EIbg009QUwQe1w
         9OvfD6WU8wAYPu1KPoR8T61qKJYbCltEJLKRQ5X8g2fb5aD96OMZA/miBqsw5GhQ/bWI
         0f5GzwM7uQUDzUXbIGzW3yeCqibeGm+1K0ZoZhNM3BewYa6V6d2Jn8/LjjSGAlMmO0t/
         g9EMDILmXxi5WPUTiUdY1Sd87MiYVqEWH1VZE88hAhoq4i0awOJkXEGVPJ1ulrME06UO
         +oYPqsKzfR4YKcj8MRWFrHwjKoEJ9a8BHe9hkdilwBnNAXnRFxzTCxwcw7Pw4FMDzJC9
         pQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=oCgdYdX8RxCRPNJlugWhA9KFxo3jWga564opL2iXnYU=;
        b=oNTOJQS9DBFNCjBjExorxEuOwLmv0EovBGklf50v5NHuGK+/T++fm+bcmyXXr9ruPB
         FbR+PptMC00deFgyJrxLj7MCZDKnZH7VSICgTO5Fvd4WOiruQ1Vw8lqmQf8VPldZs5Nm
         zJ5fuL+Ep+QFb9/MEEnMVKiYmtzqEaBzwxFOHq8en5am6tcCkV0+dvLTKGwqmhSVaiEG
         S+8957N8Whcuk87EcUYwmdgNruv7/x/lBmhrumxBD2hXXj8FMccESJnETlYFETtkCzt+
         a2LQZIzX1Aae1uLaIWALVLUW4TCfV8iHFS/3wdsWWtxBrkth1R/LS6qH9L0orDIc1xmv
         r9/g==
X-Gm-Message-State: ACrzQf1w6C1wiLlkjTzmPwzuizkz3V3UK0TBYXmnbj7rdK0aGRWBEKLk
        JZBOWiIZL5X6sDVN2MV1L70wBdZQmokTsC6zWQA=
X-Google-Smtp-Source: AMsMyM6TW7NWL6Z+NtLA+qMD37UZEGbRaTCzjVnC87rWuln/hZYvbynY8vtHNZIOjLFR+5x27bIcPw7VPqPRh1IILXA=
X-Received: by 2002:a81:7702:0:b0:328:297a:fdcb with SMTP id
 s2-20020a817702000000b00328297afdcbmr29807058ywc.335.1664365442403; Wed, 28
 Sep 2022 04:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220928064934.70867-1-renzhijie2@huawei.com> <YzPxMvjdjVEK1/b1@linutronix.de>
 <CAKXUXMxGt9UGhw9Ap_M3U2AF1vw2dX7WpDO71=UwV0Be3t4sNw@mail.gmail.com>
 <YzQQfW3h70OIiT14@linutronix.de> <e33cc08b-612b-4786-9b68-262c43af5ccb@www.fastmail.com>
In-Reply-To: <e33cc08b-612b-4786-9b68-262c43af5ccb@www.fastmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 28 Sep 2022 13:43:51 +0200
Message-ID: <CAKXUXMxfF=WrVAWEZ=G8We+fOUvaM7o9uC_c8OVEDfa9Yv4sVA@mail.gmail.com>
Subject: Re: [PATCH -next] init/Kconfig: fix unmet direct dependencies
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Masahiro Yamada <masahiroy@kernel.org>, seanjc@google.com,
        Johannes Weiner <hannes@cmpxchg.org>, ojeda@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        atomlin@redhat.com, ddiss@suse.de,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org
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

On Wed, Sep 28, 2022 at 11:32 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Sep 28, 2022, at 11:14 AM, Sebastian Andrzej Siewior wrote:
> > On 2022-09-28 09:20:42 [+0200], Lukas Bulwahn wrote:
> >> > Couldn't this become a depends?
> >> It could also be a depends (to resolve the warning).
> > =E2=80=A6
> >> It is just the question whether:
> >>
> >> When PROC_FS is not set, should the CHECKPOINT_RESTORE still be
> >> visible as a config option to add (and then automatically add
> >> PROC_FS)? Then select is right here.
> >
> > then CHECKPOINT_RESTORE is the only option selecting PROC_FS while
> > everyone else depends on it _or_ avoids using it in the absence of
> > PROC_FS.
>
> Right, we should not mix 'select' and 'depends on' for the same
> symbol, as that leads to circular dependencies and general
> confusion.
>
> If there is no way to use CHECKPOINT_RESTORE without procfs,
> then the symbol should just not be visible (it will still show
> up with the dependency when one searches in menuconfig).
> Force-enabling a major subsystem like procfs from another
> symbol is not a good solution.
>

Agree. I retract my Reviewed-by.

The arguments are clear to make this depend on PROC_FS.

Lukas

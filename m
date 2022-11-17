Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5774662E8BF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbiKQWw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:52:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240764AbiKQWwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:52:00 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186779E34
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:51:49 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so3403342pjk.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 14:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VsJCHrbdA/8xBK+FwpkLQd0Vpot4PJyQ0+YuLOFb5ug=;
        b=pTjz7gNdBT8RN8+RtgT+xL5auev0FvBO9YOSaU3P9JChlH/BQwf5eeAUx8Gh5cZxfR
         48JPZw1PcZRczw33xA5iwcCyfd2dmgyCt0R0XH84aSGkd+rTJllIOnyLeXLFMzRHmXh0
         J4S7Hk5NCsCtUfHMamYLPy0hTzphxTpDv02auUqn7j/C6zWTXBK3dqeUEvBry6TX214/
         7jNtRRvSxJSkmvQI72pj38bIgZtyg+6kveSDejcZk5vbFIelQHCygf5GV60/9KMURAHI
         WMMViEpP1m3d5aPSjwxu+vHQk8qyBTkcFO7DxWYKVq+v1Z0Ily3QrigxC6OK2Kj4dLCD
         Jjng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VsJCHrbdA/8xBK+FwpkLQd0Vpot4PJyQ0+YuLOFb5ug=;
        b=4mUbxQoU+EFQ9IbicSKTpGojkv0GQFZbV4lrXp3GICZQuK3NDlFW/Fj55JE9PbR2nM
         XdbbihpwThwCKVZALxEcB6YzjbPyiaHV3vtzcl7yjD4PpCRUROk5Y2VeHhzaxLG3cmuw
         Vw/bpRK7GZcMtr0ccdDAWpkXK0Oe3Y5VFitvgT2v0EeulhKuujgc34S9IQ92WcdO0n/p
         l0fQFqJCyJVS70TnAmJoRJ3h1RSglblcaycpFBirqclvqDZd40xLaPsw8LHngkKXZ8z6
         0/7tMVLcFmPi3iJHLCqDYDj/Ko5rQRXZ1wra5CWLh1NW9qUswfZDMXL1bdY+Xb0k2QLe
         uMSQ==
X-Gm-Message-State: ANoB5pmfrAyf/gBGVHTDW8NWTb2UGbRm/2jWwnhgTPcvjSSeY3UbbyOS
        06FKRsKT3DiyMAMEbUhUgPY14/E/yI1JaupD7OVRZw==
X-Google-Smtp-Source: AA0mqf67vPPzluRI+XlzkgbR8xb3UntQ1E82cFrLyRnnBgAER6CWMYERHA+OL7EI9rQe7Fxda54moa8+K/I1TRjN1qQ=
X-Received: by 2002:a17:90a:ab84:b0:213:343:9873 with SMTP id
 n4-20020a17090aab8400b0021303439873mr10841158pjq.102.1668725509260; Thu, 17
 Nov 2022 14:51:49 -0800 (PST)
MIME-Version: 1.0
References: <20221114225719.1657174-1-nathan@kernel.org> <CAKwvOdn67r3ZYb5XZkae3i5797GGV3=8=nLC7kT2d4On3OEm5A@mail.gmail.com>
 <Y3aMxfhBw9YsWiKr@dev-arch.thelio-3990X>
In-Reply-To: <Y3aMxfhBw9YsWiKr@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 17 Nov 2022 14:51:37 -0800
Message-ID: <CAKwvOdmYO0_m3+uWHe_C=7y1zgePQzc27Kd6Pep7Ja_pgbNPZw@mail.gmail.com>
Subject: Re: [PATCH] ARM: Drop '-mthumb' from AFLAGS_ISA
To:     Nathan Chancellor <nathan@kernel.org>,
        Sylvestre Ledru <sylvestre@debian.org>
Cc:     Serge Guelton <sguelton@mozilla.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        "kernelci.org bot" <bot@kernelci.org>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:34 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Nov 17, 2022 at 11:15:09AM -0800, Nick Desaulniers wrote:
> > On Mon, Nov 14, 2022 at 2:58 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Fixes: 1d2e9b67b001 ("ARM: 9265/1: pass -march= only to compiler")
> > > Link: htps://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/17354b030ac4252ff6c5e9d01f4eba28bd406b2d/debian/patches/930008-arm.diff
> >
> > Would you mind using
> > https://salsa.debian.org/pkg-llvm-team/llvm-toolchain/-/blob/snapshot/debian/patches/930008-arm.diff
> > as the link instead? The link on this commit message is a diff against
> > llvm-14, not ToT which is currently llvm-16; the context is quite
> > different as the logic moved source files completely.  Though it does
> > look like Sylvestre has not yet cut a 16 branch for debian's patches.
>
> I would rather use an actual hash to reduce the risk of the link going
> stale from either a branch rename or file rename/removal. I can use a
> hash from the snapshot branch instead, if that would work for you?

It doesn't matter much to me; I trust your judgement; you pick.
Perhaps that depends if the snapshot branch has stable SHAs or whether
they change over time? Maybe Sylvestre can comment on that.
-- 
Thanks,
~Nick Desaulniers

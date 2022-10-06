Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD95A5F6FC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiJFUvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiJFUu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:50:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 559C4CD5FA
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:50:12 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id ot12so7266956ejb.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 13:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lw3hcZYCbSXQECyfjcrQpfoqdXxxo96LRjkxgjmynTg=;
        b=kAE5TejQzSw+caQhIkmZcd1nyaZXxYIEyK3iZIyJoF/2VlguNLzyQL1mOCh1HsiObI
         5EDpCdf1lINvFZf3XskyCyZ6BfVm+pq9R6xYB7GiRoGcvyrxyurWiQXJsLTD5xiM9VQ8
         NKnINdJqgsmB8nB2yl3OZvR+AlPbVEMzTFWx6dMb299Wpmep2q94XorBeGE5gqFO0piy
         cIqLyI9BbxXAQsSz5pz6nhdAPhloZoll955Q1G0i26iRCdiIVNVjuz7drfjjlvOVSibx
         g4W6Rkt7jS4o1t8Q3Ri0qN7ahT4htZdy55LRZWdSHEEVQxwXphzlxjwjv9lTddLFhVE5
         Iwbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lw3hcZYCbSXQECyfjcrQpfoqdXxxo96LRjkxgjmynTg=;
        b=HvtScgrJHmhMPvABOEvyAmU/ZZjQPLvsMwyIefws6PkGgfpgvolfCJrXAk95gLhtCO
         YGwusCC48AqqFkn6IFYoPZ1cvbftt0nJMi37TVtor/iXbE5QRLCaWeLfCTp89WcM4RQ7
         wn0WaZDfx4bOmZH1ZD/TRPsMBEK5NkGMlO78/Lxhu1BQ9V3WIg5xZ8xRUTBoFKr/p3lR
         1MxTaBCp0WeoWYzJfFGKkJhN3Powgr7BDnCUfWgCDyFeF0mnfoozd9eir2GBClBEgz4f
         Ym7yKfcqAFurJ4cp1DObDinykzmNhdK4GO2KrXqJ//2VA5pFVwVEpLRHTyYbxRSMCleD
         abCw==
X-Gm-Message-State: ACrzQf0NhNxBi2D1wCQBCZD+Bf03X0G53EOX92Vb/RaxNeynUHVaDsNj
        YrME9CIiQnO3s46G72V6bSx8t8G/NXg9iMBB1H8=
X-Google-Smtp-Source: AMsMyM4P91fpDljNrDMbFUDOVbFY03lG2h0mEvfbsXCHDDWdXCu9iyeVIP+ZTD/jq+OGeQ59K+AkwxHkTF0COate9gg=
X-Received: by 2002:a17:907:3daa:b0:782:1053:ccb5 with SMTP id
 he42-20020a1709073daa00b007821053ccb5mr1402440ejc.312.1665089409864; Thu, 06
 Oct 2022 13:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6W+j+l0cJbr5dX@debian> <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
 <202210061328.37FCC30@keescook>
In-Reply-To: <202210061328.37FCC30@keescook>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 6 Oct 2022 21:49:33 +0100
Message-ID: <CADVatmMOEtX_vpR2iv9r7n5x76xjuyHwx6duERqjMutb=AKrhA@mail.gmail.com>
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display: fix
 array-bounds error in dc_stream_remove_writeback()")
To:     Kees Cook <keescook@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
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

On Thu, Oct 6, 2022 at 9:37 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Oct 06, 2022 at 12:39:40PM -0700, Linus Torvalds wrote:
> > What confuses me is that error message ("array subscript [0, 0] is
> > outside array bounds of 'struct dc_writeback_info[1]') which seems to
> > be aware that the value is actually 0.
>
> I've seen bugs in the tracker where the reporting is broken but the
> range checker is working "correctly", which seems to be the case here.
>
> > If somebody cannot come up with a fix, I suspect the solution is "gcc
> > array bounds analysis is terminally buggy" and we just need to disable
> > it for gcc-11 too.
>
> It does continue to find bugs, so I'd rather keep it on. GCC has fixed
> all the issues we've run into so far (though not all have been back
> ported to GCC 12 yet, so yes, let's keep -Warray-bounds disabled there).
>
> Specifically, I've been tracking:
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=105679     Fixed 13+
> https://gcc.gnu.org/bugzilla/show_bug.cgi?id=99578      Fixed 12+, 11.3

Thats odd, the bug report says its fixed but I am using:
gcc version 11.3.1 20220925 (GCC)

>
> And it looks like Sudip's proposed fix for this particular code is
> additionally fixing unsigned vs signed as well. I think -Warray-bounds
> did its job (though, with quite a confusing index range in the report).

Not my. Linus's. I just tested. :)


-- 
Regards
Sudip

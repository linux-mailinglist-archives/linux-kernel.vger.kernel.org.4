Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 220855F6E7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 21:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiJFTzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 15:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiJFTzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 15:55:42 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DE0A571B
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 12:55:40 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bj12so6847238ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoNK9gOMUekLsnTTqNVMHHQjqI/P+O7lQ+POtGrsip4=;
        b=Nu0+z3x7BynDTW0WDQ023bafpHEoagL2OPoBRPup5QUxc9k9HMy6v19fdC3kUhLNXF
         vber1/xzSeZ/U5W8o9wrFt4TrLTqNjbUzDQ5TmC1jtZofrUOai8PSLRV3Mp9VnkwuQDo
         8SLLuhhSNzGJTqsAnZfFRSyy9YV/drhTBzZBam6TxZCuwHduWa+RfhCHC+zNUPXrKQ2g
         8QZIBmnJwKsIoKbNddHp/OjjJC+KWL6W+yNEiM8xxeZMIWCBdq9j9jxUJHdRD2p1IEeV
         XJ5n5bfyFIb6Yv5rY/+k+IyoZVAl7p68bGeilFE/JvyBeKXgVXkbcF/xxTDtsknKIvpy
         7CPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoNK9gOMUekLsnTTqNVMHHQjqI/P+O7lQ+POtGrsip4=;
        b=cmn7gLE+UT4q9txBU0YPaEkn9XKV7PGpwwaPfhP8UHCs01inWinAld5F47m0GEZhTC
         G+Rkw9vdLOa/dSAY2H1Vezh4fxKgZXnEJjQu9ktPK/RdBewI/wI+NDvIomhNLJbGk4Am
         tm4+pwmUZ1m2xqhLsSpszYy4WQV/c0QRmWXEx1NvojJz7vW+qOcOpJuAUAeQaJlaEKdp
         druLcw/2xGm/HrN6ggXoajoglc4PWbsX8+7ATbdmYLQKlYFsMqR/Ym/IQ6bEBUpTBtcN
         6rNDgQK1u9SiSPPtg/iANxcDK9OVfxwCUmB7hlindkwNoniLGzSulwKjNEMFwilfvxds
         QHQg==
X-Gm-Message-State: ACrzQf3jah/tbgN+GLm8R9tArplhZpg3eAf8FtOpZ5Ps0pAdKrl/u5z7
        VwFQBmHlTELfrFiorrrLymCtPuSQ3cf+18oTR1sUPVHEsEM=
X-Google-Smtp-Source: AMsMyM4wckjg0HNozBCina8M5IoyBta1vET7P2VQk5+K5aDwDpwDZkT9csypQUMoBSklUdJDGwSStOOqBcVlKeoCRg0=
X-Received: by 2002:a17:907:6087:b0:78d:2d1c:c050 with SMTP id
 ht7-20020a170907608700b0078d2d1cc050mr1242629ejc.481.1665086139135; Thu, 06
 Oct 2022 12:55:39 -0700 (PDT)
MIME-Version: 1.0
References: <Yz6W+j+l0cJbr5dX@debian> <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
In-Reply-To: <CAHk-=whR8T1x6DRnOMJsorajT3A-y9+j5Mpeh0zcUXcJiJWheg@mail.gmail.com>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 6 Oct 2022 20:55:03 +0100
Message-ID: <CADVatmNe49ZSkqX7E7K+GEk3crybRaAyz0nDwh_rzjkR51GegA@mail.gmail.com>
Subject: Re: mainline build failure due to 5d8c3e836fc2 ("drm/amd/display: fix
 array-bounds error in dc_stream_remove_writeback()")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
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

On Thu, Oct 6, 2022 at 8:39 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 6, 2022 at 1:51 AM Sudip Mukherjee (Codethink)
> <sudipm.mukherjee@gmail.com> wrote:
> >
> > This is only seen with gcc-11, gcc-12 builds are ok.
>
> Hmm. This seems to be some odd gcc issue.
>

<snip>

>
> The fix *MAY* be to just add a '&& i < MAX_DWB_PIPES' to that loop
> too, and then gcc will see that both i and j are always 0, and that
> the code is unreachable and not warn about it. Hmm? Can you test that?

Builds fine with the change you suggested. Here is the diff.


diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index ae13887756bf..51571245c49a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -520,7 +520,7 @@ bool dc_stream_remove_writeback(struct dc *dc,
        }

        /* remove writeback info for disabled writeback pipes from stream */
-       for (i = 0, j = 0; i < stream->num_wb_info && j < MAX_DWB_PIPES; i++) {
+       for (i = 0, j = 0; i < stream->num_wb_info && j <
MAX_DWB_PIPES && i < MAX_DWB_PIPES; i++) {
                if (stream->writeback_info[i].wb_enabled) {
                        if (i != j)
                                /* trim the array */



-- 
Regards
Sudip

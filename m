Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 376EA5BB89C
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiIQOBL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 10:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiIQOBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 10:01:07 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30E32C67D
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:01:03 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id b136so36527894yba.2
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=zD/Sef8RPFCu0UVUYWziEP2nxLn+8U8oMtAWbA1WOKg=;
        b=YcC3cgGuhWS4Xg3lrgZagbYgcH7H+Oqs1Vtfdb19quwhZaGI9UkGTfJt0FGuC3TbGk
         cC65tdI5WnSnZBN82+V6LK9oswdYJU3KLJq6NoFtrUPaQ6p2Xvxopnlu32vLyj2QvSUL
         d2Dw+zRNL37+TnmVi1iohbS1coBfaP8ILUJ+0wNcjTbQdFjoD6QL2lSRLYKcMN7hH9oL
         z1KxYlu1exKoBhQOaq5Q1um1ACC3dGlNgbLomefFeD4frSFk69CfgbS12OBMoOtME9Y+
         YFTpir5rXiAsWbkTm5IHbNzHkcZu+iLcrlGir95p2yHh63P9SNdm/rocCcaTwgCOeScc
         Wztg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=zD/Sef8RPFCu0UVUYWziEP2nxLn+8U8oMtAWbA1WOKg=;
        b=XNKNi4WlJNpkZTL+U6G/xodw2dCCRivGmviG7Gl5XkVPPq4fGn1ktLglD2cOFFQluC
         442Fk6zM/SrR5xAMGPbtKqCES+4rupU5PEk8VCGmNMwboVBVq5e8YYpSNG6C3dKiDpq1
         vVXv7jvBpCC8XFf67jJ5MIhFtoc5cmK1e5VrsW0P1J7i7DqloYJ2cjNVfSheA76dRtO1
         hAzzmYryzjFaH/S2wr8A16nFYFVdbtllPioydsFZyRuAdKhiusiSp9yKIiv65Z1nKlK+
         xPFSUa5Olj/uf0tvV6U8zX75bqkbUWeQSnxs5BR7iBMX4p/tb/JSWoOfa1kQogNn/wbd
         m5pQ==
X-Gm-Message-State: ACrzQf2mDwGAFz5BDIQrmZYglLRGtuM+WZPX/FHkym+WeWYuTlS74wa9
        b73cu2uU844+HlzVmB2+XCcMPLxjim8oxtLoF9Y=
X-Google-Smtp-Source: AMsMyM6MSZI9tekALssIfUCVIXmmS+TxhNp3mdgEOPjIBYJ6CwNaZ3jWo3MxCGHOKPfoAytGRmXAHXSCXcB/twZbNMc=
X-Received: by 2002:a5b:845:0:b0:683:6ed7:b3b6 with SMTP id
 v5-20020a5b0845000000b006836ed7b3b6mr8163614ybq.183.1663423262817; Sat, 17
 Sep 2022 07:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <YyWniVAqJclcbSqN@debian> <YyXK1rJYEc04Sobt@dev-arch.thelio-3990X>
In-Reply-To: <YyXK1rJYEc04Sobt@dev-arch.thelio-3990X>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Sat, 17 Sep 2022 15:00:26 +0100
Message-ID: <CADVatmPwPjpEJdfygtQtt7d6oQfABUtTVrn2k57eKFEFQChDbQ@mail.gmail.com>
Subject: Re: mainline build failure (new) for x86_64 allmodconfig with clang
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
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

Hi Nathan,

On Sat, Sep 17, 2022 at 2:25 PM Nathan Chancellor <nathan@kernel.org> wrote:
>
> Hi Sudip,
>
> On Sat, Sep 17, 2022 at 11:55:05AM +0100, Sudip Mukherjee (Codethink) wrote:
> > Hi All,
> >
> > The latest mainline kernel branch fails to build for x86_64 allmodconfig
> > with clang. The errors are:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:4020:6: error: stack frame size (2184) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
> > void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
> >      ^
> > 1 error generated.
> >
> >
> > Note: This is a new error seen on top on a335366bad13 ("Merge tag 'gpio-fixes-for-v6.0-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux").
> > Previous reported clang build error is now fixed, thanks to Nathan.
> >
> > And, it appears Nathan has already sent a fix for this:
> > https://github.com/intel-lab-lkp/linux/commit/4ecc45d7585ae2e05d622879ad97e13a7d8c595b
> > https://github.com/intel-lab-lkp/linux/commit/819976a950b497d7f10cd9a198a94c26a9005b30
>
> I did not realize this was a mainline issue too :( it seems that
> commit af2f2a256e04 ("drm/amd/display: Enable dlg and vba compilation
> for dcn314") is needed to see this and it was only in -next for three
> releases (20220914 to 20220916), which I missed checking as closely as I
> normally do due to Plumbers wrapping up and traveling.

This has become a mainline issue since today.
I saw in it linux-next also, but missed reporting :(


-- 
Regards
Sudip

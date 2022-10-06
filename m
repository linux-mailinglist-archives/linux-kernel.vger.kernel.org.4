Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381305F6EB7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 22:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbiJFUOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 16:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiJFUOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 16:14:15 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A3FC6978
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 13:14:14 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1324e7a1284so3453644fac.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Oct 2022 13:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=LG5s7nbKTfHu5COP1QJvyeZv9l1qYTKLfGC/UV14PKk=;
        b=FT8jddiKZ/7hF9TxFucIVcyaA16ujYVO3dQv9YaW+7B5bMaN4nXWeK/7WZCA/gUQWS
         HKtQsJSGZT3kh3GPFl4gKcGPKW8loaE/0sZp1q93mD3ilQ2SgkyIevV0KEH8P85AAFQO
         Y6RzfJf6uTPgrhict9EuYcMyb1FrE3Tdq3RMDyhLNtmU1SHF4v9S+k4k/hTOKBQhwqAl
         IhOpwkPdC8VR4o5LxvlEqha+nNM/uJxr1o0wHfzUSRPxd97HYQhhx6F8SkmpcSgD7iB1
         q9qxKt1i0jsnNoZYTqXW4k0dMp4a52JupHZfKiRaNCFYkx9P8GPcDN/ePz5U8T6yVuii
         r9Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LG5s7nbKTfHu5COP1QJvyeZv9l1qYTKLfGC/UV14PKk=;
        b=2qG0BcvhERHS84g8/e2YLCFLlEeRWW0mCJY3YYs5lpaRIEIxafTV+664cTk4Ns5B8g
         y4Nd2ycLEqYc/qO4Ejq6zUQS1pO3bZXABwBPZeKCtCCrxADF+ETJfFRwzSO0TdnDo0oE
         qWZcdN/zbd9/mPTSLK1tZLoMwVco8qSWfYix7RTntL9dGnBd9/Rxqw91Uj/XRvQnjBBk
         Rn2qdyIFpCPjdOnXUQc9bxn1vKMCBzeqEQpdzNXhP2TJNFnr8XcRWDyRGCUiweacrVOZ
         I155Es6wgo4kiHv8fL91BJIb9WxkHUT/WGgKzP0u8ZaG0wJSgtDZHxK+nC4rqS3qTY79
         vg8w==
X-Gm-Message-State: ACrzQf2kHT5GQiw8uWNs84YV6xCytCB25uS4IcbJHz8L4A0jJTV7cUKD
        D17USBQSz42MdlhX3crYkYRHnvwrJ1CTKQI34+I=
X-Google-Smtp-Source: AMsMyM4z9WFuSSW3+LYClNwwgR9Bgu8QwYeUVIXfiqZc12CrE/fJUgscVA3p2Pvg9ze/0ZMUHo/Zuq3dM3JG4EzR470=
X-Received: by 2002:a05:6870:c5a4:b0:131:6edd:3955 with SMTP id
 ba36-20020a056870c5a400b001316edd3955mr830537oab.96.1665087253471; Thu, 06
 Oct 2022 13:14:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=whUp5Ufur6Bmv=H-rDDTNJJ-KVqOKkL+5FmR01jp0dbcA@mail.gmail.com>
 <CADnq5_Of-8ZyBxee0fZ=0x-eV-2NX_+e9sd-9nmuHdLugSHp2g@mail.gmail.com> <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
In-Reply-To: <CAHk-=wi43xD06UgO2McDT3R=ze_aHgOGjcDOoggSwmQRv2kA+A@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 6 Oct 2022 16:14:02 -0400
Message-ID: <CADnq5_N0Ef+1VUoDLdpHfJXqZFuPYbx5Lq+94NWciHcQC+VrMg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Thu, Oct 6, 2022 at 3:48 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Oct 6, 2022 at 12:28 PM Alex Deucher <alexdeucher@gmail.com> wrote:
> >
> > Maybe you are seeing this which is an issue with GPU TLB flushes which
> > is kind of sporadic:
> > https://gitlab.freedesktop.org/drm/amd/-/issues/2113
>
> Well, that seems to be 5.19, and while timing changes (or whatever
> other software updates) could have made it start trigger, this machine
> has been pretty solid otgerwise.
>
> > Are you seeing any GPU page faults in your kernel log?
>
> Nothing even remotely like that "no-retry page fault" in that issue
> report. Of course, if it happens just before the whole thing locks
> up...

Your chip is too old to support retry faults so it's likely you could
be just seeing a GPU page fault followed by a hang.  Your chip also
lacks a paging queue, so you would be affected by the TLB issue.

Alex

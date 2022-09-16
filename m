Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2AF5BB3E7
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 23:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiIPV3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 17:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIPV3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 17:29:23 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC73BA161
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:29:22 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1278624b7c4so53969468fac.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 14:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yR03AC7skqm4Sf0BoWlU++GD1rfqR8bze/qTUtC2nV4=;
        b=nmwBVnF27sMALH+ZRjJIloQ0ORAOz0/G/ggoA51mzfJ+Y79r7koANnb2Wh4jX+7UzC
         4LyyY3NI+YZ5UN/LgrVGyVSmZ5r7CiCjLV8QJcNxCQoPHNUhJXhF6pI4wCK4VVNTdOmd
         UGgvmNF3/V/+jxEwoHVP11IUtV4K57C25SAubcBwrQLcJpvEFE6NUYPKc/RPfpvjCMIN
         QkgNXYbz+Z3srSj/UplFXGGmpnYAd01lxIK6wW02cE5Sp8Y7Zy/cPp13xJkaTUaCWpBV
         SecKTlJew/OKyiiJs2blS2IM31QouOQvR7iR0jO4KotmRonw9LnNFZgpWnVMbYqZqWZg
         cxcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yR03AC7skqm4Sf0BoWlU++GD1rfqR8bze/qTUtC2nV4=;
        b=AbLcNtO4dvXqAv2lTN7tGrHt+MnluTTp/TQJwk40PzwGigjO1Mz0xP5kKkAbZxAcL5
         d3U02X44ix8F9ck3AoLoCTwprih8OFBAOVDTq7ZgmmJRYE3Si8dcR7K3D7QNMPBfdTn/
         jsJFMexjMHIjI5RRot4W7YhkL697noZaBIg1dTt+YiWPVe2LWNFoNIfos+fuGGFfrhlT
         iv3KQyrJDpwfNbcNM7tVdq8g8oSthXPb2hAnAznK8XGfl6bRW1+j0Wt2/90fb7jKJsXi
         NH99KlG2Y9cQrswiGEQItAWIo4guPBViljTfpnQlZ2Snqc2ziUCrFQuOaTqq+XMcqDjz
         wHLw==
X-Gm-Message-State: ACgBeo1ix4hNuDkDwMkEuaCxlxGmTm2a3uTqo8hzENQ58y6wiewAGDRw
        ZWMQfe5NLGScvKDm1DNVYX3S3Bhnvkz7ugLPi8U=
X-Google-Smtp-Source: AA6agR5iMb/4oOijTsdzbyI+HbVDzLhQNa0y8/uYFeeLzPxH4WLVBb4XBVeSh0vmtUpsqol8cpkSrGRIiHksuSv80aU=
X-Received: by 2002:a05:6870:1783:b0:12a:f442:504d with SMTP id
 r3-20020a056870178300b0012af442504dmr10243841oae.46.1663363761631; Fri, 16
 Sep 2022 14:29:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+5PVA5ymJ-ghhhCfEBPxBynucF3gD+nHVNwcZkC5bsVotatDQ@mail.gmail.com>
In-Reply-To: <CA+5PVA5ymJ-ghhhCfEBPxBynucF3gD+nHVNwcZkC5bsVotatDQ@mail.gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 16 Sep 2022 17:29:10 -0400
Message-ID: <CADnq5_MC+WYSdPPmMoFYzwwC1ANwtjo0XvEhOLbOLkPfYs4hiw@mail.gmail.com>
Subject: Re: linux-firmware signed commits; does anyone care?
To:     Josh Boyer <jwboyer@kernel.org>
Cc:     Linux Firmware <linux-firmware@kernel.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Peter Robinson <pbrobinson@fedoraproject.org>,
        Takashi Iwai <tiwai@suse.com>, contact@laurentcarlier.com,
        mpagano@gentoo.org,
        "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        Jared Dominguez <jaredz@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
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

No objections from me.  I don't see much value in it.

Alex

On Fri, Sep 16, 2022 at 9:33 AM Josh Boyer <jwboyer@kernel.org> wrote:
>
> Some time ago, we went back to doing ~monthly releases for
> linux-firmware primarily to help distributions package firmware in a
> simpler manner.  We GPG sign the tarballs, as is good practice, but as
> part of reintroducing the tarballs we also started having a
> linux-firmware maintainer GPG sign *every* commit done by a
> maintainer.  The intention there was that because we're dealing with
> binary blobs we really have no recourse to see changes unlike a source
> code repo.  The signed commits at least provides a measure for
> interested people to ensure the repo itself is only being committed to
> by a recognized maintainer and it isn't compromised (in theory).  The
> downside is that pull requests are merged non-ff and we wind up
> signing the merge commit.
>
> The question at hand though, is does anyone care about the GPG signed
> commits?  It's not clear to me this practice is even noticed nor if it
> is bringing any value to this project.  Since we've started this
> practice, I am literally the only one committing to the repo and while
> it isn't hard to do I want to know if it's actually useful to anyone.
>
> I ask for two separate reasons.  The first is that a group of
> interested firmware submitters is looking at modernizing the workflow
> for the linux-firmware project and moving to a merge request workflow
> instead of submitting giant binary blob patches via email.  This would
> allow us to put some CI in place for simple checks to the WHENCE file,
> etc.  Doing this while still having GPG signed commits isn't
> impossible but it certainly complicates things a bit, and would likely
> require a trusted bot to sign commits.  That has implications on
> secret storage and changes the dynamic on trust levels that make the
> whole thing even more questionable.
>
> The second reason is that even if people are validating the GPG signed
> commits, it's not exactly user friendly.  I've been looking at
> sigstore and recor and that might be a better solution in the long run
> if we do want to utilize something like the current scheme.
>
> I'll still GPG sign the tarballs, but I'd like to propose dropping our
> current self-imposed requirement that all commits are GPG signed.
> Thoughts?
>
> josh

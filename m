Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566FD6239D8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 03:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232212AbiKJCiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 21:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiKJCiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 21:38:01 -0500
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19D6221808
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 18:38:01 -0800 (PST)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-3691e040abaso3784457b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 18:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ibmMgAXbjjaN11VFsHkJQSJq1cPDMl62aGHSM2/7Qz4=;
        b=TxXbGY6MqrUFhP1+BFe+fijdVfGlWxRoOvFMDVAndTKHK+26MsMdFCXQXMG2yxBXbi
         dlsSY6HPLQZpFRFSa/89Iport3Ifx1iHPE2Ektcf53rTAbBEodSOBD5MlH8u1GoxUw3P
         +s1PnQHOIxXg5x1+skjghrBiWJ0U0wPVZpWyENYf/r4hoSrS97IiIGv9xd0zBQYdVGhm
         D4F23tPM5gPlrlgTQVxR+lIVoTszar6901KoD4/WZfkIQ9neiXc+eYkQQ1Q/ybE4qx0G
         EsdINsnqfEdAzOwo94Ll3rsVlsxNQZWmMMu7+diqzKV/sRsBUGbf0hv1S27WLj9BIw0T
         bjUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ibmMgAXbjjaN11VFsHkJQSJq1cPDMl62aGHSM2/7Qz4=;
        b=0q82zfqRI4L6C1EAY62HUfaO3aadzn9ExecoLjjNwjZiN09VRQWPOB7zIC1jJsCk+u
         yp3UK86cofbuEFv2Yd0nLk6h7BVNymZDifx3YVYG9TdnG7MO/SCV5s1UYFB/rY5mO239
         i253pMeF49VtP9AF24keU5mlrZQ3jgibt3maIIAOw3JBjsgyb3w9eyWNVST9DiCRtu0Z
         PsT7O+41j5zRCA9654CpMKQ/DN/R2z8DZC/gTn6ouuEwFYwE3Qt6XfqEeneYtsWiS3+u
         jPP5LqoLgvIeb/2jSOuMn2bvlpAIaUWByQ0uY4a975BxyPSyhBiEIRVJ8kWwPq2D0ZcQ
         dM3w==
X-Gm-Message-State: ACrzQf0vU7+g0MiopGnpgNhz0z9K3KRvsAwCh8kqI/xOW15Q+C2QEa7l
        bOz5gG8yMSXkq4qtCP14QK2NLhZpM99y+pQzuvr4
X-Google-Smtp-Source: AMsMyM68Q6DhzhnyZCPFpqsv/6KaI/umTZlXQ5XcOaYlET4DeZmtbpcInSNhrshaezKk91UO0aDy7ipBqiJ19zpHbmk=
X-Received: by 2002:a81:50d:0:b0:36a:6711:f7dc with SMTP id
 13-20020a81050d000000b0036a6711f7dcmr59100471ywf.276.1668047880011; Wed, 09
 Nov 2022 18:38:00 -0800 (PST)
MIME-Version: 1.0
References: <20221025184519.13231-1-casey@schaufler-ca.com>
 <20221025184519.13231-3-casey@schaufler-ca.com> <Y1jMeWl0oV4/2zyE@kroah.com>
 <5396ab1e-9b93-df33-ca49-58dc59459a76@schaufler-ca.com> <Y1olsHWnaEk6+b1L@kroah.com>
 <612c169c-2e11-13cf-9742-19714a247152@schaufler-ca.com> <CAHC9VhR8_aQFxBq4fG=q8FgVUEZAL6F_iSE9kFnO7Mf4tf52AQ@mail.gmail.com>
 <20cdb098-400e-25d0-f93e-98efb1095b68@schaufler-ca.com>
In-Reply-To: <20cdb098-400e-25d0-f93e-98efb1095b68@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 9 Nov 2022 21:37:48 -0500
Message-ID: <CAHC9VhR50=d_pjoxOMX_a8oyKc572BqjJUZD5Mcd8snHHq5WHQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] LSM: Add an LSM identifier for external use
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, casey.schaufler@intel.com,
        linux-security-module@vger.kernel.org, jmorris@namei.org,
        keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, stephen.smalley.work@gmail.com,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        mic@digikod.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 7:57 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 11/9/2022 3:33 PM, Paul Moore wrote:

...

> >   My reason for
> > doing so is rather simple, we're going to treat the ID as a 32-bit
> > value so we have *plenty* of room (just the thought of supporting +4
> > billion unique LSMs is comically insane), and I'd like to try and
> > leave some space for yet-undetermined "special" things that we might
> > need to convey in the LSM syscalls.  For example, this would allow us
> > to convey additional information to userspace when an application
> > asked for labeling information using one of these reserved LSM IDs;
> > applications which did not know (or care) about the special ID would
> > continue to function normally but augmented/new applications would be
> > able to make sense of the additional information ... and we wouldn't
> > have to add a new syscall to do it.
>
> I don't see how
>
>         #define LSM_ID_SPECIAL  2
>
> is better than
>
>         #define LSM_ID_SPECIAL  13
>
> There's no reason to "group" LSM_ID values, nor have a range of them.
> Really, I don't care one way or the other. I will bend to whatever will
> is stronger.

The token values are not intended to be grouped in any sort of range,
it is just easier to say values 0-32 are reserved that create 33 macro
defines like LSM_ID_RESERVED1..LSM_ID_RESERVED32.  The actual token
values shouldn't really mean anything, we could randomly assign them
if that helps get my point across, I just want a few reserved numbers
in the token space to leave room for future unknowns.

It's not like I'm suggesting something that has never been done before :)

-- 
paul-moore.com

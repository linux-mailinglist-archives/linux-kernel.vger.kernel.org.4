Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEA660FA41
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 16:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiJ0OQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 10:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbiJ0OQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 10:16:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488BE173FC4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:16:27 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b18so2731413ljr.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 07:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jrIU22cTxb3Bgw4qwsYPzB4cQE/SP06ICkrfPKGmXxE=;
        b=a8Ow75Og8ZAdIQdZNR9xPleiWBlE4qI7VFClPu3bxyL+3R+bDj6uB4dBXGXViGRL4E
         ml2Y8jhwYd0CobP2mEanjVdlDUpHShZ3fpJHtpEM2afHfeBb6aI/G6Y/WYhaaAhOGajY
         e4vzPsBXYezNFBD29M4FSeNTiqieIN0TqJkIKsMHk23ph9Y62rmk2uLO9IzcnLW06q69
         bb9URXVoz7z8aGH2T/S5oZ6QNXsIA8wazGrnXz3uRfC8gvmSanEgW/llb+P4YCOivPBk
         eI1P8Nbhy2GKFXueam8awFmGv8uoM+PRA5QeHTa9L3JK8lCtcf3KHx+mPVYNIuzLJvyH
         MqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jrIU22cTxb3Bgw4qwsYPzB4cQE/SP06ICkrfPKGmXxE=;
        b=iVc2DB9c60wf8W3rThGV0ywX5/RB/KnCc9aooo8QSKgD73p4lcgZB4qTUIUZ+70pcT
         R94rFLqKfxDyvWKl+IveN2jtR9Zu350KfV/mDwQDwSh4efmxqmT6cBygaj+qrt6pfSF5
         XCaqOVtXpqawqnXN/g/S87tjGAK19QxHuH5YcvX98UpskhpdQhU3D6BD1WdL48q1NjXA
         bRxKALcpkR0xchBQh7iDa7rmp2dD8y2dOyLyoKx6499bs+uAROSOf0Q94DeQXg6x0CBA
         b7Tp/v6XQY5NOFyz7ZJeSW/VYXGfokVp6S+HsfAn7Tk6qitW4TwMs28MnqOuoJpq3Rz5
         p/8w==
X-Gm-Message-State: ACrzQf22yBag8vW1J72bA7TQ4jWSfnqsKW3T0/4PctcE3agO+hwL+AyY
        HDPEu4fOvpVRcuEYyafvAk7SU5QO3AjjnFMrKcEbwA==
X-Google-Smtp-Source: AMsMyM7KG/Ks7YLQlEFbRpH443VpJwWyM9AE6ouquyUF3qtx9UeMypPlBKBx9JC7/EO0kkIOr+EEi9t8gQNr3YhSXPA=
X-Received: by 2002:a05:651c:a09:b0:277:2ded:cfc0 with SMTP id
 k9-20020a05651c0a0900b002772dedcfc0mr988387ljq.398.1666880185342; Thu, 27 Oct
 2022 07:16:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221012002323.2015637-1-dionnaglaze@google.com>
 <CAMkAt6qj-iHzk+FqCGh5z4EZHB9BzOfqES8RmjgYXs3CSg3CXQ@mail.gmail.com>
 <CAAH4kHbf6HO05bSwcSsqXTYKTn6wz44mivNY6ZpNrCVzgO3jRg@mail.gmail.com> <Y1pTO+T67EBdlQd9@zn.tnic>
In-Reply-To: <Y1pTO+T67EBdlQd9@zn.tnic>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 27 Oct 2022 08:16:13 -0600
Message-ID: <CAMkAt6rKAMscBPVegLhBvZ2K+jCP-bOx5z4Wv23X54MTMDzamA@mail.gmail.com>
Subject: Re: [PATCH] virt/coco/sev-guest: Initialize err in handle_guest_request
To:     Borislav Petkov <bp@alien8.de>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

On Thu, Oct 27, 2022 at 3:45 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Wed, Oct 19, 2022 at 12:58:12PM -0700, Dionna Amalie Glaze wrote:
> > fw_err = 0xff doesn't make sense to me actually. It's not a documented
> > code that the firmware was never called.
> > Still, we can simply pass fw_err to snp_issue_guest_request rather
> > than an unsigned long err, since a null pointer results in an -EINVAL.

Yes this was not what my comments on the patch series intended.

On the host side we have `psp_ret = -1` inside of
__sev_platform_init_locked(). I think defining SEV_RET_NO_FW_CALL as
UINT32_MAX and moving to make all values of psp_ret where the psp is
not yet called would help callers understand errors more clearly.

>
> Yes, pls do that. Such I/O function args are always a PITA anyway.
>
> In retrospect, that handle_guest_request() with gazillion args should
> have been made to take a struct as a single argument and populate it as
> it operates.
>
> The callers then would look at it and decide what to do.
>
> Looking at the callers, they all take members of struct
> snp_guest_request_ioctl and pass them in. A first step in cleaning that
> up could be to simply pass that struct snp_guest_request_ioctl pointer
> instead...
>
> Oh well, in case folks feel bored. :-)

Ah, good idea. If I have some spare cycles.

>
> Thx.
>
> --
> Regards/Gruss,
>     Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

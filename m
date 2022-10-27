Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 691C660FC6C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 17:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236325AbiJ0PyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 11:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbiJ0PyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 11:54:09 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA24219347D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:54:07 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id k2so5924510ejr.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 08:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FAmKYYqMjWSQ7YgGU78Q18+QVFqV8/KAmZmBOmBILHI=;
        b=FO73N2IiIEH2fVJRdCxktCZAeo3K6IHbLuTMJc21OheNeczY9V+zMBcdbFDBHn8/Sy
         jbfUewPqa1243F/4gA9DRe4xST4SCtNUnNNAPXknD/Ji+a1l2WD8kR/pkCfA/2/LDna2
         wVAVx83x2ewFJFY15ez4l6fzkJ1JFIIhBCdW0VLV1W6CVFKIl9/e3VxzID/5/KCjThML
         ilunqcYd9l41aj2hMu/ap2Q2UBRFxJMIZuq3UxjFKEwQRSQQC05yUz5po7kEYO1oTEg9
         uEeByJv86WV1DRj12jrX83h226rGLNyH/V4+ArdBrOFBNny4/g3mr9U1EWAdbBI02Uq5
         E+xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAmKYYqMjWSQ7YgGU78Q18+QVFqV8/KAmZmBOmBILHI=;
        b=zoYut8zjcSDq999Lb0Vw8MefiNk1cHr2+QmRCVUjz7z9VW9LWPbv/GHEwXj3COYx5i
         fxg/qBdVftjETJb4IRqJatDC4ULLm6SCn3OQpNGLBxtvT5Uxfau2IK2JZYDsmlFTAgTN
         w1DGgqoZM3oEXVooaRPfvmzVmwkE+CyVCSHWg5W7bCtri2qg1Rlh81b2Y8pNXaE+Ekma
         5ZLUWGjzF/cwutFlxi7jsN1JkaabtkyxJzfv68v8mY0uYMM2qQqYqPv62ju2oV9xpzIQ
         xVJWAAbJhwiDuLpE+l69Z18RRjc1gyyPOXvpYP6X5/CfiMjKggKuIBcCABB0hGqBEuVQ
         6urQ==
X-Gm-Message-State: ACrzQf0Q2PKGJ1fVfZ6eEw/EOSQ9YnNmTQKrPdOgmUESzeFTBZ0OwD5Y
        2g8w5roWo/NJino1EPqQCl2fbBOJTSO6PkmIZoqi/GUZXGk=
X-Google-Smtp-Source: AMsMyM7Nz8td/HWNYJVYPN8ThZSn4Y//ugtymf1QGc1K2+828K+u82SIP7j5RQIHsRsRpn4qL6YA3kjuAOwzyQe1J5U=
X-Received: by 2002:a17:907:628f:b0:72f:58fc:3815 with SMTP id
 nd15-20020a170907628f00b0072f58fc3815mr42899403ejc.719.1666886046138; Thu, 27
 Oct 2022 08:54:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221024224657.2917482-1-dionnaglaze@google.com>
In-Reply-To: <20221024224657.2917482-1-dionnaglaze@google.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Thu, 27 Oct 2022 08:53:54 -0700
Message-ID: <CAAH4kHbeKJ2w7VtiSS3cPQjO9DOuMn47NbJ-_1x65ByVO7e1TQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] Add throttling detection to sev-guest
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>
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

Pinging y'all in case you haven't seen v4 :)

On Mon, Oct 24, 2022 at 3:47 PM Dionna Glaze <dionnaglaze@google.com> wrote:
>
> The guest request synchronous API from SEV-SNP VMs to the host's security
> processor consumes a global resource. For this reason, AMD's docs
> recommend that the host implements a throttling mechanism. In order for
> the guest to know it's been throttled and should try its request again,
> we need some good-faith communication from the host that the request
> has been throttled.
>
> These patches work with the existing /dev/sev-guest ABI to detect a
> throttling code.
>
> Changes from v3:
>   * sev-guest ratelimits itself to one request twice a second.
>   * Fixed a type signature to use u64 instead of unsigned int
>   * Set *exitinfo2 unconditionally after the ghcb_hv_call.
> Changes from v2:
>   * Codified the non-firmware-call firmware error code as (u32)-1.
>   * Changed sev_issue_guest_request unsigned long *fw_err argument to
>     u64 *exitinfo2 to more accurately and type-safely describe the
>     value that it outputs.
>   * Changed sev_issue_guest_request to always set its exitinfo2
>     argument to either the non-firmware-call error code, the
>     EXIT_INFO_2 returned from the VMM if the request failed, or 0 on
>     success. This fixes a bug that returned uninitialized kernel stack
>     memory to the user when there is no error.
>   * Changed the throttle behavior to retry in the driver instead of
>     returning -EAGAIN, due to possible message sequence number reuse
>     on different message contents.
>
> Changes from v1:
>   * Changed throttle error code to 2
>
> Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
>
> Signed-off-by: Dionna Glaze <dionnaglaze@google.com>
>
> Dionna Glaze (4):
>   ccp: Name -1 return value as SEV_RET_NO_FW_CALL
>   x86/sev: Change snp_guest_issue_request's fw_err
>   virt/coco/sev-guest: Remove err in handle_guest_request
>   virt/coco/sev-guest: interpret VMM errors from guest request
>
>  arch/x86/include/asm/sev.h              |  4 +-
>  arch/x86/kernel/sev.c                   | 10 ++--
>  drivers/crypto/ccp/sev-dev.c            |  2 +-
>  drivers/virt/coco/sev-guest/sev-guest.c | 61 ++++++++++++++++++++-----
>  include/uapi/linux/psp-sev.h            |  7 +++
>  include/uapi/linux/sev-guest.h          | 18 +++++++-
>  6 files changed, 82 insertions(+), 20 deletions(-)
>
> --
> 2.38.0.135.g90850a2211-goog
>


-- 
-Dionna Glaze, PhD (she/her)

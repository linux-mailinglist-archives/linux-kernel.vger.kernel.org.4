Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B1E605042
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 21:17:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiJSTRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 15:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiJSTRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 15:17:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB301CFF30
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:17:37 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m15so26683734edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 12:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/AvelkHgDjx2YUHU8qQi+8CKXgP5nsqFCZcQN/8SYjk=;
        b=R3WMiPPAyjdQ68U9jp4JTmI1sLvkUEI3yLbE/GhkMc0kwE/6a6GmMLfWA1ays5qvkI
         GZJ+x1re+jdZSNYMG4e5Fu4JN5gEIzZ9A3gLyGt2UaawUZVj+ocDR2mDB1EP5j6SmsAB
         ToJZ0gK9ssU+GyMv5Hfli304WDuSb+na/Z7oGcjmFsAyjm2hZ+YjCzujK/2p5LfS/ADi
         3Rycy2KFp1CF5Go9oxlFCI/2D5u6ZuD1gPtKD8bm9sRet73ug8Yw4E4ch8EU+UJORlY4
         SjBN22EvMovWXNrEpm7whqjHo+DCt2sGBS/fSofC2E5FfK/1kSD3Q0J4LI4jy8hwQj40
         BjrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/AvelkHgDjx2YUHU8qQi+8CKXgP5nsqFCZcQN/8SYjk=;
        b=zeo2QlgP1ZTJAFPxgK0R8Gkn6tT7zLJQzhoOMVc1ZNUJ1Z/BsglZ4pulRnfZYYk0Sm
         BfK5Vh4yNPRLiIvTvmkileKJDhryA9m8fxYYyh/UZcOqmf+uyGyGBJPsWzUpSVVXjX3l
         oRS2HBtBGmkw+SKFz8IwinL3gy9wgj5fqD6jnA4XcZDkXjXIJyG7pLHm+ChHglx1Z8xU
         phnaEpwqydtUXQfhLJ9Efm88G801sTeK9M6A2mjL+cHCgMklkEnY3looNW32Hxa1lOcY
         zmhK+sTEsEjW69AYXlebUQLRBPHG6jqLtRX0nZ/piZHPoxJvQHk0IgBaNCXPNhYvDLAJ
         RkSA==
X-Gm-Message-State: ACrzQf3Ydqz2LGG2O2lKhfTybveUJm4hFtyRq6Egbmp/cqpySQSQOScN
        grxi0ApVvF+h3j2iqLz8C8Ez/t78X+l1qQj3AVNpHA==
X-Google-Smtp-Source: AMsMyM5TaI0/5pB++VRaXRjAhzycDHGj+lfPeF7w9lAv92IWAMVnliP0iUalmqXRxFXpNwBBnRDTiaed3S0HAYNLEwA=
X-Received: by 2002:a05:6402:ca:b0:45c:dbdd:8143 with SMTP id
 i10-20020a05640200ca00b0045cdbdd8143mr8878750edu.213.1666207055742; Wed, 19
 Oct 2022 12:17:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221019150333.1047423-1-pgonda@google.com> <528937ab-8046-d5d1-26ff-50ef35f5635f@amd.com>
 <CAMkAt6ritG1zmOreh9WYLYAGww0EJQy+m-Y0nfxD5+gpTkpJ1w@mail.gmail.com> <821e750b-26c9-3331-7577-5cb832a35afa@amd.com>
In-Reply-To: <821e750b-26c9-3331-7577-5cb832a35afa@amd.com>
From:   Dionna Amalie Glaze <dionnaglaze@google.com>
Date:   Wed, 19 Oct 2022 12:17:24 -0700
Message-ID: <CAAH4kHYhLkiN7H03GKgMU+3h9rhp2a03gNFGLbrNtjp=PYYHQw@mail.gmail.com>
Subject: Re: [PATCH] virt: Prevent AES-GCM IV reuse in SNP guest driver
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Peter Gonda <pgonda@google.com>, Borislav Petkov <bp@suse.de>,
        Michael Roth <michael.roth@amd.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Marc Orr <marcorr@google.com>,
        David Rientjes <rientjes@google.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
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

On Wed, Oct 19, 2022 at 11:44 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/19/22 12:40, Peter Gonda wrote:
> > On Wed, Oct 19, 2022 at 11:03 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 10/19/22 10:03, Peter Gonda wrote:
> >>> The ASP and an SNP guest use a series of AES-GCM keys called VMPCKs to
> >>> communicate securely with each other. The IV to this scheme is a
> >>> sequence number that both the ASP and the guest track. Currently this
> >>> sequence number in a guest request must exactly match the sequence
> >>> number tracked by the ASP. This means that if the guest sees an error
> >>> from the host during a request it can only retry that exact request or
> >>> disable the VMPCK to prevent an IV reuse. AES-GCM cannot tolerate IV
> >>> reuse see:
> >>> https://csrc.nist.gov/csrc/media/projects/block-cipher-techniques/documents/bcm/comments/800-38-series-drafts/gcm/joux_comments.pdf
> >>
>
> I think I've wrapped my head around this now. Any non-zero return code
> from the hypervisor for an SNP Guest Request is either a hypervisor error
> or an sev-guest driver error, and so the VMPCK should be disabled. The
> sev-guest driver is really doing everything (message headers, performing
> the encryption, etc.) and is only using userspace data that will be part
> of the response message and can't result in a non-zero hypervisor return code.
>
> For the SNP Extended Guest Request, we only need to special case a return
> code of SNP_GUEST_REQ_INVALID_LEN. See below for my responses on that.
>
>
> >> I wonder if we can at least still support the extended report length query
> >> by having the kernel allocate the required pages when the error is
> >> SNP_GUEST_REQ_INVALID_LEN and retry the exact request again. If there are
> >> no errors on the second request, the sequence numbers can be safely
> >> updated, but the kernel returns the original error (which will provide the
> >> caller with the number of pages required).
> >
> > I think we can but I thought fixing the security bug could come first,
> > then the usability fix after. Dionna was planning on working on that
> > fix.
> >
> > In that flow how does userspace get the data? Its called the ioctl
> > with not enough output buffer space. What if the userspace calls the
> > ioctl with no buffers space allocated, so its trying to query the
> > length. We just send the host the request without any encrypted data.
>
> In the case of SNP_GUEST_REQ_INVALID_LEN, userspace wouldn't get the data
> if it hasn't supplied enough buffer space. But, the sev-guest driver can
> supply enough buffer space and invoke the SNP Extended Guest Request again
> in order to successfully complete the call and update the sequence
> numbers. The sev-guest driver would just discard the data in this case,
> but pass back the original "not enough buffer space" error to the caller,
> who could now allocate space and retry. This then allows the sequence
> numbers to be bumped properly.
>

The way I thought to solve this was to make certificate length
querying a part of the specified protocol.

The first ext_guest_request command /must/ query the certificate
buffer length with req.certs_len == 0.
By making this part of the protocol, the sev-guest driver can check if
the certificate length has been requested before.
If so, emulate the host's VMM error code for invalid length without
sending an encrypted message.
If not, then send an all zeroes request buffer with the req.certs_len
= 0 values to the VMM.

The VMM will respond with the size if indeed the expected_pages are >
0. In the case that the host has not set the certificate buffer yet,
then the host will inspect the header of the request page for a zero
sequence number. If so, then we know that we don't have a valid
request. We treat this also as the INVALID_LEN case but still return
the size of 0. The driver will have the expected pages value stored as
0 at this point, so subsequent calls will not have this behavior.

The way /dev/sev-guest user code has been written, I don't think this
will break any existing software package.

> >
> >>
> >> For the rate-limiting patch series [1], the rate-limiting will have to be
> >> performed within the kernel, while the mutex is held, and then retry the
> >> exact request again. Otherwise, that error will require disabling the
> >> VMPCK. Either that, or the hypervisor must provide the rate limiting.
> >>
> >> Thoughts?
> >>
> >> [1] https://lore.kernel.org/lkml/20221013160040.2858732-1-dionnaglaze@google.com/
> >
> > Yes I think if the host rate limits the guest. The guest kernel should
> > retry the exact message. Which mutex are you referring too?
>
> Or the host waits and then submits the request and the guest kernel
> doesn't have to do anything. The mutex I'm referring to is the
> snp_cmd_mutex that is taken in snp_guest_ioctl().

I think that either the host kernel or guest kernel waiting can lead
to unacceptable delays.
I would recommend that we add a zero argument ioctl to /dev/sev-guest
specifically for retrying the last request.

We can know what the last request is due to the sev_cmd_mutex serialization.
The driver will just keep a scratch buffer for this. Any other request
that comes in without resolving the retry will get an -EBUSY error
code.

Calling the retry ioctl without a pending command will result in -EINVAL.

Let me know what you think.
>
> Thanks,
> Tom



-- 
-Dionna Glaze, PhD (she/her)

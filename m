Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DA31605238
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 23:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiJSVrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 17:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiJSVrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 17:47:49 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC979191D49
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:47:47 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id m23so23889073lji.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 14:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yQP9NNXRKqU39bqhIf70VKPrL4R5GSuKkFr6xF4ANdM=;
        b=gR1lcENN0fDNHLQiKcN1npAu5r1Kfc7SqnDjstou+CBGd0LOz8eq46/hnCrGphZH9x
         /JsX10F9PNhYjIcMBCHP1yX/hYR9/jvPCjycDAfl92kx7DL6K7E2zJuaqMiorKbgXZGR
         8olLKlaqEYFuCs5DGpC2VNBrC+B5LPUs+ilUOjh2kwUOaXFkpBPXCfHGFPSBc0MBfDp4
         WWEyENVvn2gPL+kZbVD3x64dJAKEfWoV4imc/EmU3CQiVv7QSFLsW0OmP8OOBaNyTf/V
         8bXoCX2/n7dXRetqkGyKm5h7Hq/djOdNbNQGywUNXK9Dn9NX8gkt/DKNCLLTTOOI8IVi
         bDVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yQP9NNXRKqU39bqhIf70VKPrL4R5GSuKkFr6xF4ANdM=;
        b=yLfsmOBaX/pbC1ikcwVP+os6oRemxKhMsQCH811ZrtaWbGBnalRN4S+1Jcq2Y89Nvz
         +diWbqGpFmwI317X2Jmv3Zwc72PJrbz4tpUEgfzM/0L1vBY+8+QIVyzui6Zu4NGBCww6
         3abHNvzVhE4Acm0TC2fm1l+qRSYavaR28LInNRyD3KJ6kFdTh1XbQFweNBD2fgK+AaBb
         L+kuz1c2etoc9hSrPZIxVdJxVmfAC5VPe2g8sW10+7DlxTC1RHJXhy1BO2HksseolvUx
         KEjaise577phVZXM08KEcQbPT6/ulQO+NPt6nGGM74/ZYWP4OjLqGPk6zwjCxTMKPZ/f
         cjHQ==
X-Gm-Message-State: ACrzQf3RO+TP6BK3nMDTdVopb0r4TJnfYC6eIUkyVT23BupInmiLFpns
        w8XGKMKxw/OL/xJtQGBRmL8eES2nW3keRinPXUO5dw==
X-Google-Smtp-Source: AMsMyM4GdDqKh+7dI8jHyflcaArvn8B2DE5+KoCG8n042l0aw8ASEbqBE3f8rBOWIa7nZf+gAEsUbEMaE3hnY6W38tE=
X-Received: by 2002:a2e:7c17:0:b0:26e:4f7:3c95 with SMTP id
 x23-20020a2e7c17000000b0026e04f73c95mr3817812ljc.455.1666216065809; Wed, 19
 Oct 2022 14:47:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221019150333.1047423-1-pgonda@google.com> <528937ab-8046-d5d1-26ff-50ef35f5635f@amd.com>
 <CAMkAt6ritG1zmOreh9WYLYAGww0EJQy+m-Y0nfxD5+gpTkpJ1w@mail.gmail.com>
 <821e750b-26c9-3331-7577-5cb832a35afa@amd.com> <CAAH4kHYhLkiN7H03GKgMU+3h9rhp2a03gNFGLbrNtjp=PYYHQw@mail.gmail.com>
 <5621c2b6-a5eb-c786-afee-020e97c0e4c8@amd.com> <CAMkAt6pCPmf++Dg=x5bSN4-gR-s7BuYiryOGvGezLupFN9aEKw@mail.gmail.com>
 <948704a4-2348-041f-4f46-bbf42d985549@amd.com>
In-Reply-To: <948704a4-2348-041f-4f46-bbf42d985549@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Wed, 19 Oct 2022 15:47:33 -0600
Message-ID: <CAMkAt6rb-f3qCb7Np-SdHd7u87-zShFpYkWcA910uYXUafqtPQ@mail.gmail.com>
Subject: Re: [PATCH] virt: Prevent AES-GCM IV reuse in SNP guest driver
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        Borislav Petkov <bp@suse.de>,
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

On Wed, Oct 19, 2022 at 2:58 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 10/19/22 15:39, Peter Gonda wrote:
> > On Wed, Oct 19, 2022 at 1:56 PM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> On 10/19/22 14:17, Dionna Amalie Glaze wrote:
> >>> On Wed, Oct 19, 2022 at 11:44 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>
> >>>> On 10/19/22 12:40, Peter Gonda wrote:
> >>>>> On Wed, Oct 19, 2022 at 11:03 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>>>>>
> >>>>>> On 10/19/22 10:03, Peter Gonda wrote:
> >>>>>>> The ASP and an SNP guest use a series of AES-GCM keys called VMPCKs to
> >>>>>>> communicate securely with each other. The IV to this scheme is a
> >>>>>>> sequence number that both the ASP and the guest track. Currently this
> >>>>>>> sequence number in a guest request must exactly match the sequence
> >>>>>>> number tracked by the ASP. This means that if the guest sees an error
> >>>>>>> from the host during a request it can only retry that exact request or
> >>>>>>> disable the VMPCK to prevent an IV reuse. AES-GCM cannot tolerate IV
> >>>>>>> reuse see:
> >>>>>>> https://csrc.nist.gov/csrc/media/projects/block-cipher-techniques/documents/bcm/comments/800-38-series-drafts/gcm/joux_comments.pdf
> >>>>>>
> >>>>
> >>>> I think I've wrapped my head around this now. Any non-zero return code
> >>>> from the hypervisor for an SNP Guest Request is either a hypervisor error
> >>>> or an sev-guest driver error, and so the VMPCK should be disabled. The
> >>>> sev-guest driver is really doing everything (message headers, performing
> >>>> the encryption, etc.) and is only using userspace data that will be part
> >>>> of the response message and can't result in a non-zero hypervisor return code.
> >>>>
> >>>> For the SNP Extended Guest Request, we only need to special case a return
> >>>> code of SNP_GUEST_REQ_INVALID_LEN. See below for my responses on that.
> >>>>
> >>>>
> >>>>>> I wonder if we can at least still support the extended report length query
> >>>>>> by having the kernel allocate the required pages when the error is
> >>>>>> SNP_GUEST_REQ_INVALID_LEN and retry the exact request again. If there are
> >>>>>> no errors on the second request, the sequence numbers can be safely
> >>>>>> updated, but the kernel returns the original error (which will provide the
> >>>>>> caller with the number of pages required).
> >>>>>
> >>>>> I think we can but I thought fixing the security bug could come first,
> >>>>> then the usability fix after. Dionna was planning on working on that
> >>>>> fix.
> >>>>>
> >>>>> In that flow how does userspace get the data? Its called the ioctl
> >>>>> with not enough output buffer space. What if the userspace calls the
> >>>>> ioctl with no buffers space allocated, so its trying to query the
> >>>>> length. We just send the host the request without any encrypted data.
> >>>>
> >>>> In the case of SNP_GUEST_REQ_INVALID_LEN, userspace wouldn't get the data
> >>>> if it hasn't supplied enough buffer space. But, the sev-guest driver can
> >>>> supply enough buffer space and invoke the SNP Extended Guest Request again
> >>>> in order to successfully complete the call and update the sequence
> >>>> numbers. The sev-guest driver would just discard the data in this case,
> >>>> but pass back the original "not enough buffer space" error to the caller,
> >>>> who could now allocate space and retry. This then allows the sequence
> >>>> numbers to be bumped properly.
> >>>>
> >>>
> >>> The way I thought to solve this was to make certificate length
> >>> querying a part of the specified protocol.
> >>>
> >>> The first ext_guest_request command /must/ query the certificate
> >>> buffer length with req.certs_len == 0.
> >>
> >> This becomes an incompatible change to the GHCB specification.
> >>
> >>> By making this part of the protocol, the sev-guest driver can check if
> >>> the certificate length has been requested before.
> >>> If so, emulate the host's VMM error code for invalid length without
> >>> sending an encrypted message.
> >>
> >> On the hypervisor side, the certificate blob can be replaced at any time
> >> with a new blob that is larger. So you may still have to handle the case
> >> where you get a SNP_GUEST_REQ_INVALID_LEN even if you previously asked before.
> >
> > Ah, I forgot the host could keep changing the size of this data.
> >
> >>
> >>> If not, then send an all zeroes request buffer with the req.certs_len
> >>> = 0 values to the VMM.
> >>>
> >>> The VMM will respond with the size if indeed the expected_pages are >
> >>> 0. In the case that the host has not set the certificate buffer yet,
> >>> then the host will inspect the header of the request page for a zero
> >>> sequence number. If so, then we know that we don't have a valid
> >>> request. We treat this also as the INVALID_LEN case but still return
> >>> the size of 0. The driver will have the expected pages value stored as
> >>> 0 at this point, so subsequent calls will not have this behavior.
> >>>
> >>> The way /dev/sev-guest user code has been written, I don't think this
> >>> will break any existing software package.
> >>
> >> I think having the sev-guest driver re-issue the request with the internal
> >> buffer when it receives SNP_GUEST_REQ_INVALID_LEN is the better way to go.
> >> You could still cache the size request and always return that to
> >> user-space when a request is received with a 0 length. The user-space
> >> program must be able to handle receiving multiple
> >> SNP_GUEST_REQ_INVALID_LEN in succession anyway, because of the fact that
> >> the hypervisor can be updating the certs asynchronously. And if you get a
> >> request that is not 0 length, then you issue it as such and re-use the
> >> logic of the first 0 length request that was received if you get an
> >> SNP_GUEST_REQ_INVALID_LEN with the user-space supplied value.
> >>
> >> Peter, is this something you could change the patch to do?
> >
> > OK so the guest retires with the same request when it gets an
> > SNP_GUEST_REQ_INVALID_LEN error. It expands its internal buffer to
>
> It would just use the pre-allocated snp_dev->certs_data buffer with npages
> set to the full size of that buffer.

Actually we allocate that buffer with size SEV_FW_BLOB_MAX_SIZE. Maybe
we want to just allocate this buffer which we think is sufficient and
never increase the allocation?

I see the size of
https://developer.amd.com/wp-content/resources/ask_ark_milan.cert is
3200 bytes. Assuming the VCEK cert is the same size (which it should
be since this .cert is 2 certificates). 16K seems to leave enough room
even for some vendor certificates?

>
> > hold the certificates. When it finally gets a successful request w/
> > certs. Do we want to return the attestation bits to userspace, but
> > leave out the certificate data. Or just error out the ioctl
> > completely?
>
> We need to be able to return the attestation bits that came back with the
> extra certs. So just error out of the ioctl with the length error and let
> user-space retry with the recommended number of pages.

That sounded simpler to me. Will do.

>
> >
> > I can do that in this series.
>
> Thanks!
>
> >
> >>
> >>>
> >>>>>
> >>>>>>
> >>>>>> For the rate-limiting patch series [1], the rate-limiting will have to be
> >>>>>> performed within the kernel, while the mutex is held, and then retry the
> >>>>>> exact request again. Otherwise, that error will require disabling the
> >>>>>> VMPCK. Either that, or the hypervisor must provide the rate limiting.
> >>>>>>
> >>>>>> Thoughts?
> >>>>>>
> >>>>>> [1] https://lore.kernel.org/lkml/20221013160040.2858732-1-dionnaglaze@google.com/
> >>>>>
> >>>>> Yes I think if the host rate limits the guest. The guest kernel should
> >>>>> retry the exact message. Which mutex are you referring too?
> >>>>
> >>>> Or the host waits and then submits the request and the guest kernel
> >>>> doesn't have to do anything. The mutex I'm referring to is the
> >>>> snp_cmd_mutex that is taken in snp_guest_ioctl().
> >>>
> >>> I think that either the host kernel or guest kernel waiting can lead
> >>> to unacceptable delays.
> >>> I would recommend that we add a zero argument ioctl to /dev/sev-guest
> >>> specifically for retrying the last request.
> >>>
> >>> We can know what the last request is due to the sev_cmd_mutex serialization.
> >>> The driver will just keep a scratch buffer for this. Any other request
> >>> that comes in without resolving the retry will get an -EBUSY error
> >>> code.
> >>
> >> And the first caller will have received an -EAGAIN in order to
> >> differentiate between the two situations?
> >>
> >>>
> >>> Calling the retry ioctl without a pending command will result in -EINVAL.
> >>>
> >>> Let me know what you think.
> >>
> >> I think that sounds reasonable, but there are some catches. You will need
> >> to ensure that the caller that is supposed to retry does actually retry
> >> and that a caller that does retry is the same caller that was told to retry.
> >
> > Whats the issue with the guest driver taking some time?
> >
> > This sounds complex because there may be many users of the driver. How
> > do multiple users coordinate when they need to use the retry ioctl?
> >
> >>
> >> Thanks,
> >> Tom
> >>
> >>>>
> >>>> Thanks,
> >>>> Tom
> >>>
> >>>
> >>>

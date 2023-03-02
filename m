Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840006A84A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 15:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjCBOuZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 09:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjCBOt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 09:49:57 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D838555067
        for <linux-kernel@vger.kernel.org>; Thu,  2 Mar 2023 06:48:49 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id s20so22375790lfb.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Mar 2023 06:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6tr00e30sdrmL25/YaU7XMmA2bvhntyFXqkLTVrQw8Y=;
        b=CT6e0MwG0aAVtxLeyNuhTxcp3zHVaC5iGbTfnapJqgMJwBKPELhSzM/DkF8Ly4Xhd5
         jW8YJ0PNZgSUL/PE4d6S/rwvsywqxg4/17IyHC09PGdRShD+siQzNMTbw4yZdcgpsIxP
         L3UXcef5D5VE+ofAIY+CI09fTvo/tm0xR86N4S5KapLOUJO32h+ndRfGDQPfKsotCnJ4
         7aBA149ebM2WfGGzR8q3VqxL6N62bywBcfkXKIESycMOwkFQZyWEooqrYx7T0l2oNArV
         IxhU6hKiYGPB1KVwsGZhNgS0AagWUPP97Wc6oM5rc9UYoLir8IIBb0TVYaXNMJvhOKC4
         fAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6tr00e30sdrmL25/YaU7XMmA2bvhntyFXqkLTVrQw8Y=;
        b=xBZH6Phw8ClchgA6OeSsuQvEsZa935X1wxryYRRttVHSp2HtJgGOe5cDLcE9LKqZIM
         hPQoIPPEvP6y0jYiKQ6AxJjqDlzE4TdSc+neMNbk5zoF+9EX1RkOA04iRILme/VG4WkY
         3KktBB8HIDIg7KzrJ/dMi33wIwnOVf2IInYaSP9bLHuPc5SzoBZP3S4vrEuQxTYPJrL9
         vGCwoTbsL6G85waBWq7hL8cFPlwIX+rfp1a2Ymwh3ZpqZkddkDWVX3NWlureGtMYZCrM
         vbgU7dmnxpKDDKThv9kVBGNGHe1H/Mx617l7dvCdgvc7afjVSrYKqQO9b3x3WLxrmpjK
         zDLg==
X-Gm-Message-State: AO0yUKWY3cZF1kgpm/eUOVTNZQnpK0CJi2cGN598/HrnN2fzL6PoLBFR
        FK9o7WLnHsokLdto/04rKYYp2Qf5Zl179QAFQOgsTA==
X-Google-Smtp-Source: AK7set+SP0SKkzcxlY+93oVXphgx6/hSTB/cvsVf4JfBUwuZ+LDW7LCkBmCVlKdCJio0iIf9cGqXVgdFAZxgptXXGMk=
X-Received: by 2002:a19:550b:0:b0:4dd:a347:2146 with SMTP id
 n11-20020a19550b000000b004dda3472146mr3134923lfe.0.1677768518087; Thu, 02 Mar
 2023 06:48:38 -0800 (PST)
MIME-Version: 1.0
References: <2afbcae6daf13f7ad5a4296692e0a0fe1bc1e4ee.1677083979.git.thomas.lendacky@amd.com>
 <CAMkAt6pqyOqVd_etLVfwrihEoc6XtS+BaVsV8x934rr4LmOCgw@mail.gmail.com> <0c3a11bb-9036-2067-bf73-d18bb55c1225@amd.com>
In-Reply-To: <0c3a11bb-9036-2067-bf73-d18bb55c1225@amd.com>
From:   Peter Gonda <pgonda@google.com>
Date:   Thu, 2 Mar 2023 07:48:26 -0700
Message-ID: <CAMkAt6q=3TZ5YKGkxqdzcakp8wudU9QNUtc5u35CCZj7HKNu8g@mail.gmail.com>
Subject: Re: [RESEND PATCH] virt/sev-guest: Return -EIO if certificate buffer
 is not large enough
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Larry Dewey <larry.dewey@amd.com>
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

On Thu, Feb 23, 2023 at 9:14 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
>
> On 2/22/23 10:51, Peter Gonda wrote:
> > On Wed, Feb 22, 2023 at 9:39 AM Tom Lendacky <thomas.lendacky@amd.com> wrote:
> >>
> >> Commit 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest
> >> driver") changed the behavior associated with the return value when the
> >> caller does not supply a large enough certificate buffer. Prior to the
> >> commit a return value of -EIO was returned. Now a return value of 0 is
> >> returned. This breaks the established ABI with the user.
> >>
> >> Change the code to detect the buffer size error and return -EIO.
> >>
> >> Fixes: 47894e0fa6a5 ("virt/sev-guest: Prevent IV reuse in the SNP guest driver")
> >> Reported-by: Larry Dewey <larry.dewey@amd.com>
> >> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>

Reviewed-by: Peter Gonda <pgonda@google.com>

> >
> > My bad. I wasn't testing the return value in this case.
> >
> > Should Boris take this patch into the retry series?
> >
> >> ---
> >>   drivers/virt/coco/sev-guest/sev-guest.c | 20 +++++++++++++++++---
> >>   1 file changed, 17 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
> >> index 4ec4174e05a3..7b4e9009f335 100644
> >> --- a/drivers/virt/coco/sev-guest/sev-guest.c
> >> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
> >> @@ -377,9 +377,26 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
> >>                  snp_dev->input.data_npages = certs_npages;
> >>          }
> >>
> >> +       /*
> >> +        * Increment the message sequence number. There is no harm in doing
> >> +        * this now because decryption uses the value stored in the response
> >> +        * structure and any failure will wipe the VMPCK, preventing further
> >> +        * use anyway.
> >> +        */
> >> +       snp_inc_msg_seqno(snp_dev);
> >> +
> >>          if (fw_err)
> >>                  *fw_err = err;
> >>
> >> +       /*
> >> +        * If an extended guest request was issued and the supplied certificate
> >> +        * buffer was not large enough, a standard guest request was issued to
> >> +        * prevent IV reuse. If the standard request was successful, return -EIO
> >> +        * back to the caller as would have originally been returned.
> >> +        */
> >> +       if (!rc && err == SNP_GUEST_REQ_INVALID_LEN)
> >> +               return -EIO;
> >> +
> >
> > Why not set 'ret = -EIO' and use disable_vmpck directly? That seems
> > more clear to me instead of failing on the next call.
>
> We don't want to disable the VMPCK for this. This should go back to
> userspace with EIO and SNP_GUEST_REQ_INVALID_LEN, as it did prior to
> 47894e0fa6a5. Userspace then allocates a larger buffer and re-issues the
> request which should now succeed.

Ah, I got it. Thanks Tom.



>
> Thanks,
> Tom
>
> >
> >>          if (rc) {
> >>                  dev_alert(snp_dev->dev,
> >>                            "Detected error from ASP request. rc: %d, fw_err: %llu\n",
> >> @@ -395,9 +412,6 @@ static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, in
> >>                  goto disable_vmpck;
> >>          }
> >>
> >> -       /* Increment to new message sequence after payload decryption was successful. */
> >> -       snp_inc_msg_seqno(snp_dev);
> >> -
> >>          return 0;
> >>
> >>   disable_vmpck:
> >> --
> >> 2.39.1
> >>

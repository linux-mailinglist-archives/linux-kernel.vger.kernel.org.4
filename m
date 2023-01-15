Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCA566AF31
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 04:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjAODFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 22:05:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjAODFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 22:05:17 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D6A260
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 19:05:16 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id w14so19089982edi.5
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 19:05:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EH090np8Bxqv0c4tiln2a2Jkj01lR68xoqEAzkjHOQs=;
        b=ADqrq2bRHD6bWqlePVTckbpGSwn1Q/L9k+JpMyRf7MJmd9aqHCPYFvAewGitMOfTMS
         jMrmVjmTDrObohAP2QJP2ISuLbcMJpir7gLp5tI9dxFSydo4Nx/sBbGJYMKOwyZWDGaP
         /OOjUjSAfOwZhlfclxO9MjB33uTEZx9Iv07HoSDn0qP6FlSxYsN5E+M+dM5N+389NAC5
         9V11RsxEuqBMDrIaIZgcS5NDk8uz6Vp85KzrffjjtTUszeWrCz9KE8v+/i9WlIyCzy6T
         m/gfPEaTjq2u9GmIexjSWI7mldtYbP13kWwpGFjqND+VkCxbltXTxPRDlIG51uIp7uDw
         fQNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EH090np8Bxqv0c4tiln2a2Jkj01lR68xoqEAzkjHOQs=;
        b=Ct23DUoKsOF7tJXRJs9ZhDz7Nylvq/T3ECjJ7PPVUWlqTTzr3zs4zHg3nUSoQOkG7W
         YvMbYRlIx/sRLChCeKnOdO/UgfO5+6O5y5eNIwHocfBp97+fkVc6VlwqDUYGaYtvwEV5
         oSFtEirUFJF5cfGOJSawxKoA584ezVcFD0uUtKVLmnT3HI7WceQS5ZVdrAcYuSbIvH1/
         pZFZSqvD97oG0tiRWS4eZfgrq+0UhH/eCwC5lHNHpXXwRbrgZHt6T4kXKhnAbYbu92/h
         yPCKGJjdDvEGPU45zO6scgaJqO8suz9spj6DC40ORaF7TCz4i4DT67qjEUUeQ3v2oovd
         spsA==
X-Gm-Message-State: AFqh2krYduNy+BOf0ivyJzn+sdNzI/3rnRuOIJ9GL3WF/ILTPEMAlrUA
        zR9V+X0AhG/zfFA4e4yQax9YHjHCVnf2WtlfhEhpiQ==
X-Google-Smtp-Source: AMrXdXt99fPJ3tuWP1S7jqBQHH6YawIC5z8VL4T14v8EEC2myfyKRNQoUMIRdXgGM6xQZqt+5+wm5zu4U6bFHkl8Tx8=
X-Received: by 2002:a05:6402:6d9:b0:499:7efc:1d78 with SMTP id
 n25-20020a05640206d900b004997efc1d78mr2170774edy.81.1673751914709; Sat, 14
 Jan 2023 19:05:14 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.3.I9ded8c8caad27403e9284dfc78ad6cbd845bc98d@changeid>
 <8ae56656a461d7b957b93778d716c6161070383a.camel@linux.ibm.com>
 <CAHSSk06sH6Ck11R7k8Pk_30KbzLzZVdBdj5MpsNfY-R_1kt_dA@mail.gmail.com>
 <CAFftDdqUOiysgrAC4wPUXRaEWz4j9V6na3u4bm29AfxE8TAyXw@mail.gmail.com>
 <CAHSSk04asd_ac8KLJYNRyR1Z+fD+iUb+UxjUu0U=HbT1-2R7Ag@mail.gmail.com> <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
In-Reply-To: <08302ed1c056da86a71aa2e6ca19111075383e75.camel@linux.ibm.com>
From:   Matthew Garrett <mgarrett@aurora.tech>
Date:   Sat, 14 Jan 2023 19:05:03 -0800
Message-ID: <CAHSSk058UoBY2nDx8U7-siG_dbjNSKZaPukZVjSnq=f=CBSKsw@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] tpm: Allow PCR 23 to be restricted to
 kernel-only use
To:     jejb@linux.ibm.com
Cc:     William Roberts <bill.c.roberts@gmail.com>,
        Evan Green <evgreen@chromium.org>,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        linux-integrity@vger.kernel.org,
        Eric Biggers <ebiggers@kernel.org>, gwendal@chromium.org,
        dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com, jarkko@kernel.org,
        linux-pm@vger.kernel.org, Matthew Garrett <mjg59@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Huewe <peterhuewe@gmx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 14, 2023 at 6:55 AM James Bottomley <jejb@linux.ibm.com> wrote:
> Can we go back again to why you can't use locality?  It's exactly
> designed for this since locality is part of creation data.  Currently
> everything only uses locality 0, so it's impossible for anyone on Linux
> to produce a key with anything other than 0 in the creation data for
> locality.  However, the dynamic launch people are proposing that the
> Kernel should use Locality 2 for all its operations, which would allow
> you to distinguish a key created by the kernel from one created by a
> user by locality.
>
> I think the previous objection was that not all TPMs implement
> locality, but then not all laptops have TPMs either, so if you ever
> come across one which has a TPM but no locality, it's in a very similar
> security boat to one which has no TPM.

It's not a question of TPM support, it's a question of platform
support. Intel chipsets that don't support TXT simply don't forward
requests with non-0 locality. Every Windows-sticker laptop since 2014
has shipped with a TPM, but the number that ship with TXT support is a
very small percentage of that. I agree that locality is the obvious
solution for a whole bunch of problems, but it's just not usable in
the generic case.

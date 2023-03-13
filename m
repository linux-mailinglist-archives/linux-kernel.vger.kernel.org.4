Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5876B7273
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjCMJZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMJZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:25:25 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36DC26CEE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:25:23 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bh21-20020a05600c3d1500b003ed1ff06fb0so1923823wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678699522;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oemU04S4EIP3+LlbdYWaEi24KjHjlI+DFXxErUigKSs=;
        b=dG/46LCuvRBvtVi36X1zuQFs1B1+6cl4Nn4twthBIRfmVSGE51QUZ+Lr26zlcxlrHI
         nX5aqfJ9MKdJ9HG0zlFsGpfjvYSwT9eCZDK5RBtf6coGRlgY7JBRDc/joHsaQU/6eueh
         VePFZQXWzOFuZHAhv1eCOzkp79DyfIvjmwcQk86molONkUp2QIOgTg+YOMzEcYzlQrcM
         1ru0hBZnCuTiM/s30OaaxSp/4waWQ2XEVKX9WvXj7uirt9ndFAHA8oIuAIuEXNOg0TFE
         znVJyxLSj3a8fEkkNY3tcIxyV+vN7PBGfMxbB9nQveK5slcXUci16YcCKQ4MZiwRqhKs
         cnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678699522;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oemU04S4EIP3+LlbdYWaEi24KjHjlI+DFXxErUigKSs=;
        b=YevrXzPFMmwVoFO1IJ4CbAst4hjzrlX1i8gbs9TBSuuhCxwHxQ1kt2iYC0AGItLE/p
         CPA1oFMqLwbC5xmQuPbTR0Wnqisx/68EdFVG84rtV7X0jgc701EstQ4Uyqe7hzltH1HR
         6m0ex2KyHOaAa2YoZ1CYtvXvs4d246hQVzZO9xVHX0n90fhlISFpyRkOPUNYE+fr+ssl
         x4YR9dCuyhR76TlfK8wkbAVQ7CTty2L75Lj54GaMT2ddpSmZEWrbwi+8671lRMRPpmDy
         LOowXe/i+BCPHwr0tN8GnI2ijizCMuxTaH/3mRV4EeHv0+zYI+LMtFD4HkhbH1zqD44+
         k81Q==
X-Gm-Message-State: AO0yUKWfvsfuLPbGeHRl6TN3GBtca5REOxyNAo1KvGFRCDC1o4jL0/3d
        iR7bTgf2GE10piTncdCnC4M=
X-Google-Smtp-Source: AK7set/j5QmRFkSepULMGjz536Oure7syuY0MABWMX+Gi9mSeJR9sE37XxrnMeeIrriz3umn1wuWdA==
X-Received: by 2002:a05:600c:a4c:b0:3dc:d5c:76d9 with SMTP id c12-20020a05600c0a4c00b003dc0d5c76d9mr10913475wmq.0.1678699521970;
        Mon, 13 Mar 2023 02:25:21 -0700 (PDT)
Received: from localhost ([2001:b07:5d37:537d:cd23:cd6e:ae14:44fe])
        by smtp.gmail.com with ESMTPSA id m8-20020a05600c4f4800b003db01178b62sm9181086wmq.40.2023.03.13.02.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 02:25:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Mar 2023 10:25:19 +0100
Message-Id: <CR55BD4YCDR1.22R5TLYJW6YS0@vincent-arch>
Subject: Re: [RFC PATCH v1 1/1] linux: mm_types: allow to modified the
 vm_flags in vm_area_struct
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Andrew Morton" <akpm@linux-foundation.org>
Cc:     <linux-kernel@vger.kernel.org>, <jgg@ziepe.ca>,
        <Liam.Howlett@oracle.com>, <jhubbard@nvidia.com>,
        <david@redhat.com>, <willy@infradead.org>,
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        "Suren Baghdasaryan" <surenb@google.com>
X-Mailer: aerc 0.14.0
References: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
 <20230312175703.d8d8e0192387dfa9592ee8e5@linux-foundation.org>
In-Reply-To: <20230312175703.d8d8e0192387dfa9592ee8e5@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Mar 13, 2023 at 1:57 AM CET, Andrew Morton wrote:
> On Sun, 12 Mar 2023 23:42:50 +0100 Vincenzo Palazzo <vincenzopalazzodev@g=
mail.com> wrote:
>
> > With 6.3-rc1 is not possible to build the following drivers
>
> Well, let's cc Suren who actually wrote bc292ab00f6c ("mm: introduce
> vma->vm_flags wrapper functions").
>
> > - nvidia, that the compilation returns the following errors
> >=20
> > - vboxhost/7.0.6_OSE where the build fails with the following errors
> >=20
> > ...
> >
> > --- a/include/linux/mm_types.h
> > +++ b/include/linux/mm_types.h
> > @@ -497,7 +497,7 @@ struct vm_area_struct {
> >  	 * To modify use vm_flags_{init|reset|set|clear|mod} functions.
> >  	 */
> >  	union {
> > -		const vm_flags_t vm_flags;
> > +		vm_flags_t vm_flags;
> >  		vm_flags_t __private __vm_flags;
> >  	};
>
> These out-of-tree drivers should be converted to use the wrappers which
> bc292ab00f6c added.  Their maintainers have a couple of months to do
> this before bc292ab00f6c is released in 6.3.

Yeah I thought about that! nvidia update as soon as the 6.3 is out, not sur=
e
about vboxhost. But let the driver update to this new feature make sense.

>
> It's unfortunate.  I guess it would be better if we were to find a way
> to permit these drivers to compile OK but to generate warnings, as an
> interim thing for six months or so.  Perhaps there's some clever way.

Yeah it is! Regarding giving the possiblity to compile ok (and
preserving the previous behavior) look like an interesting thought for=20
kernel API, but am I think that it this is difficult to do?

The real things that I'm missing with the new wrapper API
is the meaning of the new `vm_flags_t vm_flags`, before the=20
field was only one and it was getting modified, but now the real
value is the private one `__vm_flags`, so what is the meaning of=20
the new `vm_flags`?

I feel that this question is stupid but I can not avoid do it, otherwise=20
my mind think about it till I will not find an answer :)

P.S: regaring the warning at compile time the __deprecated looks a good
fit to generate error message, but to me in this particular case do not.

Thanks,

Vincent.


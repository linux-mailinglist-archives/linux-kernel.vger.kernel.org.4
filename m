Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9CF26B302F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 23:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230370AbjCIWFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 17:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjCIWEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 17:04:49 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B65AE8AA9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:04:43 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z11so2463231pfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 14:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1678399482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TecKA/qLSHNqUo87Vcc7qjzuRFiAfxthOVOs0V+b0QM=;
        b=B/ifo454RThSbwsVJ1GiBxsO5yR0YgC0QC8xCrJPI+zw/5vKzpZV1K+3D7eENg9Wsy
         NhM4rCbxaG+Lyfoo0bx+IQiPsmsPor9J52RV4wdVYji2kDxCGlrgBH6gAn5rHatZaZvn
         IrmgDfkgCnX4VQgzpiTR3UdvFawHccoownBfvGk+fkWO3p8QhM/EUn38nsGj3bqAoHrM
         EBu6GEwkP1B5t0E2+UxhfOzRVKkwGD0RXQq1SitNmj400OqF7EQ60JSX41H/WOdgKLm8
         uBDloVEVY8ScotG0HkCdRT88uRgKKOMDrBvcKBUgrtmv4C6uYHu/E/Fxxh9H1PYBnoeh
         iQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678399482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TecKA/qLSHNqUo87Vcc7qjzuRFiAfxthOVOs0V+b0QM=;
        b=RK4en5bIxNm9aG6wllZr/OruPUMKnfheEmbgaaW2KMH+wa3DmLM+27PtwNP8m83F4/
         CriHvpDGIOg7Twjp5B6bjDJSIgDgDoB4jt/WZnd3MEn8vqhdAZbp/xVGwUFZylBX8Y7k
         6g+h5nDIg5fntJF0kvAIX8O9S140jEg8960ea3AWbpVM01nemwvPdQHv3wI2npcnCTEX
         NsAWmJHG0pK7NA+uDP9MQVFVZ5ywZF0LkIiCsmCGkpIX9+95MAjK4YokRjB0FH6+hsDg
         QOOQxCaX0xWohhedFgUQDzRg1G0FfhzEarm7W5TMR+DPfCyMFhhUgfEj1yA4BHsMuCn0
         7oKA==
X-Gm-Message-State: AO0yUKWx1VTrF4qwbMCpnk5Vp4g924LiLVJfMIoFGIEsTzVk9vtLBsOq
        LEXus0xqxom/jdsAk2I6G/idpn5rLggFnWD7u5e3
X-Google-Smtp-Source: AK7set8bKYOJHSfTo3V36f2sVcFEqHiyfmKQ2F1unir5j8GMf0wWI3fvuuhPCS9zXNc+lm8Vuuq+UCQ/qTAM7wPhaDU=
X-Received: by 2002:a05:6a00:14d6:b0:5aa:310c:e65b with SMTP id
 w22-20020a056a0014d600b005aa310ce65bmr10450213pfu.2.1678399482624; Thu, 09
 Mar 2023 14:04:42 -0800 (PST)
MIME-Version: 1.0
References: <20230309085433.1810314-1-roberto.sassu@huaweicloud.com>
 <20230309085433.1810314-2-roberto.sassu@huaweicloud.com> <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
In-Reply-To: <397cb437bbd41e7eb223a07bc92a10bb57df696e.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 9 Mar 2023 17:04:31 -0500
Message-ID: <CAHC9VhTt7xZqkfZQsWVLRHzza_9idzxkY7bXxzBMq=Xxfc6+Cg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] security: Introduce LSM_ORDER_LAST and set it for
 the integrity LSM
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        mic@digikod.net, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 9, 2023 at 8:21=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com> wro=
te:
> On Thu, 2023-03-09 at 09:54 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >
> > Introduce LSM_ORDER_LAST, to satisfy the requirement of LSMs needing to=
 be
> > last, e.g. the 'integrity' LSM, without changing the kernel command lin=
e or
> > configuration.
> >
> > Also, set this order for the 'integrity' LSM. While not enforced, this =
is
> > the only LSM expected to use it.
> >
> > Similarly to LSM_ORDER_FIRST, LSMs with LSM_ORDER_LAST are always enabl=
ed
> > and put at the end of the LSM list.
> >
> > Finally, for LSM_ORDER_MUTABLE LSMs, set the found variable to true if =
an
> > LSM is found, regardless of its order. In this way, the kernel would no=
t
> > wrongly report that the LSM is not built-in in the kernel if its order =
is
> > LSM_ORDER_LAST.
> >
> > Fixes: 79f7865d844c ("LSM: Introduce "lsm=3D" for boottime LSM selectio=
n")
> > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

Warning: procedural nitpicking ahead ...

The 'Signed-off-by' tag is in reference to the DCO, which makes sense
to add if you are a patch author or are merging a patch into a tree,
but it doesn't make much sense as a ACK/thumbs-up; this is why we have
the 'Acked-by' and 'Reviewed-by' tags.  I generally read the
'Acked-by' tag as "I'm the one responsible for a chunk of code
affected by this patch and I'm okay with this change" and the
'Reviewed-by' tag as "I looked at this patch and it looks like a good
change to me".  Perhaps surprisingly to some, while an 'Acked-by' is a
requirement for merging in a lot of cases, I appreciate 'Reviewed-by'
tags much more as it indicates the patch is getting some third-part
eyeballs on it ... so all you lurkers on this list, if you're
reviewing patches as they hit your inbox, don't be shy about posting
your 'Reviewed-by' tag if your comfortable doing so, we all welcome
the help :)

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#sign=
-your-work-the-developer-s-certificate-of-origin

--=20
paul-moore.com

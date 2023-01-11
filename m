Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC008665DE3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbjAKO2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239596AbjAKO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:27:42 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CC61EED0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:26:08 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y1so16952812plb.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:26:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j0t2bn4nZtdh7DYNiHghgOiJ5/dQ9do1qFUNd17Ho0Q=;
        b=Gy4Mryka1zuuoKtaVN8MVkw7dRGJo1zKk8dXXcAaFhsufGRUkcyaoY9eEylCpjBRoA
         tc9oSd+PPBOUqYbDEv3hZKPjcdo0RESO3HlfLycCfVqINLxYWX90Pw0nnC0gLLS1Lkcr
         c8EEaRcUHhd+/RBgerhwWCc2y/KbqpucELD83s89s40YDId/3CuVFxAqasNQJAzY7rz/
         zZJCROGm5h4+YlAL9YviW/7Oor0mkuUi8vKBd09fFQtcmcO3oAAcpRX3XABhJr5a0NdI
         jU4Cbvcyh3hhX0Q3f8XfLMU5lGqBjEtJ7/dRxSIgdJBHr4XdJio8fEs7VP7qh0EOLd9l
         g5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j0t2bn4nZtdh7DYNiHghgOiJ5/dQ9do1qFUNd17Ho0Q=;
        b=t5QC75xsogwRcdsB87Zq0tY5jBBWh30/Csvte9lcVE3vLDRmE1tOySU10sXVc4OJv8
         Vq39c/ppMkPrsDQNW08ZbjB+3lBsZrFLBVarGrq5SOnDFY/paF+Ip9oXt9tF6/4Nqefu
         VDskMqcHPaC0yLbxoW0D2xitFz/Q4X+HAh4L+wcW1XfQMVQAO9Z5VMbbgqBekkUdSB7o
         os74L8FgQZ1+Sy2sl9qNsaLy4dIzKFt0ygM7c1x0tBQIVUNuj6Jlw4AON+CChlD9ydeY
         brJpiDFwkZFk7VeYqT6Xg2wlHR8qS2L1gA8vso/Eay5+uxyBCReQvI2ZP//ItAckjVMF
         vcWA==
X-Gm-Message-State: AFqh2koliYPgPwJzLzFbK/jegIJNOwvX9JOat7y39EgNn9J5dzkVAFJY
        vO6UdOt6NcoweyCTyF9lx+Q+6atPfAeqU/W69hl8
X-Google-Smtp-Source: AMrXdXtesEwVv45pauhHUrlC1hMdCovkRhk98mmpCmIArBxsYtbrASQb9FOY34shKM97pdStAwTTTawAfp1LlKVzuZY=
X-Received: by 2002:a17:902:7d83:b0:193:2c1b:3371 with SMTP id
 a3-20020a1709027d8300b001932c1b3371mr1314817plm.56.1673447168187; Wed, 11 Jan
 2023 06:26:08 -0800 (PST)
MIME-Version: 1.0
References: <20221221141007.2579770-1-roberto.sassu@huaweicloud.com>
 <CAHC9VhQUAuF-Fan72j7BOqOdLE=B=mJpJ_GpR5p5cUmXruYT=Q@mail.gmail.com> <4b8688ee3d533d989196004d5f9f2c7eb4093f8b.camel@huaweicloud.com>
In-Reply-To: <4b8688ee3d533d989196004d5f9f2c7eb4093f8b.camel@huaweicloud.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 11 Jan 2023 09:25:56 -0500
Message-ID: <CAHC9VhSamRVpgrDrSuc2dsbbw3-pvjDi9BsFWoWssHkAD2W5vA@mail.gmail.com>
Subject: Re: [PATCH v2] security: Restore passing final prot to ima_file_mmap()
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc:     zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 4:31 AM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> On Fri, 2023-01-06 at 16:14 -0500, Paul Moore wrote:
> > On Wed, Dec 21, 2022 at 9:10 AM Roberto Sassu
> > <roberto.sassu@huaweicloud.com> wrote:
> > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > >
> > > Commit 98de59bfe4b2f ("take calculation of final prot in
> > > security_mmap_file() into a helper") moved the code to update prot with the
> > > actual protection flags to be granted to the requestor by the kernel to a
> > > helper called mmap_prot(). However, the patch didn't update the argument
> > > passed to ima_file_mmap(), making it receive the requested prot instead of
> > > the final computed prot.
> > >
> > > A possible consequence is that files mmapped as executable might not be
> > > measured/appraised if PROT_EXEC is not requested but subsequently added in
> > > the final prot.
> > >
> > > Replace prot with mmap_prot(file, prot) as the second argument of
> > > ima_file_mmap() to restore the original behavior.
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: 98de59bfe4b2 ("take calculation of final prot in security_mmap_file() into a helper")
> > > Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> > > ---
> > >  security/security.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/security/security.c b/security/security.c
> > > index d1571900a8c7..0d2359d588a1 100644
> > > --- a/security/security.c
> > > +++ b/security/security.c
> > > @@ -1666,7 +1666,7 @@ int security_mmap_file(struct file *file, unsigned long prot,
> > >                                         mmap_prot(file, prot), flags);
> > >         if (ret)
> > >                 return ret;
> > > -       return ima_file_mmap(file, prot);
> > > +       return ima_file_mmap(file, mmap_prot(file, prot));
> > >  }
> >
> > This seems like a reasonable fix, although as the original commit is
> > ~10 years old at this point I am a little concerned about the impact
> > this might have on IMA.  Mimi, what do you think?
> >
> > Beyond that, my only other comment would be to only call mmap_prot()
> > once and cache the results in a local variable.  You could also fix up
> > some of the ugly indentation crimes in security_mmap_file() while you
> > are at it, e.g. something like this:
>
> Hi Paul
>
> thanks for the comments. With the patch set to move IMA and EVM to the
> LSM infrastructure we will be back to calling mmap_prot() only once,
> but I guess we could do anyway, as the patch (if accepted) would be
> likely backported to stable kernels.

I think there is value in fixing this now and keeping it separate from
the IMA-to-LSM work as they really are disjoint.

-- 
paul-moore.com

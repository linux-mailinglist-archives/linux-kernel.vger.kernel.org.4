Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A517762A47A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiKOVsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:48:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiKOVsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:48:45 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6290AB4AC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:48:42 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id s24so19364928ljs.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 13:48:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XChCKSa55RQw6aM9/4oFMt9X2omy2D4G5ZLlpjkEFO4=;
        b=RyWCXB6UCoN1qux5VOCmOhwPaRc0OmJOOlnYaLt4N+f00XTtQ3g7RtRIcknQlcwpki
         L/wWD/URypy9LdYt4NbRp2XvFEkmSKpWGPojY4Woop3Kr6cnhFG3M4ziG6eM2x7Ee57f
         0n1AcsrB+XShanoYsjjxQC+NlsBT/dUFk+vaNRNHvuYN+uhIRCXeSJ3iU2ZOmoV+UvC8
         G4B6yvTIVXSWJWWLZFJJzg8yoyshOgxADu8QwWlP1vm4iBgkWlDxhW+uXmYZkbUbOqFZ
         GpJZ/KD3auYO9TadQ3c1GcRFgBGbHlnqIF9ue8cd9GWVJI1DdfALsL+KZ1jqDpPC2w7M
         y4Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XChCKSa55RQw6aM9/4oFMt9X2omy2D4G5ZLlpjkEFO4=;
        b=Zt/OTm7V+R4l+ZQYPgDHO37HCKKQi61zWWyWZrHZYuXtpCA6+pHZEa2rWuBZhk7mfq
         KyD+OAviR3wDXfgnN/PFI2mMQEKT8p3XohXnv27u3gUuzO0gwlEUZt1r5nUcofN/WQPr
         RfhZYrajTfB45KIIMLfAmwQ6/GGMr5brPbKe9d+YMyV/Rhyyl9XwGR307oDec0c7INRy
         zWEddHsUnnvm560dKNvvvyjDZ2/7Qu/13c4tde81dCkTboQ2LLdXeErS1KNsTb6sCXWr
         RjlQBEuYb2iEeAAGvYV4MOWh97KSiU0pzwENnZML8M011Mexxo7X7ourvZD4H6140fGw
         aouA==
X-Gm-Message-State: ANoB5pnCr9UgtwU8ccLiR4asP16Ku7EqFliFZ/uPIvH+nk2aHcdVH4vo
        qYQvFy2qZvjPTbvq+944x4kZWGrH06XWINkgDXt3KQ==
X-Google-Smtp-Source: AA0mqf61z8RzseM7p7vQjqsEmE4nVk/t9E4uhyLhP3ph+ffPsM9rsTu/w7loWNxS9duZEsoJDENrCJnoXc5XJD6/6pw=
X-Received: by 2002:a2e:9c59:0:b0:26f:dfb2:9bfd with SMTP id
 t25-20020a2e9c59000000b0026fdfb29bfdmr7176265ljj.455.1668548920546; Tue, 15
 Nov 2022 13:48:40 -0800 (PST)
MIME-Version: 1.0
References: <20221103152318.88354-1-pgonda@google.com> <Y258U+8oF/eo14U+@zn.tnic>
 <CAMkAt6p2zXnE-ew+pJk_UpZAEFZFdCOPThNn3hSFqYOQG81t-g@mail.gmail.com> <Y3QGUb0TVd2M9qow@zn.tnic>
In-Reply-To: <Y3QGUb0TVd2M9qow@zn.tnic>
From:   Peter Gonda <pgonda@google.com>
Date:   Tue, 15 Nov 2022 14:48:28 -0700
Message-ID: <CAMkAt6qUpthB893PWXcNvdZbVmwDs1Ca-5BYwEsxnHEOM_TEsA@mail.gmail.com>
Subject: Re: [PATCH V4] virt: sev: Prevent IV reuse in SNP guest driver
To:     Borislav Petkov <bp@suse.de>
Cc:     thomas.lendacky@amd.com, Dionna Glaze <dionnaglaze@google.com>,
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
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 2:36 PM Borislav Petkov <bp@suse.de> wrote:
>
> On Mon, Nov 14, 2022 at 02:11:48PM -0700, Peter Gonda wrote:
> > Thanks for detailed review. Working on cleaning up the text for a V5.
>
> Yeah, and I have some questions in my reply which you haven't
> addressed...

Ah I was just applying answers to those in the comments/commit description.

I have replied back to your first post.

>
> > > > @@ -676,7 +712,7 @@ static int __init sev_guest_probe(struct platform_device *pdev)
> > > >       if (!snp_dev->response)
> > > >               goto e_free_request;
> > > >
> > > > -     snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
> > > > +     snp_dev->certs_data = alloc_shared_pages(dev, sizeof(*snp_dev->certs_data));
> > >
> > > What's that change for?
> > >
> > > I went searching for that ->certs_data only ot realize that it is an
> > > array of size of SEV_FW_BLOB_MAX_SIZE elems.
> >
> > Do you want this change reverted? I liked the extra readability of the
> > sizeof(*snp_dev->certs_data) but its unnecessary for this change.
>
> Really?
>
> I think using a define which is a SIZE define is better. Especially if
> you look at
>
>         sizeof(*snp_dev->certs_data)
>
> and wonder what type ->certs_data is.
>
> And it's not like it'll go out of sync since it is an array of size,
> well, SEV_FW_BLOB_MAX_SIZE.
>

OK! I'll revert this part of the change.

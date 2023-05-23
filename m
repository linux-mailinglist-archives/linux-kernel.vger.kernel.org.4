Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E855F70E37F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 19:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238213AbjEWRaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 13:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238252AbjEWR3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 13:29:52 -0400
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48A2C2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:29:01 -0700 (PDT)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6238ce8d8f9so31452846d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 10:29:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684862941; x=1687454941;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88ji2ehp7Y51Xu9y1iJArVPSJqfYf526w71azZN8Kpg=;
        b=Q2A9BZKLQmvErXWlJ5paOIUE4fYC9HvgNl59AHs2w3cbiP9xMngSYzJl7FlahZVVUa
         E79eAIBWYJfQnUUdMD/7KnQMA5d0+9GOMad3WMNIiw4G1orExpJR0yASIizk82u8XYOg
         k4k+EjZGlg+2QDIqBVWVfBSBoUu4bHioc6d1wrA2lu7JHDC6dMuRg2Qh8PfvaBPgRF+v
         Z9AGvVUQyGuGYnRpCVnH+mwWUJZTTNAIrebjJQSxY1Kd1OUtVtvwsdzeBRhuRBoO5Dso
         Ef1cfkbTJWe8AyCBwzdnkgK0Qz7V1a3sH17DPaqA4osdm1PtOsfBwW8+wQAj9xZIl7cL
         IIZw==
X-Gm-Message-State: AC+VfDxAwB78tfy6XGV/sbsvuKvi0Q1WBPvTUFDKS/GcDiqboK0fwQTv
        vvlzuBrAFO6mGlR08jI95kSw
X-Google-Smtp-Source: ACHHUZ6ppaovW6MrAx8+WrlMFkTJ9U/3siFa5SZn2V1/hKufKCBU2/85YLyX7aa4/3GEKAaK2QRmNQ==
X-Received: by 2002:a05:6214:ac8:b0:5ef:6142:cb05 with SMTP id g8-20020a0562140ac800b005ef6142cb05mr28205100qvi.20.1684862940865;
        Tue, 23 May 2023 10:29:00 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id mx13-20020a0562142e0d00b0061a2094694fsm2919225qvb.24.2023.05.23.10.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:29:00 -0700 (PDT)
Date:   Tue, 23 May 2023 13:28:59 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Du Rui <durui@linux.alibaba.com>
Cc:     dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        Alasdair Kergon <agk@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: Re: dm overlaybd: targets mapping OverlayBD image
Message-ID: <ZGz32yw7ecKhW+lj@redhat.com>
References: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19 2023 at  6:27P -0400,
Du Rui <durui@linux.alibaba.com> wrote:

> OverlayBD is a novel layering block-level image format, which is design
> for container, secure container and applicable to virtual machine,
> published in USENIX ATC '20
> https://www.usenix.org/system/files/atc20-li-huiba.pdf
> 
> OverlayBD already has a ContainerD non-core sub-project implementation
> in userspace, as an accelerated container image service
> https://github.com/containerd/accelerated-container-image
> 
> It could be much more efficient when do decompressing and mapping works
> in the kernel with the framework of device-mapper, in many circumstances,
> such as secure container runtime, mobile-devices, etc.
> 
> This patch contains a module, dm-overlaybd, provides two kinds of targets
> dm-zfile and dm-lsmt, to expose a group of block-devices contains
> OverlayBD image as a overlaid read-only block-device.
> 
> Signed-off-by: Du Rui <durui@linux.alibaba.com>

<snip, original patch here: [1] >

I appreciate that this work is being done with an eye toward
containerd "community" and standardization but based on my limited
research it appears that this format of OCI image storage/use is only
used by Alibaba? (but I could be wrong...)

But you'd do well to explain why the userspace solution isn't
acceptable. Are there security issues that moving the implementation
to kernel addresses?

I also have doubts that this solution is _actually_ more performant
than a proper filesystem based solution that allows page cache sharing
of container image data across multiple containers.

There is an active discussion about, and active development effort
for, using overlayfs + erofs for container images.  I'm reluctant to
merge this DM based container image approach without wider consensus
from other container stakeholders.

But short of reaching wider consensus on the need for these DM
targets: there is nothing preventing you from carrying these changes
in your alibaba kernel.

Mike

[1]: https://patchwork.kernel.org/project/dm-devel/patch/9505927dabc3b6695d62dfe1be371b12f5bdebf7.1684491648.git.durui@linux.alibaba.com/

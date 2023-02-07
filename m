Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FC068E29E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 22:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjBGVFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 16:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjBGVFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 16:05:01 -0500
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E03AE;
        Tue,  7 Feb 2023 13:05:00 -0800 (PST)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-169ba826189so20688317fac.2;
        Tue, 07 Feb 2023 13:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFGDXaBqsF9jEoiShHTN1yV+Mtn0R4KDmloG0NYM1Zs=;
        b=b5WH48CARw3ZlTZhUaasMaNoMIZIn1JnyKKNig5/T3V0ozxlJHoyQFq4tDFLeUzvnh
         CANdgWcHceNFEXT+AqCTu+LRV/fEeY80zTuekWIMqKO8jZ+qC3bC+4r0L/LOWV/CZCjb
         WgotwQe+P5v3QM5W67tHVcY/LHsIn3H5WTDtDttdn/ndPOBPrQ7BgPJ74l8ww6OtVWMg
         ETByyzFvge9LaAz3s22FEAPVriFfTTGoCZEKBgudrHW+Te56kPJds5yqW90DavwEI1CR
         SNSghvzDpeIhJZgpWD/4WuFBmDFDTA4BdHkWYvbdRB7MFeD7muPa5EUVNYtY5xE7Xe2Y
         zskg==
X-Gm-Message-State: AO0yUKUFGDFJk5KUbDm0r6/aZO8oK7/O1C4mhkYyStuMY534JEk7dvwt
        FymfAspZO+mrqnDqFu4WGs7eON0nuQ==
X-Google-Smtp-Source: AK7set9BvmkzqucwHSklKk1CG0HFoET9kw5v1V7H41Esr59xBJlnU34LyUXqvKNhwC7Em+eoObbQpg==
X-Received: by 2002:a05:6870:708a:b0:163:4c84:5f1a with SMTP id v10-20020a056870708a00b001634c845f1amr2100457oae.49.1675803899449;
        Tue, 07 Feb 2023 13:04:59 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s24-20020a05682003d800b004a8eb1d8f1bsm6514302ooj.39.2023.02.07.13.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 13:04:58 -0800 (PST)
Received: (nullmailer pid 4152043 invoked by uid 1000);
        Tue, 07 Feb 2023 21:04:58 -0000
Date:   Tue, 7 Feb 2023 15:04:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Liu <liumartin@google.com>
Cc:     frowand.list@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, surenb@google.com,
        minchan@kernel.org, tkjos@google.com
Subject: Re: [PATCH] of: reserved-mem: expose reserved-mem details via debugfs
Message-ID: <20230207210458.GA4142905-robh@kernel.org>
References: <20230206142714.4151047-1-liumartin@google.com>
 <CAL_JsqKA8pBess-zLA_2n0p8q=NBuY0EGA7qALKabwJA8ZRwrA@mail.gmail.com>
 <CAASV4h5ANYTJUN3gQxuLxeKMknyoyt7-YTxRRMcjrQXRrVRi5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAASV4h5ANYTJUN3gQxuLxeKMknyoyt7-YTxRRMcjrQXRrVRi5Q@mail.gmail.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 01:05:25AM +0800, Martin Liu wrote:
> On Mon, Feb 6, 2023 at 11:12 PM Rob Herring <robh+dt@kernel.org> wrote:
> >
> > On Mon, Feb 6, 2023 at 8:27 AM Martin Liu <liumartin@google.com> wrote:
> > >
> > > It's important to know reserved-mem information in mobile world
> > > since reserved memory via device tree keeps increased in platform
> > > (e.g., 45% in our platform). Therefore, it's crucial to know the
> > > reserved memory sizes breakdown for the memory accounting.
> > >
> > > This patch shows the reserved memory breakdown under debugfs to
> > > make them visible.
> > >
> > > Below is an example output:
> > > cat $debugfs/reserved_mem/show
> > > 0x00000009fc400000..0x00000009ffffffff (   61440 KB )   map     reusable test1
> > > 0x00000009f9000000..0x00000009fc3fffff (   53248 KB )   map     reusable test2
> > > 0x00000000ffdf0000..0x00000000ffffffff (    2112 KB )   map non-reusable test3
> > > 0x00000009f6000000..0x00000009f8ffffff (   49152 KB )   map     reusable test4
> > > ...
> > > 0x00000000fd902000..0x00000000fd909fff (      32 KB ) nomap non-reusable test38
> > > 0x00000000fd90a000..0x00000000fd90bfff (       8 KB ) nomap non-reusable test39
> > > Total 39 regions, 1446140 KB
> >
> > This information is pretty much static, why not just print it during
> > boot? It's also just spitting out information that's straight from the
> > DT which is also available to userspace (flattened and unflattened).
> 
> IIUC, for dynamic allocation cases, we can't get actual allocation layout
> from DT.

Right, so whomever does the allocation should print that out.

>  Also, there could be some adjustment from memblock
> (ex. alignment). Therefore, printing it out from the reserved_mem would
> be more clear.

If memblock is adjusting, then shouldn't memblock print out the 
addresses?

> However, as you mentioned, once the allocation is done, it should be pretty
> static. Thus, printing it during boot should be reasonable. If so, we
> could print
> them out in fdt_init_reserved_mem() like below. Is my understanding correct?

That looks mostly fine to me. If we can do it with the unflattened tree, 
that would be better. I'm not sure off hand if that works here and you 
are just incorrectly using of_get_flat_dt_prop() still, or if it is 
indeed too early.

Rob

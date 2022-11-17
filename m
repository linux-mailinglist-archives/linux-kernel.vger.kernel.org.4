Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A42462E298
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 18:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiKQRIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 12:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240562AbiKQRIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 12:08:44 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4155DB92;
        Thu, 17 Nov 2022 09:08:43 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id bj12so6569660ejb.13;
        Thu, 17 Nov 2022 09:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UXTIiUhTsDF1ksUQHxOjXei7p0SmIC0BDVdiFoql/Uc=;
        b=mfyuY0gsE5mnqDj5qh5OiKmRss9nTC7A3qsjOYoPmm5QQril+rlThWhPU0wD6Ub4FC
         e8dxsES6M1eDGjtNdYNKm9uWUX68BWALYloABbu3r2vvFDB+bl/D9MHQ6dolimQYL7aN
         EDoPyKs23xH6dMrl3+/EWt/jUTXcuymGKUPBkiLzojbxcQ6vhLN5DETjo1B4QFlOQLpM
         A7oFWHptPVyHvILMhI23wk40X9QgjTKiYte9CvQuDej/WMCu4v9CcFPEYvL/YiE3Mxtw
         /HQeS59Jod2FDBu4Yq1PYEyxlMlpgmB9ck9ERJDj84wD/D15QAx9uXMl5r5UV9ZilzRE
         MwDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UXTIiUhTsDF1ksUQHxOjXei7p0SmIC0BDVdiFoql/Uc=;
        b=fT8rO/lgz/rCC8TBf3Eg+U6cds3HnfxzYoAO3gifj/sqmudcfcMGwBalb/XSsEhYbF
         ay7zXZSujljDlSavLLDe6Hk82SBj9tLQWYMHfgny/+NF3BlbV/Z+v9VKfK7Yjyg0/4rN
         TkBsKjAp49VbE12DIhgJg0Oz8U06vjavaNdKjbo9fo6whRd+xEfpDg9p7aQ+hg+DNIh3
         EdHLvRsN7Q7DN1sGf5kBBrD0DPeJ/eU9pFvZXiYhMcZkPimJllmDoNrAWxwLJO/tpKOW
         SxcngIx2i3qHGlrRsGfuDxHrtck6iiEP51WY/L31U1QTBt1zDKHhgYayP5LpWttf61Pd
         IV1w==
X-Gm-Message-State: ANoB5pljE5o2up5LZBMTBFX4NIvyqHZXShibFq1kV4fwIHKfnUyLEygH
        a6shTv64S9OEWvIPO65GN70=
X-Google-Smtp-Source: AA0mqf7wfxRfK7sRIBOzZ7oJkCHzXBfgd3DzeE6bB2BpmX+zB3cRO/dVMMsqWRKhiAIJzI2mS2+oNg==
X-Received: by 2002:a17:906:c084:b0:78d:e786:e322 with SMTP id f4-20020a170906c08400b0078de786e322mr2804280ejz.308.1668704921768;
        Thu, 17 Nov 2022 09:08:41 -0800 (PST)
Received: from thinkpad-p72 (user-5-173-65-115.play-internet.pl. [5.173.65.115])
        by smtp.gmail.com with ESMTPSA id m7-20020aa7c2c7000000b00467c3cbab6fsm769694edp.77.2022.11.17.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 09:08:41 -0800 (PST)
From:   Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>
X-Google-Original-From: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
Date:   Thu, 17 Nov 2022 18:08:38 +0100
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Lukasz Wiecaszek <lukasz.wiecaszek@googlemail.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] udmabuf: add vmap and vunmap methods to udmabuf_ops
Message-ID: <20221117170838.GA74987@thinkpad-p72>
References: <20221117045842.27161-1-lukasz.wiecaszek@gmail.com>
 <970e798d-ea26-5e1e-ace8-7915a866f7c7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970e798d-ea26-5e1e-ace8-7915a866f7c7@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 12:04:35PM +0300, Dmitry Osipenko wrote:
> Hi,
> 
> On 11/17/22 07:58, Lukasz Wiecaszek wrote:
> > The reason behind that patch is associated with videobuf2 subsystem
> > (or more genrally with v4l2 framework) and user created
> > dma buffers (udmabuf). In some circumstances
> > when dealing with V4L2_MEMORY_DMABUF buffers videobuf2 subsystem
> > wants to use dma_buf_vmap() method on the attached dma buffer.
> > As udmabuf does not have .vmap operation implemented,
> > such dma_buf_vmap() natually fails.
> > 
> > videobuf2_common: __vb2_queue_alloc: allocated 3 buffers, 1 plane(s) each
> > videobuf2_common: __prepare_dmabuf: buffer for plane 0 changed
> > videobuf2_common: __prepare_dmabuf: failed to map dmabuf for plane 0
> > videobuf2_common: __buf_prepare: buffer preparation failed: -14
> > 
> > The patch itself seems to be strighforward.
> > It adds implementation of .vmap and .vunmap methods
> > to 'struct dma_buf_ops udmabuf_ops'.
> > .vmap method itself uses vm_map_ram() to map pages linearly
> > into the kernel virtual address space.
> > .vunmap removes mapping created earlier by .vmap.
> > All locking and 'vmapping counting' is done in dma_buf.c
> > so it seems to be redundant/unnecessary in .vmap/.vunmap.
> > 
> > Signed-off-by: Lukasz Wiecaszek <lukasz.wiecaszek@gmail.com>
> 
> If new patch version doesn't contain significant changes and you got
> acks/reviews for the previous version, then you should add the given
> acked-by and reviewed-by tags to the commit message by yourself.
> 
> -- 
> Best regards,
> Dmitry
>

I would like to thank you all for your patience and on the same time say
sorry that I still cannot follow the process (although I have read
'submitting patches' chapter).


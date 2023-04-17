Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74C766E4145
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjDQHiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbjDQHho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:37:44 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788445BBE
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:37:03 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id y6so23611618plp.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681717022; x=1684309022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql0iTP179pIhS3D2wVviSQ4v43IiJJy5uQQWSApfMgw=;
        b=olHgJtXl3xiBtP0Nv6bocud6SVVd0gwMTdXw8n/5ssQfoXMiSy2INA8TOLFP8Vp7TH
         Ku+SQ5nb+FwwYzAgVgF9hI7Q8ymhh4THiLGZMZJEIpXPaSdwr9d1Lu8hDifYSdXQFOV8
         +3t8C1DEdGkqKzFvhoGptiQtZTfbg/CEMSZctRk81+Jie5sX9rxu39Rw4VsF+zwvn7vQ
         1jA/ortoG/zVQWnuNBj+Cw9RGTW3KYlqOaLsYfb0T+/3ymr0rljTK73UcAWo0NjAQpJg
         093o8n4v1IBIM4ZzQ6rErOtJLTBxEycDdQakKYwvQ+5LcsD54D4CJpHIctbI0yZxgbIn
         geIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681717022; x=1684309022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql0iTP179pIhS3D2wVviSQ4v43IiJJy5uQQWSApfMgw=;
        b=XFRuL1qE6Y/OxPGhorloWfWyPaVluXEkKn32bYpHoRhb3wTc931Q2tAfzpD6PrWh0d
         ADYqOqxWKAiRRrqjq4K0PMvh9NFaCkpclkoSSV7ADpq80hQarOIDeM8OnkTtFYGFp6vc
         O7PRFPH3IljS/rCyZU6C2EPprXUN5V985MBkEku1m5UONbEQkEVu6JE7ayo6rHplZXKs
         jUpA6o/Nr83nhsaSPZOQzouAgkwCy07qYUwVuvHw4PWjSLnol5fnp38Vz6jF7Ttlr6kP
         gyOmr4wz8AR61j1DUj2chORuFWUI+vvjgU6US/1iQ0zMeacnhN9toi/3ACXMfraEKNGy
         v/sg==
X-Gm-Message-State: AAQBX9d5Q/2tV7gs983Km7847ptwCjNEmdETXYOGNdEbvG0fdE6eMBOt
        3TBeYg3JfCBC0s3vpnR8TNU=
X-Google-Smtp-Source: AKy350YeY4lDiDKgaTbJgzkeVNGLeDCUGf6a016OYEmzHRIiSAmh720ZwkB11T8nqxSBGfp4/SD7jw==
X-Received: by 2002:a17:903:32c6:b0:1a6:566b:dd73 with SMTP id i6-20020a17090332c600b001a6566bdd73mr13990591plr.60.1681717022477;
        Mon, 17 Apr 2023 00:37:02 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d22-20020a170902b71600b001a67759f9f8sm733233pls.106.2023.04.17.00.37.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Apr 2023 00:37:02 -0700 (PDT)
Date:   Mon, 17 Apr 2023 15:44:15 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        jefflexu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH] erofs: remove unneeded icur field from struct
 z_erofs_decompress_frontend
Message-ID: <20230417154415.00006a18.zbestahu@gmail.com>
In-Reply-To: <a8b9a758-d469-b9a6-f5e8-8f3768e2ea81@linux.alibaba.com>
References: <20230417064136.5890-1-zbestahu@gmail.com>
        <26cdf7b0-5d7d-68ba-da76-1ad800708946@linux.alibaba.com>
        <dd1d75a6-38c3-771c-c1ed-2f5dca523c03@linux.alibaba.com>
        <20230417151506.00006565.zbestahu@gmail.com>
        <a8b9a758-d469-b9a6-f5e8-8f3768e2ea81@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 15:12:31 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/4/17 15:15, Yue Hu wrote:
> > On Mon, 17 Apr 2023 15:00:25 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> 
> ..
> 
> >>
> >> Although please help refine the comment below:
> >>
> >> 	/* scan & fill inplace I/O pages in the reverse order */  
> > 
> > Ok, will refine it in v2.  
> 
> I rethink this, I don't want to go far in this way, and this makes a
> O(n) scan into O(n^2) when a single inplace I/O page is added.

Yeah, i misread that, it should be global before submission, just ignore the change.

> 
> So sorry, I don't think it's a good way, although I also don't think
> `icur` is a good name and we might need to find a better name.
> 
> Thanks,
> Gao Xiang
> 
> >   
> >>
> >> Thanks,
> >> Gao Xiang
> >>  
> >>>> +    unsigned int icur = pcl->pclusterpages;
> >>>> -    while (fe->icur > 0) {
> >>>> -        if (!cmpxchg(&pcl->compressed_bvecs[--fe->icur].page,
> >>>> +    while (icur > 0) {
> >>>> +        if (!cmpxchg(&pcl->compressed_bvecs[--icur].page,
> >>>>                     NULL, bvec->page)) {
> >>>> -            pcl->compressed_bvecs[fe->icur] = *bvec;
> >>>> +            pcl->compressed_bvecs[icur] = *bvec;
> >>>>                return true;
> >>>>            }
> >>>>        }
> >>>> @@ -877,8 +876,6 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
> >>>>        }
> >>>>        z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
> >>>>                    Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
> >>>> -    /* since file-backed online pages are traversed in reverse order */
> >>>> -    fe->icur = z_erofs_pclusterpages(fe->pcl);
> >>>>        return 0;
> >>>>    }  


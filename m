Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1432D5ECCE5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiI0T3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiI0T3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:29:41 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DE13DE5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:29:37 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id v186so10534633pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 12:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=r7xtOlqozdraYuJQ03gkzLKn3JQTQXmOM1qxZT3pBcY=;
        b=UMdWyNVZoSeG/LH6JnFOGTLkiBy8XOAjfwOhPLacP+EuDSAzHegFmRrkNJVbJml4w0
         +66qymozL27sUk6qvYYNQVaUc8AUDC69AVvnSeIOBVgOGfb4joh9UwENQTZE8nyJpym8
         4e3SET7aWlRYxjK8Pd3GKIKEv76Lar91eTk18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=r7xtOlqozdraYuJQ03gkzLKn3JQTQXmOM1qxZT3pBcY=;
        b=6dQJ4sVDDqBow0eo+vyoAd60YC8uQIyNpbSETLxR8evSzoE2uGtfxgMN4BGFtysPT3
         iXnZzcZ569craZ0OCrnUJdxF40+WKK8SHhDzVXGbQDvaE/MteFA0eKottBE/Lm3iC6U8
         x8vX+XuGQVMGUo62oP8Y9B1rfeI9m+Owdhc1uhkiHOKP0WbvsMAviIQrqf/AH5BBmT6Q
         iWm+lJ+EJwc9FAwHuTGtsr3uoaYJMoz3kAvrakVyIG8Z+X/u60mhoHYoQIEaeBt28vZ6
         13xkNa+z5YZDiCnjr+sgvpMjUgXNGnus93oCDb/5l2fYNqKRNdg3u1HYCW6i8Ttg5hqB
         +/gQ==
X-Gm-Message-State: ACrzQf2RtB5WKs/pr9l+UpkdWlUfegRTenyfX+qMxKK2OFf4XW1mhjlc
        WedtQo5jPb4gyHXAC+RFmXTo9Q==
X-Google-Smtp-Source: AMsMyM725HiIaC0qEscbFIhpL4ExQ1jfMBoVpTOEfDK4z6YpUJkMbo9KXGSYhiPWFhpY5VL/cejpbg==
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id b12-20020a056a00114c00b005282c7a6302mr30834862pfm.37.1664306977316;
        Tue, 27 Sep 2022 12:29:37 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d18-20020a170902ced200b0017808db132bsm1978221plg.137.2022.09.27.12.29.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:29:36 -0700 (PDT)
Date:   Tue, 27 Sep 2022 12:29:35 -0700
From:   Kees Cook <keescook@chromium.org>
To:     broonie@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Will Deacon <will@kernel.org>
Subject: Re: linux-next: manual merge of the kspp tree with the arm64-fixes
 tree
Message-ID: <202209271228.EFA1956958@keescook>
References: <20220927190318.513999-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927190318.513999-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:03:18PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the kspp tree got a conflict in:
> 
>   include/asm-generic/vmlinux.lds.h
> 
> between commit:
> 
>   13b0566962914 ("vmlinux.lds.h: CFI: Reduce alignment of jump-table to function alignment")
> 
> from the arm64-fixes tree and commit:
> 
>   89245600941e4 ("cfi: Switch to -fsanitize=kcfi")
> 
> from the kspp tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/asm-generic/vmlinux.lds.h
> index ae63dd8a3a2cf,7501edfce11ea..0000000000000
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> 
> [The block updated in Will's commit is just plain removed with no
> equivalent in kspp]

Right, this is correct. 13b0566962914 (a fix for the previous CFI
implementation) becomes useful for -stable backports, but is entirely
removed for the new CFI implementation.

-- 
Kees Cook

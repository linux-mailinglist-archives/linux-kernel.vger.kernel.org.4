Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B206E35F3
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 09:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbjDPH66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 03:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjDPH64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 03:58:56 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5F41BD
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:58:54 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-505050c7217so516437a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 00:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681631932; x=1684223932;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pi4LPZudUdSoCu6KWlPIQF+AbKkt6/8uc15eezFygLc=;
        b=gbaZCiFMGCe9loT30w7umP+CThUXjdVCEFxcRwI+N4fbyxQnNz+xwoGwm5mgVOdu4T
         0pJglngxJ/TBDuzi0RrtYA5Z1DhQCluhT4KEv2B/LE+/OgkFxjxZW2EDT3yLOuiideIh
         Pbl/s9xnH9h1rnUzbHIB86dLG8OOcdaCzJOHg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681631932; x=1684223932;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi4LPZudUdSoCu6KWlPIQF+AbKkt6/8uc15eezFygLc=;
        b=MExxKYizrv+C51HMsgSAD93Xx+MuMZUmIQcbMDhCSSKtu8ZmqVl1vprIMZCyKRz0kK
         96zXZv4wA6VFVeLDWpn0ShtJ4E4L/+vHFMs54gATf0hJFWg8EeVxxg0pDp+lNz7+75Wh
         U+X5RCsqeBLBPGAVqWLRHTWyOrB8eLyABpeqjUp1jIwpJbGYByWJa9UZhYkI+MpBJ7+9
         QqO95hY78OgwxaBMf/eQ1wLaWI0jBqRNhCVjY3FtJkFKnns9WHNnctLFxsfBEZ3Kbt50
         AraOK3+zAvopoOvB11ydV5VV2pIJCYPXqHfJQWWEpzYwgIj3TMb/ALqcnxUtAOFdzexG
         Z6cA==
X-Gm-Message-State: AAQBX9dzJG39PVhYL7X99Aa2ezVmPXFY9AJdqt4IrD5HK//9Lhe4nRfn
        rrzduEVzbfOIRpTBSP9bzNzlwA==
X-Google-Smtp-Source: AKy350bGuHVE6drEP2IMOElAil6tvl9C8/Gdd1sqZMHmULsjuwzXyNFK0kGZyhHfzLj0CpCrxIeamw==
X-Received: by 2002:a05:6402:5253:b0:502:92d:4f50 with SMTP id t19-20020a056402525300b00502092d4f50mr7819327edd.1.1681631932504;
        Sun, 16 Apr 2023 00:58:52 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id j23-20020aa7de97000000b0050432d2b443sm4307664edv.48.2023.04.16.00.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 00:58:52 -0700 (PDT)
Date:   Sun, 16 Apr 2023 09:58:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     broonie@kernel.org
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the mm-stable
 tree
Message-ID: <ZDuqut+8BKjMXblJ@phenom.ffwll.local>
Mail-Followup-To: broonie@kernel.org,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230414125913.851920-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414125913.851920-1-broonie@kernel.org>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2023 at 01:59:12PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the drm-misc tree got a conflict in:
> 
>   drivers/gpu/drm/ttm/ttm_pool.c
> 
> between commit:
> 
>   23baf831a32c0 ("mm, treewide: redefine MAX_ORDER sanely")
> 
> from the mm-stable tree and commit:
> 
>   56e51681246e5 ("drm/ttm: revert "Reduce the number of used allocation orders for TTM pages"")
> 
> from the drm-misc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> 
> diff --cc drivers/gpu/drm/ttm/ttm_pool.c
> index 4db3982057be8,dfce896c4baeb..0000000000000
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> 
> [Just the version in mm]

Note there was a ppc compile fail, which is why we pushed the ttm revert.
That /should/ be fixed now, but would be good if you can confirm?

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

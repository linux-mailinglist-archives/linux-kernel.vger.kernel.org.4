Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF47654F29
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 11:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiLWKYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 05:24:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiLWKY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 05:24:28 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E729C1FFB9;
        Fri, 23 Dec 2022 02:24:27 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id v124-20020a1cac82000000b003cf7a4ea2caso5844559wme.5;
        Fri, 23 Dec 2022 02:24:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CRuUJZVOpUtgPvjJSw65Ev7JgBrVcaaYMlRw59e9HHo=;
        b=aKDfNpRXZ27jsLjGo3FBvyZVLAnFXagcPNocTyT8aZNnWT5jO3bG9yr+ZtkR3R+XQB
         rwB35v6+Oo4WigU65Z+wI/bekDZ2yxSCox341aiSxK5S6iyTfgCNGuvFX3H2ulB58IM/
         qppT5/mM4+jUO4B/15KM8irHnM7SVwf7dl9mKm15Q/1feN1QPZIPDE+Ex352sLWYnDNr
         zvwE+jGsjnHqrQ/87Yxost4XxnWU+8r38zNrapRMJzx18Mm1WzWR+/xJ/h8dJ+6TmmhU
         ZhwZyzKC4DSyj8R45zXrbkHiKoA7ebU7eopWFpiIi/AcQw+nJbEwctHFfQAzQ4oB81+M
         2cQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CRuUJZVOpUtgPvjJSw65Ev7JgBrVcaaYMlRw59e9HHo=;
        b=q/iKd1ZjM3NfwhwiudLvs1HjGnF2FdNJfLmhHXN5svL65Hu4vubwZKsY+z4zQd8o+j
         H2MmwJNSnuGQTf5SkgA1ia/XISr6HGCddRAG+U6yyjAerTxnxlQ7yXIhMqYpZYkBqOfp
         DWBqclL8o7n/2rf3b82I/xnOEUd0VHlM5p0RXvXlfLFHF780dQoTnZqkWsF68zKQf2hu
         gyder/DnDiewt16/j786CXWZsETLkD6ytbm0XNaJCoEAkJQ3nhSfOgalLG/SFCSogBfk
         e2FPv+/3QZ1RaCwD1OeKRroskxOxL1akx8cVbpcPNhGnzNwO/5+vTbPd0ELP+qVaMHDl
         7D+Q==
X-Gm-Message-State: AFqh2kqV/tyHr2SuzCltuK647OtP5l9dp44Dd97I49V5BuVbzU6kpz3d
        TcXREF3MTL0IDYNXJD7WUVw=
X-Google-Smtp-Source: AMrXdXuqkbabnF7DzHU0Ej1s4hVLvQJ+bsyuWTyXaxsjS1VNZXTjdjD4EiZQnf6FSm8KN1A3U8ddKQ==
X-Received: by 2002:a05:600c:a4f:b0:3d3:5c35:8919 with SMTP id c15-20020a05600c0a4f00b003d35c358919mr6783088wmq.30.1671791066352;
        Fri, 23 Dec 2022 02:24:26 -0800 (PST)
Received: from localhost ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b002714b3d2348sm2880136wrv.25.2022.12.23.02.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Dec 2022 02:24:25 -0800 (PST)
Date:   Fri, 23 Dec 2022 10:24:25 +0000
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] vmalloc: reject vmap with VM_FLUSH_RESET_PERMS
Message-ID: <Y6WB2ZGoL7FaFK+f@lucifer>
References: <20221223092703.61927-1-hch@lst.de>
 <20221223092703.61927-3-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223092703.61927-3-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:27:03AM +0100, Christoph Hellwig wrote:
> VM_FLUSH_RESET_PERMS is just for use with vmalloc as it is tied to freeing
> the underlying pages.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  mm/vmalloc.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 9e30f0b3920325..88a644cde9fb12 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -2849,6 +2849,9 @@ void *vmap(struct page **pages, unsigned int count,
>
>  	might_sleep();
>
> +	if (WARN_ON_ONCE(flags & VM_FLUSH_RESET_PERMS))
> +		return NULL;
> +

Might it be worth adding a specific vmap mask that explicitly indicates what
flags are permissible on vmap()? Then this could become e.g.:-

	if (WARN_ON_ONCE(flags & ~VM_VMAP_PERMITTED_MASK))
		return NULL;

And would be self-documenting as to why we are disallowing flags (i.e. they are
not part of the permitted vmap mask).

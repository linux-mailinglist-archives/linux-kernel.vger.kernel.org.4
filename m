Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3A65EB65F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiI0AkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiI0AkB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:40:01 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1B71A23D;
        Mon, 26 Sep 2022 17:39:59 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id c81so10276675oif.3;
        Mon, 26 Sep 2022 17:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QK6s3qWgSzcfpcdtH25aSluRGCB5Dal9WKGY9WgXnoY=;
        b=A+LoIsFX52NYi2E4snRfYJDUCYS7ukrKgEjVAWhG2E4ltzMpil6FOgQ10ECOR/VAsE
         EALHMGcluPmiGF/5Ca0kHxGatmwgjXx/t+/8aNwG5eaU6TJmTCmX0u1Zudo8MrPmLaok
         Ope7nOj9/sjvVk1Ge4OP1wr1CTQhez6nPAmRY/TFdFLlVQEE6Xit3FvlYf5cShRHPJ5W
         Qhvt0Z5oZp/0zEWw778pIa/YuPkpaIFwI1KuD503lCBILScTwguySu0defhTYWpddep+
         sTZUXQQ3J/EPL8xgjStFh1yjC9Kx6akqkPIjrCVbGvWAs62YRzC5PfqUNfptj/3l97ci
         /xQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=QK6s3qWgSzcfpcdtH25aSluRGCB5Dal9WKGY9WgXnoY=;
        b=b74Gcsz18k0XzPJf/dxuyyFuMaW4zxJqDIAg50KNX9tLICKDlnzADQekSV37h+aZ1p
         Gzh5FOegoBdlXqioRtVO99ygLAWnUsU6mJDQGdLDEAbCpQBHMtQZVgb5e6cjZfpOBKlj
         oiMrt01sV97w6APivC2gBlcsohWGvHcUfrkSnHNDOSPBrcOedkzYD5v3pYm0gRJxzMqg
         p3Phk75aO2iT5GF1eAMxDud4aKEQGyY4ZQulNd8q+PZaFTelaSQB0ORTiWb1a5PhNC7y
         D8KYR3INYeg/6w99FLb95YFn6TieWU2nh81ohAWzChS/jHsKzRImlfQgt9vWfxaY2zrv
         YQdQ==
X-Gm-Message-State: ACrzQf0EnPzXgK743BSoUmGAejTx1w+wAGsh2viXEhcTEXMN7rUIHlZ2
        T+akLbVojNYIH6MmleJw/Vtgxjy+tXQ=
X-Google-Smtp-Source: AMsMyM6Hebx4KfgsUvEYqtv3W940TqkjSJ9T9yRRN1UqLwb4B/3Np5aPTbHn9YROliZkJpiQSu30gQ==
X-Received: by 2002:a05:6808:1c07:b0:34f:5d29:f597 with SMTP id ch7-20020a0568081c0700b0034f5d29f597mr645843oib.275.1664239197402;
        Mon, 26 Sep 2022 17:39:57 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id y123-20020a4a4581000000b00472874bc2ffsm55719ooa.28.2022.09.26.17.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:39:57 -0700 (PDT)
Date:   Mon, 26 Sep 2022 17:37:46 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     broonie@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the bitmap tree
Message-ID: <YzJF2hx4O6vnkVKC@yury-laptop>
References: <20220926235348.1269963-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926235348.1269963-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 12:53:48AM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> After merging the bitmap tree, today's linux-next build (x86
> allmodconfig) failed like this:

Hmm, this weird. I checked the next-20220923, and the drivers' code
mentioned in the log differs from what I see, and looks correct.
bitmap_weight() definition hasn't been changed in bitmap-for-next
patches.

Allmodconfig build looks good to me.

Check what I see in next-20220923 below.

Thanks,
Yury
 
> /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:492:3: note: in expansion of macro 'dev_err'
>   492 |   dev_err(rvu->dev, "%s: No space in id bitmap (%lu)\n",
>       |   ^~~~~~~
> /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:492:51: note: format string is defined here
>   492 |   dev_err(rvu->dev, "%s: No space in id bitmap (%lu)\n",
>       |                                                 ~~^
>       |                                                   |
>       |                                                   long unsigned int
>       |                                                 %u

                dev_err(rvu->dev, "%s: No space in id bitmap (%d)\n",
                        __func__, bitmap_weight(table->id_bmap, table->tot_ids));

> /tmp/next/build/drivers/net/ethernet/marvell/octeontx2/af/rvu_npc_hash.c:525:22: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
>   525 |   dev_info(rvu->dev, "%s: No space in exact cam table, weight=%lu\n", __func__,
>       |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

                dev_info(rvu->dev, "%s: No space in exact cam table, weight=%u\n", __func__,
                         bitmap_weight(table->cam_table.bmap, table->cam_table.depth));jj

> /tmp/next/build/drivers/gpu/drm/i915/gt/intel_sseu.c:867:39: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
>   867 |   seq_printf(m, "  %s Geometry DSS: %lu\n", type,
>       |                                     ~~^
>       |                                       |
>       |                                       long unsigned int
>       |                                     %u
>   868 |       bitmap_weight(sseu->geometry_subslice_mask.xehp,
>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       |
>       |       unsigned int
>   869 |       XEHP_BITMAP_BITS(sseu->geometry_subslice_mask)));

                seq_printf(m, "  %s Geometry DSS: %u\n", type,
                           bitmap_weight(sseu->geometry_subslice_mask.xehp,
                                         XEHP_BITMAP_BITS(sseu->geometry_subslice_mask)));


>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> /tmp/next/build/drivers/gpu/drm/i915/gt/intel_sseu.c:870:38: error: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'unsigned int' [-Werror=format=]
>   870 |   seq_printf(m, "  %s Compute DSS: %lu\n", type,
>       |                                    ~~^
>       |                                      |
>       |                                      long unsigned int
>       |                                    %u
>   871 |       bitmap_weight(sseu->compute_subslice_mask.xehp,
>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       |
>       |       unsigned int
>   872 |       XEHP_BITMAP_BITS(sseu->compute_subslice_mask)));

                           bitmap_weight(sseu->compute_subslice_mask.xehp,
                                         XEHP_BITMAP_BITS(sseu->compute_subslice_mask)));

>       |       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> 
> These look like they have probably been there for a while but I've used
> a slightly different compiler version to Stephen so they're showing up
> now once the bitmap tree is merged.  I will have a proper look tomorrow
> hopefully but for now I've dropped the bitmap tree as it's getting very
> late and it is likely I'll not finish the -next run today at all.

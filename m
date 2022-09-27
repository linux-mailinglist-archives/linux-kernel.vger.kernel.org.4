Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE345ECD0C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 21:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbiI0Tkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 15:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiI0TkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 15:40:23 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66696AA3DA;
        Tue, 27 Sep 2022 12:40:22 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id m81so13082452oia.1;
        Tue, 27 Sep 2022 12:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=iruhQjRYRTGwe5/TLaTxBohqBJDpNWfMEkvXB7N5Nm8=;
        b=QwEIwspVTzTdR8qiiMDnh0OMESLS+bpH/V1erPKT4hp2qrRM/xxLuYCHFdDAGTI+kp
         nkJHX95wQEBFcEGKYWmAYruDnmaNkm4zVI+7rtrL9mnYI86raioGRNH2v+pPVnNoZ1pG
         RiQf9TzfuPZu4QAmb8i5L3BoO36mF75eHbZzYY2aiLyTwJgY2mPdSdcj46VTCu8GL3Nf
         tG7dgCtq63eU4V8jjMb+WsEC1rWrZUOs3nAkwSgwlUiRkYuqb4Zb+ikhZ/NKW5bT8Ry2
         UHc+Ko6Nd+tyBOUr92HmiV5cjnMijr2z4cu6UqtnPuoaIZeII1YyJ/8u/yI1kW1yyxXg
         ArFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=iruhQjRYRTGwe5/TLaTxBohqBJDpNWfMEkvXB7N5Nm8=;
        b=fvS5EsLksSvO1sJRH14LBNEWSAs6pyDxG+Hr80erIw0RGM+apM8CerzkKbTExs0Ky0
         n31YP8K1VjuXz8dS6UcXrCpfTIFOrg987HQ4xLbzE5+mh758KntgG4aLB/dZvaySb9Yi
         kSQd9wmevS0ypkvYMqu/cRQ+nKMlfCOudFRyQUZs6aRNlqxUYi2kjjq83Xs8jS7yQb4X
         1DfkE/9ortq79ZfASn9PGBg9pdx22gVpD/tWorsGNuqgfJjLHQZd/Fna1+z1TOrAPSS8
         jCJhMlr3t/Q6omeVEgpDp8r4MT7WNlx4/4nzIQwOTRmxiDH+aC9bvxXxzG5bLg88r/uc
         Hgew==
X-Gm-Message-State: ACrzQf1bJpUSN0QncFlN5ljvEpMng7EGpjlVdvDwOnIaXCBE/D8Hfgn/
        HZosyb8VB/xuaN7cp+tpvmw=
X-Google-Smtp-Source: AMsMyM4fpFvhPQfJKwvwez1vvCt2fJlPRTC1a4Mi01EK+EZwCWxWdqKbv9oII3PNatNaScp19TsAqg==
X-Received: by 2002:a05:6808:201f:b0:34f:9c4e:2b9d with SMTP id q31-20020a056808201f00b0034f9c4e2b9dmr2608851oiw.156.1664307621606;
        Tue, 27 Sep 2022 12:40:21 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id r33-20020a056870e9a100b0010d7242b623sm1331360oao.21.2022.09.27.12.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 12:40:21 -0700 (PDT)
Date:   Tue, 27 Sep 2022 12:38:09 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     broonie@kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the mm-stable tree with the bitmap
 tree
Message-ID: <YzNRIep0dLbT2HGr@yury-laptop>
References: <20220927192650.516143-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927192650.516143-1-broonie@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 08:26:49PM +0100, broonie@kernel.org wrote:
> Hi all,
> 
> Today's linux-next merge of the mm-stable tree got a conflict in:
> 
>   include/linux/nodemask.h
> 
> between commit:
> 
>   97848c10f9f8a ("lib/bitmap: remove bitmap_ord_to_pos")
> 
> from the bitmap tree and commit:
> 
>   3e061d924fe9c ("lib/nodemask: optimize node_random for nodemask with single NUMA node")
> 
> from the mm-stable tree.

The fix is correct. I sent the updated patch to Stephen, and
apparently had to CC you. Thanks.

> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc include/linux/nodemask.h
> index 0c45fb066caa7,e66742db741cf..0000000000000
> --- a/include/linux/nodemask.h
> +++ b/include/linux/nodemask.h
> @@@ -504,11 -505,21 +505,20 @@@ static inline int num_node_state(enum n
>   static inline int node_random(const nodemask_t *maskp)
>   {
>   #if defined(CONFIG_NUMA) && (MAX_NUMNODES > 1)
> - 	int w, bit = NUMA_NO_NODE;
> + 	int w, bit;
>   
>   	w = nodes_weight(*maskp);
> - 	if (w)
> + 	switch (w) {
> + 	case 0:
> + 		bit = NUMA_NO_NODE;
> + 		break;
> + 	case 1:
> + 		bit = first_node(*maskp);
> + 		break;
> + 	default:
>  -		bit = bitmap_ord_to_pos(maskp->bits,
>  -					get_random_int() % w, MAX_NUMNODES);
>  +		bit = find_nth_bit(maskp->bits, MAX_NUMNODES, get_random_int() % w);
> + 		break;
> + 	}
>   	return bit;
>   #else
>   	return 0;

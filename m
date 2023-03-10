Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1C4D6B5292
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 22:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjCJVKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 16:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjCJVKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 16:10:34 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E692812087A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:10:33 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id c10so4437762pfv.13
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 13:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678482633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIWDLeYtEAYfgg25NNegNAWenGQW3HXHu20am2x2WUM=;
        b=iWDEIbP5ufsIyajRgL8qmFeiq2H4xyll9lbRwch4uhitclQkYQQ3vrfVTJ8fJxBrrl
         29v16Dp+WFXE0eWu7ZRga8J7YRJOYWWVZiUS8Og70PvE7SPn9DPxbUomA/yIAT/Jz4TI
         zrtAoI9QwrlHOWS/C64CnqgakzXcvN7mQsoYqeB27PtHi0Ieo7q89gsAMqP4BCbPXkn5
         h7k5y/bwS/8fSnyAq7/8hIamegU3mPHW/mzeZYudaeOUdW5p0gN3oDVzHh9kdHP+gfEI
         62U/sz256QDVqjY2Tb0AreTtyIKXn7z6gB/XSo3z9a81noJvm2TLx2vohr3JputA9gkU
         +ujg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678482633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LIWDLeYtEAYfgg25NNegNAWenGQW3HXHu20am2x2WUM=;
        b=SywuKJvnz0ZAGYu/ZBk1CbSO/0N7aNwOUckNAqmb4r8LiK1pkhU50DtRiwh07Rvf8Q
         kC8UUyGBmfEd7xDsWXg5sejcWkTnCAtF0I6vn5CDgefWgm2CWHvOZSiudjodRoPBCGHN
         F9CBAv/eCXFotdAGRR5sRUAoU0TEeE5XwW81LyyaklYJRWM3hOWcuroCaptiR7OS7qPW
         /Ns3HS5UjI/Cqd/icRa3JHuF8KKMOTmk4z+wSV561mGOm+OI8hQ+GHSizfvb2iVCTU8g
         9blhoessSv5tF/zgH7ukyWfvC8PGkp59KjAfdkte+Cf+feUIDGlavRIaY0mct0iGAEH0
         gc0g==
X-Gm-Message-State: AO0yUKW8Mf4+b6++YfFJ59e+nfDJvqcjW9DjwEc05GFsS3r6PmvuQm7N
        U/ZWDeX9+LOKairExw6npkk=
X-Google-Smtp-Source: AK7set83+7nDeFJkYLrcYT7ntb5qXkZerr/N2Pp8BHSDheqQAM96rS6PAKSvg3KIKt19OAfG2RV3BA==
X-Received: by 2002:a62:7982:0:b0:5a9:d676:ae58 with SMTP id u124-20020a627982000000b005a9d676ae58mr28353952pfc.13.1678482633403;
        Fri, 10 Mar 2023 13:10:33 -0800 (PST)
Received: from google.com ([2620:15c:211:201:cc57:d271:da5c:ca8])
        by smtp.gmail.com with ESMTPSA id w18-20020aa78592000000b0058e1b55391esm227823pfn.178.2023.03.10.13.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 13:10:32 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 10 Mar 2023 13:10:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv4 0/4] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <ZAucxpUG5/6Y4GSL@google.com>
References: <20230304034835.2082479-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230304034835.2082479-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 04, 2023 at 12:48:31PM +0900, Sergey Senozhatsky wrote:
> 	Hi,
> 
> Existing zsmalloc page fullness grouping leads to suboptimal page
> selection for both zs_malloc() and zs_compact(). This patchset
> reworks zsmalloc fullness grouping/classification.
> 
> Additinally it also implements new compaction algorithm that is
> expected to use less CPU-cycles (as it potentially does fewer
> memcpy-s in zs_object_copy()).
> 
> Test (synthetic) results can be seen in patch 0003.
> 
> v4:
> -- fixed classes stats loop bug (Yosry)
> -- fixed spelling errors (Andrew)
> -- dropped some unnecessary hunks from the patches
> 
> v3:
> -- reworked compaction algorithm implementation (Minchan)
> -- keep existing stats and fullness enums (Minchan, Yosry)
> -- dropped the patch with new zsmalloc compaction stats (Minchan)
> -- report per inuse ratio group classes stats
> 
> Sergey Senozhatsky (4):
>   zsmalloc: remove insert_zspage() ->inuse optimization
>   zsmalloc: fine-grained inuse ratio based fullness grouping
>   zsmalloc: rework compaction algorithm
>   zsmalloc: show per fullness group class stats
> 
>  mm/zsmalloc.c | 358 ++++++++++++++++++++++++--------------------------
>  1 file changed, 173 insertions(+), 185 deletions(-)
> 
> -- 

Acked-by: Minchan Kim <minchan@kernel.org>

Thanks, Sergey!

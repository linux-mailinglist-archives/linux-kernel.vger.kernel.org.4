Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F046107FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:31:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236197AbiJ1CbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiJ1CbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:31:20 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BEBBCBAE
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:31:19 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so8582496pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 19:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAUHHH/m0eIDeN4f4s+iXMFmqb+KGK4/n0ZCUCCOc5I=;
        b=aSJM+OG1FhyemlYtNwTjw5ZV4VuGb+rqhlQAT7rtmCvgGxlpk6ZnaI2nltig9f4BbZ
         0PHobX3HoAX2IxGudWVhQ6GzIsWvwD92Ad+AqVY3003VaLigfymIuruJNDEkJ2/30Xn8
         dxuLieOP54d6pyehSJRWCTwwCRMwpyRQo4cNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAUHHH/m0eIDeN4f4s+iXMFmqb+KGK4/n0ZCUCCOc5I=;
        b=4mPElUkblCeQk9oOGqIVLazA6FMCSYa2yR9xQ/VLlA5ehXSm1+B+Bt15D8+LtwJ8qF
         mf98jceOPaHOwxglHj73VJzq4w3DyfejALuAVEXMt3Jq+nI0unq0gCD2rICBMw91ePuT
         W75R5oEJDuHTWtnQBnbfbSm5J3Va67HfTxmmteeRXxkC/J2LPoryERRf+064dQ3DPcKH
         g+iQ45ldeY0UaMM4fj/jmeGgBfiHR9R5Cr/bzTKG2SrEscGpoxeLC1JtMaMX08L0H5DW
         aoBo6s5ot/yOkelUsVvroKmspPksB+LTkN59ao9ftnQ9JHl1FNkIxThfiO7p1lEpOAdS
         3vVA==
X-Gm-Message-State: ACrzQf2d2yS3TDehBNoJzvBpG5lV3NCM4Dy9kM4St3nBRr8dv0H1Ig0+
        2GB1VjTCO4Mhkkc6ImkIoWeXiQ==
X-Google-Smtp-Source: AMsMyM5nOKKnkWR9Ks8X1/lz1RvJR71ZgqIIeKuYxY6WVk4l1o1x/tiZwsP6ykw6vNdeD8zsm0YyYA==
X-Received: by 2002:a17:90a:1946:b0:212:f926:5382 with SMTP id 6-20020a17090a194600b00212f9265382mr13460581pjh.218.1666924278543;
        Thu, 27 Oct 2022 19:31:18 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:dd1f:6bfc:e6b3:cd8d])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a818500b0020d9ac33fbbsm1623721pjn.17.2022.10.27.19.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 19:31:17 -0700 (PDT)
Date:   Fri, 28 Oct 2022 11:31:14 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mm-commits@vger.kernel.org, ngupta@vflare.org, minchan@kernel.org,
        avromanov@sberdevices.ru, linux-kernel@vger.kernel.org
Subject: Re: + zram-add-size-class-equals-check-into-recompression.patch
 added to mm-unstable branch
Message-ID: <Y1s+8ohGRlutI7aI@google.com>
References: <20221027200348.1BC0FC433C1@smtp.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027200348.1BC0FC433C1@smtp.kernel.org>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/27 13:03), Andrew Morton wrote:
> The patch titled
>      Subject: zram: add size class equals check into recompression
> has been added to the -mm mm-unstable branch.  Its filename is
>      zram-add-size-class-equals-check-into-recompression.patch
> 
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/zram-add-size-class-equals-check-into-recompression.patch

[..]

> Patch series "zsmalloc/zram: configurable zspage size", v3.
> 
> It makes no sense for us to recompress the object if it will be in the
> same size class.  We anyway don't get any memory gain.  But, at the same
> time, we get a CPU time overhead when inserting this object into zspage
> and decompressing it afterwards.
> 
> Link: https://lkml.kernel.org/r/20221027042651.234524-1-senozhatsky@chromium.org
> Link: https://lkml.kernel.org/r/20221027042651.234524-2-senozhatsky@chromium.org
> Signed-off-by: Alexey Romanov <avromanov@sberdevices.ru>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

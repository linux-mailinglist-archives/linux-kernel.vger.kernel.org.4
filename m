Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA8367BD8D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbjAYVCU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:02:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236602AbjAYVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:02:18 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5CCD222E7;
        Wed, 25 Jan 2023 13:02:17 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-15f97c478a8so58868fac.13;
        Wed, 25 Jan 2023 13:02:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qy9hdSdytx4WlUpLP7AkbgycuXVsEcln1aautfJdWs8=;
        b=l4gTx7EVOxd+X9EB9oMpAnPj7JMfUJ4ijU1blUOZB18BRj0Biu1O909p2cG0O0UWIQ
         LqDLo6pPivzhStyzyIzVCBRj2mQ+1EIIq6nvvCMHIdQi+jlPNR9zNFmB/lOj+G6bQuZt
         xV7Y1mTfyHiKw4nFbYPJgvi2jdFBoUQP8+yjobMEtTHdDYkplP1tkleFAfaQr5VpmREE
         TQaibMeWlr1w1wTokiS3uPogTtAbP/iqN5PbYYRVy2vRSYVEqy2b7AGZ5lM4STt0Zw84
         RcOYAWzqfCNnp6FVPQDVpyDFUGLyTIkjBIleAMXeYd3JzHMsk54sV7hZxJI9Joom73it
         MfNw==
X-Gm-Message-State: AFqh2ko55gsXh6RU6mAkTPjTRxW1pEYNFMU6Y+UdTYB+bc6eiYQJbSl+
        rMZ4MGnWzniWR4mlqIutBQ==
X-Google-Smtp-Source: AK7set982YuB9zviVDeEJ8iQft1DYsVnb0qtXC/RPUZ4pZC3ngkO0EG1QPjG0FKrtdt1kl6Lz/QPxg==
X-Received: by 2002:a05:6870:4722:b0:163:18f6:e5a8 with SMTP id b34-20020a056870472200b0016318f6e5a8mr4192613oaq.42.1674680537120;
        Wed, 25 Jan 2023 13:02:17 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m24-20020a056870059800b001446a45bb49sm2355759oap.23.2023.01.25.13.02.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:02:16 -0800 (PST)
Received: (nullmailer pid 2890158 invoked by uid 1000);
        Wed, 25 Jan 2023 21:02:15 -0000
Date:   Wed, 25 Jan 2023 15:02:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Isaac J. Manjarres" <isaacmanjarres@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frank Rowand <frowand.list@gmail.com>, linux-mm@kvack.org,
        Saravana Kannan <saravanak@google.com>, stable@vge.kernel.org,
        Calvin Zhang <calvinzhang.cool@gmail.com>,
        kernel-team@android.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] Revert "mm: kmemleak: alloc gray object for reserved
 region with direct map"
Message-ID: <20230125210215.GA2879887-robh@kernel.org>
References: <20230124230254.295589-1-isaacmanjarres@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124230254.295589-1-isaacmanjarres@google.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 03:02:54PM -0800, Isaac J. Manjarres wrote:
> This reverts commit 972fa3a7c17c9d60212e32ecc0205dc585b1e769.
> 
> Kmemleak operates by periodically scanning memory regions for pointers
> to allocated memory blocks to determine if they are leaked or not.
> However, reserved memory regions can be used for DMA transactions
> between a device and a CPU, and thus, wouldn't contain pointers to
> allocated memory blocks, making them inappropriate for kmemleak to
> scan. Thus, revert this commit.

Both commits talk about the same type of memory as CMA is used for DMA. 
Neither commit tells me what are the implications of kmemleak scanning 
or not scanning the region? Are there false positives?

> Cc: stable@vger.kernel.org # 5.17+
> Cc: Calvin Zhang <calvinzhang.cool@gmail.com>
> Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
> ---
>  drivers/of/fdt.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

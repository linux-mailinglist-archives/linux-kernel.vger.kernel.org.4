Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651C362EAB2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 02:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbiKRBC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 20:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240767AbiKRBCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 20:02:52 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B53584324
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:02:52 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q71so3651690pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 17:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mytBWO+CQoCJkiJKhqFPMnyyE8NpwhXQDSgmrAOfMWI=;
        b=C3kP93/2hRKfp0hjEdA8y16GEv2aug8vq1WelUflwEktGUKJozYxz1Oyk352X5/gZb
         S8cnhEWnjbR8gb4WnCKlfXvPRsshf0Yg8KMPAnIV8R0ts5m9aKTZJeAz0O8qt5xMlFzA
         r/p32pDO73ETb/Yg5OHYTnkL4TZgpKZXSiOHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mytBWO+CQoCJkiJKhqFPMnyyE8NpwhXQDSgmrAOfMWI=;
        b=WLQTT/AOh+3zdeNjVzILA/s+iafA0qzOaZI2mYHW6S3RqAjS6/Q7vD1lWEhKHEehPs
         SjyVPsTeFswwPrJCWu+oI7S6L3mRjw+inbhnufp+BxhuoAHkw8mxfXLWwUNkfVW3yK7e
         VRaD+km6HS2y6cD0MgJSzF/RTiO9h7ZNoLinbHG1MjolTOUl5tV3ilnZA5uNNsTOw+9I
         CFJzaMF8Nhsr4/2Dz6C0njBkYKV+tSFuAYU1ww2doRagVpHSvG80aDtBmENv6x8eCMV8
         WnYyIDd38g+MVWrKfEHlRMzx9QqrXrNbbAHNPUb35V8pNIsvnCODahIRkArbTE/fqQAx
         Lxxw==
X-Gm-Message-State: ANoB5pkSECACg84RZ2PZbKMgvNJecXfEpjt3tB2rXGOGGSgeowVd2IMt
        gvmkSKBXjMfuc8Sq7L+p9d5IRdJTxGsfAA==
X-Google-Smtp-Source: AA0mqf5Tka4ddcrPjK04gCK9hWwAK1vs/Qx+ZGNGhJZQOT9eyKn44KFMGxU/pw78w/0OZP8jNwwmBw==
X-Received: by 2002:a63:1f1f:0:b0:458:6f51:ff7b with SMTP id f31-20020a631f1f000000b004586f51ff7bmr4544063pgf.153.1668733371651;
        Thu, 17 Nov 2022 17:02:51 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:d2ea:7e44:a26e:5eea])
        by smtp.gmail.com with ESMTPSA id n14-20020a63ee4e000000b004768ce9e4fasm1665561pgk.59.2022.11.17.17.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 17:02:51 -0800 (PST)
Date:   Fri, 18 Nov 2022 10:02:47 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Docs/ABI/zram: document zram recompress sysfs knobs
Message-ID: <Y3bZt5bxTZPBILoi@google.com>
References: <20221115020314.386235-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115020314.386235-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/15 11:03), Sergey Senozhatsky wrote:
> Document zram re-compression sysfs knobs.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Minchan, can we please get your Ack on this? This adds missing
bits of zram recompress documentation, which we land in 6.2.

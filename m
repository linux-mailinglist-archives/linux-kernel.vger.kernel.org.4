Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04020624EEC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 01:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiKKA0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 19:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbiKKA0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 19:26:47 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925D61BA1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:26:42 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 6so3109771pgm.6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z5NGc0Wtc/LAmeM4ZbbbL8b0+UEPmBPAYTp12Vkl1o0=;
        b=OYVMNqSYsFjm1l8Gb77rL89LoGY1zcp9Xm6VxVICPuHEclqOVJvgjkuoDATdF3jc9z
         WQ362RA9vIleTOkpT9IQ12tgbW8mtK8oT7L3E9avA34iV1hjk3pk/jNAVGr2HGyTnBTF
         IFnm+HQJ7g8P5sFjNIAVrYXFIK5sf1GV4jQYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5NGc0Wtc/LAmeM4ZbbbL8b0+UEPmBPAYTp12Vkl1o0=;
        b=30i92q0YhZkN+V0+j72wEMVKXMxG42ZyX6s3deM5btV+pzocImIw8/KBoL7heApyUV
         oVVN3WklywlzxqEErvhuOqtTb9kvy4Vmcj7WZZq9KnbJvvqpB4prNo1SJf28zCQdeUZ/
         EKURvQhObWSml6Q6hHRvWLIFcAR0dZB8nXdErIFGqj8pCaoW8GiBiMKImnEJ/6SC3bU/
         /HoUlLaRhbSP8izMnsTII7oNwl6sLTTu6fO+ZHwXbe4mHmEfdFoDkFVIIPTlx3MyN3dt
         9L+plHoy6yKR83A3qwLsiYGpG5TXZfsh5wUXRdrnNTwLUvc+BnACoPfMzVbr26Vq9kDu
         lYNw==
X-Gm-Message-State: ACrzQf3C+aSlt5X7utHUHn7C3bgMZOubALc5YWzdpFef23dNM3cOC+D5
        ysZDwBAQ4AmTrDcuhhKC1uDGh5WD/t2E1Q==
X-Google-Smtp-Source: AMsMyM7Kh7CVcxqJugz4JnRLlCyj+VNc2Jl1ZCgSFYUBWm/peCV0U9rmVHoHIjznkrpRLbvkAA1Bdw==
X-Received: by 2002:a63:5543:0:b0:46f:ed3a:f38b with SMTP id f3-20020a635543000000b0046fed3af38bmr3803064pgm.387.1668126397981;
        Thu, 10 Nov 2022 16:26:37 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id t6-20020a1709027fc600b0018703bf3ec9sm288513plb.61.2022.11.10.16.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 16:26:37 -0800 (PST)
Date:   Fri, 11 Nov 2022 09:26:31 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     coverity-bot <keescook@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Alexey Romanov <avromanov@sberdevices.ru>,
        linux-kernel@vger.kernel.org, Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Suleiman Souhlal <suleiman@google.com>,
        Nitin Gupta <ngupta@vflare.org>, Jens Axboe <axboe@kernel.dk>,
        Nhat Pham <nphamcs@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: zram_recompress(): OVERRUN
Message-ID: <Y22WtxzDXM5PfFnb@google.com>
References: <202211100847.388C61B3@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202211100847.388C61B3@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 08:47), coverity-bot wrote:
> *** CID 1527270:    (OVERRUN)
> drivers/block/zram/zram_drv.c:1727 in zram_recompress()
> 1721     		zstrm = zcomp_stream_get(zram->comps[prio]);
> 1722     		src = kmap_atomic(page);
> 1723     		ret = zcomp_compress(zstrm, src, &comp_len_new);
> 1724     		kunmap_atomic(src);
> 1725
> 1726     		if (ret) {
> vvv     CID 1527270:    (OVERRUN)
> vvv     Overrunning array "zram->comps" of 4 8-byte elements at element index 4 (byte offset 39) using index "prio" (which evaluates to 4).

Hmm... I don't really see how prio can evaluate to 4.

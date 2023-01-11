Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39EE665E54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:49:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbjAKOtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjAKOte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:49:34 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD3D6EE29
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:49:32 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id b9-20020a17090a7ac900b00226ef160dcaso15687884pjl.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 06:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yW8vy78r5/CaJ+7JPaSH55j7YIiKU2q/2tyilmGr7VY=;
        b=uqaNLzwqoyie1yMZ8bKUfxYvMpHBmor0F5f2p7il9PAgUPhNL1mWxIXl4stcdX5YQm
         mcRrkZP7vl+11YnWaZ05ogkXVpu3v46XfoPdHq8ql8TEk7qiKXybUVYFkNFmx/x0MMaT
         tCHhdLdu3m2fa8Q0mK35isWG1V9mOA8KiKRn+F/QeW8W9prZ+t98CVZPPq2lau/ZPqIe
         ioQaUm6aCLHNFmECFE3KTDaBG9/yw7osa3fFlF9M84uJ3fcC4fTMSCRlx+4mDajR+IzN
         boGDtGQZcKAzW5/oPeEPAbnAv9hpWa2otveBuVtO5c+D1ppttnWw9PyuEOiRyuNps4CT
         evEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yW8vy78r5/CaJ+7JPaSH55j7YIiKU2q/2tyilmGr7VY=;
        b=aJOU2ERmax7OnAwZuAxmrlFzPLUOVZ15daZ6NEJ5C9rj4s2XRZBO0Wygb+wmsNX1R0
         OGQrvmCM2LaCOuH26ZlLXNfNyQ28XDsYcBgB9Cr294jU+k7QSZUhciRLJ1rGhKyFA9Nd
         fUXY72qJjHCrTCjCa92Hrsr4KfiQ1aNrgo0vfZFeJh4m2IEzVIYcp0vicrk9Lxgztsze
         OTopnJLPdkwubQc0wi/nUQ9ABeXNg1L2IaanpRhqke5IFHPXAriELa/dfM42O9GMGHFZ
         9rjtDuGOswFpDlBICdxtoGcmwv5Gk+0aBHZyBJqFHSVYSAGV1MxGiKnceostuzl16WfQ
         bwDA==
X-Gm-Message-State: AFqh2kpM5V6TNtY5i0nIhK13qH0t+y6rDXgqa24kISIrOv8ZjH6691Zh
        Xlv1Obcim4jZTKHCy5uQi1YGB+VkZVp+ZhDY
X-Google-Smtp-Source: AMrXdXs/LnmncAUxOJciTiscI3S1kf8k8Azjv6Ail+7XwYbQxAT/n9d29Pe9YmHsFBNbahlQ7ogrrQ==
X-Received: by 2002:a17:90a:bd0c:b0:219:3e05:64b7 with SMTP id y12-20020a17090abd0c00b002193e0564b7mr17179052pjr.0.1673448572299;
        Wed, 11 Jan 2023 06:49:32 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id t12-20020a17090a6a0c00b0022713d5733esm1728465pjj.30.2023.01.11.06.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 06:49:31 -0800 (PST)
Message-ID: <63d8e95e-894c-4268-648e-35e504ea80b6@kernel.dk>
Date:   Wed, 11 Jan 2023 07:49:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] io_uring: Add NULL checks for current->io_uring
Content-Language: en-US
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, asml.silence@gmail.com
Cc:     io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        TOTE Robot <oslab@tsinghua.edu.cn>
References: <20230111101907.600820-1-baijiaju1990@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230111101907.600820-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/11/23 3:19 AM, Jia-Ju Bai wrote:
> As described in a previous commit 998b30c3948e, current->io_uring could
> be NULL, and thus a NULL check is required for this variable.
> 
> In the same way, other functions that access current->io_uring also
> require NULL checks of this variable.

This seems odd. Have you actually seen traces of this, or is it just
based on "guess it can be NULL sometimes, check it in all spots"?

-- 
Jens Axboe



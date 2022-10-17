Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE7B601107
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiJQOWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiJQOWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:22:50 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B2F6564C
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:22:45 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h12so11159503pjk.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jRSby5zhVSUVlEq+bbR1NcNPmHFAP8cNa88Q45JNK3g=;
        b=HQhY+g88ZnIP+kH7iqiHbNxB7iaeCzxhQZR0j13oHGBfzT+oMoWpvcv2pX9S/VPL/A
         S3IfylQ9P8lH4s2NLQ6QEyk+PmoG/OgF24tZNp+2q8C+J6Y9RiAS2lKD5Ijl4w0kq8Hu
         uD2/0f0FfaFuVj4xm1ax/Su0ic+/3BVra7XEFbyws588cK+JC6n2U1NoRl8Enlix0JX+
         1csPc4RcLXmMKF61/HV1PogJseiRW9MSf03i/7JAx0AHAeJwoTGjQZiTmel4tSoED3iJ
         DeceZsBmI2PtBtzqCVGYUw4eMHCfEOlu9rKS5KYDsV7SdiDxhGPVOSlv/Hqs07HTeEBK
         aPqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jRSby5zhVSUVlEq+bbR1NcNPmHFAP8cNa88Q45JNK3g=;
        b=iFpkYFnH/zwerk19iNwgvtrfO1LNF6aNKkluGIZ36pI0JrRGnMYYj7xXZ2PZDBmuML
         0GOIsvn42ToGPj3WmWHGgmW0Nw2zB/AgdSts/yazSBwVg14HCrcY+SYeHUKvVKnk581N
         J1L1R9R5QOGJkBysuDLVo8crpsmOTk+bHOuiTfB8x6j972MwJCBqHNoyTUS4Nn6V56tf
         9EvvY4wWPAJWJK4TDS1XigpILJhg26PL7TIQA3omD8asoKv5xh/n63XzPXx4hTB+yNR2
         wzZYE4UJIl3dWGkF/pXv2QyXn0UMeRo60qLniLBdevrkqxIGccBlbi8LnCJF46t73rwY
         2Bqg==
X-Gm-Message-State: ACrzQf30P3toWtHKjBMvHATBK/PFljOfjAlDTk2v3PFxnHStl8/roeEf
        099NbeafKAGdj7XyauLYrYnLRg==
X-Google-Smtp-Source: AMsMyM50KWzgYIMmz7/3yb4h+y0bnJI6wCzK2l2zIpYBnb278tJXu3bJkMqOsgQoWoygRDsU6P8zZg==
X-Received: by 2002:a17:90b:e0e:b0:20d:ac00:d261 with SMTP id ge14-20020a17090b0e0e00b0020dac00d261mr13485859pjb.214.1666016563651;
        Mon, 17 Oct 2022 07:22:43 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id f131-20020a623889000000b00561382a5a25sm7182627pfa.26.2022.10.17.07.22.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 07:22:43 -0700 (PDT)
Message-ID: <79b12322-4298-2a2f-c126-a00071e31f1d@kernel.dk>
Date:   Mon, 17 Oct 2022 08:22:41 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] drbd: Store op in drbd_peer_request
To:     =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Joel Colledge <joel.colledge@linbit.com>
References: <20221017090154.15696-1-christoph.boehmwalder@linbit.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221017090154.15696-1-christoph.boehmwalder@linbit.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/22 3:01 AM, Christoph B?hmwalder wrote:
> diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
> index 4d661282ff41..0f8e3b94a635 100644
> --- a/drivers/block/drbd/drbd_int.h
> +++ b/drivers/block/drbd/drbd_int.h
> @@ -395,6 +395,7 @@ struct drbd_peer_request {
>  	struct drbd_peer_device *peer_device;
>  	struct drbd_epoch *epoch; /* for writes */
>  	struct page *pages;
> +	unsigned int opf; /* to be used as bi_opf */

Why isn't this blk_opf_t?

-- 
Jens Axboe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDFB4750926
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjGLNDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbjGLNDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:03:23 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D18F1BF5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:03:05 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fbc12181b6so74615385e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689166983; x=1691758983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSRULxvfLJxd6xzB1HBFWn8lQ9a6bu29n+o7ble+0oM=;
        b=2Z6WUbg1BWfF9ziHsWsCLY+MUOoAcNFaklTXzSkZTQAlSdmVciQlqSxCkebunsw77u
         LsGvxOMKtNSVgfYjLdg5YVqbnOhiP8Kx0cNvc/UFKgVNXQRKEjCW76Hlm0N+iOv5ItJD
         Mc7CXlmor8Owt0aQp+syL2YDWzajC1YpA9b52xkVguI+01mIMcL0kgOHMvuj8vFS4h0y
         AUYeP1rYDTEW6z0s8cHCdBxrYYD0YRZ85jXAstxebOFMV6J7tD+TQECeCWUdxYJnL7WR
         sotm903lEjclBbYdIgSygvPzQk/sm2XkskduBMCxydqTWvnd/9EX5Xkhn25oYf6hjHxM
         0Frw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689166983; x=1691758983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSRULxvfLJxd6xzB1HBFWn8lQ9a6bu29n+o7ble+0oM=;
        b=ZKQ+nwYu5y/membD3g66u24Dkr5MZs0o3pyerebueA7G8fpG/adshHtisSC9POJ71r
         /fvy/hx0ZpfGCEFJwyLkohwQOiMWKZf0YZDDUDnhYsIO5tYorDN5qRQBX9MhaslHjVMs
         IZOL/HOAQQfAyuuGU6Di+cSrlFW3rWlwRsp+wh+F9V5Qprj1sa1YJqh9TBd0aK650wWr
         +nKtY+BWOXN6ZPkWduw8A/oErUVFIvcp0HdvqGVAAhtOXk8AqzVaaAmoU4yrpi9NU1A8
         uFrpP3nduERJv+eJ/r74+OEoDbqBXBLMrs84rYL1Mmc/amB3+1ipr6+VZ/NJ0D9s5Ow5
         Harw==
X-Gm-Message-State: ABy/qLZSf6CDv9HYKawuXUqJMO+uL1wYCz6+YNMe9IxpxTGleIlLFg2+
        WMqXPz6nLsA1GXpSbh4J5FDA9g==
X-Google-Smtp-Source: APBJJlGSQc4f/DWJNPIm30X0RCk8ibYVWS/PzA68G9YIu/iC0V9OZ7UmT4v3sNNuC5ijsDPsj3unFQ==
X-Received: by 2002:a7b:cd8e:0:b0:3f9:b9e7:2f8d with SMTP id y14-20020a7bcd8e000000b003f9b9e72f8dmr17191551wmj.2.1689166982085;
        Wed, 12 Jul 2023 06:03:02 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l3-20020a1ced03000000b003fc0062f0f8sm5101025wmh.9.2023.07.12.06.03.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 06:03:01 -0700 (PDT)
Message-ID: <c331bfa3-443d-0976-fb14-e6e97fbd7d58@baylibre.com>
Date:   Wed, 12 Jul 2023 15:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] drm/mediatek: Fix iommu fault by swapping FBs
 after updating plane state
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jason-ch Chen <jason-ch.chen@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        Nancy Lin <nancy.lin@mediatek.com>,
        Shawn Sung <shawn.sung@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230710093253.32224-1-jason-jh.lin@mediatek.com>
 <20230710093253.32224-2-jason-jh.lin@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230710093253.32224-2-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/07/2023 11:32, Jason-JH.Lin wrote:
> According to the comment in drm_atomic_helper_async_commit(),
> we should make sure FBs have been swapped, so that cleanups in the
> new_state performs a cleanup in the old FB.
> 
> So we should move swapping FBs after calling mtk_plane_update_new_state(),
> to avoid using the old FB which could be freed.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

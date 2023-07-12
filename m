Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73975092F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjGLNER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233544AbjGLNDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 09:03:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1DF213E
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:03:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3141fa31c2bso7009607f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689167021; x=1691759021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3gVKLalCnKJyVFKEYA/aeQE5NMhQhDJSpVDflsC0RHE=;
        b=yS2Ymfgh8L3mPR+FT8+S9ZseYw10W47Ifo8rhgAW43xrjdyH9QSUS5LxotXGW4pM4j
         LCLIRcxYm/XsY4hUvCG9UZCcIeM+zOwsz2MCi+1Fce3BOGQ03vV56S7aLFXb3JTfLCzo
         nigRNcdTBLQka0/SbQJvcjYTp5xXsGeBqzYKX2NnMVmKQx/IGvqJ4rf2IhcIwl4dZKlN
         2PvDu/UtuPimR3goJZDNwu2DopYqClTptxG4Q8SEDCTVnjleElknDIndTBvPv270AqSH
         OGMg3kWOxudgkaggCpcRd2jwVY6HXoQNwGjd6uxLP3xmSaP41B8WjbbOBj2nwlpXl2et
         o7dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689167021; x=1691759021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3gVKLalCnKJyVFKEYA/aeQE5NMhQhDJSpVDflsC0RHE=;
        b=isNBpw1ZoNGkDnm3gr1Mk4vvsuwuc2HoCUe0CYPXB88ZNxQQnQXlblg9IE6J0nu6IK
         l8GbSBFq+clYp0fei0q2nue8nxdQ9obn18ZbwbMWpXKh9pFWXbksrc/G52ZNOxaybZwg
         6+2Hh+IZkKPLOAR7tIpLNbCBH3TZU3bdMgCdaWFdseaAqpDYtUNskEmR9ingtPbrmsTq
         hjHgCHiwTTgfZ7j+LmBuHtCLQZo1kfZrMLkZ8ojKJwa3sEpyvcH+G/L3GWeFP4dy51zD
         MitsTDr+Xqt02qHfjNWcBqEZD5ILUkJPFIJHjaJUw/q8g5mZ5SuJr/+tGxf5x+27+bsm
         GiIw==
X-Gm-Message-State: ABy/qLaC8v5CuBhfOGDoU2JJhWQReFGQiA06Fu4EO1LoodscS+6u68Jz
        hM6LMe04QGwGShdHLFbCt5EfRQ==
X-Google-Smtp-Source: APBJJlGI2b047RWaYG6CTnzPtae20KR5OjN1EgJIkCgV1cLrD0xJ5uB3HcXw1wrHwP5ZVgcWayCYmQ==
X-Received: by 2002:a5d:58cf:0:b0:313:f399:6cea with SMTP id o15-20020a5d58cf000000b00313f3996ceamr19407509wrf.4.1689167021315;
        Wed, 12 Jul 2023 06:03:41 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id k2-20020a5d5182000000b003143aa0ca8asm5082491wrv.13.2023.07.12.06.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 06:03:40 -0700 (PDT)
Message-ID: <3fd78e84-b16d-e1fc-85af-d19efafc83e0@baylibre.com>
Date:   Wed, 12 Jul 2023 15:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/2] drm/mediatek: Fix iommu fault during crtc enabling
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
 <20230710093253.32224-3-jason-jh.lin@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230710093253.32224-3-jason-jh.lin@mediatek.com>
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
> OVL layer should not be enabled before crtc is enabled.
> The plane_state of drm_atomic_state is not sync to
> the plane_state stored in mtk_crtc during crtc enabling,
> so just set all planes to disabled.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

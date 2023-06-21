Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD90773838F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjFUMPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 08:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFUMPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 08:15:21 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF89110F6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:15:20 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9741caaf9d4so712131266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 05:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687349719; x=1689941719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WILflar73P9grdlRUg9RO2U9WLt2s61ZgDHgOf0roCg=;
        b=fA/GToZx8rTkl4+8te9h0sgmdRmFX73L6r+lbNg9D+OIxz5sP/Hh/4vw1yEiS2brzx
         Eh8+ulOe891pexuYL28+KmrKf0hxfWpGiyLPYbH66ZRgS+nYwJBknEPqvpNFoWSaYKTA
         iGPg1hSa7mD/IYXnO6A81bLfXCKZ8owbM1wTTg6vEU+Jq9JihFKP7rZYuy5DAGwDsj6R
         IVmzrJB5seub/+/b1qyZKanzuT8ybBM3bkZJtM5f0SsAKo5HfxihUsTGzapMaoulw2Wi
         kCulasgakjKqR2j0Ff31/2BePi7GF+8WTquoLn/fYBfkquwyOoJZZnfXDmJlhg44U4iv
         CsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349719; x=1689941719;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WILflar73P9grdlRUg9RO2U9WLt2s61ZgDHgOf0roCg=;
        b=jNUGuXiUnYisKvlqNAhTvddQMOaDMYSTWETeLQ9QboMJw/qPw8SPVfB6z930V/fZRp
         Iq7J01S+Qn0cuSh/j6Kt5smoqtBNLIdDC/9aGl13MwqGKXo60omSQlcVPPPPblbkeDPn
         A/Lbofy8rshhcaiEzTasQNGW574jmtowXcq6gLfV45dDN9yY8Z4n1x9BvkJnzN6bZEqA
         HekxyS/CvbCNV9V+wCgXD/3RMJaoExzAmBsP/IecqXG2S/SCuVJEHRy3iyRkhjTUftEx
         8mFv/zCyupDm9V6xjsqLVf90mIGAcn/LbdchJXCfR5S+7xJvz3r8uCbrl6m+p3IYUypZ
         WvyA==
X-Gm-Message-State: AC+VfDw2IArWoFnsPhJd382hR/HB73+ms5LO46SrdMU4/xwPulp2RT/S
        W1SfndOjQsg/WB649sEDaxjcIw==
X-Google-Smtp-Source: ACHHUZ7azvcvHBW+wPfSgRuwA0WGdeEm0dZ/FYXf5fv6pTmWqmIwCPGWA2q3H4YY5S3xPaR/CRr0KA==
X-Received: by 2002:a17:907:2da6:b0:988:99e:9798 with SMTP id gt38-20020a1709072da600b00988099e9798mr12028501ejc.43.1687349718972;
        Wed, 21 Jun 2023 05:15:18 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id me16-20020a170906aed000b0098669cc16b2sm3017631ejb.83.2023.06.21.05.15.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 05:15:18 -0700 (PDT)
Message-ID: <b0a2d809-943b-d5fe-fbb4-32d23e501ae3@baylibre.com>
Date:   Wed, 21 Jun 2023 14:15:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/4] drm/mediatek: Add cnt checking for coverity issue
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
References: <20230621102247.10116-1-jason-jh.lin@mediatek.com>
 <20230621102247.10116-3-jason-jh.lin@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230621102247.10116-3-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 12:22, Jason-JH.Lin wrote:
> CERT-C Characters and Strings (CERT STR31-C)
> all_drm_priv[cnt] evaluates to an address that could be at negative
> offset of an array.
> 
> In mtk_drm_get_all_drm_priv():
> Guarantee that storage for strings has sufficient space for character
> data and the null terminator.
> 
> So change cnt to unsigned int and check its max value.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A7C749B7E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGFMNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbjGFMNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:13:37 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B4519A0
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 05:13:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso8006955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 05:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688645613; x=1691237613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/5wxHDy6mL4FcPapG0NJLXj6++vEZT2MS33NrQ/lTQ=;
        b=IbzlafQusCaKto71OXk4bPoXEo7+FCrn+i1Hk7cATXwj6jD0FU8RZdq5IA1kP7kLfv
         3wa2qn53DE926m9gNw+SaXT8iilPDkuOnkdWh3rudUNg4TkmKbsep4bvf6f4ina/mf0n
         DRzQ5WErugGScBJuVhHq5WnqfJ+sbM8TC8wciV21yFhQIkvdpuXBfsE0yBYDKWNEyEzu
         lpnbDPWvcKk1agZbeYhhPixhkIwdNkyTBaE4WrvBvWEH7byJOAeR7mDKtmdQTgGRv1FI
         o1xazO6BOLl8JRFEvxnms30i4deFFBhipFbK+xh41OKOpj6wb+fGF1re4lHoK4boQTQD
         xVYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688645613; x=1691237613;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/5wxHDy6mL4FcPapG0NJLXj6++vEZT2MS33NrQ/lTQ=;
        b=QGoHCdp7mgp38+RF6sd5CGVpbnq9LnkssaUdnFCYmJOfN0oJWXEJTwTClcHj3z9c/p
         eaBh5z63dCEnwl0J4FY+2Z+5CHRR74/IDqzBLbuTHfRolkTSiWwft7Vkk8d1Dnfnx1ZK
         oTe09K8aIbqK7EfrcQQOLaIKUpLs3ymySuPwUkE8X3OsykvEQJvdsw+JNg1krlZk0luV
         scckZKdhkaE+DkQ3BQF400VImDBkwMA7h/eU5U4d2jsH62rz71+a7vrHq4Jt6O1Gspjn
         sf1KOUp5aIb1+Yem3qzwBQqvqC94+ljK/HyLwLIgOPYS3QVAVI+N7bLe6uihIGJCzxBM
         gUvA==
X-Gm-Message-State: ABy/qLZzW20UXN1xyr5G0CD98iprE2uQT5qNhjQ5atPEE76rROPkxjjo
        PypHy+NE7kmLPh69+l9pAVLZCA==
X-Google-Smtp-Source: APBJJlHrBYvDJNnzrZAW/qWNal0XP+4b2h86axDo0FU4omajc4qpoygiGFAh45R45C+UW4rrqkg3cQ==
X-Received: by 2002:a1c:f709:0:b0:3f5:fff8:d4f3 with SMTP id v9-20020a1cf709000000b003f5fff8d4f3mr1994310wmh.7.1688645613660;
        Thu, 06 Jul 2023 05:13:33 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003fbb2c0fce5sm4911847wml.25.2023.07.06.05.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 05:13:33 -0700 (PDT)
Message-ID: <4f493bc2-45b3-13b8-f1b1-1729a803c74c@baylibre.com>
Date:   Thu, 6 Jul 2023 14:13:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/mediatek: Fix potential memory leak if vmap() fail
To:     Sui Jingfeng <suijingfeng@loongson.cn>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230626185801.684451-1-suijingfeng@loongson.cn>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230626185801.684451-1-suijingfeng@loongson.cn>
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



On 26/06/2023 20:58, Sui Jingfeng wrote:
> Also return -ENOMEM if such a failure happens, the implement should take
> responsibility for the error handling.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

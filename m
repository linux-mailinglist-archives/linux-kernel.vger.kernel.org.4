Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1CF64DBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 13:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiLOM6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 07:58:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiLOM6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 07:58:14 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EC1F019
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:58:13 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so1758307wms.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 04:58:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwYH3ujKbU1Du63Snr0pMmTST6dRtu8bysSgCO116YY=;
        b=eE7Ak6jKbiwDMWCYFiVygnx51rea3oQHieIRkFnhtDwwYfp/LsMkHbhtRPZVK6aISa
         uLwjgtpouvOwWtkNrZfMvShhUFEJfF1bv4xpC0hJv4MDH/fHgic41HvZGPa+7djniI9y
         ABoLhXEYzoqliCHvnq0Vy+Cy3hwFMZA2QKrOPMr7KaqF36XjL6pQ0Oqds4h7B1vbn8y0
         q2C/+aSFf52Ou1LZx+f/2gtGmo9RFVgDoYxGi8Y7pRj2F+PMeRV0TltprCgf6er47WSZ
         Gr5+2C8x+i0MxlhSjpYY5Snw0WyA8LIBddTl6h0N6t8JtnTU+lgUiZzAs7aVE0DEkQNu
         7QsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jwYH3ujKbU1Du63Snr0pMmTST6dRtu8bysSgCO116YY=;
        b=eLhX3f+EmSkMmXJ+bBYQu5kRUjp/QKDFwPaktU4obNZCAK4frAjy/BP6knMHMo01kv
         BV0OVrYUZ08amLDC3x486nVdXKohTND0yAfQObV2JhMoJCplVG59BTyoz7IhhJMLtans
         2ye/Lf2ybEy/bJIbKgB2ViGnuoYmNxvCvXshHfSv0WW15pYxxceFrtE8ijChh1NPr3vs
         7Ek/472yg3t1sziDti+Bs3V+r8Sx6/urAXtr3xK0k1XJQAfGY7SMYdVITEgp0VBY8F0f
         5a8jqFwaXJHtKwRbZx79GsdTJOu9Z/tEPc+LFoVSrE/xZqSwoExg0drXJgEPfs1kwyIk
         Xu3w==
X-Gm-Message-State: ANoB5pkykxHzFDfjRSlPtSzAJXaKsYbLgI0bYI+xe5PH2qIOwGYqfG4I
        ASl2ZtWxoArSawpc54vdRuemAA==
X-Google-Smtp-Source: AA0mqf4atkMpL65PjLsyFlVw5AF8QsgJ5VGJ8W+Ej+Ee5o9xomZOkrFcTbIpIpdByvvfcuZBFLcTNg==
X-Received: by 2002:a05:600c:3b84:b0:3cf:8762:22c2 with SMTP id n4-20020a05600c3b8400b003cf876222c2mr22284442wms.38.1671109092141;
        Thu, 15 Dec 2022 04:58:12 -0800 (PST)
Received: from [192.168.2.104] ([79.115.63.55])
        by smtp.gmail.com with ESMTPSA id q11-20020a7bce8b000000b003d23a3b783bsm5852026wmj.10.2022.12.15.04.58.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 04:58:11 -0800 (PST)
Message-ID: <17c7a0fb-9dc3-6197-358b-894aeb8ee662@linaro.org>
Date:   Thu, 15 Dec 2022 14:58:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     linux-erofs@lists.ozlabs.org, xiang@kernel.org, chao@kernel.org,
        huyue2@coolpad.com, jefflexu@linux.alibaba.com
Cc:     joneslee@google.com, linux-kernel@vger.kernel.org
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: BUG: unable to handle kernel paging request in
 z_erofs_decompress_queue
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Gao, Chao, Yue, Jeffle, all,

Syzbot reported a bug at [1] that is reproducible in upstream kernel
since
   commit 47e4937a4a7c ("erofs: move erofs out of staging")

and up to (inclusively)
   commit 2bfab9c0edac ("erofs: record the longest decompressed size in 
this round")

The first commit that makes this bug go away is:
   commit 267f2492c8f7 ("erofs: introduce multi-reference pclusters 
(fully-referenced)")
Although, this commit looks like new support and not like an explicit
bug fix.

I'd like to fix the lts kernels. I'm happy to try any suggestions or do
some tests. Please let me know if the bug rings a bell.

Thanks,
ta

[1] 
https://syzkaller.appspot.com/bug?id=a9b56d324d0de9233ad80633826fac76836d792a

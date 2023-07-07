Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653CF74B251
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 15:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjGGN6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 09:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjGGN6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 09:58:19 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC221FE8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 06:58:18 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1974193f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 06:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688738296; x=1691330296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YRYKWLcICY/w12lNxMoJVR5s2kK0wW/mWDa5IrHhho0=;
        b=D8DASQjM8uOnq/Et1EL0DKBNOL395SX4Pd99z5tcVN2SjA4RkVZAjGu1Q+5rD7n3RT
         1zSbc0cQfgXHjkzXIhBWwpaysopWq6WFJZWseTprmcFChioMdkcVs+GXWjFeBndn8BWv
         7g+0qtRSOl2QKrQJqBB11GEx4jkTiORHX/kpWkOfeEZJ8w4MWIhlx5Fz8nNjRHbBFf8A
         fTkd06UJg4JkK/tOaeKgd6oik7Z7R/kXeX+EFe8N6LpG1aE7saTmdFlMnGE7m5ob7OcU
         W9L1tZYvSDs+UAOXk+CIxXOW+eUOeG0auIrUMx8inqhz8XETF6jYv2t/6Bpu0CzFtDyt
         /NhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688738296; x=1691330296;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YRYKWLcICY/w12lNxMoJVR5s2kK0wW/mWDa5IrHhho0=;
        b=j38ij6fkT4+Oekt6hXGxa6Cg1uiyLofAkvVTNdQQYboDQhOZzw/3xiOvT5+Eos3zEC
         7ZpzJJUgopRNXR0nK1Wbolyhi3Ihkyxlu0Exrj+Uhvu7RYEd5mNjzWfnIwzlixl80Xhq
         swKy59yMk0l6F9F8cTctJrz7WmYOHeesyB/9qkA3mMKEGYZNu9m1+CcOzuh3ZbUOBzjQ
         3RvGb5DPM2+MLGQk4mE6ooc/WkKtE05Qc5DcxNBlFyVC936UCixRWX13HD7p13blrycu
         XE/s2KEfeghkpOXHXUDmEVLCnSlMR0UcAigjohnBoji8dJMo49d7XWnmG2wMM2OX3nkn
         jOsQ==
X-Gm-Message-State: ABy/qLZHF073oMvwSWYqLxK+hqdOkGqWTCNau0w8wFYyjdeS67nUa848
        wpWunLW8r+4DLYa2i7pV2YYiZg==
X-Google-Smtp-Source: APBJJlF/IJPwi2hekpbwYkjsQKScIRJcy/Nj82kQId+zt+KJoEcW2RTRZob/tUsy1Qycfvbvjj4riA==
X-Received: by 2002:adf:ee4a:0:b0:30f:af19:81f3 with SMTP id w10-20020adfee4a000000b0030faf1981f3mr4239441wro.41.1688738296585;
        Fri, 07 Jul 2023 06:58:16 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f3-20020a5d5683000000b0030ae499da59sm4520881wrv.111.2023.07.07.06.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 06:58:15 -0700 (PDT)
Message-ID: <c0441cfc-82cd-f398-6a11-8b4644953332@baylibre.com>
Date:   Fri, 7 Jul 2023 15:58:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/6] thermal/drivers/mediatek/lvts_thermal: Disable
 undesired interrupts
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
        Amit Kucheria <amitk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230706153823.201943-1-nfraprado@collabora.com>
 <20230706153823.201943-5-nfraprado@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230706153823.201943-5-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/07/2023 17:37, Nícolas F. R. A. Prado wrote:
> Out of the many interrupts supported by the hardware, the only ones of
> interest to the driver currently are:
> * The temperature went over the high offset threshold, for any of the
>    sensors
> * The temperature went below the low offset threshold, for any of the
>    sensors
> * The temperature went over the stage3 threshold
> 
> These are the only thresholds configured by the driver through the
> OFFSETH, OFFSETL, and PROTTC registers, respectively.
> 
> The current interrupt mask in LVTS_MONINT_CONF, enables many more
> interrupts, including data ready on sensors for both filtered and
> immediate mode. These are not only not handled by the driver, but they
> are also triggered too often, causing unneeded overhead. Disable these
> unnecessary interrupts.
> 
> The meaning of each bit can be seen in the comment describing
> LVTS_MONINTST in the IRQ handler.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

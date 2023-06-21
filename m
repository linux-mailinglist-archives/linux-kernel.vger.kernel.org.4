Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EFE738227
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:12:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjFUJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjFUJiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:38:24 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6AF296D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:36:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51878f8e541so6755819a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687340184; x=1689932184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j6elu26YtJfohzcS72Xjup0fvXIh+C0cjlp4750l45E=;
        b=0jJIXDRE/dKzNejhP+OjYi3MzC5xg50Bl+mytGFvV2hHFM9edrgynGWJX9XgPFrye2
         ir2Up9TlMiZYfpRmkFVvyf3lgGenvMkpRAcTIDTHUXCFtAl6KFjQwPrS8Jv13m68e+4s
         SgOv1A0sRPqc8qe/stnqTEn786oINj0AXqPnf941/AH2ReV/T6yCgVbuRAj/0snLjDWF
         Lyd2+J/TbbTVgSl60noS6q7ZuI7U7pSYv/biLUIJWj2mxjmAxkQ24B8BQeJRwQEfB6Ce
         zgB5JwmCEVOb74jk6nhkgKkuymsCxfr9a/3jMc2Kb7ugeFDiOL9y2Zt2hSIdE+R8r+oE
         W30g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340184; x=1689932184;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j6elu26YtJfohzcS72Xjup0fvXIh+C0cjlp4750l45E=;
        b=V0RDuqZg+5aUe4xFtfeIH6ZKzD18x+yDpowHgB4MbkG/NL+IYIuPcib1BlRP+6wXgA
         osMFnqo/bYUUu35Q/J9z+0RiMLVCLUDFY0cfKvZNs7Pg7ZS8plcNhBul2vZtScFjjfF2
         61EBaIGnalTNJZBUIhENuGzIOGAeQ/55/qnCPgCo9XRDf+cJKVKGUae/m+scO+f5uL4Z
         v/OvymEBuIjxLyACllK+AHuNbrLSI8WHJseu7aJaE29qvkDC3lblfWIEz2NktuJqMovM
         LRTKIuIUtoBlVolzcyGKmBsy4hqN9eHpThtyjPpX4dJxPXa5mBWjNluz45kdfimep6pa
         BQJQ==
X-Gm-Message-State: AC+VfDxhzwQQndRwccJ+zbCpX5s7Deax4LyMmhzxK6EEp9OGfcngf8Ti
        kNUvDZhaVucTpUo8VBaRtd6ielZd+qxgGehyrXc=
X-Google-Smtp-Source: ACHHUZ5/2qNwBEnLurkUDa66kVeGNaGFVf728nFX+LisHTCTh8RsynfWNIKoix7OvUyk36H+bVvTAA==
X-Received: by 2002:a05:6402:692:b0:51a:3334:f87f with SMTP id f18-20020a056402069200b0051a3334f87fmr9232463edy.37.1687340184246;
        Wed, 21 Jun 2023 02:36:24 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id w17-20020a50fa91000000b00514b3dd8638sm2335019edr.67.2023.06.21.02.36.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:36:23 -0700 (PDT)
Message-ID: <dca88551-5fa0-c259-32d8-673f1e81944a@baylibre.com>
Date:   Wed, 21 Jun 2023 11:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/mediatek: Use devm variant for
 pm_runtime_enable() when possible
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
 <20230608101209.126499-4-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608101209.126499-4-angelogioacchino.delregno@collabora.com>
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

On 08/06/2023 12:12, AngeloGioacchino Del Regno wrote:
> Simplify the error path of return functions and drop the call to
> pm_runtime_disable() in remove functions by switching to
> devm_pm_runtime_enable() where possible.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre


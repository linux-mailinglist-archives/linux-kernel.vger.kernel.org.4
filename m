Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55682727B80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbjFHJeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235985AbjFHJdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:33:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FC32D79
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:33:34 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30ad8f33f1aso275176f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686216812; x=1688808812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cOj98+SP3A7ue8uJEiHbklaDi2wbfbIhAir4uuSrLHU=;
        b=Laz1RwxGIXm70TgzRDCLNkCjouhFptZ6gdr6yztXF1zDimdNhFWFzEGo6BPIMxK2yG
         qhUi7PZ5Pj/IIFnP7F/khg/w29O0p+iS/mDwDLmD+GsIg92naL8tetlwmvWgNZnr4Vmm
         LVos3YWwVd21ZDWTGdrN2b4ips7bQLckATt4+dtyw7YzTiIYGYj/Et+6JfvPv6BfTcAf
         EKzbqPH4jMtezbOAUCtX+FVxOBbQakai1lzurb8RqhMwqguCXmeeBAnbfjBUbjdACBU5
         YiG/df/4i2ihDgFBEmWEwE6ZzPdrx4qcmwRSiBx1RYEGZ3jv2M/x0J/No3yZV9O0jf6d
         VG4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216812; x=1688808812;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOj98+SP3A7ue8uJEiHbklaDi2wbfbIhAir4uuSrLHU=;
        b=BJJmKmFU5gDT9apjthC3lQu8+zLV6z64bxsY37Blc1j3l+ePxI9tj+lzqbuQiFvjh2
         93enT6L9gxwyvsXaJcQfLp46JkvS5efDpPbHrgKcSdeEvH3J+dNycxATfkPJTwaXqGCk
         qMCUUj72D0fY5Np6iAivqX8FFLsc8YtpLZpaUNqEpGcrQ45Oo6WmOdnmkXBh14jf1wJi
         8qRqWCAA+oQb/I55SQsYepPmbQ+CwWKeWTJLUUozb4jvBGpEkr2ltQPCIwCAqOFTN+7X
         7gEQD17JCfa4xF1IBwirCPjNvewGn9iBjzt7CAJEyAIX3X4Z+NxfMra9my17hVTuPHc9
         E4gg==
X-Gm-Message-State: AC+VfDzXY7EquTrjNScAf01YmxiUDiXoN4r0Ih6GAknUDHZ7F8EB0v/8
        60THPEb3z/R8XaN3HozumTi9nw==
X-Google-Smtp-Source: ACHHUZ7P8OxpxQTjiKrorLWZywqz5NMirJO0K4lefJ+9XIYZYERDkbTiMsX/D53AhUJjyGH6f3r1lA==
X-Received: by 2002:adf:fccf:0:b0:309:5068:9ebe with SMTP id f15-20020adffccf000000b0030950689ebemr5857679wrs.50.1686216812642;
        Thu, 08 Jun 2023 02:33:32 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id b14-20020a056000054e00b0030c2e3c7fb3sm986359wrf.101.2023.06.08.02.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:33:32 -0700 (PDT)
Message-ID: <bc366bde-95f6-1ddd-9528-a9c1dd30c04c@baylibre.com>
Date:   Thu, 8 Jun 2023 11:33:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/5] ASoC: mediatek: mt8188-mt6359: Cleanup return 0
 disguised as return ret
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-4-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608084727.74403-4-angelogioacchino.delregno@collabora.com>
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

On 08/06/2023 10:47, AngeloGioacchino Del Regno wrote:
> Change all instances of `return ret` to `return 0` at the end of
> functions where ret is always zero and also change functions
> mt8188_{hdmi,dptx}_codec_init to be consistent with how other
> functions are returning errors

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre


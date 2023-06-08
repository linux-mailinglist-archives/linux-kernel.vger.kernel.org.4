Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFC2727B7B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 11:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbjFHJd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236007AbjFHJdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 05:33:13 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1FC3A85
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 02:32:45 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f735259fa0so3076075e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 02:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686216764; x=1688808764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qh+AyXkdA/v/9kzVTrAL99NIpdi0mGHc3m8uGx6UR50=;
        b=2zfWTuEMe3vS7U9zuJsMP2vQfKn8N+zqkxv+/d/SAkFZXyxO/JlkYJDJfYLoU2SzYk
         HOFfN7F+urIh30E6sqIClU5tRfZTXUkCUe5PetIsu0eLjLOfYWfhzb2tTFKWHusiTsLa
         3C99D0XgCaxBQkWubyObQpI8fGvpsqVVnxy9I41a0tNssosTD5paCXmH0ORLOBGmZfeF
         SREg7sdTJ8a4fI3a0h3g/UuzMW6WFAtA2NNxlRMyMHnXhtlvuDZC2i0pjONTDk8A34Zk
         cgd9iHTXTqP4YkCLMJV1Wg+TESY2Ck6rPjmQHkeLZPiAhYPdDEAONBsrmPxEMrT3sAdq
         Ml5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686216764; x=1688808764;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Qh+AyXkdA/v/9kzVTrAL99NIpdi0mGHc3m8uGx6UR50=;
        b=Ae2tlOlRx6cVqJYewalvORYxROd69xHQ3YtpENIGslSXfHS+vawWQWnBzVLbcI2HP/
         6ydQmDaR1PMd3oLOZtuoUfw/uNPCmxQY3JEXnMt8woIFZajl0TDEq9QbltrvY9fhHTE6
         P4XMCfn5QiVdm/38tZjoNqsdvGtQYPK9WsuvFpr9N6dXgdDYxZd88YJNI0I8nRV4rTim
         J3MFdF1xOOyWsmAzTqbcBJNdVU+FJ8gVkn5WnoVID/NcEJ+HXtXhe/Tw61ihF5HzPBtj
         4l9RYsIQwjfvl6Lc1HIWsuT/9P5eaNTeXPHC2e4igGnlAVuzwKlmokx/yyOrzC5QOOFt
         ELXw==
X-Gm-Message-State: AC+VfDzWHnARsoE5lPA+w4NXQG8LjO3771Y8oldmG5PNfG5klmZyg+nt
        +iNx+luRRnZbyPj2dJjEs6NO2Q==
X-Google-Smtp-Source: ACHHUZ4niH/W18GVbLuK2FNm3lOVu/Kuf0O3YTklSvQmuP4gcU0NpNfou88IFGerHEFcQg4ETn2BUw==
X-Received: by 2002:a7b:c5d5:0:b0:3f4:2ae5:b35d with SMTP id n21-20020a7bc5d5000000b003f42ae5b35dmr846586wmk.40.1686216763972;
        Thu, 08 Jun 2023 02:32:43 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id l5-20020a7bc345000000b003f735d6fa74sm4719624wmj.9.2023.06.08.02.32.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 02:32:43 -0700 (PDT)
Message-ID: <c8976700-6d22-3f7a-73c8-6986504cebff@baylibre.com>
Date:   Thu, 8 Jun 2023 11:32:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/5] ASoC: mediatek: mt8188-mt6359: clean up a return in
 codec_init
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        dan.carpenter@linaro.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230608084727.74403-1-angelogioacchino.delregno@collabora.com>
 <20230608084727.74403-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608084727.74403-3-angelogioacchino.delregno@collabora.com>
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
> This code triggers a Smatch static checker warning and does sort of
> look like an error path.
> 
> sound/soc/mediatek/mt8188/mt8188-mt6359.c:597 mt8188_max98390_codec_init() warn: missing error code? 'ret'
> 
> However, returning 0 is intentional.  Make that explicit.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre


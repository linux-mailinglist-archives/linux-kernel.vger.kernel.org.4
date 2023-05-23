Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5286F70DF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbjEWOWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbjEWOWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:22:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C277FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:22:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-30a1fdde3d6so3590570f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 07:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684851751; x=1687443751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EranyCDg/9rde0AKk+TrYZhj6TXyu+KiL6HFMU6m/Vc=;
        b=lXbZ/4cY6bh3L0O0vsZya24TPX5PgkE3gNjG7MnLWafEXib47/oB4qvLn8NJ3Cvy9O
         65gp5VUR4VVO6Rb0xlq2zRNsqII4bD43n70CHWLWCANEMe9NEko3ozAjAvl+ZMTVCivi
         vPB3nRNrXEQKWin+2CNqHRyZTqmocNsH56DN7czvai7Gcv4zzNNhzMlwwDul6rXI4NcS
         UhaZn8CBqR7iUbyoSXuNxRnYRnep4ylMm+9cBuPcwAx7S3QBuyIFmw7CbsuU/iCeg4mk
         a42rjwNgz9owQe47UF31HD8u8a/8lxNXrj4GS7S9qijb1i2fo9ph//NRGaG+4lK0xKxI
         IJ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684851751; x=1687443751;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EranyCDg/9rde0AKk+TrYZhj6TXyu+KiL6HFMU6m/Vc=;
        b=KXizpv5JEmdzV/tt5h2tPymM4Wbfy1mxzuT6EVIia8r3Q5I2KDyt+tV0yZbGanmb8e
         uXGWZrhf/50QopiiRlJEvyO7sWBLG30FPLlmUtct4q6J5RVw3FU8euRE4UoB/HbnnuD9
         4m7Boop8N4o+rozRvniZey09yA71NZOC6vZbfjMAWHv7qrjt8w5nisD47NF7OiugBe+0
         FdWPTST6uUEeUnJUIUf9MwRpDVBpd5R0VNmC0NJt2pJzs+O81r1qfgz6emhbsc52YBUQ
         W3Q0p1cDE4otSZ+sLd33GFr5Zphc9PVOPNlPBfbrJYFX2nBRFNFPeotg3W7Y5S1XcL5X
         pemg==
X-Gm-Message-State: AC+VfDyhnZjtm57WBcj+hAxE8inuNLYkc5ynDouQPOvZaECwdbg3yTgm
        q9jlBprW+iSags1XFf9hm5IMFQ==
X-Google-Smtp-Source: ACHHUZ4CeNjN6dEni8tyfgYEbyM8ejjEVm8OHV/gr0I9cOmBWMG6V5ywEC801CZKE/maISgSoiHhrQ==
X-Received: by 2002:adf:ee49:0:b0:306:3b78:fe33 with SMTP id w9-20020adfee49000000b003063b78fe33mr11199720wro.32.1684851751343;
        Tue, 23 May 2023 07:22:31 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c024a00b003f423dfc686sm10083928wmj.45.2023.05.23.07.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 07:22:30 -0700 (PDT)
Message-ID: <1d3ba1d6-ff91-eedf-90e1-4ef5b16354c2@baylibre.com>
Date:   Tue, 23 May 2023 16:22:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/7] ASoC: mediatek: mt8188: separate ADDA playback dai
 from capture dai
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230523021933.3422-1-trevor.wu@mediatek.com>
 <20230523021933.3422-2-trevor.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230523021933.3422-2-trevor.wu@mediatek.com>
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

On 23/05/2023 04:19, Trevor Wu wrote:
> MT8188 will support SOF. In SOF, be_hw_params_fixup callback are used to

Can you write what is SOF please ? (Sound Open Firmware I guess ?)

> configure BE hardware parameters. However, playback and capture stream
> share the same callback function in which it can't know the stream type.
> 
> It's possible to require different paremters for playback and capture

paremters => parameters

Code looks good, after the commit messages fixes:

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre


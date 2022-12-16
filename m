Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7237364EBA0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:53:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbiLPMxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:53:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiLPMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:53:06 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2622496C;
        Fri, 16 Dec 2022 04:53:05 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i187-20020a1c3bc4000000b003d1e906ca23so1127802wma.3;
        Fri, 16 Dec 2022 04:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BheHA0Tcwm6n8ymyQljk2z1vC+8TH8hh+YD/X0C4MfE=;
        b=AKseIkBZZBrqaCfkNwNc+eOqwfrvP1xB5qgAOduMfqvnWa/fl4el+6xifzPzoHdoMu
         dThO83kul7JlQEUalQSJI9PwHrXOloc9BXy1SaNNYS+GTaohbapvDJ2iA7c17ImUR/pL
         Uk2j6bXGXuATvNUy2eCZTxPY2QaZYRDXNaKGCW3EXp8C7VYgmqmHT3UDXn5ON4P5VoWj
         tODxHPhQ6dk0TlV8sn3u7JzozL5n+Gxdh7d+nJQj8+lj0M+EKpOCdv5zjTNYG56tqWzs
         T9KTGXJaolmbqw9gWZlSp+8ctPAfsp7jDTmRNpJnAxZQmafMXgXusal93noxxC/XvI/j
         nmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BheHA0Tcwm6n8ymyQljk2z1vC+8TH8hh+YD/X0C4MfE=;
        b=C8iwDwwUVz0aFhDn0LKPLvaTRdXNdHqxulbUiiA7LUQ+XC3IcfNpN4QceKNYoHTuCG
         rLZ16HAGhkHkwSZQhUdotjr6eIySIuOb6Za4Y75d/N5W0c8ZtDX8Bebsl4dnyR+dggXK
         frt62kcXb9N5HrHntl+0TC+7z45tZXozy8SCxHJs1fq3LDN7BFIxL7hEobgQBEQCet45
         QgrThJ86Z1UBthh/9/1Tte4rgscwi0hPkXvcoK1zxj+4Ud6qOoLb3s3VwHgwTrWeBVEd
         j1VPLgTfAxerb2hJIsvDx2wH/cwMobgD4BZmak9bNcEwKrc4X7FnhangiRtebW2atTDN
         VVpQ==
X-Gm-Message-State: ANoB5pmfWuZxqcqEKlXPpfvhK26w6X/4ESvQsE7s2abb0wTUt41/V9f1
        EPk6xT3xzcn7xzVKTQBEeb0=
X-Google-Smtp-Source: AA0mqf479L304eL8/K8VJH98TvI/FZlxuU1K4BcjUM7FJGorT7BHd3K5GAGOp5+Y4o4yWCg6c9hDig==
X-Received: by 2002:a7b:cd17:0:b0:3d2:2d2a:d58f with SMTP id f23-20020a7bcd17000000b003d22d2ad58fmr13121323wmj.2.1671195183537;
        Fri, 16 Dec 2022 04:53:03 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id k11-20020a05600c0b4b00b003c5571c27a1sm2870571wmr.32.2022.12.16.04.53.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:53:02 -0800 (PST)
Message-ID: <0fc0217e-f1dd-d64c-d43c-cd47a8acbfd4@gmail.com>
Date:   Fri, 16 Dec 2022 13:53:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v7 0/8] Add MediaTek MT6357 PMIC support
Content-Language: en-US
To:     Kevin Hilman <khilman@kernel.org>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Fabien Parent <fabien.parent@linaro.org>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>, Lee Jones <lee@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        linux-rtc@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Fabien Parent <fparent@baylibre.com>,
        linux-leds@vger.kernel.org
References: <20221005-mt6357-support-v7-0-477e60126749@baylibre.com>
 <7hr0xe56uf.fsf@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <7hr0xe56uf.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kevin,
Hi Alexandre,

On 05/12/2022 14:16, Kevin Hilman wrote:
> Matthias,
> 
> Alexandre Mergnat <amergnat@baylibre.com> writes:
> 
>> This patch series adds MFD, PMIC keys, and regulator support for MT6357.
>> MT6357 is a MediaTek PMIC very similar to MT6358.
> 
> The regulator driver (and bindings) were merged by Mark.  Could you take
> the rest of this series via your mediatek tree?  The input driver (and
> bindings) are ack'd by Dmitry.
> 

Yes I can do that but 3/8 does not apply cleanly. Could you please rebase on top 
of v6.2-tmp/soc?

Thanks
Matthias

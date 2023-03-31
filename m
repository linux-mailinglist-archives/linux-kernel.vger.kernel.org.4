Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D196D1E24
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCaKhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjCaKhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:37:00 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC111B762;
        Fri, 31 Mar 2023 03:36:55 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e18so21904186wra.9;
        Fri, 31 Mar 2023 03:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680259014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DeLG3SmKVoYAE/gwaTVKHgqiUXEu5PfzU6zaovu3/zE=;
        b=QpDa14UIm5S6KX7Xj3tCP7mEFM8GCkjFb3RgvdmV16zv6/ZN2Q3qIWes5E7Fcy6MtN
         8jWjkklZhsFl24feC02AhLHW9yAH22aMPTDy1ATfj0EeX/tThFZzLuGaiUnIOpTCjxJF
         +DnJHLYtw8Kd5Bs1YdwHyL47ijjVz0qbASevXkg9soAgSA4PdLVabRqY0NnhYFkIK1Sj
         r3Ys3a3AdgtrPnN1DrvccLcxM/qOSaFJ6++BiGcNhaDV6nGTZok1R7KDZkSOtul9Jmqh
         OU53e3ud63mUb1cv9oMkurFz3AxjXJgPji2LMiLaJH1XrbrH//AjFDspo9O696rkj3k+
         ycgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259014;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DeLG3SmKVoYAE/gwaTVKHgqiUXEu5PfzU6zaovu3/zE=;
        b=eLc30cLE0q4y9zMZOgwdtmN30iv4ZQHE0QMI2ke4TGxxrwvbxmeLEs9ZMl7IIzKF/3
         HgLKNlA/x6efzsGd8f6XSP/0FDE/ZK5V4cb6hPORy2ItlXEwMom5JTMkse3Ek08AO1fL
         VSsGgng4mHRyWWDg/v6Kp6UdA8jmxqpfTGN36eIsIVKiYzgfTg9VP9QW4+IUCcjdMJ7A
         QRIm0+zsSsmC8CWxavJaHnc5uV1w8S0i0UQzm64MpQi4tq4UpQGP7PatLNRC247t2bIj
         7w2e8AMVTEHKifgd6ZGytd41ObPl3AStu2cXB/sx/wbzcyfuyH3+7A1qDk0L9lTjwwPf
         bhMw==
X-Gm-Message-State: AAQBX9d1VTLj6RLnTLZy5SgP6WWeyySqCDUWHZ69xxZqyQQYJVTZJor2
        P/cLLF7msemYbHud+dnTOLU=
X-Google-Smtp-Source: AKy350Zd8s0vzQSVNquNFIc6CYHt3yGGpsThtNQB0RBm1ZUMCQwEfLqUw7AqLmN3YHCa1IEHnWkmjg==
X-Received: by 2002:adf:ea91:0:b0:2c5:9ef9:9bab with SMTP id s17-20020adfea91000000b002c59ef99babmr20931861wrm.43.1680259014240;
        Fri, 31 Mar 2023 03:36:54 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i12-20020a5d55cc000000b002c3f81c51b6sm1834023wrw.90.2023.03.31.03.36.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 03:36:52 -0700 (PDT)
Message-ID: <a1fde974-f392-1493-b48a-b4cce05f3ea3@gmail.com>
Date:   Fri, 31 Mar 2023 12:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v14 6/6] arm64: dts: mediatek: mt8195: Add temperature
 mitigation threshold
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     daniel.lezcano@linaro.org, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230209105628.50294-1-bchihi@baylibre.com>
 <20230209105628.50294-7-bchihi@baylibre.com>
 <CAGuA+oqOgprdu0dVcmB=qJd5HJjada3d8ZazMpoG-SBPizzuPQ@mail.gmail.com>
 <80c60f09-56eb-cb84-43f0-7b055ea4b32c@collabora.com>
 <CAGuA+oqJVTXE5YHm6rSv4pPWsGxR8nZD-T5EM7LS9gPtdcu4HA@mail.gmail.com>
 <CAGuA+oroM1XmLTDZcFx5F+tHvbOJXUGuj8SnZnUxD56+9XAb2Q@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGuA+oroM1XmLTDZcFx5F+tHvbOJXUGuj8SnZnUxD56+9XAb2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/03/2023 12:10, Balsam CHIHI wrote:
> Hi Matthias,
> 
> Is it time to apply those last two patches of the series "Add LVTS
> Thermal Architecture"?
> 
> [v14,6/6] arm64: dts: mediatek: mt8195: Add temperature mitigation threshold
> https://lore.kernel.org/all/20230209105628.50294-7-bchihi@baylibre.com/
> and
> [v14,5/6] arm64: dts: mediatek: mt8195: Add thermal zones and thermal nodes
> https://lore.kernel.org/all/20230209105628.50294-6-bchihi@baylibre.com/
> 
> Is there anything that I could do from my side, to make it possible?
> 

Both applied now. Thanks!

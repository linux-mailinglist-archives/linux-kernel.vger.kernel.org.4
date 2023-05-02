Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BEE6F3E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 09:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbjEBHWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 03:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjEBHWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 03:22:30 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C8EE4230
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 00:22:28 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f19afc4fbfso33186065e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 00:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683012146; x=1685604146;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cfc3shu25VAQBLjR0CRWBWzFrWGG2Jfrb9akd4uF1fc=;
        b=b0Fed6b+eCmT8cV3xr3wlG4FF8mw3G/wDBEk06E4EJlwgGLdhjYYmaTHanorpuU5xU
         SAUybqW0SFDeWqgmj1Gbu+Ho+8CS0HQ57uAlfCfb14Feln32WDvAvTJgQMi2ZwzaewIl
         RQJ9MpLuwcJOULjBA+YC1gbkJcJmyLeTpSNciXhFkctHhbFjVsefgxDrVL3v0BA6DSqA
         WdgpWxxAWEmJxANsrf35sLT07alHX99MNorU34Kd7N5u9RnLC/LbHn2LydQPh798aFwW
         HsOKvEQwFDTzAh60j/TiLHoh7x/JvuTl0NybV4G+9DpvDzf22aQ+YUQqT1NHnUCiZFJ8
         Kslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683012146; x=1685604146;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cfc3shu25VAQBLjR0CRWBWzFrWGG2Jfrb9akd4uF1fc=;
        b=DyIgl6oLLdCumch2hx8EOXze8h79aEJiYCJtmdhzAwgTYLhGxFf+umtA9uqDNVzTEf
         CI+9B1Wu7BUkq+Wqfkxs1lsQ5tMh+aW8ixQF6q6HtXVoCcZR4Lon7aa9R1TVbsocPMge
         QUk3kncv2AbUACbvAyarMr4rZ6ccJ97YiSmeKJEUTbwQrfrDRdysf5o+8adKZueJHjUB
         lxC0EwHw4Z0SnlwsWUEK4xujWSTBU1/uipKvJS94R/PGnNwbkZtC+iyHVBG54UEEQ8Qb
         LhZK9xLK0CiAq67cfmeVM41xI8RWHB8IzBopmPqdFmg4ugGfocer7Gne4j8ViQ2fudw7
         mZqg==
X-Gm-Message-State: AC+VfDzfVaVLb3RA5kUlU71y5FCEHr0kIEsS3mQDtfWb/+2KyWdhq32F
        1P5IF6Jex9OXFYLjnwscxAssXQ==
X-Google-Smtp-Source: ACHHUZ6Ty7St5+Sjn/T8sAFgQsPINWtfyPc/hBOGyfBpwxQPyOXrdrAjjcNqquluIL42F0ajaoYRKg==
X-Received: by 2002:a7b:cb85:0:b0:3f1:7136:dd45 with SMTP id m5-20020a7bcb85000000b003f17136dd45mr11226104wmi.30.1683012146663;
        Tue, 02 May 2023 00:22:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:e265:b513:556a:4149? ([2a01:e0a:982:cbb0:e265:b513:556a:4149])
        by smtp.gmail.com with ESMTPSA id bi26-20020a05600c3d9a00b003eddc6aa5fasm34009357wmb.39.2023.05.02.00.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 00:22:26 -0700 (PDT)
Message-ID: <e7a8e78e-9e99-91fd-40a9-5cb8623f287e@linaro.org>
Date:   Tue, 2 May 2023 09:22:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v5 2/2] arm64: dts: meson-gxl: add support for Xiaomi Mi
 box 3
Content-Language: en-US
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Karl Chan <exkcmailist@inbox.lv>
Cc:     linux-amlogic@lists.infradead.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jbrunet@baylibre.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230425165624.11999-1-exkcmailist@inbox.lv>
 <20230425165624.11999-3-exkcmailist@inbox.lv>
 <CAFBinCA4c1qDC5=NWJKEMkTh5HfhkqpgrpetgEH3kJTY_qLVHA@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CAFBinCA4c1qDC5=NWJKEMkTh5HfhkqpgrpetgEH3kJTY_qLVHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/05/2023 14:54, Martin Blumenstingl wrote:
> On Tue, Apr 25, 2023 at 6:57 PM Karl Chan <exkcmailist@inbox.lv> wrote:
>>
>> From: "Karl Chan"  <exkcmailist@inbox.lv>
>>
>> The Xiaomi Mi box 3 is a TV box based on the Amlogic S905X chipset.
>> There are two variants:
>> - 2 GiB/8GIB
>> - 1 GiB/4GIB
>>
>> Both variants come with:
>> - 802.11a/b/g/n/ac wifi (BCM4345)
>> - HDMI , AV (CVBS) and S/PDIF optical output
>> - 1x USB
>>
>> Signed-off-by: Karl Chan <exkcmailist@inbox.lv>
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Note: Neil will probably only apply this (and the other patch from
> this series) after 6.4-rc1 has been released

Exact !

Thanks,
Neil


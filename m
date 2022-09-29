Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC13F5EEF84
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235330AbiI2Hp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235219AbiI2Hpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:45:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BB2BEEB5F
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:45:54 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u18so1002155lfo.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 00:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=p7ms7uqng+TRfW2+8KLEb7IsEqCgIjkUcQ5rclrFPw8=;
        b=BBTb8i3GIiG9CaQszwD5JUyCdxCbBwlxH9N8u8bkqxNpkoUNCNT5/gIvsspbDLA+de
         96bs2KSDzqRRZuxUeityqLuhoeJHxfKS0wAc7EXM6lvgDRvtfGffuXB0b+hv53MnW010
         3BMtAZcmfpO8Eu1IOqbXjkiSGUihqK2ryoQa8dCKxALvE+TRI1g5U7+wx+lz4AWsckP2
         UpM4chLJleJMWeJFM7W6NH/fvCnRKNg0lSgK9iR06OJjcRgPlAEgdlrBVDssFea6XptW
         1Shp2VP1ndX9q7wfeuoz3AussVnb9V+lrQJtZX/DCbWW44tabOtHledw2eVfMLmql46S
         aJ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=p7ms7uqng+TRfW2+8KLEb7IsEqCgIjkUcQ5rclrFPw8=;
        b=heKy3HvfVMglEIiUDbdFi3ciN1dw72YPUnhVKo2YlsyBph8YuGWqE2Z4DVTT5yxOP2
         JUytkgG7zGA7riOhEaxRIrLk2G6aF42/+ATzg0MF3ucuELnwsbmHdzjPbOgc1tp59p2X
         W837UIN28k3dReu8dVMxUSKzyRM5peeQluOwTcvjkt1qbdYeBGPZHUYnlzUJRNv/Hw28
         63gCQsW1LwJrIDsgd6ra8SeZ5BHEHTGR4tjJz2sTtZA8QGxEmTEFktZuw4YyhMS9GS1O
         90Y6BDga98ouMtWRqjh9gS4Pae8oGZzekLbbieKknvn6WuCwSPKQNhTPuY7nC/83kMwE
         TnTg==
X-Gm-Message-State: ACrzQf3YUrVqAHpFkHmhru7VXS/ttqeMx46ilTspFkweKLQE1mOLw4Ie
        h3jXxdq5pZdclSeP300twFfbsw==
X-Google-Smtp-Source: AMsMyM4qz40OXC+DwXTJoJOTC15xvBFpmJ5eD9N4isSloiSD+bMU6hutKIdvRpX7/Dj03+q2OsJR6g==
X-Received: by 2002:a05:6512:3d25:b0:49a:d2a0:7208 with SMTP id d37-20020a0565123d2500b0049ad2a07208mr833485lfv.82.1664437552543;
        Thu, 29 Sep 2022 00:45:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b00499cf3e3edcsm703233lfg.296.2022.09.29.00.45.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 00:45:52 -0700 (PDT)
Message-ID: <f54a40ea-99bf-e341-3bbd-851b250cc9cd@linaro.org>
Date:   Thu, 29 Sep 2022 09:45:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v5 2/3] dt-bindings: thermal: add loongson2k thermal
 binding
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     zhanghongchen <zhanghongchen@loongson.cn>,
        Liu Peibao <liupeibao@loongson.cn>
References: <20220928083702.17309-1-zhuyinbo@loongson.cn>
 <20220928083702.17309-2-zhuyinbo@loongson.cn>
 <066b55cf-4a28-89a2-56ab-572590c97c30@linaro.org>
 <9b2f2d43-981d-3ffb-7526-dc3e58a9f367@linaro.org>
 <f0946817-cc2c-449b-d93b-0dd94a0f51f1@loongson.cn>
 <ed762d71-7104-b1ad-009d-51c1a4407472@loongson.cn>
 <9b62594f-7473-9974-8ab3-4c93aae5fa64@linaro.org>
 <abaf9b69-487c-0f1e-7a94-201155f5e3d2@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <abaf9b69-487c-0f1e-7a94-201155f5e3d2@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2022 09:07, Yinbo Zhu wrote:
>>>>>
>>>>> ... and please test your patches before sending :(
>>> You said is refer that "reg: [[0, 534779136], [0, 48]] is too long" ?
>>> Need fix that warning, right?
>>
>> Yes. You said you tested it but then sent with an error... so it's not
>> really a testing.
> sorry, I did do some testing. but I think It is okay that can generate a 
> dtb  without reporting an error when compile yaml file, in fact, I 
> ignore the warning,  I will fix it in v6.


Do you also send the code with warnings reported by GCC? Judging by
number of kernel test robot reports, it could be. So just to be very,
very clear: do not send any code which generates any warning. For GCC
this means W=1 builds.

Best regards,
Krzysztof


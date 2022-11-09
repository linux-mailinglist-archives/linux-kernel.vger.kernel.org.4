Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E15162264B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 10:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiKIJJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 04:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiKIJIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 04:08:55 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26325F8A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 01:08:30 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id l8so24768769ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 01:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jGbGooKvFWbES+AsyyGgBWCRTH4U8Br/SsJ/FDXSqtI=;
        b=Rb49nhfdYsnw5YoVW5xzIqm2Q23E+V3yVq1LsviIrs1dMDPhWMjEoKSh3RpKQAvakH
         ws3w7ZRENkO4eGwh/2YZpFmhspp5XTl4gXA+RsinZqzzymm1AJyrkAO/iOUjQX6mI8Bu
         QKnsioyzIMUYxoCzZRMMZiBaMCnmkyVizCDaCdrhROkTf9IyChL+S5gKj1emPMSdHt+I
         rvvaD140bcKEDo3h7vAhqqsJw4b4DNrpjvZwFHhd8fi4YFMNDM3XWROgpCdf6AwMqK/d
         DKWZyRKgqxi3u3NEf9osSjr+a8um76A5Wrl95kUskRu041i0pG8SUw7Ymt/PrWksvEyq
         iAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jGbGooKvFWbES+AsyyGgBWCRTH4U8Br/SsJ/FDXSqtI=;
        b=cX5I+YY/No+PCQ0LTPwiLB2yqjN371kndd2v8uQKC8D8ZvaQPcB/O+Ytkeb7fBTyzV
         195LBCFzn9IkqOkxcUc41lYwfUXPxxQ03lHJe8AzQQKKfxKDxfeUgqY2Xt0o/i57vBpQ
         1mbkJXUya1rJn2kPzT7f+a+a/T9/lDrKE4pROuezsjH+5WoGNv3Cnqcd7x3BrGooVXrE
         E1VxEsyxni8SnoGxBFHYPwKkMsbxNwHFTc3sMSnQdW0HhNZkadG3pcVt9+YQPBLAkrnI
         hAN12mj6KaDwjFJasINnM9OGYt+w/VJ7Sj29R7SeXMzA19hAXfEGS+inMjuXSjeLPq5c
         B/oA==
X-Gm-Message-State: ACrzQf1/LtfvLpkICwa3LgBDUeIsAR8qAwEvvvp0UWotXoYFOh10F1n9
        3ugVXW/P7tl77waBOvJT1KecUg==
X-Google-Smtp-Source: AMsMyM6sYUOAqqD60ytJo+GJJIu8FQwld2gQiCTzj+OXNkOT0XnFPjFRgSEXqhCbsOJQAZ72Se2Mqw==
X-Received: by 2002:a2e:8ecf:0:b0:277:1137:380c with SMTP id e15-20020a2e8ecf000000b002771137380cmr19036819ljl.107.1667984909379;
        Wed, 09 Nov 2022 01:08:29 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id k8-20020ac24f08000000b0049482adb3basm2146908lfr.63.2022.11.09.01.08.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Nov 2022 01:08:28 -0800 (PST)
Message-ID: <d9690b4e-30a7-75be-5492-98206c3ccd99@linaro.org>
Date:   Wed, 9 Nov 2022 10:08:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 00/13] arm64: defconfig: Enable missing kconfigs for
 mt8183-kukui-jacuzzi-juniper
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Mark Brown <broonie@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221108232228.1177199-1-nfraprado@collabora.com>
 <06c4f370-715d-4c66-ad43-143b652af5ff@app.fastmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <06c4f370-715d-4c66-ad43-143b652af5ff@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2022 08:28, Arnd Bergmann wrote:
> On Wed, Nov 9, 2022, at 00:22, Nícolas F. R. A. Prado wrote:
>> mt8183-kukui-jacuzzi-juniper is one of the devices set up to run tests
>> on KernelCI, but several of its drivers are currently disabled in the
>> defconfig. This series enables all the missing kconfigs on the defconfig
>> to get everything probing on that machine so that it can be fully tested
>> by KernelCI.
> 
> The changes all look fine, but I would recommend not separating it
> out into 13 patches when you are doing just one thing here. 
> 
> As a general rule, if you keep saying the same things in each
> patch description, it is usually an indication that they should
> be combined. Similarly, if you find describing unrelated changes
> ("also, ..."), that would be an indication that patches should
> be split up.

I agree. Descriptions you wrote are useful - they explain why you are
doing it - but it got all really too detailed, just for defconfigs. One
commit per one symbol is a bit too much...

Best regards,
Krzysztof


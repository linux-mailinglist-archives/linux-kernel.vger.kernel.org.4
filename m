Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AF36D5C8D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbjDDKBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbjDDKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:01:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A2268E
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 03:01:04 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i5so128464551eda.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 03:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680602463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/EbqtYiG8jTBdNfg4iHSCY+HD2O/PfHv7vkEdFGwb4=;
        b=PypqPuvPHBMVOCvNRpkEldZR+4v1haLUXl3tGgAapMP3hilAQsloRtmpW3QST8o+sy
         M707x+Gkikr7TN+8WP/xmWqKMgL+ByvVfCcGbJl97uU0OiqWXlLaaymSruXTv+k+iVEP
         ZzVahpyBw0IlpvyvZjwZJLwE+eN2Ba+PZkY39wD20n2NRMS9kNeD5jDwtxVmfxrGEq7n
         4f7s7Jjb/abyEMEoCeWneANim6tueAaMgDgej9kZzIB43xkc7NnHgfNqHq3RT2DQKJ2p
         GEjYc4yMZDi4r1VMMfMt+93uTXRDxA/QpgF9fY6/STfrKXHiXxaolYRjHetb3LNdzMtT
         /a/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680602463;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/EbqtYiG8jTBdNfg4iHSCY+HD2O/PfHv7vkEdFGwb4=;
        b=Cx8sTQlNIIllSTsBz9aWBnUhaYUIVzqgmDSTMyy3GH+NxlUhlO6SMwA2oYSe4Max8x
         PSM0IGh1TSVb4bAIj/CQ3HwlH/FfySJGha6SkVYuT+bbq5pC7lts+q07Hjafs6JiJcAD
         BFKLse8B8mFaMPXPIqI2NyXKKykwnNOjzOMTrO9TMFam6gitJWmsaMx9I+LhJokOX0wR
         tqibGrN0mwiwj/evbjLNnDhOOMV4fFseIPj+62iahUzoNuawtmfxLyrBe9vBflyP0ZSr
         NbmYS1JnCGPPQoeWmHHMHryDJ3W8pgQduBOfU+n8sxcDn+hFszqgJ/lHbshwo9IxX43I
         m0eQ==
X-Gm-Message-State: AAQBX9ergK19MLFPd9Tkb5Qb2AOW1vTo4ONNMSzQ1+wCOV7Q+ZZgdR17
        tZUNHnFx5YT3nrpAa0BD3wIrQw==
X-Google-Smtp-Source: AKy350aD/201Rp8J8tnbsIBynEwDR67zEs3ALuwUS/9YCh8njUOYddARRcOnPrm1nnLjEHmxKm6RCg==
X-Received: by 2002:a17:906:5e55:b0:93d:ae74:fa9e with SMTP id b21-20020a1709065e5500b0093dae74fa9emr1677310eju.7.1680602463125;
        Tue, 04 Apr 2023 03:01:03 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:99ed:4575:6001:8bda? ([2a02:810d:15c0:828:99ed:4575:6001:8bda])
        by smtp.gmail.com with ESMTPSA id f1-20020a170906084100b008e09deb6610sm5702697ejd.200.2023.04.04.03.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 03:01:02 -0700 (PDT)
Message-ID: <0ffa9690-9709-669c-b44d-dbb93446ec95@linaro.org>
Date:   Tue, 4 Apr 2023 12:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: multi_v7_defconfig: make USB_DWC3 as a module
 instead of built-in
To:     Arnd Bergmann <arnd@arndb.de>, Roger Quadros <rogerq@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Nishanth Menon <nm@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230404084259.13752-1-rogerq@kernel.org>
 <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <283f8f4c-9f8d-48b1-b161-3b712104583b@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/04/2023 10:51, Arnd Bergmann wrote:
> On Tue, Apr 4, 2023, at 10:42, Roger Quadros wrote:
>> USB_DWC3 is not required for boot on most platforms make it
>> as a module instead of built-in.
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
> 
> Does this save a significant amount of vmlinux size? Since this
> is a fairly common USB driver, I think it does help to have it
> built-in for users booting from USB_STORAGE or nfsroot over
> USB_USBNET, which are both built-in and not uncommon.

Especially that sometimes, at least for arm64 defconfig, we added as
built-in less critical pieces (RENESAS_ETHER_SWITCH, MARVELL_10G_PHY,
HTE_TEGRA194, SM_VIDEOCC_8250 and other non-core clock controllers).
This change will require several systems to update their initrd to
include USB.

Best regards,
Krzysztof


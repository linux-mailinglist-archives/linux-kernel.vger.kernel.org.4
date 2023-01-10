Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7806664C54
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 20:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbjAJTWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 14:22:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238977AbjAJTWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 14:22:31 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1D2F010
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:21:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m3so9565100wmq.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 11:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMPBm7XtkGVF6xVWVkDxzofUywhGoCk80IYnR0yXaIs=;
        b=yh6/x9xf5trCOeKXwe9hG1tDLZUWt5S5xlZSNpZQyu1maJ1XYrDUq/X81N2xFHks2N
         MQfSfkBLLUXlnfeg//QhFeIZKvhPVXJzJ0/YGsISxI8KOqHN5RlNAZgI2lNVAxp+WsCu
         dxtdxQM1lCalwIyRqW4TwKDhVGhKeK0avTK00dpeZsuFC37gdLlFs9/bQtH4tJDmmSGN
         Ili1eUnWF6io/PfdwqvV5mWf/FFYUBJToC3cAGBeGT61h6G6vsbH8aaiqXL8E2f8jMid
         pe7T2oh9ugRrPJHBZ1Yah2O8Qo1cPKLs+9NOJgDaJYn517pFbUIdtFUAmORjl22/cxCF
         kYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMPBm7XtkGVF6xVWVkDxzofUywhGoCk80IYnR0yXaIs=;
        b=opRgV+cHVIK67iyc/5kXE2GJgSQuazRHLig82j9cROqrAMhD7jr08gZ/BI+h9kR4UK
         /9pgm6t50gEk+bbS+KG78b1n1FCL3yOzfwz4vQHI+E73mOhGqhSIUA6s5qiiwMYH8ZXM
         IjVVAxWZGzxhhWFTfGEP7azfudl7goFva1ixhtMcEiPu+ntuFG9f/sYzmQZNlh8qYM+7
         /GopYHtImmNQlFPoi9n+wtO3cAo0aWC8Df/aa0IMdzclawpruknaru/EcXgFFBxiUvP7
         WWGWEKcoQRbBDO5pXXW6cVh5o26n1dBNP8iUg7yoTXXvmP/Yun/SLAr1lzhL84oQ/uMp
         wHFQ==
X-Gm-Message-State: AFqh2koInDiiqyzCsieUCqEwuGN2nmhPS9kjEkMxXauFfhScrOFdUBvs
        bq/UbeXiqYbhkkFcfksKxILZjg==
X-Google-Smtp-Source: AMrXdXviZUCkRjV2mpiDuqBAO+kHieMZ8dMRos9EVEF5bSwzCgyCceHXL2XMDrXDfDKeNsK8wtLalw==
X-Received: by 2002:a05:600c:c0d:b0:3d9:7667:c0e4 with SMTP id fm13-20020a05600c0c0d00b003d97667c0e4mr41777322wmb.31.1673378515542;
        Tue, 10 Jan 2023 11:21:55 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bh13-20020a05600c3d0d00b003d358beab9dsm15702372wmb.47.2023.01.10.11.21.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 11:21:54 -0800 (PST)
Message-ID: <615a84c8-0b5a-8f3f-517b-af1feea6d005@linaro.org>
Date:   Tue, 10 Jan 2023 20:21:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 1/3] arm64: dts: rockchip: Update sdhci alias for
 rock-5a
Content-Language: en-US
To:     Christopher Obbard <chris.obbard@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
References: <20230110155252.189300-1-chris.obbard@collabora.com>
 <20230110155252.189300-2-chris.obbard@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230110155252.189300-2-chris.obbard@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 16:52, Christopher Obbard wrote:
> In the previous version, the sdhci alias was set
> to mmc1: an artifact leftover from the port from
> vendor kernel. Update the alias to mmc0 to match

Please wrap
commit
message
according
to
Linux
coding style / submission process (neither too early nor over the limit):
https://elixir.bootlin.com/linux/v5.18-rc4/source/Documentation/process/submitting-patches.rst#L586


Best regards,
Krzysztof


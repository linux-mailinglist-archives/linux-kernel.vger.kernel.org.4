Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470AF63A362
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbiK1Irv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:47:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiK1Irs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:47:48 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD220E25
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:47:44 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id s8so16248296lfc.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g8cpJZzwZcOfQBKekp5W5PYUvdbAkQEhoY1WkUc5q/s=;
        b=OaK40KI15MSE21aLx8h2c0dYg+ObBzbWw9dc4/k7ayP0dd+qFskF/FS/rF32oVJv1N
         fZ6zadsWDlh6/9NKH48zOfVWRZ23j5nP3UXiKu6qBgPilL+vZrFNQDi0kxsLFniGeShG
         brqSglf46Zk0d1IyO0RkL+FEUr6Wn+Oeyvc0D9Tg6XZRaoB6mNUvICfw5Sww83O/F61W
         G9YKLZVCQvmbAPF1LPSviFuYXeGKD1a6qSllZxNKzlvdIREsuz8IrSTpA6zTPMXAR8Nd
         1XHXIItH8QOxuES9xdZL7jgBQXn+I8kiljC/0ZRUUEm6qUa0Bq40fHfXF6IwYoAjCypN
         mQIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g8cpJZzwZcOfQBKekp5W5PYUvdbAkQEhoY1WkUc5q/s=;
        b=H+Gcj0SXae5nfkLucBigPKc6yGKZnRNW4Yo49LJP3wNNWq8onoThRBr6yF5+/g7/F8
         OdRYGjXsRb6X6HXOYC8PWtvzUpAHIhQyZc7yXkt7e+asp5+Ndx96E6vGCu5zC8I22W4a
         XKsQWauk7zPg+9AHhZcfZnujBl1fHg92P0EBev56v0UU35UeBFcWbDQeJqvl+P/gacdq
         TGDODSauXlqczU+OOxt/e9Uq79k50h0bpFE7ateEdM3rHAMwinnGZQeHyPov89uElcS/
         0ZYwVtJVf9lbV06SwEQS+lT/RkiE278Ij3+XKNl9MHrlyPHTBwwCpeE5gmZJJkH6VrBe
         obMg==
X-Gm-Message-State: ANoB5pmNnO7YR08N6+8OfkSLSihVWBX765a6rIcVU4Jw3nlVFieFdnS6
        WReLFQ+245uV+r4relDaTlbZPA==
X-Google-Smtp-Source: AA0mqf7VZxdsj/udeBpfKWnkOLujblXIoNHpFPGSLvYQsgyuvZyLT/MGO0+3qC+VN+BF6+4RWQDzyg==
X-Received: by 2002:a05:6512:949:b0:4a2:3efe:a4fb with SMTP id u9-20020a056512094900b004a23efea4fbmr18855822lft.216.1669625263109;
        Mon, 28 Nov 2022 00:47:43 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u7-20020ac258c7000000b0048aa9d67483sm1631841lfo.160.2022.11.28.00.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Nov 2022 00:47:42 -0800 (PST)
Message-ID: <5ea89c72-6f27-f7f2-4392-0c37a6ae348e@linaro.org>
Date:   Mon, 28 Nov 2022 09:47:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 4/6] vendor-prefixes: Add Shenzhen Rongpin Electronics
 Co., Ltd
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20221127073140.2093897-1-uwu@icenowy.me>
 <20221127073140.2093897-5-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221127073140.2093897-5-uwu@icenowy.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2022 08:31, Icenowy Zheng wrote:
> Add the vendor prefix for Shenzhen Rongpin Electronics Co., Ltd, which
> specializes in ARM SoMs and EVBs.
> 
> Website: http://www.rpdzkj.com/
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


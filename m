Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A8EE6183B2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbiKCQGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiKCQGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:06:23 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE3F1B1D5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:03:59 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id c8so1413583qvn.10
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKMpDhiUu/M7O0O5bkHOuOa6eYOMJH/4iBj4qwPMl7Y=;
        b=sbL6SBVeknWERt/ChyeC5xi8UZm/BhelfxrCWszU3t2KiEM9cN6xBZnpnE46zBJmCS
         UOIO2RW9QmZd8roO1mgvZLXsSFEdfkbyswDEib/+g2dI1iOH5P5ueaKjHjVuB50gAO1h
         6BdAbqyQUZI4/XXBikqYvTIDZNepjhPoKkPoKGLLhLpFtdM1saQf+Nd5b3w+gWMlWWDk
         Guc6YdiFwLeTGog7HeKBuARVibkdAQBpxbZQ9AyhJBkzC9tmL70GxbXiqqajzJ7pYbU1
         iwBbm4+jU0BHwEjMICJHU9+f6kYRY6kqujF1jvv3/aQLxPEINogM2Ms0s5iX8p/zC8Nc
         q3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKMpDhiUu/M7O0O5bkHOuOa6eYOMJH/4iBj4qwPMl7Y=;
        b=yyIRg+k/IR965pKvBCfb9eopSnfU2EdBjJ96TFMc/ctg2+11SjhG11KsxJ+q+6PKKw
         WP9QqtwxVXTztm35bjNcbMMY1strlEZgGSdLvtDCC6rdg597eb7a9qVxKTbj5BZW67Bg
         aTD5/3+Cl6FOLkGy2JJTbHUUn2OgYjS19qH9tbLgRYJjTHnE+sAMZQvqGYT1AVy2nfDd
         hWiPUBADPyvWZsVCbMQCrLFCGAbj52O8ccwxHSH+Wk3EJc4xNoUgPlJSbONAtx6VdEd6
         h8oHiObUfR15SL5q8+HZ2Ba7k7XQHv/1XU/Z1eM462TNwJNdIyU1PBwd1VE84G44Jv/G
         papA==
X-Gm-Message-State: ACrzQf1SPQu3LwyNFyg/PqMMHupqCIPPYo8OcS/OmlCuJYeovNC27ZF+
        RqqFZfZFWPn+IbDQque0Y1hLCQ==
X-Google-Smtp-Source: AMsMyM69i5ab1Q7nhLqQaq5bDRNkS2UxjRukihuDyZW5o6eBPkvcCOM6zqEQyHBY8YcOZGQOBrctsQ==
X-Received: by 2002:a05:6214:2b08:b0:4bb:bd9b:64e9 with SMTP id jx8-20020a0562142b0800b004bbbd9b64e9mr27475391qvb.53.1667491438075;
        Thu, 03 Nov 2022 09:03:58 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id d2-20020ac85442000000b003a526675c07sm718519qtq.52.2022.11.03.09.03.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 09:03:57 -0700 (PDT)
Message-ID: <a4a52f69-81e9-c4a7-011b-8d79ac519cc8@linaro.org>
Date:   Thu, 3 Nov 2022 12:03:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v7 1/2] dt-bindings: it6505: add properties to restrict
 output bandwidth
Content-Language: en-US
To:     allen <allen.chen@ite.com.tw>
Cc:     Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221103091243.96036-1-allen.chen@ite.com.tw>
 <20221103091243.96036-2-allen.chen@ite.com.tw>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221103091243.96036-2-allen.chen@ite.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/11/2022 05:12, allen wrote:
> From: allen chen <allen.chen@ite.com.tw>
> 
> Currently there are no "upstream" users. So, no existing users to break.
> Add properties to restrict dp output data-lanes and clock.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>
> Signed-off-by: Allen Chen <allen.chen@ite.com.tw>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75060BD85
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiJXWg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiJXWgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:36:15 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C623AE55
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:59:30 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id j6so2831058qvn.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgCiMRv4/zA0qfKFUypWEY5U/CHGoAGbHObmkG9bAjU=;
        b=nI8mYyv168AhumzkCxoWILqL2HSCDNPlZXOLGgbH+tsFoUAG6CstXdbpn9kTGqLSXX
         I7jJznF8AqNwuu/9zC4niHv3s29DeysGaYvQzKzLIhpSrW8LdEZjzxQxDo0C7VAxRBOP
         rOmcUbjrQXSTr1h4Glx2Ia/Bn5PsGho3PIGKjrQ5qptZGIqlGmk6KrA9eOPo7Wbx4K9C
         9x8JeVYnsCvUA7amY9rb7AMo+prVNMn0XHIHrb0XBVaxYnvriA0/kQ3AYYmjRKcJJCPh
         u3gJvCyfUfwZ6D5+SKOfnHo5YfDcuVol/5+7a4UzXB4sZc7gjYUjOzocv49OEnLSakDP
         r9bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgCiMRv4/zA0qfKFUypWEY5U/CHGoAGbHObmkG9bAjU=;
        b=CRztYNqSFnlBQ305GVzWMMr47zbgLH75JWgEspdxiR7fq8MUW24/LJJswM4cxzHPZq
         fFfj8eOmsidut/qArYWLZhYdbK9QvOyWRUKaq2c8aUP7KCr0/LWjdTUjSaCR9BJQTs8m
         5PHYmGN5pfcVr362Tg1nmmG/c2mPcQ4vZU1oHFO/yBlzFEcl01yxnqm8oZCPRUzDznv8
         M2Hrhu+1bPFBXbiy5yf2X4R3qZ+heq2s1O+rwnRl+rThpMLRY6VPu7+q6uNGCFz9rbfd
         OxXraTTedg959DDssWY/S8yVMNwBntabKDwqISnjeh+qoMbdCSvSEAeqNoijjPtiLHrx
         DAgg==
X-Gm-Message-State: ACrzQf0xS2Faa+pK74BRHbFhvSxpn4aDp2e4XeLbKKvkxkq99ibf9Nnw
        0m9CxksDYjCWVJJ/Q8FStKOTLw==
X-Google-Smtp-Source: AMsMyM676vm0ry2ES6d7HLo9qrJwI5HY6Xf3UVXvmpUkNow7rbtrRLf/0gml2w0gx85djKs/FMJQCg==
X-Received: by 2002:ad4:5ba1:0:b0:4b1:9a15:4766 with SMTP id 1-20020ad45ba1000000b004b19a154766mr29127446qvq.6.1666645013219;
        Mon, 24 Oct 2022 13:56:53 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id w7-20020ac86b07000000b00398a7c860c2sm550226qts.4.2022.10.24.13.56.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 13:56:52 -0700 (PDT)
Message-ID: <90bfa1ad-8404-2da9-4235-b7d87dbadbe3@linaro.org>
Date:   Mon, 24 Oct 2022 16:56:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCHv2 6/6] dt-bindings: rtc: convert hym8563 bindings to
 json-schema
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20221024165549.74574-1-sebastian.reichel@collabora.com>
 <20221024165549.74574-7-sebastian.reichel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024165549.74574-7-sebastian.reichel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/10/2022 12:55, Sebastian Reichel wrote:
> Convert RTC binding for Haoyu Microelectronics HYM8563 to Device Tree
> Schema format.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


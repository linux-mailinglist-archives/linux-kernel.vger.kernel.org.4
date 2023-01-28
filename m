Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70D67F763
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbjA1Ku3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:50:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233082AbjA1Ku0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:50:26 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74E9C643
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:50:24 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j36-20020a05600c1c2400b003dc39cb9c33so2781152wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jan 2023 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YaOTMZCAzgKrIAUlQhEpyZEYtdqL85tdGpXqE3dUxAY=;
        b=qOvpqV9opnMpa4pSBiep3eGvxDk1njLZRogz0l6TdkuXNfno63B1MfvYT7nIoSxmMN
         eS7BrQty2F9ViffyCwMiW6/749Q72JJ4ZZIMvYorbUakKI5AOzL3VhhLtRL0OB3pzubP
         5BnqKME5cqWxv3/0fKx61Lqr4hDqVLkZ/4iF4o+2DnNBIXN6heP5XzmgZkYu9cKMRuTk
         HUIezcG762YEnzTUvBUqSeu96gVtIOGFCmxpaxgE82y/78BnArdoZH23XtNre7qEvDtS
         YT1CEjkko9mZQatYkPUeUMkhijRKasPtB4K49ojbW7Ns4GtbaRmPFY7fl7pnPEFupm1k
         fAwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YaOTMZCAzgKrIAUlQhEpyZEYtdqL85tdGpXqE3dUxAY=;
        b=f41QTGtsTnC/XnsjgV4xJ38Iqq4jIkWv68Vwal744VyRFEx/i09GWuYE+0qm3VnXla
         8hl1wzyT68m/7WSuYMRaLt+UddpLi9CShiAHqFkUoM85hgMnmd6UrPvCYV7B/jWJpemp
         yv0n/4yfbWm6FhqmvTWE5nwTrfdna1sY3PdX7zCkd3ap4m+kgoJWPyNAml/177Z7GLiI
         ghQK7W/Q8bu9Vm17Br3pzV4zcSuDo2TmYzH7o/oBpxcp1YqOagPKjUy5FjiXMZYxirbg
         olLHlcLh17wphbS9SjFB2MswOhR4Cm3bxPdx8sYT/cU/XwUcVzFek/wQRhnPXqJsS82x
         q3Ng==
X-Gm-Message-State: AFqh2kqKnzoZxmxcU0k2RiNQ1MNDIMAGEjS6uZc0227R7G0q6D2cc0a4
        wYbKLDdDzXamrDlwwhqiKe3HZg==
X-Google-Smtp-Source: AMrXdXtQdBiLWEzmCwbTdL75wdJctW/pF0mG4rl7sNjikcyTEOXbOzQ9/BGPt7iBfP/i9tFYKnBUHQ==
X-Received: by 2002:a05:600c:3596:b0:3da:1357:4ca2 with SMTP id p22-20020a05600c359600b003da13574ca2mr44919912wmq.11.1674903023483;
        Sat, 28 Jan 2023 02:50:23 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id az26-20020a05600c601a00b003d99469ece1sm10620035wmb.24.2023.01.28.02.50.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:50:23 -0800 (PST)
Message-ID: <b0b49007-7882-bb44-df26-8d2132b34bc0@linaro.org>
Date:   Sat, 28 Jan 2023 11:50:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v12 2/6] dt-bindings: thermal: mediatek: Add LVTS thermal
 controllers dt-binding definition
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, bchihi@baylibre.com,
        angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-3-bchihi@baylibre.com>
 <20230126161048.94089-1-bchihi@baylibre.com>
 <2ce57abd-203f-04b9-f0de-8e524d6afaae@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2ce57abd-203f-04b9-f0de-8e524d6afaae@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/01/2023 23:10, Daniel Lezcano wrote:
> 
> Hi Rob,
> 
> I think Balsam took into account your comments. Is it fine for you ?
> 

The patchset was not sent to us at all, so it is the second version we
see. Therefore it's not v12 for us. It's v2 and it still needs fixes.

I replied with minor comments (which could be fixed during applying) and
the license concern (which you rather cannot change while applying).

Best regards,
Krzysztof


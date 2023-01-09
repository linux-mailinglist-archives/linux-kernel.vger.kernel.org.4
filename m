Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADAF66255B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 13:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbjAIMTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 07:19:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236994AbjAIMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 07:19:38 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66641AD9C
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 04:19:36 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ay40so6126099wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 04:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jitCQv0s/QU9TR/kvFCoOvVqsRo9aYoQJwCNC9DQgx0=;
        b=NrLnlZN5pilVg5pJ9hGkyj6hqNK1xfAudXGtGmFZ4juJPji17dzQOKB6+Hisohwmu4
         YDaL0jl1IKwv+VzdDMeGbGaqZrz2GayM7qxjVci1RqKixqbo55ipujxgqg7uHy8bEWTy
         gRP1MyEnDY4WngXQnWGrjvaQSnVEQAyOVlT79aZg67hQwUe/0N8sfXeAaARGQVev6Xxz
         C+Eauq3URw/RSGw+u3BXoerQUjxwweQZKwNO2hsFp50YNCFvRok3YOtITwbZQXZdMfdh
         LRiSgKYxvETeu8m/bQXDT33vzv0Z3nVyiVCwlFIkz34hVkipn/wtxDtk2g9Xok9slX3q
         7OlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jitCQv0s/QU9TR/kvFCoOvVqsRo9aYoQJwCNC9DQgx0=;
        b=BqN81ykTv2rnLmtDIyFFu58hhMCj1XydfXuHbD9yXDo9SYkq8x0pCuAL7DO3H6hiFk
         mT9IzVugdQ/plVHK2kxJkz1SJWXOJnWT/7j3RQqCop3rLW+vHDMNz31GBRBY+YR652xR
         OtpGB70NpOJsiw+E9DrjW8mww2tpSWvosTV4VDfcZhiLau5uJ1qUpNiQqJQYxV4Qx+is
         3HMRQ9ryxlMD/ZJn5hA01RDk6zg1FSfzibsGNKdTCNzllKPXnFM8mgnM5dbqgTDMDYGU
         4wa1xn0Jq8RhCYx8/6hDYmJa1RWh2zukO85jNetwkJEvIncoqSaE8fYusBunnswz01zR
         dkiQ==
X-Gm-Message-State: AFqh2krmgllI1v1cbjEmW9pbxG3RUIfCFU3MNnROPr7FBuX9L4kgTV+l
        RGajf1fMRCdd4v+J4mrJqhZy1Q==
X-Google-Smtp-Source: AMrXdXsAyJ4lT+wvy3BcH9rELIN1iiZ36lxt2Jac4mrXesJxSQNBHvE03+2SPcfT+LWH9MtDPHmhVg==
X-Received: by 2002:a05:600c:4854:b0:3d3:5a4a:90ff with SMTP id j20-20020a05600c485400b003d35a4a90ffmr48472400wmo.23.1673266775279;
        Mon, 09 Jan 2023 04:19:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003d9f15efcd5sm2493331wmc.6.2023.01.09.04.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 04:19:34 -0800 (PST)
Message-ID: <0b32b198-09cc-803f-9ce4-8a516e784849@linaro.org>
Date:   Mon, 9 Jan 2023 13:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 2/6] dt-bindings: phy: Add QMP UFS PHY compatible for
 SM6125
Content-Language: en-US
To:     Lux Aliaga <they@mint.lgbt>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Dhruva Gole <d-gole@ti.com>
References: <20230108195336.388349-1-they@mint.lgbt>
 <20230108195336.388349-3-they@mint.lgbt>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230108195336.388349-3-they@mint.lgbt>
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

On 08/01/2023 20:53, Lux Aliaga wrote:
> Document the QMP UFS PHY compatible for SM6125.
> 
> Signed-off-by: Lux Aliaga <they@mint.lgbt>
> Reviewed-by: Martin Botka <martin.botka@somainline.org>
> Acked-by: Dhruva Gole <d-gole@ti.com>

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Krzysztof


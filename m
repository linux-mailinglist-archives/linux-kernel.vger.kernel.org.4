Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C5F6E59FA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjDRG6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjDRG6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:58:36 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82815C4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:58:34 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9505214c47fso48085766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681801113; x=1684393113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l2UcFBjQLaNzIK5GKlQDmzU8n4/TMWCbFZ8UL957GS0=;
        b=DRxbbh3CbNMVnJSuArXrVsKACeq+lK4JmAkFYm5PHsn5BDB306szUoyxakPua/w+qO
         ibu3xOu73S/0j4tvvQhxcXgy3TkLwFdVo6+ETCsiPMu3JEgKUaEeJAZVjXiId+GnZ4cQ
         ZF5poLLTvQ+DVSERXxu7v5x7SE6AY61a24Bot7FLYskRWaBGx0L4u/ja37EbJ/s990dG
         EdvMIXAxyNX8zJw8+LHMWo96/sflo9DCCYrrF1U3/sRgszadwxH+i/nGR9BKQ5q+59sC
         UDTMwvi5Da/8RNxrMwW8bbfUD21JSi6iYQpdx0AOBHS1lkAQu6XmFna3lgdLkvxnFLdp
         UILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681801113; x=1684393113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l2UcFBjQLaNzIK5GKlQDmzU8n4/TMWCbFZ8UL957GS0=;
        b=LjDtzwgz9BmAa5Ep1XAXvYeAvvdiE0iYlotWMmr6cRPdD5cSCqduwXUhZunDbT5Kkw
         DtwIDjSO8tGzpcxOZ8HPEM231rsQxU9FhxM59aYexv72gcbRixYScpykJAkxrDpT1oC9
         dbA2Nh002l6mDSjb9vVXjCJIlb4PMm5gt3jnaJ42KI4UtTdVrtd0W2qdhKAJvgfqBGZ9
         At6bnBrtOrMrovKbBmgSAe/lMKRq9O0mYZDqFhwg3PRzRsLuOf9Ieu6hEtNUux6GrRUJ
         NJAhcGqI6U6xwka6iLKmENNz5Z0F88f6B046Y3xLIjj/oDtcmi0M+Wo3TyFZAsn7evDx
         vavQ==
X-Gm-Message-State: AAQBX9e7Enpnl2yLCaJVlchi+4YFSYLJ5kN0wbDS3smp4kYcvE/uuuYU
        bVjyrs2Cw/h/mKnKkHqMWNozv5n1+Rsn73o95QdXKA==
X-Google-Smtp-Source: AKy350b9Xzjko8vvPWxHtLxh286C7kaU/ob46ldBnLSrm6ougidBgb7T/eT5enlIIB04KGHHYyq9Xg==
X-Received: by 2002:a50:fa8b:0:b0:506:6c24:c83 with SMTP id w11-20020a50fa8b000000b005066c240c83mr1386434edr.29.1681801112806;
        Mon, 17 Apr 2023 23:58:32 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a276:7d35:5226:1c77? ([2a02:810d:15c0:828:a276:7d35:5226:1c77])
        by smtp.gmail.com with ESMTPSA id q1-20020aa7d441000000b0050499afe96bsm6691692edr.10.2023.04.17.23.58.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 23:58:32 -0700 (PDT)
Message-ID: <d12255a0-4bd8-6c2e-4b99-113132426bb4@linaro.org>
Date:   Tue, 18 Apr 2023 08:58:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] dt-bindings: watchdog: alphascale-asm9260: convert to
 DT schema
To:     Om Parikh <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230418051446.24288-1-hack3r-0m@proton.me>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230418051446.24288-1-hack3r-0m@proton.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 07:16, Om Parikh wrote:
> Makes alphascale-asm9260 dt bindings adhere to the dt json-schema
> by replacing txt file with yaml file.
> 
> Signed-off-by: Om Parikh <hack3r-0m@proton.me>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


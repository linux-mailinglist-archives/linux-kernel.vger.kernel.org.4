Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D6068ECCE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjBHK2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:28:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBHK2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:28:18 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50146722
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 02:28:13 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg26so13001074wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 02:28:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPx3PngIR8DhUNEkJNoSw3b5IoN0UlUPn06sByvNhzk=;
        b=V3Oqu9vyzZwsIQff8hANhqv/sm6hI+RKNCL8L1ddqodvuTOigdfNOR1sJ9krPX6n6F
         lrVHKVnTuNA2PvxZnsCxzNEt+F/kTAOmjdHBHAyTd2GHzXeRigEFfEuF0+AcPs7mVn/5
         nZU/78C+8Xit7MVWuo+IRGFPSTQDPS2v1lr0tnFqRm8DCvUcQnluTmFTdnyV/9skwFlI
         /hLhIFlS/Jr/49Og9RN+S1rXtDGPM6fk9Qxuq/LpLXYk18JEd/vov3+7C0MQwdLzujPG
         aMWaFoEM9PYEdPwHdA0i0mmd+4U2oCk7JOfs67O/dt6oLU+umO0nBcFISwIMcJ3NI4Q5
         uCCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zPx3PngIR8DhUNEkJNoSw3b5IoN0UlUPn06sByvNhzk=;
        b=cOaAXZmHBLIMEfC7pwq46rNRkrnkKenq+ID0ZvwMoznrX+M4kAUik1w4nf7qsL7Z1r
         5H4i0pi4UbbKQoi99EX15u0TePs4yLye5ZdSf9/nIXBjCl+Cu+QN0ba+tieGXvVvoKOq
         n/R9IUG+BPN1XQo88G9A7IiK/cy7Z9E4enZSuFjlj8AioHFRASBRVPCeoUiz3ha6O2VN
         sp9OpFWq4NLrLEmlNObGEX+mLCNRFcNi+O2ik3zG6Wp3SJZh7zpHo2S6vN0TOnlniDuv
         /0qlrR4fpxM9MSrBHM3zOsp4RtHE+3EAD2kH4gjTQaTd42hjP/6B5T9yo+7pCGTsg2a4
         aybA==
X-Gm-Message-State: AO0yUKVWAztKg4PXFmSruMqTAI4u78stgXlZJZq54FE5+l9Z0X2PYhfe
        I2bBLDzqQELLqT/LxTA6F38VlQ==
X-Google-Smtp-Source: AK7set/WsTpPNnLmbeDYcwU6ylA0LbbTvFVJcsPMQVF9uUqlxofQa+jEXReXVQ6i+OXENazVLtUXJw==
X-Received: by 2002:a05:600c:1716:b0:3df:f7cc:4da2 with SMTP id c22-20020a05600c171600b003dff7cc4da2mr5966396wmn.16.1675852092080;
        Wed, 08 Feb 2023 02:28:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id be7-20020a05600c1e8700b003dff2b493c8sm1601687wmb.36.2023.02.08.02.28.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 02:28:11 -0800 (PST)
Message-ID: <53818676-1e4d-2e58-00d3-ab06b3741fc2@linaro.org>
Date:   Wed, 8 Feb 2023 11:28:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add prefix for Ufi
 Space
Content-Language: en-US
To:     Jordan Chang <jordan.chang@ufispace.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        robh+dt@kernel.org
Cc:     jay.tc.lin@ufispace.com, eason.ys.huang@ufispace.com
References: <20230202081843.2358-1-jordan.chang@ufispace.com>
 <20230202081843.2358-2-jordan.chang@ufispace.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202081843.2358-2-jordan.chang@ufispace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/2023 09:18, Jordan Chang wrote:
> Add a vendor prefix for Ufi Space (https://www.ufispace.com).
> 
> Signed-off-by: Jordan Chang <jordan.chang@ufispace.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


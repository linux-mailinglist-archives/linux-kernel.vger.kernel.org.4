Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82F5FCD06
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 23:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiJLVV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 17:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJLVVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 17:21:18 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B9611B2D4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:21:17 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a6so65911ljq.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 14:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMoJtkP6GDIvxHiFlOtDDZAchlStTRj58VoeHhcLfyA=;
        b=l8IBEA9/bY3lLPl84OdADiyojZcsaaHG/bRcPFzNy5oR8J1vniBNQ8M2bj3hrAoF1G
         e4/0cB4k7OmWIAvZu9LpxLrbhFufXcLxvKxs02DDE55iUcZULCL/uImMqL+F4qGNnjbC
         NqWupxvSJIbv+9vvcYeJqZs9llq1thPLyZk04E4jx4ZdJ42wYQENMgD4TLlbBggoCyMA
         lhz9aA4ijC8mlxvtWDGAwEkL8q8MsUV7xbGpkltMTEvzFlfi3r/il7hbG4Hvbj4uiiQR
         q3ElyOlMCSUg0Y7HvUeqIzXeSNoANbrnBiyy8LQ/5toAZIl1xnhD5H7RPlXpzyGeqmIp
         ySig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMoJtkP6GDIvxHiFlOtDDZAchlStTRj58VoeHhcLfyA=;
        b=plP2k8+Eu4G//ecZEZxKzb80EQg+ps0F6GxG9j1bgFzEqBEUTNwBM3geknfEVqsWaQ
         U8dKcY2rqZn3SKxAf+892DRhYJNdMILoO5NXOY2CUuxCtuhMSKrDN2KhgjexBkW+u9Ew
         TrbKyig3kmn1NSXO4x/jDpcUv8OadGYgmQ2NxltriR8qbRqAIY0Fnp+pSiRTxGBBUrI1
         43KcuBhjla6ka1YuBD6LaVnTFbagOhALRv7u/0pK+ygbflLlkkHrAi3p9a+HbhowXO64
         njDGMU5i8jF+dPuKsFHBNEOX8hCjrObZRI+xF+zvDDgsvXBxffDuL3G/slgq959usS5Q
         0Hgw==
X-Gm-Message-State: ACrzQf352UB1zU32S7UV3mUCSQM7mzfkHR3MOndtUgTnX0PVXTMzPY0K
        6fjEnybGLqcYMXfIRDBgseqgzj9Xsg+i0g==
X-Google-Smtp-Source: AMsMyM6U3PEKV/Z4doHXSyjGCJi+t8X+DP4P3abKMcGtoJYTe8TU7GsJWVYFYZS4KVY0nUoO4r53MQ==
X-Received: by 2002:a2e:7401:0:b0:26e:506:380a with SMTP id p1-20020a2e7401000000b0026e0506380amr11252106ljc.222.1665609675171;
        Wed, 12 Oct 2022 14:21:15 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 13-20020a2eb94d000000b0026ad753448fsm121554ljs.85.2022.10.12.14.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 14:21:14 -0700 (PDT)
Message-ID: <d072875d-4275-a30f-2fdc-2ee0c51879d8@linaro.org>
Date:   Thu, 13 Oct 2022 00:21:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 20/20] phy: qcom-qmp-usb: drop start and pwrdn-ctrl
 abstraction
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-20-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012085002.24099-20-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:50, Johan Hovold wrote:
> Drop the start and pwrdn-ctrl abstractions which are no longer needed
> since the QMP driver split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c | 61 ++-----------------------
>   1 file changed, 5 insertions(+), 56 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


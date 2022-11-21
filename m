Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74AAE631DFD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:16:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKUKQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:16:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiKUKQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:16:05 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7BA31FBA
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:16:04 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b9so13970071ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWUJOeG/zPa04enCW2XorjiM8RYSaxFwzqOSJ4t0ZC4=;
        b=khPaLEgn5sIjpQ/rVRtbW4TPfFp9SM74USATHKHChhgRCvnVTfJPdbiC5WGN1bVtk7
         QiLkKMAl437DI3DaZ3NZBAxpzm6+/Z0PQfKHKfRZUAe+ugTe2n2YZKwlclADe6+7xZDN
         j00cZB0kmeIJNs9rKi3n4K9xmhU4cb3CctQXx6x1V0f2bEzMp+A2OYqECFUS0YAlttvQ
         +NPBcGFNOok2AkxOFewjTpSAl1Sz2Aq5Pgf9natG7Uo0t2PJxSxLpaqiD8DBlGvAEiFB
         Zzg0lER6Hcw5Crn6yAx9rPgrUKzxmRuF7Y1FtpoQETg94tvSeQ+RU7E+4reOAIp2G4HL
         xuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XWUJOeG/zPa04enCW2XorjiM8RYSaxFwzqOSJ4t0ZC4=;
        b=n9Kejv6Dc8cNUGbGyUcdqPQngiILw3ZHGOsVww2BLpyu+v3iA40w+Wsac+Oon36mIz
         VmW1E9TcuYjoL22XY4ZFYWOXB5b/ZJbKzdZw9PV1BNQUq8FeUoOGhNjrXZFKNrK4+F8y
         mrIZSXmGl4K3xzsfeDsk3umf7jsjBdWv+aK/0eTthP0stVMrlh0Q0qaEEdF/eHFI05Ji
         J340M00QpNZp/Rnx21cW6/zj3J54wyeGhrmjZG8OHUTO/bQiLoBdxilJx9ySTFvhJQ04
         VQ5LeHH4NGVhwCC6bwA7AM7qrkeGcftmTjIcAZUwnr6QyCutmMWhR4NpPBk7s6IxYbPY
         EnnQ==
X-Gm-Message-State: ANoB5pmO+c0BH1LPNRQjS/yY0Xv8yLsdwBDbwYf4r+9nDm4SYzTkkVf3
        l/2FBCVpatJ6JlogbHbhK4KG3w==
X-Google-Smtp-Source: AA0mqf6pahYBk6m7Afp7sdpUAI0+3CyI0KsGlCZ114PFjqD+zcE1OVlp+BPydhnl+MgBAMEt/rZR0Q==
X-Received: by 2002:a05:651c:179e:b0:26d:fcef:7d84 with SMTP id bn30-20020a05651c179e00b0026dfcef7d84mr1016416ljb.9.1669025763307;
        Mon, 21 Nov 2022 02:16:03 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c27-20020ac25f7b000000b0049f53b65790sm1955252lfc.228.2022.11.21.02.16.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:16:02 -0800 (PST)
Message-ID: <1243aa10-21c3-5b63-d454-8cec925e9adf@linaro.org>
Date:   Mon, 21 Nov 2022 11:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sc7280: Add a herobrine CRD Pro
 SKU
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dianders@chromium.org,
        mka@chromium.org
References: <20221121043437.21925-1-quic_rjendra@quicinc.com>
 <20221121043437.21925-2-quic_rjendra@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121043437.21925-2-quic_rjendra@quicinc.com>
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

On 21/11/2022 05:34, Rajendra Nayak wrote:
> Some of the qualcomm qcard based herobrine devices can come with
> a Pro variant of the chipset on the qcard.
> Such Pro qcards have the smps9 from pm8350c ganged up with smps7 and
> smps8, so Add a .dtsi for pro skus that deletes the
> smps9 node and include it from the new dts for the CRD Pro
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>

LGTM

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


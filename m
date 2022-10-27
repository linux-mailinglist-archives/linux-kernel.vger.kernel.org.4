Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53E6E60F8FC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiJ0NZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiJ0NYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:24:53 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DBB201B2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:24:51 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id i12so1241872qvs.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 06:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rKIXqmN8fXuaXvk/V/jBOfekdmVMA/Qz1v4HcCw6xrk=;
        b=TCdV8rayNU3MKQtnjdq9vhlRCr9G/0M7wilhh3907Iimmma59PjA9ZfGh5df3LLUkB
         yG/IT6b4XW8J8fz9CJdf7cTru3geU+OsVibORIKBnDZ5IobwbD1LwhJyeqmkpsQHEFZ2
         pfGWPbYIgKvpMEXcw8barRQDiKogA+/7Nf3Sx5Ajorhr8x/diRHFS/dyOMZS558tx8Ws
         XkjS3SHdZ8x2YTeB2KkSW/xldrx/8dfe4TsFl7YmFsdr/CuLI8StNs4wyGZTjRoByXir
         OFjGirxg+N7Pw9yDsOveRfk0Y+0+lIgmbL3mLrfaUsc68pFPRGxQeyLFms+o63jl9mDN
         ROjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rKIXqmN8fXuaXvk/V/jBOfekdmVMA/Qz1v4HcCw6xrk=;
        b=fPUsNbf9DyAeLFqUCKvX72S2jJBOd28hxeGNxGiPaB+d8ZASBdx0tvPd/ImTN1XsNn
         caBJ2XabzAze4r5O/HjdASwJUz1d8eEp9IeUdy23FqCnyrD6CKofiim4GCoM+onQ52vf
         rwQIDwOiHP5OvkUH6WYxNvUoM1uQI9wlnPQznfEFuYwpT7iieErd/aPDmzNRqpgooT62
         /+ipbgDh1vL0oym0V2PVLQlZwnKlMHB/bQkylfyQ5/m2Kq1wWGh4vLYUw3ME3H1Zbai5
         Nm6Vtsq9raIEVgRXYQBGT4wFMvPa0V3p6j9VbTTd56SbMN4XXzp9cCBl+gsniqpNEp30
         YhUA==
X-Gm-Message-State: ACrzQf1miCQCw2l8x2ishbKu6jF65mO5EqsLYo5xVM7VyQlm+ONlzLp0
        dtxO9eTnVPFIaU+Wb3ytD3I18TU0cBLcbw==
X-Google-Smtp-Source: AMsMyM4ZRHfn7E15uUXl94Q3NLzRptQt9ctzDaAkWZaCMz6b0Hb3yKny5hbnB21qs5Cs9thNtWfEnw==
X-Received: by 2002:a05:6214:2682:b0:4b4:8c75:2488 with SMTP id gm2-20020a056214268200b004b48c752488mr42343114qvb.88.1666877090922;
        Thu, 27 Oct 2022 06:24:50 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id 184-20020a3705c1000000b006cf3592cc20sm951037qkf.55.2022.10.27.06.24.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:24:50 -0700 (PDT)
Message-ID: <da796e23-56c1-6fd1-2299-2e55b965569a@linaro.org>
Date:   Thu, 27 Oct 2022 09:24:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 3/5] dt-bindings: clock: dispcc-sm8250: Add
 EDP_LINK_DIV_CLK_SRC index
Content-Language: en-US
To:     Robert Foss <robert.foss@linaro.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        dmitry.baryshkov@linaro.org, Jonathan Marek <jonathan@marek.ca>
References: <20221027123432.1818530-1-robert.foss@linaro.org>
 <20221027123432.1818530-3-robert.foss@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221027123432.1818530-3-robert.foss@linaro.org>
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

On 27/10/2022 08:34, Robert Foss wrote:
> Add this previously missing index, since it is supported by the SoCs
> targeted by the dispcc-sm8250 driver.
> 
> Signed-off-by: Robert Foss <robert.foss@linaro.org>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


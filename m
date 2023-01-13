Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7EF669E7F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 17:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjAMQo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 11:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjAMQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 11:43:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F60821F
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:42:39 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u19so53546872ejm.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 08:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B2qfQi85BFXWzJOoJ/C3jhHUUhELCYlryxRCopmVC4E=;
        b=FJi8siw+vXtF8D9mi5G5vvDf0lPW3f9pv9Iv2mdn1DnyXqeTqfNk9isOW/Ak7Ety1u
         yATIlfHuoBfZjkYoz11aWRvr4AJ6raeyyxEWvbwEBApB/rjJebvWvxMEHYo1pQqhCp42
         RJaFcPnFxTpn/v3NvFymFwNRkM2fgZobdg/BzC5Fo6fZDy87EJZ33KTUkfn+Rc5dRUhB
         kucSA2aMKxml8CBtFs3jGhf2BICu1rP4b8GYY+y0+pwKIYLvpfmTvJpCcH/EWhflora6
         EUMSYXzVbGdYt5Oj5aqpeZT1Vu86TCRRbcTHMlrntskE4CK3mNgW/POij7vjsP34Da3O
         20ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B2qfQi85BFXWzJOoJ/C3jhHUUhELCYlryxRCopmVC4E=;
        b=YDq2TzMrGkvK9xrFgthBQI9SmXV3YVyBwR0m7QfCueS0fPPnTSTMoq8TZUTyVfBwaL
         ewCPk6B+5bujWuwGQoiSU8hAmAEJtPIF8MZcU8r9P3cAfv3+qXDT5C5EZjYZ4jwgtV1v
         UZ0OKeZp9pN2pNeOF4R0M86DqNzw8x19p1257YWuFGVFIsxURiNOLd83q9R2YIlh1LJj
         W07K9PDUZ7HiBoaFk9le45iO+etzHKCAj6xk0XO9df1UtJ9/SmojpLp0sgVRtauNg0fz
         lRvHyyRYjeT/rBueK5LFo80gkRi5UIsBu/mh2mma7nQe8pW1HQ6fdmXuvbKZ+Arw88KV
         09sw==
X-Gm-Message-State: AFqh2krYJiOykt75VyBmBIa8KDyP2V8hBn1XXHB2QPhd5+12tStw/zFR
        9VKgmcdpZ5KDQ46WJfPEr9cwTQ==
X-Google-Smtp-Source: AMrXdXu9Z3Wyw2FmaT/keEdSguCI2C4xDyUJleWKV22VndENhfLhB/RhZnxZD/s+XT/m/3NrJ5mjnQ==
X-Received: by 2002:a17:907:c498:b0:7ff:7876:9c60 with SMTP id tp24-20020a170907c49800b007ff78769c60mr71047961ejc.15.1673628158089;
        Fri, 13 Jan 2023 08:42:38 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090618aa00b0084c6ec69a9dsm8661401ejf.124.2023.01.13.08.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 08:42:37 -0800 (PST)
Message-ID: <37755ba1-e8d0-cd9e-73a4-6501746022d8@linaro.org>
Date:   Fri, 13 Jan 2023 17:42:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/6] soc: qcom: smd-rpm: Add IPQ9574 compatible
Content-Language: en-US
To:     devi priya <quic_devipriy@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <20230113150310.29709-1-quic_devipriy@quicinc.com>
 <20230113150310.29709-2-quic_devipriy@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113150310.29709-2-quic_devipriy@quicinc.com>
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

On 13/01/2023 16:03, devi priya wrote:
> Adding compatible string to support RPM communication over SMD for
> IPQ9574 SoC
> 
> Co-developed-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>

What exactly was developed here but the other author?

> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> ---
>  drivers/soc/qcom/smd-rpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Best regards,
Krzysztof


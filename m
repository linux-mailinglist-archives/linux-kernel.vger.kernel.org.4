Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DEB6F59AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 16:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbjECOTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 10:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjECOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 10:19:53 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C3759F7
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 07:19:52 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-95f4c5cb755so1008007266b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 07:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683123590; x=1685715590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWgO7hULIYINXjGmfuoAQDTi7WMO+rhRdnfLea0FV6s=;
        b=CP/OHCt/e7mqivbmA8RV5uShl7FpaLgGQ+cEPXffsVjXHIDDZdUZKj59N3CC7GjNox
         77W32+m1Vevs34OaSgnTI4YZxQmonF4WchSd1O5Mf6FhU7TMpFWixFiZPu7LUXI8gAfj
         oPk9SAjXBFPfT7fcf24IJSXcsy6oO3q1yx3M6Rn2Thyg7dEEPuwEPF6l3UWRsYaKV8mu
         w5oE+vhGFlT2v3/mQ9LFQzNtSblCI+0IZQ/s3GEEnFN4QXgUQQB8PWbFfAFT4vnlpG3D
         8vs1vFKNRfWsyVNr6tf9H7txea5GI2qVR5VDCEQBTQnz/tedyrZBk1oPsSYzEWsE3fhd
         B+zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683123590; x=1685715590;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uWgO7hULIYINXjGmfuoAQDTi7WMO+rhRdnfLea0FV6s=;
        b=XQE5XfmDii9ZxmULGuPGat8XLl8MzABCzhTTcleLg0T5ySDHuKXgOHZaPF7wKWXe3z
         eUTtL2LYP9RQyEpKygke+fsWpn0xEPjyS9oF8+NoBvj0P12hB7pjh0dBEPSYJiOO7dlj
         tKtZzhwN52AnI45rXCzihp7KpYe8lbgY7k/Y32/GGB7hGk+xUFS7jW8MOuGRkUheEXQd
         eJJxwFanDplLKeJ745tIYwzvk/MB+TWe4w/LYZSIxUvhye/mCiVfSZSaxaAbqi7gQG0P
         hR8GpHNqjLWEb5L38lrxkH6N0UoFgAWOV0TfHOZC+9gTHT4sg1ERhwBRAgksbnUQBNuq
         MXWA==
X-Gm-Message-State: AC+VfDzjR6PKSobfycFyjQicXnFezPhytBP5y+JS4Jb65uA6khLEyWvU
        JwOU2kkrbMid33LyM5tk8QyglIC7uvowdY78re2PZIao
X-Google-Smtp-Source: ACHHUZ5TWjOPSlETWTZrvGUlMvw+LaPKm7EzQMkfpLGL86DzCj1hoJhrNBBY+/0jXpFGI1jS8SdmJA==
X-Received: by 2002:a17:907:25c1:b0:94f:62a2:d1ab with SMTP id ae1-20020a17090725c100b0094f62a2d1abmr3360895ejc.63.1683123590563;
        Wed, 03 May 2023 07:19:50 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:db42:e3d0:c55a:8cf1? ([2a02:810d:15c0:828:db42:e3d0:c55a:8cf1])
        by smtp.gmail.com with ESMTPSA id e6-20020a1709062c0600b0094ef2003581sm17287005ejh.153.2023.05.03.07.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 07:19:49 -0700 (PDT)
Message-ID: <256d8a4e-ecad-668a-b404-fd10debdc8f5@linaro.org>
Date:   Wed, 3 May 2023 16:19:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 1/2] arm64: dts: qcom: pmk8350: add reboot-mode node using
 sdam_2 nvmem
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230503-topic-sm8450-upstream-reboot-reason-v1-0-c5ac3dd5b49f@linaro.org>
 <20230503-topic-sm8450-upstream-reboot-reason-v1-1-c5ac3dd5b49f@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230503-topic-sm8450-upstream-reboot-reason-v1-1-c5ac3dd5b49f@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 16:13, Neil Armstrong wrote:
> Introduce sdam_2 node, which is to be used via nvmem for power on
> reasons during reboot. Add supported PoN reasons supported via sdam_2
> node.
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Tested on HDK8450.



Best regards,
Krzysztof


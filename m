Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DD5B6B8B77
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjCNGpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCNGpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:45:06 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18407B48B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:45:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so14018141ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 23:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678776301;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GsnKTD0SODWoslIHUD0hxg2mluVVvz6vXURt6MrNCRc=;
        b=WHZXJJv+tf2nveUE8CdkITBCP/nRSC3CsIG6qRQuGOtbrLt6WR+Q/twrUD7gH+tKqt
         RGs6ETBjJuH/zKvrTrRzi35e8vhqSahqiWhcW9MVBa9WRAadGYdN89O3ZY7sHIk9vhfi
         HwqKrMcT2Zs+IUrLei4fHpocehIX9zLmcYdnA2QLvOvVvoAZQpB29qw9Oxk1gJy0P7Hc
         Ar3EghccJlG8R+1cLg8lP/Q2vxfd86KNypTaq4gipCRLcS6YQD5cJnPSezsOdjKVjDrs
         d4sW6UwOxT5USE8oQaqyv6X7sybdgyeWAnyEHbV+87iko4z4bVSY1lL72kFzKYClYuB0
         vq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678776301;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GsnKTD0SODWoslIHUD0hxg2mluVVvz6vXURt6MrNCRc=;
        b=jNNZC9tENQFVPPVpcOrFQOM6rzP1K643DRS2Jw7cz+fQMHo9iBzhGyjRVjBiWNj/Nw
         0yTHu/Ny+vKIRIsVrn2aJK6cfQd4+cM77eCuXjXyIM46i++OUcwKk4kYQHfo21RQBcdR
         r8ChtaTp2WfF4tjL5HlO4MoEWaJuF8+OHe0oStAALruPiyEnV+tyfAaDvdyFo+pJ87y+
         K/Vz+daprH+FRjO3Wbob82n3DIfV5lXcISGp9oN2l4jZN5zpwmlWv+LmS8+5ZKdc/b1C
         xX983NrKQCTBSEbxr9mBZ9opAJFnSvE6amz2nqbAA7txxGN7Y+a1bY5MbTvtzwOVySVr
         bJYA==
X-Gm-Message-State: AO0yUKWxTYommtfDN3iWvODtX7QHkbN2gufPZgX2EpGJii2iRvWgXrR2
        2pC6o14hi35YgNjUlPqLs0QxJA==
X-Google-Smtp-Source: AK7set8UizlHicugDTmsmqEjUg3hCIi6xbzA1UNWlJstLOyjii+Imx79NEcx3d5+DyiUiZ5chI89RQ==
X-Received: by 2002:a05:6402:1347:b0:4fa:2363:6806 with SMTP id y7-20020a056402134700b004fa23636806mr11312501edw.17.1678776301370;
        Mon, 13 Mar 2023 23:45:01 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id d20-20020a50cd54000000b004fd1ee3f723sm508535edj.67.2023.03.13.23.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 23:45:00 -0700 (PDT)
Message-ID: <307e99f4-00c2-0644-ddd1-1eb98f057f75@linaro.org>
Date:   Tue, 14 Mar 2023 07:44:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 3/3] arm64: dts: qcom: ipq8074: add compatible fallback
 to mailbox
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230314050005.10409-1-quic_kathirav@quicinc.com>
 <20230314050005.10409-4-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314050005.10409-4-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 06:00, Kathiravan T wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> IPQ8074 mailbox is compatible with IPQ6018.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- No changes
> 

Why do you send my patches?

Best regards,
Krzysztof


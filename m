Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCEC6B8CE8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:18:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjCNIRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjCNIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:16:34 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C1C99D55
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:14:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id o12so58494827edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678781689;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wboTlz+tvE23niIuCWa5AP83n6xHxsyLfDerF7pTjSM=;
        b=OMP2Pg2VucXTq3RaZgj0lXYSRxiP1CU+5fgZV/OifjHXkNe3jrAe7fhzW3Lzeix2IF
         n9OMJc3GsHvLkDu4JiZ2Iwq14i52HSIKWYpPlEL+cio7KhsG79+XiTxSfWPBJzH8NZV6
         ZavvTnSluRMmpsBDKxSO+Bf5hV35cM0z/UDUpURuk/1UdJlbBARpwFKqnw8WHMX/9qXV
         lu4GBms2S3lNWQRnb0NGH7EVPH++QGB7epyUfUBPtyc/Gg8AMV4u6TczbtWnq0cnQa3B
         i5CC2zq0BeZDt64qawKjD4G5ZMtSeuEHU+hv5/V6t4WA+GfQv3NyaSOZGcf2/AxULVuo
         NnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781689;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wboTlz+tvE23niIuCWa5AP83n6xHxsyLfDerF7pTjSM=;
        b=VltBoWtY1yUTwu4gNTWbBAzSRxd2HzN4MdOXKo5D6hgt+VWEDWIDdTZa+VbEHeSxJV
         8JPjLpDuoGZsgMWRxHGjQhuoMQus/0AhS7zjWytryZ3AnVzuaeD9warudnZ1E09CxrgS
         dKctTN/eS5xOKyWlbZAgFDrhBqC/ZUatbRT4vgXvoDw9MwXPxbUxYTNQVn4FwjL9nO/k
         OT6Ik2UOIlMxlY5h388b0DYQWqKQBcDVVnC49JfTP13HxheLcIiHjQAnVoODOrCn5kWp
         kh/32lyFK9gKxwczzm+JYC4rhokokM5iP0UAVFNdgMchD6Mx02WQUKfw96K1PzKDVNxq
         8k7Q==
X-Gm-Message-State: AO0yUKXxRpKXSnJO5LSPekhTCGq+sy01e0ryn9kdKYlntBAhdfDLVBFl
        8ywiN9ZdRArGqs4ZdujNH+W0yg==
X-Google-Smtp-Source: AK7set+faacEFbuyaWCfRFYG2V0EhpSmAjWujyP1fyxeJV54nDc+J7N1cs8blrEkU+GccFX2iB7UoQ==
X-Received: by 2002:aa7:c245:0:b0:4ac:c44e:a493 with SMTP id y5-20020aa7c245000000b004acc44ea493mr36246588edo.2.1678781689499;
        Tue, 14 Mar 2023 01:14:49 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:6932:5570:6254:9edd? ([2a02:810d:15c0:828:6932:5570:6254:9edd])
        by smtp.gmail.com with ESMTPSA id v10-20020a50a44a000000b004fd204d180dsm600243edb.64.2023.03.14.01.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:14:49 -0700 (PDT)
Message-ID: <43a38d58-c105-cdc7-2d83-affd9d724780@linaro.org>
Date:   Tue, 14 Mar 2023 09:14:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 2/3] mailbox: qcom-apcs-ipc: drop the IPQ8074 and
 IPQ5332 compatible
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230314050005.10409-1-quic_kathirav@quicinc.com>
 <20230314050005.10409-3-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314050005.10409-3-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 06:00, Kathiravan T wrote:
> Since the IPQ8074 and IPQ5332 mailbox are compatible with IPQ6018, we can
> use the compatible fallback to IPQ6018. With that, we can drop the
> IPQ8074 and IPQ5332 compatible references, as well we don't bloat the
> of_device_id table.
> 
> Suggested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

I never suggested anything like this, so: NAK
(also responded to v1)

Best regards,
Krzysztof


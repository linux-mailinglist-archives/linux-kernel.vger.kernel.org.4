Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABBF74E68B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGKFw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGKFww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:52:52 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041B31A4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:52:49 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51e28b299adso7066365a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689054767; x=1691646767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTH+b0FMii3gSaeeQ1T55MVp/pMuBpVsJcjB20chDZo=;
        b=Uy/p1R1mTnlbbEiuCXQCUL7p/f3jYl3zcb962iSP+fXVvELx0QERfZ31KtA5oL3/mU
         Xw+bsxFpzHKbHA3+dEB+GRgNLWXvafeuaGwuILSDlQ0JT92oFg+F3+DF+MtXNf2kFh7U
         76DFQtid6pLHywlroeR/AeTB6LrP0NW7seBnWGywCYMQwhcuDYVP20XF4NzitJ+4Ylrr
         +dR+bzlEEftP5UM/sfUAscyiAJcy5bV/IyHNaZJuj8NPoCLVDJ1snEsGFHpkhmWziMtw
         rz6xQlEzwAjmbJ6XR1wQd2Os/lqOs+txEyXZ5qEV6S1TB79HZqdnB2RfERTDiaKHaPUt
         1V1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689054767; x=1691646767;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kTH+b0FMii3gSaeeQ1T55MVp/pMuBpVsJcjB20chDZo=;
        b=jwQvn/GurjsEYmkIJyO5hziqRkIoc46L6jUNv0tPZLwK+BRIkoSZ7BTmxj3WZ4OGo5
         k1iMk27sCkPvsmt7XpBnyitRtG+jNYA9dD1ql+3zb/a1y+0DEp9CV43A7ERXRXQqPF5s
         E2z3H5+OXcx/JUEChUV2pwVcEuhXfZqMTdfZsRCwwyz8X7FzhgyM9fKq0DtLz62OcNSZ
         YvyLu7oaVVcB2y2h26cZXp+6cS3BUQ91e4p8IXnUDkg98HIw/ms+df8UBFi314DPJRKE
         l4MyYQwKEOpS6EzLrf4kzknYToKoXWxO8Y/FVAB5myUMjKI4JbZMr8v6ztD7p1AgeIvZ
         LO9A==
X-Gm-Message-State: ABy/qLZbj9L7do8bxAgH51OqyXc9dc2AlDyZJB9DkjG3PJuA1awpAhet
        hyPj9S9m4wK1VvT2xxnPdKZ0/Q==
X-Google-Smtp-Source: APBJJlFqwJKaAIODVwviak6jXzJPuzXa6kHuy5wpvbBcFllldmrIXayqoYJUtUiG1TEiy3EQev1igw==
X-Received: by 2002:a05:6402:38a:b0:51e:3558:5eb6 with SMTP id o10-20020a056402038a00b0051e35585eb6mr12369977edv.3.1689054767362;
        Mon, 10 Jul 2023 22:52:47 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ba17-20020a0564021ad100b0051de4f15362sm710214edb.5.2023.07.10.22.52.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 22:52:46 -0700 (PDT)
Message-ID: <2040226e-9b45-b409-3edd-a5b86d86daa8@linaro.org>
Date:   Tue, 11 Jul 2023 07:52:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/3] dt-bindings: power: rpmhpd: Add Generic RPMh PD
 indexes
To:     Rohit Agarwal <quic_rohiagar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1689054169-10800-1-git-send-email-quic_rohiagar@quicinc.com>
 <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1689054169-10800-2-git-send-email-quic_rohiagar@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 07:42, Rohit Agarwal wrote:
> Add Generic RPMh Power Domain indexes that can be used
> for all the Qualcomm SoC henceforth.
> 
> Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  include/dt-bindings/power/qcom-rpmhpd.h | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 include/dt-bindings/power/qcom-rpmhpd.h
> 
> diff --git a/include/dt-bindings/power/qcom-rpmhpd.h b/include/dt-bindings/power/qcom-rpmhpd.h
> new file mode 100644
> index 0000000..4da2e04
> --- /dev/null
> +++ b/include/dt-bindings/power/qcom-rpmhpd.h

Filename based on compatible.

> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
> +/*
> + * Copyright (c) 2023, Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _DT_BINDINGS_POWER_QCOM_RPMHPD_H
> +#define _DT_BINDINGS_POWER_QCOM_RPMHPD_H
> +
> +/* Generic RPMH Power Domain Indexes */
> +#define CX               0

These are very generic names, usually not used in global headers. Please
use some reasonable prefix.



Best regards,
Krzysztof


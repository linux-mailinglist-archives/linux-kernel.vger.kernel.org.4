Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE51465BC56
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237051AbjACIic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbjACIib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:38:31 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B279DDE82
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:38:29 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id p36so44693438lfa.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4CHw5FRtPDUOv1NrpkJyQctZ8ejkK9MC1Qo92iGbQHA=;
        b=yWUERWb3HN5RS07LpLAzOJBjd4P9b6jvyMrjMHFK3nKwcgTP3rK53AfQOTMwIvhUlH
         HRnTv0odk9zaw8ACrc+glhjQDOj0uoSDLhL5Qu021HGlkPyM8554WPC8nnqhKI1yDjps
         gBPl3ja3J6Be7JPn1RgYe3VGFqd9FZpDmkCa49pJIyLuHqCFIZvaBfnrC7O8Hg5R0jhG
         mQPlOyYoDPzHUEfYqK3jdJFWttdEXqzUvHX1ywpBmSkGqplYR7iPQSOvtOPRWE0JGemO
         rsgRFq1TiUGhlkt8TQGQm1aUT1eXHPQsyu7HShhQ3qK6rkEKPkw8yR8v+c2Mutx01Szm
         doJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4CHw5FRtPDUOv1NrpkJyQctZ8ejkK9MC1Qo92iGbQHA=;
        b=eFlU4vzoIPTGxSsnRBfqDu6gNy4kZZtPJrTxGjB8h5B7TxJzMFgBHvTFKWcoW2MHWM
         hKlexHjxRlMRl20iJvEpeFljBblMVz24cynceKTvQdw/k8nFTAH1RFZgHwocvwWzfU66
         Q7Mljbd2/trcfLXIfb0motLRNc4oC+ckEab9oWyH+UeVNErikCQRBvoVy6ne/cWLTj/t
         vWYvbYNxSAdMavxX7/S/zaJY7OEW58+C0xvNoS/d+dyLoWQfHyjZ2zOhOyCiaHC+siAT
         bweMmhZIorLWSjLPt/5ukfz+/25akZlh9fcw9wYib4+ii/lbPsj8fX24VxQcVbCskE/s
         cKqg==
X-Gm-Message-State: AFqh2krsFQo+62T3D3B0iIM+kvY9Jo/o4jLayqg/5f4chsBHJoRtFqgR
        w5kjvUAoYGH+hamzjvpOrMhBjw==
X-Google-Smtp-Source: AMrXdXt8qdijhfpphBEQyqtUvrn7jPvTr9kTEBH4cPMC3TMxiu2AnOqGKjlaZxNaozv/f12gc+22cg==
X-Received: by 2002:a05:6512:2591:b0:4b5:7dd6:4df0 with SMTP id bf17-20020a056512259100b004b57dd64df0mr12477210lfb.32.1672735108149;
        Tue, 03 Jan 2023 00:38:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id z9-20020a056512370900b004b55c1b5c66sm4727589lfr.157.2023.01.03.00.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:38:27 -0800 (PST)
Message-ID: <7dc37079-c577-8eca-2c6b-8715f0a715a9@linaro.org>
Date:   Tue, 3 Jan 2023 09:38:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] dt-bindings: reserved-memory: rmtfs: Document
 qcom,assign-to-nav
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230102165034.830620-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230102165034.830620-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 17:50, Konrad Dybcio wrote:
> Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
> others really don't want that. Since it has to be conditional, add a
> bool property to toggle this behavior.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> v1 -> v2:
> - Rewrite the newly added description


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85926DEE22
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjDLIky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDLIjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:39:46 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F410A83D9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:39:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-94e102534d6so117961166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:39:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681288656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JF3WPk1WtXSLnyqiPhKTVud46FRRu6czewRsuPqGnnA=;
        b=ZSxAOBx1oV71IYBBZolreG5VEmcG3zApfwaekJpqpB/rFLbe14d/EZyc2f4gM4gjn5
         66hPH7RQanNvJo9bHbC/g9qQdo2fj6N8LMo+laioykVoGdf6nakDppwWWF5XN95B4gNu
         mz7gAQmfYPlgtCJuAmpA6itnaneNbtkzbEtZn+KurKTQeIBCJ5D2XK3ktlMkjPenisk4
         f6YWA1U9rhY+MhgRwi4n6iD8hh69sZ+1r0UiK2U4fDB4MGNiczsXMd5yzk/UXoxZGoSo
         feNNIQORsALodcix5fQ0VXH+6UpVXSw03ZUUGzaVX92BGy9zfcvViAqF6SoM6+Viqi+x
         ugIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681288656;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JF3WPk1WtXSLnyqiPhKTVud46FRRu6czewRsuPqGnnA=;
        b=wmgbvt+XqPw9Zpa8kHp7cjc9e43Mp0sx481yw6ltaAVZOjWfwKCnNq5Ic6QVBA/D9C
         8+HgDmzNyBtDANB5kCbVuvBZsLIzFUcjdglQXep2Uy8koonTTdxaEfyTrXmVaiSrxpEh
         LXDH2yJTSJPo38up8lPC0rm0umHoXSrzKkp9umcntIG9zLC0UixCP8lzYcIwfcXpwu6X
         TNfBErL+Tl4Jv5Tz6CaEODOanGrSnJBt61JFhoFbuiUMjAgqZzxGubCw5IXYPFmmFhHY
         bNXXMWz/wHGd+xLaim1/noc4UmE1U6qmd6prog9r09QRn4kLu6PbMFxsoOwR4lMO6dBz
         4l7Q==
X-Gm-Message-State: AAQBX9fHUD9K626GPXi9jGQPeo8aNP3fsD6mnEvQBgEuF1AlR+TPIx4+
        Pz5y9Pnje8ncMWqJrFHcB9ioqg==
X-Google-Smtp-Source: AKy350aBwVs8SnHcaM/3pKKf00g7XCMEHYzXX/vNSI56mW4MmK0vC1Ick41N2B7PMC1esUn6k77bJQ==
X-Received: by 2002:aa7:ca59:0:b0:505:879:b54f with SMTP id j25-20020aa7ca59000000b005050879b54fmr279118edt.37.1681288656056;
        Wed, 12 Apr 2023 01:37:36 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id co2-20020a0564020c0200b005049297c5d4sm3807023edb.56.2023.04.12.01.37.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:37:35 -0700 (PDT)
Message-ID: <4e5d0efb-581e-1b2a-6173-75e5f8ba6588@linaro.org>
Date:   Wed, 12 Apr 2023 10:37:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4] dt-bindings: net: Convert ATH10K to YAML
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20230406-topic-ath10k_bindings-v4-1-9f67a6bb0d56@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230406-topic-ath10k_bindings-v4-1-9f67a6bb0d56@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/04/2023 20:19, Konrad Dybcio wrote:
> Convert the ATH10K bindings to YAML.
> 
> Dropped properties that are absent at the current state of mainline:
> - qcom,msi_addr
> - qcom,msi_base
> 
> qcom,coexist-support and qcom,coexist-gpio-pin do very little and should
> be reconsidered on the driver side, especially the latter one.
> 
> Somewhat based on the ath11k bindings.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


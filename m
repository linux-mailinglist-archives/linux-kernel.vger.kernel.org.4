Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BB5FFAC6
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 17:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJOPKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 11:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiJOPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 11:10:34 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDB837194
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:10:32 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id j21so4269197qkk.9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Oct 2022 08:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yqMwDclQ45ffIH7ERhsrTKPoNsfFtriO2oaxRQc5CLc=;
        b=YuvGwldRThMSnUzXBF3OyQtevTelouY9e0EcNqy8Coc9IjbOHwvoAIkfIhU59HqX3T
         W852wvJ9xYj64Tu05Y9St1YsaE93i/uLsnLVVEps8a0gid4k/eVyfoOZzr1s+dedZFkQ
         tCFeeOUejDkjPriuet320QVDMAkBrh5fMYmmvwIXn0WJFhU9P2RSHn9Dv5sTH3Z2FbWS
         cMBdf55LHeCmwkVFys1R5p41M4AKdjzUGpuBi33DQnGC3bqsTFjV8acDT4018ZmvOxqy
         ClCXCqJqso9SNLCDR3chnQruepIEkeyzqSScQ6fSRkc33EtJHd29CI4cTQ1bZDnTUsLR
         r+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yqMwDclQ45ffIH7ERhsrTKPoNsfFtriO2oaxRQc5CLc=;
        b=wIUISQtIqBhK7jS3tG7rc8qijQzfzc7s8XKtxcTmBlAGCAVxoIESIGt+16q1H3yYfZ
         CD7guaIF2OP3q9yXZ/EN91pqqffCkYX5vm75dK6pmafM6AkZyBIRmbnH2X3IgENVsbBQ
         8EVWUVNPc14RqoOlM0NG4quETdn+XA6gRja+wQKITDjs5kX1Tts0Qd8UAru5DsZ6XZdG
         HtIPFng7QmS3SZcqiIySpSyhoslxoKlg/FCLSTRcERV6Z4bHZOqSt4BXTlvfUPm7DGbZ
         9JnE2DnSayN2k6aqLuv/NHhCvplETaUzBaAvqhyLginlNRE1jtyXc48MuU7aHsLKNkKR
         hYoQ==
X-Gm-Message-State: ACrzQf3vh11OAeO32sdlCNJDfADtRLkkY/iAR/2oSvYP7X7G4ekXS59+
        22VJBgQoCGl7XkNG7CAZ6BJtPw==
X-Google-Smtp-Source: AMsMyM76SqgrJjCXoUR629croDqDLouV14YVwjk/5C6TXSR/vjLAmXN8yyI7fF/Js5bLiNnRD/VBAQ==
X-Received: by 2002:a05:620a:bc3:b0:6b6:5746:f91f with SMTP id s3-20020a05620a0bc300b006b65746f91fmr2077337qki.391.1665846631584;
        Sat, 15 Oct 2022 08:10:31 -0700 (PDT)
Received: from ?IPV6:2601:42:0:3450:9477:c2f0:ddea:ea08? ([2601:42:0:3450:9477:c2f0:ddea:ea08])
        by smtp.gmail.com with ESMTPSA id bc10-20020a05622a1cca00b0039ccd7a0e10sm4079811qtb.62.2022.10.15.08.10.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Oct 2022 08:10:30 -0700 (PDT)
Message-ID: <247ef598-b3e8-f012-4cd2-7aa8c652bac6@linaro.org>
Date:   Sat, 15 Oct 2022 11:10:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v2 1/2] dt-bindings: interconnect: Add QDU1000/QRU1000 dt
 bindings
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221014221038.7423-1-quic_molvera@quicinc.com>
 <20221014221038.7423-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221014221038.7423-2-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/10/2022 18:10, Melody Olvera wrote:
> Add interconnect IDs for Qualcomm QDU1000 and QRU1000 platforms.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/interconnect/qcom,rpmh.yaml      |  8 ++
>  .../dt-bindings/interconnect/qcom,qdu1000.h   | 98 +++++++++++++++++++
>  2 files changed, 106 insertions(+)
>  create mode 100644 include/dt-bindings/interconnect/qcom,qdu1000.h
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> index a429a1ed1006..c4cfdcf40ebf 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpmh.yaml
> @@ -27,6 +27,14 @@ properties:
>  
>    compatible:
>      enum:
> +      - qcom,qdu1000-clk-virt

Test your DTS or bindings. Your DTS (or this) does not match the other
and this is very confusing.


Best regards,
Krzysztof


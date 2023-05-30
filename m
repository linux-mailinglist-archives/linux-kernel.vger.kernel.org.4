Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7FF716103
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232514AbjE3NDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232402AbjE3NDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:03:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BC5184
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:03:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f4bdcde899so4802991e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 06:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685451819; x=1688043819;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LzBOsqpAKP1GRqHJCHjWzM7W2wtshKvbHikXn0UNJ+w=;
        b=g+GY++Kpi5N3bKfymnIQM842X84OVDlDN+hE3wY4F2UDq32bZPqdm4xzBkOKzUEIFE
         OlrcdAlziwNyx16w0vk/XHjiCc9HWdqZJmT5l9rEGAGIyJlFZUtWGQNHBdB6EgvtqV+5
         hEBbIZnITz2FwK3kWe4x0ZM9Lxxj0l2j649YVBmvF10UZXAV91Fy8cw3KMA3zflJJzTY
         +FRtMtPlTe92w1im/HXgt0e8nJcH2LZXBqHd+zsBmskl7lP39bUMmkefU9lnmOSAb27+
         t4fMOvi7Dk4AnzoYp2h2GwXWfy+omwEA2h2wj9/TQQpcy75uanJ9h4H6FdPhi1nKP8iu
         fZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685451819; x=1688043819;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LzBOsqpAKP1GRqHJCHjWzM7W2wtshKvbHikXn0UNJ+w=;
        b=BJHhlbA5vtrkDTAVoD5bNOLcch1GkRWSIsDJeFTUkRDxdH9YRAKm2dteibRuBFRir3
         GCW59V5L/lWv2fJAhsZ3gv+ZBjls0uHbfb/R2OyWAer+4WOlXUnf129xNZ6vvqyYZMhd
         dtksu09Wyc4qZFl5+OHiy0eGxS35QgG1Lc1dTnGxCoY7Fzs+YB+meRM70U2h+vZwUdJH
         EwLpMc3TRrOqv6inAaeMFvPn0CJEXqRM1slsxqtS4qiJcNP1b8VDea8m8J5sQ3hUrHw+
         /4YiJJ3bFF6XGTf9xNmG97EqKdcx/Z0A7dz9YmLUTjGeiJlSGsacg4mnpfGyKTUjzRdG
         C5bw==
X-Gm-Message-State: AC+VfDzVuDxHDlSxnpDh2pmE2umkl1A6LwF9UYP4z9/mF7gwc3fbMjbB
        461nvq5lJ88UMrSthg1Sd5x4cQ==
X-Google-Smtp-Source: ACHHUZ65QosLJ2p0+9l5Nwum/uDyPI90mQPSK+sfrYNDq2TI8JMX+RwDIAdHmNqeSqm9Bj5ej7UsfQ==
X-Received: by 2002:ac2:53a4:0:b0:4e9:59cd:416c with SMTP id j4-20020ac253a4000000b004e959cd416cmr707366lfh.0.1685451819362;
        Tue, 30 May 2023 06:03:39 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id a21-20020aa7d755000000b0050bc041d2a8sm4313379eds.15.2023.05.30.06.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 06:03:38 -0700 (PDT)
Message-ID: <a8a03623-3189-b17f-6ca1-43b7d10ba5dd@linaro.org>
Date:   Tue, 30 May 2023 15:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/4] dt-bindings: nvmem: qfprom: add compatible for few
 IPQ SoCs
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230526125305.19626-1-quic_kathirav@quicinc.com>
 <20230526125305.19626-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230526125305.19626-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 14:53, Kathiravan T wrote:
> Add the QFPROM compatible for IPQ5332, IPQ6018 and IPQ9574
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
> Changes in V2:
> 	- No changes

This is a friendly reminder during the review process.

It looks like you received a tag and forgot to add it.

If you do not know the process, here is a short explanation:
Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions. However, there's no need to repost patches *only* to add the
tags. The upstream maintainer will do that for acks received on the
version they apply.

https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submitting-patches.rst#L540

If a tag was not added on purpose, please state why and what changed.

Best regards,
Krzysztof


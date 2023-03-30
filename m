Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F64F6CFD5D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjC3Hva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjC3HvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:51:14 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294096195
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:51:11 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x17so23415474lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 00:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680162669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p5JIbgE4mWmLEPi3Y22j+UqX8dqtBXqktYNQxfeYmYo=;
        b=AoL2KiCDYrHyxJFF0E2edmitIJYmey+uQaTWcs8HIc8SoIKya8Molw5zfDIsaj1xDN
         /eghJFpFwiOUFGcfPzSUOCb5y8+6adUMPZKTg6qR4OZKZkdpZUIfMyarWuIrGg5uUOix
         Rvi8NJkalZU0BUmrVMG7XxfPzReYK/nZX3Y1Xn4Y1/GnHaUMxnmeUufoUMa43VmnansJ
         em0sYNNUemmmAYXajlkUkIckZL21fJNFzcxsR8rr903aSMCaewo9daCpCv14w1QweqZI
         365eXJoCPNgeZb3QOpQtHnDh//5GsmoO1iJXuUtrctYvTLkqmmPfUA56jNyAhAlkb5sI
         4erA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680162669;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p5JIbgE4mWmLEPi3Y22j+UqX8dqtBXqktYNQxfeYmYo=;
        b=1cje1hF6TmLr6JyiQfHB/EYPXcm38Dm5ie/J329Z8dTQHNdO0/L6TDYtCdCtsS0Tsg
         ziKeUC6Ojec1cSR9yeBp9YPoZs0KApbUbXJzWs0gQhXiV+EDXdWsykxcKE/NmVRGjGgz
         3HPBDH8ofZVQTljV9GSKkROHaWQJbpr0KlYXcdU+Au/lezNP6t26ZyshdtNvnHNdFLMj
         mEsuanJ+WfWcJtRjHRuuN0Nl1GdPTMucg4gW7xDt2R/fKW2/iikckY3C5DJeNbXAfAq5
         wsSMU2eJIbTtR/jYcC1iOg9UXW+yxOYsSGTBbxqdnd1lyWImWZBS0T8HsMy2psQtdqTc
         huLg==
X-Gm-Message-State: AAQBX9esgOv0WuVA2VUaALPR1hT73h3LisgshzM0AeGkvbGhIUM55C0I
        gAaBo7RiyflsJ/QhaIVDPikvgQ==
X-Google-Smtp-Source: AKy350ZGwBiegowDdHzkcTznbvKIEMX0rH2V2MxUwjDFRRAeA/N4NsmT8GOmCC3U8yRrE0hK8xQn7g==
X-Received: by 2002:a05:6512:249:b0:4db:38aa:a2f4 with SMTP id b9-20020a056512024900b004db38aaa2f4mr6685203lfo.14.1680162669380;
        Thu, 30 Mar 2023 00:51:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n22-20020a195516000000b004eafac09d8esm3169103lfe.240.2023.03.30.00.51.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 00:51:09 -0700 (PDT)
Message-ID: <9343a6d4-8cc4-2733-7e46-07f73bb0b4b4@linaro.org>
Date:   Thu, 30 Mar 2023 09:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 6/8] dt-bindings: arm: Add support for TPDM CMB MSR
 register
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
References: <20230329084744.5705-1-quic_jinlmao@quicinc.com>
 <20230329084744.5705-7-quic_jinlmao@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329084744.5705-7-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 10:47, Mao Jinlong wrote:
> Add property "qcom,cmb_msr_num" to support CMB MSR(mux select register)
> for TPDM. It specifies the number of CMB MSR registers supported by
> the TDPM.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


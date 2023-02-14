Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0224B695CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 09:25:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjBNIZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 03:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjBNIZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 03:25:09 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FCDBBA2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:25:06 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id z13so10407092wmp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 00:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m6YzbHeijVYRLJ+k+ysFkY3qZGUT24eM/SXq0u2hpl0=;
        b=zc3a2TNGE5lhWMT6/1egKMP6QQC2JoaLrNPh92Zha2FwXDhNacfwKU59fU8R2y4MB5
         9OdCjIWcp8QrBrI3BVPkpYGGXRs7zoiQdAXhyjG4gxcQx0SFTbQgDd1UVJyoJHONINW9
         21kKq89dLVQnfZAnvTIIGmESqyo0B0n1bf2FCz+fBumOznrCl6cEcWyLLXDlz0dSe9Fb
         /7HENpCmmQ1Co5WvRFl6lku18FYGRwMnGX31VyikC1YHLydfJI3yRjvR4SfrZ0QDr+8e
         GavwIr5tCzr5jJ07YU5JpMxoLkNO/nRPx9dGIwTKNNHZbTcVIYyqJehz9TZLdEIXaIMO
         Mfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m6YzbHeijVYRLJ+k+ysFkY3qZGUT24eM/SXq0u2hpl0=;
        b=nZ2FmA5OovYP040lKdCT0ROIlG53xkq6J2NzFeuOIOT7TY+W2WGPduvZ07WJ1Dgs1+
         9eFEvhMAHbAUYU0+tUC/fJsBSPaiJn5BUv3rtE3fp84Vu1sz6Uc0EsR+jHEvGwklvwU0
         OPK19rNQxY6xTi88qc5pNf+fwcJ+pfCkQ+G8NJtP/jXB3g1NUu8zP1qDX0W+CIPiswqC
         8DqidWNupqrq5TX3DAolSuhkRCryAxRfVFhGNpcecpvbVZw3A4wdXuczzbibuUYKKWg5
         d1RzGB7DtwBKGQonKMtMhpUgerqJGTwzZ1Cm5+mdEoXJha4qwoWmVCIzkRZT5fZUPgKs
         Te2Q==
X-Gm-Message-State: AO0yUKUlgymXwya2/m3w1oN0odiyoJv+djIM39sl382lR0SBcFbkkmRI
        o2suHfmd0EWBWqtiW9PEbx4LPQ==
X-Google-Smtp-Source: AK7set8ke1aM1nENCGqcij6HydhlyUcWM8+QrxYrQ+b6qRNZCSEisG5R7jEMFjOeoDhgNTaHgB7QAw==
X-Received: by 2002:a05:600c:4b17:b0:3df:eb5d:c583 with SMTP id i23-20020a05600c4b1700b003dfeb5dc583mr1389270wmp.17.1676363104749;
        Tue, 14 Feb 2023 00:25:04 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id hg8-20020a05600c538800b003e1202744f2sm13504837wmb.31.2023.02.14.00.25.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 00:25:04 -0800 (PST)
Message-ID: <86f5121c-d9de-250d-b845-fee70f28c1c6@linaro.org>
Date:   Tue, 14 Feb 2023 09:25:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/9] dt-bindings: soc: qcom: aoss: Document
 power-domain-cells for aoss
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20230213185218.166520-1-quic_molvera@quicinc.com>
 <20230213185218.166520-4-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213185218.166520-4-quic_molvera@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 19:52, Melody Olvera wrote:
> Document "#-power-domain-cells" field for aoss devices as required
> by power-controller bindings.

The power domain cells are for power domain providers. The reason to add
them is because it is a power domain provider. Power-controller bindings
do not require drivers which are not power controllers to become such...
and this driver is not power domain provider / power controller, is it?

> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 4 ++++
>  1 file changed, 4 insertions(+)


Best regards,
Krzysztof


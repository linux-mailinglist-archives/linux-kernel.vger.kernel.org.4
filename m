Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C3471677A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 17:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjE3Pqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 11:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjE3PqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 11:46:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11334FE
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:46:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9700219be87so847972266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 08:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685461563; x=1688053563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kco/qrPRR9qVEKmsCLmq5Or18nc2rDc7yj23Xb3BRM0=;
        b=KS4eWpJrga4I24WgKcteIRZc7/ac27QtPHgqXZY1fFBQMnC1kdqMxRufQHM2f1lP/a
         wypV4fpmnAQ/4tjQOeEt5gFAqZ72Jgqg8ESfcpORyCaRj7cz8YPbb6nxhISU2pc/PPbK
         Up8SbrXVh0l4xuop7U0LlaY7wxMy6fMB7Peu+Y/toUR6YKQCNxquiaCDTAGWcfFW5zA2
         l8H7mwnPM0quCzjoVxWxLvalXpVM+2FM/wqeQerycIkwryon0ATXGN3Cxr7mMyWGYVtg
         foEnCsoX3rTWEe7xK8te5mxvjBnZ9fXFdskXYHAybab3D1p3rJu9byUNqHqw9MXybjjZ
         VWxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685461563; x=1688053563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kco/qrPRR9qVEKmsCLmq5Or18nc2rDc7yj23Xb3BRM0=;
        b=hUQD/9FnB3X0Zs8oJ3ZZm3YKFpWf9PMzM/GNfHFfbBysDuLzppdZQ+5cPovn01jSZY
         AiHDm3IKK+MQeImsm/EE+oyx7iPwBogl4w04R+R0CIEIVYqssy2EPP4U+6vesP2gYSRi
         CLXkrJ3wtdRePIlDHOl0TWmC+/7HD+aaY+Dp2pBNirqXdHG9HyAbeC8936REubp9QVvo
         exrkCuyKDC2TxY4nRZfd1iZntd98t295Rf/tb8EdgEj9igakmtKeFfcxD1+e705qsVnD
         Qt6j6e8n8TLeUIwChc12iJ02vhywIIMAtCKqd9FsowwYIu0HGPF1o3lJJPtuvATpb4TC
         BG4g==
X-Gm-Message-State: AC+VfDzLpJpzTH0TSahi9hy5nJL2bOqjykYLXhx7iCmwh3clAMnStePr
        VuM99lgjlnq+0wHLtnh5ZgvgtQ==
X-Google-Smtp-Source: ACHHUZ5fY6UJmxTLzca82b3TLWQQcUdCkMtNJXjn/esHY4L/fJXaUR6aMvlFxTJZN251ZWNy90dEmg==
X-Received: by 2002:a17:907:3f1c:b0:970:d85:59e9 with SMTP id hq28-20020a1709073f1c00b009700d8559e9mr2833454ejc.5.1685461563584;
        Tue, 30 May 2023 08:46:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id rv3-20020a17090710c300b0096f7b7b6f11sm7462034ejb.106.2023.05.30.08.46.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 08:46:03 -0700 (PDT)
Message-ID: <4f99a4b7-990e-e802-0313-6437fa9693c9@linaro.org>
Date:   Tue, 30 May 2023 17:46:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 1/3] dt-bindings: clock: qcom: Add SM8550 graphics
 clock controller
Content-Language: en-US
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <quic_tdas@quicinc.com>,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Imran Shaik <quic_imrashai@quicinc.com>,
        Ajit Pandey <quic_ajipan@quicinc.com>
References: <20230524181800.28717-1-quic_jkona@quicinc.com>
 <20230524181800.28717-2-quic_jkona@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230524181800.28717-2-quic_jkona@quicinc.com>
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

On 24/05/2023 20:17, Jagadeesh Kona wrote:
> Add device tree bindings for the graphics clock controller on
> Qualcomm SM8550 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---
> Changes since V1:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


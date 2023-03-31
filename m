Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A75E6D2944
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjCaURb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbjCaUR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:17:28 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4572220A
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:17:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k37so30466543lfv.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680293845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCmSmcqOfsVfl2tCC9qQBF7W/rjcBMfD/MOmc9ZECng=;
        b=FEiZSZ2LMcZKJU2i8m5CNciGjOyJb4arZgojJLsdnH9X51Wu0xd9kykG7TVQeTWVt7
         EGdy0HMjLrf41HKCU5RkhArcpTo0OK/eIsYj0NSAXifw3hQ0JBi+IHUZF0TIGjEaJAUT
         REgb/Q4U4TV9zLTRSz6NiaZ7t5kmVlZAdyBrUHXB1dhGkRkdH0TLcRtvFgoQQy777BNT
         4CxdWjSMdSLdvAIWBDuRSlSKHIDXf0qRtRU0/JQFh2ySp2TJMbQw7KtTXVRP+kDh61si
         BZ+W1D8+PpuK+CQs+kL3EBN9ENntaT69bjpNmGSJe9ORVuSH8YKpdsCMi747ameemdZe
         r9tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680293845;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCmSmcqOfsVfl2tCC9qQBF7W/rjcBMfD/MOmc9ZECng=;
        b=t/pKCVUgc9nnGgIMmjhrkF7DVCEZktP54hWQdmV8vHg4QM1duD6roLbPkMjUStCVWH
         +TK4DD9xbXh/Xba/ubvhJDo0VNgOtdteFUeJO9qaqq9f3HU8LasIpXJCfS+mAN+5u5HN
         6I6ysFWJqOeEvsBzQcmdOKM72A5R4J1syZ0khs6vTHlFKzkTbOgbB/Ohdlb+QMx/1fbc
         AmkNhtQqAvZFp9+fQRZ7GWhVFVQz0LWkxjuvCihYlhoX+Nj9AQoNHqeR+2gsUAiaPj6P
         CXunWL+xwfUWmBuzXtmAY2c2jpqeZn178hAhnP7QEMm9sisZyZc6NuvZHdm456ImYNBj
         qmUw==
X-Gm-Message-State: AAQBX9cX2PzHIs20M2doxjzRZlu9oHYvj7IJ2tFtKOxC1qIPe1oVQ9JO
        qkqEjxYBazikwvasQzEnCIP4aw==
X-Google-Smtp-Source: AKy350ZW4tojQvCr/HnE4u4WkpM3V/on97zQF5/1LXrQhTmYXHS1Eyrs70NrN1cP9EiLT2GR3K7Mzg==
X-Received: by 2002:ac2:5b5b:0:b0:4da:ffa0:3f21 with SMTP id i27-20020ac25b5b000000b004daffa03f21mr3033440lfp.14.1680293844910;
        Fri, 31 Mar 2023 13:17:24 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l28-20020ac24a9c000000b004db508326c0sm506148lfp.90.2023.03.31.13.17.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:17:24 -0700 (PDT)
Message-ID: <fccbd0bb-8cd5-b286-c68e-32c094db3cb3@linaro.org>
Date:   Fri, 31 Mar 2023 22:17:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: remoteproc: typo fix
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
References: <20230331155527.3111125-1-arnaud.pouliquen@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331155527.3111125-1-arnaud.pouliquen@foss.st.com>
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

On 31/03/2023 17:55, Arnaud Pouliquen wrote:
> Fix "communnication" typo error.

Use subject prefixes matching the subsystem/device (which you can get
for example with `git log --oneline -- DIRECTORY_OR_FILE` on the
directory your patch is touching).

> 
> Fixes: aca8f94e5b69 ("dt-bindings: remoteproc: stm32-rproc: add new mailbox channel for detach")
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>

No line breaks between tags.

With missing device prefix and dropping line break:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


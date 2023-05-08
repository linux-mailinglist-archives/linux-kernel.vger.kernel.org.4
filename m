Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B438B6FA325
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbjEHJWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbjEHJWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:22:41 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091EB9ECF
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:22:40 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-50bc0117683so7843752a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683537758; x=1686129758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pVj4EgN1q+dbGHrGT8e/iARrKVM188GxyHNl2r+hzF8=;
        b=Md4vn+f9cQhbeUbsXRDQbSWhZ+fAiJW0B4OuApMysW4RU5h1yXDPY+YwtsEJHkMF5B
         jpeWNyokE82vle+iicdmMiVU2ptIK9VstuqNtjQe5PmkRMO5/AYflXifF5/MoNA1BVGU
         Q5t3SjqikXdE2BPD8BsZZZct8k8/trZQYlf4JmMH/pF8NihPRlrpq3MHs/vXWXnhI6u1
         wb/q3MtY3iz0OD/P1vzK9FQuaNxOKIsU5iOoSpGWzxCkW2zyC07qQTNXT2kmqkkeDbCS
         GXGCaYtSaxnLvlVUaoV72i/TsPGJsVaFta/2yKJrAQlmY7ibzpG/VxIpXrnx6rG+apJd
         eNrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683537758; x=1686129758;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pVj4EgN1q+dbGHrGT8e/iARrKVM188GxyHNl2r+hzF8=;
        b=k1j0TeEOMn39OKg6HfslnvXL9pV9CyurT0zjOZJQ94sXqK2BwYp+a7fTtwz6BbMhrT
         TQWwZmW25nppJtzd0rCPe7bP3oH1aKPeUK7gGBtDnm4qU+Panb3/mPHfUQf+QTC8lAF8
         x3HPAJufLQQ61nnGjB5rH1wgOWYK40ksPuIZ2wVmr8nq0iM6zG89aWXvik0lwL/U4bUX
         DukSV0FntrW02/T7J0zFgnp66I1UouRbfT+NQs/Ss2wc/0XtcfaxO65Ax+RnC4PKgQEp
         ALDWftAbtS4VjDZAxsdZS0SUCqti9lkPHPoG32QZZOsHZYqYyJhFRLQkCS7XkjbdSDs8
         5prQ==
X-Gm-Message-State: AC+VfDzF7LcXY6W7LZdH1zw+z6UKGJnzkwVlBBYz+PtMGdzVLSdOqNaM
        R88Gnz/bHhRejBhpcTQS/JnUew==
X-Google-Smtp-Source: ACHHUZ5VaDWHOixrG3ph+olohR2QPP8FUseVlklJZHozoAoTP51z+idUN0t9bFA6/QABvV1HMgfTUg==
X-Received: by 2002:a05:6402:181:b0:50b:d18c:620a with SMTP id r1-20020a056402018100b0050bd18c620amr7784668edv.25.1683537758551;
        Mon, 08 May 2023 02:22:38 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:50e0:ebdf:b755:b300? ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id x24-20020aa7d398000000b0050bca43ff55sm5836133edq.68.2023.05.08.02.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 02:22:37 -0700 (PDT)
Message-ID: <ef700424-5805-b44d-7256-4bfa932cf92d@linaro.org>
Date:   Mon, 8 May 2023 11:22:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH fixes] dt-bindings: PCI: fsl,imx6q: fix assigned-clocks
 warning
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230508071837.68552-1-krzysztof.kozlowski@linaro.org>
 <20230508-purely-radar-8fb16747ba60@wendy>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508-purely-radar-8fb16747ba60@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 10:23, Conor Dooley wrote:
> On Mon, May 08, 2023 at 09:18:37AM +0200, Krzysztof Kozlowski wrote:
>> @@ -49,6 +62,31 @@ required:
>>  allOf:
>>    - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
>>    - $ref: /schemas/pci/fsl,imx6q-pcie-common.yaml#
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          enum:
>> +            - fsl,imx8mq-pcie-ep
> 
> How come this is enum rather than const (and same for the other
> single-compatible ones below)?

I assume the list might grow, so enum will spare one indentation change.

Best regards,
Krzysztof


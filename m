Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2701A604B13
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbiJSPTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbiJSPTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:19:19 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 304AF273A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:13:11 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id g9so11532764qvo.12
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 08:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x7xM1tF26guvpMM6hquHSLkNF2RXOCRIuEvHgsryY5o=;
        b=xTM+cKmiRF3cX437gWbe4KODrpi6akAS7aPwwz5H7IFKceBFMQ8mW2hsA5GAiEi0XM
         FhTgT0unF02KtghoXN5sg1gcBFEGWAiTtVWt//XTZczCh/FdhLSszePXff0u1baoUf4u
         Db62cOD+rutcd68/yRSRhLQTpC7kFF63HIuIDIleamxAGorvozO6kcFyaQc3WWyMvhgT
         w688cgyv7kLi/Ga6x3GcByAU15qMP+1+j+TQYJQ2LIYDS/0D4U5bQcMPrkSS5MhurC0e
         81nt/9TCkO1dO+i1V/8Q65obpBibpegnoie88He7yP2IxLT2l/GGSFsJelpPRkenxZRW
         bnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x7xM1tF26guvpMM6hquHSLkNF2RXOCRIuEvHgsryY5o=;
        b=oKMI1a/tzBhqRQo0tzObv/FcCt5BHoNfa0E3K6RVhok7BeW+rTvkUB3xsJ2/l314tP
         mwnwhNhsju/3VmRT3PeVIUL6YDAzRzjk5lWB6sPYpK0OcDhaSwxQ/RBVtyq1Y2wJlHER
         000v8Euf4A1seb+C8IyIZ65ZVbSY2wkZ9NSppByHehiZVGj7TNPpIfwARg7aY47LfjBn
         wuXbmuzOCWMAfS7y2oIByW1aNkmAsvAt7gPMGSuqBQUu33n8x3asz9iAYvqST1DPr/eK
         9tkq952yynHQ2MD4gTI8FGVGwD5J8S/nTjgYuIafxE1k8GbTrstfaTB+XQIQ56hhYlvB
         WaGw==
X-Gm-Message-State: ACrzQf0zY1d37QzNq19RqsEKB0qIs8jBd9MPPNs7frR1X+wXPZGPVgL8
        97yd74Dr91A+TIEUBd5Aj/Izug==
X-Google-Smtp-Source: AMsMyM6O84IcO//MIOST6jaQC8XTW1ufb2EL3D74fnDXEBGAlwqxrAwt3pfMOtmMYNKcbW6NvzBxiQ==
X-Received: by 2002:a05:6214:f0c:b0:4b1:d497:732f with SMTP id gw12-20020a0562140f0c00b004b1d497732fmr7061751qvb.121.1666192286933;
        Wed, 19 Oct 2022 08:11:26 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id cd15-20020a05622a418f00b0035bafecff78sm4138131qtb.74.2022.10.19.08.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Oct 2022 08:11:26 -0700 (PDT)
Message-ID: <e077ae19-7271-19a4-e10f-1c7d26b0b304@linaro.org>
Date:   Wed, 19 Oct 2022 11:11:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 1/2] dt-bindings: PCI: xilinx-pcie: Convert to YAML
 schemas of Xilinx AXI PCIe Root Port Bridge
Content-Language: en-US
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     bhelgaas@google.com, michals@xilinx.com, robh+dt@kernel.org,
        bharat.kumar.gogada@amd.com
References: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221019144640.9458-1-thippeswamy.havalige@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/10/2022 10:46, Thippeswamy Havalige wrote:
> Convert to YAML dtschemas of Xilinx AXI PCIe Root Port Bridge
> dt binding.


> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - ranges
> +  - device_type

Drop all properties which are already required by referenced schemas.

> +  - interrupt-map
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +


Best regards,
Krzysztof


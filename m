Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A3D66B09E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 12:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjAOL1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 06:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjAOL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 06:27:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B1FF770
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:27:46 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id u19so61963261ejm.8
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jan 2023 03:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z7PMxCsJkAb5zQbRqwSXZpv3C+Wn4fU0jkcRwYX713M=;
        b=rIySFykUfWGYkFwiPEQBuQY1wcbV/spapzk7yC2TgMBXItfkAdcx3xt9QrzCimtYqP
         ab+UU/N2yr4kLb8AKlIXAnezibB/pmpY7LO5AP5/EIlNy0w2oBHX71BIPRc24YexWXJm
         hLJ+V1rUuu+OMPtEYGaNqzwfuSCcqg+kUd+hRYME2EB72LN244c63HqKWBfiHXEu2MuR
         FofzhNTxMc7zsddKuPJMwqPgqSX9nrwcbB/ZFHom9Y2sSlgRhcGo7apoXCuXbMDID3MN
         pJjPpwxtfFfTVI7TXLBorILiFMMY6Z2O8lut/gXiUSIVTVP7g222E9G2/4hTsj+URcla
         UCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7PMxCsJkAb5zQbRqwSXZpv3C+Wn4fU0jkcRwYX713M=;
        b=ghLS4vSKVu6AIsRQ2wzDGKA4xVHdreNVwOjA9I/x0qv9u8sLG4BzbbPNNfSnc7Rv0g
         eAAuUeRIdLhDgZDe+9aCzmxBzMVZGT3dYtBDdOy3tShWAWXOPO5o6Vhvy8Mrk44As6uV
         wFkHf4584MYzc587HyRFTNTCUAEd/AIZ6j26u8JMufbbWL0dxkqDX/BKR3TQNU98/AHm
         WenHaLfDqfOQEnl4q1W7W9C1ZnI1tMITVCxjTlT/1zbysCDW3nSG6zgqnR09+q07AxrR
         kN7QaWaqiWjuK2rtogzhxqCA15xdkit1C60s5Sltu4R4X3UMmzYVeDXjpAK1Nixaoaxa
         JefA==
X-Gm-Message-State: AFqh2kr01AgxQHOyUQCOCAkpvi2z4Llic/KgEY65C5vEH5RHdWaVXQ58
        bNynPd42dVAvAWNnnAcTF6D1hA==
X-Google-Smtp-Source: AMrXdXtFQYrU3vox5pa2TLu8mIB/4/EHzl+qM0gUfAC2BhQ6WOmoJrEabT2e49RH4k51j7LrglEA+A==
X-Received: by 2002:a17:906:7e0c:b0:86c:df3:4bbc with SMTP id e12-20020a1709067e0c00b0086c0df34bbcmr6363079ejr.4.1673782065346;
        Sun, 15 Jan 2023 03:27:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c23-20020a170906155700b0084c7f96d023sm10713809ejd.147.2023.01.15.03.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 03:27:44 -0800 (PST)
Message-ID: <48785391-2da5-08b3-6bc4-b485aacdf231@linaro.org>
Date:   Sun, 15 Jan 2023 12:27:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom,pcie-ep: correct
 qcom,perst-regs
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-pci@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
References: <20230113224749.GA1867364@bhelgaas>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230113224749.GA1867364@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/01/2023 23:47, Bjorn Helgaas wrote:
>   dt-bindings: PCI: qcom: add MSM8998 specific compatible
>   dt-bindings: PCI: qcom: Add sm8350 to bindings
> 
> I asked about splitting the first and if you did that, I missed it,
> and in the meantime I got distracted by my E820/EfiMemoryMappedIO
> regression.
> 
> In any event, I updated "next" with this.  Check my conflict
> resolution because I'm not a DT expert:
> 
> https://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/tree/Documentation/devicetree/bindings/pci/qcom,pcie.yaml?id=25cfdd48a4bd

Look good, thanks!

Best regards,
Krzysztof


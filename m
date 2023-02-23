Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 523B56A0501
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 10:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233626AbjBWJgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 04:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjBWJgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 04:36:37 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA6053ED9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:36:11 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h14so1461407wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 01:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8+c3O+JKb+ygyDEtjXcAkTDQCL5lhMHIdEFdwOPkUzM=;
        b=GJAvOM7vT6y+dpNnUBSXR8Ebltv2bQljUUOjeCVhH+BHrudJbK6t3LP+tnTTJyVur7
         S/W8Iuh4ID/TlBggamOu7aFWsNu2AMd3kK5xLMgYsbr9G/hGMCNh4kAF0htl8p4FtDpc
         kliFUM4kqlARQ+W5qLa649a6zqvToo665hF/E0ErCtfI1V1WSv4OnuuHaxvm/RvVF3BC
         o4gk8RuiYnYyTs4yd0Z8n1BOs2onAiZBqpj3LT1HBFN1vIQOZARwLGmGLToZajHrkgPQ
         B5Kl01grWp/Y1cWhljIkZMdMPpUuABL61kL/hYXukh5zJN6H7NQnzHQ20N8QpSykhAqT
         L5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+c3O+JKb+ygyDEtjXcAkTDQCL5lhMHIdEFdwOPkUzM=;
        b=OUZIw1NFPPA6zttJzrT7JhANp3owrhhBBCpM7kRVrPcZBszLmkYvinXW5psrApir7L
         ytCJ0OZ43gIgiKqwLHN/Xsay/sAhiSMw8S8le7I1/I9nGgWyPgzXFAxcD7vJkecMKP36
         UmD5DCnlnBGtIV6TC6/okdB82XQIlCp9ZAowTXi9dfGNt7n7+TIuagYW72IUlGstJUF3
         USbbyXdJpRgfU//s+0ce/vX55hGO+8rR3NkbOwp3XC2/CTMM3+zzwqPfPTkJIDMGWAEX
         QVGoKkJV3nXEkSsvaxmCvaZd1KTQOsVTaBhPUUnsizfbPU/eCux6EWRTIAXyXUeXa8tP
         63fQ==
X-Gm-Message-State: AO0yUKU+e3/rbAwClYXfgxJ0oKAM+f2NUW2E+1IRH4y+Fe5/jVB7LNrG
        mpNL+S8U6UcrDsxEcQucybWfWw==
X-Google-Smtp-Source: AK7set8QN3z8iyphsQHHkmevnZI5JlReWkBkgbZdtR+/J74U1LMkYhlHUOO2fryJAU1hiUfczkXfHA==
X-Received: by 2002:a5d:6a04:0:b0:2c3:db98:3e87 with SMTP id m4-20020a5d6a04000000b002c3db983e87mr11353074wru.20.1677144965983;
        Thu, 23 Feb 2023 01:36:05 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c500a00b003ea57808179sm1577581wmr.38.2023.02.23.01.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 01:36:05 -0800 (PST)
Message-ID: <4e2ea3e3-8a5d-0e9f-f16a-acedacc99b95@linaro.org>
Date:   Thu, 23 Feb 2023 10:36:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 01/11] dt-bindings: PCI: qcom: Update maintainers entry
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org
Cc:     konrad.dybcio@linaro.org, bhelgaas@google.com, kishon@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230222153251.254492-1-manivannan.sadhasivam@linaro.org>
 <20230222153251.254492-2-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230222153251.254492-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 16:32, Manivannan Sadhasivam wrote:
> Stan is no longer working with MMSOL and expressed his interest to not
> continue maintaining Qcom PCIe driver. Since I took over the driver
> maintainership, I'm stepping in to maintain the binding also.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


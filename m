Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E7B6FEF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbjEKJuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjEKJuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:50:03 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D2A1FFE
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:50:02 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-50b9ef67f35so14875631a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 02:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683798601; x=1686390601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZeuJxcLYHvnducoUZ2tfN6ldpdzeLGAaTYjya3TOvfo=;
        b=NFXGriYCOSUh+Lw7dIdqAPCMJ29f5l043OJhVsEeEP4U5lPIAu8F9ns0tM9PoNJs9e
         A5P4fNhWdJrw9ATAPy1aCfihrLmMBIwBp2vHqPJ9TpNE+fKFnqmI1BwDHged0cezzPEG
         wNdWRNr6Lz45V33NaZWsTqYIiL0afuSpLRdlRgo9szDyIEte41n2XgVbQXwoZjhEiQwA
         //EpOg9jzrD2r+dRHovI6H/I/xSj/3GEruXCtIxiBceaaXleRNCETiIy9C/j4+fjq235
         0AHhv7BLiuHiPB18sqgpErsRyVPPZ+zRakAJs27z17BzsfaMrJ2GrIPatVrRX2PGgXOd
         zwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683798601; x=1686390601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZeuJxcLYHvnducoUZ2tfN6ldpdzeLGAaTYjya3TOvfo=;
        b=VBeQLZ+Z5tRQz6Q8B2fTV+cT6hCthQbfP5LRh/h9Bl+zEuoIlhFx9r94EV3mK9bh9Q
         zSUkOBn+I92p3ewEnWLPf5oI5AEoDWjeNcKuSMj7HDzuPiQSblDH1UCrBD53w3RkZFeT
         XJUe4b4EeVNCsaelf32Lj+QA/7n0UK+UVr1xRBPDy5tL6N/64t78iUsU1a1YHMUIg6UD
         MAo5th68+mDv9nJwWupeEVAGFLD6wdJnmqgw0S942reIjcFUv+2b4QgYnduzWBStfEdM
         1dcrsKh22qrs2DbzkrldSOg0U2cQHkVQgm8J0WDzQGm0gnliRnP9UYVBMbFfPe2O8PVb
         kUNQ==
X-Gm-Message-State: AC+VfDytd/0XRhC4j8uVjE084bLQcNn0sxLpg06y23ETdWcR4sqHRuIZ
        HtMI7dXAWXBMmPjpB0kg0sex5w==
X-Google-Smtp-Source: ACHHUZ7Ea2uusu9jGNU3bGYWIa2nIX2TkmMJmfdXAah2FwXvUQkusDiywyoV8u4oAqkUEMD6Z3cmBw==
X-Received: by 2002:a17:907:9495:b0:96a:7a75:aa44 with SMTP id dm21-20020a170907949500b0096a7a75aa44mr364203ejc.4.1683798600971;
        Thu, 11 May 2023 02:50:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:7e61:f14a:c3a4:809e? ([2a02:810d:15c0:828:7e61:f14a:c3a4:809e])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709061f5300b009596e7e0dbasm3723120ejk.162.2023.05.11.02.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 May 2023 02:50:00 -0700 (PDT)
Message-ID: <9dc6c0d8-fb49-6242-3863-8040e43e52e1@linaro.org>
Date:   Thu, 11 May 2023 11:49:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 04/11] dt-bindings: interrupt-controller: Add RISC-V
 incoming MSI controller
Content-Language: en-US
To:     Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20230508142842.854564-1-apatel@ventanamicro.com>
 <20230508142842.854564-5-apatel@ventanamicro.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230508142842.854564-5-apatel@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/05/2023 16:28, Anup Patel wrote:
> We add DT bindings document for the RISC-V incoming MSI controller
> (IMSIC) defined by the RISC-V advanced interrupt architecture (AIA)
> specification.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> ---
>  .../interrupt-controller/riscv,imsics.yaml    | 172 ++++++++++++++++++
>  1 file changed, 172 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


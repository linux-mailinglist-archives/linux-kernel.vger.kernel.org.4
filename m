Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A46F705C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjEDRBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjEDRBv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:01:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB0C30C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:01:50 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso129318566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683219709; x=1685811709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AfsYi2ajE7KBB+3cu+gy9TJnH8eupsyTucE+Ap7OLfE=;
        b=MSCT7Z3CZOlyP5WXEUSAnCxuI1NG877g68kGf51CG5q8jxXg+ivoFrJ4frg5PE5m4G
         WzdxPVTK9oMR0gudg80O1YGwsAbG5b5LQvbrafooIFlF8ZB1fQnU0+iYUnHi9V6iZH38
         mDNE2Ub8BddqDDUDzNm84H9ivBfHpcWESTLbyiDbAIwU2ihrtNdwYJ1ecydV1PRhGl8z
         IETG/dydu01P16aijauq9IARk7efRUD0HkY0Tl+F3dVnXFPjDR1mwTP3sgkkUHski6qq
         23oqUq798pfJwYsjYcRqT4JK18ZZ8MZocD6C0poXMCdYYdHU5QjcLlhU5Hf0QPb7zNdF
         wZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683219709; x=1685811709;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AfsYi2ajE7KBB+3cu+gy9TJnH8eupsyTucE+Ap7OLfE=;
        b=U9H6dSbZqMeCn228k47dTJojFjNbsHyExgkVqTKppfIHkjJxh4sPAi9rvd5Iwg3gVr
         jOcOrWq6dyZd2AMS2T6F6Ezed1KDEu1ltZRc1qYN6dz5KSd9osthHbgsWK+//vqzi9G0
         d1/J0PfBVHLHXXXZZMqoyQNSJWyQsFlR5GFbfhabTQt4HDJYmNmfLuFBlsCV7MOFJmcF
         la3lgYh+736zQpOwzw1rcaRZ0zCq2QHG/M36fr7lQFpiLatUUucShAjETk8A3e0SP48j
         RnN/Tgp6g8tx+IiMZ6e0PXu1WTqNrUediU7qTNwacKcG9RxYwV/GfpsQof200GajGW99
         Py7A==
X-Gm-Message-State: AC+VfDwnUnWg76e8+OCws06JSnvPjA7hjCkBHFGHZfaUW5ZVrbotKQH3
        07tlc3u7HJ+lhyzSMPc5pX8vIw==
X-Google-Smtp-Source: ACHHUZ6YYh1nZpUG5otxrpWFVvmW85S+krxdrcrlKhVFZeG92EX7ruAI/eRnwOpJa5nj0EceB0neqQ==
X-Received: by 2002:a17:907:94cf:b0:965:bf30:9a21 with SMTP id dn15-20020a17090794cf00b00965bf309a21mr1617983ejc.7.1683219708620;
        Thu, 04 May 2023 10:01:48 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:bdb9:99c4:33a5:6114? ([2a02:810d:15c0:828:bdb9:99c4:33a5:6114])
        by smtp.gmail.com with ESMTPSA id li14-20020a170907198e00b009572db67bf2sm17220234ejc.89.2023.05.04.10.01.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:01:47 -0700 (PDT)
Message-ID: <417d7d9e-5d9a-e0cf-11b3-f191f4a9c9f2@linaro.org>
Date:   Thu, 4 May 2023 19:01:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v2] dt-bindings: spi: zynqmp-qspi: Add power-domains and
 iommus properties
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
References: <2afed7285061abbb5d9ad3b1e795b737dcff9693.1683102032.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2afed7285061abbb5d9ad3b1e795b737dcff9693.1683102032.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 10:20, Michal Simek wrote:
> ZynqMP QSPI IP core has own power domain and also iommu ID that's why
> describe optional power-domains and iommus properties.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


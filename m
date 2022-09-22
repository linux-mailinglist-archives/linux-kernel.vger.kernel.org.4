Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B2A5E62EF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 14:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiIVMzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 08:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbiIVMyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 08:54:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B32E9CC8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:54:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id z20so10898305ljq.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 05:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=6iOm3ykiEYCxC1y7MhUHMQ31n65A3mybmY95lFp43lM=;
        b=YMrrxM62da8qNRcPcsPM1f6j5pHpWSlnMRt/k9ArblV9TlykNySfRNF69BfT/CUnNS
         d1IgmIX8cBoGeK/KzeQKLk9snEUd//Z8IiuFzwStqnPErEbT6CVnJFSzxdZtZfr7a1wo
         ePKqfoJuLDVgA/ZdKIRApfAyd03xKvat/TKZDIeRdF9Lw65leabKONVnWVXEjKvleQ/I
         nzsPkPsQA427uSydpgtnwZz9JVyC3GUlHDuPIOTWvjvM+7EN7Ag3dwrNpDgwfVWonYqA
         GuhLJBaNq9DLDxKviqF9tAZ++Ad5NGIcGstVRhyOjY97y4VMRB7Mu0RBqSTLNiwVGcLX
         Nj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=6iOm3ykiEYCxC1y7MhUHMQ31n65A3mybmY95lFp43lM=;
        b=XUgQFtdJtjZi93giq31mhK5mjV0K/q+aYWL4KkIYd02Z0/o67P39ycMVUeq1F3wNcA
         2xgPsMt5ax41Gm7MhDL0C+Ee1XxLoKANoHNnbhFvqre6D0YdhHOMMn2LvPL4/aMIqSZB
         Zpf6zDXNVg/7lyMI690FrCYKpoIHBeNfpBYkF/B8Liemq+SPuAyX61NbWDXyax/MFMrG
         lHPbxp/2cnb8BfspwZPML6CAZWBqNnDIRCqKzgflmmOAdJdQyK+NCUKKYvH4AWsULEFJ
         QWKoZQY6VgJJhFsVurlQAwqIMjBy3l6uv3Yp4uYZmvP3MjR0gco7mdy84mb9tXMOrH+/
         8UZg==
X-Gm-Message-State: ACrzQf19/LWAFW2ml3hBrtWSXiZw1Fi+aarxIDFaXvgKBqD2Gq0gbHqS
        7CQKlZbqOZYFPNRYkkb6sed9ww==
X-Google-Smtp-Source: AMsMyM6o08fe7EJUEoL9IZbLm9HzdOug3LCgJEjROkmEOsMLYtujzse2VqJjxZ68Gea+MQekuYjXKQ==
X-Received: by 2002:a2e:8496:0:b0:26b:f230:a55d with SMTP id b22-20020a2e8496000000b0026bf230a55dmr985734ljh.466.1663851248171;
        Thu, 22 Sep 2022 05:54:08 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u17-20020a05651220d100b0049ad2619becsm929038lfr.131.2022.09.22.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 05:54:07 -0700 (PDT)
Message-ID: <3c0c6932-89fe-5962-d1c3-57ab6ef577df@linaro.org>
Date:   Thu, 22 Sep 2022 14:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: iommu: arm,smmu-v3: Relax order of interrupt
 names
Content-Language: en-US
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>, will@kernel.org,
        robin.murphy@arm.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220916133145.1910549-1-jean-philippe@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220916133145.1910549-1-jean-philippe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/09/2022 15:31, Jean-Philippe Brucker wrote:
> The QEMU devicetree uses a different order for SMMUv3 interrupt names,
> and there isn't a good reason for enforcing a specific order. Since all
> interrupt lines are optional, operating systems should not expect a
> fixed interrupt array layout; they should instead match each interrupt
> to its name individually. Besides, as a result of commit e4783856a2e8
> ("dt-bindings: iommu: arm,smmu-v3: make PRI IRQ optional"), "cmdq-sync"
> and "priq" are already permutable. Relax the interrupt-names array
> entirely by allowing any permutation, incidentally making the schema
> more readable.
> 
> Note that dt-validate won't allow duplicate names here so we don't need
> to specify maxItems or add additional checks, it's quite neat.

Nice explanation, much appriecated!

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


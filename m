Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98950695EEC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 10:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjBNJZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 04:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjBNJZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 04:25:01 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E36A62311A
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:24:58 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id o18so14941662wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 01:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8KakO0m99ack6WtkcRo8QC9fAx9EZec2nxXq+nRpV8=;
        b=XnkRv8qcJgXS8YBUYXFr3msPkyWSuAK7Xwx3teh9Q0AMx2x3w1TmzQ4QaN2BFQUsm2
         dAkbt2lgSE8azsW+GIYDqBUszigYr4JXpwL9t55zGb6hko0SNNNZ0CU591nyIEh3hrkX
         3sIMsRJkpU3r2i3rHqHbG4Ba9RLNQwldJxMnJ4zTPU5zV2FKlhLmnBdlOFyfBU0pZkRU
         jY+tqaUlCNUw5VjcJTmsD0Q23FEDvYpHCnCEyD6Dt3vKHMFJi5gyj1vxWFtHYC2wfCTA
         aaE3jNFLfHlnXZNOUbMo7pb+raS6UQBsEaAd91iI0L+vQCAayILyCKYkXNnfejlshzTz
         iN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u8KakO0m99ack6WtkcRo8QC9fAx9EZec2nxXq+nRpV8=;
        b=S8wG/Muhzij+QqUcd5ScEozdm6/+qdEntT9OM1FEOFVYHUoVyUD6yPp9VQ+DUVfG2W
         r944TVCeQzst9BjZ7LIuIny6Miw3GpeODkGDE08NtHOpHgiCFKAVtezFID4P4jnuDlw6
         u1RI87WCGOWcDElw1cxuZBJDZW+qfTtHkz9rvtNZfSfdLjU3Omgz+UPaG4PdHL3dMYhW
         R0Hz4E/Ilfymrw746wF5C171qsW2Ety6HHJ+BNuhNViJ1hTdgyJaiL8apHTqeGKpJ470
         io0Qgjw6kf69t/82OYwpVf7iEQ5bbRC3kgZNRGgCMhLQb5ZZUOJh6YLRZUh3XO77MNbi
         2JYw==
X-Gm-Message-State: AO0yUKWJxtoLUzNjzJ15FtzjY5BZVshV98+tpIrde1GIm7mJy9BMxwRr
        TIfOksMZEDhXoLG5RvUb7vRySg==
X-Google-Smtp-Source: AK7set/D6I/qxlSfxlRbpbzUy5a6qP8a6fLo8xCBJzYuz2JnEbfY9w2P98SqeCbjjCL59H93Va0T8w==
X-Received: by 2002:a5d:6352:0:b0:2c5:5308:859c with SMTP id b18-20020a5d6352000000b002c55308859cmr1628694wrw.18.1676366697533;
        Tue, 14 Feb 2023 01:24:57 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id y16-20020adff6d0000000b002c55521903bsm5679255wrp.51.2023.02.14.01.24.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 01:24:57 -0800 (PST)
Message-ID: <0a815e82-0c4b-cc94-7143-6fbbc2d62347@linaro.org>
Date:   Tue, 14 Feb 2023 10:24:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2] dt-bindings: PCI: qcom: Fix msm8998-specific
 compatible
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230214091202.2187321-1-konrad.dybcio@linaro.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230214091202.2187321-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 10:12, Konrad Dybcio wrote:
> In the commit mentioned in the fixes tag, everything went well except
> the fallback and the specific compatible got swapped and the 8998 DTSI
> began failing the dtbs check. Fix it.
> 
> Fixes: f86fe08ef00f ("dt-bindings: PCI: qcom: Add MSM8998 specific compatible")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

[bhelgaas: sort msm8996 before msm8998]
yes... I love amends by maintainers.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


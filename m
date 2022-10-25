Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E618160CDF0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232067AbiJYNvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiJYNvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:51:43 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54159E5EF2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:51:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id b25so8039939qkk.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hiXTBIxGK2t5txUBusQYuhQcGX4TmO1rhGy37Hdf2JA=;
        b=Sy75r9oaFQDWQ861B3wpDbhx48jsZ91GQwb1V9jtLdb0fJPBRF9sWKv/vUqoZRIRt/
         ZoTLEFflqwJGrqwjgdI3rQAALaUUqOU0Cmf8YNyCgrLdAoOr6iGAv22dol71RNj9y4MO
         C4YuV+0/1Z3xBU1pTrXP/hO+odmt2uyRsupbUWkTlnN7rCZ/kBQ5u9XmM7vYG9n3Ha/a
         BhOVqqOy3heRCb4cs/aW//nd4C3f4g2y/7+kZObxeSCmvB72s3P0oTHRvxd39Ojaf44C
         InKVAZ3F16xPJA9ICpDgeEukM74I4JiovMI6QB5upqcfS2TGZt6ZypXS/MTwkWSGQ1ta
         wO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hiXTBIxGK2t5txUBusQYuhQcGX4TmO1rhGy37Hdf2JA=;
        b=B60PkNRykVEtQWy87ih6Jk9Iqoya4jZsuvf2IFvdT6pR9r21wtvCbAaJLbSmM1GWhh
         e3+PIcLtHZRvY60FZSObyRODB0B7GbWk4quizh7bpGTa/9m2tY3YRR55YsG2O/Et+OAb
         6723uS2g1eLrEsCtqLAi2uYlYvcatICvgGdRis5G66MsDjXZKv/GLL/7gwDy2F29EEFi
         pqUWGezQMSZ618kkL5E8P2Wf7N9e653B7MraQtFj0VnthMd57y9yLw46blsxBCwFp3bL
         hZZEBEatjSMKD+RsL4Dnujxkk4k2p6l+/bRlNy56VKSLy4gQAqSYkQ46HWNclt2WJsnw
         cYMw==
X-Gm-Message-State: ACrzQf2r1Nm87T1hCQpZxtaFdkD4FDotV4GKR8DdG2jSobwKcicBaK6G
        mU7dx6i4PbD9PxmnxiJu/sbRlQ==
X-Google-Smtp-Source: AMsMyM7Es2ToCl7355XkI7mwGX8iRulCB/ilcwJ+dOH/F3DEcOMkvtbZTVso1pxl4RvSr/chaakG7A==
X-Received: by 2002:a05:620a:4245:b0:6d7:6d51:f66e with SMTP id w5-20020a05620a424500b006d76d51f66emr26370218qko.617.1666705899534;
        Tue, 25 Oct 2022 06:51:39 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id u7-20020ac80507000000b0039cc47752casm1609741qtg.77.2022.10.25.06.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 06:51:38 -0700 (PDT)
Message-ID: <0a9a8833-f664-d3b0-7194-069845512ea5@linaro.org>
Date:   Tue, 25 Oct 2022 09:51:37 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 2/6] dt-bindings: mmc: Add support for Mediatek MT7986
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sam Shih <Sam.Shih@mediatek.com>
References: <20221025132953.81286-1-linux@fw-web.de>
 <20221025132953.81286-3-linux@fw-web.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221025132953.81286-3-linux@fw-web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2022 09:29, Frank Wunderlich wrote:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This commit adds dt-binding documentation of mmc for Mediatek MT7986 SoC
> Platform.
> Add SoC specific section for defining clock configuration.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
> v3:


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


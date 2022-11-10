Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65758623E57
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiKJJMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiKJJMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:12:20 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A23712AEE
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:12:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id f37so1976881lfv.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ohHp1eb6I/UQdWWcqp55BKGGvWKwCgIcCW0FoTVSsZI=;
        b=I56bDON7JfWAKthaugOMMoQ2jimBBZr8i9c6Hu0ywMq5QJNELV60lCgabal3qMA/9k
         +cjfMffl9Ttv5Ha0dHf3v93QXPde1kXRGwWUGtLiC7BnKd/L84sF0+u00D2BaLzKdQDo
         AdrZzsxvN3yPmtwSKSnhhuCSw+4/nmjYGdKRmAFeotLWygDcHWhDlMlZjMHyN4zOeuyR
         by710N82UZhE5ySURJ84sH/XHdjV2X1kwdpPaWjwDnritU6d1KJ3TmhB2+zaaJDSgZc1
         lg+J45KctN2I5d3M/OgmnxAbaqu4ABNKwH1dNKD/GI1RQdeWcJM2mSwb56ewCGR1noCV
         sQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ohHp1eb6I/UQdWWcqp55BKGGvWKwCgIcCW0FoTVSsZI=;
        b=TH5udltDRiFQUpvxbawtCC/1COacXd6V8lvk+66uHL+zK0svIF+NJ4fFrQZDTWghIX
         QtEBn8B5bjI68z5QaH7bPBHGB08PuYmedAUJAR7fusuptc2hjjNQWhct2XSl6KjiZdAD
         Kn3nmU6oxfQRce8RtkTuaKcM4AC0TehdyW4IzB5kLxvcnU1bTSAFUFlHwHH5OerRtwI4
         Ssmluf2hMervPrZAEkhNTd5D/Z4Elo6paXEKtOHDtGSNrFKuS3Kln51LUqmz/IySDFPb
         93bVZri/9xfEk/C7v8OeE96N98PhLfOO+ZmkYS2zNxk2a9nOw2mRueLM8ewcQo2j8qB9
         8fTA==
X-Gm-Message-State: ACrzQf24ABZf3kCSadThlG49stUz14Q5iZchWsDomaLhMJeEtHCl/R0P
        nCPztTvNI4dEj7tpCHIdh16Hyw==
X-Google-Smtp-Source: AMsMyM7Y3V2v2/8mRxV5yR+nSEYp8DzIvDBrJBylIEh3eldYvYvEe0EA+GcwH9LW3shJJNeLRjE+zA==
X-Received: by 2002:a05:6512:10d0:b0:4b0:2675:110d with SMTP id k16-20020a05651210d000b004b02675110dmr1328387lfg.295.1668071533700;
        Thu, 10 Nov 2022 01:12:13 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24e8d000000b0048aa9d67483sm2644769lfr.160.2022.11.10.01.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 01:12:13 -0800 (PST)
Message-ID: <121da3f7-a39b-fda5-49ef-3a165ad6d4e0@linaro.org>
Date:   Thu, 10 Nov 2022 10:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v6 1/2] dt-bindings: edac: Add bindings for Xilinx ZynqMP
 OCM
Content-Language: en-US
To:     Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rric@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        saikrishna12468@gmail.com, git@amd.com,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
References: <20221102070655.247511-1-sai.krishna.potthuri@amd.com>
 <20221102070655.247511-2-sai.krishna.potthuri@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102070655.247511-2-sai.krishna.potthuri@amd.com>
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

On 02/11/2022 08:06, Sai Krishna Potthuri wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Add bindings for Xilinx ZynqMP OCM controller.
> 

Applied with fixes in subject - please use prefixes matching the
subsystem (memory-controllers) and do not put twice "bindings" (one is
enough).

Best regards,
Krzysztof


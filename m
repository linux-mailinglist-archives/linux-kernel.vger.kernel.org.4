Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E9C639681
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 15:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKZOc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 09:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiKZOc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 09:32:27 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD111B9EB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:32:26 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id z4so8180943ljq.6
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 06:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K4zuqMsuiqnvrDQp6f6xq5f0XqYJXIynO5h28fxOnsU=;
        b=gjZlOl29mWeOtWX9ThnwZStX+q18qMsbFd52esHJOQuXy1WSDEzTyQksdLwEz97HhG
         mEFLn9XXshTNvIMvF05LpWfGxa5MDXVOM/FM8U/sAPzj3mhh3SjRM8FLjFEPQ0Z8WU7F
         o2ssJ2Qb1nIUzbfFjXZHXRvnWyFykaNhmmD8XH/4OmUpjy/cE4k1vJO7nOgtCBkfESzD
         AGO4ZqoqrEdjm1EDtjqTFmTsSN7dFvm0lj4G1CbcfdPnOQMyoyk60sfCdXL5FhRjTVWo
         Px/T4Jas7DS2wntOp/xLqTrxycWknQkrHJnN6Uwl/FSyn0NXuwOPobU2wK/ZR6frp1UC
         v6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K4zuqMsuiqnvrDQp6f6xq5f0XqYJXIynO5h28fxOnsU=;
        b=7/nVVNFk6q5g7SG2GD/AVl1vZEKGKF+hEMZU7HauO/m3m8/ZInbifv+czV6w/A/NyS
         zuAZ/JxRF++hI+iaornwa5Drn8phn2Bbs6MpdohOGCcbLUhMH/VuWpHb4v9gfo+xxsY8
         jbsyiLCcouHyUqUT1bmgQxNo49sXPuXpjT8ja62XXrBnV8zDKKAxIF+El6lp17iPQ78b
         mSpbzFxjWpBj0/wfVThoOQ3r/ZNjnvqBeLSsoAQjK4GEmBq9uS0Owc10UVCFy8iWJOfw
         C8nbaVx8aayxpc3Pp7uzia3B4KQ5RiZSJvSuDsQCiMLfaGLByrer2grd3aoJgJORPANb
         jKhw==
X-Gm-Message-State: ANoB5pmJuC7sUCeO+14A+k99jyndxaL262CnfnuYTRnRVSLznNd3XKoq
        ORyzZNrkrTWqf2u/wg00ujUmBmcSQrjiqzK3
X-Google-Smtp-Source: AA0mqf4/4oZ0kQLRKfzZKB+9gta/ZRTDrQn+blmHHw+wrQgHzNnKaa+UH9SINf3JuV/LmjV0Q2uHAA==
X-Received: by 2002:a05:651c:b93:b0:279:69e6:bb1e with SMTP id bg19-20020a05651c0b9300b0027969e6bb1emr7269177ljb.335.1669473145151;
        Sat, 26 Nov 2022 06:32:25 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o1-20020a2ebd81000000b0026dced9840dsm637552ljq.61.2022.11.26.06.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Nov 2022 06:32:24 -0800 (PST)
Message-ID: <b3e80e53-16df-f6b5-bf1e-6f13ae93973e@linaro.org>
Date:   Sat, 26 Nov 2022 15:32:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH V2 1/6] dt-bindings: dmaengine: xilinx_dma:Add
 xlnx,axistream-connected property
Content-Language: en-US
To:     Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>,
        vkoul@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars@metafoo.de,
        adrianml@alumnos.upm.es
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@amd.com, radhey.shyam.pandey@amd.com,
        anirudha.sarangi@amd.com, harini.katakam@amd.com, git@amd.com
References: <20221124102745.2620370-1-sarath.babu.naidu.gaddam@amd.com>
 <20221124102745.2620370-2-sarath.babu.naidu.gaddam@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221124102745.2620370-2-sarath.babu.naidu.gaddam@amd.com>
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

On 24/11/2022 11:27, Sarath Babu Naidu Gaddam wrote:
> From: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> 
> Add an optional AXI DMA property 'xlnx,axistream-connected'. This
> can be specified to indicate that DMA is connected to a streaming IP
> in the hardware design and dma driver needs to do some additional
> handling i.e pass metadata and perform streaming IP specific
> configuration.
> 
> Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
> Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
> ---
> Changes in V2:
> 1) Moved xlnx,axistream-connected optional property to under AXI DMA.
> 2) Removed Acked-by: Rob Herring.
> ---

You already add two properties here. Convert to DT schema and then add.

Best regards,
Krzysztof


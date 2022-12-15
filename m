Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA8564D81D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 09:58:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiLOI6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 03:58:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiLOI6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 03:58:31 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 747C12DAA7
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:58:30 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 1so14643722lfz.4
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 00:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWdeRDSeYB3DzBxHS75d7a4c1oXHvEh623J0a+DwoFQ=;
        b=w5zNFWuw4gd9gdJ7FdYaOucaCP8gGImeCTeXbA6hFRZH6OoJ40t/pCO4M7VlG/1sqE
         OkKIQDrWWa5GxkzlrawvdPD/Tik4n9ODuX6i48/hArZ5K3YSeG9qPNHn+SvpOuDIM/cz
         Y/2mn4XiJIeU41rrEOCfWteOe1xbVdFa+PgSGrkAAKmiG4+wN9A8We3I7+LZjj539WiP
         9YpU9aMRXGYjGhQ1nJiYiP4cpK2AJJsDSGA5N0Qi5+qeeqyG9Q1Ccs9OdMuHTE8S+HJN
         uCpBW+KMHDGvcx64/YE+MJ5PupCon4HH/k5TKgmkU8c8Drh/rDBGZbqNBRKDwxtdxysP
         uVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWdeRDSeYB3DzBxHS75d7a4c1oXHvEh623J0a+DwoFQ=;
        b=M4HP/FUEQ4WA7/vXP31vf46Q/kuGt6GY0skB+JMbhO8MXihIkWuAZA0Di8TvV5va4D
         HzSuec15dX53u5vF913N82Pn77JCp7jjh5wEQc9w5l8ZjxQlqKR317v5TcQ1w6DIwlTe
         oNj133+2yhQ36/30+Ot+Nufs7BTyS8MoTsGvXXm3nZ8OmhoGw2MKznfQrkNRvUzDdfMF
         wR0m11QxQ4VGKc/ZBjNgwrT+WKl9bZR93KpCJmcHfvV+7efC2hpBTD2OB6PoQgNej7hd
         28IquRGrUuHZPDcd2wYVYyzh2/6KTPCn2Jc2c/XI6xChHQHLEPpFm5T81LLmmAbfO/lD
         DpGw==
X-Gm-Message-State: ANoB5pmfBSlbHo/aeu29EFBUAN1nOhZLVQnbjIAi1OgjeuOCw/uykeLA
        oK45pEooWi83LqFKPHh+qO8dMQ==
X-Google-Smtp-Source: AA0mqf5sup5h7VOVNlFqUdpxDsVaIkiJTuZWoo0xwOCFodsR5FjlJidzSFra/9u60kPjMJWBHmnYwQ==
X-Received: by 2002:a05:6512:3b8d:b0:4b5:b76e:3669 with SMTP id g13-20020a0565123b8d00b004b5b76e3669mr8227146lfv.27.1671094708867;
        Thu, 15 Dec 2022 00:58:28 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d4-20020ac25444000000b004b55f60c65asm1100252lfn.284.2022.12.15.00.58.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 00:58:28 -0800 (PST)
Message-ID: <505acb6e-24c4-45c7-7a54-1a77e3718fec@linaro.org>
Date:   Thu, 15 Dec 2022 09:58:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v8 3/7] dt-bindings: arm: nuvoton: Add bindings for NPCM
 GFXI
Content-Language: en-US
To:     Marvin Lin <milkfafa@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     openbmc@lists.ozlabs.org, avifishman70@gmail.com,
        tmaimon77@gmail.com, tali.perry1@gmail.com, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kwliu@nuvoton.com,
        kflin@nuvoton.com
References: <20221214092636.810883-1-milkfafa@gmail.com>
 <20221214092636.810883-4-milkfafa@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221214092636.810883-4-milkfafa@gmail.com>
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

On 14/12/2022 10:26, Marvin Lin wrote:
> Add dt-bindings document for Graphics Core Information (GFXI) node. It
> is used by NPCM video driver to retrieve Graphics core information.
> 
> Signed-off-by: Marvin Lin <milkfafa@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


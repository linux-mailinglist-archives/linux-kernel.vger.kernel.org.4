Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A4F694368
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:48:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjBMKsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjBMKrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:47:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDD818AAB
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:47:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k3so4046326wrv.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:47:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e/3Rg46LCIECXTmzltYeLCxx09WgeNrt+MNMZLrlGZs=;
        b=QkGvEARzZi10SgW85SKmLQmKqQ+qcLW6GuRTFW8BoP9HzXDvAOtxgAiwEe2qOAgJFm
         +CcxUgGM2Op+PUPbnvcleVwWUyQd8R94g6XZ4kI/p6nmtUbvH1emQe7Fa4BHNWzS3vz5
         0ughZebnyCurIDTuwcfVDiUbZOt92HRRG/MJPjOWN/BXPtouwwfmg6xUl1e95LJVhdgQ
         nffIbSHcA1pdRzAW+mzdIKuOnAcDKrHXV+hCRELjchKwhjVxLaeqAcJoIREH6YkJ8YB/
         +ugpwh9MxtAa/jEQ22tUqxmoOXLTqQSSXRv0c7GW8cJ9XG5/PkUJNlNAwSPL6I3lCAKY
         u6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e/3Rg46LCIECXTmzltYeLCxx09WgeNrt+MNMZLrlGZs=;
        b=ANuLBTSUhXAwl+oOwDed5oeTS+E5B2/xQLgXBKRReRGwyek5eSEsAlOQn57Wxs4e7Q
         GtDfjVt8J+j9CRVbxYTb/fT2l0cp9uIYOkwlNSGFV4hrZ+S7wh79z99yrnlWernYqL35
         UQ331ruddy7kB6uqvuLBdjNq8q1qytdoWnmzGxz+HBYLRlwhA42nNyaUP58bT0Nb4BV0
         Ef2vMSJ8pwRDOyJjn4H/c2ep/CeaG5bibWT+R0K/yzcfvwf4fXRYncPOTTjogcOHvLhZ
         WXfdsQjxvbjEbK+1Z2QXlkHEvE1NoCzcnMKKnzaOp9TzGODqAfaHaSHcHj8ujNyIGC2p
         Nxow==
X-Gm-Message-State: AO0yUKXD3xeuKmWkZuSdvv21+0zG8e/HQzNcyFTlRacojuGyWKWoBSUN
        fwW5d96yuRPy/qgwRlv218QA6g==
X-Google-Smtp-Source: AK7set8+ZM/gk0bgd963R9l41/fNKoVfugJ7Yjx+aAI34GotvjQNR7W2PgS/YAcS5882VaYHTHsT5A==
X-Received: by 2002:a5d:5c06:0:b0:2c5:483f:1580 with SMTP id cc6-20020a5d5c06000000b002c5483f1580mr8250292wrb.12.1676285232897;
        Mon, 13 Feb 2023 02:47:12 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l2-20020a5d6742000000b002c55cdb1de5sm1153145wrw.116.2023.02.13.02.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 02:47:12 -0800 (PST)
Message-ID: <d2af0b1d-7eb6-85f0-7e2d-3a1d3a3fc382@linaro.org>
Date:   Mon, 13 Feb 2023 11:47:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: sti: add STi platform syscon
Content-Language: en-US
To:     Alain Volmat <avolmat@me.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230212205107.8073-1-avolmat@me.com>
 <20230212205107.8073-2-avolmat@me.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230212205107.8073-2-avolmat@me.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 21:51, Alain Volmat wrote:
> Add DT schema of STi platform syscon

Full stop.

Subject: dt-bindings: soc: sti: ......

> 
> Signed-off-by: Alain Volmat <avolmat@me.com>
> ---
> v2: update wording of commit log
>     reorder compatible enum
>     update example within the binding file
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


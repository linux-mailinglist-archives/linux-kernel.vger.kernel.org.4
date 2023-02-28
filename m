Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D56A6A568F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjB1KZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjB1KZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:25:12 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3AF233EB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:25:08 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m14-20020a7bce0e000000b003e00c739ce4so5514927wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677579907;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mgkaj9z/KbMzs8cFTS/37vTg899N24Js9wfGA0s9PBw=;
        b=fbOYWLgxJVZKeVrkdDxiwN3NSM7QFygLSX/dttpu186Wu1twH0tSgDJ/rfLDtbF9p1
         D7ui2aZRycpif/n27U9IYZwXwlWj4R72afHqFgD+NytJmx5TQBwecsLlp6DMo737YaGx
         xC504xNaPupjm1mD+IWnnMoIMssQwkYIqKfuc3ETlmOteplyFn1cBYmPEuu3YAbF7NnT
         PnSvWDkmDogd++b2Nz6HF9URQiSvHY4HwjutnUbgkwmg5LNCbNKqyrLoiJzYQOSzOQoG
         jYcw7YvA6nGcOy2O8QSn8OgAoGmZiENw2gCR03xMnEF6APwjffVRQA5eOEERb0PGmZDs
         48Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677579907;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mgkaj9z/KbMzs8cFTS/37vTg899N24Js9wfGA0s9PBw=;
        b=2C0+Is4fzA7T9tJMkF37kYk8ANduIo8/YwXIIYGZQ/Tp/DiIoMnQ+cnJRKasl/CZOb
         Znwo+RxKzXbGzi8A1fNVbxnn/12XQ5R29pM2LB8QZ14jQEboITHH4C8FLenstJvAMaXr
         VvjZNww6uSw0Jan6Z9WjmuIu26BhkwKRfsLyepdKV0rtCeND8C5UniqX7bT8/tpVOu+w
         g2xNHfRHTcMqOPtF2zHjT9bTFJhqOmLiIBzxV73VwlA0idwXle+2mic8w4Cjb5FROSLc
         jX9hnj9GXfWRB1tl1iXZyjmtRWfVxPB/eibqeunTcEWhj+gXwpzHmv0iUPdKyIvwQisV
         sOmg==
X-Gm-Message-State: AO0yUKUZYWiJ51mTktEyzqPty3JfcSkpUzYFQFMt7nLvpES+cpn1TEuE
        b99wiAnJaAdOm25j0YfmGbIyCg==
X-Google-Smtp-Source: AK7set9kSTpOpMfs+oiPL+tox1XHjnaZltE/NY/+ULnAV7QTX1WOcx8ydIKjlBe9PD0f9u+K57nx1Q==
X-Received: by 2002:a05:600c:4b30:b0:3e0:1a9:b1d7 with SMTP id i48-20020a05600c4b3000b003e001a9b1d7mr1685992wmp.19.1677579907307;
        Tue, 28 Feb 2023 02:25:07 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f5-20020a1c6a05000000b003d9aa76dc6asm15426295wmc.0.2023.02.28.02.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 02:25:07 -0800 (PST)
Message-ID: <08d1e666-cb28-a296-8647-b5e2f9c81276@linaro.org>
Date:   Tue, 28 Feb 2023 11:25:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] dt-bindings: fpga: xilinx-spi: convert bindings to
 json-schema
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230227110213.291225-1-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230227110213.291225-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2023 12:02, Nava kishore Manne wrote:
> Convert xilinx-spi bindings to DT schema format using json-schema.
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Removed 'fpga-region.txt' relevant info from the description
>                 and addressed some minor comments as suggested by Krzysztof.
> 
>  .../bindings/fpga/xilinx-slave-serial.txt     | 51 ------------
>  .../bindings/fpga/xlnx,fpga-slave-serial.yaml | 80 +++++++++++++++++++
>  2 files changed, 80 insertions(+), 51 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


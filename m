Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82514620DF4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbiKHK7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233591AbiKHK7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:59:12 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17DD450AD
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 02:59:11 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id r12so20719627lfp.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 02:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gKq0Z1l8oyk0eTyU/o64FPBYWBNjgIJP6U1m6VFKy38=;
        b=jq15JLHcMwjPo4ZAVev6hyodHFze50Y4xkNNcEBd3N5bTa5gPvN3mV2VtvW5wu6ow2
         A8mYz+ncNNJPaeD8cjsxQ0on0uzB7GZNwbzPGec0nSf9nwHtpfrVRRP4u0rF8bmJ79ZT
         vV2R/dk6RqbMfiY2mXFfkSt1XD/C7yLwAVFDWdsCDje0sYSjkh+QNA+S1uPn4H/vhq+/
         3GMNVA/4fSCXVmmdZzIVn7K5uRRi6BWuVWamfeexUaMBYGz3hCFUtvN357DOABEiXHdF
         xF6p280cnlJRpgCWwwesbDSenCdz4xURwFz2ShhVS5eQ8EjTskEGfhHwgk+1mE9SwEAe
         5Kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gKq0Z1l8oyk0eTyU/o64FPBYWBNjgIJP6U1m6VFKy38=;
        b=Ao4wNoSVy2HJM2vRpiJOlbpNZq51h/X+5qfu4l7EY/XG7o9RuPTKy9lZmLHI8Lo7NU
         ah7TsGCg0cL3KYPASB3zg56dnjpXY0Z0Z+8JNiGTYI1Y0uAKZvh7s9XeMGohE7C9k0FF
         HhaBGcyxKZys1lSicNWOZ47lap1ON/LetvNlp64gFAVR/2LMVV1dRfPVSJWWw5cTfe2g
         /ZlB0zVQXwemZ0G9O5QSy8nnZM+F0V8jrGWi4/vQS9n4es1CL//0y90IydyVoWKz4sxE
         fWhIQwhu3NxsGFghBlViwDE0fN9LGb5LWbdC7mZ1xu0hTn5CkVZD0v3YAZ5CU1sV2SuM
         kEhA==
X-Gm-Message-State: ACrzQf15g41bDCcxmbO4zmWc68icVqQNBCHdVkPokOsQ5qaqpG6rWDW3
        B4Upv35wcn9r1xuQNyq3+c1sSg==
X-Google-Smtp-Source: AMsMyM6/CWgviva8Ua5H2rBPqp+shUg1VToT4XYT2Nz9j6W2D+ROm/o9KyJhfyTcFBWltkiLfbmkbA==
X-Received: by 2002:ac2:4c8e:0:b0:4a2:4745:a63d with SMTP id d14-20020ac24c8e000000b004a24745a63dmr18436290lfl.605.1667905150054;
        Tue, 08 Nov 2022 02:59:10 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id t1-20020a2e9d01000000b0026fa9e19197sm1688928lji.36.2022.11.08.02.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 02:59:09 -0800 (PST)
Message-ID: <241dfd95-8572-626a-fa9a-339c67641fd7@linaro.org>
Date:   Tue, 8 Nov 2022 11:59:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 2/3] dt-bindings: watchdog: fsl-imx: document suspend
 in wait mode
Content-Language: en-US
To:     Andrej Picej <andrej.picej@norik.com>,
        linux-watchdog@vger.kernel.org
Cc:     wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, Anson.Huang@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20221104070358.426657-1-andrej.picej@norik.com>
 <20221104070358.426657-3-andrej.picej@norik.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221104070358.426657-3-andrej.picej@norik.com>
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

On 04/11/2022 08:03, Andrej Picej wrote:
> Property "fsl,suspend-in-wait" suspends watchdog in "WAIT" mode which
> corresponds to Linux's Suspend-to-Idle S0 mode. If this property is not
> set and the device is put into Suspend-to-Idle mode, the watchdog
> triggers a reset after 128 seconds.
> 
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


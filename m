Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408B86A1B5A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjBXLWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjBXLWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:22:33 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 989B563DE2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:22:31 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id bt28so6893807wrb.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 03:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tGfBN8IEC+qlIc6jdLkyzSmAC7UCyGCFtdcOqQyVOrQ=;
        b=Hkh/qnF6A9pPW2TadDONBTbQf9DzjMsN316XQA6esIb9TPIqC9nm3BqU9oJ08sXWtj
         Hw2HM6U1e5fyJzzy8Dmi2SGPi9LWQLKMlxzEAJD6H2FpWt1mpaRx6k/c75jSz6FGJI6P
         f4FF/0wb3O9ZfflVgcVHxTzknLCypYHQvJPcCQhCSIDXEZmihdML/k296mawpjmngs5e
         4ILFQcUzGbHCTPTcgAph5q93prYpb5ltsx15nxBDHRR7cqNMnGiMwEJUV3EExnZ4lLya
         vBSmi28unYosHNjlxXq3lCdFfND61ZLWgKNPQ9d7OQA88IDw7TQmXbW0+Jcqe0P9VQl8
         pRmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tGfBN8IEC+qlIc6jdLkyzSmAC7UCyGCFtdcOqQyVOrQ=;
        b=2R8XdF7DKBRoDjwDqA0mul7b6yoJnKpdiBVNBbQGmrNpDh8NBw4ap/AJX5Hd6dZnCl
         XfAUL+xxfOzSkhtEhsGYFSci3SlwQ6w4YZD7LrkWtLX1zcdwOt8xXL2oN64KbvvPUFte
         O14tL5rrErGlhlaPdG+w0MmDOi5e5fbDsuM3pn1/5tc5/e68XPZafqOlQx+oCYkxQHFa
         1JVQ0pvO18QSRgQHD7XBz56cBMZkmwKWN2F3NorVtD/OLaQ8yDXYLOxDmWzTq870lbuE
         8NthWiM6NAjbaeDtIn+2Cr9CF6oM004dWwgrsVSROYn3E4fk35zo7E9yWIZP72bJOT32
         zi4w==
X-Gm-Message-State: AO0yUKW0pg93I04I7RbNl3j50iPHrpeA8+Ni4uL51Xyf+jiCEnv2gDWa
        YOqDB86licZCMgxYcU0KB3dG8Q==
X-Google-Smtp-Source: AK7set+ci4988jeWDzm40Oj0p0cIoUr1kM+gaFBJ0XOXlbOKhkAP28EYzk+rLB39CGk9Yl/o0t/hiA==
X-Received: by 2002:a5d:5651:0:b0:2c3:f78f:518f with SMTP id j17-20020a5d5651000000b002c3f78f518fmr13108445wrw.39.1677237750097;
        Fri, 24 Feb 2023 03:22:30 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id z14-20020a05600c220e00b003e11f280b8bsm2427156wml.44.2023.02.24.03.22.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 03:22:29 -0800 (PST)
Message-ID: <86ececf1-72f3-41b8-ae48-092d169b690a@linaro.org>
Date:   Fri, 24 Feb 2023 12:22:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3] dt-bindings: fpga: xilinx-pr-decoupler: convert
 bindings to json-schema
Content-Language: en-US
To:     Nava kishore Manne <nava.kishore.manne@amd.com>, mdf@kernel.org,
        hao.wu@intel.com, yilun.xu@intel.com, trix@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@xilinx.com, linux-fpga@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230224111825.161593-1-nava.kishore.manne@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230224111825.161593-1-nava.kishore.manne@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 12:18, Nava kishore Manne wrote:
> Convert xilinx-pr-decoupler bindings to DT schema format using json-schema
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v3:
>               - Removed 'bridge-enable' property and addressed some minor
>                 comments as suggested by Krzysztof.
> 
> Changes for v2:
>               - Updated the description and addressed some minor comments
>                 as suggested by Krzysztof.
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


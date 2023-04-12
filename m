Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E196DED7D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDLIVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDLIVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:21:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506765AB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:21:21 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id kt17so14549141ejb.11
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681287680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUO++GBBoZIwNOjnNCFjzZBL93b05/ZV0KX55fLaOwU=;
        b=ermxDx5yXw3LJg8LQ8y2VaBrAXai3Mv+rhv8GcQn3FHDDqqQowqbBAoeC5yZDFfR+w
         XwTQzHDu0O0A4613YnmWvj8BIy4fHL4xrfax2BpHR9nTxxPY/jytPjb9Lkz8PqkBfmIm
         8VBNl1sIGXD4ZaG9ztqGv+pfB7IYo5yVRPi67YZsysR/AxCmCIVssdR90eIedq4CRdvg
         sfV7BKKAZrXcwI6AkqTH/IUWm9Od9NyCszcED2Ken8jJDSCzorU/uYvgGSrsNB1GNb9I
         3keRCkUtEG1PgtAPyTVaxfgrXniQFBlS4zIZrjPi4AgJHEClRPsSys3MIQqVyyPcOEUL
         kr/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681287680;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUO++GBBoZIwNOjnNCFjzZBL93b05/ZV0KX55fLaOwU=;
        b=wlzGC/peOWnrhgkKoZ1EBWi8twO23uxamxs4Ldp2ABRkpy0itVjp8wrDgeGFbvuG0t
         zOAXOn0sw1m6z7ghfFaJRWv40zAzrC5X2cueNM0KdDaYgWDMqoHi8iX620gHS0bD0tc9
         V3pDQOLrfVj5mlzp49PsNcJipjvP+LVSEjxNajYWn0tYZklS2RD5GLCXFRYqGDWLTsl8
         MQmcI03uow+jaUcEG8GQ6tDxWeAci4OhG11zPV186enBNzphJEO+S7vCpZHiAF/u/Fmo
         6H/nUZOYiVo/MsYxSXH1WsfPtuB3MKES8u/148YtF37mq3wo9z2A5bpdSbV+PNnCjaZB
         fBPg==
X-Gm-Message-State: AAQBX9etiSVbJF0NhAm4Xk61sXaTU1L4Ll+81IRDONRk/2s7SSF5JB8H
        HJUwXYXx3fyURXy8mX+hoF7yKg==
X-Google-Smtp-Source: AKy350YgD9pPWbZwe31IUoR7ZwLqJFu4tppJMfLi/4jG5W6CI1Yx5BtjvxaAME8sdzTWSeH+UZ9oqA==
X-Received: by 2002:a17:907:1ca3:b0:92e:eecf:b742 with SMTP id nb35-20020a1709071ca300b0092eeecfb742mr16457515ejc.2.1681287680177;
        Wed, 12 Apr 2023 01:21:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id sb2-20020a1709076d8200b0094a785e362dsm3305279ejc.141.2023.04.12.01.21.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:21:19 -0700 (PDT)
Message-ID: <d05e1184-ead4-3f80-4c06-ff757a10ba3b@linaro.org>
Date:   Wed, 12 Apr 2023 10:21:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 2/3] soc: qcom: boot_stat: Add Driver Support for Boot
 Stats
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <5eeeb46e9b3f61656a37cb77c2ad6a04e383c16d.1680874520.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <5eeeb46e9b3f61656a37cb77c2ad6a04e383c16d.1680874520.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 16:04, Souradeep Chowdhury wrote:
> All of Qualcomm's proprietary Android boot-loaders capture boot time
> stats, like the time when the bootloader started execution and at what
> point the bootloader handed over control to the kernel etc. in the IMEM
> region. This information is captured in a specific format by this driver
> by mapping a structure to the IMEM memory region and then accessing the
> members of the structure to print the information. This information is
> useful in verifying if the existing boot KPIs have regressed or not.
> A sample log in SM8450(waipio) device is as follows:-
> 


> +
> +static int boot_stats_probe(struct platform_device *pdev)
> +{
> +	struct device_node *np_mpm2;
> +	struct device *boot_stat = &pdev->dev;
> +
> +	boot_stats = of_iomap(boot_stat->of_node->child, 0);
> +	if (!boot_stats)
> +		return dev_err_probe(&pdev->dev, -ENOMEM,
> +					"failed to map imem region\n");
> +
> +	np_mpm2 = of_find_compatible_node(NULL, NULL,
> +					  "qcom,mpm2-sleep-counter");

This is undocumented and non-existing compatible. No, we cannot take this.

Also, referencing other nodes should be with phandles, not compatibles.


Best regards,
Krzysztof


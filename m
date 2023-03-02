Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D463A6A7BF0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 08:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjCBHim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 02:38:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjCBHij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 02:38:39 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC78C5273
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 23:38:37 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id ec43so63938565edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Mar 2023 23:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677742716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rXBpuovAno/5WCGDBV+AisE7CduBEJt/pA7c+lDgz+U=;
        b=CtKIX0svb8mSkZgFLyFr9jWV5y+5hXYP7lDRB7ItN9JP+1Y2FepFoLwhA1GetDiSKW
         1ucgVAHyAUIqfv/yzvVsAf7sMF82M5fJaQIZZYmfTvxyozPPVhqQZLlX8fl4vA4W0aIi
         5cj2rJU4LVe7WMFMZBAUWC5xa80DX4GpniOrXlj/y+8lu5U2LlOY48rvOcjZQM3+PnyI
         a7J75lhYwwhYMyiKf6SfDHaKuuAgB/S3T0Jfm8sFU+p6gBbLuyyhE3Z32dmo4ZgWqK33
         8B5fmQDVDhYWaQ+IbpwQCfvir3buV9XbMTbXfAgQdSZwu7Fh6/ySm7XXzU7pRGR2/fRM
         h8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677742716;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXBpuovAno/5WCGDBV+AisE7CduBEJt/pA7c+lDgz+U=;
        b=hGqkUe2j/81Q1/2nqMJC+SSH41B5WJQw2ARliAdGQ3S9DUrv72mbUFUG+7GXx66PCn
         MmJU6EF0OKkVZexd61IKds60wrfWsA0yTt50SZx578+0R1kqB5FUWUjiprCpXtAEGVBv
         btBfzAdWN1qtoCpWreHRK19JhDqx8SuKk4fXSqIjyzxe9WMv4mHbejzyPK7YPwMYbewU
         yxB7vTikWUNw3Mks1Hg0td0rimURuol3TGhewn9qy36f4OwWnjBpJ+LhHgGMEyfFawaO
         CJrRGnC1INR6qLDmhk2cmz6qZCT8EqzJVN6M2bSwtH3v2tyOVK61eQ4LOTmgoavZFiPd
         LxLQ==
X-Gm-Message-State: AO0yUKUGYD2G3ET9qgzl/mf61S2CvtmuWuJ2U2NUqfvoG564FAYRI+36
        rPlZnBM6zbhcM2dRqu9bAKpVGQ==
X-Google-Smtp-Source: AK7set+XPLhKndG5E75elshInMBO12jf2Y0kWOxB2hX9mc2dJBDx5XFbqaU8SlL3kW9dxo76L4ZYMA==
X-Received: by 2002:a17:907:7e91:b0:907:89d1:1ba9 with SMTP id qb17-20020a1709077e9100b0090789d11ba9mr2367300ejc.51.1677742716300;
        Wed, 01 Mar 2023 23:38:36 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m29-20020a50931d000000b004c0459c20f9sm334103eda.66.2023.03.01.23.38.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Mar 2023 23:38:35 -0800 (PST)
Message-ID: <99fbc30c-7239-f63b-c76d-0b55a377eea7@linaro.org>
Date:   Thu, 2 Mar 2023 08:38:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add
 versal watchdog bindings
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        michal.simek@amd.com, neelisrinivas18@gmail.com
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        git@xilinx.com, git@amd.com, devicetree@vger.kernel.org
References: <20230301175229.342004-1-srinivas.neeli@amd.com>
 <20230301175229.342004-3-srinivas.neeli@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301175229.342004-3-srinivas.neeli@amd.com>
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

On 01/03/2023 18:52, Srinivas Neeli wrote:
> Versal watchdog driver uses window watchdog mode. Window watchdog
> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and
> a period that is not too late.
> 
> Updated devicetree bindings for adding versal window watchdog device.
> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V2:
> - Added watchdog ref
> - Removed timeout-sec property
> - Used 4 spaces for example indentation.
> ---
>  .../bindings/watchdog/xlnx,versal-wwdt.yaml   | 58 +++++++++++++++++++
>  1 file changed, 58 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> new file mode 100644
> index 000000000000..733de1ac60e8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/xlnx,versal-wwdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xilinx Versal window watchdog timer controller
> +
> +maintainers:
> +  - Neeli Srinivas <srinivas.neeli@amd.com>
> +
> +description:
> +  Versal watchdog driver uses window watchdog mode. Window watchdog
> +  timer(WWDT) contains closed(first) and open(second) window with
> +  32 bit width. Write to the watchdog timer within predefined window
> +  periods of time. This means a period that is not too soon and a
> +  period that is not too late. The WWDT has to be restarted within
> +  the open window time. If software tries to restart WWDT outside of
> +  the open window time period, it generates a reset.
> +
> +allOf:
> +  - $ref: /schemas/watchdog/watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - xlnx,versal-wwdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  xlnx,close_percent:
> +    $ref: "/schemas/types.yaml#/definitions/uint32"
> +    minimum: 1
> +    maximum: 99
> +    default: 50
> +    description: closed window percentage

There was no such property before and your changelog does not explain
it. Don't add new stuff silently in new versions.

There are several issues with this - missing dscription (you just copied
name of property!), unneeded quotes, using underscore, incorrect name
suffix... but what's the most important - what is the justification to
put it into DT? IOW, why this is suitable for DT?


Best regards,
Krzysztof


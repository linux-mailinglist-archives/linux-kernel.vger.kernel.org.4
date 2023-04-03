Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6C66D50A6
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 20:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjDCSdx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 14:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbjDCSdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 14:33:36 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C81130FB
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 11:32:59 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ek18so121089625edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 11:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680546778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EPWT5mMmuGrFkQaGaj75abt7BvFmjgz0kWUiVZiK+60=;
        b=F2GsOoTdBB99ORU2xWrBAyXtTxEW63x/qTkd9bnEjUalG0IkTiwxfDqA6EYadBh8pP
         vwyMm+hX6ih0XzUM4XtCwk4+vZUdjXdYE6bJHph8vK6cQO6iDgBm3PUIaisbCAOOkA86
         l9WaVyERMvWNz1GmqPxdgqdIF4tfvEkw62UeH0Iwv8od2RImp00TZREbGnqrbtlqXpxe
         IhAOAcTAXtQR3WvPXGOClOo90KVfGODQjFXF7uN003AI2qKMYiRYtgoR9a9ckkyVPEfn
         nO8LUwxUVeBT36nvPtpcRJ9C3SHnHGlkFMul6ogJoooxMiABfRUaLaEUnfj4QF9fp8d3
         L48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680546778;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPWT5mMmuGrFkQaGaj75abt7BvFmjgz0kWUiVZiK+60=;
        b=IQENOA0zu0Wa6m1oRD6Eh7e4IZRUw6BcPDk4CVgmwMR6Yx0/jeDodLLYLtOGRu9ug+
         /3+yxS1rWQyZa7Xhk+kNu29ZCNAzoUTJewczDc3Q7oDqP2UbKn1B0QWoScdMGG3PIJ+K
         Pw5KKtBztaqJq5rr60wV9qtzGPayx4lMjLcQzgRhegv6wQPvIJ7YQDgyDCeprQmBvFmn
         Lq77n4jBOGhkoVonLjtOS3LT2VLPY1kECZL9+5/qD/kph4x3r7eKVDRQn4poL6uU7Zn9
         fAcAgLOmImZ1KrvSsroPGk9qau+s2f4ghI2AHP65mRYuA03sRs+BXLS4XGtXBQ7Qzx+S
         Lorw==
X-Gm-Message-State: AAQBX9dY3S4rUEVkgo2uHFu3wdX6FbtGQWE/AsYZ9sQBz6av2tv9r0bb
        iO7E/NvAjHpLHpUs5WPkufGW3A==
X-Google-Smtp-Source: AKy350aW2SN3jstLLNu7d+H5mzsNCZIqfayZUeK8PGvt9ZdUMKzysVtsFyu0PycM5P2N+wDccL5QXA==
X-Received: by 2002:aa7:c699:0:b0:4fb:80cf:89e6 with SMTP id n25-20020aa7c699000000b004fb80cf89e6mr172550edq.8.1680546777852;
        Mon, 03 Apr 2023 11:32:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id p9-20020a50cd89000000b004c0c5864cc5sm4915461edi.25.2023.04.03.11.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 11:32:57 -0700 (PDT)
Message-ID: <23a7215e-0be4-195c-f3c9-3b1d1b760fa0@linaro.org>
Date:   Mon, 3 Apr 2023 20:32:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3 2/4] dt-bindings: watchdog: xlnx,versal-wwdt: Add
 versal watchdog bindings
Content-Language: en-US
To:     Srinivas Neeli <srinivas.neeli@amd.com>,
        shubhrajyoti.datta@amd.com, michal.simek@amd.com,
        srinivas.goud@amd.com, wim@linux-watchdog.org, linux@roeck-us.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        git@amd.com, git@xilinx.com, neelisrinivas18@gmail.com
References: <20230331074117.356339-1-srinivas.neeli@amd.com>
 <20230331074117.356339-3-srinivas.neeli@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331074117.356339-3-srinivas.neeli@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 09:41, Srinivas Neeli wrote:
> Versal watchdog driver uses window watchdog mode. Window watchdog

Subject: drop second/last, redundant "bindings". The "dt-bindings"
prefix is already stating that these are bindings.

> timer(WWDT) contains closed(first) and open(second) window with
> 32 bit width. Write to the watchdog timer within predefined window
> periods of time. This means a period that is not too soon and
> a period that is not too late.
> 
> This patch adds devicetree bindings for versal window watchdog device.

Do not use "This commit/patch", but imperative mood. See:
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> 
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> ---
> Changes in V3:
> - Removed  xlnx,close_percent property.
> Changes in V2:
> - Added watchdog ref
> - Removed timeout-sec property
> - Used 4 spaces for example indentation.
> ---
>  .../bindings/watchdog/xlnx,versal-wwdt.yaml   | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> new file mode 100644
> index 000000000000..dea1e7c487d3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/xlnx,versal-wwdt.yaml
> @@ -0,0 +1,50 @@
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

What is driver? If you mean Linux driver, then drop all references to it
and rephrase to describe hardware.

> +  timer(WWDT) contains closed(first) and open(second) window with
> +  32 bit width. Write to the watchdog timer within predefined window
> +  periods of time. This means a period that is not too soon and a
> +  period that is not too late. The WWDT has to be restarted within
> +  the open window time. If software tries to restart WWDT outside of
> +  the open window time period, it generates a reset.
> +
> +allOf:
> +  - $ref: /schemas/watchdog/watchdog.yaml#

All other examples reference local watchdog.yaml. Don't do it
differently than others (git grep watchdog.yaml)

> +

Best regards,
Krzysztof


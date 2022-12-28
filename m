Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774B56575AD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 12:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbiL1LMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 06:12:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiL1LLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 06:11:25 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6C1299
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:11:24 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id y25so23180302lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 03:11:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2f4SZyg4wonPVTx4RxeA6rIxFyapG0eRgUtOAydlWA=;
        b=VgWuOg0Q/BEsBygLFpJMjYgIuVod22bWs5l+/X3fOaaWVx2IsUkTSEmYS51+wK57k2
         AUfCWQAqR4hCi3nLS80syhaX/nsfMis8faHJzh7uTMpzmuASDUVAU3goBDGehMe972uK
         q/xvXtEZB2MqYQfqyPin8nBk5kR7sPo4cddfVm/DUFP/BfjpkZXJaksirvR0lTu5Pa6T
         RCVe0Nqk48/Iu2DfDLhx6HhpiG7FG8YN8LRYrx0iBGicqs0qOJPUmtiHLwf0xcF5PdZr
         UtTEUuBT9t1fTENfGm0Yq6hYTuRqpqLdp1kGG0tZGG1vwmXibTxBmSevUKASgYB1u3UK
         zp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z2f4SZyg4wonPVTx4RxeA6rIxFyapG0eRgUtOAydlWA=;
        b=wpkCEtzsaLJmu/4Q+hJAlu/7vjJCYKFwDs6icqNUcywJCXeJA8i9pJdXvvgwIGcoFV
         I4KJkL6ZyB3lLAAwW9kAs8NQgTYr8fbZwDcGRtWCl0p+1SIpwlefgqiVSRpMzok48/H/
         WlfN9FFBCCR9k3gqfggibXm4lARy85lr8kjqboYnxa1hLBV4nqgFTAcoke5QxvBRwkIz
         XrhOvNqmi1VVUnczGVcGVRmK94EmQ9xw6Jc/btE7ImrPYqBrYPOczEYR9ZM5xbLIulsz
         w1bPk5qCZbKNeU2GwhlAH5HP3TW08V9m7luS/pr92okQ7lVKWXsjfcaScf/ybtgLAk+0
         2O3g==
X-Gm-Message-State: AFqh2kpmpjxC27WEdWXbn/+pxs4EeGj3G8n+rYaQomq7H8Jg6U8gfunL
        /77XPXP0OcCgqgJSjUDXSYkRbw==
X-Google-Smtp-Source: AMrXdXvOtmvIG7R1J4c06BP7mYgTgqlZzX8dEVFQxPiuCwnLOhkokMDzf7g7ahmf2F74vURqMQtXZw==
X-Received: by 2002:ac2:51b6:0:b0:4b6:ed8b:4f16 with SMTP id f22-20020ac251b6000000b004b6ed8b4f16mr6620915lfk.52.1672225882451;
        Wed, 28 Dec 2022 03:11:22 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id s5-20020a056512314500b004b59871f457sm2628788lfi.247.2022.12.28.03.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Dec 2022 03:11:22 -0800 (PST)
Message-ID: <2653e293-92a1-817f-6a84-c8e21f34d304@linaro.org>
Date:   Wed, 28 Dec 2022 12:11:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] regulator: dt-bindings: qcom,rpmh: Indicate
 regulator-allow-set-load dependencies
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Andrew Halaney <ahalaney@redhat.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dianders@chromium.org, Johan Hovold <johan+kernel@kernel.org>
References: <20220907204924.173030-1-ahalaney@redhat.com>
 <14b0237d-6511-4a1f-3bda-e0e72b442a56@linaro.org>
 <Y6whZ50Lz07xG/R1@hovoldconsulting.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y6whZ50Lz07xG/R1@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/2022 11:58, Johan Hovold wrote:
> On Wed, Dec 28, 2022 at 11:37:06AM +0100, Krzysztof Kozlowski wrote:
>> On 07/09/2022 22:49, Andrew Halaney wrote:
>>> For RPMH regulators it doesn't make sense to indicate
>>> regulator-allow-set-load without saying what modes you can switch to,
>>> so be sure to indicate a dependency on regulator-allowed-modes.
>>>
>>> In general this is true for any regulators that are setting modes
>>> instead of setting a load directly, for example RPMH regulators. A
>>> counter example would be RPM based regulators, which set a load
>>> change directly instead of a mode change. In the RPM case
>>> regulator-allow-set-load alone is sufficient to describe the regulator
>>> (the regulator can change its output current, here's the new load),
>>> but in the RPMH case what valid operating modes exist must also be
>>> stated to properly describe the regulator (the new load is this, what
>>> is the optimum mode for this regulator with that load, let's change to
>>> that mode now).
>>>
>>> With this in place devicetree validation can catch issues like this:
>>>
>>>     /mnt/extrassd/git/linux-next/arch/arm64/boot/dts/qcom/sm8350-hdk.dtb: pm8350-rpmh-regulators: ldo5: 'regulator-allowed-modes' is a dependency of 'regulator-allow-set-load'
>>>             From schema: /mnt/extrassd/git/linux-next/Documentation/devicetree/bindings/regulator/qcom,rpmh-regulator.yaml
>>
>> Andrew,
>>
>> This patch was merged therefore we started seeing such warnings. Any
>> plans to actually fix them?
> 
> Didn't Doug already do that?
> 
> 	https://lore.kernel.org/all/20220829164952.2672848-1-dianders@chromium.org/

You're right, thanks. I keep seeing the error on
sm8350-sony-xperia-sagami-pdx214 and I thought it is on every board. My
bad. I'll fix the Xperia same way as HDK was fixed.


Best regards,
Krzysztof


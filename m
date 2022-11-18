Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D96862F54A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 13:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbiKRMsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 07:48:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKRMry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 07:47:54 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5C1905A3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:47:53 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id c1so8033955lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 04:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNREZukHu2EWl9pxNtrKnMGTdTaPArHSEVFgX5pTSBA=;
        b=Mfh5qnu8wwOXZ/SzH/+YCoPeRNG7YHtHpQz4PENBI6WOjlTEfK65GOFFdJIdzBXmVS
         cQCc3SIyzhpYTLAG9BCUTPVGGzMKXpGfHew0Mxzw5lYfaxSFNnWlnPM9nDL/UNpmoAco
         Ujda1R1mHJWcw0le9xAyKp+xKwt0jPkXJwJbKK0RlzTv52xCVu4vcG1DeSEmpzDO2OTF
         MwEuUFvzBJLn1739krAvTZnDtW1t+c9brT7AK6XbxYe9DOOUDvwh9yVcG3IycoJZFceF
         XEpQgbRjiSiNMRzrvE5VmEXVtR1TVJKFe3XnBpo6OHDF7h96s9y09WzjnwrmT/XVex4r
         Jylw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNREZukHu2EWl9pxNtrKnMGTdTaPArHSEVFgX5pTSBA=;
        b=FerrNwdP9mbBfxBYzfCGKNtOLvvEf86yiQUeQ5TetzMKKhZfwY7mY1moPjZynov9TB
         uGoHZsLrOu+irfz3pd77tVG9715AbO5OYSAsFv2bM54jKr5IxnVCGA5mND0YZRBYg4q7
         YnTvNH1HIKA0wkZ9ge1JVypGbyvcTXOaTQxWUzHDqgcUFc/OMjEXICuZke1rGlUaj1G7
         KDP6+rW86pAlxiPc3vH/CfkipsI9UXrdh0Zc0bvXb16BG1UVDaB0WWPyKFbHPBqVOPrx
         TWydjeV3+Y2JiOLTCX8snBeetH0SyyeNSTPlVUd1PccUxxLku+ewIGMqNTnagUOGi0BE
         KdSg==
X-Gm-Message-State: ANoB5plw7f/mXeUr4S26ee1qD97RcPU/I9MzB6T2CUZ1NP8lwv/5lIy9
        Hula1Os7RT+id/Q0j1k0EHiY3g==
X-Google-Smtp-Source: AA0mqf5TGgDQBL7ZsT/FgIIAJdgZEFUFV8vHJHcHUACF18USX8SmXmeBQIkM1RWk72aUP3s8yc6eVA==
X-Received: by 2002:a05:6512:23a5:b0:4a4:7e77:664f with SMTP id c37-20020a05651223a500b004a47e77664fmr2353698lfv.603.1668775671475;
        Fri, 18 Nov 2022 04:47:51 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i9-20020ac25229000000b004a764f9d653sm645706lfl.242.2022.11.18.04.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 04:47:51 -0800 (PST)
Message-ID: <acbe0e45-1abe-eb3f-f818-8511cae676ed@linaro.org>
Date:   Fri, 18 Nov 2022 13:47:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 2/3] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
Content-Language: en-US
To:     Tzung-Bi Shih <tzungbi@kernel.org>, Lee Jones <lee@kernel.org>
Cc:     Mark Hasemeyer <markhas@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        chrome-platform@lists.linux.dev, devicetree@vger.kernel.org
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.2.I9e018ecb8bdf341648cb64417085978ff0d22a46@changeid>
 <Y3cboMlFTRzSJyQ8@google.com> <Y3dJYXCngi1p28HO@google.com>
 <Y3dOF3IQ/S5NCnR+@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y3dOF3IQ/S5NCnR+@google.com>
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

On 18/11/2022 10:19, Tzung-Bi Shih wrote:
> On Fri, Nov 18, 2022 at 08:59:13AM +0000, Lee Jones wrote:
>> On Fri, 18 Nov 2022, Tzung-Bi Shih wrote:
>>
>>> On Thu, Nov 17, 2022 at 11:48:47AM -0700, Mark Hasemeyer wrote:
>>>> Add DT compatible string in
>>>> Documentation/devicetree/bindings/mfd/cros_ec.txt
>>>
>>> The patch doesn't apply.  Please rebase it.
>>
>> Were you actually trying to apply the patch, or just testing?
> 
> Was trying to apply the patch to my local Linux tree (for-next) for
> reading the series.

Are you sure then you choose correct base? Because with instructions
"please rebase" you actually could encourage to rebase it on incorrect
base...

Best regards,
Krzysztof


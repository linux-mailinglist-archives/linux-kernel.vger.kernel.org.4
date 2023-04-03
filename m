Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7302C6D401D
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231919AbjDCJT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjDCJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:19:39 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB7310ABE
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:19:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id ek18so114574433edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680513556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xtjX09frN0K29pRxgf6hACPfNtdl31/D5yVk7FHaNzM=;
        b=AcngGAsNnhlAdsWvDJbbweHBhYpK2WLDIX0lIsSNoQoqTBpzO7gU2tby5FG89yglvj
         jwalHAdHKzk3Ul7phzxP6THvFKSCRBHj+8ezkKuP+9x485GCH5QHXR9+Uv2PckqJfgng
         We12sfM1IafZfmT01Wgma9fvtA/b4QMfkIbvTy/gCHvVKULaSteg7elA3+8Ahgssjs1A
         xlEJTQm2cIT2g3chnw7CfTpwNQYlUjT4A+u7LuPLp7jCSg+MzcTHp3QTsEb6N++lOxin
         rPlNhJofl8P4kO3gcCNTEayjjofywoi1fmiE1FZfKbMjaMI9nQJZrITou8k6BNUcsygm
         RpeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680513556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xtjX09frN0K29pRxgf6hACPfNtdl31/D5yVk7FHaNzM=;
        b=aP84uNC55lJMbHiiyCsuoG3P3Zxpu+aVvMRIBp+sBVKbpc2gZoZh//NYiJQwfdj5l0
         aCKZBAOcqccWOI3iOFsMYOY9Kndg2JEJZCJPLk2A7mNLpoPVsuQvCBZ+1xZ5sBFebsle
         uHtLjjov+J9GWRNcdBpWxbHxUZ0YIi01VKzPBrWYPqTBmhR7dRcc7DwNdLkTNmRnIauT
         6yt/A70m1BD1zXh96xalsJh0ubRlQAQ2aoIk9ydo3IZEGyUElubwfcW/l1B+TkeuVMgP
         t5bvVdTh2A1bVBEeC01A+cgOCZc3YiP3IlGWmg3R1J1PvbOnu9AwF6heoDk83SRoAgw8
         IiKQ==
X-Gm-Message-State: AAQBX9d2XglvmuZIHPEZvHXuD+rk5U3rybSIJOygykHpbgtYnSmsiYfd
        tA9YTlBFuf3DZHGDpOzvLgvLFQ==
X-Google-Smtp-Source: AKy350b9Mnm1wx7mnQYX/WsjT5FVGKxITPprQ1LuJWlIRLGronH4vRCLv2HbU4jDnRWyRbvCXKTQmQ==
X-Received: by 2002:aa7:cacd:0:b0:4fc:7201:6e4 with SMTP id l13-20020aa7cacd000000b004fc720106e4mr32928442edt.20.1680513556539;
        Mon, 03 Apr 2023 02:19:16 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id x3-20020a50d603000000b004c06f786602sm4270132edi.85.2023.04.03.02.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:19:16 -0700 (PDT)
Message-ID: <a585fb29-e960-46e3-f768-01e7d104b204@linaro.org>
Date:   Mon, 3 Apr 2023 11:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v4 3/6] dt-bindings: firmware: qcom: scm: add SSC_Q6 and
 ADSP_Q6 VMIDs
Content-Language: en-US
To:     Dylan Van Assche <me@dylanvanassche.be>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230401173523.15244-1-me@dylanvanassche.be>
 <20230401173523.15244-4-me@dylanvanassche.be>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401173523.15244-4-me@dylanvanassche.be>
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

On 01/04/2023 19:35, Dylan Van Assche wrote:
> SSC_Q6 and ADSP_Q6 are used in the FastRPC driver for accessing
> the secure world.
> 
> Signed-off-by: Dylan Van Assche <me@dylanvanassche.be>
> ---
>  include/dt-bindings/firmware/qcom,scm.h | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


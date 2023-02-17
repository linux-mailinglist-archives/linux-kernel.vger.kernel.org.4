Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729B269B495
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjBQVUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjBQVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:20:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E7BA5FC46
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:20:49 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id bg25-20020a05600c3c9900b003e21af96703so1264198wmb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fG5SLtoM0wtpwjDkO7HF0+tlYQd+noTOTI3vBQPoJo8=;
        b=w8ncplniUBt+6IvkMo+dy6w8R/fuJs9sZVhA5HsgPWHm6OXkJqlGUVBxceYd3Hzcw/
         tYiXRJAPhbJ4NCDsAugvq7gWkk6zD+JNDOmHgcrUCrTzlwsWNo8fGpo8BYK/Yx3fDw+7
         LNiQNmF0pVwC3dURJhPgQ5+XNOipPw6XSAizb2qodYJIGSSRZBa4uqBIiax4lcXrxOy+
         LM11vZDQ0cfW10hVz47ZEpoJ3EQJgC5F5jb/rps2sFEcz3ObQje9FuCabXb8GGbplUwP
         N33Kv/mdpn3QGw1Fw2GAgxnSl66LU+c6AqtLyOcSTf7xHaD0W97rwl9O1bXlqX+U5qFT
         Gatw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fG5SLtoM0wtpwjDkO7HF0+tlYQd+noTOTI3vBQPoJo8=;
        b=s1y2z4BrzDp2WaAOL2F0chnrp9XnWEBaFjLH5H8ZXHBeVxdVtTmKTOeG6cZL1yvT82
         SSXNOkYzch6ykO3QLMJkfXX62DUNMyvyxcP0VYvLxsy8lVdHdl09BhP3WdbnYHkPTHJn
         wCd/EwZcrrLX4fGl/Gq5voUceD7t6rvHY5DgH3nzDFWDISgbBmO5vQVtA1NKvLitGADc
         E8nOyj+ppGPgC5gMMtLscn778zUFv6y3zNKz5iY3Cw4IKe/+SUytftwrms0uHbi2HcdB
         b7P1aeruvojMzDul+Q0rhB+nRlF1MWUfORzeWzVWKUc1Yrlve4cCnmqPOxIAp5Y9tUWj
         b9eQ==
X-Gm-Message-State: AO0yUKW4uSEdGLHSBSCj9GKPpJr+BZdeMz/m1w7qlQOMGoq2qLIb/z2r
        jeKWF0WUfXKnfTZxvHEXx+mxbg==
X-Google-Smtp-Source: AK7set9fzwn18p3L36vUlE7QAvIXE1IZGf36C/OC1NkzutJb49RjQizbwoUUn89B5EiLd/COy2eBCw==
X-Received: by 2002:a05:600c:2a08:b0:3e2:1fa6:f428 with SMTP id w8-20020a05600c2a0800b003e21fa6f428mr3055036wme.15.1676668847653;
        Fri, 17 Feb 2023 13:20:47 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o9-20020a056000010900b002c54241b4fesm5119375wrx.80.2023.02.17.13.20.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:20:47 -0800 (PST)
Message-ID: <0b3e8c81-b0fb-651b-8688-872f03c68d8f@nexus-software.ie>
Date:   Fri, 17 Feb 2023 21:20:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 1/2] dt-bindings: display/msm: dsi-controller-main: Fix
 deprecated QCM2290 compatible
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230217111316.306241-1-konrad.dybcio@linaro.org>
 <c49904be-d842-fc12-a443-17f229d53166@linaro.org>
 <a4eaccfd-34ba-15f3-033f-165b46c43317@linaro.org>
 <a158bca2-78bf-5b38-60fe-88118e8b4ad7@linaro.org>
 <ab35cdcf-53ae-a3f2-fc08-d0f58c51a0ae@linaro.org>
 <48cb00cd-961c-b72f-fba8-1842d658e289@linaro.org>
 <d4ffa9f0-797e-7a32-147e-64aa46d7e197@linaro.org>
 <76de00dc-f128-e609-7f0c-b53161036b97@linaro.org>
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <76de00dc-f128-e609-7f0c-b53161036b97@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2023 21:16, Konrad Dybcio wrote:
> Correct, but QCM2290 is not supported upstream yet.
> 
> SM6115 (a different SoC) however is, but it used the qcm2290 compatible
> as it was a convenient hack to get the DSI host ID recognized based on
> the (identical-to-qcm2290) base register without additional driver changes.
> We're now trying to untangle that mess..

Gand so what we want documented is:

compatible = "qcom,qcs2290-dsi-ctrl", qcom,mdss-dsi-ctrl";
compatible = "qcom,sm6115-dsi-ctrl", qcom,mdss-dsi-ctrl";

with the old compatible = "qcom,dsi-ctrl-6g-qcm2290"; clanger continuing 
to be deprecated.

---
bod

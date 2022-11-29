Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2063C012
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiK2MbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK2MbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:31:16 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B4257B7D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:31:14 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id g12so22259433lfh.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:31:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tEe4be84+cUwvRy1iPXGZ70MDhm+yOVuOy18UTBPziI=;
        b=n8SVbZqJDou0d9x8BSOGaCYiA3Nm8CqG91qDm4M1BI8tXviM3qck3sNE0iVlMEROKh
         uZkpERuUSMSoPTOJziUfGWNRmPfFJuk8sDRJkvGRApbjBW4//RssuGdxsQSVy4I6cCw1
         PzdskeSbpP+EVge5nQcKMgXf0NgkukGb/valud3PmgjPjQwCqFNG9wyIVr3pVyZbDn5F
         Gho16NzaT0+rtExU6QQBoUjy88dOiJ04rEfsxJHalzatoNvIjYURV0B6tN8stNug2L5A
         d8AXMo+q+Wm+N/mun/+xMnLlSNPCyH7ens1pLYNxAQpPBSknJfbIl7+r5A/hqZXymkcS
         DDGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tEe4be84+cUwvRy1iPXGZ70MDhm+yOVuOy18UTBPziI=;
        b=uwA5vNw6UHUks/U5kRTQYPYhMD0elbZW4KuWvdoXkU9HzP3BjtVAfwV+bKwA6JJx4y
         8N23q2VUZcnnl0NX3hg9wxwyhjIBv1HEfkN97fNl73Xon7I3nzY//nSh0CIbOJRRdCjH
         b3pbXwwvg6FNkQogNytLFlTxSePw3pJJWOd1Ae1wXnlFqAqMJdw+DiwzkiVQ9AuOO1zf
         LUfDZaz2ISYyPpvi44Y0Y8aqABetc/ZD/X5qqXTldcoVGtLo+00e9bcYmjhGILbMQPka
         hkYxE6hSNK+37juIXHS0phNEVNjKzJBIANL6hk7wY8VEg8k+RJDezjaNsAzrdIdi8rcd
         dICw==
X-Gm-Message-State: ANoB5pmd2J0WeRuh07bsraKHEsE5ndim5oaR+VNYAHxYCd1HPxHC20cq
        uIXNbGZXbavUfKBtdePwApDp1g==
X-Google-Smtp-Source: AA0mqf5U6ptYG6qigHafOnnkfolPA2UcpznePa9vGRTYrR20w2p6PZs3g/q4WMvpQ2kt2HhPBVvnkg==
X-Received: by 2002:a05:6512:49a:b0:4aa:da5d:dfd8 with SMTP id v26-20020a056512049a00b004aada5ddfd8mr20847347lfq.677.1669725073278;
        Tue, 29 Nov 2022 04:31:13 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id x7-20020ac259c7000000b004b529517d95sm182509lfn.40.2022.11.29.04.31.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 04:31:12 -0800 (PST)
Message-ID: <5c0d5ddc-9212-1f02-2f9f-9eab8947a0a5@linaro.org>
Date:   Tue, 29 Nov 2022 13:31:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v9 1/2] dt-bindings: arm: qcom: Add zombie
Content-Language: en-US
To:     Owen Yang <ecs.taipeikernel@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Matthias Kaehlcke <mka@google.com>,
        Abner Yen <abner.yen@ecs.com.tw>,
        Gavin Lee <gavin.lee@ecs.com.tw>,
        Bob Moragues <moragues@google.com>, Harvey <hunge@google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20221129194620.v9.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221129194620.v9.1.Idfcba5344b7995b44b7fa2e20f1aa4351defeca6@changeid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/11/2022 12:47, Owen Yang wrote:
> Add entries in the device tree binding for sc7280-zombie.
> 
> Signed-off-by: Owen Yang <ecs.taipeikernel@gmail.com>
> ---
> 
> (no changes since v1)

So that's the v9, still without improvements.

Best regards,
Krzysztof


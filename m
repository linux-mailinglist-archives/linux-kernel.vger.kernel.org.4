Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1FBD6C0185
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjCSMWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjCSMV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:21:59 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 809301A65F
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:21:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id b20so3914479edd.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679228516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UA/RVseheg2Mc3aNDxrWXO0sH5wS3//KYOVz8WHnSys=;
        b=ro7/Aw85j2ohxJI5Th71eZODXAv7tXOyG3a5gSiHPGDCS8I1MyNsw4VzCN3LwKNlgo
         Z/gvIQKe7+xuuLp3ntdlVLxyMoO+VpFVWf3rdS6JlTsMJGoDMZroYfU9S/Zo0q9qNJZv
         7LzJ1kPPVji8vrAAE7ihaNvo0yqZ0NsMMseHd3Vdr+91O00YP3NNjZlgi9WHP/LeBJd6
         r2yMghWhfYLGZfoNVXYTcxOCTgADg9NqDNL4d8v6+rPb+0xXi1SgwDCL4DuEFJNXEpvr
         BTYpNPK4XDZPf7nLEFTr1P7ZJj9U+gq3LZaIDu7RpRhwWWmAt4tUoubKvp6ytxuHQsJG
         /zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679228516;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA/RVseheg2Mc3aNDxrWXO0sH5wS3//KYOVz8WHnSys=;
        b=PHgcsSe/bH/HM1ldTHQAy2lk1HNAs2g/vH1cBq2Dl0oA0cpgYs6kyi303WKrJiGAF9
         J07FrjzcoP7q8eafzxK4MX4P1bGY/CriylJxaRa4ROZNCYHKyTEe+RzNsiYYGMby7A9A
         0OUmljih7UdmrwODNO8Jr+KYVdF7sFvDg/MFgkNi3r+IbLr4c2LYzZnj4dq9yOgs5wfI
         zxbvNHKjHVD41PH8QrBVeOt0Lnxpsq+p8LvUuRK23Y3+PVOXPgsxqYmhIZffaFG3UUsG
         HRkJkPr1mtO0kBnosJDKd7y8sWBmjBpzB6y3i4Kb0OdJk6NvU6c6SD9chKhYT1KidOMf
         yeeg==
X-Gm-Message-State: AO0yUKWVsmEdKJNd00qgC7vmwXx5VCrsmJXUubOTNzC0Y2iU9UF5JNzn
        Wvla3FiNC8aYgFzVq7q2R97/RVZOGtEkakCBLhk=
X-Google-Smtp-Source: AK7set+E9ngdMGo3d0f03BlUazh4+7McUbDGjmEBkFAAeDIwW6xWmjiuP9WKSoc39PO9j3/TPR1elQ==
X-Received: by 2002:a17:906:d159:b0:932:8dc:5afe with SMTP id br25-20020a170906d15900b0093208dc5afemr4941050ejb.67.1679228516021;
        Sun, 19 Mar 2023 05:21:56 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id x93-20020a50bae6000000b004fbf6b35a56sm3458374ede.76.2023.03.19.05.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:21:55 -0700 (PDT)
Message-ID: <c6b562d7-8d88-18ea-31df-db1fd200c251@linaro.org>
Date:   Sun, 19 Mar 2023 13:21:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/4] dt-bindings: mmc: Remove bindings for Intel
 Thunder Bay SoC"
Content-Language: en-US
To:     rashmi.a@intel.com, ulf.hansson@linaro.org,
        michal.simek@xilinx.com, p.zabel@pengutronix.de,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, kishon@kernel.org, yuancan@huawei.com,
        andriy.shevchenko@linux.intel.com, linux-phy@lists.infradead.org,
        mgross@linux.intel.com
Cc:     kris.pan@linux.intel.com, adrian.hunter@intel.com,
        mahesh.r.vaidya@intel.com, nandhini.srikandan@intel.com,
        vasavi.v.itha@intel.com, kenchappa.demakkanavar@intel.com,
        furong.zhou@intel.com, mallikarjunappa.sangannavar@intel.com
References: <20230316120549.21486-1-rashmi.a@intel.com>
 <20230316120549.21486-3-rashmi.a@intel.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316120549.21486-3-rashmi.a@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/03/2023 13:05, rashmi.a@intel.com wrote:
> From: "A, Rashmi" <rashmi.a@intel.com>
> 
> Remove Thunder Bay specific code as the product got cancelled
> and there are no end customers or users.
> 
> Signed-off-by: A, Rashmi <rashmi.a@intel.com>
> Reviewed-by: Hunter, Adrian <adrian.hunter@intel.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA9D5C0255
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 17:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiIUPvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 11:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231673AbiIUPuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 11:50:55 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662299AF88
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:48:47 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id a8so9862552lff.13
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 08:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=dfNfQ/WHHv5bx3D+RgTnUZ4fVKImMkLUwy9dSYsV4ZI=;
        b=CDmDV9J3qN4i9riPSH+wIb8RFI/McE/mLSFmgYfB/gE5F7kdrl1NmF42wf9DSBeRwd
         Ct19uqUuy2FLnAbCNp1CNMh4/330+XcctKS0V+I6PI+WFIOsKZvo5lCamy74KsczQFZS
         3uKuIr/48msm5QHiZgpYrcT5MTXmmsjkYB6oaTVlrafKzHaWJ+uv8QFBGhPIYiRonj9w
         8A7Rzs09sLCakpZTS6WRyB2bxIgExnCPqs6DkxUIwoEQSAn4C///Mygs7lqMZdHS3J8a
         ds+no9LudlHEJMErjZyqkQk19Omjo8V4qRakUidEcKo2qvMYJbfnxGwbd4PB/n/eRlFr
         wpbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=dfNfQ/WHHv5bx3D+RgTnUZ4fVKImMkLUwy9dSYsV4ZI=;
        b=HVDbOpsAM9cWisAmsbIyfRWw5xQ/AJgrP7OqgzwY6EGq9J1R5zZlSwELZDFgs6hwrQ
         wzZyNB/MpObAtv0PrZw27xG/Yi+/5OToJu//PNqA+HeuGTcUqQz3etXNFOFlr1APhqE8
         47SE4JDcH4Bfo/BXMqCBLR2WgTtlkTNFxJVDy3bpN0b4zilzJfrgssC9UxFn14E0TF2k
         n4PgM+u+hyupgsy3PSPuWA3GDLWj+WgwlAU1z9Fy9882DAGhZXkZqiQAhsXsRwNRUjQz
         WiPiyZMuy88YRNeLJEa3XbWsFVRu2igus20vMkOia7h3rdsCNahAw3OOSEEZm/wlADdG
         EBqg==
X-Gm-Message-State: ACrzQf3jvjGSxrFaJNzx7xRRxLW8qvuwgiuQBOuC2nKoChi1Dq7oJ2lf
        a0hKjVClCsS0MKA9+TnloJbbu6G/ZyH9pw==
X-Google-Smtp-Source: AMsMyM52aQHhQGHg1+wR1Bdadj9kbl+E7s+T7WEcsWzkxcaODyaGUchTnGQ0q6iJgm1jXk7j1PT/UA==
X-Received: by 2002:a05:6512:3503:b0:496:55d:a186 with SMTP id h3-20020a056512350300b00496055da186mr9957884lfs.340.1663775318470;
        Wed, 21 Sep 2022 08:48:38 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id be36-20020a05651c172400b0026bca725cd0sm496321ljb.39.2022.09.21.08.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 08:48:37 -0700 (PDT)
Message-ID: <6ef8b2d9-2ffa-ff18-eb9a-9d7b9f293ced@linaro.org>
Date:   Wed, 21 Sep 2022 17:48:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] dt-bindings: clocks: qcom,gcc-sc8280xp: Fix typos
Content-Language: en-US
To:     Andrew Halaney <ahalaney@redhat.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220921153155.279182-1-ahalaney@redhat.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921153155.279182-1-ahalaney@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 17:31, Andrew Halaney wrote:
> pipegmux and SuperSpeed are the proper spelling for those terms.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


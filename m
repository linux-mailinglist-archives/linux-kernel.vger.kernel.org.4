Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838046D420B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjDCKcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjDCKca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:32:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23C586AF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:32:28 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id t10so115173533edd.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 03:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680517947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziesCGyE5ths8HzE/mhJvKhp/kqnRaJ5l6HH5FEAep8=;
        b=l2KRbV63hq0ABBC0fAbwwaH56OrBM+lonL5AbrqdCqij4e6mYZuRQgvsJcG9ba2OHj
         JdQAr6S1I6SNn/ffRfikpDvQZ6tsBB+Sr8MU0mtuuXK0YnwF4i5YmFOSyQWgxPTM5L61
         Ha17k4z2oahI9CVuVagXWVhhHnTSQN0IyULowdRUwv1E+b4aNgJFcY/xZgBFIb3Gm1Mk
         DaURSiK3gHrIyIocZsLyM6wr/FsFylOiabXQ7hXsiFf04HQ+AubRGoVK1bWnE8tmSuc0
         be6buNRvxg1U4kxJE/+Wh1zo7ebp2PZwvzAkI9z8SngE9gZPFAbbQbPT2ou8YbdZfC1J
         f3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680517947;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziesCGyE5ths8HzE/mhJvKhp/kqnRaJ5l6HH5FEAep8=;
        b=sr+EVFDRgwSv0NCSC5BHgpWYqtEmXcHgI0q1/t0PomYTslqG89iRu7nhW3dmhzCk9B
         q8dwVashdVuwUqhOAseUPsnrdcxHdVlyxxABJnj6sFFRXdxVuIrrM2eYhx3wNx7IxBzI
         f3SzU28JWc+EXaeqDLGRCy50IXks4aC2iEk9M3aIk389MZpym7eZ5g2Pv0qNKSD5tNaI
         enygbNvWOWtqEvKbRe3BvvJRUIaF9n5yeBTvDf0VyCnr2T4NxbL9cmQC3q+DO/BKkAlo
         C/Z9kyZZuDP8CSqdeLiADvYAW3RkiSxUzgtg3gm5mvorP5qrZ3PtCgZjInOFCjisSDOm
         wsyA==
X-Gm-Message-State: AAQBX9d1KMvDprfOdgUd7/YHTdgXkoEEMVGfdngAP45aq++/HFiEfceI
        kuXIlCaLM9sfpRWb+iycerigRw==
X-Google-Smtp-Source: AKy350bXqnHRSCry8TNkyNVTg3r+0qjfsw4m4vCtJmGjh2QVaiDlfZ4+urlWYvfoN5DuvqM0V8TEuQ==
X-Received: by 2002:aa7:d8cf:0:b0:4fc:8642:ce56 with SMTP id k15-20020aa7d8cf000000b004fc8642ce56mr31893374eds.25.1680517945601;
        Mon, 03 Apr 2023 03:32:25 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id q6-20020a056402518600b005028c376d50sm3169066edd.71.2023.04.03.03.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 03:32:25 -0700 (PDT)
Message-ID: <f8c64dc8-7ded-6dff-4d27-754e547f79e8@linaro.org>
Date:   Mon, 3 Apr 2023 12:32:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH V3 6/7] dt-bindings: clock: imx93: add NIC, A55 and ARM
 PLL CLK
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
References: <20230403095300.3386988-1-peng.fan@oss.nxp.com>
 <20230403095300.3386988-7-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230403095300.3386988-7-peng.fan@oss.nxp.com>
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

On 03/04/2023 11:52, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX93 NIC, A55 and ARM PLL CLK.
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


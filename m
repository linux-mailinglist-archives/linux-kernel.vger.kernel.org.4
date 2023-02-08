Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058C568E971
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 08:58:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjBHH6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 02:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBHH6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 02:58:21 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3AA86A9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 23:58:20 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o18so15853011wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 23:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53XamUUloQYj/jVvLSV4moBLsa3YomfACjfIwHnHSNI=;
        b=GPBZVn7ZfcdsfPWdTduklU51G2rhQj364fR41ayHVt3aCFDsimiVDN1DdOb1z3LBuv
         WC8jbiLlLWU3kA+VFDyVwlkUnAu+f4QeXBSkF4swK4M5gOV8xe0QyBuzfPyf1dJPkCOw
         7EwXxcVpThdDQU2owzRuXxAVGGooH5pZ1UDZVljur9hQK0XLAQWXWZY+PcYtZ2iLYRUc
         rUz6xFvjSYDoZ++L4Fk1zal+ejxx9vkIgw9B/wS9OhVND/RiyqA81WO3AemORRvoU0NW
         zmuE09d4ITmqfTAxEm1hK44GFGMcEq9RVvLrXUIBWAGvbxvS08Kwjv5LjoCGtuW7D0XD
         xynA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53XamUUloQYj/jVvLSV4moBLsa3YomfACjfIwHnHSNI=;
        b=hnwxOscZ/KPqKQmLjjLmNO97QyA586mG8XRlLP/T3nsm7lvR+FUVrkvwvPwDo9dVoL
         pHxV6NaZyVFiEy9P3nNoAlckuDAoOkMkZPPJiutjFENNZ4HN5NkItqVovet9qIxYqkVs
         OySbBW94jwsgVsRUPMSolAIWGgA34e9QvinUiM+vKS192qb//hhoRHUHjKeZa1G7W6oF
         K7W2dsy1NHz9psF2nkBUNlbrTGRGdlSA+N8nzMh2DL8L5AFGvNGLESOc9STihjcItoNQ
         yWT6F4HPuBFzNBEPWDpMDidUHlS+IdOH0Mqd+QE19amOh3lFf+dlyy0kmeq2c/aCL79Q
         JaFw==
X-Gm-Message-State: AO0yUKUc9tTVIM5DoOGi9uL3/MYHgrPa0TnoqRi4b0tTAXMe9m09S6ZL
        3u9s0bhvXjER7OhyGaLQuD1Zeg==
X-Google-Smtp-Source: AK7set8lQDcsnWmrx0kQMFtwUSItD+vLMs7AH/LE1ruIcfb91C9M8IKgZBf4CI5Iglz2RaKzuYEBAA==
X-Received: by 2002:adf:f749:0:b0:2bd:f71a:5b32 with SMTP id z9-20020adff749000000b002bdf71a5b32mr5428250wrp.58.1675843099089;
        Tue, 07 Feb 2023 23:58:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f9-20020adff989000000b002c3e6b39512sm7566243wrr.53.2023.02.07.23.58.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 23:58:18 -0800 (PST)
Message-ID: <f0b5e056-50de-4712-d600-8abd147f9c13@linaro.org>
Date:   Wed, 8 Feb 2023 08:58:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 1/5] dt-bindings: scm: Add compatible for IPQ9574
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230208053332.16537-1-quic_poovendh@quicinc.com>
 <20230208053332.16537-2-quic_poovendh@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230208053332.16537-2-quic_poovendh@quicinc.com>
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

On 08/02/2023 06:33, Poovendhan Selvaraj wrote:
> Add the scm compatible string for IPQ9574 SoC
> 
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


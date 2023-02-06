Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC2168B752
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjBFI1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjBFI1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:27:11 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7529193E9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:27:09 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u10so4995272wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 00:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lRhRPXlz1dgromDCK1s2N7IY7bqqLSP4EsF8anTgRk4=;
        b=cmQhN+tgVmBqVkIJ9VPP89ONCFVXmbRk+ybmZMiPCFpICUbwNAoh5fXYMim/tefXc4
         /L1Svy6OI55UszeC5Kdc1GgHOUPVFurcgLwRDCwHKG+zlqrw1XFZyNQMkLWKAweDuhgo
         7WkzCb4jK5XADZCxSN24MDvY0/tWenhtiwr+ZxYDs7YxJeUQ0FQtJ7gYmfVp4S4zPPps
         pEinbdYmGLjrfIj+5NqVSRit7yABJZ5HP/JjhymtpYuReBlEvW0C2SRMJ13NJEsYPxvQ
         718JJgy+ryjUd+YUaxymmNqMer2hGJRctCDNGDQE2YGMdRif9xjnzVOYuE51BLVWtkY3
         jseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lRhRPXlz1dgromDCK1s2N7IY7bqqLSP4EsF8anTgRk4=;
        b=n9+RzHxZYZMIlT3MoGecVbr1PcvjMQCX+1nvvyGxb+OJahCMFoUd0Omx+Mw6DVvp03
         MosyvffjCTOavwecNwL85v45XdCNn4NOqgAAs4EdTk40uWWEiORBd1EiGAVItdqSaQSn
         CR4DIqEZY1Aq5gipOfu9d+om80jdXHRE2EKQbxI89OA0CMDi6FXnYmqiThTK/9Ac3IQ0
         l8wUHYvX5ma/btOLrU4Wvs0Sd4gDuuMduvohHDhfHUhyBSGwzJvr2H00NnWPAtG9GE79
         f08OT/7t/DvP3EzNRNad4p+H9aH0jMY8c4kNCBe5T/YYAP0c64auLHAPoYt+4M+a7Nca
         cDmw==
X-Gm-Message-State: AO0yUKVhzQ7Ysr6AjBZceRHPY1E9CaFC+3ulNhXaB7NlRbcKmDU0BTQo
        Q2xhs0L1B0DQLLtdi6ZtfKOhJw==
X-Google-Smtp-Source: AK7set+Jgz8qWMe0cgC3Y67YXKAYW3XJd3uSW0UFZAOST+pdZaUIZPVIu7/v5YDcuacneIyaTWtXKw==
X-Received: by 2002:a05:600c:5118:b0:3dc:1dc3:7a05 with SMTP id o24-20020a05600c511800b003dc1dc37a05mr17763671wms.10.1675672028539;
        Mon, 06 Feb 2023 00:27:08 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x20-20020a05600c21d400b003dff2b493c8sm6663445wmj.36.2023.02.06.00.27.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 00:27:08 -0800 (PST)
Message-ID: <ab8e553b-41dc-513b-f5c1-2a1d712dd299@linaro.org>
Date:   Mon, 6 Feb 2023 09:27:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 6/9] dt-bindings: qcom: add ipq5332 boards
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, shawnguo@kernel.org,
        arnd@arndb.de, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, nfraprado@collabora.com,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_varada@quicinc.com, quic_srichara@quicinc.com
References: <20230206071217.29313-1-quic_kathirav@quicinc.com>
 <20230206071217.29313-7-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230206071217.29313-7-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/02/2023 08:12, Kathiravan T wrote:
> Document the new ipq5332 SoC/board device tree bindings
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


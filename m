Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41E36834AB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 19:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjAaSFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 13:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjAaSFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 13:05:22 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAB73C2B
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:05:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso1292341wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 10:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=seE7ygZeWWdLG7NxMzBN7WjkibYPgHyAGj2RkW+QhY8=;
        b=VL6uoVukheKgIllrVuliShh6ta6le+Dv219cjnzwF9BHp36+pEB3LCuUgIh48MRerC
         bQQoGq6FhNproUQsuKWDH7ggu5y2e9Lc5PE0z4JsIAHEbV4Mh3txlR4kbfyMyum8KEfA
         F/WBkyMBOxtY7tncwoEoYt9c/az//b2qW4rn/bMLf+k1xBJA30S7fDeYqmmIF47Zm8n6
         eqZd65DtlWY/0qGSgUm7Vj4iTMaGUJU229648ko78YROD7VA6P3ZUDF9XifEMyBLJuFu
         gLiF876v9sqEIK0htCWu3/sEnCRsPtHnDuYDwtqtpoQdA5SfBYkacJJ1nNZYS84JrXXM
         /TCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=seE7ygZeWWdLG7NxMzBN7WjkibYPgHyAGj2RkW+QhY8=;
        b=3nod8mWoKFE8lP9IJKL2fyP6E9sH2EwoGK8hlchcix0F14UCsqKa5IK5B2TG8t7VoL
         bpswT3vpsw2/m1PtNNZWJEnAn4DQEsSWiofei0QUWcTEdFdetOkLjMNV1pPE6kVvtrQ/
         Ae5M1NuKTE3OC5pxe+GLgZHnUSyNTy7Ewsmw+IJFEiwl6xAv0JLLri/YWWWEGnZGGru1
         Nz810PfVlfwLuCJpfNg2Hw5g9MERcJ9k2MDr1F9LNGH0KEC/OQCNG1PwLvZ+wJiCSfY1
         QZq+DDfuz0iYYCeyDCr3SBlPRywv/Fb9/KRexPpgq2q9dRhTn48yyTRSAzuG6lw+z1XX
         J5VA==
X-Gm-Message-State: AO0yUKURfxPMr5+dqbEBdBd1zfDlKke7Tla8WFqm+vdQO05Mo9U4xE51
        A/9ijqkKGLJNolrm8HcP6PKU3g==
X-Google-Smtp-Source: AK7set/lppNvGDkUIrAZV2PDMuAe7/iVHUkL5/AWvjEdNa0/ITCgHtNYruV5eqsp5eZwGh/T1eQOJA==
X-Received: by 2002:a05:600c:4e55:b0:3dc:50bc:da70 with SMTP id e21-20020a05600c4e5500b003dc50bcda70mr11642170wmq.10.1675188319015;
        Tue, 31 Jan 2023 10:05:19 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600c314d00b003db2b81660esm7156431wmo.21.2023.01.31.10.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 10:05:18 -0800 (PST)
Message-ID: <d6387420-b0d6-32c8-48ff-9c2c2028166d@linaro.org>
Date:   Tue, 31 Jan 2023 19:05:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] dt-bindings: arm: qcom: add the sa8775p-ride board
Content-Language: en-US
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230131124424.167827-1-brgl@bgdev.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230131124424.167827-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/2023 13:44, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Document the sa8775p SoC and its reference board: sa8775p-ride.
> 
> Link: https://lore.kernel.org/linux-arm-msm/20230131124026.167281-1-brgl@bgdev.pl/

This patch cannot be split from your patchset with DTS. Or rather: DTS
patch cannot be in separate patchset/branch because it depends on this
one (otherwise you get checkpatch warnings).

If this gets to the DTS patchset:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


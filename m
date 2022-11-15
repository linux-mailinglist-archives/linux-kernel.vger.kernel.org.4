Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87392629E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:52:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiKOPw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:52:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238518AbiKOPwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:52:34 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1452DAB1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:52:30 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id t10so18104160ljj.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qv1jQJ+HAdTvDoHEWeiJyxCYUc1W0oMj7+9QSvPLhVc=;
        b=by67cHmdJG/Y3MLIFsigEaHI6UU+//XXwrX3/Ut83VA+Cmpe8/MUNVfjV21llKKtiI
         nx7MbqtWD/pTgQIjfINnM778dG6FGptovgryInpbKTk5tzwwEhALKRvxrnybAjqGoZCW
         VtmgjdS7Z4M7h2d43uAphVjmqQyPldFRAbVBW6O3ErHeYluHYPet2100OI5zksptMpI8
         Ol6EAbdBAhP1H7yR9auIqrabT3cBB5yO+mc1a82AR4U092w4gXTHo/y4lFjCsTzNRkAr
         +PpmDROj/OzHQMft5k3DIgL62g4gc2asRAQCKKTB+fqkd6rycNH5GF3EimYh+tNPfDd5
         YhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qv1jQJ+HAdTvDoHEWeiJyxCYUc1W0oMj7+9QSvPLhVc=;
        b=baSvPOp555VLEfJ00w8AnDSbowlxpsaejaCStCd0/Ci6yKb1GekYtgxTCc0CmeE3Ka
         Y0BiAMHZDV2jnHdQe0rIPqzrHlViX79idMD5ByYtsW4b2pt2+4IfXwW42Zk1Ma5HEbDE
         tvDZtee7/4PK3kQ99DGz2dbnA/0cgc92jJMPgtihT+ht5boyxTfc8t9Das7ZwROrtJop
         yCFRh6hZ96+iHHV7+Bjtkfydbz+sPUrc3ILwHvlrDA838ulGw8RJOAwe/w/6ajSBVtkT
         rWU5qP34mj7Tvw+RWiJqdL9vLrdLxFDJgM/8Wt/PFy9qdJk5AGYjHjoBJVq4yoJ8Weam
         +4uw==
X-Gm-Message-State: ANoB5pmZuXKXAWDTTHwGcaMddj3SGlb7JlM1+NdLljJkCXrvBJ7Oxd1x
        e6DsvVLYSzrIJRx3s8UBooTUB9VmKZ4GzvoM
X-Google-Smtp-Source: AA0mqf7gWLAjDp2it8ozEEeNxtZ/0E2c3yVOGMOdPqQ9nMgKSfpCDyG2szboeSX/KAVBrxbsqEMLzw==
X-Received: by 2002:a2e:a401:0:b0:277:37a8:ba87 with SMTP id p1-20020a2ea401000000b0027737a8ba87mr5799824ljn.14.1668527549201;
        Tue, 15 Nov 2022 07:52:29 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id f27-20020a19381b000000b004a45ed1ae21sm2243842lfa.224.2022.11.15.07.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 07:52:28 -0800 (PST)
Message-ID: <63f4d2eb-d681-a523-1a5c-9f727c3ddc7f@linaro.org>
Date:   Tue, 15 Nov 2022 16:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on
 SM6375 MMU500
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     patches@linaro.org, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
 <20221115152727.9736-2-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221115152727.9736-2-konrad.dybcio@linaro.org>
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

On 15/11/2022 16:27, Konrad Dybcio wrote:
> The SMMU on SM6375 requires 3 power domains to be active. Add an
> appropriate description of that.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


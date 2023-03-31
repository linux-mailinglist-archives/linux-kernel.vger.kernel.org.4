Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4ED06D2961
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233079AbjCaU0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232462AbjCaU0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:26:16 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BCD2220C
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:26:14 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h11so23465071lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680294372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sD8mbWj1kMVE8NzRJa8GWqijChuvu0jsth7lJ3hShYs=;
        b=PTKj0SeuGnj2ad7pRobdVdg6QeOoPNb9lLzffLecwX7EmkTZBhSlLZG/SD9Toin8zE
         gNXEGe199O8Ok0rD+yLXK7li43Fh3tBUA5vJdJRvH+Fwkkl6zM567IxT7uyglJU3oI8c
         qJQm2RTgHBXM7vgCiT/h7DuOXqXXiMubR3RqObJqgnkMN+3TJgDl6obHnBVBu0/KGM0v
         ToNQ6plbdkdw0W7T99pLBFJKfoYGa9Q2C7kQ/WpSqZ2sHcJZMA/J+JRG1qb9GV1xhYod
         1vAkOyGZuwJP0WVtZS2ijP4XKF+qX97KUyE9CGHRodUI1hs0JmsEyIjL9T0g7Lc1ApeP
         TUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680294372;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sD8mbWj1kMVE8NzRJa8GWqijChuvu0jsth7lJ3hShYs=;
        b=T6HL46hIm54a9LoKdegC+t+vhWO6jy3E5KXtjbXeNyHXhFiZlnX7HizguTiI2aWBN+
         JchiDIWsAI78bvD9JbP8mNvdCIx7FYFXDIK1jLpg87duT0TSf2nN9u39jbPI6TlW1Xq8
         /4akr2mtUnR60QEMI7VJadHBM2a8iimVGg6SzLHHqVACjJijTW4/EzaAtgPrQnh2PjAB
         NYb+fAlS+FiAPJ0Aiio4Ew/rnDyiOwHSQICX5BGitl0OhFUCTetsc8GD5MPyYH8b08S3
         eK/6acrpDEuoNmQ7praRCH+25D/nScBbn1ln9Nm4DFJhoLL8Qpau3anLyjH2MlxVg0kf
         w9kA==
X-Gm-Message-State: AAQBX9eruXisYL2xGoDBvvldpF4v06Y1LXKdYvlimsWJzqptsjkDeRNd
        58BByIAC8Yv5v06rOYm7JKebDA==
X-Google-Smtp-Source: AKy350ZoqkfOym6kDy4v6Y7zmE6e+052nVQHu0OjlVY4UkTg7CgHAQygrVoeUE2G15qnU7ATKWsL5A==
X-Received: by 2002:a05:6512:3902:b0:4ea:fa77:e424 with SMTP id a2-20020a056512390200b004eafa77e424mr7644042lfu.65.1680294372326;
        Fri, 31 Mar 2023 13:26:12 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id l28-20020ac24a9c000000b004db508326c0sm508811lfp.90.2023.03.31.13.26.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:26:11 -0700 (PDT)
Message-ID: <6f57a806-231a-3145-1ce8-1b2a7e3c1e78@linaro.org>
Date:   Fri, 31 Mar 2023 22:26:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/2] ARM: dts: qcom: sdx55-fn980: Move "status" property
 to the end of node
Content-Language: en-US
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        andersson@kernel.org
Cc:     konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230331145915.11653-1-manivannan.sadhasivam@linaro.org>
 <20230331145915.11653-2-manivannan.sadhasivam@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331145915.11653-2-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 16:59, Manivannan Sadhasivam wrote:
> To align with rest of the devicetree files, let's move the "status"
> property to the end of the nodes.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../boot/dts/qcom-sdx55-telit-fn980-tlb.dts   | 20 ++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

These are cosmetic changes, so we should not do it board-per-board (see
recent Alex's commit).

Either two commits (one for entire arm32 and one for arm64) or per SoCs.
But not per-boards.

Best regards,
Krzysztof


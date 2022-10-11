Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3DF05FB3E4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 15:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiJKNwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 09:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiJKNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 09:52:12 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFECF816AC
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:52:08 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id m14so16913121ljg.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OxR0v/ndmgcsuPzjbLqOmbbrMc5VOEhwcb79QANVAz4=;
        b=WGNbpXLjvtsfc6Vl/bpIgYFr7RbCrUSyueqiIkBrdO4N13nbo7UgKj8f7cm4SLA0H5
         +5j6MxF9UVldncMF4puCTaGJc7HNrDwhAQaHYL/PtOsOad8+BF0ottFg23+ckx+ZjFKu
         KutT5bjxxLPFeos9GSXNTfCGuTDB2ohVEMGHlCq7dz1NG25KzGzZ5+kSgq2BqikIpQlv
         xaXgF8O5ZYdLMjT6hDSsjUJDMUN12Fd9NcnFNzVB5aUlAx87v1K/fS3faIi8TCiu3RQP
         w+Q4FKbfxlSDLvtrxI6TwcON9CCLVY7DjcAE/mCNPLbAMBc89+SDcYvKp3Ct0lfmML+u
         GN7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OxR0v/ndmgcsuPzjbLqOmbbrMc5VOEhwcb79QANVAz4=;
        b=RjwJMqFwBphnUs68XlDR2sg0dqScMF8b92DoEJzKnhl8kwuOapiLZlNFWfZb7RCfzI
         1m9Hjh1wbFaAPPOD2GAV6qM/6mkCSFxRC0lbUXeuqgBToksCcwIWZkymwHUEp532JDmT
         gxh5p7+HsFDUt1vbyEHi0qWhpT8MFsIa1eXz1j1SNpF3Vzf8Z1nALM5JDOG6M1OXjPPi
         C5R1Z3PKdEMYKc0nG6Trtxth0ZM9Z/wciga2aztx7gfradm+pC8aYoruBTyCtCf8vQsT
         wQqKTPu200tilYkGPNuNGa1SiWfalZo86iWvZrJfUGTRYAfU2uJ2UoQlmaXsNcfdaFHX
         AAdA==
X-Gm-Message-State: ACrzQf2ZBG6mVR7HfxdLaKkovzaAzeeybMGA91Vo6vTBX8dH1a6+OMc1
        3wYeOVhaJMV4NAJDfabyQa4xqw==
X-Google-Smtp-Source: AMsMyM4/nklHTLz3p+xybaJMzzzkzXVdaYKrMfraaF3FGyJLTenKKTwePcIZcpcEqfuOYsZHIydRug==
X-Received: by 2002:a2e:95d2:0:b0:26f:b14a:d639 with SMTP id y18-20020a2e95d2000000b0026fb14ad639mr2680183ljh.57.1665496326864;
        Tue, 11 Oct 2022 06:52:06 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eb98a000000b0026c47426cd0sm422510ljp.140.2022.10.11.06.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 06:52:06 -0700 (PDT)
Message-ID: <44f43f88-508c-d2d0-197f-f0e37d3bdd1e@linaro.org>
Date:   Tue, 11 Oct 2022 16:52:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 01/13] phy: qcom-qmp: drop regulator error message
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221011131416.2478-1-johan+linaro@kernel.org>
 <20221011131416.2478-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221011131416.2478-2-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 16:14, Johan Hovold wrote:
> Regulator core already logs an error message in case requesting a
> regulator fails so drop the mostly redundant error message from probe.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c        | 3 +--
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c | 3 +--
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c         | 3 +--
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c          | 3 +--
>   drivers/phy/qualcomm/phy-qcom-qmp-usb.c          | 3 +--
>   5 files changed, 5 insertions(+), 10 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


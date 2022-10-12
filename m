Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC2E5FCC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 22:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJLUrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 16:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiJLUrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 16:47:36 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA318FF234
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:47:32 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id f9so22019442ljk.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 13:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRi07UGE41OwqQfpU78z2swnPD/UtUjDseXmNlB/AVs=;
        b=HNsQRbXmlY3u6rH7OV+pp5MZo1KXdAWVRcn5faiUXkVpoe7E8AdjKH7ERheNRJ21hY
         s26KiCsDTKOsifZPdzlALNJlPK8d2bnHxV1rA/6OXr7aL13b2DY8XzCiYq3Ut7CkBZQS
         QtqoJsr/PXwQ2H9LtO+3ULlJGT1h1hxd2NHZh+zHvam+xTcevX/Nf7nDmr2ntkbY9xSf
         InA+z+yEw8am6oWvheIyAHm33rVwwtESEM/rORjU8GHxzkkrx2a84prw0frXQ0NZUZaY
         /YnOq5rY4fHQBiXry49t/QzAgWapIcLIR9MruPWN6B0oi8B0FF64tfvFoyCdkCcKOdMj
         LIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRi07UGE41OwqQfpU78z2swnPD/UtUjDseXmNlB/AVs=;
        b=5h+5bZjOCvd/arOei9QTTkLCWY71oYf0dZg+6xCPuQjmYrugu/gleJsQxAFmZbmDRs
         XdlNRjVxCjC/GYX6lHxOqOTCRrD8n63VxgNTEqagLuqo85tghU8Ce34Kssc90x5jkybt
         rXu4PQrYgeJmw4sSTpS/5nkEL/hZcDkMNkxHbrAobMnRFClXSc690XuXhfWnub0pXF8R
         F5St7CELNx3FLWQtBeaR92o07mRfRJuMmkB8xJ8HB6Gq3y97R5gT5bWSLJEteNdFvFAC
         n+AP0awDgYxMQj4BpsL7V3cNWC7Ts3RctduuKrxamniR6xXymBITE580H6v0iuWlozE7
         kLXQ==
X-Gm-Message-State: ACrzQf1oDwQ9+9uQjk1vRXprp6w2jxXCnVk8uom28DkX8ELE6EZLcEWL
        DtqVhvgSiIxS93a5wj63hmkp+Q==
X-Google-Smtp-Source: AMsMyM6TPgGEwHy/lPNlSNdyqSHU9MouHQlSUyHWi5kf+3eAyyX7PbeF0PNOhjFNRRp0f0gIwqV9IQ==
X-Received: by 2002:a2e:984b:0:b0:26d:ff5f:53c6 with SMTP id e11-20020a2e984b000000b0026dff5f53c6mr11466123ljj.59.1665607650922;
        Wed, 12 Oct 2022 13:47:30 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id 14-20020a2eb94e000000b0026dd4be2290sm108011ljs.90.2022.10.12.13.47.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 13:47:30 -0700 (PDT)
Message-ID: <8e39d242-9b88-6a33-384c-00fe5dad4a17@linaro.org>
Date:   Wed, 12 Oct 2022 23:47:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 06/20] phy: qcom-qmp-pcie-msm8996: clean up ready and
 status polling
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221012084846.24003-1-johan+linaro@kernel.org>
 <20221012085002.24099-1-johan+linaro@kernel.org>
 <20221012085002.24099-6-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221012085002.24099-6-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 11:49, Johan Hovold wrote:
> Clean up the PHY ready and status polling by dropping the configuration
> masks which are no longer needed since the QMP driver split.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   .../phy/qualcomm/phy-qcom-qmp-pcie-msm8996.c  | 19 ++++---------------
>   1 file changed, 4 insertions(+), 15 deletions(-)
> 
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209A46267B3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 08:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiKLHjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 02:39:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiKLHjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 02:39:16 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38EB27B23
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:39:14 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id d6so11408540lfs.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 23:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B3rJhIFR1mK2yHxMMcxFO8jz+qe9h76vXF9R64i7TOU=;
        b=w9SSLDRAXqi5Uj5XgcgIbxPK/g3Xj/OLGH6H8zMIcZYZ2gicerSghhMI2KsppTD1RB
         LIHgl7foTOGi8XtmjCV9aOLbIgMEUOMqVwoe7smsh3YMAQtrvyeGzoJ9vr03RCTsSFq2
         Kpbmz7VBGDwX91Vmf/nMpCBg4DTpGPTJhRmjAHEo+gBf0treSRRwBdXzzNBdbBNiJ2rg
         ZU8CQppU+XaKWiXnJLND1welt95RGxcU7Wn62lQ66q/RXugR93UGtAv6xpQIvMkC17kL
         ubWBOWsaGnlCAGu9x/46NqGQT2oldpAyttNvEPU62yipYFoUEJPYNA71NOkt8kqumSYa
         4G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3rJhIFR1mK2yHxMMcxFO8jz+qe9h76vXF9R64i7TOU=;
        b=oc1rzR7HWKEt+PFlsGYBn7oV7BAmPDij8Y04QUFMlNYrA52iaZti5pK4kP9kgk/wXQ
         4eka2y9nHxBZQmg7/8DZKlUoiVUAGMRS3ZOQKBVNDIeva6c1xC0WRiWWQwYjbadAUY7H
         R2R0VQTscSZpKr+/g+yjmfE6dwpRCFidfKGk3bxiNSHbUui8IIqkGocnD8Q4uic/rFjQ
         hPWYer01LdPELo5u4xWfmuMHO/CiPtsmTDzsyQI+VyECs9YwCViesvVL6oAOoVB+0pZ1
         ApUXvHbeSxBaZoK8acl/gv4MX0OWn1sywn3jp35ob5GS3qQujixEmdf/DuGAM/zwA5ia
         prdA==
X-Gm-Message-State: ANoB5pmE0N4HKlIKABpWIkHgsBvcR4NNehz7nljtJRjeKCjA45JA60Ol
        dcM1Wmd53VGfNZCtRBoRSmvpZQ==
X-Google-Smtp-Source: AA0mqf62E0O1VTd1yn+byHz2PeVxx7XBq5J+K6rXGTklbKKVcIj/WRrGa/mTnyxgJe1vhxjf43IzNA==
X-Received: by 2002:a19:5e4b:0:b0:4a2:46f8:24bc with SMTP id z11-20020a195e4b000000b004a246f824bcmr1688117lfi.180.1668238753043;
        Fri, 11 Nov 2022 23:39:13 -0800 (PST)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id u26-20020ac25bda000000b004aab0ca795csm736999lfn.211.2022.11.11.23.39.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 23:39:12 -0800 (PST)
Message-ID: <56752623-d865-2848-3132-4df769a31d39@linaro.org>
Date:   Sat, 12 Nov 2022 10:39:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 16/22] phy: qcom-qmp-combo: add DP configuration tables
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20221111085643.9478-1-johan+linaro@kernel.org>
 <20221111085643.9478-17-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20221111085643.9478-17-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/2022 11:56, Johan Hovold wrote:
> In preparation for merging the USB and DP configurations, add dedicated
> pointers for the DP serdes and tx tables to the configurations.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 45 ++++++++++++-----------
>   1 file changed, 24 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 499368e19e00..b27d1821116c 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -816,6 +816,11 @@ struct qmp_phy_cfg {
>   	const struct qmp_phy_init_tbl *pcs_usb_tbl;
>   	int pcs_usb_tbl_num;
>   
> +	const struct qmp_phy_init_tbl *dp_serdes_tbl;
> +	int dp_serdes_tbl_num;
> +	const struct qmp_phy_init_tbl *dp_tx_tbl;
> +	int dp_tx_tbl_num;
> +

I'd prefer to have DP-specific instance of struct qmp_phy_cfg_tbls here 
instead of having separate dp-specific fields. WDYT?

-- 
With best wishes
Dmitry


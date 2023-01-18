Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C3E6712A9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 05:34:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjAREey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 23:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjAREeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 23:34:46 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31B2539A5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:34:43 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ud5so80379089ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 20:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9QRiqEIm/55SzWiod6J1S0tN8S9gHuqwPIfY3LIUzYE=;
        b=CkQ+nrOAkSuCp7mMrD3K8TzSBuvsFxd2aXjwpTLPYTAkNV16EF5Z6NGuL0SdCyqF3Y
         b8dVqPf6pVcRtIHzg0ddcGEJ8R72DWRX40wLruO9IUtwo02lmr36z0aj45JOpKoKrcZ9
         AiYWHjFlZPErZb8FSbFNnQ5sNI0O+HN3yGLHfpgwqmuPstOZ7GwZDegGt3EwlCUfDsg8
         qqFF35IK18d49bkLp9b7TpH2Vk4XdEPneiueBJldHD/XcIb0H04RDrjjizEmy0K7VJpC
         xDsPZKtFU3f7j05ngH3ojWbAPu3fGrVjT1CVv6jHmEIkFIca1qlnr7Ic4TdsN8chI5s1
         1cjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QRiqEIm/55SzWiod6J1S0tN8S9gHuqwPIfY3LIUzYE=;
        b=mqBmB+JhAjmkYnsGkyG2i+aYTqnyv+OlTkRkZnwKx2PJvdLrtTyxozBviCueFgUwgJ
         oS+gHwxzwIDrckQGqsHpHRiMExAm6BUkVuHKvAll+LeO+Yjvvc5OAPeXJcI4Eksubgk2
         rLY8igW6S7qNuyFxk9pTHZWqTjmVPNBRCQQ5Kfufw4apZQdVf5WEN5+LN+ZxFDXtyxQq
         CHBVuZ2CpeYJGOQIDHX46epVm7EncMp1oxsBlEY9oBM2/kLSrS+aobYekNnaNnU9FNZM
         wP7GPQYiB+uJfsdI/wuYn4CEOszxPAFQvoFuL1EB2Ym/vZ5Ac1X6CbTGOld2sIp/WFGu
         sszA==
X-Gm-Message-State: AFqh2kp+Dk8A10uPO7w86uTFouGLmYQJwTaEXhQ9wuUzqa0sJlWBtPNX
        tMvRQzF07QxPWMAmuhWj+MGZOw==
X-Google-Smtp-Source: AMrXdXu2NLT2a5zzlRnQMmqm67QQgZ3iKnxMMDzynioxIR+84++bUki1rW6n724CqDRQgXpq66VxZA==
X-Received: by 2002:a17:907:9b06:b0:872:f259:a7ea with SMTP id kn6-20020a1709079b0600b00872f259a7eamr5343432ejc.53.1674016482610;
        Tue, 17 Jan 2023 20:34:42 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id l2-20020a1709063d2200b0087276f66c6asm1872325ejf.115.2023.01.17.20.34.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 20:34:42 -0800 (PST)
Message-ID: <7fe0c49e-a628-8e76-8294-ab8faadb3a70@linaro.org>
Date:   Wed, 18 Jan 2023 06:34:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 8/8] phy: qcom-qmp-pcie: Add support for SM8550 g3x2
 and g4x2 PCIEs
Content-Language: en-GB
To:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230118005328.2378792-1-abel.vesa@linaro.org>
 <20230118005328.2378792-9-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230118005328.2378792-9-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 02:53, Abel Vesa wrote:
> Add the SM8550 both g4 and g3 configurations. In addition, there is a
> new "lane shared" table that needs to be configured for g4, along with
> the No-CSR list of resets.
> 
> Co-developed-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/phy/qualcomm/phy-qcom-qmp-pcie.c | 369 +++++++++++++++++++++++
>   1 file changed, 369 insertions(+)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> index bffb9e138715..6f82604bd430 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-pcie.c
> @@ -1506,6 +1506,234 @@ static const struct qmp_phy_init_tbl sm8450_qmp_gen4x2_pcie_ep_pcs_misc_tbl[] =
>   	QMP_PHY_INIT_CFG(QPHY_V5_20_PCS_PCIE_OSC_DTCT_MODE2_CONFIG5, 0x08),
>   };

I see that the last two patches still use 'shrd' a lot. Does this 
correspond to hw register names or is it just a vendor kernel code 
convention?

-- 
With best wishes
Dmitry


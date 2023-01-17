Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0528966E113
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 15:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjAQOmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 09:42:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjAQOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 09:42:11 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10743D0AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:42:10 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s21so1141056edi.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 06:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hc75TyffO25aVJYo/DlU/tvU9zvgJb8khhzScIUOhmU=;
        b=sdCkItfiGOKGlz4qq5AkoHv3WRIzQLHfvVV3TZJf+ek+OQtXNYCbzA1FgwjlpA0GNS
         5sC0DyfMJ7iB1Jph0oWojgsoaSULER/wDj0F0DuNNDKZOzrPI+8ZKEbxiADF/xdDXZIz
         ONCnd9N7/zb9dN7lYy+KukSz/SGBCqMpgIGlFPecV48O2q8aNjXC6fvov6z9c/JYOA1S
         bKWoPuekTbSTjrWLqO88N3GtiDgz+5O4LlcotXmFginUw9BVzdWHQ+4FSz+Za+KDVk7W
         kuv5KHAZyaJ+xnuiimq9NU9w2p940PM4TE/zn1C2t0t8SXWhFs6vC+Zypfo/YBPScOfa
         xNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hc75TyffO25aVJYo/DlU/tvU9zvgJb8khhzScIUOhmU=;
        b=trVMf3ISAHUoZyOiTckt+LNJElcH7kRQ24xKpiXhr+XdnfBTyGkaOPEViuN1kwuCd+
         /hPiPwZNgZJzG94yfxP5NL74X59p4M1ksVdUquCqVvdyy6BvClWcciqDXJNF3AXGOvDc
         eWRCmEwSwQQsB33ZxWpKiGjhOMhXbKoC8RD9xXOmsAtPQ6/1Tffw44ffqR8Z1Avc6C+N
         XSEpmJ7kpMDyhyq0O0lf+IW9v0OmJgP05nVG5HpjTrRUnxqOE/FP5fPXxy8a6FwR7l/R
         FvU0RfctUig0Wtnb4UT/KjJRPzKHthnaGVMc569NH4IBWlhY1UwOM0d/cC53HkDpn2B2
         WfNA==
X-Gm-Message-State: AFqh2krQB8CzUE0CegQ04Hy1xwrrwDTBmyHldvMMpZky8SHWcEyy3Ufl
        j7G2264953aBEi8NF4T50OOO2w==
X-Google-Smtp-Source: AMrXdXswfLZjseblqDDfG3SABRK5o4w3rIGxnxPRJ/o9FT4Mp4F/UAxJuJ2olnpJUzBUKNUP4UFvkw==
X-Received: by 2002:aa7:c052:0:b0:475:dddc:374a with SMTP id k18-20020aa7c052000000b00475dddc374amr3407422edo.18.1673966529432;
        Tue, 17 Jan 2023 06:42:09 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id a8-20020aa7d908000000b0049dfd6bdc25sm3805154edr.84.2023.01.17.06.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 06:42:09 -0800 (PST)
Message-ID: <61be8f36-7171-dbc1-94ec-7e77438b37f5@linaro.org>
Date:   Tue, 17 Jan 2023 16:42:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 4/6] phy: qcom-qmp: qserdes-txrx-ufs: Add v6 register
 offsets
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
        Johan Hovold <johan@kernel.org>
References: <20230117142015.509675-1-abel.vesa@linaro.org>
 <20230117142015.509675-5-abel.vesa@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230117142015.509675-5-abel.vesa@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 16:20, Abel Vesa wrote:
> The new SM8550 SoC bumps up the HW version of QMP phy to v6 for USB,
> UFS and PCIE g3x2. Add the new qserdes TX RX but UFS specific offsets
> in a dedicated header file.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   .../phy-qcom-qmp-qserdes-txrx-ufs-v6.h        | 30 +++++++++++++++++++
>   drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       |  2 ++
>   2 files changed, 32 insertions(+)
>   create mode 100644 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> new file mode 100644
> index 000000000000..6238dd2b8421
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-qserdes-txrx-ufs-v6.h
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2023, Linaro Limited
> + */
> +
> +#ifndef QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
> +#define QCOM_PHY_QMP_QSERDES_TXRX_UFS_V6_H_
> +
> +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_TX			0x28
> +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_RX			0x2c
> +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_TX		0x30
> +#define QSERDES_UFS_V6_TX_RES_CODE_LANE_OFFSET_RX		0x34

Emty line please

> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE2			0x08
> +#define QSERDES_UFS_V6_RX_UCDR_FO_GAIN_RATE4			0x10

Any chance to doublecheck these two values? I think that 
UCDR_FO_GAIN_RATE2 is 0xd4 (according to phy-qcom-ufs-qmp-v4-cape.h from 
msm-5.10)

> +
> +#define QSERDES_UFS_V6_RX_VGA_CAL_MAN_VAL			0x178
> +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B0			0x208
> +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B1			0x20c
> +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B3			0x214
> +#define QSERDES_UFS_V6_RX_MODE_RATE_0_1_B6			0x220
> +#define QSERDES_UFS_V6_RX_MODE_RATE2_B3				0x238
> +#define QSERDES_UFS_V6_RX_MODE_RATE2_B6				0x244
> +#define QSERDES_UFS_V6_RX_MODE_RATE3_B3				0x25c
> +#define QSERDES_UFS_V6_RX_MODE_RATE3_B4				0x260
> +#define QSERDES_UFS_V6_RX_MODE_RATE3_B5				0x264
> +#define QSERDES_UFS_V6_RX_MODE_RATE3_B8				0x270
> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B3				0x280
> +#define QSERDES_UFS_V6_RX_MODE_RATE4_B6				0x28c
> +
> +#endif
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> index 110d8fb9309f..a5cdd58c5b4d 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs.c
> @@ -27,6 +27,8 @@
>   #include "phy-qcom-qmp-pcs-ufs-v4.h"
>   #include "phy-qcom-qmp-pcs-ufs-v5.h"
>   
> +#include "phy-qcom-qmp-qserdes-txrx-ufs-v6.h"
> +
>   /* QPHY_SW_RESET bit */
>   #define SW_RESET				BIT(0)
>   /* QPHY_POWER_DOWN_CONTROL */

-- 
With best wishes
Dmitry


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7CA60E479
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234560AbiJZP2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234392AbiJZP2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:28:15 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1107012FFB3;
        Wed, 26 Oct 2022 08:28:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id t10so2133589oib.5;
        Wed, 26 Oct 2022 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I52e8ODL6d9B8EPRm/dUTW74AdI5aoJaumLitDlvZ6A=;
        b=TCGJaytyonLlG2s5MM7nkXzRTgnxXVr1fxSlda8NdtOcRVTRJckOVfxRUHKlfXidbT
         7CSYB8u306NsZbY4mYYjkHaL066sPa6ac1eD3nR6wMs5IMBYWpJxV26Kzn+hfPMoxsTV
         Br8IAnWzHfl9MrSgx4QBy97vTK1WesetQ822j63wX8WZN72hT1u2el/9RGVF7Y2+N94y
         lxDv63Wej2BexvlYzJi/f0yetJzOWzfeAAXX1+9NUmcyt4e7iiay5OIhvrWvx4+EK2gu
         3OmvBuGZoHmwnA0Jg8G/9sHGK8s86YVlauEZERPCKmClwjM25uxn7ssldZxSA/GyaaP4
         ZPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I52e8ODL6d9B8EPRm/dUTW74AdI5aoJaumLitDlvZ6A=;
        b=FeiT2mRLvLcW/rzOMzfEUxOp4zuIJG1wM6HWT9oNpi8fYied003Xa7txduSb/6m9mO
         nEp27301zto3n45Bl2itr3/ucXSxdu7OyXWGbBK0dxKp6BuXlTCCc+4OHbeCM1incTzM
         XOqLTIM2HRgKytV1GkPVM4GWFTQmSmJva0gMPp36unRxngkCT082N1ZplCZQJOGnemp7
         1SbWZ+gGV1kCTkiseD79c706wPzl4wjIImHNpi1qyxs/L5OE/baDcnglYpyua8I6cFts
         3nU71Z+6eyy4YHu+vCfch9YyuE5fNywQkvMuFOMhEmt28YKvZIOTj85z/7OvkZWmR5VP
         Ze6A==
X-Gm-Message-State: ACrzQf0qub60j30vp3kVnXRk+WQtX+VmeflkXtHG5BzYeUpvr5ooibdc
        2G7bqmDy3BiwOV/Tk0hTjMg=
X-Google-Smtp-Source: AMsMyM6mMHxk11uO0qF4YLsns5seilyn+6912mbQNgsFsprQcpvhyji6wOCpNbMuTzELpP8eQSt1dw==
X-Received: by 2002:a54:4404:0:b0:354:4ac7:45ac with SMTP id k4-20020a544404000000b003544ac745acmr2168239oiw.133.1666798094325;
        Wed, 26 Oct 2022 08:28:14 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d3-20020a0568301b6300b00661a3f4113bsm2240634ote.64.2022.10.26.08.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:28:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Oct 2022 08:28:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Runyang Chen <Runyang.Chen@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        nfraprado@collabora.com, angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [RESEND v3 2/3] dt-bindings: reset: mt8188: add toprgu
 reset-controller header file
Message-ID: <20221026152813.GA2971664@roeck-us.net>
References: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
 <20221026063327.20037-3-Runyang.Chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026063327.20037-3-Runyang.Chen@mediatek.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:33:26PM +0800, Runyang Chen wrote:
> From: Runyang Chen <runyang.chen@mediatek.com>
> 
> Add toprgu reset-controller header file for MT8188
> 
> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  include/dt-bindings/reset/mt8188-resets.h | 36 +++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>  create mode 100644 include/dt-bindings/reset/mt8188-resets.h
> 
> diff --git a/include/dt-bindings/reset/mt8188-resets.h b/include/dt-bindings/reset/mt8188-resets.h
> new file mode 100644
> index 000000000000..377cdfda82a9
> --- /dev/null
> +++ b/include/dt-bindings/reset/mt8188-resets.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)*/
> +/*
> + * Copyright (c) 2022 MediaTek Inc.
> + * Author: Runyang Chen <runyang.chen@mediatek.com>
> + */
> +
> +#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8188
> +#define _DT_BINDINGS_RESET_CONTROLLER_MT8188
> +
> +#define MT8188_TOPRGU_CONN_MCU_SW_RST          0
> +#define MT8188_TOPRGU_INFRA_GRST_SW_RST        1
> +#define MT8188_TOPRGU_IPU0_SW_RST              2
> +#define MT8188_TOPRGU_IPU1_SW_RST              3
> +#define MT8188_TOPRGU_IPU2_SW_RST              4
> +#define MT8188_TOPRGU_AUD_ASRC_SW_RST          5
> +#define MT8188_TOPRGU_INFRA_SW_RST             6
> +#define MT8188_TOPRGU_MMSYS_SW_RST             7
> +#define MT8188_TOPRGU_MFG_SW_RST               8
> +#define MT8188_TOPRGU_VENC_SW_RST              9
> +#define MT8188_TOPRGU_VDEC_SW_RST              10
> +#define MT8188_TOPRGU_CAM_VCORE_SW_RST         11
> +#define MT8188_TOPRGU_SCP_SW_RST               12
> +#define MT8188_TOPRGU_APMIXEDSYS_SW_RST        13
> +#define MT8188_TOPRGU_AUDIO_SW_RST             14
> +#define MT8188_TOPRGU_CAMSYS_SW_RST            15
> +#define MT8188_TOPRGU_MJC_SW_RST               16
> +#define MT8188_TOPRGU_PERI_SW_RST              17
> +#define MT8188_TOPRGU_PERI_AO_SW_RST           18
> +#define MT8188_TOPRGU_PCIE_SW_RST              19
> +#define MT8188_TOPRGU_ADSPSYS_SW_RST           21
> +#define MT8188_TOPRGU_DPTX_SW_RST              22
> +#define MT8188_TOPRGU_SPMI_MST_SW_RST          23
> +
> +#define MT8188_TOPRGU_SW_RST_NUM               24
> +
> +#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8188 */

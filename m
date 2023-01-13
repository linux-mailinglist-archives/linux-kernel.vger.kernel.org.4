Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7355669600
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 12:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241435AbjAMLvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 06:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239755AbjAMLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 06:51:15 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B39E1A822;
        Fri, 13 Jan 2023 03:45:08 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id az7so20813828wrb.5;
        Fri, 13 Jan 2023 03:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jn2+fCHl5ad18BYclTOTd/dWOtO4Qcidi7ooXugxCNQ=;
        b=GS3kERsiiAD8MQz1KiiAaDhKe1WJ+iBm9SjGh2QWZZYbCE1EzGzfumiTO88BBNSkAi
         Q+RAVpaO7n1uTFgTnBCmsb3BRoh3ytBvrDF81ddV6XKevC1O/Q7xabgIxvH6guBsg9DK
         lDqyo+jPJpdg1n9P3KJvfu+pnzQETtAFPpvopSqo4Fxuxo7qfF/EoUcwJK9s8Ehy//WJ
         wuXUXMEw6D2LThQnGJc9o0nMRN4rjA/nreRDExeBtz0i1wU7MpDAPYFk+z+dMoyORkH8
         MkjoiZSMXLxgrI88yAwxdrUTz+GpyZwpaR/Jig/lnzZ0L5KurNn7slGxFQGtv+lM0nwU
         aJHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jn2+fCHl5ad18BYclTOTd/dWOtO4Qcidi7ooXugxCNQ=;
        b=eEYT4B+v2wNEr9hePoVsXwjRX5xpW4hXF3CktRXX1q8ZMJpV/MuKZsE4NVkBsz7M4T
         wr//l1Er79Kgxwo+LJBzXoUPlLhq/T6RG7D95USWInhGwHA0D2bWJ/3rBYgmaBx7vBRx
         etxcgEsr/hEtIKkIoN8HjYo2J7GNUtbgRoH4N4cRUcc8MTXIIaT4qznZH54kJSJcSuCU
         FXRn3TQBCiH5dgkrsdGpDctgInuJ/BcQGW4Zwn6ACwrXyUtNmbYMugfL0UEKMU8Qzhz2
         cskWlLBb+XVAcLuMtq91hRfnUp6ITSdrNPFJgvU+9wadvvijgj9GUIjrMbLPsSC+BZMv
         5UNg==
X-Gm-Message-State: AFqh2kr08n/ryxdtfrWY+AxCGAjbyWhS1Up37AP56exzfhkb3+qght3s
        ThNaAcz0c+Kovd/VeNnI/uc=
X-Google-Smtp-Source: AMrXdXtfcJLQrWeIUr4UDN6ImK6x+hSR/nhLfjBfN+6jtiLjGDc4A5OGvU9xqAwrDkqqZLh6yaSVoA==
X-Received: by 2002:adf:e7cd:0:b0:2bd:d782:c2b8 with SMTP id e13-20020adfe7cd000000b002bdd782c2b8mr3630527wrn.29.1673610306993;
        Fri, 13 Jan 2023 03:45:06 -0800 (PST)
Received: from [192.168.0.30] ([37.222.254.155])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b0025e86026866sm21956492wrs.0.2023.01.13.03.45.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 03:45:06 -0800 (PST)
Message-ID: <1e5d5341-4ed4-0333-a56d-673f8342aeed@gmail.com>
Date:   Fri, 13 Jan 2023 12:45:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v10 3/6] arm64/dts/mt8195: Add efuse node to mt8195
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230112152855.216072-1-bchihi@baylibre.com>
 <20230112152855.216072-4-bchihi@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230112152855.216072-4-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/01/2023 16:28, bchihi@baylibre.com wrote:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> Add efuse node.
> This will be required by the thermal driver to get the calibration data.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   arch/arm64/boot/dts/mediatek/mt8195.dtsi | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195.dtsi b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> index 5d31536f4c48..09df105f4606 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8195.dtsi
> @@ -1380,6 +1380,12 @@ pciephy_glb_intr: pciephy-glb-intr@193 {
>   			dp_calibration: dp-data@1ac {
>   				reg = <0x1ac 0x10>;
>   			};
> +			lvts_efuse_data1: lvts1-calib@1bc {
> +				reg = <0x1bc 0x14>;
> +			};
> +			lvts_efuse_data2: lvts2-calib@1d0 {
> +				reg = <0x1d0 0x38>;
> +			};
>   		};
>   
>   		u3phy2: t-phy@11c40000 {

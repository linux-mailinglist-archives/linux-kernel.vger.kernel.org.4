Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC0C6CA174
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjC0Kac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjC0KaH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:30:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756E9180
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:29:59 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso4763829wmo.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679912998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KYfSIoKXNS3sSCXkM4mLPOnfFyH+Y/o4nva0Ic4Cwk0=;
        b=dcns/R16IPSR9+8Qx4l91dTXHIf7FlZWe9GoJ6MSG9DAgpQUHXBvQf3iS3ONcMn6nH
         eFHmciA8dwxEBu7xf32wW4b3HGloLF6XIwRk6nM7qCG4pJ8zZTP5FT8GG6KeV9bezVKO
         ppDzdYI7Ve/fQ5s2K3kEUKJ/eEGdXOZxn4vbDjoYcRnIrZ7X7lrDYve0ovs6dhf5KqYC
         qJ5hKC+eEJw3RFo9XKgTRDJO9aXJ+4JLSti0Ot3SMHJSb+34ucfZwyY3dYHHmKHzRxeD
         F+5qKTMcbu36DlU6w1uro8ymsJMAgWyIzp+PXXTcJEMUybyPB1Ggb0prNSIEf4e9PX/H
         vmgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912998;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KYfSIoKXNS3sSCXkM4mLPOnfFyH+Y/o4nva0Ic4Cwk0=;
        b=iCqIYnS+WqCWWrFMbqdaO71ZUOriTYFcelKNkDF/r3WGv2vz0UUuei9rLOiyN2RgfX
         PHqVTFCAoyR5ukAGt2lI0JLO+npNV9ytRo2DOW/760Af9Fcr8ziFAvtd3WfiMo/jkok+
         t5Tj+gEd5y9mrbvMjGgk8GXHLwBc7FRzMVHSihVcd5zbK1IYz5KD5Q36JktJopbYaUpW
         5MzwTr/uAUmUBGBR4uoVVQNIAJ/Zk+Tq2Q+TZ5/g2JwhkDzEag19nHMwVGPCGnk4oMdj
         XLJwv96waPzjL2rBL9s9bH5HqlZTBSZpI/Gb7VYbfMhG8KuA79JbUmM5++UbL1UEa0C6
         b00Q==
X-Gm-Message-State: AO0yUKXBnplo9JiEcwTLLf1t5uY1s4hZ21MDbfMhwzo+N+FRU1YyQZiB
        ieqyg4xHVZyNeBKFFPnovgQcEA==
X-Google-Smtp-Source: AK7set/smYnMthy48xIiehT+4wd3+HCmKMpGIq/8zhn9DCMe/nzn+LRCE19xdyNlP+eMMFDqVvbXNw==
X-Received: by 2002:a05:600c:28b:b0:3ed:5cf7:3080 with SMTP id 11-20020a05600c028b00b003ed5cf73080mr8752590wmk.5.1679912997970;
        Mon, 27 Mar 2023 03:29:57 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.91])
        by smtp.gmail.com with ESMTPSA id s17-20020a7bc391000000b003ed2987690dsm13210822wmj.26.2023.03.27.03.29.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 03:29:57 -0700 (PDT)
Message-ID: <a17cd888-ef4d-ced0-adba-c6a6abdba51a@linaro.org>
Date:   Mon, 27 Mar 2023 11:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 1/2] mtd: rawnand: stm32_fmc2: do not support EDO mode
Content-Language: en-US
To:     Christophe Kerello <christophe.kerello@foss.st.com>,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
References: <20230327094742.38856-1-christophe.kerello@foss.st.com>
 <20230327094742.38856-2-christophe.kerello@foss.st.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230327094742.38856-2-christophe.kerello@foss.st.com>
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

Hi,

On 3/27/23 10:47, Christophe Kerello wrote:
> FMC2 controller does not support EDO mode (timings mode 4 and 5).
> 

commit subject and message should be in imperative mood, so I would
change the commit subject to "mtd: rawnand: stm32_fmc2: Remove
unsupported EDO mode" and the message to something like "Remove the EDO
mode support from as the FMC2 controller does not support the feature."
Extra points if you describe what happened when you used timings mode 4
and 5 with the current version of the driver.

Miquel, could you add Cc to stable when applying?
Cc: stable@vger.kernel.org

> Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
> Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash controller driver")

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

> ---
>  drivers/mtd/nand/raw/stm32_fmc2_nand.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> index 5d627048c420..3abb63d00a0b 100644
> --- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> +++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
> @@ -1531,6 +1531,9 @@ static int stm32_fmc2_nfc_setup_interface(struct nand_chip *chip, int chipnr,
>  	if (IS_ERR(sdrt))
>  		return PTR_ERR(sdrt);
>  
> +	if (sdrt->tRC_min < 30000)
> +		return -EOPNOTSUPP;
> +
>  	if (chipnr == NAND_DATA_IFACE_CHECK_ONLY)
>  		return 0;
>  

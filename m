Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34B93656108
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbiLZIMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiLZIMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:12:40 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7117D25F2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:12:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ja17so7190687wmb.3
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=js3TL2/kH+RzQ+7Oe4DwrXCAreJ1aNAmnn2LZazzYwo=;
        b=PHdhoPdZtHYI2ghJY6uGIZywGaGEMzyqhtRWz40QquY8smrCoTYirmYRyVu8NQ3+5H
         TrZ/hD+Ol5ko06NlaWeenllzBjW+VfC58WO84kLQmqibQLoxXsl00/Jy43s+//aJHAIa
         YKLWeTYqdDJjrmst4sp9n303Q1XYsWU/htHYglV4HEVc0HJJbBmDH7U7CL4N8q2xVdlc
         e2OG/RIXEq8tOkulZ22fPfxLxEzA6MNE64k4IEymX8ebkkPbsFITZosdM6xUHmc9K+7H
         Zj/rbzKaaaf2Gsi36GlDNaEFuC3FL/rCT0CxZ9THd6SYSRJYq1lJYj7JsOkHIPT7l0ol
         B3IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=js3TL2/kH+RzQ+7Oe4DwrXCAreJ1aNAmnn2LZazzYwo=;
        b=BwBaTw5iUITyO67VjVxWeCzXn0fbedk7c+QPYR4xkBYnhumoKaA+tTpqPqJUxU4GUr
         1wMIkc9eQD+Kb9OaMzQs6xVuaw7g4uLvezjSHBwdIywKJyu+7RuAysTI8gHB2AvcCfMI
         K2P8y5dvRtgPDi36gtoIs01NN8y2Z1+aQTZyLJVZvqben1VqLY07k8DglIni8eiOHwP/
         uklBGrhBwPr8plNWDqxrmJoY+bQAr9azOGguFNsRLOYsEe3S4Ko/OgQA4NyXwjQgYK30
         cf+o/HD0DXZV69wqSl6XUxK3uREIRIBFwlA0gf28CFTwMer7cst+WPhbve0sboH+/e3k
         YgbQ==
X-Gm-Message-State: AFqh2ko+kSxUFH5sOz8VNBRLFXSRFUCN/80uHAGNske7rfBIyFSQYy0A
        49hIDfnfhmhLuCB+2gZoi58Q3Aj58U2ipbV0
X-Google-Smtp-Source: AMrXdXsA+uuMJEwFKRlNagP34/tJNyQWWRlvs8dMhh/8qVYj99EBXMb7AI5f3rCsUW6ZK6Coke+epQ==
X-Received: by 2002:a05:600c:1d98:b0:3d3:48f4:7a69 with SMTP id p24-20020a05600c1d9800b003d348f47a69mr14559450wms.17.1672042357994;
        Mon, 26 Dec 2022 00:12:37 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id bg12-20020a05600c3c8c00b003d1e34bcbb2sm14553916wmb.13.2022.12.26.00.12.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Dec 2022 00:12:37 -0800 (PST)
Message-ID: <590af263-8278-5fb3-10c1-341b609a77ec@linaro.org>
Date:   Mon, 26 Dec 2022 10:12:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/3] mtd: spi-nor: Extend SFDP 4byte address
 instruction lookup table with new octal modes as per JEDEC JESD216F
Content-Language: en-US
To:     Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Cc:     greg.malysa@timesys.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "open list:SPI NOR SUBSYSTEM" <linux-mtd@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20221202135539.271936-1-nathan.morrison@timesys.com>
 <20221202135539.271936-2-nathan.morrison@timesys.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20221202135539.271936-2-nathan.morrison@timesys.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good.

On 02.12.2022 15:55, Nathan Barrett-Morrison wrote:
> This adds the new bit fields for
> reading: 1S-1S-8S, 1S-8S-8S, 1D-8D-8D
> programming: 1S-1S-8S, 1S-8S-8S
> 

We usually aim to have ~60 chars for the subject line and 75 chars per
line for the commit message. If you want to reword both, fine, otherwise
I'll do it when applying.

> Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
> ---
>   drivers/mtd/spi-nor/sfdp.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/sfdp.c b/drivers/mtd/spi-nor/sfdp.c
> index 2257f1b4c2e2..e4e87815ba94 100644
> --- a/drivers/mtd/spi-nor/sfdp.c
> +++ b/drivers/mtd/spi-nor/sfdp.c
> @@ -953,11 +953,16 @@ static int spi_nor_parse_4bait(struct spi_nor *nor,
>   		{ SNOR_HWCAPS_READ_1_1_1_DTR,	BIT(13) },
>   		{ SNOR_HWCAPS_READ_1_2_2_DTR,	BIT(14) },
>   		{ SNOR_HWCAPS_READ_1_4_4_DTR,	BIT(15) },
> +		{ SNOR_HWCAPS_READ_1_1_8,       BIT(20) },
> +		{ SNOR_HWCAPS_READ_1_8_8,       BIT(21) },
> +		{ SNOR_HWCAPS_READ_1_8_8_DTR,   BIT(22) },
>   	};
>   	static const struct sfdp_4bait programs[] = {
>   		{ SNOR_HWCAPS_PP,		BIT(6) },
>   		{ SNOR_HWCAPS_PP_1_1_4,		BIT(7) },
>   		{ SNOR_HWCAPS_PP_1_4_4,		BIT(8) },
> +		{ SNOR_HWCAPS_PP_1_1_8,         BIT(23) },
> +		{ SNOR_HWCAPS_PP_1_8_8,         BIT(24) },
>   	};
>   	static const struct sfdp_4bait erases[SNOR_ERASE_TYPE_MAX] = {
>   		{ 0u /* not used */,		BIT(9) },

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA4675BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 18:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjATRsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 12:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjATRst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 12:48:49 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D98388746
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:48:41 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r2so5513467wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 09:48:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=usZwUafmssHHjBMbZ97d1dp/H4o4iCVGkXuyEhBu/eE=;
        b=Xk8v6S4B9l/1/rZC5Acfrnhs5lgw/5B2wVyXT0iRjq2/6CzwmVk2HVGvuCnXq25YXm
         7cXqKvaFgFecajORnMSICkCtzhDysvIuMaPZJ94snTgQGUbtynCWhpOtJmthFeTgqkJn
         llBYq1ZjfKp4J1H0YZJfFqVXXGwTAq1xXzPKWxBCDC6HCQfgYdlxa0QDpYlkmhZB6SBy
         YisYi/DGL2scYRLQwGhRtDm6Ze9Mp2Odt8idZOLZCMsASSiqCankWGGxlzgfMiSmbLEe
         ENPMDZ6CzrCrFOb7UgoyE58gi+nHNarCy+wsA7liMfKbFz8pYZ4jVL2MIz8Lm5451MHV
         QoQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=usZwUafmssHHjBMbZ97d1dp/H4o4iCVGkXuyEhBu/eE=;
        b=5kwQ3+ZSRrfDln0frAJxtYs/qh7/F8aja2Dufv1ui4oBveP/gpykwrQrPq15wKffp/
         wUQFswtPMBiomhb89FB7RhqGlgj3HAjKGpidM4S8uK+WITanzzzbfKguSImiB5q/52cl
         0aeR1fKZwx7lH8+9cGYpgAdOKJWqTkBdL1gwx6jKSoKcRtaGMVjzS4wmzRWoNakeSV8z
         rS5WgMcqDrj+WRP26d/kSISNCwAtpLm9urlpp282+OTqNwwqjbKAM3Ek/bsi5orPhEgn
         HUfgLomw+FwS2FIhcdGs4o6ZG8IPZRTQ8YS2WSeARTPLD1psj3q6RnrrngpN80o355ON
         FDlQ==
X-Gm-Message-State: AFqh2kqnpeA/SFYtwzUI3F+2HEsJuoSRl8dweGMIjJYLHGftwE83nawp
        fiAtSiyvr5ltGlXwLvMl8MraQg==
X-Google-Smtp-Source: AMrXdXuScCkgBt6ufGU4Q+zUCLg+jabHQ01J+OwfTLnAkLy8rziGHZ9jITRpp+e1sZ2s8g6Fe6Q6EQ==
X-Received: by 2002:adf:e70a:0:b0:2b5:90e:cfa5 with SMTP id c10-20020adfe70a000000b002b5090ecfa5mr13962181wrm.29.1674236920097;
        Fri, 20 Jan 2023 09:48:40 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id r12-20020a5d4e4c000000b002be1d1c0bd7sm9540535wrt.93.2023.01.20.09.48.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Jan 2023 09:48:39 -0800 (PST)
Message-ID: <ae73ae73-3c5f-d8dc-fda8-0916c976a835@linaro.org>
Date:   Fri, 20 Jan 2023 17:48:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] of: property: fix #nvmem-cell-cells parsing
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robimarko@gmail.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Peng Fan <peng.fan@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Aisheng Dong <aisheng.dong@nxp.com>
References: <20230110233056.3490942-1-michael@walle.cc>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230110233056.3490942-1-michael@walle.cc>
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



On 10/01/2023 23:30, Michael Walle wrote:
> Commit 67b8497f005f ("of: property: make #.*-cells optional for simple
> props") claims to make the cells-name property optional for simple
> properties, but changed the code for the wrong property, i.e. for
> DEFINE_SUFFIX_PROP(). Fix that.
> 
> Fixes: 67b8497f005f ("of: property: make #.*-cells optional for simple props")
> Reported-by: Peng Fan <peng.fan@nxp.com>
> Signed-off-by: Michael Walle <michael@walle.cc>
> Tested-by: Robert Marko <robimarko@gmail.com>
> ---

Applied thanks,

--srini
>   drivers/of/property.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 8d9ba20a8f90..95b838185b2f 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1202,8 +1202,8 @@ static struct device_node *parse_prop_cells(struct device_node *np,
>   	if (strcmp(prop_name, list_name))
>   		return NULL;
>   
> -	if (of_parse_phandle_with_args(np, list_name, cells_name, index,
> -				       &sup_args))
> +	if (__of_parse_phandle_with_args(np, list_name, cells_name, 0, index,
> +					 &sup_args))
>   		return NULL;
>   
>   	return sup_args.np;
> @@ -1256,8 +1256,8 @@ static struct device_node *parse_suffix_prop_cells(struct device_node *np,
>   	if (strcmp_suffix(prop_name, suffix))
>   		return NULL;
>   
> -	if (__of_parse_phandle_with_args(np, prop_name, cells_name, 0, index,
> -					 &sup_args))
> +	if (of_parse_phandle_with_args(np, prop_name, cells_name, index,
> +				       &sup_args))
>   		return NULL;
>   
>   	return sup_args.np;

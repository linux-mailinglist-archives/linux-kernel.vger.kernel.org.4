Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B719F691E59
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 12:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjBJLdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 06:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjBJLc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:32:56 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F8E71F2F;
        Fri, 10 Feb 2023 03:32:55 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id h16so4736864wrz.12;
        Fri, 10 Feb 2023 03:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSB2tORpEY7AFj6lkS5miPOljfi/Oe35Ina8RVx1G+M=;
        b=AnL7oOlwGYw2m2KHrKGYSTrurPx1qkJqcWP+jaHP+Xd4NBPcMS3LIG0NUQe8zJH+MV
         OaaVxiNJHXIlR1m296SK8NjK5a/TPeqQ72pzXwVsU5s2KOGE6CRNBxiX81XAe2FCyjxN
         SBZd+NrIy0IT8xHzZ2QZb5N1oULFnHGojz4GMoE9jPDFGrVFFzzc7Rtcg4U46w3dQeg3
         dUzTvfVbZxizhEVkxQDclwNDWS3Weob71EnWAa61sQ5+kWgkWfiQV0llXd0BvIWUNR8P
         g7kWzn/mnfboAh1X8zraJdB/PG87qGHDcVbaGxEZGkybeKDRJpCYVQ8n0dQYquSdDYum
         X49A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSB2tORpEY7AFj6lkS5miPOljfi/Oe35Ina8RVx1G+M=;
        b=LM6n6Aizk0X5WZw/AxG+2DcLlpimu+gU+aNjfXTojh0CN7MsJNqtCyWgC6k/476BkQ
         1PuDbVUsn9TqNbULAAVMO21gyYnKqpaHJ5r+TSpHEG1D2O3IY2Xfvb+vbJMBuaVBnEo9
         SaDBxwGhitSfnFuG+5TVPeeHBmOdQ28OSEesGYGgx3uKEdU/V5gCnkS+nBC4bOGx5JCw
         /HAxKiMhI1GbMA4j/iegpqQ86qhnHj2rdS3EhAdsGyi6vd+cuTTeZWvW+HdPiwb4rrh4
         nDG+T0NTHgBQ6wSYcmX9eTOoUTEOr9SbIslVcQft35ULd8Mi67uMU6MSGslKd2Mh6p3x
         RPhA==
X-Gm-Message-State: AO0yUKUfzsCUlAGcN5PaDNJJPuI3qwgM07rgoHvXHKTlsyUbTsaiOjFv
        /VxzeL3UoRSbzJxbcyaZjMg=
X-Google-Smtp-Source: AK7set9Cu9elcH6gpisnWD6MWr0EGRotDjpqGXMjkrCDhVwQARmchj+Gb21ZbvpCjBdk++FK4FDZQw==
X-Received: by 2002:a5d:6a83:0:b0:2c5:4a70:20df with SMTP id s3-20020a5d6a83000000b002c54a7020dfmr1342411wru.67.1676028773798;
        Fri, 10 Feb 2023 03:32:53 -0800 (PST)
Received: from [192.168.1.135] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h8-20020a05600c314800b003e11ad0750csm3576930wmo.47.2023.02.10.03.32.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 03:32:53 -0800 (PST)
Message-ID: <6f48f7a2-23d4-687d-5c9b-3a1561928ed7@gmail.com>
Date:   Fri, 10 Feb 2023 12:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] remoteproc: mediatek: Check the SCP image format
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230210031354.1335-1-tinghan.shen@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230210031354.1335-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2023 04:13, Tinghan Shen wrote:
> Do a sanity check on the SCP image before loading it to avoid
> driver crashes.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/remoteproc/mtk_scp.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/remoteproc/mtk_scp.c b/drivers/remoteproc/mtk_scp.c
> index d421a2ccaa1e..0861b76f185f 100644
> --- a/drivers/remoteproc/mtk_scp.c
> +++ b/drivers/remoteproc/mtk_scp.c
> @@ -649,6 +649,7 @@ static const struct rproc_ops scp_ops = {
>   	.load		= scp_load,
>   	.da_to_va	= scp_da_to_va,
>   	.parse_fw	= scp_parse_fw,
> +	.sanity_check	= rproc_elf_sanity_check,
>   };
>   
>   /**

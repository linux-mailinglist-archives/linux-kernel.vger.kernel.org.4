Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C8C682DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231881AbjAaNWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjAaNWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:22:42 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A92BB1;
        Tue, 31 Jan 2023 05:22:41 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n13so3314890wmr.4;
        Tue, 31 Jan 2023 05:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YqCcxNM0oQ47CTFQk6ypa9uV7hhok/zL4Fnr5q3moYk=;
        b=Eb5Fa0y2PKje90ynik0qDiPK88YhdfznviATz7/qM/4FIz3xdlMVVEtd992UzgLXlJ
         eWcHQG5o3DcWbVPUU4kQ3xiWQ5NfQwvPOore1j1lJ43bckFv7y+NPAFWJaj5Zt7NaFq+
         dxWOgpTw+xYAijDfamE/4nvRI5khcW55ctYWqLhA2Vr7NVgIXnOtPvJH/CN0DxJ/3yse
         wlTivATD30zwugRCrUiHvR/+x9iyXjKpQbDIAKasXiVvMv+O/gd/odXJ0lELg2Bj+EQY
         mC5rIkLghhqpDaubEtmL96JwT1i0autyAEvmPq1TjmOncsLh1cV/yUz1gsUUCuYgqvU2
         s3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqCcxNM0oQ47CTFQk6ypa9uV7hhok/zL4Fnr5q3moYk=;
        b=X6QeVsHSdvkT3sGu7EEjQoNoSybXQ7PLzqlJ/YdF8uVmJjP/NaiXuFohz4k05Vsx2E
         4Q6/DIji9tiXMMhqdOZ832xQaUSjslOiyFYAl+t4SeRrol4Kct2deuPh5J0y6V9IdtMT
         YbxzoKse8XVeVLrlyrBWrtplTgt92lMHQTrJ9zJ927UxS9RjgdBl/1mP1QojrzVhQoO3
         JGKKtCHW1H/bnWEV3xVe2ccOuYWCSeYdWqAihCtW23iKENDdAkmRAjwKDmga3lfhTBzN
         Jt6RNrR1bS0YZ36W4+qmN82sWhBjRG4Htr3cxguWbcKxXgSOBHqk3U/30lS0hfZgLolP
         bm4g==
X-Gm-Message-State: AFqh2ko/jQlgNReqzTDYNd8OnXkAt+wgRDXi473v49ItnwfrDuJM7Nq/
        VA3CsVXQLtr1YcCEGvRItRk=
X-Google-Smtp-Source: AMrXdXtixiVnQKlwB4dKIZTeavrQqJ0wcmz9Mhqv3aD7AfQaRe21JMjwNwp+cs2JCFFXcClem4ZelA==
X-Received: by 2002:a05:600c:1d8e:b0:3d9:efe8:a42d with SMTP id p14-20020a05600c1d8e00b003d9efe8a42dmr54310562wms.21.1675171359958;
        Tue, 31 Jan 2023 05:22:39 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id j22-20020a05600c485600b003cffd3c3d6csm15455120wmo.12.2023.01.31.05.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:22:39 -0800 (PST)
Message-ID: <618fb1ea-4f26-a8e3-21b6-b6a2017aa73b@gmail.com>
Date:   Tue, 31 Jan 2023 14:22:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 02/14] soc: mediatek: mtk-svs: reset svs when
 svs_resume() fail
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-3-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-3-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2023 08:45, Roger Lu wrote:
> Add svs reset when svs_resume() fail.
> 
> Fixes: a825d72f74a3 ("soc: mediatek: fix missing clk_disable_unprepare() on err in svs_resume()")
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 2df30a6bca28..a803b92afc3d 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1614,12 +1614,16 @@ static int svs_resume(struct device *dev)
>   
>   	ret = svs_init02(svsp);
>   	if (ret)
> -		goto out_of_resume;
> +		goto svs_resume_reset_assert;
>   
>   	svs_mon_mode(svsp);
>   
>   	return 0;
>   
> +svs_resume_reset_assert:
> +	dev_err(svsp->dev, "assert reset: %d\n",
> +		reset_control_assert(svsp->rst));
> +
>   out_of_resume:
>   	clk_disable_unprepare(svsp->main_clk);
>   	return ret;

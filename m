Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E7B682DBB
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:23:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjAaNXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:23:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjAaNXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:23:20 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6013065A0;
        Tue, 31 Jan 2023 05:23:19 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso10575536wmq.5;
        Tue, 31 Jan 2023 05:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DxqT2eMiEuxRnBsmwUs2D0qkIojDueG3BR3ri/bN6+s=;
        b=T0r+CaGMfGweUThdfbzF9UjIdg+qzhzE/zYh6nJZNGdLSuF7rhGCe/sqWeFbbj9UXJ
         6HZCUh2n4YYwdT8UM2o1P0Xa+C6cjlVSkEWjmbItKQkjkAbVI7aO8qMQAbA24Wu2CB1s
         uhTKIHauaE3ecoVYwDuXKqEOWTObc1/frP630Iy7a7XDeOeXwh3yH/kXn5SYKkNZNk4C
         SjxSpXbHuukH2d2s3HPUajJMdrOYIBeBxD1UjvcpCW56iMlg7wBWWJEwTIAvYdbiCAQd
         0XAQ23FH7De3Nfuj4ocYEC64wfhy/hSD5neChPhTISOjBnYKplKF3A2Q7LeJBaK03wFV
         KZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DxqT2eMiEuxRnBsmwUs2D0qkIojDueG3BR3ri/bN6+s=;
        b=sal6a9lvbaBNJ+F7XaXom0upEAVv8LuqMtfwJCfGIqmgfzUy/ZRfdI5SdKEq3cLavS
         78uVO5sCumV2Mq6mUSvzysfWL0AW3qkm8f9bmkL0D7IyPWmQZF8hbpS60HjO18lrZDzD
         GAhoYzlgpIXaPqO6+cnCagEVnbsOtcAucWN+d9zrHMVJaRt4eESmNj4y0i0YOKOBF6AN
         FSjsL+7j9DLUHAZw4SOzeCFcMn4FAnPKXleZMHaKyqkb1gmI87g9z+/HATXmn3JKEjYw
         pvAbxF8UPpbu6xoO4UlcbNuXj/e99HSMYjqQZo8sE3bzcaCUENp3mVOfePEH/P4HdIZa
         nU3A==
X-Gm-Message-State: AFqh2kqGHYLWiKOnfPrhvOKqHd3ZZ+gUTl+RQbpqR5C2NDcH+fiamkXk
        YSi/YJtlQPcnsNzryoR4btY=
X-Google-Smtp-Source: AMrXdXs90s3eq6X/sKbtmQ3mlK2owSJhgh00MP0sAFb6WKMS4+U9xyLsJ07GGTZiYY1iXwIChdaY+g==
X-Received: by 2002:a1c:ed0a:0:b0:3d3:4a47:52e9 with SMTP id l10-20020a1ced0a000000b003d34a4752e9mr54149073wmh.15.1675171397941;
        Tue, 31 Jan 2023 05:23:17 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id c1-20020a05600c0a4100b003d9fba3c7a4sm21354223wmq.16.2023.01.31.05.23.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:23:17 -0800 (PST)
Message-ID: <ad5e0eff-e043-2e27-d152-54f3047da0a3@gmail.com>
Date:   Tue, 31 Jan 2023 14:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 04/14] soc: mediatek: mtk-svs: Use
 pm_runtime_resume_and_get() in svs_init01()
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
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Shang XiaoJing <shangxiaojing@huawei.com>
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-5-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-5-roger.lu@mediatek.com>
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
> From: Shang XiaoJing <shangxiaojing@huawei.com>
> 
> svs_init01() calls pm_runtime_get_sync() and added fail path as
> svs_init01_finish to put usage_counter. However, pm_runtime_get_sync()
> will increment usage_counter even it failed. Fix it by replacing it with
> pm_runtime_resume_and_get() to keep usage counter balanced.
> 
> Fixes: 681a02e95000 ("soc: mediatek: SVS: introduce MTK SVS engine")
> Signed-off-by: Shang XiaoJing <shangxiaojing@huawei.com>
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 64d4d03ab71c..9575aa645643 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -1324,7 +1324,7 @@ static int svs_init01(struct svs_platform *svsp)
>   				svsb->pm_runtime_enabled_count++;
>   			}
>   
> -			ret = pm_runtime_get_sync(svsb->opp_dev);
> +			ret = pm_runtime_resume_and_get(svsb->opp_dev);
>   			if (ret < 0) {
>   				dev_err(svsb->dev, "mtcmos on fail: %d\n", ret);
>   				goto svs_init01_resume_cpuidle;

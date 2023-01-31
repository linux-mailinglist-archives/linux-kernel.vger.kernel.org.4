Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6605682DC1
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjAaNY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:24:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjAaNY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:24:26 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBC42FCEE;
        Tue, 31 Jan 2023 05:24:10 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id j32-20020a05600c1c2000b003dc4fd6e61dso5591925wms.5;
        Tue, 31 Jan 2023 05:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uYAnZ/YKKMZS0ESVTb/QD70EINljsBIpkmayN7aaRjY=;
        b=oThxhhvGEHzBRodyxvZhenx9d/DdJBBOrLzYg3WN6xin/pwCMuCMZSRjIJNX5tJl1m
         4WIsMGxZllazPJS8FWgre5+cUPGzId2umKrw2Mc0mCJRVC6P8tMi4syNXMiXZo0T5EzE
         3bFMu3IXVz+xwhzgWC24XZ0pM+x7sq+XW4CBkBtMUIcst9PGNMmj7As8gixEW4sGkXFv
         1xSljzi9FpAoxU99dDynD21Y1+wHmBhHxqvwguKmWkmMu9FnvxVdQZFPkjCWS5FQnvUb
         1zFXACdPYiEsVdB/qaSrqDomknSSnTkUFVffFWP72yjiOZCqN7WvxLO4y725cr+IYldH
         2sLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uYAnZ/YKKMZS0ESVTb/QD70EINljsBIpkmayN7aaRjY=;
        b=QxoM4U7ddLwo3YTJrNA6RwGoqHzyHGLAsiDDssGqGe1oZq6+ysYmfW9l5Wik6elwHI
         QHCKS7g9H/zPwyatugYJrO/4ijIOI8D1xlnWAIgcAJVY93P/yKF7C5PqmTTt1akv7wKU
         G/4ilJRh7bKU7VRuHvuFhapkbN128JgjEP5+zNdBfJQY0k3ywfDFk7j3zUCqFGqrywyF
         1qP4h11RmHjC+kjd6d2ZO8FJV/b5Ylycml+0FEQxaD5bDUecoIcsRp31dqgHbax8fzJX
         0CwiNDCVXMrHdqJIJtMkiTurZueSwRXxf5ZA+ovHJ4XFJJVom5Cf9gx2s0CiMxyfaQue
         9uqA==
X-Gm-Message-State: AO0yUKWHAryrG4aGTvL6L21yn65pcXP1nmmOJhuwOmLbdbgW9W3JitIt
        svNPSUAiNf6CtOy8zAWvhwd6MEmRvc4=
X-Google-Smtp-Source: AK7set+wO+ccUoqK04iTl8+nmE2aEHP+M+nzLL77INW0lcsGsDqoKdu7CQsLyWZX//2uQN7rA/neTg==
X-Received: by 2002:a05:600c:1d0e:b0:3dd:1bcc:eb17 with SMTP id l14-20020a05600c1d0e00b003dd1bcceb17mr3459855wms.28.1675171449053;
        Tue, 31 Jan 2023 05:24:09 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u20-20020a05600c00d400b003dc5343188dsm8198730wmm.24.2023.01.31.05.24.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:24:08 -0800 (PST)
Message-ID: <6ef5047f-5728-3729-ddcc-c3a90eeb0483@gmail.com>
Date:   Tue, 31 Jan 2023 14:24:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 07/14] soc: mediatek: mtk-svs: keep svs alive if
 CONFIG_DEBUG_FS not supported
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
 <20230111074528.29354-8-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-8-roger.lu@mediatek.com>
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
> Some projects might not support CONFIG_DEBUG_FS but still needs svs to be
> alive. Therefore, enclose debug cmd codes with CONFIG_DEBUG_FS to make sure
> svs can be alive when CONFIG_DEBUG_FS not supported.
> 
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

Applied, thanks!

> ---
>   drivers/soc/mediatek/mtk-svs.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index a3c84e819bc5..70ca9c9acae0 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -138,6 +138,7 @@
>   
>   static DEFINE_SPINLOCK(svs_lock);
>   
> +#ifdef CONFIG_DEBUG_FS
>   #define debug_fops_ro(name)						\
>   	static int svs_##name##_debug_open(struct inode *inode,		\
>   					   struct file *filp)		\
> @@ -170,6 +171,7 @@ static DEFINE_SPINLOCK(svs_lock);
>   	}
>   
>   #define svs_dentry_data(name)	{__stringify(name), &svs_##name##_debug_fops}
> +#endif
>   
>   /**
>    * enum svsb_phase - svs bank phase enumeration
> @@ -652,6 +654,7 @@ static int svs_adjust_pm_opp_volts(struct svs_bank *svsb)
>   	return ret;
>   }
>   
> +#ifdef CONFIG_DEBUG_FS
>   static int svs_dump_debug_show(struct seq_file *m, void *p)
>   {
>   	struct svs_platform *svsp = (struct svs_platform *)m->private;
> @@ -867,6 +870,7 @@ static int svs_create_debug_cmds(struct svs_platform *svsp)
>   
>   	return 0;
>   }
> +#endif /* CONFIG_DEBUG_FS */
>   
>   static u32 interpolate(u32 f0, u32 f1, u32 v0, u32 v1, u32 fx)
>   {
> @@ -2476,11 +2480,13 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_iounmap;
>   	}
>   
> +#ifdef CONFIG_DEBUG_FS
>   	ret = svs_create_debug_cmds(svsp);
>   	if (ret) {
>   		dev_err(svsp->dev, "svs create debug cmds fail: %d\n", ret);
>   		goto svs_probe_iounmap;
>   	}
> +#endif
>   
>   	return 0;
>   

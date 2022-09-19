Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8EA5BC5D6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiISJzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiISJyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:54:36 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E12026D1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:54:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id a14so31062409ljj.8
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 02:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=acfZNlSk6UDSUFER86iU5/oC+tWnJPYzNY85ToWvplI=;
        b=qfjkJOzXVYyBbWBcP7ScnhEr3K4rRvVk5rRFs1OF/IhXIcCx6uLOkHA2R32bWSNb52
         5caWhhw2LYFoBao51d6Yo0KY2AIBTSHg+QnKa7HxvTNoOshJ/tHBsHX38mjzLh0+H6Ee
         4fsyaEhlpXl1wpJC3pjQYWXzowXLs+gWWaVzVzDBYTxZ+nP41WOqMcEipwrL1zpuGxND
         p1m8qpVVRXkoNMN8xLi/+m7PY3PqdbA1YgMysj/KPnvPX5xxBZ9c2bxmGfWfnuNGf08t
         1n73JgcdGa+B9fnnGY1IKwJN1dgH675rZsofUMF2WwtMQ1f8K5lM9wlUgkjt0f1tKhrV
         6rwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=acfZNlSk6UDSUFER86iU5/oC+tWnJPYzNY85ToWvplI=;
        b=CWkBhP1MmpTWt4ScZtwBEPrtMCIMGhSmY49bALiORSF+wtbCYUrFFVY+DyL8tLfwys
         T2tIz0y1N4tzRtSbWDy3nMyuH4cWVA9d8o/OicALk6gaE/vQXATdDa7rgcneiZhyVIqe
         W2am9mMvnyPHQyWmWbLM+hDg6+uSzMOPaosaMw1U9O+EpEHc1jPKTGiVQ2czvNb6uhUA
         qpfani9Rsolifjrct+b/GwajVTAzxpyh/lBC5vm+DoeSX005h/LG0A+OmfrbJDOGNWAA
         xUhfKmecQ9ObUCu1jUCwMIuZicLa3bSep0YzKL6+rVkkfkgfiZa0HtBadQs8xShgDdq/
         FKpQ==
X-Gm-Message-State: ACrzQf3/H5zs05xYj93FDDisNw6MBwfAgaxueJ57SZTMrYMSOUL4Ew+U
        ZsX/5axM26Vnm1HSkO6rg1Y=
X-Google-Smtp-Source: AMsMyM5s1lURiFkaTiES2Do+Gp85hVbFMOUBWEtYF1ETax19T1vejZL/sH5OF3FW8EhMfG9KBBZ7oQ==
X-Received: by 2002:a2e:b893:0:b0:26c:22e0:716d with SMTP id r19-20020a2eb893000000b0026c22e0716dmr5260362ljp.48.1663581273645;
        Mon, 19 Sep 2022 02:54:33 -0700 (PDT)
Received: from [192.168.2.145] ([109.252.122.187])
        by smtp.googlemail.com with ESMTPSA id y11-20020a05651c106b00b0026c3e350682sm1347948ljm.14.2022.09.19.02.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 02:54:33 -0700 (PDT)
Message-ID: <7fe977b9-8e54-96cf-91da-49f0861ff945@gmail.com>
Date:   Mon, 19 Sep 2022 12:54:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 0/3] Refactor MediaTek DP drivers
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>
Cc:     Guillaume Ranquet <granquet@baylibre.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        David Airlie <airlied@linux.ie>, liangxu.xu@mediatek.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20220916133821.27980-1-rex-bc.chen@mediatek.com>
 <CAAOTY__g=s_ACd+zTJZT1HBbrLo-JpHbrwLsy1zKjxbM5c21uA@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <CAAOTY__g=s_ACd+zTJZT1HBbrLo-JpHbrwLsy1zKjxbM5c21uA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Chun-Kuang,

18.09.2022 06:17, Chun-Kuang Hu пишет:
> Hi, Dmitry:
> 
> My tree has no mtk-dp driver yet. Would you like to pick this series?
> 
> Regards,
> Chun-Kuang.
> 
> Bo-Chen Chen <rex-bc.chen@mediatek.com> 於 2022年9月16日 週五 晚上9:38寫道：
>>
>> For this series, we do some clean-up and fix a build warning.
>> This series is based on linux-next-20220915.
>>
>> Changes for v2:
>> 1. Update commit message in "drm/mediatek: dp: Reduce indentation in mtk_dp_bdg_detect()".
>> 2. Add fix tag for "drm/mediatek: dp: Fix warning in mtk_dp_video_mute()".

I changed commit message of the "Fix warning in mtk_dp_video_mute()"
patch to make it less noisy and applied all the patches to drm-misc-next.

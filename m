Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EF4564EC32
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 14:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbiLPNm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 08:42:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPNmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 08:42:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A22A74A59A
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:42:23 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h11so2488839wrw.13
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 05:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mYuHcMpMgTC0m3iMA8FpqMG9rZZG/4yzIXsxv8BzD4Q=;
        b=EQ1utNUBpT5/gARhtVgdXHHX5dnJdpE0FTA66+x9gIl2AV/cYPh9EpX3/UjPhp9I6L
         3FnOIfRonS3YzBsjsXT4Xf96/zP7RVrpypzlLYFEz5w+sb1VGTa32eHaHuo87sDVT3i+
         k163Amn9PAgGB86owOsajZTI+ja+dadyZXP2qfIeVS5XtTpuECHAiUjTChevkWjp+GzI
         PD57jDZ0phQc9+W5kIp7GmtSdttmURWpYZxHkegAzsNAMmXF1cpGwzuXiaP/3qyh9eHS
         v/gdaD+rUzwgsVpJCRcwHlLNxacKJ4tZGA9Ge6O+n7A49/yOZsY1DlcoNam2xc6kwgfb
         h53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mYuHcMpMgTC0m3iMA8FpqMG9rZZG/4yzIXsxv8BzD4Q=;
        b=nVOfi0aCXuZnNh8lyI7g8GLQvglXSycLuFulP0E8wCjGobGEcinUDCbxYHKlp7IW7J
         zFnawT/Q4aCmFFS3G4SjQTabVOfneWaU2RemBoQYQ88qRNnqNG5qEff5LNGCg4EgLvYa
         FFaoa2abYVebnUZjy8VA6ZBg30r4Wi6PMljizbPLUMSlGIjPQIBRWF3J4tmstepVikKW
         wDkr7ufQb4m2zHlM4Rq7KGd1uHbDFyjlXVWYhuJBBCj1NWlzOqJM/uwOK07Es1GDL2Fe
         NGjgN+l0npHq5SrBnUjIF4v9BuSG94QLAl/vQbxFd9pEAm5kc678gF4RLMOoCkdwx46Q
         sAUA==
X-Gm-Message-State: ANoB5pl8J0mzfUF0rJuCxtqE485+legbOhKiicxT9GFLlbKVYtOJ1/K5
        mPbIajDQRMCBJ4Xz66UQhnA=
X-Google-Smtp-Source: AA0mqf6ZT7g9UyCovA5LB7Bkyrd4TqhUMe5sC8xG/onVrq2Zeh9xkyJlD3lqy0IKnsxPZx63GrQ+Aw==
X-Received: by 2002:adf:d202:0:b0:242:ac4:4a0c with SMTP id j2-20020adfd202000000b002420ac44a0cmr27076278wrh.32.1671198142063;
        Fri, 16 Dec 2022 05:42:22 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b18-20020adfe652000000b00241d2df4960sm2369478wrn.17.2022.12.16.05.42.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 05:42:21 -0800 (PST)
Message-ID: <36ca8be4-511a-4d05-de36-0a1b0958f2a7@gmail.com>
Date:   Fri, 16 Dec 2022 14:42:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1] mtk-mmsys: Change mtk-mmsys & mtk-mutex to modules
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Hsin-Yi Wang <hsinyi@chromium.org>
References: <20221118063018.13520-1-yongqiang.niu@mediatek.com>
 <90c7e6f3-ecf6-bb90-5a9a-3fa1eb4b9d5d@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <90c7e6f3-ecf6-bb90-5a9a-3fa1eb4b9d5d@collabora.com>
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



On 18/11/2022 11:36, AngeloGioacchino Del Regno wrote:
> Il 18/11/22 07:30, Yongqiang Niu ha scritto:
>> Change mtk-mmsys & mtk-mutex to modules for gki
>>
>> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> 

Applied, thanks!

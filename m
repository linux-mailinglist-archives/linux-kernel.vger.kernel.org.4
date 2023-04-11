Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8FA16DDF6C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 17:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjDKPSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDKPRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 11:17:50 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8B56182
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:17:22 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id i8-20020a05600c354800b003ee93d2c914so5995439wmq.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 08:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681226192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rAnyItecZ2z9vvTCwvHtRvd7Qhp8m4rVZ2fhtqoSxcc=;
        b=QepIDv2vzF9TGg8dmBYgO94A8bpFE/PqwDzOxtq1+LXoNCGvxc5oFX54q7g0YGw4fh
         XNl0thFWuYEVCzGZWJF4qIxrhsZeeGxewEemTWbPZWHKeCN9hTUHBdQsM7Ptovz8wrKU
         fRVkOIKcFvFnQANanbeyYLkQ9/KNPy7JnWFLT0610SdpPpKvK6OMXEJPHyuqTb7O4YC7
         f5nABwZv5BKnIkIo+0FQTOTjqudu3ooBnbVC25bu+t3n3xWhZhBYRULf/ZzhXWhmdW1y
         LGHcx9w8yr7tWCrcLGZFdQC5YA5zn2CPtn7DE3rSmJjxrbMCOAomAO37DMsf75ZvmYfU
         l7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681226192;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rAnyItecZ2z9vvTCwvHtRvd7Qhp8m4rVZ2fhtqoSxcc=;
        b=8BunBwVjF9zlKQ8p0tE3QRQD4Rhuu4hTORhsSsOfiis8MkzaMKqCJziCLk7Rmfj+uJ
         vdFVwTFEReKB6rqlhOEt2w1tXWUCoHUnwM5oJX+c2kFHXDFiHFZT3a81Pl4B5IEvRo2n
         TrHNOiXxAatHF+mljxY1Td592ASLct3ogpf4ZKINk3JN7k32bTmuMaH+ncx3TjBI6Oxt
         FMlH8OIigiao3HyQCXqEK21d8Nnxlu+azKgcgX73sTTh3QQMbJqwZzAqF00xWoQhF1mR
         je324Otd1LNexiO/jaCihVY60pmwbOsI6Z4zuN9st+MWZ3mw6qwT6mcD0Q9lwnVf7jz/
         naRQ==
X-Gm-Message-State: AAQBX9flChaeH+eHCqwE/IO3By8PpDFe9tOVGzKu4chyz/WWBRsbK+YM
        UuTmS+TYP18RlIPnomJm/RVZg80CJdc=
X-Google-Smtp-Source: AKy350YYczj9vQgtR8p+/keGudnvll6ePlBxMOGhUVM9Wl5egXGj+Ti3qENcdSQ608cDRLSeGQmNWA==
X-Received: by 2002:a7b:c8c5:0:b0:3f0:85b8:ce6e with SMTP id f5-20020a7bc8c5000000b003f085b8ce6emr6511718wml.37.1681226192363;
        Tue, 11 Apr 2023 08:16:32 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id o11-20020a05600c4fcb00b003ebff290a52sm21212046wmq.28.2023.04.11.08.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 08:16:31 -0700 (PDT)
Message-ID: <c0f7b342-6dc5-10f2-cdc5-7af15d4d2fd4@gmail.com>
Date:   Tue, 11 Apr 2023 17:16:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] soc: mediatek: Kconfig: Add MTK_CMDQ dependency to
 MTK_MMSYS
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230403093304.276418-1-angelogioacchino.delregno@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230403093304.276418-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2023 11:33, AngeloGioacchino Del Regno wrote:
> The mtk-mmsys and mutex drivers do have a dependency on MTK_CMDQ,
> even though both can work with *or* without it: since CMDQ support
> can be enabled either as module or as built-in, it is necessary to
> add a depends rule in Kconfig, so that we disallow building both
> mtk-mmsys and mtk-mutex as built-in if mtk-cmdq-helper is built as
> a module, otherwise obvious linker issues appear.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Applied, thanks!
Matthias

> ---
> 
> This has no Fixes tag because the commit that can produce the issue that gets
> prevented in this commit is already in the maintainer's tree.
> 
>   drivers/soc/mediatek/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index d6b83a5508ca..a88cf04fc803 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -76,6 +76,7 @@ config MTK_MMSYS
>   	tristate "MediaTek MMSYS Support"
>   	default ARCH_MEDIATEK
>   	depends on HAS_IOMEM
> +	depends on MTK_CMDQ || MTK_CMDQ=n
>   	help
>   	  Say yes here to add support for the MediaTek Multimedia
>   	  Subsystem (MMSYS).

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B67729CEF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241132AbjFIOcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231752AbjFIOb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:31:59 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE2F3585
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 07:31:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f6370ddd27so2324132e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 07:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686321114; x=1688913114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J2y2HdDd7pDRhxkuoV0sN0tGmbLDSEWqGjjnTOPE8C0=;
        b=jv6QgWSWJK9B49CWVEjYYq8OTrViNl5tn0TnuYZDfsu7ddSU+eWiK7dM+r8VmImRu/
         XshjhX5j9vxKlqOl0yMQaJ6sZLpSyoYF5Cg5tWdMFmDHMvdSAFSeB4Gk1gvBhP5lKa+b
         oWEF7agXfNxGbkjTg/xUVaMx/Fr6ogU8wuPG4r4wv5eu4C6iOniTfmY0FI4Fcgf24eNy
         NAjZvyszlpElPHSUdDG9PZxH1/kuFOoblF7ReH5fJjeEMhe+wAerQq4idTebaiID9sAv
         A/qV7vZ1K7dzcC/UjVbaTWd9PtBC2J1mHDVOPErOGBG1665guAQLq8gBUqQWE3r5sqbg
         YOng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686321114; x=1688913114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J2y2HdDd7pDRhxkuoV0sN0tGmbLDSEWqGjjnTOPE8C0=;
        b=ZAmPkDJ7+JVvXNw11V+843ZAkFYvvRgkiBtRrzvxEGP+GFZ/3Mscu+EmLyQNq6T0Xv
         SfvpTrUmfCKQ+RWe3qSBG/U+1+SIsc7gqwHMLoF0UCMUTn1wodbg1bqZHv+VKlrKuyc8
         OHpZfr8xpdO6Jx7yP2w0sFzNpIbnAmhETQUJ3rjOrotVfMfp7YiaKSg0hA0QDBe2xfIp
         zDPjEPP2lqPLB8bkDmjCGZMmptDVsWM0081XK98uuyWzOUp4iEaxCM9HQ0SVH6bG8kp1
         Wt8ABG/pIT1wnWFV7o3L0ocu4eog83Ga8kO8YKcsv7N4BRt65TThD7lp6rvd2S/FzMNh
         9obA==
X-Gm-Message-State: AC+VfDyGPaRVSLgWtdyBO2I3+VmNt/BJJWOaTO1grdd/oxPKSa4aFQly
        T/QWCb4KlcFjGofAbvF8VRgJKSF9h0g=
X-Google-Smtp-Source: ACHHUZ5c+syomOcPl20/KiXNVGkRj8MpgvmbDUBaQd5g7W8c0gmKY1MCKxluMEQITPiWqgOL7sc/IQ==
X-Received: by 2002:ac2:5b5b:0:b0:4f3:a9d3:4893 with SMTP id i27-20020ac25b5b000000b004f3a9d34893mr1119113lfp.35.1686321114094;
        Fri, 09 Jun 2023 07:31:54 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c00da00b003eddc6aa5fasm2862276wmm.39.2023.06.09.07.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 07:31:53 -0700 (PDT)
Message-ID: <eed12356-4bc8-29a3-6105-b2bc65d74029@gmail.com>
Date:   Fri, 9 Jun 2023 16:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [RESEND 05/15] drm/mediatek/mtk_disp_ccorr: Remove half completed
 incorrect struct header
Content-Language: en-US, ca-ES, es-ES
To:     Lee Jones <lee@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230609081732.3842341-1-lee@kernel.org>
 <20230609081732.3842341-6-lee@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230609081732.3842341-6-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/06/2023 10:17, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'clk' not described in 'mtk_disp_ccorr'
>   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'regs' not described in 'mtk_disp_ccorr'
>   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'cmdq_reg' not described in 'mtk_disp_ccorr'
>   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c:47: warning: Function parameter or member 'data' not described in 'mtk_disp_ccorr'
> 
> Cc: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-mediatek@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/gpu/drm/mediatek/mtk_disp_ccorr.c | 5 -----
>   1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> index 1773379b24398..720f3c7ef7b4f 100644
> --- a/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> +++ b/drivers/gpu/drm/mediatek/mtk_disp_ccorr.c
> @@ -34,11 +34,6 @@ struct mtk_disp_ccorr_data {
>   	u32 matrix_bits;
>   };
>   
> -/**
> - * struct mtk_disp_ccorr - DISP_CCORR driver structure
> - * @ddp_comp - structure containing type enum and hardware resources
> - * @crtc - associated crtc to report irq events to
> - */

That surely suppress the warning but I think the correct to do here is to fix 
the documentation instead of deleting it.

Regards,
Matthias

>   struct mtk_disp_ccorr {
>   	struct clk *clk;
>   	void __iomem *regs;

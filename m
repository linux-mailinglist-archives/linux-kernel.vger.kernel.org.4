Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F35D74B2D3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232926AbjGGOLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjGGOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:11:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAABA2125
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 07:11:36 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fba86f069bso3138447e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 07:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1688739095; x=1691331095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Psajd6OVU6HONVcYwAF4k7kzKO1bSsPA0lwnR4yTjw=;
        b=k0jYnuzcSLleSs3obf+lLaCtWROeHyPhn8EWW6WP6AGps9GYnwmtxLqnWzko3Y7PZ8
         MGdMD7Lo5VgU6tDGINs34PTZC/AlLTPiP4yN3qypZ897dyhroZoNVbfW3PS51XY6EpeU
         Xzv2ErGjwfl9TtO6WYUHjBLOo2OLwswW86WIdgzvZmGpvaP4nyOC8TcKIGKeWLEgqA0i
         aSCnNlnqho0nUXKhKNTr64NdiMNmAPhbzW0q6jCamtjYfo0jACY8m3YfEM5cMAEC8nAP
         HmzSyD6zZBMsYmqIW6ZKqmHCzwp5AgoV62trz1lwlG2SeHg1NTc+olyPUN3iJnseb4qp
         S5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688739095; x=1691331095;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0Psajd6OVU6HONVcYwAF4k7kzKO1bSsPA0lwnR4yTjw=;
        b=Kiqd1oOvGYm7G7R0dD2oERNUz+HlI0TnrklHrtrMnTRNTFdary+CgJ/aD0Vsh1toAj
         TbWg0hl8klA+xz+hlexVXj5pP24K9j6YcvVxbG1rhTu1HNMAl9ANBYrHp0GYLc3Eg9wm
         ypzYBoQysbQJBTC9mH5tG1gaYRrhRE+0HufMPSbqbSC8lrBc3Qd+40z/EhzsvIIDeIH8
         T7RvjFym9HTY3r6NpeH2mOInGZgIRtcl1gr8+KtLkKVzJs2q4NuokWWw/6cllOa0Etsf
         Qbi1MWfE66BwGPNps2hCKD2Ltx4wc+rhhUuClKxPYAAymKhRA+T+PoIPIkDcEec7qhPf
         u/hQ==
X-Gm-Message-State: ABy/qLYwZVMVPUbdLJBYdV5JHByO8NO1wVjXM5Eid1shPE9VDT2KgvMR
        VK2eF1xf+/RzI7MpPmuBaniMRw==
X-Google-Smtp-Source: APBJJlGOrHsd3wpz2+GZmZI1MI3v3biMwXG7vAhqELyS89IGLyJw+nKLVuZO69fJqliUZgxCRzWo9g==
X-Received: by 2002:a05:6512:3e9:b0:4f8:6d53:a68f with SMTP id n9-20020a05651203e900b004f86d53a68fmr3527714lfq.64.1688739095027;
        Fri, 07 Jul 2023 07:11:35 -0700 (PDT)
Received: from [192.168.1.172] ([93.5.22.158])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bc8cb000000b003fbb618f7adsm2577638wml.15.2023.07.07.07.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 07:11:34 -0700 (PDT)
Message-ID: <538096d2-7b24-e1c7-706d-4d4f952d35eb@baylibre.com>
Date:   Fri, 7 Jul 2023 16:11:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v2] media: mtk-jpeg: Fix use after free bug due to
 uncanceled work
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>, Kyrie.Wu@mediatek.com
Cc:     bin.liu@mediatek.com, mchehab@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Irui.Wang@mediatek.com,
        security@kernel.org, hackerzheng666@gmail.com,
        1395428693sheep@gmail.com, alex000young@gmail.com
References: <20230707092414.866760-1-zyytlz.wz@163.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230707092414.866760-1-zyytlz.wz@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/07/2023 11:24, Zheng Wang wrote:
> In mtk_jpeg_probe, &jpeg->job_timeout_work is bound with
> mtk_jpeg_job_timeout_work. Then mtk_jpeg_dec_device_run
> and mtk_jpeg_enc_device_run may be called to start the
> work.
> If we remove the module which will call mtk_jpeg_remove
> to make cleanup, there may be a unfinished work. The
> possible sequence is as follows, which will cause a
> typical UAF bug.
> 
> Fix it by canceling the work before cleanup in the mtk_jpeg_remove
> 
> CPU0                  CPU1
> 
>                      |mtk_jpeg_job_timeout_work
> mtk_jpeg_remove     |
>    v4l2_m2m_release  |
>      kfree(m2m_dev); |
>                      |
>                      | v4l2_m2m_get_curr_priv
>                      |   m2m_dev->curr_ctx //use

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEDE606225
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 15:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJTNrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 09:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiJTNrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 09:47:37 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B6B1A7A0D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:47:36 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l19so13517558qvu.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 06:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfoaDvIHm+IYqFg1zUd7jQMQTXkElPWTcNgvljK5gOA=;
        b=XZcIHHMg1dkhD0LgOjy1iBpji/JY8TckG64n7iRLwcdhSP6mWFjkTQpve5ROlxVx9R
         z3ZyWgENFeFwmcNNpiAZ1rDDt9xTH7+vV+O6iybz68MR5IU+kPJ431BoBfarnd5CmCIh
         m75Z0BY/2hll7ZDl3b3Bh4n4rSxv4lRaLGtPBpTKUb2qvOdPzfWtblSDpGZaD0W4Mw2M
         z9gRZjdMTSNCJwui0gk4X6RdyStQm2ePgb6Lcfcv6MYPB6W0n8bmVA/ntbrAweNTsex0
         cXFzrKKM9b/6jfDMmxw59mkngKBzHtv3T/Z3jv2aNVReNceJF2AAp2FYF6w8Xx0cCk/X
         1YpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfoaDvIHm+IYqFg1zUd7jQMQTXkElPWTcNgvljK5gOA=;
        b=gTU86PWpNG5dDD26p7pzfZRQTthiu33SF6MHb3FOlDLbBKDLh+IYCGwFMuwpjoiLjt
         k/dsB8l7BUV0e1A6u/9MnZPuuPqr+gyiU7B1+puKvFrx9yWjRHJLH8SpERc+kkvWZRzq
         t2E31zfNvcykgL0wZfv3veqCqlFTcSxNe9Ch5n4XRiS11anN5PbGbKGJWUQWCkhZSbK5
         8bN6VJDDOP6zvJA8eph96FhKbua9wOlGgctsXtFpmCYZkaiMroXZt3fZNj2IZQ0PCo52
         aISzO/y8MegfH9rFz1DzCVA99SHKh4rkhf8MyE3aPvQpgue7ckOM8kvsPmcULSr+nMDm
         WarA==
X-Gm-Message-State: ACrzQf0BRG/XGzJPNL9PKfR0vOHnypdfNgRMmJLK1wSa1BQGgcezZdOX
        ZRZeyRi9dwNdad7UHc5LiOzNhg==
X-Google-Smtp-Source: AMsMyM5sOIvVtFC130aKpuulDJA8HBv+YuVvL3HoTNZOe6dhDsx7M2SccxP4xCX5/6e1vhY5fApY1w==
X-Received: by 2002:a05:6214:c68:b0:4b2:31c5:78bc with SMTP id t8-20020a0562140c6800b004b231c578bcmr11137347qvj.45.1666273656040;
        Thu, 20 Oct 2022 06:47:36 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id gb11-20020a05622a598b00b00398d83256ddsm6107388qtb.31.2022.10.20.06.47.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 06:47:35 -0700 (PDT)
Message-ID: <883c9095-f304-1b8c-2f4f-a2151d8e1d1b@linaro.org>
Date:   Thu, 20 Oct 2022 09:47:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v2,1/2] dt-bindings: display: mediatek: dpi: Add
 compatible for MediaTek MT8188
Content-Language: en-US
To:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, ck.hu@mediatek.com, jitao.shi@mediatek.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <1666266353-16670-1-git-send-email-xinlei.lee@mediatek.com>
 <1666266353-16670-2-git-send-email-xinlei.lee@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1666266353-16670-2-git-send-email-xinlei.lee@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/10/2022 07:45, xinlei.lee@mediatek.com wrote:
> From: xinlei lee <xinlei.lee@mediatek.com>
> 
> For MT8188, the vdosys0 only supports 1T1P mode while the vdosys0 supports 2T1P mode in MT8195.
> 
> So we need to add dt-binding documentation of dpi for MediaTek MT8188 SoC.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


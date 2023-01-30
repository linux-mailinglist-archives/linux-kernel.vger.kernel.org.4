Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D820680CCA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 13:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjA3MEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 07:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjA3MED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 07:04:03 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D9310ABF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:02 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so7979905wms.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 04:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U4k/Nc+vbxM1mE6/adaioEXR7QTUOYEWnVbj4IhswtU=;
        b=kUVVk0Qo3KVIzL0lbkWQGeoXMGZLnOmnIBkOywzB3qf6dCsF7RxVxMu4san75cEg/W
         tUoXfvlDKLrDvVxvZDaXy7j+ZQXKjujcuBzMBbNnWILBMgjaQ2ZHvr1FJLCogUMo3MTQ
         9/JqstAUzQzcK98MeszrwfL6oJDjtjC83cp8QTUqkWlbtJ8v5ufBAWafuTvO6azfZYVC
         s58Rtf0pb4KbnPxnaKab5Vs3B5TjnCy4k8LwKEj/zysJaiLxSVdKJlsCCrxoiVjuRCil
         V6L7TH50uTrB9qyN0y1dSHGxTW0dkMHyEgfvH5jcFRCq2sMTmWmHJazuUk4oUSUrpJY2
         n6kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U4k/Nc+vbxM1mE6/adaioEXR7QTUOYEWnVbj4IhswtU=;
        b=ekthXKgqRSb8F8EjuTWAMjpSmst7sp0mHXZyLiOzQgxPA8J706wtSYm72hubXL0VPb
         HptU/q0xrzpfYaofAEZ9B2qfuzIntWFaRvkFLd7xoM1Wu2+Slz8ufMSQOndG8XYjpHUb
         SykZoxm6vfuvQMwpc7N+0oQCL3kMXcEupJOkKK/chZOk2pZV6lGVubJqvgsYKkhYjSGG
         Z7c+7QUkVftI6qNIWsIgb/nvvNt7hi5YIILy35kfMw0M2YbrGwOlmdW6hp6JHLhHMCmO
         /h8B7tRIgE5/II+/qGlYRKFoSrWdUKGc34P6kmruQcj+YtmGUpiyid5n6vNDt+3ORM4Z
         7PBQ==
X-Gm-Message-State: AFqh2kqgG9bbQQtfbdm5wTXXdSmDlhrENEdKFGiOswnnL9W0yekHN9EJ
        Mp4bIXmtcrPJY/2D8mU6Xe5Scw==
X-Google-Smtp-Source: AMrXdXszvEIL/pKpL72DqLBqbSkAybsWNTlkDzADohEONJssb8T5yk+kO3rPc5tPFLreuiK5WEAq2A==
X-Received: by 2002:a05:600c:5390:b0:3d9:a145:4d1a with SMTP id hg16-20020a05600c539000b003d9a1454d1amr46068952wmb.34.1675080241399;
        Mon, 30 Jan 2023 04:04:01 -0800 (PST)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n10-20020a05600c180a00b003daf672a616sm12320077wmp.22.2023.01.30.04.04.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 04:04:00 -0800 (PST)
Message-ID: <30201eff-0339-da85-cf01-d0001af0d03f@baylibre.com>
Date:   Mon, 30 Jan 2023 13:04:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] iommu: mediatek: Add support of unmanaged iommu
 domain
Content-Language: en-US
To:     Alexandre Bailon <abailon@baylibre.com>, yong.wu@mediatek.com,
        joro@8bytes.org, will@kernel.org
Cc:     robin.murphy@arm.com, matthias.bgg@gmail.com,
        krzysztof.kozlowski@linaro.org, robh+dt@kernel.org,
        iommu@lists.linux.dev, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230130102722.133271-1-abailon@baylibre.com>
 <20230130102722.133271-3-abailon@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230130102722.133271-3-abailon@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/01/2023 11:27, Alexandre Bailon wrote:
> Currently, the driver can allocate an unmanaged iommu domain.
> But, this only works for SoC having multiple bank or multiple iova region.
> This updates the driver to also support unmanaged iommu domain if
> MTK_UNMANAGED_DEVICE is set in the iommu id.
> 
> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

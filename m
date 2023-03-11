Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 834BC6B5C61
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:44:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjCKNoz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbjCKNop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:44:45 -0500
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33431241FD;
        Sat, 11 Mar 2023 05:44:43 -0800 (PST)
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-176b90e14a9so9017402fac.9;
        Sat, 11 Mar 2023 05:44:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542283;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j0hyUN2C7BZ8jVZKqrrryijZX/Ej18OXHW5ztfQohzY=;
        b=6lj/G15qfcviqe0MRynAm+h55PrAZLhnmqKRoTJzQd3NC4oWvcEn1xooc3pt9fGfZW
         g9j4zQfChPrmgqdoaBrtf18xJxEehnnTTZwNhnAQ401k01I359xBqhXow1nOvXGyDbjX
         pnJObwV777VAol8uDxuGzcnNR8M8euv5eZ9Fg+2y5ckjuO6k/GiIiNlRVroA1YsAWNOu
         bGY/wu2IXmaXDVlkpb34HmAbD5yYk2nFAaawSlqmwzHGj9i0idUj03hqm7yPppdYxU2o
         TXaEArREQW/HlwJzLRw86xu6OUEQZwGCRC8J07gxwJ/0orEKZ4BEpk6/IrsDLGBSgAQy
         em5Q==
X-Gm-Message-State: AO0yUKWkpdQ2f+IZTNx2GFRkm8dpjmQizpgFKNxZi7NSwJjE2/jhtJYK
        GjhG1vnC5lRsrTtHwLpY8g==
X-Google-Smtp-Source: AK7set/rLkaFClc4znKPpav+nzsqeHO94LkJ+fiEk32awaq55tpq51tK/F2CMuYjeMLhY0UjRz2QOQ==
X-Received: by 2002:a05:6870:460b:b0:177:81bb:1b30 with SMTP id z11-20020a056870460b00b0017781bb1b30mr1388328oao.31.1678542283119;
        Sat, 11 Mar 2023 05:44:43 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f8:ec2:d840:96d4:1bbf:55f])
        by smtp.gmail.com with ESMTPSA id bd3-20020a056871b30300b001718e65a5d0sm1109969oac.57.2023.03.11.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:44:42 -0800 (PST)
Received: (nullmailer pid 30642 invoked by uid 1000);
        Sat, 11 Mar 2023 13:44:40 -0000
Date:   Sat, 11 Mar 2023 07:44:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bernhard =?iso-8859-1?Q?Rosenkr=E4nzer?= <bero@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        maz@kernel.org, tglx@linutronix.de
Subject: Re: [PATCH v11 1/3] dt-bindings: irq: mtk, sysirq: add support for
 mt8365
Message-ID: <20230311134440.GA28029-robh@kernel.org>
References: <20230309213501.794764-1-bero@baylibre.com>
 <20230309213501.794764-2-bero@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230309213501.794764-2-bero@baylibre.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:34:59PM +0100, Bernhard Rosenkränzer wrote:
> Add binding documentation of mediatek,sysirq for mt8365 SoC.
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> ---
>  .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks.

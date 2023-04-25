Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDB7D6EE13E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjDYLrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbjDYLri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:47:38 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75233BB97
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:47:35 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-2efbaad9d76so5119591f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1682423254; x=1685015254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JiuIRKs9PjicPVCiI7+t45e05sE/xszCru50zXxeVEY=;
        b=ALjxPtORpNCAYZeu6DgdQlxj7NFa6BnSD70Wnc+hZR0VXLFPGlr7Ne5ajzsnIpVxFD
         7iXjWLORbfbNICGERP1w2eL0pnpd0pZtgL5fereqLjzo75BgGbe5jJtRYg3o9z2JIn8c
         Y7bfX/vVq1AQ/gUH5KjoWINEEgZlhoKBp3MXesyB69LziMgb6kM1owXyPAl1bFKutu5l
         5kzqIzI7PqXkr+M1l6zbwfMaMmTlyeUnze/0csHt4lJxVHZ8KAWBr+ShF3T7EYm9Zstz
         CmeFEKvCW2EZkyPGkKEIpCw1YXh3fiKnpxqMDxz7pIpJUV4ZdryvPaEDeghBzEwhIW2L
         3odQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682423254; x=1685015254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JiuIRKs9PjicPVCiI7+t45e05sE/xszCru50zXxeVEY=;
        b=XizaMxB6Y4PhF58dRiQIGCj5B59vZGPAlv9qT7FNPnA46dwItYUGeCt3yEZ3A4YMSM
         wJYdGSI3WJj4myyYhUpU430z1M4DO+cQliEyNRtqSulsbcbDEhi5lboeXO8slxnbkZQz
         qb+KAv1Zm4QsBPpyZ9JpLI0+DrverDywtWwanJFi8F9P3raOdS8lhVSSacXFCAStB5E8
         bZuMOZYl569E8z6WAfK7xmU0S9yD86MOq/l75+qw8JtLfxb3RNMQrbNFldvONO/69B5d
         W3jFc2Vi2C2BhHoi2is+9U/nEA21Q2s/ORMJI7BTTBGuUQIA11DiDbMiAa/sIOg0cHsN
         CF5A==
X-Gm-Message-State: AAQBX9eQlJTlyCrOGswHNEivMa5K72tbIzBh9W55B8lVl5jPH6xPNAKf
        sExcZfcGOSSj3s7EbCUl2uEC7w==
X-Google-Smtp-Source: AKy350aTPKhEURErKvzC5tUu15uUXe3txxCHawCF48VkO2ZBI2xz2AV7K/6E6w8KpCtXd4vFAgJrwQ==
X-Received: by 2002:adf:fe83:0:b0:2ff:7311:6e74 with SMTP id l3-20020adffe83000000b002ff73116e74mr11502057wrr.26.1682423253790;
        Tue, 25 Apr 2023 04:47:33 -0700 (PDT)
Received: from [10.101.1.6] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id n3-20020a7bcbc3000000b003f175b360e5sm14904856wmi.0.2023.04.25.04.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 04:47:33 -0700 (PDT)
Message-ID: <e69e5c5c-033b-e932-a64c-25c00837fc65@baylibre.com>
Date:   Tue, 25 Apr 2023 13:47:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 2/4] arm64: dts: mediatek: mt8195: Assign dp-intf
 aliases
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
References: <20230424112523.1436926-1-angelogioacchino.delregno@collabora.com>
 <20230424112523.1436926-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230424112523.1436926-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/04/2023 13:25, AngeloGioacchino Del Regno wrote:
> Assign aliases for the primary and secondary dp-intf IP to properly
> and reliably enable DisplayPort functionality.
> 
> Signed-off-by: AngeloGioacchino Del Regno<angelogioacchino.delregno@collabora.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

Regards,
Alexandre


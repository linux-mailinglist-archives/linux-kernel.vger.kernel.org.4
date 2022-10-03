Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362375F3139
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 15:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJCN0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 09:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiJCN0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 09:26:43 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3C01C418
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 06:26:42 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id u26so7955551lfk.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 06:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yRIMiFRHxfdGJDjG9K9HNpuOScDcKnyF2oEGJoSrlM4=;
        b=CCRAtD2B/gDLVtVgCmF4Q4OjwVBw0wDfwOpTt6CScLf+G88sFEV/U0as01pkrtLJ16
         mbfWdwO8Ozs19RiYvPdK81wU+r7P3sNtB3Oy7Y5NQbHzqzCU4kpcqnM1RXShBFJmTPZT
         VUkLDyIh26H2AIFUyvItrin8K2vImbAVe2K5Pn2DrjRqwLcF0BZMzV1olxAh6OCqYDSI
         8J9VYJxfljrKOO/LxRMCB9y1+rt7vzmm0iXKLw4QeFs84RtVvRK5Q+5eAMMKrgnNUjSU
         Arwdq+AcHdKwNzpsSUC8jrNjmjXUKuYBHvBYL0p90ahVtkkf577LrrkKk8sLqA1wxy5g
         gVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yRIMiFRHxfdGJDjG9K9HNpuOScDcKnyF2oEGJoSrlM4=;
        b=p4s5Yg02RUGNHmZy6ij74Wq/280rRSLjg5OONKLvZi8/H5MCfq8jT55or1FOatRwCg
         MgylSCXh7ZJQtAM5WZlzCk57zu/KTdNdNgEFxpXLJeRx2krVYCZNZ+XADKIdB/4bfJzE
         50cDvHCNk1/dDzJvrcB6wy5eh0wrdWU9zHhjT31EFFalnkfYyr5jstA6J8KBNp8w6nd/
         TMAcmrNO9zFJZAA9WrQBrzmIzFt5VMFYk2liN2GRY6CsMc42UXNO86gur9d8LBpplt7Y
         3NwQYA81qXntGnsr61Zc0iLwCTHw0PdakuA6fTPqphr7grpk/AlWgSwwRuGjpI1ToMpd
         kLTg==
X-Gm-Message-State: ACrzQf3PQyw6h290MDTyNKFfeRafQUVc4s3+1ci22WB/i07Cq0JbWZ2O
        OJ5q2ho1rCF8AnLGf0HoethHjw==
X-Google-Smtp-Source: AMsMyM6LLORTXjbGJao6foKAioZdPQngaNSwlkj1I2jJGoa7BH0czKJEH7M00qNEosJEewFi3Y8F1w==
X-Received: by 2002:a05:6512:234c:b0:499:9c33:af96 with SMTP id p12-20020a056512234c00b004999c33af96mr7094704lfu.545.1664803600423;
        Mon, 03 Oct 2022 06:26:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id n5-20020a0565120ac500b00492d7a7b4e3sm1462850lfu.4.2022.10.03.06.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 06:26:39 -0700 (PDT)
Message-ID: <01ead0ea-d0c7-7878-e411-c00cb5f78140@linaro.org>
Date:   Mon, 3 Oct 2022 15:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v4 1/2] media: dt-bindings: mediatek: Rename child node
 names for decoder
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20220930112237.14411-1-allen-kh.cheng@mediatek.com>
 <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220930112237.14411-2-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 13:22, Allen-KH Cheng wrote:
> In order to make the names of the child nodes more generic, we rename
> "vcodec" to "video-codec" for decoder in patternProperties and example.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml    | 8 ++++----


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


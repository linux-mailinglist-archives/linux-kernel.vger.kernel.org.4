Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575C37006DB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 13:32:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240864AbjELLcJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 07:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240422AbjELLcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 07:32:07 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23CCD059;
        Fri, 12 May 2023 04:32:06 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f42c865535so42695485e9.1;
        Fri, 12 May 2023 04:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683891125; x=1686483125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yiqqflnIDT5zW02DCqAL89wuz3kC3M5MrYziUX0JLbc=;
        b=hmNW3GPWhcb3KKkcveW0KfRlmGKxwkNiv4RiebqLGQHxlFHuAZvvcJMIlJzc0ln4yU
         tzEKsFdAATSMBTgSx93OouI0hbp52mBHOPkE8K0ueyPFkocGEyf8KdHAwkrNJBVmhIT0
         3JzumVD6A5iBs3oI37Scg4/ZUONWJt7Dfs734CuQiXN8WcIkMBDWY/EJfGHTeKMCLkg1
         Ed+jEnRZIispEHySuZTvVy5rVosHhB0ULsjR2K1naB+H7bwjFpr8MT7SvxQJyCwcLffG
         HP4nU10Hd6xAlWtbn3s820JPdwG//mvOkpao/9HAbyGwikm7qPDadiBeJCwK8Lf4gAyL
         dCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683891125; x=1686483125;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yiqqflnIDT5zW02DCqAL89wuz3kC3M5MrYziUX0JLbc=;
        b=M2i8vgbSjm4YdorwVkaFOn2nDg6M2HcnCebuSbJ+XQO2R8/8br1czp8RXVwm25P58g
         anzcacCz1KELpzipRTSLhAnQtioCEAPJtfIAL3W6Q2+JfuyFVxyqUWX3lE6E2tA6ecf4
         p1WaDjPGDAHICggFiPCUtyvrn5P1ImN6d4XVTXJ4jgcVzgvdbKXaagP/a2SuJ0kXW190
         jPfvvEbKhEPQFlGQS1JxOQCXUhHt8xX7RuMRIcjK/6bSYpy49aKf/dX5XWFawVXR5kgo
         t15crXJ9WMuzqp0BZK9+Va+wF6IA4BV60XpZBBAZR0VUe2XNFIySI3U8xOTZMLf01pbG
         3Ekw==
X-Gm-Message-State: AC+VfDzJuQwSotTfuyZ0GDphqJaGvH7AjAZi+ZAeHCWNaI4B+QuGwCGm
        9pn07yAbwBz+74O47mbhYRA=
X-Google-Smtp-Source: ACHHUZ7+5L5xW9tJPCOpere/SZxgTKKOoJ8T0EuxolXCIbyUPaKaY9fkdLq1/SKO5pJZmkOp4ZrxLw==
X-Received: by 2002:a7b:ca51:0:b0:3f4:2174:b27d with SMTP id m17-20020a7bca51000000b003f42174b27dmr13085546wml.39.1683891124853;
        Fri, 12 May 2023 04:32:04 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e19-20020a05600c219300b003f173419e7asm28079750wme.43.2023.05.12.04.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 May 2023 04:32:03 -0700 (PDT)
Message-ID: <cdcf000e-d1f4-d420-3151-0c8fe1b534d5@gmail.com>
Date:   Fri, 12 May 2023 13:32:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: arm,gic-v3: Add
 quirk for Mediatek SoCs w/ broken FW
Content-Language: en-US, ca-ES, es-ES
To:     Julius Werner <jwerner@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wenst@chromium.org, Eddie Huang <eddie.huang@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Ben Ho <Ben.Ho@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        yidilin@chromium.org, Seiya Wang <seiya.wang@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org
References: <20230511150539.6.Ia0b6ebbaa351e3cd67e201355b9ae67783c7d718@changeid>
 <20230511150539.1.Iabe67a827e206496efec6beb5616d5a3b99c1e65@changeid>
 <CAODwPW8TqhArafCK3RvBdxyiav3WL=0MU6x=QyBOFP-h8bQrWw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAODwPW8TqhArafCK3RvBdxyiav3WL=0MU6x=QyBOFP-h8bQrWw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Julius,

On 12/05/2023 00:37, Julius Werner wrote:
> Reviewed-by: Julius Werner <jwerner@chromium.org>

For the future please don't delete the patch itself if you give a tag, just 
leave it as it is (and don't top-post your tag :) )

Regards,
Matthias

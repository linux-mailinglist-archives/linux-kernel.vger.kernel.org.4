Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C04724539
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237388AbjFFOEw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232450AbjFFOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:04:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1145A10CC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:04:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f732d37d7bso26777215e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686060267; x=1688652267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7fDUzTpaD/GTmyAtwno6H654DQCka/Z8x1UqVQuHL0U=;
        b=VjYSvrccY2OgtD7RCiNqCRothioaXTvzS0GzfX1luOT97zsSBHWxcKuQHU16bSxqqz
         vgbUo4q/SOkwJGdrBGaj7T7VfYFygwL9oUD633g2PnL58nPUSto3S8Orf/5iIMP7Kdlf
         sDFAIyQFeD85E/vhG25XXL32SrGf8AEmII4TyvbTWw2jJrLEfGcKCn10IAX2dyeiuMaS
         RiBl0IUMW19gxslfXn9L2cvM4ay7z+zc4rg3tfTo8CXLsyTe7YYwhMJ7NbiTC+1aIQkj
         oB2L1iQmeCR93sDMU5EsJ7SF9hdS4wR+xs+hR1HQt1j7eJDckxLm+rhjNpkvPe4J6ZVf
         PLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060267; x=1688652267;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7fDUzTpaD/GTmyAtwno6H654DQCka/Z8x1UqVQuHL0U=;
        b=hKcQIwgPJ2aKTtic3KrnmPRH8B5xdVyspFKP2wzJqXJvsqoV+StK3GSqh83T6yD1cR
         kI7SP5WZ8dDcNkLUnsiq8Iw413jkn59W1RBthGdhCO3S5e1GGusnuysNH88NQUUHuThM
         6c695racCYvU/uTlpLaAAdfsnCXa8mbHHzMj2btVfUyh3uk+ip1sozXFhJx1IUQ2rRHQ
         YnVMbSiRrdnujnGqKGwUnYZwGGIGj3FfkwOGjYZxeowf9dkq/0vXroPvMHasgq5WPycM
         5AZUOp75jmLzrg8Wl1EnBysslUFz1kr5zi7gSy5cAPdzww2NixkqvAGhbHgo+oTpOztF
         6pag==
X-Gm-Message-State: AC+VfDx3nu4NPlmYi95WO+pkoz/eF0s5svPkxG+cRtjks0cW62bMkwZu
        5EU9Ss8+FF05Y+AS1Dj4iE8r2g==
X-Google-Smtp-Source: ACHHUZ65YDUp3H7WFvUIjfgRFCS2KoaePCRCWSZaPTCc9TjMDlxD9G/g2wWFJ3nyES0QN9B8wJpQoQ==
X-Received: by 2002:a05:6000:4c8:b0:30a:eeee:2fba with SMTP id h8-20020a05600004c800b0030aeeee2fbamr1937111wri.34.1686060267488;
        Tue, 06 Jun 2023 07:04:27 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d6806000000b0030630de6fbdsm12677603wru.13.2023.06.06.07.04.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:04:26 -0700 (PDT)
Message-ID: <5857ffb3-6ca2-8012-ed9a-9278c71361d1@baylibre.com>
Date:   Tue, 6 Jun 2023 16:04:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 4/7] iommu/mediatek: Add enable IOMMU SMC command for
 INFRA masters
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingyuan.ma@mediatek.com, yf.wang@mediatek.com,
        jianjiao.zeng@mediatek.com, chengci.xu@mediatek.com
References: <20230602090227.7264-1-yong.wu@mediatek.com>
 <20230602090227.7264-5-yong.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230602090227.7264-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/2023 11:02, Yong Wu wrote:
> Prepare for MT8188. In MT8188, the register which enables IOMMU for
> INFRA masters are in the secure world for security concerns, therefore we
> add a SMC command for INFRA masters to enable IOMMU in ATF.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre


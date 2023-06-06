Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278C3724582
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbjFFOQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232718AbjFFOQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:16:43 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B80A0
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:16:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3f6d3f83d0cso62756365e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686061001; x=1688653001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jAJKlhfbMyQplK7V4LBuMFmDWCWyf09orv4Khsn/h98=;
        b=ADRP1bQCKU0JZgIwyThrHejXZNS6SNtFkb6zSc3+4bezjfXOJL3O1QvSWzx0VvpR8C
         2vq87FZ5pL5J2j4gFKw0Nwzn6WP2VJwm2pji9kwz8kD9umkqWuR8ESx5xE8BvO3f9nQA
         rEArD1O/c16OLFBalQbBhIMTaqGfXHsGVLWTkNwqxa/OJ3FGO281KY65uA5CUAJ9TX2C
         fQtrjAMHE+Ogw71XfCqYa3gJZjSpf698KrNAaHYPPYv8Nm1fzkxSi7OAJDBMRqYW7VDW
         4zwGz4OgW+D3M6Zk+StsGM5Nb4Vk6V0Bi+JxKP6ZDCQXP8d4YXin8NoyPTBBI8kxzyWo
         eADA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686061001; x=1688653001;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jAJKlhfbMyQplK7V4LBuMFmDWCWyf09orv4Khsn/h98=;
        b=l/ofR1o62SkKlrF52eIR1xuVHtrDFNWMDLym82NFNPKtmvzYougOOlN6j/W/72uzDj
         AZK/PEGrbD8wAFJImLosrF471scjAQAv55ScKo2T6Nrj/SBwUSFOk8M8b1frpr2YZ/zT
         0jeWq/3bQdST6VZXHfD9VobRUbW4+H+KwitVmSgYAcJNcBx2ZPN9OWxGBRXZ0DUzH+gq
         Uw4wVETomaasMnMjmD866M+nmPKkB55dZ2HtJOPEi49PXxVtMtU1Z8BTgxrLT8xQEa9B
         JiWcHQVREFIYVxRLienEgLPQl8qcZUpQYNrAwr/Etd+uUsAViseyokp2jR325cWdnYFO
         101Q==
X-Gm-Message-State: AC+VfDyCvlhlvPiGwMFXI/m2WL6y90Nqa9/dVEf6hRSYNqyNpW/b29CY
        XDtYmD6bNTVyP20aTreXCcs/Rw==
X-Google-Smtp-Source: ACHHUZ4B+HMXMA37SveRg95J8RPbhX92Kzuddi7nlYWzpXsyavm7U7yYxf7JFrAAtLM2rTtQfbDpPg==
X-Received: by 2002:a05:600c:b49:b0:3f7:8fd5:567 with SMTP id k9-20020a05600c0b4900b003f78fd50567mr2601919wmr.2.1686061000705;
        Tue, 06 Jun 2023 07:16:40 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y24-20020a7bcd98000000b003f42314832fsm14077795wmj.18.2023.06.06.07.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:16:40 -0700 (PDT)
Message-ID: <e925728b-ae6b-6347-20f9-2510f046d598@baylibre.com>
Date:   Tue, 6 Jun 2023 16:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 5/7] iommu/mediatek: Add MT8188 IOMMU Support
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
 <20230602090227.7264-6-yong.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230602090227.7264-6-yong.wu@mediatek.com>
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

On 02/06/2023 11:02, Yong Wu wrote:
> MT8188 has 3 IOMMU, containing 2 MM IOMMUs, one is for vdo, the other
> is for vpp. and 1 INFRA IOMMU.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre


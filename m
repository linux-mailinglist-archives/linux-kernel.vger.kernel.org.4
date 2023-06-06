Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5446724519
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235259AbjFFOAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238221AbjFFOAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:00:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67D90196
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:00:06 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-30af86a96b4so5018150f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1686060005; x=1688652005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FwrMrJM0MbRtGcxqqd7/qoRa+Z48fgcXIKuxfVUvplM=;
        b=Qmkebezhd3bE3EvClEVx5a7mjquFqdwFKJ07a+K/AxFUAUuZLUzo+nJmpQh0A1yT2c
         Kseq4TT0aRD3LwDElehU16MKuowQDxTagXLfA+S2b9hCQkgoCb+B6EXJJDuZ0N5zENVv
         aQXBjdLHxHKnWazjp2gv4X85tqhJ8MXmp8xYbReBJ6riWDDaUmpesbk5nH+H+j9BLFr+
         QBZZfqfPTE/DJ+03sI6+cvdy0DPOJdkAiRf7xQfCvC0d7D9j5RW6ozVBibrWo1Toonq7
         jLK6vvN7LyMlsKZ7ADisxhcWO+C+lAzJonHXyuQXiB9TmJMl36QVEdRf39rfR+RLWvfZ
         /l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686060005; x=1688652005;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FwrMrJM0MbRtGcxqqd7/qoRa+Z48fgcXIKuxfVUvplM=;
        b=Lbj0MOq/Ftu2nZjqWIXOURK/gW8TLiZGZFZCWmVnxMGT6voikrBRKzyOhqlaRoOoE9
         jDA04In0n1vxc7/ier64vaZOBHVco26tIBll7ttpSkoB4X7dNj2QH56B1aQJ/wCs2XSv
         PFOA5loUXKfzd53KnqmaUMd5uarEJm8gEXfEzi+9m9KkLZxVhMW2K5pGUlBD63p/Efwu
         j892sDg4c3qUSTZ8X4ze5KMKIp05nXPbvBSZYbcwCxlQiuaD6LkYiEL596eFp5zK4rIn
         oLCENdGtbD0UjWEZDc/SXkDjN9RaViniJ2HleBu5XJbWKmUqrQjD8rAHAjJ/yIW1KIUB
         IrnA==
X-Gm-Message-State: AC+VfDy6A7gI5a/vF+/spWEQhZEI6L6jXAwRpXnF5/L9wJE2QDa6qNb0
        tAPxxbxUc9TfvHCjjoBqB5fSwg==
X-Google-Smtp-Source: ACHHUZ4ccc0T1eCTcxB1MhwmrQqdwiijiuxyeqJgwleyD1UPH+KZBBX2FUY5GnJZiKflEDdNGeHzAA==
X-Received: by 2002:a5d:5102:0:b0:30e:4c8d:c6c with SMTP id s2-20020a5d5102000000b0030e4c8d0c6cmr1743312wrt.55.1686060004870;
        Tue, 06 Jun 2023 07:00:04 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id y14-20020a5d470e000000b002fed865c55esm12639517wrq.56.2023.06.06.07.00.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 07:00:04 -0700 (PDT)
Message-ID: <1dd3ee51-f1e8-2a4e-f0d5-dd61ee5206f2@baylibre.com>
Date:   Tue, 6 Jun 2023 16:00:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v12 3/7] iommu/mediatek: Adjust mtk_iommu_config flow
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
 <20230602090227.7264-4-yong.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230602090227.7264-4-yong.wu@mediatek.com>
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
> If there are many ports in a infra master, current flow will update
> the INFRA register many times. This patch saves all ports to portid_msk
> in the front of mtk_iommu_config(), then update only once for the IOMMU
> configure. After this, we could avoid send too many SMC calls to ATF in
> MT8188.
> 
> Prepare for MT8188, also reduce the indention without functional change.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre


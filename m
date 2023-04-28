Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA976F17E8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 14:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345631AbjD1M0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 08:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbjD1M03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 08:26:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1265349C0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:26:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-2f86ee42669so9459738f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 05:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682684785; x=1685276785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ta0l6Lv08itCF3ih3pDrrtQORcFWDgffeo/Lv6j7nWs=;
        b=l/kvU/GHw0avOPKANSxEPurb9FkrW5c6sXEi2BHlm2Y5GYB5+69txZKbvaT6AOqCtV
         bLqaNmHLakLuj8vEtMZfeULYDYmyOdqFqaTSDVHI7tb6eRP2mnxzK3FqjAAHXY5rb/OL
         BfwoZtZBL5OCZ0OrlVcgr47q17VWh+ity76RJudCv0Uu0NZ2/vrnElhg6OS2Hz6cPcc9
         aY95cnaUz25Y8TO4UDkNtDnyUpHkPi08ucqhgM/f+OBLkTwYb8LbetYh0kHggEaUf1sF
         SwVLeBIA6FT6zGCA+XbGx5trbNwvUpZLgQFbOG2oJtvclEZrci8574SccMx4h522wQKX
         PwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682684785; x=1685276785;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta0l6Lv08itCF3ih3pDrrtQORcFWDgffeo/Lv6j7nWs=;
        b=O9SVy5wEXnWuPhmPDC2bA1fg0YFV6hKnCxtyLFlnL2IWh7c7qxqYQDwjfDmHj/ot5g
         GmAp4rmXRyYusAq2y5j6+UpinSc/ybPxV96UZ3IO+I/a7ygHxxZbANWOZuXjsgh2G6E5
         p47l7s0UDhNQhuYKsU8Hem2TclIPPclojpMcY95epzPJgEsjmTeZBqWN9OFSAiUzSdaE
         R7BBexHevKHusumejwkFE6AbXwa+24G13PfODM58iGbeIolZy9WhZpaqvtSmY637TfqK
         n6lg+G8abi7JhPbs3gm/becv4tQPMq+B3KMQxBlmvS4dsowTijrZKn3jH36G4c02GNiU
         5E9A==
X-Gm-Message-State: AC+VfDx1P+bsYCXabOl7vFiHJHBqzGL0h2ng+J9So26IUaswsjZzg4xX
        zOC2Pt1R1/gpSsDJ8B4V4xskZw==
X-Google-Smtp-Source: ACHHUZ539Um3Au7ebr5J25DDcgb29sKe92KDcP8tUre5wahXVbiS2azwg4bFs5ceTkPhZOBWur11+w==
X-Received: by 2002:adf:d4c6:0:b0:2ef:b8e3:46fe with SMTP id w6-20020adfd4c6000000b002efb8e346femr3704585wrk.37.1682684785530;
        Fri, 28 Apr 2023 05:26:25 -0700 (PDT)
Received: from [172.23.2.142] ([195.167.132.10])
        by smtp.gmail.com with ESMTPSA id f8-20020a5d4dc8000000b002f9e04459desm20930621wru.109.2023.04.28.05.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Apr 2023 05:26:25 -0700 (PDT)
Message-ID: <9b39118b-afc8-034a-67ad-c748cb76fb71@linaro.org>
Date:   Fri, 28 Apr 2023 14:26:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/7] GenieZone hypervisor drivers
Content-Language: en-US
To:     Yi-De Wu <yi-de.wu@mediatek.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mediatek@lists.infradead.org,
        David Bradil <dbrazdil@google.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Jade Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
References: <20230428103622.18291-1-yi-de.wu@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230428103622.18291-1-yi-de.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2023 12:36, Yi-De Wu wrote:
> This series is based on linux-next, tag: next-20230427.
> 
> Changes in v2:
> - Refactor: move to drivers/virt/geniezone
> - Refactor: decouple arch-dependent and arch-independent
> - Check pending signal before entering guest context
> - Fix reviewer's comments

You need to be specific about what you changed.

Best regards,
Krzysztof


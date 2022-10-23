Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3674D60946D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:34:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiJWPeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiJWPd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:33:58 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5BD760F5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:33:57 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id w3so4454619qtv.9
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:33:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=25kVQPQG2znFAF9RxCCNUOxMKGya3FwJ+y6I9/YjZ3g=;
        b=cJc/VzN5gpUzhU64fYp5atWXE1bdvd50oacKDPWZR3CkPaHgchhB+GMa9sud5EBjzE
         Qw17HIXtXiEu7cub8VNj/py/htxJfniIrX5Db+lp5gv8CRj54wVsEBA8fDtxuDCD5Rql
         TWklIU1edzHaKXXsrsAa6GuNg2YlNpkrucCWHFURkxGuu2LY1f+oOCrsr8np0MvtfkQy
         EF67TlXPQi9wL/09bSN57CvYs38TmA4gGSfGs+1C3rzvtgSGnO4S0PDBmMKUqfQWX3Zx
         zF5VF+l6nS+uI3OEsrvcOiwbtQBnIHAVQZbTH95OIQzMBoPe46LMzpopD6MtsfYpmJaA
         Ewig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=25kVQPQG2znFAF9RxCCNUOxMKGya3FwJ+y6I9/YjZ3g=;
        b=UH43U4O/x+fDvJVneiesRYSV2XYUWdBWH5TmJ3sc5btrooVOA6P5A3wHISQDHImhST
         VEZYgj8HGih/3QtgVB/aOaU5HQBHQqm6AhvNM2VoYXGo0YZfIfTYplW0pZVK2FrBLgL0
         dQKLsX3ln+EGfVbib59RRIu3PVeigbQQxPc0uKbtpO5r1uvMSUAk26/EA4O2LS7uH4LS
         L/GO0sgvhEgL++jl8ucOBI5hnIevA6KjitI44GSAHMrf/GrkT+/o50iYsj9AjWwl9A8Z
         J7VkofXrtZsWVliVF9C59EukdB3KxWkRvu9TvM9DoF6IneB/aw5FWj7IaMqA2dTMJKDi
         IczA==
X-Gm-Message-State: ACrzQf3XUupIRU1u3kpzLH/qbiDsrybX9A1PK6Vz/rx3c77C9nw9V3KH
        VGrUgVTfF6nVh7jOFs4FY0EBIg==
X-Google-Smtp-Source: AMsMyM6swSIg2sGVruIpJY6Rp2ZQxDPnIP4a+ggvbvy5C9Vy1hEqWe61Vv2Gdgvdonhozz5yuBCSGQ==
X-Received: by 2002:ac8:4e90:0:b0:39c:f65a:3376 with SMTP id 16-20020ac84e90000000b0039cf65a3376mr24038567qtp.228.1666539236624;
        Sun, 23 Oct 2022 08:33:56 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a258500b006bb366779a4sm13033072qko.6.2022.10.23.08.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 08:33:56 -0700 (PDT)
Message-ID: <50000fa9-74bd-d837-db5c-a38d470c069d@linaro.org>
Date:   Sun, 23 Oct 2022 11:33:54 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 1/3] dt-bindings: ingenic: Add support for the JZ4755
 CGU
Content-Language: en-US
To:     Siarhei Volkau <lis8215@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
References: <20221023131331.4107782-1-lis8215@gmail.com>
 <20221023131331.4107782-2-lis8215@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221023131331.4107782-2-lis8215@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 09:13, Siarhei Volkau wrote:
> Update documentation prior to adding driver changes.

Instead you should rather explain what you are adding - what is this
hardware. What if you want to add it without driver changes?

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

> 
> Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
> ---


Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE5F5B85AF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiINJ45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbiINJ4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:56:52 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F683CE0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:56:51 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so15121425wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 02:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=5FtBgeK2f0cwrAqROX1aiw+bsyTANUvt9FFxN9wNUrM=;
        b=XHFsSyyKZrA+ZJ2khkgtth5htTTD6NBx7KeB50DRgrZtb3PifpKrdGJLCYH/wGzvsd
         t//ol14nk4Pn6hjKfVhFt+0+S/HG7vHILvXQJMjCjxYAoVqKWWtSKzgABWoLu27E4QY4
         myfA1U20rVzmJ9peejcoVd35sdjV7My7Liz7cft/YA8RPgP7ooeOATdbyTkj/xNEr1V3
         v7YmzmrfnAI36QpXwnU2R8MbhmQ93X8p2BbBIGaeOsp6T+fttU+s4ureKA8Pm7f8sXpk
         dlbVEKMt2CqfNg5zLV/IJ5WbsFpgmZuxWSR3Ox1n8MLkbDpu4gr4suOSLjTcEVG4dR9u
         xAOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=5FtBgeK2f0cwrAqROX1aiw+bsyTANUvt9FFxN9wNUrM=;
        b=UMv1f7MWFgK43QBAArY4HA3srozcNV8FPccxLEBO3N5MKBWKsVMYC6xelmisq7ThbU
         1RiRUcrZ+cjme8AMt9YtwSLw3hlZd7RQe1LUMoFAGVY63utqvB6Qpml36/WMnLgNnyPg
         Hh+yqT0WD6bPXKKUusz3Zd179x+BkL46V74XkC6JUXLdC1Ru32MlKZqa1bqC+LiSltSz
         P1xAiyJQzV5VC4PKMVtItA1hSkzh9CH0hPWHyz7DijxFNzy2mQ39KQdhUPF6gaKpzEWP
         Bia9hK5pPIa204/ZJQXhd9RadiqDnHQuyOCbKqUEFmCPxl4tPpRRFq2FSnRuHRa2/BDS
         67Ew==
X-Gm-Message-State: ACgBeo0aPU5eLBgRtciQtfi1+3sKSYNYISs3LRfbB2FfdciAtfzU31AI
        n7mrqb6UlFMA8hEea7FzgQjXHg==
X-Google-Smtp-Source: AA6agR7fzRki6XCTDf3LuWBEgQLBcp8/fw7HjZQ0M4BwpFA2amtSUrHYvGEFDFqrFRZWlMr/gJZrJg==
X-Received: by 2002:a1c:2c6:0:b0:3b3:efc2:1bb1 with SMTP id 189-20020a1c02c6000000b003b3efc21bb1mr2482160wmc.38.1663149409653;
        Wed, 14 Sep 2022 02:56:49 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.73])
        by smtp.gmail.com with ESMTPSA id x14-20020a5d60ce000000b0022862fd933asm12808432wrt.96.2022.09.14.02.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 02:56:49 -0700 (PDT)
Message-ID: <f1a5fa86-2a4d-85be-5641-9d51f2d35af5@linaro.org>
Date:   Wed, 14 Sep 2022 11:56:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] ARM: s3c: fix repeated words in comments
Content-Language: en-US
To:     Jilin Yuan <yuanjilin@cdjrlc.com>, alim.akhtar@samsung.com,
        linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220914084127.33781-1-yuanjilin@cdjrlc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220914084127.33781-1-yuanjilin@cdjrlc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 10:41, Jilin Yuan wrote:
> Delete the redundant word 'would'.
> 
> Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>

https://lore.kernel.org/all/fa6a55a9-1c27-e9a8-739e-fd7ec34e3b76@canonical.com/

Same reply.


Best regards,
Krzysztof

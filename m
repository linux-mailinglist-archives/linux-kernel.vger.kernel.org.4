Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83302611962
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 19:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiJ1Ri3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 13:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiJ1Ri0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:38:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6DC22B7A9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:38:23 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id l28so3916744qtv.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 10:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OoiWmzEHNiG88vfsHfRqrZ47OnbEddshqdwrSUCSfdc=;
        b=KVHYbMgLdjosFobEllSKS2gVxGXmn7likk3DFxkKLRckWZBWtQ+hYLRHf+mHMnbAzk
         OS6GbPuf0tS6LBmIxqEmp14LX28G3ZfllSvD0QnStJJOfPOfW6SC/UmDt6h7H7gbl8zl
         GtdUA69sBxa8SDi5iTokosr/jbkNeuSq01ATIF7I1oCTapq+ZqHj1dxZhYsFqBrV59Ga
         4o6kKJGy0TsHgli8sUlqjpSMEUGglIqtzD8g3eGRRnwFxB80tTodWyguO7OM/7/UEYT7
         Yan2bmd5zkguKG/iX6GqzIQ+Le87HcLfC7Nn/oz9sm4/EBBKd7X44vo+DownrOs5fxbo
         t2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OoiWmzEHNiG88vfsHfRqrZ47OnbEddshqdwrSUCSfdc=;
        b=6xAQFSKB0/+Ie5ftHtQIYvpNpb7//d+6fM8qe1YWjfZQAOoL/Nkw9Dk+2UIhnaqMuE
         pGX0RzHsjTE6hemExX7QDq2q58yARfAE1kAzWpvbtMOpJg7wjf29YrCkEHHspi9GEh1j
         5kdSNuco/Pe0LHOvghk8KFsAxRA3dr1kwQMo7/odsx8f2ozernQ9R91hLo3Enqbkaiik
         U3qFQb51P5DYpogJ8VJwl+t21O/WadpYtwCfg/L506dA6W3+36B9M6ke0RhywB2jE/rs
         lrEYh0yQydDDzKSZSBne9OFQIJuqCZK8jN9m6COAyIyGKAbC4Mua9TL/Bi5qwVwTWo65
         WI7Q==
X-Gm-Message-State: ACrzQf22mXcKlyFt8cyS+jEu9DG0PCDyPTshxGawxunT+KNoJtivtZMz
        Xw5DMeZRbRjciAv/Ip3wFLccVg==
X-Google-Smtp-Source: AMsMyM4caIjhtYHuTfGPNcDxg9L7/E27m2qa9JZA/wHA4f+o4D1CwRHBXK6JfuWmsbrhp+8T9OCd7A==
X-Received: by 2002:a05:622a:1905:b0:3a5:c6f:a874 with SMTP id w5-20020a05622a190500b003a50c6fa874mr552750qtc.282.1666978703103;
        Fri, 28 Oct 2022 10:38:23 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id i6-20020a05622a08c600b0039853b7b771sm2612184qte.80.2022.10.28.10.38.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 10:38:22 -0700 (PDT)
Message-ID: <fd226c82-ee6e-ce5b-3949-faaf88ded3b6@linaro.org>
Date:   Fri, 28 Oct 2022 13:38:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] dt-bindings: rtc: ds1307: Add support for Epson
 RX8111
Content-Language: en-US
To:     glasveze@delta.nl, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        Mike Looijmans <mike.looijmans@topic.nl>
References: <20221028144041.11067-1-glasveze@delta.nl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221028144041.11067-1-glasveze@delta.nl>
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

On 28/10/2022 10:40, glasveze@delta.nl wrote:
> From: Mike Looijmans <mike.looijmans@topic.nl>
> 
> The rx_8111 is quite similar to the rx_8030. This adds support for this
> chip to the ds1307 driver.
> 
> This adds the entry to the devicetree bindings.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


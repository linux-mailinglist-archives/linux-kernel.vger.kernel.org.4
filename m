Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5135E5B9A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiIVGq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIVGqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:46:54 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4CBB6D47
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:46:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id i26so13025364lfp.11
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 23:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=lD7eGEkv9NNmbwuFNSY5wNAY2Knw/AnArDcDD7Ihsks=;
        b=YT4rwaGsNKJG3KJBaTg7AUI0lTcs5pu9cde18uITqorpKfQXMhgzunwhvvBDo9PKhC
         Qf9hYFBQWxbBaPKIpB/KhzBCCG2TPOcVFr0FNlkpyyaGJDT42yhiemFHusfEtY0LVWVa
         FNZVQ03Ncc2PhW19hQ47E8a0WhjnsAWJNPT9MVwI72MYgAqdZr4WYAzzPXEsliKFJuHA
         DdErzWJQk0NN6oPn1IxJhox2r9ZcjANslzC2xURXaooUD8aco5iN1Ai8Q0g7wm60qdNT
         IPP2luoHMWMh+0t6J4ni3MdF8Y78D3tpN635v0AsB2oXsMjym34mt5Mc7oujN6RLsCTy
         VmHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=lD7eGEkv9NNmbwuFNSY5wNAY2Knw/AnArDcDD7Ihsks=;
        b=cIMkqSpeDFJmJIESDp77wb9z0WqL+JhvlHS4TdVDmgx3PMKOYdhQCFES0c08/FMfBj
         TjfD4DbNcaLHCLtKjzJ+EkzJu7nu3LBcdXSimm6H5/Kd/W/FroqBra9qdhNBSdmbeQgj
         Z5makY4btiCEqqFMncVNpeVb1ii7w6fKmapKGJJMaBu+57SulJjxW6/CddxSz7oOo86+
         uS3CI8J2L2A+4NWgQXANqLm2RMEdIcAg5jtC/xtIybwvJTqQX1a/3G1f1V1B0U7cz3VX
         jGQ58DuNFXe/sdN24GwaOwPghJfHF4eAA5Y1waRy9EYSLGHuNmUlOWN1IuC4Ik7xZL0Y
         oOZw==
X-Gm-Message-State: ACrzQf3Avw/SxTv2ov5cxTuBnpSCEu64HB1xnGnKBYbXZ0JqLoYsjL5x
        1QlmkpAeTWgciWddxkhKS5l0HA==
X-Google-Smtp-Source: AMsMyM6BxgcSAwVtLlEKusvSWmnmLV6poxPCMlvtdabspSYBYoJIoYD1EYIbi1fGCHJMsVaqCxy8eg==
X-Received: by 2002:a19:7406:0:b0:49d:d448:59c3 with SMTP id v6-20020a197406000000b0049dd44859c3mr630832lfe.300.1663829211573;
        Wed, 21 Sep 2022 23:46:51 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 8-20020a2eb948000000b00261e7244887sm733355ljs.60.2022.09.21.23.46.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 23:46:51 -0700 (PDT)
Message-ID: <87800017-a620-041e-15af-3386ca671eda@linaro.org>
Date:   Thu, 22 Sep 2022 08:46:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 1/2] dt-bindings: arm: aspeed: document AMD DaytonaX
Content-Language: en-US
To:     Konstantin Aladyshev <aladyshev22@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20220920165404.14099-1-aladyshev22@gmail.com>
 <20220921210950.10568-1-aladyshev22@gmail.com>
 <20220921210950.10568-2-aladyshev22@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220921210950.10568-2-aladyshev22@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2022 23:09, Konstantin Aladyshev wrote:
> Document AMD DaytonaX board compatible.
> 
> Signed-off-by: Konstantin Aladyshev <aladyshev22@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


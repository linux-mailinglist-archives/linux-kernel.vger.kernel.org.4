Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFC36B6FA2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:52:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbjCMGwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjCMGwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:52:17 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88854B81A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:52:16 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id k10so44278905edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678690335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5hhe4wio9//gD/X+57x3DT7JNF21M8/U6QD9QPUvHN4=;
        b=Nf/S6Q9tIGrBCh0Ks5N51Pr1bn3/V4DJ6tLOQsGJbxNr/8pH/1sWJGx+hu83TB9Juj
         ktv4SQpB9pdJLZszndkB85UySwlpfWsJkHsIdC0Rv6ICNIB/Od8fXDjT8MaPQ7iTcFtu
         mBoxFgLML9YAszkhB/hdMLEKCjkCYkSUIXfqYb3IDOeF1Qs6dNICqto2kIUFqQt0a9MB
         iivF8T7HED63I9nkE9kTSziJx9eR4zkCqD73sBYuO1GpvnTv5/jP9ZJ2A5mT1WKRiMBB
         n3dPwlQhUXJP1BeXxBhK3L3o62UOFwGW6ZZU2ite0coikEPkfYf04vg5hcI7Ywn/3+7F
         ax4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678690335;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5hhe4wio9//gD/X+57x3DT7JNF21M8/U6QD9QPUvHN4=;
        b=xt87dNk5ujs092vVnmrkbCa0AQ3IDi0zT7AoA7XUno69S+lxRkwNBvXoh5h8IK3HHv
         wXHc8uyRi/dZSlFdoX1WmceVOoDZEk0gYF0+Hk9N3/mDpVka1zan/tNiufu0z7gHfYtl
         QkzlXusWDod3+T5B2sHweUa9QXIxO8rIzXEt/UEzgAEBqrvNQt7Xor5AzVz6uvt46i71
         /SKaEEZNRxmtfRTUsLrJvHhGNAC3/ZzhNjoTNecy1o7dbuo4R9Tv53v4P3PurcVIPItQ
         w4+uzYDerZoHbjwN8vHag6479NdApoE39Mfir0XcHXvAV+al2T6rt3lCv0XoyDoolESk
         bNGA==
X-Gm-Message-State: AO0yUKXEPrD31Y1+wSRhmDpPkksJbofwROIf4DwxKsy5wKwgC/g3fUqa
        UQw/VBdgYIQPwbun44Hj2F2elw==
X-Google-Smtp-Source: AK7set/LvfKPgi+f02fXbzzOlDSFTRF4wXPEpc3Ff+cuJL0D4OGjjudy2tliaW8Cw4cviRoap08Jkg==
X-Received: by 2002:a17:906:b197:b0:900:a150:cea4 with SMTP id w23-20020a170906b19700b00900a150cea4mr31852799ejy.37.1678690335163;
        Sun, 12 Mar 2023 23:52:15 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f052:f15:3f90:fcb3? ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id b22-20020a170906709600b008c06de45e75sm3077075ejk.107.2023.03.12.23.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:52:14 -0700 (PDT)
Message-ID: <a16b8715-2962-4094-4d50-59d673f455e2@linaro.org>
Date:   Mon, 13 Mar 2023 07:52:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] nfc: st-nci: Fix use after free bug in ndlc_remove due to
 race condition
Content-Language: en-US
To:     Zheng Wang <zyytlz.wz@163.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        hackerzheng666@gmail.com, 1395428693sheep@gmail.com,
        alex000young@gmail.com
References: <20230312160837.2040857-1-zyytlz.wz@163.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230312160837.2040857-1-zyytlz.wz@163.com>
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

On 12/03/2023 17:08, Zheng Wang wrote:
> This bug influences both st_nci_i2c_remove and st_nci_spi_remove.
> Take st_nci_i2c_remove as an example.
> 
> In st_nci_i2c_probe, it called ndlc_probe and bound &ndlc->sm_work
> with llt_ndlc_sm_work.
> 
> When it calls ndlc_recv or timeout handler, it will finally call
> schedule_work to start the work.
> 
> When we call st_nci_i2c_remove to remove the driver, there
> may be a sequence as follows:
> 
> Fix it by finishing the work before cleanup in ndlc_remove


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


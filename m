Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76BFA694836
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:37:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbjBMOhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBMOhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:37:05 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A18331C306
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:36:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so12430315wrz.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZyRvUUDOLHj8CYuZ0RJLhyzA8xLiouj5htg3dqZA0GE=;
        b=ka7GXad0pjWurOwIo2sN18R12XuPJ/VUcP5ORRRg0SFOshLAoez6fykUgh6kY/fAQR
         oYbDbhsSiUP1G/D+Z4KoDG7qzCFQxHF8t3ZrwNe4KgoGAj0uvr1IU3wp0SKAF81ORVNz
         lFy/0JmgGEfmVC8jM1ankVh7dt/iKRJGLsrzoZCkvcDCmFOKrDqngYx25+Q+/3G2PstZ
         JeA3efksQdm5Wclt/M8JJ9y/717T41Md2FxTTH5jJZzodTsFuIn3XUY9XzykQfyFmzsG
         VQrCVBjxxUW+KbiFf4MxraHqe9AT9AIjysvJMb3u686KBY228Z7w7aywfRxZB1F6qFqb
         puoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZyRvUUDOLHj8CYuZ0RJLhyzA8xLiouj5htg3dqZA0GE=;
        b=Efs7KD0ybN6GoT7VQr5WkDSd8W42MOLkch9kOJdwxQpHOYeTQVm/xhqHLQh+Mu0WdS
         NUORjx4ok9wUj/ecbxn4M/dYnbYIE64F2dpS8giUQXGtxBNovPQ4PQy14HwQznkvJJgu
         6tBrexWocTUSKZ4CLE1OT/EJzUHwJ5EsznKypxtB11Swu20Dh4v/VNtXtppr0fjXb5pI
         oOBi9489rck7qfN4k9ICOcXWSHjgTHEZex+ixeZh17MbRs7cS8/spt5itw/1Rjp7aGJw
         vIDqMTWo/nKKTfcauipeXe12DDEQSiCxxzOcauJEpvzdm01N9hkwigBd+7bbZbq9BqFl
         /pJg==
X-Gm-Message-State: AO0yUKWhAL0GFxVK6dO1uMcw7hPDGOy6b5V6xmago1FXl9Cptd4ShLd7
        OttdYa3chcdbCPSG5kiLXNfyYg==
X-Google-Smtp-Source: AK7set89smbO8qcTdScCI68QdZHh75ELtlhJvOjDZ/gP2sg6ky2NHbQDhknK14ZmHRVJk74gI8I5Fw==
X-Received: by 2002:a5d:4007:0:b0:2c5:5ebc:d681 with SMTP id n7-20020a5d4007000000b002c55ebcd681mr1584143wrp.16.1676298996138;
        Mon, 13 Feb 2023 06:36:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j40-20020a05600c1c2800b003dc4480df80sm19312274wms.34.2023.02.13.06.36.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:36:35 -0800 (PST)
Message-ID: <16804864-dce2-d68c-ce81-b6fdeb20a527@linaro.org>
Date:   Mon, 13 Feb 2023 15:36:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 17/17] arm64: dts: apple: t8112: Initial t8112 (M2) device
 trees
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-17-cb5442d1c229@jannau.net>
 <1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org>
 <20230213140113.GE17933@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230213140113.GE17933@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 15:01, Janne Grunau wrote:
>>> +
>>> +		pmgr: power-management@23b700000 {
>>> +			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";
>>
>> Why this is simple-mfd?
> 
> I suppose because the syscon device is not limited to power domain 
> controls. The dt-bindings in arm/apple/apple,pmgr.yaml specify those 
> compatibles. See the original discussion in:
> 
> https://lore.kernel.org/linux-devicetree/57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st/  

This did not answer my concerns. There are no children here.

Best regards,
Krzysztof


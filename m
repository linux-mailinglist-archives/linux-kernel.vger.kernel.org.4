Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3A156D2934
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbjCaUOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCaUOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:14:08 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E514422207
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:14:07 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id h11so23430225lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680293646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n67xfSkcpEtzX5QMjPKd5APTdmzHsGNsYGFEMF9r3z4=;
        b=j/nQxlj0CtORf51Pr4WGYWNzsSg94CijuqLmO5HqGRUpTcW1xvZumxFBZ4jBBRzCDc
         49Uugh0CRE502QRobTEjgpZb8t9POu1D6koVJ5KvCUIpwB1OHcQJnsYacgl7rApgUaUp
         dg873Kh7NYt79jaTHRR/0C/XBt04gKiFswvW5OGpf8prQId7c/i6BW2HAGOapMozHaVP
         Exey2FR9oJkHtffmEO/uHjtzBnN6e/wTOQ05reb5rBW3kDTrZ/IfWRDVpKbNy9yHLnxr
         LTVQ1mIQcWoe7zM5beLtq2bSN5BuBAbmHwWEov0NkqbU8DEXvm3ppV4WFpMTdMs1t3qg
         WfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680293646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n67xfSkcpEtzX5QMjPKd5APTdmzHsGNsYGFEMF9r3z4=;
        b=xhC4zzPL4SZHcP8+limNRkakKqtpnKeH4gVZqtTbwDpfBqpPGIqJ2ihFRvOB1yqZAC
         FDgRWNKXgIq9EiolWX6obTKKZJH/WgINbdKAlY9OwzPmL39yIecZgWlo/lesX1i8Ly5q
         QIjxTeQt4Q4EifYnCMeI9C9zHy6//OVMnkOKztein2J9t4zgZZEJOA+ouCfp0Ix+cvRZ
         Nqk8DJsSMx84Qxao4Ga+zUt/zkXZKOelG+bk/1nCdQeS/+4qkKDmYbpZaLGHCfqdQp8H
         2H86Ovask1TBK/F8l7PuBO2w2bMOF21j+UzPOteEWOJBn3ihx0FsM/LX3ehwNIeW+4aK
         bBkg==
X-Gm-Message-State: AAQBX9fodwm3CquKfbnTJkTBGgdWQags8MlqcpuaNL/AnQvY9d2v0L19
        6RkyhwXWIZdWkoDO++zQ5b74/Q==
X-Google-Smtp-Source: AKy350Ze34MZWNhO2btm8AEIkdzcD7WnSrrBXF/Z9Y+QYP4+BZrisSzYXWjbJE4HnkbB3oP1ygYaug==
X-Received: by 2002:a19:ee05:0:b0:4eb:680:391c with SMTP id g5-20020a19ee05000000b004eb0680391cmr7159612lfb.10.1680293646193;
        Fri, 31 Mar 2023 13:14:06 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id w8-20020ac254a8000000b004e83f386878sm504872lfk.153.2023.03.31.13.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Mar 2023 13:14:05 -0700 (PDT)
Message-ID: <80e42b88-fd86-1692-4e52-a3629165c5c5@linaro.org>
Date:   Fri, 31 Mar 2023 22:14:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 5/9] media: dt-bindings: cadence-csi2rx: Add starfive
 compatible
Content-Language: en-US
To:     Jack Zhu <jack.zhu@starfivetech.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Eugen Hristev <eugen.hristev@collabora.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, changhuang.liang@starfivetech.com
References: <20230331121826.96973-1-jack.zhu@starfivetech.com>
 <20230331121826.96973-6-jack.zhu@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230331121826.96973-6-jack.zhu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 14:18, Jack Zhu wrote:
> Add starfive compatible for Starfive JH7110 SoC which has a
> Cadence MIPI-CSI2 RX controller.
> 
> Signed-off-by: Jack Zhu <jack.zhu@starfivetech.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


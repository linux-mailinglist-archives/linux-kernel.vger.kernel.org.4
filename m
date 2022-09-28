Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43BB05EE396
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 19:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbiI1Rxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 13:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbiI1Rxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:53:37 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF89FB33E
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:53:10 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id j16so21533893lfg.1
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 10:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Vcqtdnkvj8E1ldfON+g0kjMIXp26wYlPSwSJlx1Z+zI=;
        b=byoMi1LOklJOZFggEC3HYt59rIuVIY4Dvo+Ov6JeKwMDS4MTeiIQT3AkJjA1NfqLVT
         AEcTPXUh9FVRicqzFZqFJMCkybWI1HnQv1npA01/ROhBSBYjda0jrVVsOeId0Pyf5vp4
         h347cFliyzHKADtvSMqeEdAyBAoi7C+DB/hv1shT6QE5LM6g6kiDAJybZX2bBifr1FaO
         kv+RvDX0t27zZYriMdWus7AI4tK/IzWkcU5zHXzqVkBDPRmqadWRQxv62uFMf5pesOVG
         QTLTtOgXCzBrsnNRntsYBWLzTY73PBXfad9DZYFs4yzh5Q12hsfAmB5uM40fwLmoGGo2
         bSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vcqtdnkvj8E1ldfON+g0kjMIXp26wYlPSwSJlx1Z+zI=;
        b=a7St79Yg6QmEVuVaMSJQ0f2kWhaUzqzKqLzQFHN1tMSEzMxLRlHv4aoNgoMRBtX5m1
         M42jr8YOO2F0WXXMiw7Fo7Ic6itpmLxu00/WcRU5U9yRDjnRMc1ETUV1S4RGEswZ/3pj
         CKRXBs0KCCmtC9AltiZJJ9t/FVhqrLz0bpDdcucXY7iKNg47IvASpYg2kFTzGe3XCESM
         Z+IXiJDhsBJmeJKjDogB+FmxWaQGKSqt+rlVbr8JQVP35WJ4wfR/7/ueLitwoaxiiUwZ
         8CM7GczNcBbd+42H5ViKfoXZMTKHgmAWYVKJ4dpItZCn2lhJ+Y045gLeyTr98wNEpxlY
         Kq5A==
X-Gm-Message-State: ACrzQf2an8JHw3JonR/VOXxEoftV+dR6nQU9MIfzwJaAJ/zos89blRDE
        sBfpSjLL220vlMRsjagep4aVNQ==
X-Google-Smtp-Source: AMsMyM6BgzODaHTfBrx34XfoJcT/1t178R/FMLrqgzid4kU4W+U6XHasiC4SuUJmMszh6C3eQ42dFg==
X-Received: by 2002:a05:6512:22c7:b0:49f:c780:4886 with SMTP id g7-20020a05651222c700b0049fc7804886mr13118925lfu.389.1664387589153;
        Wed, 28 Sep 2022 10:53:09 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id bp39-20020a05651215a700b0049fb08e91cesm531101lfb.214.2022.09.28.10.53.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 10:53:08 -0700 (PDT)
Message-ID: <a58a4022-ab21-6833-d13d-c3f35fc7caec@linaro.org>
Date:   Wed, 28 Sep 2022 19:53:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 1/7] dt-bindings: arm: qcom: document the
 swir,mangoh-green-wp8548 board
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20220928-mdm9615-dt-schema-fixes-v1-0-b6e63a7df1e8@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v1-1-b6e63a7df1e8@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220928-mdm9615-dt-schema-fixes-v1-1-b6e63a7df1e8@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2022 11:14, Neil Armstrong wrote:
> The qcom.yaml was lacking documentation of this board, fix this.

It is documented in:
Documentation/devicetree/bindings/arm/swir.txt

so remove that other file and instead describe it like a conversion.

> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0925F2BE3
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 10:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiJCIeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 04:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbiJCIdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 04:33:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7307FFB6
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 01:05:47 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id hy2so20386862ejc.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 01:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=VxLz+CiueyVvu++oqIB4n8YZjZ9RxrwPKFRwIt+z1C0=;
        b=Bs0SQnQj+Xmn6KqExiDiGgUwHoJqM5rizfJiThZTYtkBuatI9cF8KdjbC/uTfBVDhV
         fIA1COwBydG9dx4qJ+8euEOHJbDjeIwVGPVWwOmP0QiuRNC5Uf7EQnJWopN88mi1OA58
         zKKkNCLrNEFqVWfJDbvtDeOuN3zwVGc7kbY2C5SveLwkPqtsPl3IX/3Lh805tUSZ0aVe
         8/N6faHsqSRoEGmuKO8tpCj88KN2ObI1YWuKcEmzhXifhJkanwqEiVCb9QGEEt2Rukyu
         vBaJp/cQ0stxvSL/k6Deafe9/f617wYk3LqjdrQpedkvfztf6iXhAtQPYfuAoaME6EsV
         axdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=VxLz+CiueyVvu++oqIB4n8YZjZ9RxrwPKFRwIt+z1C0=;
        b=0nYGb9flBoQ6j6Fn74B71YGrlVGnTSQPy905UfOMSTHox3MQ05kxwdHyKb30Q4fV/M
         7aMeTQppm4HpUvGrpOr49ovprnz2wm3t2/bvHPUwmBd9QepG5uQcWkP/DwIShy/JKWPv
         bzClJPbOSAyF9U4MgwX9+czveCcW26RuvosYPQU31TSkfcgtsev8oJOnBZRTMSM2y3Bq
         1wxx7ITjtO/uzHcUJC/8/vFTxlRKsaTWWIs4D0u/NXlUHP3a5Ewa8nsmKHXtMoTVLTLf
         EI1H2CIICMOzi2hCGYaSqSKz9vmG8Yh9SEE0s1XaI1ZvL86QCjXKpJ5Q35PZGKR3Rsyh
         YO2A==
X-Gm-Message-State: ACrzQf359IX+IUVSdwUKcaYo/3wOnsQFoRejRgQpCAABAsHI6OTNWT49
        /ujlecF6LHCFT0kzif5jYQ9UqbI2PViQ3A==
X-Google-Smtp-Source: AMsMyM6UWo9ttAvzfg/NKEz06mFrr3n9K8bvsb0F9lo6ILrx2L/rCxI21p/obR2+722kv1KXAzQ2oA==
X-Received: by 2002:ac2:5bcf:0:b0:4a2:4521:634 with SMTP id u15-20020ac25bcf000000b004a245210634mr648176lfn.201.1664781950664;
        Mon, 03 Oct 2022 00:25:50 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id cf31-20020a056512281f00b00497a3e11608sm1339726lfb.303.2022.10.03.00.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 00:25:50 -0700 (PDT)
Message-ID: <6c590add-c832-b29a-97a2-fd02efaf1727@linaro.org>
Date:   Mon, 3 Oct 2022 09:25:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v1 3/6] dt-bindings: i2c: qcom,i2c-cci: Document clocks
 for MSM8974
Content-Language: en-US
To:     =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221002122859.75525-1-matti.lehtimaki@gmail.com>
 <20221002122859.75525-4-matti.lehtimaki@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221002122859.75525-4-matti.lehtimaki@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2022 14:28, Matti Lehtimäki wrote:
> Uses same clocks as MSM8226.
> 
> Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


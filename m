Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C168C5F0560
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 08:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiI3Gvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 02:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiI3Gvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 02:51:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D3510EDA4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:51:38 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z4so5471669lft.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 23:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=4B+Bl56spk+pODO7EJb2Jw970de3XRPWAqRz2OugYl8=;
        b=qcGFsciYtF80kI/M2jcxLbmRDrqqV69IG04/sfDGtIIgJSbdrzRj+/Z84OmVrj7+cz
         8C6xW9/DnGgy/FRg1SC6S9FbBYd9j4I7XSU4v6DZIVEzo813bt+K/oKtTQCE8Qk+/dk1
         274IANd41L5O27KfQsbi/E960eFHXg5mY8PHFIqMQ/4UA/ylKOdJd+ragKD6qhexDhmZ
         WJNUEcvg4fpqcq5l9axn3EbsOeMitQJarNQwSZzLgBUcKOaCu3W3nybUGjYjJxLB/UCJ
         B67tsw20V+Lx/IjUkWh6HQ3vFfZ5eI2O/LBkhs6DSvA41K1f1+IN29+ht1rrFGBE7TsE
         6zFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=4B+Bl56spk+pODO7EJb2Jw970de3XRPWAqRz2OugYl8=;
        b=KJcDx7f5BdgODzRNqlQm0TZicpXpkEGdGzLQUb+mz50AU5N0bLKBVCpJnJfmiXgYtS
         NQos/gOWs63pAlUmd4RGTnqZBS0ygvki4J29QvGM2ngFLMZ08wbH6JvhU0QIptDY7S2C
         B2ssObZLkJg9o/+N+ppsNjnasm26lLKrRckzr7SxREePFhutEZ23fWbDn17uTMYi0SJb
         KtqkuG3I3UKeY9tIktrMEk/4CGa/geNd7soKsOshE1q8R0kgmfAW3Au7a00WCtJ0Cc4e
         ZOBgqWpo9T4jE4BUr9QqGfo3amB5ODZLh5nLPFZmqpJJXCovQC8quXRprjkjJRHj6Zw4
         gzug==
X-Gm-Message-State: ACrzQf1IKCQD/EuOja2ERQAbhghye83IcM1Ipycx/EOjKirWmXaGhyZt
        wqjSiDdOjrPWlELGdrkTlJv6Ow==
X-Google-Smtp-Source: AMsMyM7WIJ/osT0A9NNpRN2ZQ831fWdLzmt680XpGMGIhG78S4TAirKbJVdyMeip9x8Qbd32GJTvKw==
X-Received: by 2002:ac2:52ab:0:b0:49f:543c:c5de with SMTP id r11-20020ac252ab000000b0049f543cc5demr2727119lfm.650.1664520697170;
        Thu, 29 Sep 2022 23:51:37 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g22-20020a19e056000000b004a0232613desm194606lfj.205.2022.09.29.23.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Sep 2022 23:51:36 -0700 (PDT)
Message-ID: <02b97b75-8581-7132-62b0-39e9483eb6c3@linaro.org>
Date:   Fri, 30 Sep 2022 08:51:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 1/4 v4] dt-bindings: memory: Factor out common properties
 of LPDDR bindings
To:     Julius Werner <jwerner@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Jian-Jia Su <jjsu@google.com>,
        Dmitry Osipenko <digetx@gmail.com>
References: <20220915003222.1296421-1-jwerner@chromium.org>
 <20220915134407.GA1168889-robh@kernel.org>
 <CAODwPW8=+a0oKeqeFz-Nf-RX2gir1=0Y8B-PvufSYM+_T_ZUvQ@mail.gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAODwPW8=+a0oKeqeFz-Nf-RX2gir1=0Y8B-PvufSYM+_T_ZUvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/09/2022 03:00, Julius Werner wrote:
> Hi Krzysztof,
> 
> Just wanted to quickly check on the status of this patch series, are
> you good to take this or do you need anything more from me / is
> anything still contentious? Do you want me to send a v5 with Rob's
> Acked-by/Reviewed-by tags (apologies for not gathering those up
> earlier)?

You got some comments from Rob, so I was expecting a new version.

Best regards,
Krzysztof


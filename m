Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAA916782BC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbjAWRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233555AbjAWRQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:16:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78DC2E0FD
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:15:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r9so11490525wrw.4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 09:15:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wGAaeFHRUbbcLchitvOo8c3uIrY8nrhrwfD9OzyUHHE=;
        b=j/3e0s3ZNLlg6zARvUYvUo+MRXgYBVxsoHwtK4slffkM3LJS57gKTVI/MsNRDuaipu
         uZ3T5Egu0VZ7a3N0mn/EebgB+NlsDgWVcPJzLWprU1ItMPE4eruY/smltPCXeIj1vfoY
         Xk73Lu3LA8MBMvhYG5p39J5hZj2Zcwl9CO8V9pQMzv5dxD2DvZcxB5jMQ4PzyEhdSTz5
         yqJ5rnH5u9ksn4uChRow+ntFfa4QttTJaKyr3wcLAZPiizl+s3Rr+RIw0nWSW0P5zGA6
         kVHcQj4EdFcVuT/jf9pBRX/zDWRRUR95n3B2wXjqNqmR3ZQucuYeVTcpO35KekFutNUQ
         lnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wGAaeFHRUbbcLchitvOo8c3uIrY8nrhrwfD9OzyUHHE=;
        b=6sYcaDztaiYzo+uRqGfcOFxTEsHAJvxH6qVOoy0LIZX8fz2j4Io/k+7Sqmwforlcmc
         ehe3k/9BMeI28bKvt5Vi1lIABMeUBOX/75VBfFHsBBlKMpthU2TAheIo5EXFAvYhEFZT
         FQYsxPXmBjCa4YbyzKRg3zgmVICsYctEhxYYyvD28wFqYo294EtjPoaHvbWaqCXLfTrT
         ynJd5g5RZSz3UpQBNdQctME0IcAA4VlzkooGkw6K9yPkh43x8s8bWnF9BcIGeBxhy0rR
         AnJUQLvkzj8yT46rQPxEqcpNsNHim8wR0ppOb9QV+fY9+34YKRNbBhYcQeK/YbwabKMz
         Liiw==
X-Gm-Message-State: AFqh2kpx/yw4y1HEQn4bAiL868480xrJE5fpvRRiesKzsszkX0XGB1kc
        Gwb5eCjsqnN8TAcWF+drSOaqGA==
X-Google-Smtp-Source: AMrXdXuwX8R2g5rTyHK8O1HpVuy3t+r8vVzoPIZ0LTPfIDjn20xptFDKQ2VmDXw4q4jvVdhXPKBRbg==
X-Received: by 2002:adf:fd83:0:b0:2bd:dbd8:d41e with SMTP id d3-20020adffd83000000b002bddbd8d41emr21927689wrr.57.1674494128460;
        Mon, 23 Jan 2023 09:15:28 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id j14-20020adfb30e000000b002bbedd60a9asm827309wrd.77.2023.01.23.09.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 09:15:27 -0800 (PST)
Message-ID: <9464494f-765a-95fc-ebc0-f225b1c8f9a3@linaro.org>
Date:   Mon, 23 Jan 2023 18:15:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH 1/3] ARM: dts: qcom: samsung-matisse-common: Add initial
 common device tree
Content-Language: en-US
To:     Stefan Hansson <newbyte@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        matti.lehtimaki@gmail.com
References: <20230122144749.87597-1-newbyte@postmarketos.org>
 <20230122144749.87597-2-newbyte@postmarketos.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230122144749.87597-2-newbyte@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/01/2023 15:47, Stefan Hansson wrote:
> According to the dts from the kernel source code released by Samsung,
> matissewifi and matisselte only have minor differences in hardware, so
> use a shared dtsi to reduce duplicated code. Additionally, this should
> make adding support for matisse3g easier should someone want to do that
> at a later point.
> 
> As such, add a common device tree for all matisse devices by Samsung
> based on the matissewifi dts. Support for matisselte will be introduced
> in a later patch in this series and will use the common dtsi as well.
> 
> Signed-off-by: Stefan Hansson <newbyte@postmarketos.org>
> ---

Decompiled DTB is the same, so:

Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

(although not on a device...)

Best regards,
Krzysztof


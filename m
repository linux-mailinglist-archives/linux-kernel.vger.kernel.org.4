Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF57D65FD7E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbjAFJTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232556AbjAFJTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:19:37 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D5396B5E5
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:19:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so706746wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HBvK4FbyjugL/NTQ0CwTNBhtYz4NAjQXr3/z7/3gv1c=;
        b=KguTVW0zMu+a4TkWdjQOCghkO44wZY1ikqaFifFYt8+opXcFZ4er5Lq2rLzH48cBXj
         t5MPgc1pg8frJ6Ui6gFJRFhuWPKHw5KohU6ob9GJlxA1IQ0D/0dnafiHdXQ41rmMcWWk
         w6vizNfQU6mFIuZECInhojR7wTiX5deDZprk/1dhvMt/cssaYuw+hr2uVWUNF7ay21SN
         ecdYkyok+gMX5BKtK6P5jO9J5R/01RvWDgvSNIVeH8hYxYYkhAnMiAiD0Mxx2lJXzBXV
         1XfJIn6qcvhPvBZNBHNuZS6Wpc0etRcDInZR/+Nh+rXW+DrKT4XElHKoaLCmfq32Ns2g
         jurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HBvK4FbyjugL/NTQ0CwTNBhtYz4NAjQXr3/z7/3gv1c=;
        b=GZbqFP/b7ej2PPzKVOI4hgJTf3tgET7xESXXRtx9DHG9cUawKxdX93UKhATihzUnEV
         u6CJIVnOxW7TUK7m8DNgU6L6dpQXnoQVCHAN//SvPatWMaFA4DJTfPzytKt8OEz9d/nN
         NR5lcQLWxto7qRVnjEWfmKJOnxzlYDm8wL79DeD5Za57Zn4Oju0okwgApq1bBgdcatVZ
         Vt1cCfLCvftbltw7bS4Af5jXIRbzBx5/eEc4LYrlRZR0/T66GurzFs+lWTXO5D5VDHMn
         Hj4AhmkVQBCSB8bgLB8OZnet6uEGFJM/Wl+v/iSw+MP0roM6hJuA84pbz1u+x8Pg0Ui7
         KsGg==
X-Gm-Message-State: AFqh2krsUfqJ6x5GGrr30oMw0V+D6O3sMD8tHgnf+YghQfg0JP+i9EUO
        J2uQcG+bVl21vA79UB1cI8zN3A==
X-Google-Smtp-Source: AMrXdXuSNM2Lq+V95/prLY3ph2EizEdVN1Dv4ZsinbWWmgY8IDYy7I0WuxBpxqKrxbkW8QjsPK1aYA==
X-Received: by 2002:a5d:6808:0:b0:272:3a86:29c1 with SMTP id w8-20020a5d6808000000b002723a8629c1mr31438869wru.16.1672996774576;
        Fri, 06 Jan 2023 01:19:34 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m13-20020adfe94d000000b002714b3d2348sm612611wrn.25.2023.01.06.01.19.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 01:19:33 -0800 (PST)
Message-ID: <f2566d6f-3cb5-9985-ebfa-87ea56d56718@linaro.org>
Date:   Fri, 6 Jan 2023 10:19:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/2] dt-bindings: usb: tps6598x: Add wakeup property
Content-Language: en-US
To:     Jun Nie <jun.nie@linaro.org>, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org
Cc:     sven@svenpeter.dev, shawn.guo@linaro.org,
        bryan.odonoghue@linaro.org
References: <20230105075058.924680-1-jun.nie@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230105075058.924680-1-jun.nie@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2023 08:50, Jun Nie wrote:
> Add wakeup property description. People can enable it with adding
> the property.
> 
> Signed-off-by: Jun Nie <jun.nie@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 3 +++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


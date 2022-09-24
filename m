Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6E05E8EA2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 18:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbiIXQyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Sep 2022 12:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIXQxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Sep 2022 12:53:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2682E9E0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:53:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id i26so4720958lfp.11
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 09:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=m0PT28nsrsAiwm+d/SfcMr5Oex6iVxmoaq7Jg5RhoYA=;
        b=OSbBCdmJ840xiC5/OHQSoqvFn95W0ajXt/DNwc/tRirbedoIFm/N7Nx++vvO9YRTqP
         309dI/NKQ0+CRMfTtDURVpvPnL5AMlMU6fm4IxTH4CNzddZ7mDUbBOIKWDvPsTF2DI1Y
         F6qg6zST94UzoDXRgLms1g31i+7FQtO4O5aqKin+9AzuQ4EpgJpbJqyOf6edWIuTNsAk
         PQF61sHcdCNd4eanGSS3Cwd57PSRaHhNqTP0clz8HRFfqFBQrs24e5mP3yXH5fImA5KW
         gX1di2yiRzghvTAxN45N+Tm+ssyS/paBYeOPPpOXZxrfhwwcSTw/Rkx48lrxW2Fw0/xw
         cKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=m0PT28nsrsAiwm+d/SfcMr5Oex6iVxmoaq7Jg5RhoYA=;
        b=1Ib8XAXCDBdlARUtCpxnfP9/RdI4i7rVIlUe7PE0r3VV/Xc6OHSXvNFby0gI64VREH
         L6gjaceggub6es38eqzJjRtDeQ6HbcPQtCfbZ74Nu+9GVKbrt0sc5T8VRcLsEM3/b5bN
         eZ6LzOPD1GGc5FwRnA/QxqUuWHvWfxRErDsrIQNpjKiIw7OokrLwcF1tQBQ9tSRmVt/f
         5ssPVZ7f+y5sYqqK6nuuY3jp7D+Tu65l7VOFdKKL6jrfwokzkYwZYOd668sRUSLWuEr7
         RGRnUflw8cvpS8CRc8nWBnk8hLkB2s+Hx6dHIEvJKtUtW3S8mbFWO7jXeez+IDiVT6/Z
         /P2g==
X-Gm-Message-State: ACrzQf1IexHjU6nQwBTQjlVt4x3EwNX0P04HtXxqgamOMQfx9XSTTFs2
        rUMPDHEB4cbcbMhwNozMvnIRYQ==
X-Google-Smtp-Source: AMsMyM7tSptZVBxYgc9j7wkrPycfKbhavRuvgF/a/6bf63nz7er5iXO2CeeNjWP9twazsberkj1TxA==
X-Received: by 2002:a05:6512:3f08:b0:4a1:af5e:5643 with SMTP id y8-20020a0565123f0800b004a1af5e5643mr935183lfa.86.1664038432279;
        Sat, 24 Sep 2022 09:53:52 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k9-20020a05651239c900b00492b494c4e8sm1925202lfu.298.2022.09.24.09.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Sep 2022 09:53:51 -0700 (PDT)
Message-ID: <daf1b77c-e752-70d9-c0eb-81d5a9adaa86@linaro.org>
Date:   Sat, 24 Sep 2022 18:53:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220713200123.22612-1-pali@kernel.org>
 <20220808202352.iimhb2q6yawi35y6@pali>
 <3b80983d-93e9-9663-f569-7dda5b738cf1@linaro.org>
 <20220924143004.evsnw3xaplc57aot@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220924143004.evsnw3xaplc57aot@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 16:30, Pali Rohár wrote:
> On Saturday 24 September 2022 15:50:38 Krzysztof Kozlowski wrote:
>> On 08/08/2022 22:23, Pali Rohár wrote:
>>> PING?
>>>
>>
>> You got the ack, what are you pinging us for?
>>
>> Best regards,
>> Krzysztof
>>
> So, who can take this patch?

This looks like platform bindings, so the platform maintainers. Would be
easier for them to pick it up, if they were CCed. :)

I actually hoped they will pick up also fix for maintainers entry:
https://lore.kernel.org/all/875yi5g96s.fsf@BL-laptop/
...

Best regards,
Krzysztof


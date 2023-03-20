Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77146C0AC5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCTGjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCTGi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:38:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E11EB126F5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:38:54 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er8so30747101edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:38:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679294333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aL001ady4NA4/hsn4xZG1v6Zr6XG/l61DgNleMsf6i8=;
        b=OJAFgmI8/InvLBl0H5GobooZ6YXV9wZLYH90nbnlVGtt4s3AkYiORKceYX+YwHrDDZ
         VEp7fhZ7AyVWCU29ZVQBQrZyzIhRnM9ZLVYY7MO8ZBRhOWmqrR+Aj8od2AVHqNJnqQRG
         z1UXbLHDbarDcDtFd3RZQKUHTQyT+umQ9LI7odgCv0iXxJ+TgI5Iv6S6KGb58ZTilNbT
         UqChP8OQXci0UX5vnmX2HDG9jtVLX1x+/SMRvEfhHS/XoCAPKhEJ2K0Wj7x+rs7nkOSJ
         9oFGvS8ea5TLwRmOg016dkzmFlk+diHLpl5sZd7Tt/rKlXkhfR3ZNcI+eaVVfOGW5vmV
         5XvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679294333;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aL001ady4NA4/hsn4xZG1v6Zr6XG/l61DgNleMsf6i8=;
        b=JxGJZJEi7qdM8U6zJh49tbI5scaomMCFZ9mgeJ7k4r8eZmNsowifYn0MoZg7/hPU6j
         ltkURunz/DjhePmFqcV0SC8Xd7ax207WIX2EhuW5T8zTmsxO/9vqWlI2BoLyOrcLMW8s
         +Huw+04JHdmZyXJXMRnQ3fh+TCu83dCxSDtLNnWfcH+qmSe3YApkn2P9s7nfl5dKPt65
         SIfAbze/ILg+tE23RpvB8ms4Baru1eSAh1udNCu+fA3VNvQZ/EbZgtqMdW+L1b4N0U0a
         QZE4wZ0dRl9CsPYsrhZHcWVc9V+zht4Ivrdk9/Prdj400VROX5wfqw7IcFo4vNbjx2jJ
         Wbtw==
X-Gm-Message-State: AO0yUKX1pGrq5XI1ZqQR+YZ0uVJ3xCvvq6UnvDjOpFNNPAE0OD6qN3rN
        ByrnacoKq2YOIHo6enrUQqlORf+SdXH5GPBXSkA=
X-Google-Smtp-Source: AK7set/ZY0jx52sr1B3qF/Hpsv16SzPgkWnQ2bQGAUShEUbpOMmPcYjIMDF8J7VRk3bDNNkFO3R7Vw==
X-Received: by 2002:a17:907:7294:b0:935:20d8:c3c with SMTP id dt20-20020a170907729400b0093520d80c3cmr1391024ejc.61.1679294333377;
        Sun, 19 Mar 2023 23:38:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4428:8354:afb6:2992? ([2a02:810d:15c0:828:4428:8354:afb6:2992])
        by smtp.gmail.com with ESMTPSA id jx3-20020a170907760300b00930876176e2sm4009892ejc.29.2023.03.19.23.38.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 23:38:51 -0700 (PDT)
Message-ID: <ccebb1c9-bbf3-8998-6611-8c0046a6e3d6@linaro.org>
Date:   Mon, 20 Mar 2023 07:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RESEND v6 1/2] dt-bindings: soc: starfive: Add StarFive syscon
 doc
Content-Language: en-US
To:     William Qiu <william.qiu@starfivetech.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>
References: <20230315055813.94740-1-william.qiu@starfivetech.com>
 <20230315055813.94740-2-william.qiu@starfivetech.com>
 <9dfc752b-7ae9-5e45-e9e2-50b87dabbca6@linaro.org>
 <adcbc5a7-23e7-9396-a67b-776653e14b8d@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <adcbc5a7-23e7-9396-a67b-776653e14b8d@starfivetech.com>
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

On 20/03/2023 07:00, William Qiu wrote:
>>
> Originally, I only wanted to add a base module, and the binding of other modules
> was added as incremental updates by other related colleagues. So now I need to
> add the complete binding, right?

Binding should be complete.

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 683DA694404
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjBMLME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbjBMLL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:11:56 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767DA18AA4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:11:31 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id m16-20020a05600c3b1000b003dc4050c94aso8705947wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9F7cJax0QH/QZaBK2YDN758lsvYWSdX4ohNIeUxAEAM=;
        b=SVA4Dj5Xuyr9HVEH0lvTiL0cMIi+LvPIeX86RcDpd+cPeDOhEjxwaaZwt3SPcz7TWG
         8ChGY5xRhFwZAgmccT85G0O19W34h7jaMBg1Udvnl9wEzPNLYBhnSdrzd0HoGVJ/AEBa
         nx9+E8qh3R3ttfHLlZisIn38JBhH1vHdZCkTBKS508cPMFM5G2GkqTYtsSsEV22GVZBv
         roSImdoCRaLJ+3MqOcU+I9I47t0h+VbRUXdgyWEe0qnjxr6nda5tW1KnlrJ00M632ORp
         Tz+3YzbRI7KcoayGIR2bYZEZdZtBLQfj2RRQtwPt8Nz+bRJURmx92RETNDLEmh1wn6g+
         todg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9F7cJax0QH/QZaBK2YDN758lsvYWSdX4ohNIeUxAEAM=;
        b=1xZcrXOB+5LSLf/wY4zQ4TSacDut0VIKjzF/LjjH+V03JnodFsR+LSrbLTU+6NLcRA
         yASnR29KuJQ4+1095KeoIYYgxqhWprtgzo1LiMCBe1L6y6lhGKszff1vjPq9GjC4KCf+
         jmOSNJhp8sDj9NASwCsj6zzsO1tIPDHgQd5iHf6EQYiOsvgFKwLlLE1BlrrjApNZpE41
         Xz4wKu6NkRDeTRLDXsgLiXqaepdmhgs73UyrMwKKocO7iE75Fj3SIEsciNdn7Fpy7hW3
         tf6ji+UhRBvmTOdjxGIPg2iMLcvktreWGig4bHaqCgGIBTy2kfq1fjuaaXyU0gz6v/a2
         /nsQ==
X-Gm-Message-State: AO0yUKUwKX8FrASj2F/byp5JCIH7kyYLCldLBzr3Lv+H5AnSnAmuJt6M
        TKr6j66YrYXxRN4QHDM2pPF/fg==
X-Google-Smtp-Source: AK7set9Ifw0+tELdcUwLkSrgoYRSHeB+Wjh3bsRxKQ7ICkMhR+qYAHJfbsSS0fGi6pKvYn6YyOEvjg==
X-Received: by 2002:a05:600c:502b:b0:3db:2e6e:7826 with SMTP id n43-20020a05600c502b00b003db2e6e7826mr22764706wmr.5.1676286682837;
        Mon, 13 Feb 2023 03:11:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m24-20020a05600c3b1800b003dc41a9836esm15156957wms.43.2023.02.13.03.11.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 03:11:22 -0800 (PST)
Message-ID: <942dcc16-9d7a-2f7c-763d-47515030931c@linaro.org>
Date:   Mon, 13 Feb 2023 12:11:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 03/17] dt-bindings: watchdog: apple,wdt: Add t8112-wdt
 compatible
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-3-cb5442d1c229@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230202-asahi-t8112-dt-v1-3-cb5442d1c229@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2023 16:41, Janne Grunau wrote:
> The block on the Apple M2 SoC is compatible with the existing driver so
> add its per-SoC compatible.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> 
> ---
> This trivial dt-bindings update should be merged through the asahi-soc
> tree to ensure validation of the Apple M2 (t8112) devicetrees in this
> series.

Same comment as before, that's not a valid reason.

Best regards,
Krzysztof


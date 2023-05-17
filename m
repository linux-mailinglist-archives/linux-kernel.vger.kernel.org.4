Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB52706812
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbjEQM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjEQM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:26:43 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45D164C33
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:26:41 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-96adcb66f37so128885166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684326400; x=1686918400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=USCAL9ci1L7Jzt1hbuawF3JoWW9gk40TXqU0TdQgN7A=;
        b=rBxPOoatiE6lQtfsIe2prpdVTm4pN2hVFWYMbq7IbMBPgmTD9s1SOVfquSomV/TRtx
         qhvmyjk/w5tTkagRJ+fjUqt5MB6VlHaaezKlXwb/FFgCXDjEVAwHvk+Xh/w7HxEecIdZ
         SRK4w+AcrDA7NED7xbXay4hbP6al5WjyB5PhhQNqrkzOytqzX1py+XRUffWmFoJJqy54
         kjNqTkLiD8j9lla3pGtUdnaz420SYdl9oPwGTC6lEYf10Nh9EwOromW+jzGhJgsIB1SU
         5wwjy+C6x3xNOQR7u9A0rMzw6WemCuBeb0EC1W+bFfWBY2YwhVtJa2/RNqyuX7zt5Jiq
         BhPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326400; x=1686918400;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=USCAL9ci1L7Jzt1hbuawF3JoWW9gk40TXqU0TdQgN7A=;
        b=fR10WIavJ/A7sy5iWKvQxdDBB7C1zDnBSdR33ik+m3p+3eL1ps7gNoJBrQdAGxATAC
         PRmSglV/jSz8TW7iNqLBlcDmfyZHNMZ0gaNOrljWL8ZOr3EvBy2TclbdBsZ2orzJPvT8
         9dCeCBe1XGUjDbM4f9VHwFYKPn0TOLvRUZ7iA15D74bUaG8GA3JsW/2ibwOLm2xNjxdF
         JnMq92qssXE8vTMpZ9uKW9qVtTPeg8o43kgeKE44Ij/B8PAsX5GuORrSWnaxgE1h/urk
         tG8PRgriaddPsHke/lwsx3DbaFulRWaPhnrIoabRtUzSQedab41vtKeOwv0gADbZxYhc
         DO6A==
X-Gm-Message-State: AC+VfDykXpnk7+xj/VJb898xQo679iS7vMCq7IuKV2JPvnev3zTNIkEy
        OxGJ8ay7z0mvea0pBf2vIj9VFg==
X-Google-Smtp-Source: ACHHUZ5g/ll5J8iQENU3Sb6MJRgdWLOVh5T/ZeijhjFZuoZw/kpBk1hE9MLzyKB6KLkCARBabAvQrw==
X-Received: by 2002:a17:906:4fce:b0:965:a414:7cd6 with SMTP id i14-20020a1709064fce00b00965a4147cd6mr41653146ejw.17.1684326399729;
        Wed, 17 May 2023 05:26:39 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id w5-20020a056402128500b0050c03520f68sm9403339edv.71.2023.05.17.05.26.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 05:26:39 -0700 (PDT)
Message-ID: <6c920568-4407-29d9-d7d9-3fd5c8d6e30b@linaro.org>
Date:   Wed, 17 May 2023 14:26:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/3] arm64: dts: microchip: sparx5: add missing L1/L2
 cache information
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>
Cc:     luka.perkov@sartura.hr
References: <20230221105039.316819-1-robert.marko@sartura.hr>
 <20230221105039.316819-3-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221105039.316819-3-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 11:50, Robert Marko wrote:
> Currently, when booting on SparX-5 you will get the following error:
> [    0.050132] Early cacheinfo failed, ret = -22
> 
> This is due to L2 cache node missing cache-level property to indicate its
> level, so populate it to let the kernel know its L2 cache.
> 
> However, that alone is enough to get rid of the error, but then the
> following warnings appear:
> [    0.050162] cacheinfo: Unable to detect cache hierarchy for CPU 0
> [    0.093256] cacheinfo: Unable to detect cache hierarchy for CPU 1
> 

This did not apply, skipped.

Best regards,
Krzysztof


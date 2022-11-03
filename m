Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C416617CA4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 13:35:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbiKCMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231680AbiKCMfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 08:35:12 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFB2BF7D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 05:35:09 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l15so1082666qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIhE5tTAyhN78d6a2N8YuzGDstI/Nrsk3pPBZ8RS5Yk=;
        b=YYxU3yG4i+301n1Yz40+nRHTTCJgk1T3Tym8Fiq6TDBNv+1KQ4YVl6p/PAtepKSRD/
         AIuaoJN05BZEoSv/ZELW0H8b95Yj6W8Pfqke5EVawTofFSVabfowL6RiNCh8h0Mnfauw
         Jo6HIrq42XRW2eoecTxq7xKJl6vSQCEAsPKnJS35EL5OhpMOzofeqXHyv3m4EyVFWoSq
         yXqs1qabKHqDSDOGe1/5dZ0G3CLWkvLyJru+ZQPcJOwCJ4i+OpC2VQ7YtkI/+8j6qpr2
         1MmZTTMG/XDpeZoV8ZpuELpevhdvTClO6G2jAgSPmKgf9BLX/7lXlAi01DBFSsUWkIxh
         NrWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIhE5tTAyhN78d6a2N8YuzGDstI/Nrsk3pPBZ8RS5Yk=;
        b=ofyaTAUWlh6bE++g/x+Ppadd+oH+I6rq6TLDs0hA9qg5t6ohDqq/UJqxoSignhcX6L
         FmjxGSZCXpTEpqr8tJlZVUs1BdSgaxECcBE3g6Xns6az7KGy1cenPcaUprfbHl64WQSG
         4JhtXuGqwpS0bdn2l0mkOZnr6Y0bKHaFNy4XG2wbQ2ogeyExFziY5cUkhteaG38WR1OO
         HtF0/HSHepULLJu1J57pi3uVSsh7SYafi5NcbGLOcs6w+2e+CngREcAnfDsg+60o9H40
         Rjc0X5M7AMIOy5nxZ9Z45fGOz0AV+04ObuGNu59dFziHWMESRw1qv0EPeKeSbMT69/+w
         0gpg==
X-Gm-Message-State: ACrzQf2fF6NIUIrukgWg7lHBvJnBIj4yyy83QInDp0IJ3xrqly3EZeLk
        vg8YHNV1y6hhA9lf97d5p60o0w==
X-Google-Smtp-Source: AMsMyM7xMUwtyr9tB3lj38zP1zS2TpQYq3vUnnA9LpvU4xyURUGwzF3DryKpyfcka2lcnVJDZ1anMg==
X-Received: by 2002:a05:622a:5d1:b0:3a5:3818:a067 with SMTP id d17-20020a05622a05d100b003a53818a067mr12241551qtb.574.1667478908921;
        Thu, 03 Nov 2022 05:35:08 -0700 (PDT)
Received: from ?IPV6:2601:586:5000:570:a35d:9f85:e3f7:d9fb? ([2601:586:5000:570:a35d:9f85:e3f7:d9fb])
        by smtp.gmail.com with ESMTPSA id c11-20020ac8054b000000b003a527d29a41sm424304qth.75.2022.11.03.05.35.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 05:35:08 -0700 (PDT)
Message-ID: <c55d29d2-a70a-f2ae-b605-1c63051202bf@linaro.org>
Date:   Thu, 3 Nov 2022 08:35:06 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 2/3] media: s5p-mfc:Add variant data for MFC v7 hardware
 for Exynos 3250 SOC
Content-Language: en-US
To:     Aakarsh Jain <aakarsh.jain@samsung.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com, smitha.t@samsung.com
References: <20221102130602.48969-1-aakarsh.jain@samsung.com>
 <CGME20221102125813epcas5p40a38f17a267276ff8b2bc5861b5d450d@epcas5p4.samsung.com>
 <20221102130602.48969-2-aakarsh.jain@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221102130602.48969-2-aakarsh.jain@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2022 09:06, Aakarsh Jain wrote:
> commit "5441e9dafdfc6dc40fa" which adds mfc v7 support for

Please run scripts/checkpatch.pl and fix reported warnings.

> Exynos3250 and used the same compatible string as used by
> Exynos5240 but both the IPs are a bit different in terms of
> IP clock.
> Lets add variant driver data based on the new compatible string
> "samsung,exynos3250-mfc" for Exynos3250 SoC.

Aren't you just missing the clock on Exynos3250?

Best regards,
Krzysztof


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA9716BE3A2
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjCQIda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCQIdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:33:09 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C37BDDF2D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:31:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id fd5so17329034edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 01:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679041907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F22xKzaXQ16zz1R+nPdvOmBcImJHM2RC64dPlAyscLI=;
        b=aWHmZxuyjKoQeJE36fh5yBR6stqa3XOEzB1SVT5U3CDiWrUEUqd2msGm72CQst+RK/
         Vkvm0winBTSa9GH01ItcF++wZbeu9Ca1O3OtCD+slaX2sfyNvwLNaP1kIkpF3YZUMRQn
         HfvmrKvHVhT+8utKUDchex+GgFH/jLaIYm4bbhg36sw75vbB0yaziDmmZIytqIRMJ/g7
         is+q5vtZXQM8KHDf43TQvE+c6zwdlCIA18cenpVd/XaOf8fvgq8Nh1BPceGza5/jL5BR
         uck6vWW5VahlzU7RL2fq2660WI4kK3wtWgp/dcDhr9zyW0GxJp9pXvMbmxOhPThJ0YhX
         8BDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679041907;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F22xKzaXQ16zz1R+nPdvOmBcImJHM2RC64dPlAyscLI=;
        b=E+CwJNlEJlsUCGgeTe3aJKzdMiAU7JC2lN/qK2ChDcgF8KANo+9KX5hhUSUcmEPmUo
         nzaQugKBYPMjrsmM78io2Xpc3jxidGKBrUih8bSpoUIcx7IPkMUmnJKNtJ5Wk7MmTfTZ
         ZCn/+Wo7sO6DFNjgo0ulIOWnJ30O/ebHHLxGClca4KuBL8ddLzkNYZOzFD1Tcucvz1n2
         BToFYoghl1C27eLuktjR3kY+5RE7rB4Q2LJH0To8dfX3ZqsAysuzopH5u38FDcCxUoym
         YX/Fr4d7lnSbDPQLT4bQinGIe1ZoCgSxpb5CMjZSsIvQioUoU3ilyo3GsUUclGjhnJih
         2OZw==
X-Gm-Message-State: AO0yUKV4zCvC4KSBZZSnnu2WZjRkQ/wpWYDPxdBFYigWor8CVHMyxgGS
        yjeqKALYAt4y3ND++raOdwLiWA==
X-Google-Smtp-Source: AK7set9P1SuFct7TKYsl2uFH88M5Njs8psB88aLuEx8C2MfAzct4blZqPVjveqZ3ledMk3g6rAb+8Q==
X-Received: by 2002:a17:907:6eab:b0:932:3942:f28f with SMTP id sh43-20020a1709076eab00b009323942f28fmr618319ejc.61.1679041907355;
        Fri, 17 Mar 2023 01:31:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:848a:1971:93e0:b465? ([2a02:810d:15c0:828:848a:1971:93e0:b465])
        by smtp.gmail.com with ESMTPSA id e18-20020a170906845200b009222eec8097sm692325ejy.75.2023.03.17.01.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 01:31:46 -0700 (PDT)
Message-ID: <3679f2d0-55f0-1710-abc2-b268b6fc6969@linaro.org>
Date:   Fri, 17 Mar 2023 09:31:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 02/11] dt-bindings: serial: snps-dw-apb-uart: Relax
 dma-names order constraint
Content-Language: en-US
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Drake <drake@endlessm.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        linux-riscv@lists.infradead.org, kernel@collabora.com
References: <20230315114806.3819515-1-cristian.ciocaltea@collabora.com>
 <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315114806.3819515-3-cristian.ciocaltea@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/2023 12:47, Cristian Ciocaltea wrote:
> Commit 370f696e4474 ("dt-bindings: serial: snps-dw-apb-uart: add dma &
> dma-names properties") documented dma-names property to handle Allwiner
> D1 dtbs_check warnings, but relies on a strict rx->tx ordering, which is
> the reverse of what a different board expects:
> 
>   rk3326-odroid-go2.dtb: serial@ff030000: dma-names:0: 'rx' was expected
> 
> A quick and incomplete check shows the inconsistency is present in many
> other DT files:

Why not fixing the DTS? The properties should have fixed order.

Best regards,
Krzysztof


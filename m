Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595825B6BEF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiIMKs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiIMKs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:48:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D5F5EDF4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:48:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e20so20075692wri.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=LJCRMGu9UXK8orOWVRKbRgxw0UO+idyGAeR7Y3jikKw=;
        b=NeSntqardnDjnKrtpeILxp80AOsTlNfRCL7Uql0MIaGOdigKkinqklNZYFwWgL4ysm
         biZEg5cH1vEU0QxxBehIi6/RHlSDx8RvGIbhTMzyDcWR6GfDj2S5o/QZlwtk5PRy8T45
         tRh3Y2YHdG3gyMWtBOe9eWGf/SbiRWqldUV+Ui6nmsfBsh4ZoHTAUhTbyL589l3w9eik
         Al/u6Jxfbye8Of/2qleHhW0HLsdUzBM9nGQYaInf3tnh+aFtlvEX8vcXBY5mRzN7CgbN
         XK1df2zoP8/nEsJMHkB140sKV1GqKWLLi9AtE5UocKtFGOGDCpkr095XySzdELavSQOF
         fbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LJCRMGu9UXK8orOWVRKbRgxw0UO+idyGAeR7Y3jikKw=;
        b=lSEHiSJ/H/8vvGalQ3ADwpcKLEtAgRce/MFFs81ZM6XIIBNRKgUQNqzyi264jAUPGe
         kP214eocB5CIFpdWXqXVX8rbEkSAEn2hwmBaVT+jB1ZMI/Az3auxDUT1NVB7TKX1cjpG
         y8xrK4gHQDMg/EPnC3bgV2cU6NGamwPRJgbj25blowP1wa0q4cMK+9bn6kz6Vm8c9aWX
         TVCPNlAa9anepheRdAV7tiDrvhZGnsklXywWlJIbf1+kWvCAnt1O7P2IKJ2zHbKKGka6
         +Jee5oDfFdzm9FDLbtyxwZ4mYAR6OMASI7A8UOyGoIhJogdV2korfs1IT+tM1QFUNN7/
         UFrw==
X-Gm-Message-State: ACgBeo1hodRYVYQkBkmJVV+h5Jl+ih0TNgifVRlfIN28fHRJgAe1SUm0
        Ff93xrWy60rpcbbEoCebguGNNQ==
X-Google-Smtp-Source: AA6agR4xsP9/dAm7OWDgkbyYRgdEH17SK6tKuWJh2vOluW5ov3tY2rT7SDbc/ARQdL/OHtYIW4AnPg==
X-Received: by 2002:a05:6000:1b90:b0:22a:c3a9:6567 with SMTP id r16-20020a0560001b9000b0022ac3a96567mr191509wru.118.1663066133882;
        Tue, 13 Sep 2022 03:48:53 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b003a5fa79007fsm12042552wms.7.2022.09.13.03.48.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 03:48:53 -0700 (PDT)
Message-ID: <893c8446-5c4b-0e16-6979-632a20c8a201@linaro.org>
Date:   Tue, 13 Sep 2022 12:48:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913102141.971148-1-m.felsch@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 12:21, Marco Felsch wrote:
> Hi,
> 
> this proposal is to mark clocks as critical. It is somehow inspired by
> the regulator-always-on property. Since sometimes we can end in circular
> dependcies if we wanna solve the dependcies for a specific clock
> provider.
> 
> The property is generic so it can be used by every hw clock provider. So
> it can be seen as generic implementation to [1].

Missing devicetree list (so no testing), missing bindings. Please follow
Linux process, run checkpatch and CC necessary people an dlists pointed
out by get_maintainers.pl.

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555036814AE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237854AbjA3PTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:19:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238112AbjA3PT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:19:27 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370DA5CB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:19:18 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id v81so5891163vkv.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 07:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xlsuOCO1YI2MMlgCHeBWLiVMGsqzeJfOwez6+D5kqBc=;
        b=Rx5ZT27gjdzWRwbX0Tyc/+dk5vjX0+wrDP1QTezFRqJJliSPoDMBhicfLS5bNaQ2qK
         oAFH1dCV4eJSERNzDTgg015uP6W+Myq6XEpgVlgjYt91G5QsrCTqG67NFFHak1/Vq2i2
         rxPmR3u+KvTqx/Z2heyy+LjQjzJhCcgo9WgbNJWcgCvTfJl5eUaDIQKLoph1lS3PoQ6V
         EBr8Xne388w6RWcCwaEMLVtXJWsyarXvwhsHDcofkrUNNWG/R2yKqA1mOhKU9TdzR4Bc
         DSRbEESte6R1DvsTknnDSwoPwzu3XNPYg/71uHT/tLNNE4cur/vEdDSBDUxhbfoxGMjA
         Sjwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xlsuOCO1YI2MMlgCHeBWLiVMGsqzeJfOwez6+D5kqBc=;
        b=kV0zEh+0hvoQYPKIViSrL4eR1816z9h2VuUmLkLxRga2Piw8HmygruYTV3JaM1U6bf
         AMxyGXfVo7iilfhjag8rONEPAPqw1jyNPT8oIw/mCRpeuF6TyORReRI90InJBovPgPIZ
         5b/SHstRuGXI+U1pwhd5T0E7z4VD4Gg1315YSVbExtbAzTGO2YQDuXhUUU4fsKJNV/YT
         TIfNLSQvU1CoiEZAima2Z2u8NShEnLmwzOllEzKwoOquvAYw35dPxbCU85uJbo9HfALn
         lLWE4V8QcEiK6KOgWrpuZNtrQsm1n/52xBNIYgMfghvtlnTDIbWysqoAxpqX1Gh8j3EZ
         3KNQ==
X-Gm-Message-State: AFqh2kpSE+000VQv+Sh0XqP6Epmoj3XsniVDd5g2cSJl9sm/z+K0VWLp
        blmBx3W7s4uTLlvZ9+afmO0+e3+eBAW6f+/2nILsrw==
X-Google-Smtp-Source: AMrXdXvrpSfest9Nz2ELy3kyAiLAnfRzOnJ1Y3sWUJTC0FxkcDwpmweJu+nCWsskihnhNOiqk4hiEqyl+u72iE7URSg=
X-Received: by 2002:a1f:9b4d:0:b0:3e1:722f:9a6f with SMTP id
 d74-20020a1f9b4d000000b003e1722f9a6fmr6572750vke.1.1675091958079; Mon, 30 Jan
 2023 07:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20230126-b4-ltc2945_shunt_resistor-v4-0-bb913470d8da@criticallink.com>
 <20230126-b4-ltc2945_shunt_resistor-v4-1-bb913470d8da@criticallink.com> <20230129201604.GA1583293@roeck-us.net>
In-Reply-To: <20230129201604.GA1583293@roeck-us.net>
From:   Jon Cormier <jcormier@criticallink.com>
Date:   Mon, 30 Jan 2023 10:19:06 -0500
Message-ID: <CADL8D3ZkGT51FX5UrCQ8afzFxPNGHbi09EdXqE+cQyGRnHR2mw@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] dt-bindings: hwmon: adi,ltc2945: Add binding
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bob Duke <bduke@criticallink.com>,
        John Pruitt <jpruitt@criticallink.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 3:16 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Thu, Jan 26, 2023 at 05:32:23PM -0500, Jonathan Cormier wrote:
> > Create initial binding for the LTC2945 I2C power monitor.
> >
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
>
> Series applied,
Great
> after merging patch 4/5 and 5/5 of the series
> to avoid spurious 32-bit build failures,
Huh, I split these per request, curious why they'd cause build
failures when separated...
> and after fixing a continuation line alignment.
>
> In the future, please run checkpatch --strict on your patches,
Will do. I didn't know about this option.
> and please provide change logs.
This I did do in every cover letter.
>
> Thanks,
> Guenter

-- 
Jonathan Cormier
Software Engineer

Voice:  315.425.4045 x222



http://www.CriticalLink.com
6712 Brooklawn Parkway, Syracuse, NY 13211

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D7368F82A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 20:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjBHTh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 14:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjBHTh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 14:37:27 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C04129E1C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 11:37:26 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id h16so17880977wrz.12
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 11:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pl3dbhpEG6Kk1GoL/DPqwV3Qyi+vQX/NfFDA0o7wGFU=;
        b=Tf7g5VTRK99FyjQXJoKTupMl38GKbPYe4fIgwxfxZqkvK6ztKyIwCfdyU1XLjbdDAq
         I7RdPSs9WTQRQL9NfVOlQlUOaDdX39bzR0YqKyY2E06/MH0mkxnPHSnoeTB37XBzb4z/
         4kp3Y0xEzR2igA+Dhox2rZ+bUi5FyuZaOTMEVpgBl7e2evWhbJGZMwXqR2qaJBPoUMCv
         oIcLoJIjya4uTk5UB3JfGCh2QP/EN6jPyFqDDJ5eV8UdL6FVgC0OensXWp6zNJb+tRX0
         sY9QDuu3D7xSMjD3cnTVkBT/DQ+3I8Z3w/jh4fMR3Nw1KQyhK5h9RiYk81v+C5xmOPCx
         QjQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pl3dbhpEG6Kk1GoL/DPqwV3Qyi+vQX/NfFDA0o7wGFU=;
        b=FhBbPE7TUKstVJYb6WWAmBw8Xpvmgg6HUfY+zNyFtbH0ucNYjZlXZOSTJ3z2rm1xGd
         fcuGhongmfq02oyyzAxXIamu+mPkjDGDnW22x+4Mny1+HpT9ZA+sWRDnT2LHiXATOYLa
         HUZjWUvBVDx46gTMhY5fjy6BxZtFIw0BSbB4KBvulFxNYYlPzZ/yUmhHSgazvT4vdL5I
         4Dp5yjRfPNwKK8yNKNMqdsPf9St+qIEJuwfP8QPVB1xFw/+vB83TYKN53/KShHULLQy9
         +QdfPSueezPvR3yqhbbTcpCtZ0FyHzlAl+TTNQUlgklhKx+6KpSUIl0gkhRmnyhWzewd
         VDYg==
X-Gm-Message-State: AO0yUKWA5o2P+sxgQyb3XhesQ1alsuaTKPq16XrCAx/G3qdjf6kNwxsY
        tArkh5e55g44giv2aGY7FhAriQ==
X-Google-Smtp-Source: AK7set+SNrYvyRQN/7d2R5sXxvthYndgy/lcDLA1C3Np8r2unDUEEAtE4VjuP+DDWEkWXVDvat5PDw==
X-Received: by 2002:adf:f80c:0:b0:2c3:cdcd:f0b3 with SMTP id s12-20020adff80c000000b002c3cdcdf0b3mr7233340wrp.9.1675885044603;
        Wed, 08 Feb 2023 11:37:24 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u17-20020adfdb91000000b002bdd96d88b4sm14522878wri.75.2023.02.08.11.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Feb 2023 11:37:24 -0800 (PST)
Message-ID: <c876f40a-2db5-eb50-9706-3147671ec4c5@linaro.org>
Date:   Wed, 8 Feb 2023 20:37:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] ASoC: dt-bindings: wlf,wm8994: Convert to dtschema
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        - <patches@opensource.cirrus.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230208172552.404324-1-krzysztof.kozlowski@linaro.org>
 <Y+PeR4EFfcVDbUfV@sirena.org.uk>
 <51e8e157-3f60-1731-a8ca-4a678c8eafd6@linaro.org>
 <Y+PlUtAmbl5TJq6z@sirena.org.uk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y+PlUtAmbl5TJq6z@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2023 19:09, Mark Brown wrote:
> 
>>> Are you *sure* they are grounded and not supplied from the LDOs?
> 
>> That's what I have on schematics (attached), if I got it right.
> 
> You'll notice that they've got decoupling caps on rather than being
> grounded - there's an internal connection to the LDO output so if the
> LDOs are in use that's all that's required, while if the LDOs are not in
> use for some reason then an external supply is connected there.

Yes, indeed, not grounded. I'll rephrase the commit. I also found few
other differences needed:
1. AVDD2 should be always required,
2. LDO2VDD exists on WM8994.

Best regards,
Krzysztof


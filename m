Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 002B86DCA5C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjDJSGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDJSGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:06:09 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8286826A0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:05:48 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id jg21so13964382ejc.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681149946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G9PVist2arUI3kdkR3ttleRdx9YrvXAmoxGbLGAPcGI=;
        b=SUFfmwVSDzggfij1RLzndNQHnBBBk4BxVxk1C2Z8/U3w9EJQNx8TkcxhlS8AEzdke+
         6W6s4H6cwpbibiRC60ftHooMGFC0UuRwROh/6GcefEm6Zep22zc5a3hB/aMBuOlcPMd7
         TvloWPSjvlFjLQbJYZB3tnC9LToSHp23VeMLjvWdB+aBd/OyCny7vvcED7julRJed1tI
         sIs6EzMNo80vodjdMfDhhpCvIt5hWl9lnoVgtCVkScLZj9EvwVw3YSsdEhzzl+iumW5Z
         07jxIPJvs1FzpfPIK1aEjUaZbTvHG+F6jHfh/Up/X+/wHltgWbYpDS+Hy2nwpVrPYe4H
         8DeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681149946;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G9PVist2arUI3kdkR3ttleRdx9YrvXAmoxGbLGAPcGI=;
        b=TGZj5XtzO9AIo4EE/ZQ6Lk7Nl5Be0zsxzxMXcYgVRtDsBB3fRKvLEqiURFhHh2tAxx
         GJ9SSg9DA7uy7rtpJenqoErkqaoXt+/aEbH5GiF6sIbCu4kFdm/u3gckwHrf7YA0cRlD
         G1JZhLjCdQlTVXKLJur+MHTpcR9r6838VuvD2XtU1vQxUhcNY8b/RCdW6aOzupOmv9Ew
         vdfh4F67I33vy38V3GxS2uyhL824QQvHGg07qjvFiYYD3nnGMhH6hL28EyoyiQliRFA9
         U1iVrEoP3R2nYuwmfczui/I6qaOr90GkocXXbLyA1V8lSFQY2O2tuG7/R7axQBFR9gZz
         I89g==
X-Gm-Message-State: AAQBX9eJ/IwsvTSkwDAF/+MxFvv7UayrOQXEpTR9VG5bGMNaqIRJYZmH
        x8oam3h0eg6gyxehjNAi+KAQag==
X-Google-Smtp-Source: AKy350Z4KybuktGNUlFrXFdPBinlDWA5XpwNX08ySiR1+g5FcSX17vllngbCaMnGKhuuppAfORKkSw==
X-Received: by 2002:a17:906:8595:b0:94a:7c88:263a with SMTP id v21-20020a170906859500b0094a7c88263amr3889107ejx.9.1681149946492;
        Mon, 10 Apr 2023 11:05:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:1a6c:6968:e633:48df? ([2a02:810d:15c0:828:1a6c:6968:e633:48df])
        by smtp.gmail.com with ESMTPSA id gq10-20020a170906e24a00b0094a962da55dsm1028943ejb.195.2023.04.10.11.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 11:05:46 -0700 (PDT)
Message-ID: <8132817a-db81-9a3f-7cfc-176c5df023ae@linaro.org>
Date:   Mon, 10 Apr 2023 20:05:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ARM: exynos_defconfig: Enable zram as loadable modules
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robert Elliott <elliott@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Stefan Hansson <newbie13xd@gmail.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
References: <20230410124907.3293869-1-javierm@redhat.com>
 <fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org>
 <87sfd7sk04.fsf@minerva.mail-host-address-is-not-set>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <87sfd7sk04.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/2023 19:51, Javier Martinez Canillas wrote:
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:
> 
>> On 10/04/2023 14:49, Javier Martinez Canillas wrote:
>>> Enable zram and dependencies as loadable modules. This allows to use the
>>> /dev/zramX virtual block devices as swap stored in system memory.
>>>
>>> Options were taken from commit 5c824e8be64d ("ARM: omap2plus_defconfig:
>>> Enable zram as loadable modules") that does the same for OMAP2+ platforms.
>>
>> Neither this commit msg nor above omap commit explain why do we want it.
>> I know what zram is, I know its purpose, but the commit should answer
>> why we want it in defconfig.
>>
>> To me it is not a matching defconfig at all:
>> 1. Not a feature related to Exynos hardware,
>> 2. Not needed for basic boot (systemd) or debug.
>>
> 
> It's needed for basic boot on distros that use swap on zram (i.e: Fedora).

ZSWAP could be for this as well, but none of them should be used to be
able to boot Fedora. If Fedora requires them, it's something broken
there. I can setup SWAP on my eMMC as well, so why would I need ZRAM?

Best regards,
Krzysztof


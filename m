Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4012722B99
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234925AbjFEPnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:43:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbjFEPm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:42:59 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA88D3;
        Mon,  5 Jun 2023 08:42:32 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-53fa455cd94so2368253a12.2;
        Mon, 05 Jun 2023 08:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685979742; x=1688571742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QRYKJ7udBueNyscWhHvS8zfExl2vPiqNyfj9FsctqDw=;
        b=WEuEtpYl/RyfoX8Gs7JUq2hVzAwiyuY1muk8V45xiPLXD+jalOrBSG9e15q2SOltq5
         jJFPs9htSp6SyidmYXoEBRjeJDJT3+8nSzbTJTNBUP0J66532RvRsHNOiJY5obQ6Lv+U
         Nqp/gJQtyjnfMa6tN4W4Fy6Yvh9EkaT93zY7KRtgkknw8MckU+LUM9A1gmJqkZTCT6Hh
         sBnDVDi02h0R2YpD2X83EvOA5iQgAfDZdMpk7XLSo3JPFvyGA9KbaobXH8Y4FQvv+8Ti
         UxnKL38O/XEuK8j9fZa4n1/y+Cz4nlyi/qMlLdbfpkbIml1AHyrvnnzmbakai2wXZB9U
         OgOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979742; x=1688571742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QRYKJ7udBueNyscWhHvS8zfExl2vPiqNyfj9FsctqDw=;
        b=YCxpRoSVevn5DlMve9vl6nfkf8iQWawf/6GDkABWu8f5coKPlmrQm2M6mfKClNiwb2
         djgjV0WDFsCRKCVRWPOMNBBNlO2m9vWCwkYpJkFBzFdmKlWIbUq3iHvIu34QZjKK6lkM
         nzWps4dvDRK8niaPQN3Hc32xN/yA86bkBIh56NrU3pJaYKCKN/ePrdVeasKIIbPdDhTW
         V8sVqD5Yc8coO/gSkbC7DfOarQVrnqzltT5asnmlbl//l019fSq2pVipg/ZBM5vMySs0
         VIGAP1IvTe8qVgZGArK4Acr7NkRYPsyeoI1kVRdkKuAbagxnNIZVdBnHa2ZaNjmxs+79
         Bg+A==
X-Gm-Message-State: AC+VfDwQ1YU9/fia/GLH/i9RuP+uEKX7OpROZYN4SxdKjC537GIex2PC
        Md2Ch9ZdqSgIXGavm7u7kEs=
X-Google-Smtp-Source: ACHHUZ7I6Ar3LZZ9kHoToMAD5HQyB77QUBL2IaQwSPOBlUFjtuda+fyGHtngzVCV0z/dW7b6GRwNXg==
X-Received: by 2002:a17:90a:1cb:b0:259:452b:7270 with SMTP id 11-20020a17090a01cb00b00259452b7270mr1482349pjd.37.1685979742480;
        Mon, 05 Jun 2023 08:42:22 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f32-20020a17090a702300b0024e026444b6sm16380307pjk.2.2023.06.05.08.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:42:21 -0700 (PDT)
Message-ID: <6b5f3591-a5a4-03bd-286b-def857763618@gmail.com>
Date:   Mon, 5 Jun 2023 08:42:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v2 1/2] net: phy: micrel: Move KSZ9477 errata
 fixes to PHY driver
Content-Language: en-US
To:     Robert Hancock <robert.hancock@calian.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230605153943.1060444-1-robert.hancock@calian.com>
 <20230605153943.1060444-2-robert.hancock@calian.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230605153943.1060444-2-robert.hancock@calian.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/5/23 08:39, Robert Hancock wrote:
> The ksz9477 DSA switch driver is currently updating some MMD registers
> on the internal port PHYs to address some chip errata. However, these
> errata are really a property of the PHY itself, not the switch they are
> part of, so this is kind of a layering violation. It makes more sense for
> these writes to be done inside the driver which binds to the PHY and not
> the driver for the containing device.
> 
> This also addresses some issues where the ordering of when these writes
> are done may have been incorrect, causing the link to erratically fail to
> come up at the proper speed or at all. Doing this in the PHY driver
> during config_init ensures that they happen before anything else tries to
> change the state of the PHY on the port.
> 
> The new code also ensures that autonegotiation is disabled during the
> register writes and re-enabled afterwards, as indicated by the latest
> version of the errata documentation from Microchip.
> 
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


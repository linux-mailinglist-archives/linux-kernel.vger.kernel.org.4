Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBCB722BB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235076AbjFEPoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbjFEPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:43:41 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4953AF7;
        Mon,  5 Jun 2023 08:43:24 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b02497f4cfso25043885ad.3;
        Mon, 05 Jun 2023 08:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685979769; x=1688571769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WB+xuJyQnP5i0NrdzK2CEEmW6xZAV3J9cIB2MRW7p7E=;
        b=LQotv4TKMp036ZubcNkWawVs3OX2PM8Qb7M2/RbGv7X0HRTJU+imNFb1nv4f/gS/OO
         FTZOqMiy1WYFkvc3l1Ot5aCMQQ1yrXw9gnOvakjWrOSTlgbUJFdXrghiiy2yH4RWNwp4
         gtqK9nXFhUE8lFOTyX8Jqd+NSplHnCO0ZxCUJ4HIY+6c+yUSII60rtGWuTsXx7cm7hDZ
         JlagPaaKIyoB8pZ2zRHDjkoQaEf55v2vfSC+ir6CGoeb2r5utI8O39HIz5/pMo7BJd/8
         iDm8hEhJSa4oKOdXinGNXHy8p4e2yGmhhXe4QxWIKq19mIy1v3TdaA+gVVXtiA47dfx9
         0ZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685979769; x=1688571769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WB+xuJyQnP5i0NrdzK2CEEmW6xZAV3J9cIB2MRW7p7E=;
        b=a4ERch/P4v4sDQ04CXzoNtX2aRSdq4J2x9u+va6R7xSgeenue2KHTCmvWthiPqYgQn
         nw+D68e97SKiqJFtKPfkHsrIAkuCfOKImDrb9NwsKEBDM4NHqez/EiF8YRmk4tndjTxD
         vaHaE+6AsWBXORFA9zrQAIN2K0gtThsuXyIB3Ck8g2jDEuCFNGHDuXkowZK5KihNBt0I
         fr6QZjDiBjKJrs/gZgH8UdchxuxJ3gZHZra2cTXpoD/5atIQjtqbNKzzQUmjIrs+nIBA
         Eg5J5JMk3Vo1RzJAYICaENyW/ypkYlrIAPkYCrPgo3X51oA7n4R5x/ieoaaJj6MQDNc8
         K2ug==
X-Gm-Message-State: AC+VfDxlO71o8Dy0LLcSRYWXmnwaFjmJVw0vDDdHvionsjJTJF0N9Fxs
        NdgI5nlZyyxK5Rda5/2s/tmtI536hWMIag==
X-Google-Smtp-Source: ACHHUZ5bbf2vRchTShIwA5VETN6NLk4Hm+kzHeya+hrBi7tAnmDqu4/23bl5bXzA3e4+uxp4T5UvjA==
X-Received: by 2002:a17:902:c215:b0:1b1:9b59:fc68 with SMTP id 21-20020a170902c21500b001b19b59fc68mr3290280pll.13.1685979769611;
        Mon, 05 Jun 2023 08:42:49 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id g16-20020a170902869000b001ab13f1fa82sm6755143plo.85.2023.06.05.08.42.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:42:49 -0700 (PDT)
Message-ID: <38797003-c236-d92b-02dd-5a18d959e727@gmail.com>
Date:   Mon, 5 Jun 2023 08:42:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH net-next v2 2/2] net: dsa: microchip: remove KSZ9477 PHY
 errata handling
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
 <20230605153943.1060444-3-robert.hancock@calian.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230605153943.1060444-3-robert.hancock@calian.com>
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
> The KSZ9477 PHY errata handling code has now been moved into the Micrel
> PHY driver, so it is no longer needed inside the DSA switch driver.
> Remove it.
> 
> Signed-off-by: Robert Hancock <robert.hancock@calian.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


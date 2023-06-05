Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7030B722AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbjFEP1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232819AbjFEP1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:27:21 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 495E4AD;
        Mon,  5 Jun 2023 08:27:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5289ce6be53so4324104a12.0;
        Mon, 05 Jun 2023 08:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685978840; x=1688570840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ieu/xxysVKbGsHF+00dw71+S3ejA2tEitu5T3zoXPB0=;
        b=A5scA0dd0wm3VKZ3PTP3Gd9o+B39YstHpIKJ+NE1iRokmyg4qeXr29sJ5o/2cwBLMb
         ObmUbtXeaDT/ZyO7OnC5ovBw6zM/Oh+trg0B9DKbubkHslv4+pT/msS11OzUtLMA4+yz
         wgGtgFuTrR4TrBFcAcuHgmASBQxOkKOOOJPiVle70qpOMXaLAOPq5q6fxRug1XMNy2dI
         X9Iww7P6X+zJVPYAYx3OOOFDm/JORWr88pZFysCQ319fXjxgnx73CRKt5TECYDlDumxI
         vFOSaNjfYs95m8AjR+Buc254DvIEhRWuvu60eHPwBTiOybAJvciui/x0ialbIGF95rUZ
         Bgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685978840; x=1688570840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieu/xxysVKbGsHF+00dw71+S3ejA2tEitu5T3zoXPB0=;
        b=Q7pmvi11y7596vw7BrI0qcSqtLAby7TTUkbN6dBvhyr6WEbfpwp+Hf2YN9rcqD60B5
         0lp7dru391bMJAAFiHSHsRgFJT8csCuaZMxHbwLs7+apVuRSi+NuEpiWUF+yEWK/Q11t
         vkqqqPT7RyPyHrI/dmaOfQL8XGf5YZjDwNjc2UDI1o5EZp8QCGVGnsTA99IoVWr742Z7
         zd27LP0ieoTpswfcJxyADV3xK/SsJZILaDvlZKlFLOatvWRq6Ys55eKHyy+f6DSi92Wr
         VElzmIybGLh2iSk3eYD14f23iGcRDezJfvmZDQHwL0ajWBogbT/Kmee9D1XYo61fXNaF
         DKQA==
X-Gm-Message-State: AC+VfDzN/3LHFD3biqXniozF7Au6XpVSQH0QHF1GQtScoaeDpqk0HzL0
        YthdOES5iTjHc+upPHCrVOs=
X-Google-Smtp-Source: ACHHUZ6/on28cGqEUtuLH1gzTbjbi0i7Uc578RrsqZpQ1uDxG2t+ExFz+BzyyUDIoebj6ATgtJ//+Q==
X-Received: by 2002:a17:90a:6b4e:b0:244:d441:8f68 with SMTP id x14-20020a17090a6b4e00b00244d4418f68mr9271108pjl.16.1685978839644;
        Mon, 05 Jun 2023 08:27:19 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id f19-20020a17090ace1300b002502161b063sm7886395pju.54.2023.06.05.08.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 08:27:18 -0700 (PDT)
Message-ID: <086b52d5-4159-ffaf-8bcd-30ac24c25017@gmail.com>
Date:   Mon, 5 Jun 2023 08:27:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 3/3] net: phy: realtek: Disable clock on suspend
Content-Language: en-US
To:     Detlev Casanova <detlev.casanova@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Florian Fainelli <florian.fainelli@broadcom.com>
References: <20230605151953.48539-1-detlev.casanova@collabora.com>
 <20230605151953.48539-4-detlev.casanova@collabora.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230605151953.48539-4-detlev.casanova@collabora.com>
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

On 6/5/23 08:19, Detlev Casanova wrote:
> For PHYs that call rtl821x_probe() where an external clock can be
> configured, make sure that the clock is disabled
> when ->suspend() is called and enabled on resume.
> 
> The PHY_ALWAYS_CALL_SUSPEND is added to ensure that the suspend function
> is actually always called.
> 
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
> ---
>   drivers/net/phy/realtek.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> index b13dd0b3c99e..62eac4835def 100644
> --- a/drivers/net/phy/realtek.c
> +++ b/drivers/net/phy/realtek.c
> @@ -426,10 +426,28 @@ static int rtl8211f_config_init(struct phy_device *phydev)
>   	return genphy_soft_reset(phydev);
>   }
>   
> +static int rtl821x_suspend(struct phy_device *phydev)
> +{
> +	struct rtl821x_priv *priv = phydev->priv;
> +	int ret = genphy_suspend(phydev);

Sorry I missed that part, if Wake-on-LAN is enabled you cannot suspend 
the PHY as this will typically prevent it from passing received frames 
up the MAC where Wake-on-LAN can be done. You need to move 
genphy_suspend() into the !phydev->wol_enabled clause.
-- 
Florian


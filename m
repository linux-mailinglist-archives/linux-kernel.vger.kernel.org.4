Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC812714539
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjE2HGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjE2HGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:06:36 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272D710C
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:06:05 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2af28303127so30875981fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685343963; x=1687935963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSGCe5USSQJEGiF5Fy/UcpM812mnZfMtSYhSOl2CPIg=;
        b=yQ2RPOVq3xwqv0kByvZOr7NUoTwGS3KYUBuoFO2EN1/+riLmQQ+gl9KBdbY2XNa2Jm
         yf/5UujrzcXwrAGJIROdbayji0Bh217OowCFGgM9AZJGkReWDmzGiJZq/HjBp+dO3Utt
         AhPlTFhN16867KYDuPmyh3X0WCmxNTzZyye26DI7zoLt7LPAX9pgO92hARHQDTOnW9yn
         d/i3qIv5HKFpEsX8GkhCuaBS2GTwc1zV006/YEnkF12N/WXX1vjpLufIg7fg1cIT6X2Q
         AXa/DLQZ7H0Q8ZMt9TSsnYV40gtDv5CwfyBls1Aw7nxLr0MHiFT4Eb2pH0gnxu8F9H+p
         cOvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685343963; x=1687935963;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSGCe5USSQJEGiF5Fy/UcpM812mnZfMtSYhSOl2CPIg=;
        b=Ky6jdDwaQcAKMj/58AUJjyB0gGUG5EwP5blb4ZzkjWwU110aSBsL7gb/cSWnO+jFZU
         EKOy1i+pdKz/QevM/U96G7SGuSScPe1SG97WQ7as1zbk+6xP6hdhy1VjtReV64gG5q3R
         c4K3d6QqfB6vRjHaVbMb7Xnf0fnCFBr4SSf8YTIopXNS6wvmhL2yW3+3qaKXvMAoAVe8
         4XhJ2D5wR0HnH4XD3AwaRrBolkvISteQ908GHpsMbSsvbYHvo4BXV8sJwcbqd9rKNvyt
         8bT9s/XvZ3AePMb717CaNeRbKCCXCawxzIeyLXBd7n1sKFDg+lQfvmnORY7AMDiOMIqW
         Zjsg==
X-Gm-Message-State: AC+VfDyRTfTJULt9XuMaKwAUN4tB+UWFBwjWKyow6AiJAfRSj+Bgk9NT
        +Zq1tcwRedJEEqSZpirWTRihhg==
X-Google-Smtp-Source: ACHHUZ7ghxvNiBXIZexmU6mGNqC84T8NesjozSmGJVnzo7tfrKT3UAnltzTThAYM5S8QkaTa1ZnIig==
X-Received: by 2002:a2e:7d18:0:b0:2ad:990a:212c with SMTP id y24-20020a2e7d18000000b002ad990a212cmr3309182ljc.32.1685343962830;
        Mon, 29 May 2023 00:06:02 -0700 (PDT)
Received: from debian (151.236.202.107.c.fiberdirekt.net. [151.236.202.107])
        by smtp.gmail.com with ESMTPSA id w5-20020a2e3005000000b002ab017899e8sm2298927ljw.39.2023.05.29.00.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:06:02 -0700 (PDT)
Date:   Mon, 29 May 2023 09:06:00 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v4 6/6] net: phy: microchip_t1s: add support for
 Microchip LAN865x Rev.B0 PHYs
Message-ID: <ZHRO2HZdrTzDoOQm@debian>
References: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
 <20230526152348.70781-7-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526152348.70781-7-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:53:48PM +0530, Parthiban Veerasooran wrote:
> Add support for the Microchip LAN865x Rev.B0 10BASE-T1S Internal PHYs
> (LAN8650/1). The LAN865x combines a Media Access Controller (MAC) and an
> internal 10BASE-T1S Ethernet PHY to access 10BASE‑T1S networks. As
> LAN867X and LAN865X are using the same function for the read_status,
> rename the function as lan86xx_read_status.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---

Reviewed-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Tested-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

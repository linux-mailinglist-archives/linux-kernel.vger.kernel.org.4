Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30E07113B1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239626AbjEYSaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234112AbjEYSad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:30:33 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2AC12C
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:30:31 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3a9ad31dbso2942078e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685039430; x=1687631430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+YJ/U9yQq7zENy/xeT5OhlkVCIP/m9WLirdWwzeDK4I=;
        b=jklSg68Yjq7Ohsf/zGVOv18G5cs2zXhVUYIHJ9oz41V5C6o9cEHx0aUKecr5ZvoSMz
         bfvuVb+k25HF7HOGe68clM7VAZM/PrDoBpAhleFL9zvFYPvvXvzz8clUm+txJU7XeYw5
         /AdH8wAIROoj0XRklCZKZ2yNmZcXiE2QkHUF+N7ioHqcEFJXPDqY+YuHgrJtBTeIChwF
         xhVUst+NzkjyVjGhtZWA2Ek7XS1/wyfXkSyl8dkYWF3j+9glwpQVhDpY31boqS8kYa9F
         brttZp2s3/JdaEwTHpdtkgl7+Yp+U07XKejie82aCumUh5KB+40AiG29ZQo+6hKp6JOh
         TI9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685039430; x=1687631430;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+YJ/U9yQq7zENy/xeT5OhlkVCIP/m9WLirdWwzeDK4I=;
        b=PWcrTTtA4qvRF5Qbh/x8cPHJVEPp0PAcvYJ5JwYV/u5ciSHSD7R1bvIDdbq2YqeX7V
         HBGgQvBmRyyDIkAx/ZDjXR/tRZtE1t6UkAtHRtZ4n4HqfvSwjzp1zfkFiHGngKC2a+Km
         df7xqQNRrJSy44qVKla+kvnntMWhg5JYMS7BqsjfTgC+L133Tisn4W1xjiVJumilVVVO
         oTVpjXTqfoK9g//Yxd8hwnYfZbY5dCG4Ruw1lctmEVEUQLtOkUBDWqDq71JZgHEa+HxF
         Ra8u+ErtNPFLHi+4izY4WqRT6om7LbAvSUjPYL84bgP3iNoPIW4WUVFmNRbrooESRunT
         pC2Q==
X-Gm-Message-State: AC+VfDzPvi+1KOI7QJuQ0Ua6Ffx/QkI+cEzPKiZLfgKhM+4Zy+mor3zM
        Mm0yVpkp+DQkW7l1MrdHEuWsWg==
X-Google-Smtp-Source: ACHHUZ6GpGNkXqsuXcs2YgoOJsCMXwrX9WEYcj1NNZ2HxN1HKZL1L3M96Tda83v8EXyBwnNG83x1Bg==
X-Received: by 2002:ac2:4299:0:b0:4d8:75f8:6963 with SMTP id m25-20020ac24299000000b004d875f86963mr5769978lfh.38.1685039430204;
        Thu, 25 May 2023 11:30:30 -0700 (PDT)
Received: from builder (c188-149-203-37.bredband.tele2.se. [188.149.203.37])
        by smtp.gmail.com with ESMTPSA id g21-20020ac25395000000b004f3b258feefsm296583lfh.179.2023.05.25.11.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 11:30:29 -0700 (PDT)
Date:   Thu, 25 May 2023 20:30:27 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v3 5/6] net: phy: microchip_t1s: remove
 unnecessary interrupts disabling code
Message-ID: <ZG+pQ95pU2yn7LlR@builder>
References: <20230524144539.62618-1-Parthiban.Veerasooran@microchip.com>
 <20230524144539.62618-6-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230524144539.62618-6-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 08:15:38PM +0530, Parthiban Veerasooran wrote:
> By default, except Reset Complete interrupt in the Interrupt Mask 2
> Register all other interrupts are disabled/masked. As Reset Complete
> status is already handled, it doesn't make sense to disable it.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---

Reviewed-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>
Tested-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

Testing has been pretty rudamentary, but the procedure has been as
follows:
    * Hotplug 2 devices
    * Unload and reload the lkm
    * Ping 2 devices over ipv6 link local addresses
All testing has been performed with the EVB-LAN8670-USB

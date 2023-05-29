Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FB371452B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 09:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjE2HDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjE2HDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 03:03:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58CFBBB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:02:57 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2af7081c9ebso30908351fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ferroamp-se.20221208.gappssmtp.com; s=20221208; t=1685343775; x=1687935775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tH8g1ekIg69Qrl0yhVydO5jTTrGC3bGgfrq7vcoo3ls=;
        b=LSzhdOX7vT2a4pcStAvCVH/Ag+2ngZv8HrXWcZyYa+NjdGmaJP+JxtPt3XJJoYhKLZ
         EWkjiJfTe/fWIUnIv12oLEt+nzPO/nF4JDvE0qTVGOdgRG/HlqXH0sfZTgv97hud3eNa
         sa7D/DZn3EqH2GYYP6D7h/E0GfKXZHroU5KM9DOzAlh6XTmTVRGv7vzWlNq4/xaiAob/
         uEcpbSKRGIt6LqGfT/4eUwF72enNjfGla4JUFdsg0e4P6+1tmRKBgZpx5IliDiR9RuCe
         yZjTB0WPUuNneAQirI0WAIk0RwNMUoQYfCMDTuVGJphYaj/lWRayRyDCE7D+ySH/sdxV
         fObA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685343775; x=1687935775;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tH8g1ekIg69Qrl0yhVydO5jTTrGC3bGgfrq7vcoo3ls=;
        b=i5XKFfpOW71/6JUW7l6EOBumforD8yYvZpeVmcDXN+fB6F/1EK4hOhECOwqi176W7Z
         B16+FRcePc1w+Z5Emh+pQd/4jQMofnp8eBQ9kqxbDwMaLyN3AJXlCohrIJuNznAqCYsr
         rAEjaj8F7ecwONs5XcJPAJMcDrH006otz5DulleHdMSraEqF17a2tulOo+YguPFS7n/+
         +IdTJ6J4jKpkBrrfaY/Zpu1z+eeThDk0Uq0sxmc3bmof9EsOxWeuymqndWTA3ux2cBfN
         +JSQDWYraFPcvuUVueQSARMOh1Ab2aprKWwiMMrfIqk5QbXabCwevMlb3G6cFwL7h1lI
         LE3Q==
X-Gm-Message-State: AC+VfDx040UaJeKOh9osNhzg8NCHNopqCZhTJqglBtgdZZphGKFQDRlp
        KtwcbJsz4FVTH3W9399BUiRK/A==
X-Google-Smtp-Source: ACHHUZ5A2gkiYymrOP+RqHAli0SUin/a2l45wvlc0Gn0Wx+lzYoPnZF4ULp6Pb3j8lqV5xd0R5HtDA==
X-Received: by 2002:a2e:b703:0:b0:2ac:66c8:3c4b with SMTP id j3-20020a2eb703000000b002ac66c83c4bmr3501959ljo.11.1685343775651;
        Mon, 29 May 2023 00:02:55 -0700 (PDT)
Received: from debian (151.236.202.107.c.fiberdirekt.net. [151.236.202.107])
        by smtp.gmail.com with ESMTPSA id a24-20020a2e8618000000b002a76c16ad65sm2348781lji.87.2023.05.29.00.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 00:02:54 -0700 (PDT)
Date:   Mon, 29 May 2023 09:02:52 +0200
From:   =?iso-8859-1?Q?Ram=F3n?= Nordin Rodriguez 
        <ramon.nordin.rodriguez@ferroamp.se>
To:     Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, horatiu.vultur@microchip.com,
        Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
        Thorsten.Kummermehr@microchip.com
Subject: Re: [PATCH net-next v4 2/6] net: phy: microchip_t1s: replace
 read-modify-write code with phy_modify_mmd
Message-ID: <ZHROHPboJrIiBy5J@debian>
References: <20230526152348.70781-1-Parthiban.Veerasooran@microchip.com>
 <20230526152348.70781-3-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230526152348.70781-3-Parthiban.Veerasooran@microchip.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 08:53:44PM +0530, Parthiban Veerasooran wrote:
> Replace read-modify-write code in the lan867x_config_init function to
> avoid handling data type mismatch and to simplify the code.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
> ---

Reviewed-by: Ramón Nordin Rodriguez <ramon.nordin.rodriguez@ferroamp.se>

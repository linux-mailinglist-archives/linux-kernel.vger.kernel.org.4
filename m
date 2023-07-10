Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E9074CEBE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 09:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230257AbjGJHnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 03:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjGJHmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 03:42:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B95BB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:42:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-992af8b3b1bso550676166b.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 00:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688974967; x=1691566967;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sYa+4YE+30QHiJRTLMjjqFrjqPnCqAokMplj1Cbx8tk=;
        b=lh4Qa6BqUYpz9h0AN8Juc4Owh5RGq45EKpwB0uT7TBMVhHOyzsCOVRS0qgm4F+FFhG
         EUXPsFsdWye5q6sQ5NkZAMwWXGbGrUtOF2uP3wvnJh+FbV1EcQtBBgeE2pqXy4DBcJ8h
         k3U/R3xCogBzw02HT8IlVq3LrxoTSEdCckrT/f6JLstgbHcH5YfggQe3iXmQHsLGt0T+
         pPlMcg34JSEivDT0uhvxJSwTSL4LVPKHdgQ0mUt17wV9TTnA3ApvTdemHWFeBeBrjuhe
         1r3kp6vQqUEt8u40Exqm9pVaAT4spNwiUqqZaJ4vExQ+Sm1R/rxbZFfJ89dq1VQuJcew
         C9SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688974967; x=1691566967;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYa+4YE+30QHiJRTLMjjqFrjqPnCqAokMplj1Cbx8tk=;
        b=KiMwULUtg3fgU7/tF+5stRwFTA7oaWFae4WDhmVetGLayFtw9rCmOb7oEy6M0Je4gG
         qfC/+0vomEdak7QFtvCjiYuQyjFPmtqexhsGsB+v2XDz4/IvDeO3VfOe8od8BOCDJK1V
         DvvpFbfqd31Xj6x31RWsIjVltzbrpicYOeWAhqd4obux6Jg4z+bFrqa7uUC7D08sujLU
         cTDyorxDhqTZj6wP0ZuZzquAhvIKLZApYo+aO43E90KNA5inWoCx9Ef5CKZORZNv9DOE
         T8S7JwzEtcfqItqyJROiUe9+Gcl+Z3MOB6rjhvkY+uwAHVDaK8lR6CU7yAJh2WCMMI/J
         N6bg==
X-Gm-Message-State: ABy/qLYwUXmE9BGdIh6U667AyZSyIOPgKE6Ke/d/y+2V0xKRHJ2okth3
        eTdiB/7E9VYCmrDpLUWCJwpmJg==
X-Google-Smtp-Source: APBJJlFihkbV+iGQfqlM2l+vJaUqtGbDKAwRAB0VfcquEqSMuBJDFojT6/PGG5hqypecgV2Q5nUFCw==
X-Received: by 2002:a17:906:51d1:b0:992:7295:61d4 with SMTP id v17-20020a17090651d100b00992729561d4mr13652686ejk.3.1688974967161;
        Mon, 10 Jul 2023 00:42:47 -0700 (PDT)
Received: from [192.168.0.107] ([79.115.63.146])
        by smtp.gmail.com with ESMTPSA id i15-20020a170906264f00b009893650453fsm5777899ejc.173.2023.07.10.00.42.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 00:42:46 -0700 (PDT)
Message-ID: <9609c217-45b7-211b-7ec0-5e4275b1ed78@linaro.org>
Date:   Mon, 10 Jul 2023 08:42:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] MAINTAINERS: Add myself as a maintainer for Microchip SPI
Content-Language: en-US
To:     Ryan.Wanner@microchip.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org
References: <20230630161700.448747-1-Ryan.Wanner@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20230630161700.448747-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ryan,

You should probably add in To/Cc linux-spi@vger.kernel.org
if you want Mark to queue it.

On 6/30/23 17:17, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Tudor is not with Microchip anymore. I have worked lately
> with Microchip SPI drivers replacing Tudor with myself as this
> maintainer.
> 

Describe your changes in imperative mood.

I agree to be replaced:
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Cheers,
ta
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad32db6c81cc..8478cc82f197 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13881,7 +13881,7 @@ T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
>  F:	drivers/soc/microchip/
>  
>  MICROCHIP SPI DRIVER
> -M:	Tudor Ambarus <tudor.ambarus@linaro.org>
> +M:	Ryan Wanner <ryan.wanner@microchip.com>
>  S:	Supported
>  F:	drivers/spi/spi-atmel.*
>  

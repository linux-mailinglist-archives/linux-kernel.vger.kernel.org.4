Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C953A706810
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjEQM0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:26:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbjEQM0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:26:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E01DB5FE6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:26:10 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-96649b412easo106243966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684326370; x=1686918370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1CP2l/NtswQ2liAsrw5zT1ZbU3pO/pwGbRQu355gbn8=;
        b=VBtkYto9xGFEO1CppAuG0v1Dmewsn1R31kjzccCOn1eoLhpSL201qaN2H5EkllKhv/
         gdobh3E5JfMtJObzPrdlZsD8k5P9kIxC2asxM/OpXrAO9AEn1wzo7Ndouk0zkjrKyEcK
         gOYFst5lhtws9usJK18aSvJbXgq4jkpSG915tx+ayOZZYipa7QEkTbd3jf7FqVbD0csr
         k9wAgYU8N0mHshLpW8TM2A0XAiw54YxR0CjDaCgQB6n4ODl09f7d6mF9J1OjbPjFfIIW
         HUBxQ8uzuGIFZX7dz/FicH1sWwS6/MBSs9ymQtev8/9nudRH8aLPQGbTINFFccTJ++ye
         T0Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326370; x=1686918370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1CP2l/NtswQ2liAsrw5zT1ZbU3pO/pwGbRQu355gbn8=;
        b=QkGuIgOnSmKe9dokR0IerKSsS+JfVXYUEqrojVHP5Mo7kgrI+Xr4NWVRiH0hXo5c3l
         CVVYJjHyjuUZNWer8ZzCpS1ZQUKPpVHd9zqSosNVzKTUgFvD2gyuUILArwUAoRNsiDTJ
         dIrTgfS+uVT+gjuQtJxA/FJIv2joseBbOgbF2dZVh5NE3CJtNRx4PgLaGICgNdtci910
         b0whv3F/fRSzE5/z7D4WE6lOyX5MSFsqT8VDlJlpye9V2+qyBJ9sxd6EfSzwMOIo+06X
         /Um9/ucgSZdEFY73qaDjT5tRzLXoBbtjMZywuczoZvxN44J1kjW35vwjZUg0a3xHDjRr
         Voxw==
X-Gm-Message-State: AC+VfDwLXiJfTle3Bd4wTEr/6BW9tz51mgq+F8GNtv3OCt3rXQeTUKi+
        o21DsFupPqDYzKUwW4jl4tnQXQ==
X-Google-Smtp-Source: ACHHUZ7nluM80mVezxfqHid7whylgXIMip3+ht6mCuSjzse0yWcDYgy8fyDnVvoJpQw/42+CyKz0PQ==
X-Received: by 2002:a17:907:7207:b0:96a:937c:5608 with SMTP id dr7-20020a170907720700b0096a937c5608mr17479390ejc.53.1684326370372;
        Wed, 17 May 2023 05:26:10 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id ze11-20020a170906ef8b00b00965b439027csm12267891ejb.195.2023.05.17.05.26.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 05:26:09 -0700 (PDT)
Message-ID: <f6d44478-c07f-92ff-b3fa-20cff6dcfd05@linaro.org>
Date:   Wed, 17 May 2023 14:26:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/3] arm64: dts: microchip: sparx5: correct CPU
 address-cells
Content-Language: en-US
To:     Robert Marko <robert.marko@sartura.hr>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lars.povlsen@microchip.com,
        Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        alexandre.belloni@bootlin.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Conor Dooley <conor@kernel.org>
Cc:     luka.perkov@sartura.hr
References: <20230221105039.316819-1-robert.marko@sartura.hr>
 <20230221105039.316819-2-robert.marko@sartura.hr>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230221105039.316819-2-robert.marko@sartura.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2023 11:50, Robert Marko wrote:
> There is no reason for CPU node #address-cells to be set at 2, so lets
> change them to 1 and update the reg property accordingly.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> ---
>  arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 

Patch seemed forgotten, so I applied it.
https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git/log/?h=next/dt64

Best regards,
Krzysztof


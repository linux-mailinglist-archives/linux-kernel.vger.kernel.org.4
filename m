Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB17D73FC0F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbjF0Mil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjF0Mij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:38:39 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C330DD;
        Tue, 27 Jun 2023 05:38:38 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98bcc533490so539492666b.0;
        Tue, 27 Jun 2023 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687869517; x=1690461517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OGrEp5Q39HZGQ82JmPmmh2H94aW0HaIcywyFDbjcurE=;
        b=NOB+ERmjStBCqjkPlUmP0vwjHclGmaLXnqNDFHvHmtpwUsypiY0Dtg72njUZPar5fx
         CMvsdYa1RXWaHtmHE7/6LS64Hc7BlWnUNxZ6QfZiOQEw5+J61NdWupYFNjah6fJ7KpbR
         D+O8KhKUI1jxIrmJyXi1VJ46pPvlWBiDBxQTvq5fXQLreeb5Vm4A+qaLpd8YJ89U3Txg
         8IvQKsRZWyFKZyh2vCzBgo8DhCBTHAK25K1WtFERxDQdKYOnv2gKjFHSsp3ndc7tB0nR
         lPuNnof4ooUQ+36toCZHblt3mVHO1b/juwSFn4mVBx4he9scyvzUYeZqP0xL8VX2Sn1l
         Btcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687869517; x=1690461517;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGrEp5Q39HZGQ82JmPmmh2H94aW0HaIcywyFDbjcurE=;
        b=MwOmoqeGHqa4pd++TTaFa6UOfHO0ZltDgwQ7m/uCmMa0llvaDUBztEU6dbp1xG1zhs
         8JAsB86KavtD3exn9gtH39XmMHoAaNnWaOm41tM/jnVi9B3Ve/REQZ+EEkuuD5cZXn0i
         BL/nPjraMXOhatHo1gMImRt+v1ZKtiZAKSJTve4ai1MQ67NBRmZ85WfOj0lwqp0EHKQD
         XDLWTOfvNXj+D2zc/XDrYAPPFH2OPhdpHQU/dvdp4LVJvjzimXtvzx5ZDakwtp480dgs
         vo/byhJuKNqb3JW1AjwVCjLI0zOoZGYk36+iCzaBnJIKpD6dae1Bq/ee7ctTm9J+2UZY
         MfBw==
X-Gm-Message-State: AC+VfDy2RmjNtfVKTyYwO2+7hkozG0UPWRMePel892bozmmOjb/MMgj3
        /Dt85w42xfCOqSL2HnJXtrATCssR5E0+Qg==
X-Google-Smtp-Source: ACHHUZ5PyNyzI/RcofGx13FdqXcShZMBIm55egb8GztHqoIAr75k6TPoNEICmVO1Te79u4XXd8uENA==
X-Received: by 2002:a17:907:3e0a:b0:974:1ef1:81ad with SMTP id hp10-20020a1709073e0a00b009741ef181admr30559593ejc.4.1687869516574;
        Tue, 27 Jun 2023 05:38:36 -0700 (PDT)
Received: from [192.168.148.233] ([193.85.242.128])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090682c300b00992025654c4sm1083297ejy.182.2023.06.27.05.38.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 05:38:36 -0700 (PDT)
Message-ID: <94dca2c3-e5fc-c4bc-a945-31ebb728e353@gmail.com>
Date:   Tue, 27 Jun 2023 15:38:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH][next] power: supply: bd99954: make read-only array
 sub_status_reg
Content-Language: en-US, en-GB
To:     Colin Ian King <colin.i.king@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230627121707.722021-1-colin.i.king@gmail.com>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20230627121707.722021-1-colin.i.king@gmail.com>
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

On 6/27/23 15:17, Colin Ian King wrote:
> Don't populate the read-only array on the stack, instead make it
> static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

Thanks!

Yours,
-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


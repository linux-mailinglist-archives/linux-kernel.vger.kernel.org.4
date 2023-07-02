Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB97D744DA7
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jul 2023 15:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjGBNB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jul 2023 09:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjGBNB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jul 2023 09:01:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 602FD135;
        Sun,  2 Jul 2023 06:01:56 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so41229355e9.3;
        Sun, 02 Jul 2023 06:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688302915; x=1690894915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zzka9CnRuiGxtiFqL9JgKk46K47spIoim848zQhRx/I=;
        b=b1WNUNT4oTwKh77H5nT3jfqCE3yGRMR6EkAhEAFqi7jR/T1jTcluVilYz655Q0pIYX
         T2+nS0EnBCIcSSafc/OxQJqxPWnGwo/JC6P82Lk9Y+ViWTeTIaVmFbB1YsyrSArw55Jp
         Q7EzB3uerrUwVEzqSXYRtc1Hx75rNfVpJAO+Yed1N5X5PhwnNJfvuoajZAZddgo589/9
         PqorW4chq2JgOvNZaWYMjFQISh+CFw/Ln+QEMnujnKV72B1XldfUSU76VI+6G39hvJOs
         coOn32UVkkeyRyID1QqcL6Ao82nPtI+qhfOVXnJgbPlxM8inX6eahd0mnV3MBG1w1nin
         Zg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688302915; x=1690894915;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Zzka9CnRuiGxtiFqL9JgKk46K47spIoim848zQhRx/I=;
        b=dKjHIwJdB4KTrxmig7pqaU/BgHKekoBRcR6cUfv/80iwGxzLOA96eQBr0toeCEbeJd
         o3tRy7Pv+3SJ5M7bMCp5/jRh7N2a4DcUEFRaHIg5k4dyku0Nx/9H5XIUMLV7LuG3yBe8
         44gLNlymvSJT0vv7manJyuMJqqnzQ2cKmq8Om5jsYt3YFcv62KGi3LaYtbtf1hj/Jcxd
         1/MgCYVxyZOVp+9yBeOd+OrkJh7KEIgNIbIucABlbE2vFJbMyqG5Mf30kPLdtiE+VXvB
         lME+NYNFkPylI8oeLsrjrslqb1lzY1Gc7mt5G+a5hdsRXJLPXMai67KKLlpGfnNzYNAn
         xHlw==
X-Gm-Message-State: AC+VfDxSMznpH/dddddpe4jyoI7gHT4atN5CFlefHhH9+IeH6tw3x5TR
        nWqtnE1ZpJcYYUqHYLif29CMH5QCQgY=
X-Google-Smtp-Source: ACHHUZ57l2NYdjFz6gnbDv5RtxHSLeNECuh+UmIbNVUXxycz4UEWnF6Th5b5Yk8FZNtDi4ojGzHT9g==
X-Received: by 2002:a05:600c:2213:b0:3fa:e92e:7a7b with SMTP id z19-20020a05600c221300b003fae92e7a7bmr6995851wml.15.1688302914474;
        Sun, 02 Jul 2023 06:01:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:32f:1f0:ae0b:3bc8:c743:b2d8? ([2a01:e0a:32f:1f0:ae0b:3bc8:c743:b2d8])
        by smtp.gmail.com with ESMTPSA id y17-20020a1c4b11000000b003f90a604885sm24277641wma.34.2023.07.02.06.01.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Jul 2023 06:01:54 -0700 (PDT)
Message-ID: <ae400e28-0cd4-cdf8-811d-843e62cd4a95@gmail.com>
Date:   Sun, 2 Jul 2023 15:05:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] staging: fbtft: ili9341: use macro
 FBTFT_REGISTER_SPI_DRIVER
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230702080324.120137-1-rgallaispou@gmail.com>
 <2023070254-embark-subplot-4dd4@gregkh>
Content-Language: en-US, fr
From:   =?UTF-8?Q?Rapha=c3=abl_Gallais-Pou?= <rgallaispou@gmail.com>
In-Reply-To: <2023070254-embark-subplot-4dd4@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 02/07/2023 à 14:02, Greg Kroah-Hartman a écrit :
> On Sun, Jul 02, 2023 at 10:03:24AM +0200, Raphael Gallais-Pou wrote:
>> Using FBTFT_REGISTER_DRIVER resolves to a NULL struct spi_device_id. This
>> ultimately causes the module to an early exit at probe time.
> 
> So this doesn't work at all today?  Has it ever worked?  What commit
> does thi fix?

I tested again with only a tweak in my device-tree. The early exit in 
the driver's code is caused by a missing field. So regarding this 
particular driver the macro works.

It resolves to set spi_driver.id_table = NULL, which yields a warning in 
__spi_register_driver(). So I guess this patch only fixes a warning.

> 
>> In addition the MODULE_ALIASes can be dropped.
> 
> Why?  When you say "also" or "in addition", that's a huge hint it should
> be a separate patch.
I did not find any reference to those aliases in the kernel, which led 
me to remove those.

If you think they are still necessary, I'll split them in an upcoming v2.

Thanks for your insights,

Raphaël
> 
> thanks,
> 
> greg k-h

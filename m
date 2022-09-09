Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 645295B3E6F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 20:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbiIISAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbiIIR77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 13:59:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3290A138679
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 10:58:41 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id lc7so5873433ejb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 10:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Srs+1Vi4RvFdDPhBXtmUnH/GIvlrSvvrVz/Ri5d6Vsw=;
        b=IjHjg30W1/4+4nPBc9ElLosn7TuaI/MmuB2RBNBmaA5eRnvprGCC+dO6Kle57P/F5+
         vfrWkLL60P0/KRj+j6YNfeF1Z32MwH1X6K0BTHge6nZ/4opfxeudnTi9ArlQLC9fbp8/
         3Rq/SCOiXOr5/R1JVrLVEQH8WnpidIIs7J6ImhFRVvA7Ekzk3USEeIAlDDcfxuYRSTL8
         C7cyW26vZ6fUAjmfGDAcUPHcJFt06xd57+pJOV1s2iRmaPGW5uze43fERyD5s/grPwy1
         rYxzP1gnwzpeObWIsXGSXgVAZhjEsSQYA8YfmWV5rkfkIlts+48HKc/n+BPxObGO8WN+
         TzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Srs+1Vi4RvFdDPhBXtmUnH/GIvlrSvvrVz/Ri5d6Vsw=;
        b=Jqv/AK9rRu3Vq90v1DkN0NKjT8aP7gajxPRW/ASBy/BiPQR71yumgOA4Jq4lCpaYLQ
         jM+4XbLO4t8jB168TG2WTT6P270wrZ8+dTW3255JadJiSA23r6XM23syrsM8mWaIKl9b
         9HHnfdFqbqH7bTafHfJUUuHWNTwTs/4eKd184rGBO4psv5NB9v80S9HAm+KC2qjbFCJS
         LS8bZqDSmekhqcW+xhLsX3x8BPyd7PvcQKlyDgdHjNAvzB2IyJv1pTu/Oa2kCgc7mEll
         EP45tR8LeeOXCZRaoSEX8/L2mEcvm9li0oFtZcYDzUY33Oa+Fc7L7ao7dIwZ8ySpYe5+
         lAJg==
X-Gm-Message-State: ACgBeo1AYmYpUcYzz3J32a/m6g0c99BvXYbp8WDNJPRn0dbSEFHYhVA+
        VjQL42Ij1WI0hdGxVHUnzk15zbp7aKo=
X-Google-Smtp-Source: AA6agR7TaPPvNfsU2NfZNZFJSIqc6mYLalbQSr1rzrRdspSrZqkF7WXVD46+dKnewuhFIDS0be14IA==
X-Received: by 2002:a17:907:3e8b:b0:741:9c2e:1afb with SMTP id hs11-20020a1709073e8b00b007419c2e1afbmr10633629ejc.701.1662746319579;
        Fri, 09 Sep 2022 10:58:39 -0700 (PDT)
Received: from [192.168.1.103] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id t11-20020aa7d4cb000000b0044e8774914esm739666edr.35.2022.09.09.10.58.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 10:58:38 -0700 (PDT)
Message-ID: <2b19f1b0-0916-9fe7-99a4-33d0c626b7c3@gmail.com>
Date:   Fri, 9 Sep 2022 19:58:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 0/2] use memset to make code clearer
Content-Language: en-US
To:     Nam Cao <namcaov@gmail.com>, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
References: <cover.1662724786.git.namcaov@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <cover.1662724786.git.namcaov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 14:17, Nam Cao wrote:
> Re-write some code using memset to make it more obvious. Also remove an
> unnecessary volatile qualifier, because compiler complains about passing
> volatile pointer to memset.
> 
> V3: get rid of "volatile" entirely, instead of just casting it away.
> V2: re-write commit message because previous message describes a
> non-existent problem.
> 
> Nam Cao (2):
>    staging: vt6655: remove unnecessary volatile qualifier
>    staging: vt6655: use memset to make code clearer
> 
>   drivers/staging/vt6655/desc.h        | 2 +-
>   drivers/staging/vt6655/device_main.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>

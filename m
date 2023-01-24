Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E7967A628
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 23:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjAXWur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 17:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjAXWuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 17:50:44 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FBB611E86;
        Tue, 24 Jan 2023 14:50:44 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id be8so3338476plb.7;
        Tue, 24 Jan 2023 14:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m3d2xUJzcuTZwxJedz3ZzVGOlQpQeoNyDwzZ+VWtnWw=;
        b=bntIqt6hWU2W3cGziRRZV3oC6YWNpg8GpErUTMXsWMqAKG5BlJLnk6/k8Lm0o4vuMV
         v+6oLpXAHLxTugmoAVORIcpanh/rNWCayI7FZiBCKImbA7yhNGlkaKAVcLPWoJFZ4LM/
         gqqO7bckhbOUwZshLtDBu6iwzUmJLk7a4eXSOGTLCobQy/Z2AAQ1lMyZvlJ25ZWRMgGa
         hQPRIOz9cFBHUTbvpC1z4PgqwFvhE8bxp0pqoxkSWxsW6/hlwzXYHv8ajBQ+2BWpukvd
         crWgVvufgJyZtO7yQ4a9Llbrlt+GoZoib6MOgDAQHKYHmhSSPowLa8u6P93/I4O5uYdQ
         8FaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m3d2xUJzcuTZwxJedz3ZzVGOlQpQeoNyDwzZ+VWtnWw=;
        b=hrnS22PfecyX1B9B++fOZLvm1GPle/aWxcR/Lz9iFCdbKBlTf8Rajt3U11rTcHzZzK
         uq1QAKVGgoJ5G/kT3uakSIk5ZGNN5oHBQHecVR58hUWZ4SU1hzqkdHm3lpecQQHwjSl9
         GBczJqf5qwwfrD/MZou9YJeNyRARlIN8R7HNstu8KE1O5/C1bHlfI26/LJz5YS1COb7h
         UXdTR0IJcJVWDoZKJNHBCUp1w+OxjG+SKS23Qr3dz3gvUKAekhybQlKqETDHJUo481Xw
         QzGMxTbBb6uvquEn0aTYh0Y+Eg51gCs6hNkh1a8Uhfn84MaeGkd71dHBmma6UJS4HJxr
         AG2g==
X-Gm-Message-State: AFqh2kqpKCfzxMglW1RWz0uH5DqV93op475glyVhzXMH7sT4rIMDGBYz
        wCjtaUn103NuHIp18nRoTP+UXpjTJnefWw==
X-Google-Smtp-Source: AMrXdXsR/vURbmZYx/xStcEi7ddQ/TJMFPrjoT1oHcobziT+TBb6hSDR+4Ap5lpLJAfTx6FCIZif+w==
X-Received: by 2002:a05:6a20:45b:b0:b9:5fc4:6e3b with SMTP id b27-20020a056a20045b00b000b95fc46e3bmr17802418pzb.34.1674600643280;
        Tue, 24 Jan 2023 14:50:43 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id pg4-20020a17090b1e0400b0020b21019086sm5095625pjb.3.2023.01.24.14.50.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 14:50:42 -0800 (PST)
Message-ID: <f6022623-23c2-6e1e-596d-e092f7259f2e@gmail.com>
Date:   Tue, 24 Jan 2023 14:50:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 14/14] MAINTAINERS: Add entry for Broadcom Broadband
 SoC HS SPI drivers
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com, linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-15-william.zhang@broadcom.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230124221218.341511-15-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 14:12, William Zhang wrote:
> The driver and device tree doc were originally authored by Jonas Gorski
> and it has been updated from Broadcom recently including the dts yaml
> file and a new driver for the updated controller. Add Jonas Gorski and
> Broadcom engineers William Zhang and Kursad Oney as the maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian


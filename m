Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEFE61E310
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 16:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiKFPfD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 10:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKFPfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 10:35:00 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2DCB7F6
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 07:35:00 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id q9so24464446ejd.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 07:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9FDFktrW0wAx1f1BHMw8rTl7LtbuKPcvRcQH3aU1BUY=;
        b=i1F0zpJdoS7qsJHG0GXrYnqlWxoIIgR98FqkJOT4VIq6uqdMEPlOrbb/9YtnRU7yAt
         G1opFuHvwMiAwq/eWRolKzHqBzAOe4iocyZs9vnTuT4GQf3mL6gxJE3RRTMjA9KG5Mrj
         57seTB88bwzKb9Zxki1vGNDTzZtzZ4vOIECiihG8fSHvOrPZ3ijUK46nI9L9v9eRYTqb
         9vVYJHFqp51OvteKzRB1cuwbTmlWX9YajCyRHmAMsd0kkSC1W/0nvpNcn5a6lwlMkeqt
         kRCFjMVNss63ocgICbmC7PajbzzfssQ2oA1C+MfWzGjf5k670t6Y1dajkc31F/+BsOxd
         SjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9FDFktrW0wAx1f1BHMw8rTl7LtbuKPcvRcQH3aU1BUY=;
        b=jVgpH4Z4FsDtyYjlSByTAO3gwKTmSgOlriYoHvZyEQRT5eu3FsQ+Uew8Vr+TeLwkgA
         AvFzIMAqD1q6SO4wHw2ODWSuqAnreV/tohN7p4aqPajweYYOO9YVHLYeLBZYjRtvrfDK
         3H7OrtJQHT0bbYTr0vDRzKEhVA/5eWtMQ4Dlu/d7zgnpTHpxoaBISu5PM3Ty6Pv7CNL7
         Pvp4/vbOVWTfUzs6Rza2rxcTDweLbBpwLYyfoDrgb9tEM86m8+4/J2OFUsrdQSdn/IXC
         oh4IRRO5SQDTcwfXMSPIAkp/SW3gUwPxTcJp2ODn7mqBi+EQCbu9D08DgLZsrMAQ5Lp8
         zj5Q==
X-Gm-Message-State: ACrzQf1a7mRQkGxz2Yh3PMVZJKuiUoXQH3WfgQ4JM/XdIx0DZbc9O4p0
        SYKNhl3die/cevRMcEChn+w=
X-Google-Smtp-Source: AMsMyM4Wusv1N6eymYj7LFUZv5YPrfkF3/s4LOCO8kwE4pocykCIEAsR5icMC7SwSgCi++NCEvYC/A==
X-Received: by 2002:a17:907:2710:b0:7ad:86f9:9bad with SMTP id w16-20020a170907271000b007ad86f99badmr44542860ejk.32.1667748898578;
        Sun, 06 Nov 2022 07:34:58 -0800 (PST)
Received: from [192.168.0.101] (ip5f5abba7.dynamic.kabel-deutschland.de. [95.90.187.167])
        by smtp.gmail.com with ESMTPSA id s26-20020aa7cb1a000000b00462e1d8e914sm2782339edt.68.2022.11.06.07.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 07:34:58 -0800 (PST)
Message-ID: <5fa89086-c81d-0a3d-8d0d-0bb293052c5c@gmail.com>
Date:   Sun, 6 Nov 2022 16:34:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH] staging: r8188eu: clean up error handling in
 rtw_start_drv_threads()
To:     Deepak R Varma <drv@mailo.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20221106133443.8872-1-straube.linux@gmail.com>
 <Y2fGGsV5ZwxmkTNB@qemulion>
Content-Language: en-US
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <Y2fGGsV5ZwxmkTNB@qemulion>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/6/22 15:35, Deepak R Varma wrote:
> On Sun, Nov 06, 2022 at 02:34:43PM +0100, Michael Straube wrote:
>> Convert the error handling in the function rtw_start_drv_threads() to
>> the common logic used in the kernel. Another step to get rid of _FAIL
>> and _SUCCESS which uses inverted logic.
> 
> Hello Michael,
> Can you please tell how did you find this opportunity for improvement? Are you
> using some tool or is it a manual code review/analysis?
> 

Hi Deepak,

I just used git grep to search for _FAIL or _SUCCESS and then looked at
the code manually.

Regards,
Michael

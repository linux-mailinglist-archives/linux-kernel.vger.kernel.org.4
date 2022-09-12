Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB50D5B5E1F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 18:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbiILQX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 12:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiILQXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 12:23:23 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2144B2A72C;
        Mon, 12 Sep 2022 09:23:22 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id l5so7095200qvs.13;
        Mon, 12 Sep 2022 09:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=f/s93VerkeISAQKTR/XDUp54w5dbtKqamQRqfdXE/Cw=;
        b=gYm10M36+sXqa4lG4ctn/pZ5iooVZ5KGRMl3ulTYd8MwV5ncXA+crkpplMhEu9I14b
         jXeettIN6CX7a3dMDkTHpo54rO3bViXrX5qW0RTivbl7FK4KArH3QiUW2UFBLtFdJeKz
         EyEYFCSCLEHWUb5VBSNu6Nnf+/rtTUdmSRgZ4DEoGjfM11RxmZmVr9BD/peiQAsRXCBn
         54tFVN36NVTbC1AP7xfjrxnHkFpo+EzeehvFIEHI3SGrn62ibxX2G0lCHuecvcQJawzb
         Sh2rpiisThFehORoszthmqU1FIndu9tuT773NhFdWNIdVBOqbFblWgW+g1jkMZEwQz+g
         YfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=f/s93VerkeISAQKTR/XDUp54w5dbtKqamQRqfdXE/Cw=;
        b=5aLIyLLID0lfdBxcnXtFvpN/hHp4oJ5MCO1+y8CdoRJZO7S9JcG8Q87xZEfrUoklhj
         z93QNDUfAU+Pn9KhfxWcBB01MjMX6I1dUd/EUt3+7ykUI7vM44l/bDzSbfp3+lECnXKh
         i9IEgbqgecc7C0D0MvmBsZUWxmeuM/QfK8QQj2Lj6LQ4/gW7blEGXOE/O9eKdG0NTNei
         UT0HWb96B0b8C7S5anAxfRNu6rVHP2Lmpyx0WgYJIxgVVpOcsRcZidOkNqmpi+2Idnh/
         psCMBzMsC2dr1cTwk2bpO7qha8CVDhjzpD9okZP2qTPwsdI+1ThpwwFrVhAwkloxybam
         KqGw==
X-Gm-Message-State: ACgBeo25ROSLUXVLBjBIpySeEcaZxwNbKqk5EoIjBTfQaT2Oc68d7Ulf
        n/Hk3TPmS0H00H2aqNXo+Rk=
X-Google-Smtp-Source: AA6agR4v25aCDEB48/McOeN5RWIp7Dx4rsivPb3jN2RGL20GWLur7mAnc6iQWtQNNc862heGIGu0Qg==
X-Received: by 2002:a05:6214:29cd:b0:4ac:bcb7:18c9 with SMTP id gh13-20020a05621429cd00b004acbcb718c9mr2239270qvb.106.1662999801182;
        Mon, 12 Sep 2022 09:23:21 -0700 (PDT)
Received: from [10.69.77.229] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id f5-20020a05622a1a0500b003445bb107basm7304904qtb.75.2022.09.12.09.23.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Sep 2022 09:23:20 -0700 (PDT)
Message-ID: <62fe6831-b14b-7c31-f475-964b6eac4b03@gmail.com>
Date:   Mon, 12 Sep 2022 09:23:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] clk: bcm2835: fix bcm2835_clock_rate_from_divisor
 declaration
Content-Language: en-US
To:     Stefan Wahren <stefan.wahren@i2se.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Maxime Ripard <maxime@cerno.tech>
Cc:     linux-clk@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220904141037.38816-1-stefan.wahren@i2se.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20220904141037.38816-1-stefan.wahren@i2se.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2022 7:10 AM, Stefan Wahren wrote:
> The return value of bcm2835_clock_rate_from_divisor is always unsigned
> and also all caller expect this. So fix the declaration accordingly.
> 
> Fixes: 41691b8862e2 ("clk: bcm2835: Add support for programming the audio domain clocks")
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

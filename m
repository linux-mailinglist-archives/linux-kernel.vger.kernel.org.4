Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0421C68AA7F
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbjBDOKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjBDOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:10:28 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017D36FC6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:10:27 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso7853488wmp.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 Feb 2023 06:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9s6NAgqAsAyHqRtokq9Jv8AryOH+kxl/jYELgXGXAzY=;
        b=T/SRexPCns1O7QUBs/9ErL2CeaAIrG4f04lu/Rtibpf7cwRjIElH79gWb72Z2bY0jf
         ZwKyxeD/nyhFDQ+vxUsgz3ZaiTS5ohEflzRvYdVdYIpuP0YOvbnZDL/AmM7wGaf/05gy
         rWdK0urERezP99X0z0oL/GOyP+MZA+mA8MyYYNe6PNhiouZHrzywN1MIrdVwkAp6d05J
         MXGntrNcDgOHhnKE2vMJ/2cEG+RbmDUJm+T0p5g2E/7mg5lBer5uotaX7jKmi2eyydQK
         E7oZjmUEL/k4E2pR+m+S5+dtHHhd/XACcp8qgb3PoVJhErkcLRxGjEf0F8yrWaeYt+mT
         vrwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9s6NAgqAsAyHqRtokq9Jv8AryOH+kxl/jYELgXGXAzY=;
        b=LxLpn5jMFDcdoSaCzEf5gl3INkomSE5cg3k+GDzs8uhjZwDJBi+Kd3Ln+HxuAETHOT
         whpnIzjM+196Dp5+20xiRRBYLgy5TZ0xe0lcwgOI0cuWkRdg0gb+s2k8rEsvgn7E/7tJ
         Q392k/Wi9Vf6ryEdDmQH/9O01YIevIoZ0wE3Ok3aQPiZD2IGREoEJX71mzTnm0bIOgqf
         9SQWTiNZmz++lWin681mtKkXZhn77ZvWksbR1/Fd35X4IQkUZE9KDsMxRl5zE5B5QY68
         Ghcspf1HhV7nNIUL/raG4Aq7C7hP7PlK7HQ5KTktbDSMuclMychUuKMw7JZZjCyd59b8
         YDUw==
X-Gm-Message-State: AO0yUKUIPyJCYzwaYSxQyldumq/3nRTpSsyhJYA3PVlAJkA/cKfCpPC8
        DNrROPceniJLzfgYg7nvrCY=
X-Google-Smtp-Source: AK7set+N5x+cDjKx1IEGv1oZD6a5qD4dqZc7/THmEw2/IWEVZY1DxHpqNbMhkJR2rqL7qtrupPiA0w==
X-Received: by 2002:a05:600c:4e0a:b0:3dc:3398:cf6e with SMTP id b10-20020a05600c4e0a00b003dc3398cf6emr12591146wmq.2.1675519825850;
        Sat, 04 Feb 2023 06:10:25 -0800 (PST)
Received: from [192.168.1.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id y13-20020a1c4b0d000000b003dc4aae4739sm10587795wma.27.2023.02.04.06.10.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Feb 2023 06:10:25 -0800 (PST)
Message-ID: <86e96ed1-365a-7cf7-9e7a-140db15b35e4@gmail.com>
Date:   Sat, 4 Feb 2023 15:10:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] staging: r8188eu: correct error logic of two
 functions
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230204101654.10232-1-straube.linux@gmail.com>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20230204101654.10232-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/23 11:16, Michael Straube wrote:
> This series converts two functions away from returning _SUCCESS and
> _FAIL. Another tiny step to get rid of _FAIL / _SUCCESS someday.
> 
> Tested on x86_64 with Inter-Tech DMG 02.
> 
> Michael Straube (2):
>    staging: r8188eu: correct error logic of rtl8188eu_init_recv_priv()
>    staging: r8188eu: correct error logic of _rtw_init_recv_priv()
> 
>   drivers/staging/r8188eu/core/rtw_recv.c   | 30 +++++++++--------------
>   drivers/staging/r8188eu/os_dep/os_intfs.c |  2 +-
>   2 files changed, 12 insertions(+), 20 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

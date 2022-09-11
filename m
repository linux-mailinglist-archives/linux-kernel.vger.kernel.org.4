Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D661B5B50CF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 21:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbiIKTPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 15:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiIKTPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 15:15:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6BC819031
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 12:15:34 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id u9so15586965ejy.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=siH8GbCgzSgUrSeqhFveF0F9U0Hvq+9AhRsP9/PYgB4=;
        b=CrtGAG6bN4UEjWBpJL3YVLktnEO6VNRYbPZhAztaFxriztiQa5j2acS6ZAc4TP19id
         rszmXCQzUBHpwYDs5PmsKgqFVDdcqwinHZW86/OKa/27Z31wHWdmn+nDME8jyqe/XIW1
         KVoeduI0Aof64MK13sZYNqj7aUKHOOMSgrQeK02z3aKr/EyT8BaEdc1oKwC4oMqkpIpo
         KBTGbW8G6Kqn5vrBjVw7og0zSqQpXYo5KkjWgasgTRoC9DLxAX0yrkNfdrDoL7ue9OCv
         iOxCU6tf18fdI1BxGQ20mhNRzdDeDvwfhth/kuoAaQ2PXqWKNb/AxK529NR67V2DoB+Y
         W5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=siH8GbCgzSgUrSeqhFveF0F9U0Hvq+9AhRsP9/PYgB4=;
        b=ADMrrDW3IYWc1blJVtkleWwYniiA8naeHHLh5HCD61VhpiK84kgvdxXzC90SZQMWuE
         3fnlGyAR42f3jVxsbGcuxx3WBq3LVLFn7OhpGw09OVdDcg5u1TRbClF7MxZSgL2x5uua
         B/VZHnWWwuty6YkpO/dIP8obB1qeTPeMJhKx491ZA2oXZDYa7CeVh7rH5mY7ZOHQo7+D
         PIRdWcG/h6E3gRNxOeN28fJ0e3jjA9Ld5yKUCcIB5ya/ESLCAGaTnJ+8zwVASQfmNGQ7
         VTQxpvd2lqcWwBTkE3T+vxlXTZ6F4rVcRpY0kRABaGpXjDLyxgrm1ubuk/p/HhALR+mF
         9v9A==
X-Gm-Message-State: ACgBeo0mwzwaI6TreEpJKgf0qSNG/UsJWWHOe7j4GeiV8E0AMd94+0UC
        HkglGRHDWyF1M3yFOhKT3s4=
X-Google-Smtp-Source: AA6agR7+sL3YY6zdFMG25nfCaLTep5knbLZV7ruXS9yQctLegZrD+d55dHm2leBECZLgCMzC/lmiMg==
X-Received: by 2002:a17:907:763b:b0:77b:c559:2bcb with SMTP id jy27-20020a170907763b00b0077bc5592bcbmr4059857ejc.490.1662923733156;
        Sun, 11 Sep 2022 12:15:33 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id c19-20020aa7c753000000b0044ea1fe7ce4sm4371270eds.56.2022.09.11.12.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 12:15:32 -0700 (PDT)
Message-ID: <2a9d164d-d509-e59a-61d3-671526581423@gmail.com>
Date:   Sun, 11 Sep 2022 21:15:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/3] staging: r8188eu: remove recv_osdep.h header
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220911174933.3784-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220911174933.3784-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/22 19:49, Michael Straube wrote:
> This series removes the header recv_osdep.h.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (3):
>    staging: r8188eu: make _netdev_open() static
>    staging: r8188eu: remove unused prototypes from recv_osdep.h
>    staging: r8188eu: remove recv_osdep.h
> 
>   drivers/staging/r8188eu/core/rtw_br_ext.c     |  1 -
>   drivers/staging/r8188eu/core/rtw_cmd.c        |  1 -
>   drivers/staging/r8188eu/core/rtw_mlme.c       |  1 -
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   |  1 -
>   drivers/staging/r8188eu/core/rtw_recv.c       |  1 -
>   drivers/staging/r8188eu/core/rtw_sta_mgt.c    |  1 -
>   drivers/staging/r8188eu/hal/rtl8188e_cmd.c    |  1 -
>   drivers/staging/r8188eu/hal/usb_ops_linux.c   |  1 -
>   drivers/staging/r8188eu/include/osdep_intf.h  |  3 +++
>   drivers/staging/r8188eu/include/recv_osdep.h  | 23 -------------------
>   drivers/staging/r8188eu/include/rtw_recv.h    |  3 +++
>   drivers/staging/r8188eu/os_dep/os_intfs.c     |  3 +--
>   .../staging/r8188eu/os_dep/osdep_service.c    |  1 -
>   drivers/staging/r8188eu/os_dep/usb_intf.c     |  1 -
>   14 files changed, 7 insertions(+), 35 deletions(-)
>   delete mode 100644 drivers/staging/r8188eu/include/recv_osdep.h
> 


Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

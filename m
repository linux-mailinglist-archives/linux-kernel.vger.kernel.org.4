Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E535F3420
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJCRF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiJCRE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:04:57 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D26259
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:04:52 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id f1so6050100ejw.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=NvKGaoGjC6Yu6xtiRFq6MbTzbAxFa+B5R7nWn1UhP4k=;
        b=SQU8tzb+i5qz7F1TG0PxtutgODUrjACUsQTOKj0yU8Xz3zic2W56zMbDbxBECt5xV5
         pVXGgK/fgvSUKnHO2uw2HSS37vXyf8e2V5vefsXAa7qW4pwt77jajZJTMcuivylSj7eU
         8adQux7n3+rBSsWnUArxOguTyNtizQaEpTarw4gBhjzQcULgTY60Mu+Tw5gtMcqN+MBz
         dH3AmIsrTigaMIZDMD7gFnJ3N6k55tXWV8ZnJghoV3Vj1dVgZq7m5oYMx/9zP5bphdI1
         XceLE7qmYGgAetuP7jB0KqMv73T3AHV2cvRwDGKXqAO1wLy3zy7fvpXbDBqmLfcofh7J
         vdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=NvKGaoGjC6Yu6xtiRFq6MbTzbAxFa+B5R7nWn1UhP4k=;
        b=q2JNIS6nh2DDtiTkEQXONxQHwoYlqZ0OOxHGmDPw/AB/t+fuWoDSKiC5RSNxAwnsfg
         bIadMd6ZkEyAJdXE8rr8QTVyiUNL/6GXVRxAvalKODo8pY3vAp7+gns0TF/pVGmngDW2
         mwBfuQoIqUE9HvMx0Oh0JioFjk7zV3jsVl4aZzJZaR2EO4ctpiA/BPPndQbDGjTithJH
         24HEldr+ec83cpsEHPmnCQaISVEY3hfH1/ZJ0r9mck+HM3SPncmKQQnE/RPa6a9vQ30y
         vNGkklGJBEuC1+RP0bgcTz5Qst58VMKo34JOUfE8QEsS5LVi2Fcbu/pPDD/rhEHatLsH
         cl8g==
X-Gm-Message-State: ACrzQf0xT5Jg/48PA0eWSnlAG9hsWKaR34QaORMIv3+kV6bOJun66pyL
        q75zxKhm3TCInFi7onJZQ4s=
X-Google-Smtp-Source: AMsMyM7bIjzC4j42DUSy5Hnr9Z0KHd/yZHbTdOJ7Gka3C0Rc82nkNCuntjqiy+KMPAr9DfzGhez1mA==
X-Received: by 2002:a17:907:2c74:b0:77d:5624:6301 with SMTP id ib20-20020a1709072c7400b0077d56246301mr15197633ejc.133.1664816690626;
        Mon, 03 Oct 2022 10:04:50 -0700 (PDT)
Received: from [192.168.1.102] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id kx2-20020a170907774200b00781b589a1afsm5684402ejc.159.2022.10.03.10.04.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 10:04:49 -0700 (PDT)
Message-ID: <45b797ad-7dc0-cf9c-ef7c-59d8420c9e34@gmail.com>
Date:   Mon, 3 Oct 2022 19:04:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/2] staging: r8188eu: convert two functions to void
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221002143544.7974-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221002143544.7974-1-straube.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/22 16:35, Michael Straube wrote:
> This series converts two functions return type from u8 to void as
> part of getting rid of _FAIL / _SUCCESS.
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (2):
>    staging: r8188eu: convert rtw_reset_drv_sw() to void
>    staging: r8188eu: convert rtw_free_drv_sw() to void
> 
>   drivers/staging/r8188eu/include/osdep_intf.h | 4 ++--
>   drivers/staging/r8188eu/os_dep/os_intfs.c    | 8 ++------
>   2 files changed, 4 insertions(+), 8 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

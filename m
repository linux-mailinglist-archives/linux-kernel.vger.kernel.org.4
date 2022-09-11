Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35695B501E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbiIKRIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 13:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiIKRIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 13:08:45 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48A255A6
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:08:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id b35so9677678edf.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Sep 2022 10:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=JtKK92om0G2WOBVnqwpOEzB17LAG8qKM2Zhmdg8A6S4=;
        b=Z2HRxRGB91lOsuC6eUUPNgHwLqmjDcxMZ92LvFs/wrUpURtnUBps7W2DGgDwnFVnbr
         uXtNCAN/aOaN17Vnbdbv1X9PUHqidhNkmRyTVvXKYVbqUk660ix1N6JD5BwgwqDDlpWr
         cmIN5XWptg7R3ZimhhWn1ymJtGVLnzNsOKDJm71z3ckua6+yMkIaHtHqoz3zeqPisry2
         EbEbPpMzJz0YFNdcMQDc4UAJH7uE4rZj9V0+5L8FmqHE25bpYp5hR+8bhD489FUwyb9X
         N2SZtRZmnU0eA/UIA4SZnnayZz6ExfLXozfgArqCRGIdiU1EMfbv2kUYGjegpqRj4sd1
         osQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JtKK92om0G2WOBVnqwpOEzB17LAG8qKM2Zhmdg8A6S4=;
        b=In1CmnX91jS/ko4ht1rk87aTzk7qyyycNp/d6p+C9cpjiQA1V4ojVdVt3ooJVWg8co
         1iWidu1FECSjN0Tzw1EfMKtPsdRrZ3Q2MDDKeKld3IMkppojgrBycW4fg+A3leGEK1QF
         3MyQNJvEC2BB9lCcyAt+57nG1vgWg4fIduBBrbEDMXRjLYGjotulcxVN/K9dGKZhgtQU
         GO+10Vi7G7tN4Aa91Fh7ZFBU92yux/pidgBCST6y3qjaUcfRWyEuDJST8rXskxVgDKCj
         8OcIOV3qbCOr2qlKHaioj9nzbbFzZ/p9+eAiFKQ7egTJwmcvvjZmgnzQC8NrNwh0XnDI
         yCSw==
X-Gm-Message-State: ACgBeo3CnBswfvlFWsBpQdcuQj3EFHcN6RJl6TbKlAWt/2OsxbFUszpJ
        JqdmRtvNHBbKVfYuqdUBHQQ=
X-Google-Smtp-Source: AA6agR6r51nJtrAKM5UOSmlhYsNfYlIA+DoYdk4U2mxC/t6Uf2/oGtBM2IwFtzYGJYBzIkxe5TdMng==
X-Received: by 2002:a05:6402:1ccb:b0:446:4346:8597 with SMTP id ds11-20020a0564021ccb00b0044643468597mr19299220edb.177.1662916121414;
        Sun, 11 Sep 2022 10:08:41 -0700 (PDT)
Received: from [192.168.1.100] (p57ba2cf5.dip0.t-ipconnect.de. [87.186.44.245])
        by smtp.gmail.com with ESMTPSA id p1-20020a056402044100b0044e81203bebsm4246565edw.31.2022.09.11.10.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 10:08:40 -0700 (PDT)
Message-ID: <f85070d3-2ead-d80e-8789-2ffc00a8a582@gmail.com>
Date:   Sun, 11 Sep 2022 19:08:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 0/6] staging: r8188eu: some coding style cleanups
Content-Language: en-US
To:     Michael Straube <straube.linux@gmail.com>,
        gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220911161949.11293-1-straube.linux@gmail.com>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20220911161949.11293-1-straube.linux@gmail.com>
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

On 9/11/22 18:19, Michael Straube wrote:
> This series contains some coding style cleanups in the file
> odm_HWConfig.c.
> 
> Michael Straube (6):
>    staging: r8188eu: rename odm_SignalScaleMapping()
>    staging: r8188eu: clean up camel case in odm_signal_scale_mapping()
>    staging: r8188eu: remove unnecessary initialization
>    staging: r8188eu: rename odm_QueryRxPwrPercentage()
>    staging: r8188eu: clean up camel case in odm_query_rxpwrpercentage()
>    staging: r8188eu: replace tabs with space in
>      odm_query_rxpwrpercentage()
> 
>   drivers/staging/r8188eu/hal/odm_HWConfig.c | 60 +++++++++++-----------
>   1 file changed, 30 insertions(+), 30 deletions(-)
> 

Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150


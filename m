Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F04639B69
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 15:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiK0OpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 09:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiK0OpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 09:45:17 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0859BF4C
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:45:16 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vp12so18908243ejc.8
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUXgxrLtiv5I/LQlNEQb4l+Oh7igXNjdXrq3rf5J8X4=;
        b=gBMq8hfrt16Aw9izcazXcsAAESg4Uet8vUpMKOiQLkEEBKYNvi5/gOGatHK6u9dDzv
         8jjHXi8TcYSM8vymib4BcAshPgvYZtQuOz+GhOgXuw7OXBoiUkv6uNJTjSdf6MBzieuc
         hUTJi9MctsCbjyj6WhhDPMfmVwYUvsGSQDtuMD98cbJv3HC4r3AIhv+vxHBm0Pi2Xzba
         V/pqfu1PYZkkQGCmH8iRNrZKgw9WaMz1KHx/s2UAyYdhKAUOuFvkUqsFHXasz1PV8mix
         XbXanAopjcjdt6eKnklD6h5IZHdlDSZHmV3JtVRfnK5QSFZ92VrSs1E4Zg4R86pGuRJW
         XjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUXgxrLtiv5I/LQlNEQb4l+Oh7igXNjdXrq3rf5J8X4=;
        b=Xv4MwSTFwjFSV9sxFjhrA7KOnhjTPYHgTXi6zYZPos2IRv2i45ximpHWU/K2hpoPvc
         8MnNH8KeYOK/t22bKlHhXE0Oy4Qwts3xlPgubC3kjcRVF3f/JTnG97BPy9U5PH9qgERg
         tcO6c+Pq65+KGXkT0rsmmuIwONPw0dmBcAsMGMUqxh+SzNOHquYAPQLT9s3o9oat24LQ
         KX9yJBbRpLCyYvkKQnvJEb3Cnm2hvAsPjJMqT5qJ3//vzLzHiWtUFYf9MjcVPmG/CSLn
         fGm722PPrb6maTgNrFQ/ebox5BPww/NPjRuL/hPFB6DfgyhHtUSlnYI9PnLVfXc/3y5T
         HkqQ==
X-Gm-Message-State: ANoB5pni1T06nPR9uEZeJSrBPy8vtR0h5tqTcJivHAon5Vcvw4oNW0tm
        tNXO70I4F0aJ2nlT0Cg86Xc=
X-Google-Smtp-Source: AA0mqf6c+8WPcm/JlIo3iB1fQ/xqDK7wRMkWXpyMXY2y7dm8TQlMIs/+TF81znkGa2PL6vJqdvlpdw==
X-Received: by 2002:a17:906:dfef:b0:7ae:db2:f10a with SMTP id lc15-20020a170906dfef00b007ae0db2f10amr25590181ejc.709.1669560315225;
        Sun, 27 Nov 2022 06:45:15 -0800 (PST)
Received: from [192.168.1.100] (p54a07888.dip0.t-ipconnect.de. [84.160.120.136])
        by smtp.gmail.com with ESMTPSA id lb25-20020a170907785900b007933047f923sm3816923ejc.118.2022.11.27.06.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Nov 2022 06:45:14 -0800 (PST)
Message-ID: <b55f9596-6a2b-a65f-7de8-63c096a36317@gmail.com>
Date:   Sun, 27 Nov 2022 15:45:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/5] staging: r8188eu: another round of cleanups
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20221126154253.178275-1-martin@kaiser.cx>
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <20221126154253.178275-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/22 16:42, Martin Kaiser wrote:
> This series simplifies the issue_probereq_ex function and fixes other
> minor things.
> 
> Martin Kaiser (5):
>    staging: r8188eu: drop return value from issue_probereq_ex
>    staging: r8188eu: remove wait_ms parameter
>    staging: r8188eu: fix the number of probereq retries
>    staging: r8188eu: simplify the checks for zero address
>    staging: r8188eu: use ieee80211 helper for protected bit
> 
>   drivers/staging/r8188eu/core/rtw_mlme_ext.c   | 30 ++++++-------------
>   drivers/staging/r8188eu/core/rtw_recv.c       |  5 ++--
>   .../staging/r8188eu/include/rtw_mlme_ext.h    |  3 +-
>   drivers/staging/r8188eu/include/wifi.h        |  3 --
>   4 files changed, 12 insertions(+), 29 deletions(-)
> 
Tested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com> # Edimax N150

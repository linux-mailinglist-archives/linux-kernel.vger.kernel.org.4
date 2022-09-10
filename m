Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325F25B480E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 21:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiIJT3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 15:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIJT3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 15:29:10 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 594813ECCD
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 12:29:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f11so8302950lfa.6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 12:29:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=oOdTLog1ww4+Rwiwa3MAUwOOPiXVgt0XEL/X6i9LfOQ=;
        b=WGCl8V+AXHCnsZ/XXjoZRsoOxyOF1hPDc4jVXjwgWrr7B9vtRqexou1Mty3/Lgnedg
         1KyAamL9bu2qFziYV6GgJM1W94yun4ly9cVtEKevrICOvCBEAfuxHESke580tKKtqVEC
         PkTG4GUUJVjcVudGWGvstPLeUnVh/gh3nRZE/s6oRPosQ+FTSV+VTUPF5N0iz20rgZOZ
         nZO3cyEFxB4pMb3n80UmRLvW1JRJ3i5rIZLMfyoYMOIwfc6ubjDnz4dZMPzu+6FM3d+v
         leaiErteasjlKd8OcSOTN1bQ0TeCv/fGfe/OuIVOapfHWMEGzdGJMUT9tlCkq4xS2k0N
         H8Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=oOdTLog1ww4+Rwiwa3MAUwOOPiXVgt0XEL/X6i9LfOQ=;
        b=xdtMNY2MkMnA2Zk73FlpO8BAmKM9HCP+JVkKdO/xVXj+WPLk1nzl4wOliDt8IEQd7n
         nF3vzSSqBuYBXPIz2OcSy2gfkXqlk2oRuql+c+OSh0zLUZM67fUukYXciFx8nxidj/e5
         jV0j83TlEjLpfkJyzQoJGN5M42tjwFrwDMBJdnB2SLOzgJEtO3ByBWT4cFlxrYP55nh4
         i3s7Rq5m7XXGNUI++9h3wKYCcJI8TtzKL8R/yfIheVG1fFRsFC2WbI+fBCr3yVHBv5Vo
         4+NnAUVhPPZqgyW3lAsXp0AZlirTDtKF5cdgbrlLEOh6hgmVQC2WoQcc+3jwCh8owWTo
         ffXw==
X-Gm-Message-State: ACgBeo2oz964djDodsCrK56Z/g+nhlfmKmC1YG8QIuCc6Uzzgwqythz0
        IAWeHjq6dr5ZM1J8sHau4cY=
X-Google-Smtp-Source: AA6agR7jcY3FAyjxtezWbgMGBh752c3IXRZnmhtVH/5q4ruz/GBmFkF2o0smgP5hdwm93W53pcbc7Q==
X-Received: by 2002:a05:6512:3984:b0:499:b142:9a52 with SMTP id j4-20020a056512398400b00499b1429a52mr1108383lfu.253.1662838147458;
        Sat, 10 Sep 2022 12:29:07 -0700 (PDT)
Received: from [192.168.1.11] ([217.117.246.58])
        by smtp.gmail.com with ESMTPSA id i24-20020a0565123e1800b00492e5d31201sm353098lfv.7.2022.09.10.12.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 12:29:06 -0700 (PDT)
Message-ID: <9df4bb0a-d494-551b-c7b9-cc93853e8620@gmail.com>
Date:   Sat, 10 Sep 2022 22:29:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH 0/4] staging: r8188eu: remove empty rtw_*scan* macros
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20220910180236.489808-1-martin@kaiser.cx>
Content-Language: en-US
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20220910180236.489808-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

Martin Kaiser <martin@kaiser.cx> says:
> Remove four rtw_*scan* macros which are empty or constant.
> 
> Martin Kaiser (4):
>    staging: r8188eu: remove empty rtw_set_scan_deny macro
>    staging: r8188eu: remove rtw_set_scan_deny_timer_hdl
>    staging: r8188eu: remove rtw_clear_scan_deny
>    staging: r8188eu: rtw_is_scan_deny is always false
> 
>   drivers/staging/r8188eu/core/rtw_ioctl_set.c | 5 -----
>   drivers/staging/r8188eu/core/rtw_mlme.c      | 5 -----
>   drivers/staging/r8188eu/core/rtw_xmit.c      | 3 ---
>   drivers/staging/r8188eu/include/rtw_mlme.h   | 4 ----
>   4 files changed, 17 deletions(-)
> 

Acked-by: Pavel Skripkin <paskripkin@gmail.com>


With regards,
Pavel Skripkin

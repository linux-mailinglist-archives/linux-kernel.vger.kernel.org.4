Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9616E39CE
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDPP3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjDPP3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:29:00 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0846C1FD5
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:29:00 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1a524c999d9so12040545ad.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681658939; x=1684250939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YUpkKa9lSybfFOxcoDD5YeVul+uOBvZq53WUTUhoysM=;
        b=OGBgitdOjVVBrw/PI50cjAT7bb47JG1/GHVc8+NRhctY+dd5lemjYnyEs5GCJ2Z/2I
         xCSnY03km+OPcsndESmMhvaStIaUOidyNKgzRUgAl8tW2PIyJs0JfXS57O77nB6BYcr2
         06D9p6+SKQbqTV3ORT9adeuK2j6HbTO5V910gTpLSvYXG0y5YNp95ol4QxTkysGnF44y
         GucmPqptFNIBok8T8WSZQ9h5VTu0zXnuvl0oJvjrXS3QMGg+Dj/pwbNoFtiep5hHzwce
         qN1s1OPGr28sv++G0BJs1pFkSBqee38JYfHGcRUiNMfgFoCI+1FqBlBPJZ/AaQeQJoUj
         zheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681658939; x=1684250939;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YUpkKa9lSybfFOxcoDD5YeVul+uOBvZq53WUTUhoysM=;
        b=BK94Nr4vD/eIRBsNphrZBbfWrw51lxO4/27HRqEjrePu8qFPbfTLpITYqAGoSc32dC
         i6Wgqw9PZB9CCAp9Kiz+RzltFBqDdDU6WKfqZsGXfon/ncqcg/O/qe2pzMd+DBNYsuhV
         7r2r0hLSllupoWiqxUPkKR1aqcI5xOqMgDTWPqiFMkAfFs0imoF/EYygtJlswPXzLoxs
         oGs7iavyLNlq70ByAQ+fpN+DugeLcJJFkQpbOm7z9Sl2jzFnK/A809fhOKD/rpRk2Jgy
         AkYHB59xrht3FuWLA3tj9wN098NlyMt/Sm5OFMoKTmqOpbd4NrZpNRn1Xdi4iTxrtDHR
         maWw==
X-Gm-Message-State: AAQBX9d6HBVEL9aeVt0/FHGM5ehov6Xa/C2c0htLZK4VC3nik3IsuoHd
        uZ9n1dwT+OsbtKs/lAyoR70=
X-Google-Smtp-Source: AKy350YEmDIy25Bd8zKiuQ+6OSozvZjGFHDXPHWFGtuns4RRszXGEgg02bOTHpE891nfmsQq6QJI1g==
X-Received: by 2002:a05:6a00:10cb:b0:638:7e00:3737 with SMTP id d11-20020a056a0010cb00b006387e003737mr15487247pfu.23.1681658939348;
        Sun, 16 Apr 2023 08:28:59 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id y64-20020a636443000000b0051b4a163ccdsm5376005pgb.11.2023.04.16.08.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Apr 2023 08:28:58 -0700 (PDT)
Message-ID: <f2bbe197-803d-14c4-4bdf-37d89c285933@gmail.com>
Date:   Mon, 17 Apr 2023 00:28:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 0/3] extcon: Core cleanups and documentation fixes
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Bumwoo Lee <bw365.lee@samsung.com>,
        linux-kernel@vger.kernel.org
Cc:     MyungJoo Ham <myungjoo.ham@samsung.com>
References: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <20230411114824.82960-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 4. 11. 20:48, Andy Shevchenko wrote:
> A few fixes and some cleanups against extcon core module.
> 
> Changelog v3:
> - dropped NAKed patches
> - added missing tag (Chanwoo)
> - dropped unrelated change in patch 2 (Chanwoo)
> - dropped misplaced tags (Chanwoo)
> 
> Changelog v2:
> - dropped applied patches
> - completely rewrote the patch to handle name field
> - dropped kasprintf_strarray() patch for now (Chanwoo)
> - used new IDA APIs (Chanwoo)
> - added tag (Bumwoo) to the patches that haven't changed
> 
> Cc: Chanwoo Choi <cwchoi00@gmail.com>
> 
> Note, MAINTAINERS shows what it has and hence the above Cc is manually
> added. If the database has issues it should be updated, but it's out of
> scope of this series.
> 
> Andy Shevchenko (3):
>   extcon: Use unique number for the extcon device ID
>   extcon: Use sizeof(*pointer) instead of sizeof(type)
>   extcon: Drop unneeded assignments
> 
>  drivers/extcon/extcon.c | 35 +++++++++++++++++++++--------------
>  drivers/extcon/extcon.h |  2 ++
>  2 files changed, 23 insertions(+), 14 deletions(-)
> 

Applied them. Thanks for your clean-up.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9B85E697F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 19:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiIVRUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbiIVRT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 13:19:57 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA973057C
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:19:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id c11so6750425qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=YW1vyfK0IFS8wI5DuxeJs6+Exwqe/LMWpZCMhRTfroI=;
        b=Hxv2i39fcXPBjVK4g7jtOpTEqBgIAOOERFyAheJD0Fm8U3RHi2b/0QMBGhJVtG2cyp
         X/6KHWkPFrNJ/VGq43wSgWPOnZyUQKxF10KFm1+Ean18WhIswcgilKv1gxqP5huJCMrW
         mOQbF4OJ8kDwLB+MmCjaWYuFPECxrrRta7V28IOVERVc6WX19/q2de3W2GGaUB+rQE/t
         xTdx5C4U36GriccQPh4/o9Oc4PK8E0rz6Yc2Fx3OrKkpaeR9T7mqIJkL84Ci5W5VzVQT
         7Ku+v+TH2esBzY1PE5yL/1QSjfWeHfcfCHR0Sjy20LLQtcz7RVt/9cnPnhch8hD/Xwa7
         amnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YW1vyfK0IFS8wI5DuxeJs6+Exwqe/LMWpZCMhRTfroI=;
        b=46J7o3D0CuElJKwm3kbFgDyRLkWIwOfTuc6+psxujzmPNJjA8VFsvBYT2FUlw8TH/z
         SWjbFLVFwn2k4ZhlPOvmE+up3Zkgke6sULCjzWTDN0tg9u90PM8DroAh/0A/3PLjR/kf
         DwS3Ek7pX+fXqD10YpdcC7kPXi9jnltsm85e5M0iSN+MKPZMUUWeFN2kWsGm99fUY37i
         Ha/CCmp1SgJ1OHDPSVIn+lotBZ+Xy2KzKtciyOk5v0UWn6SBvvGYDCwPQueUQ5ONkHcy
         7faiImNGj4Q8d0e/XME9FH9nQOoS9c09H5ikPn9qgTmiu2oFzNPntQHP52YeGE1P9sCY
         nkSw==
X-Gm-Message-State: ACrzQf2VScMnlX2JHnA7zclq0ihBMSBuGS61uCP7qvmtlarM4xCH+44X
        hYXBYO8S3Gnt3KdYrzSKWok=
X-Google-Smtp-Source: AMsMyM5p34CrKi2jcfxG02C5TgN9snPm/q82SonXdwbQPz/zsl6+J33SRKgi9/iz2ewgjW8kqT2XOg==
X-Received: by 2002:a05:622a:50b:b0:35c:f172:514e with SMTP id l11-20020a05622a050b00b0035cf172514emr3869458qtx.60.1663867194659;
        Thu, 22 Sep 2022 10:19:54 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id w4-20020ac86b04000000b00342fb07944fsm3707104qts.82.2022.09.22.10.19.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 10:19:53 -0700 (PDT)
Message-ID: <87427dd0-7307-57b2-4008-2ffb839a099a@gmail.com>
Date:   Thu, 22 Sep 2022 10:19:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [GIT PULL] ARM: SoC fixes for 6.0-rc6
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <acdecda4-b11a-4e15-9ac9-6d2696218012@www.fastmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <acdecda4-b11a-4e15-9ac9-6d2696218012@www.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 9/22/22 08:32, Arnd Bergmann wrote:
> The following changes since commit 12f09234bde51810b3f7412b2b5c84af4c07cfb1:
> 
>    Merge tag 'renesas-fixes-for-v6.0-tag1' of git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-devel into arm/fixes (2022-09-02 12:05:28 +0200)
> 
> are available in the Git repository at:
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git tags/soc-fixes-6.0-rc6
> 
> for you to fetch changes up to aaa58141a5d7647b14d812dde92b8d680e0985db:
> 
>    Merge tag 'at91-fixes-6.0-2' of https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux into arm/fixes (2022-09-15 21:54:07 +0200)
> 
> ----------------------------------------------------------------
> ARM: SoC fixes for 6.0-rc6
> 
> Another set of fixes for fixes for the soc tree:

Looks like this pull request just missed the one I am replying to:

https://lore.kernel.org/linux-arm-kernel/20220918205038.3017866-1-f.fainelli@gmail.com/

In case Linus has not had a chance to pull it just yet, could you amend 
it? Thanks
-- 
Florian

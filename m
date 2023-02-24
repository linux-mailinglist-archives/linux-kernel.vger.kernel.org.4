Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2CA6A23C3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 22:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjBXV0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 16:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjBXV0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 16:26:18 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE8A1B2E8;
        Fri, 24 Feb 2023 13:26:18 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so4213870pjb.1;
        Fri, 24 Feb 2023 13:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0GCi2JQwruHr6r5czYS5DePcLBFM0iowN3CE86Y0+c4=;
        b=gKmSZTycP0MMmvjU1xYwRAmgBXaGOBirUFd70Uq8YM+4URzIt90yKKHRE3wkrm979x
         eo2L4yIEAxg3NdEpQObI1hWpVemXZ6x2qD1xuvhk1F8E6MafOAziNM83oIKDw3CrV1FM
         GhtXGGZX3t7fjAZ9jwldK5dp+OtghYKhfdtagUq7dqEdnUQxcTuoboJRT/nIV56mh7hq
         uPej7Pt/o3awk5z91K9Cbx4q4S7nYo+GVNMpBYvcIxx5j+KlZFJlmvEyfX4ZMLspgNsQ
         SguJy2oifJ7E193N1zODcWjwwXg7UPL2xtg9RqzKX8dn9J6Glz9zRAtRYh0ZkeR2nECb
         UwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GCi2JQwruHr6r5czYS5DePcLBFM0iowN3CE86Y0+c4=;
        b=FM56dgQi7ax1Pr+fdspdImLnUw5WBmqwWN+ms3wOUXL18i0rBhrN4sXN18GLUJxvNc
         prRutKYBR9aGYM1MiMnYDI0TWS/dX5kV34L2RltECwgM+Bsa+EkAPClS2CktxPAFfCKg
         RhnkOJwFWZUJjYomtU41KocsleB94eaTbIkGniXBaK3Hb9poAcUYXuFCPIvh9RR500PJ
         liXHkvUykfSa1ph6U+u6zJ09h2dHk1sT+2nE+12zAm1eKMbC1Xs5QZvNXbDU1B0DMu/y
         gFpK1QkIMQeOQyz/VQiDIAGogmNptDuLEiVqhbPMHhzaRl/QI2JkSgNYl57arcYorvia
         mijw==
X-Gm-Message-State: AO0yUKXLFJB6XugTtNFIGpfJAFez6uuM3F1Yzdvvaa4locxEO8oVFAKX
        ZQxhFDnbB1kXnwcn6FZOh2PgaWiWa6s=
X-Google-Smtp-Source: AK7set+MmDtK6Ik5bPi7L+RxVNTJ/ReiVLOLhWZ1CZYG/0+hYgXc/IO2mPWY/O7Bv/MBuhTJ8KKVIQ==
X-Received: by 2002:a17:90a:1c5:b0:233:e305:f617 with SMTP id 5-20020a17090a01c500b00233e305f617mr20756061pjd.32.1677273977508;
        Fri, 24 Feb 2023 13:26:17 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id mp4-20020a17090b190400b002375c356b0csm108132pjb.19.2023.02.24.13.26.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 13:26:17 -0800 (PST)
Message-ID: <fae989be-7f12-81f3-f236-f2658cf0f33f@gmail.com>
Date:   Fri, 24 Feb 2023 13:26:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 04/27] kbuild, soc: bcm: raspberrypi-power: remove
 MODULE_LICENSE in non-modules
Content-Language: en-US
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-5-nick.alcock@oracle.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230222121453.91915-5-nick.alcock@oracle.com>
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

On 2/22/23 04:14, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: linux-rpi-kernel@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org

Applied to drivers/next (cannot push right now due to some firewall 
issue). Thanks!
-- 
Florian


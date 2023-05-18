Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB37707783
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 03:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjERBm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 21:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjERBm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 21:42:27 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC17212F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:42:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64ab2a37812so13614777b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 18:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684374145; x=1686966145;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pvjw77fQ/ErJLaCJSMiJ2Mn6niHh8kIyIMJpAj+Is8w=;
        b=dfJL0x+uiW7HCq/mVm5ocC80LIodXAAhJkjZaDe8t9jsmomYEj0syfMDnaploNCaXk
         t7CHu5+a+/02szN/sn00ijEUpgxlJN62lWCceNY8iwobuU5NrKViYr2L3MWL55WwtM87
         eo7NiqEtSpjem6zPgChp/lKxelOt1JsIkr8pwp0o8gbe0wubIBCiWfk7udrgO03i4RdT
         ueRGKgeizfMHYaeb4BIlOtPbCrxL0+aoKwZvXHXdY0c2HRqWc5GiPUFz8uy06irzC+ZN
         jBkDdZ38UqW9j5Na7tscUzMAq230D4aer7h2UrzJf22gWBKsh8B/nK0kJZI8mYiAjs+L
         35nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684374145; x=1686966145;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pvjw77fQ/ErJLaCJSMiJ2Mn6niHh8kIyIMJpAj+Is8w=;
        b=ImHvqkjKeiGeT+S15SJDBIq3/GWvYW4lXAMyVa8R1cX7F7QYoQs4f0vCIns+L+qh4q
         wMfkK2+4ivcOj4zZi/GzpUL0RQ/7UXSyqyIBwKeqrbbWEyLyN7a6QWI6ICXGuHIngpUK
         uZNaBlN12lEN+FJcppACyjswyJAd6rJ7aczpGx1OEdyhdHhjm8CAAK8UzdT4SRloqb7Y
         v0O6st1QEjCCeCwY38VdgiR6hngy0l4LUfj8WMowqpf/R5CaA+djd6QB5YyB0xtcv2GR
         iuzsIXFUmZ0Xms9J0d9iUAKU0BcK2cK7N1V5PDVtCQ18MBTGP5Q1Nj/EYMAoNYFtT3WD
         jn1w==
X-Gm-Message-State: AC+VfDzFtyIEh2li9Peo2/ZDzscPat021vNUPHLgwcv+qcTouZE+tv23
        eOYqxiwgJ7iXD0MAr32WtMs=
X-Google-Smtp-Source: ACHHUZ5voyf0SZ/Qhe3EXUj4hd+AncQZuBwZ2/hJ2/4P4tl5mLWcvpjhwwo2z8kmHFYryOnWdVzAKA==
X-Received: by 2002:a17:902:ec82:b0:1ad:b5ed:e951 with SMTP id x2-20020a170902ec8200b001adb5ede951mr532805plg.13.1684374144882;
        Wed, 17 May 2023 18:42:24 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-73.three.co.id. [180.214.233.73])
        by smtp.gmail.com with ESMTPSA id f5-20020a17090274c500b001ac6293577fsm47640plt.110.2023.05.17.18.42.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 18:42:24 -0700 (PDT)
Message-ID: <b984f839-cf0a-fc25-41d5-656171774e4e@gmail.com>
Date:   Thu, 18 May 2023 08:42:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Linux Regressions <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Todd Brandt <todd.e.brandt@intel.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Tudor Ambarus <tudor.ambarus@linaro.org>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Fwd: BUG: Patch to spi-nor hangs Lenovo ThinkPad X1 Titanium with
 divide by zero
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I notice a regression report on Bugzilla [1]. Quoting from it:

> This is the system I'm having troubles with:
> 
> os-version              : Ubuntu 20.04.2 LTS
> baseboard-manufacturer  : LENOVO
> baseboard-product-name  : 20QA000FUS
> baseboard-serial-number : W1KS11R111D
> baseboard-version       : SDK0J40697 WIN
> bios-release-date       : 05/20/2021
> bios-vendor             : LENOVO
> bios-version            : N2MET49W (1.14 )
> chassis-manufacturer    : LENOVO
> chassis-serial-number   : R911Q4MM
> chassis-version         : None
> processor-manufacturer  : Intel(R) Corporation
> processor-version       : 11th Gen Intel(R) Core(TM) i7-1160G7 @ 1.20GHz
> system-manufacturer     : LENOVO
> system-product-name     : 20QA000FUS
> system-serial-number    : R911Q4MM
> system-version          : ThinkPad X1 Titanium Gen 1
> cpucount                : 8
> memtotal                : 15939728 kB
> memfree                 : 8428028 kB
> 
> Ever since 6.4-rc1 this system has hung on every S3/S2idle suspend and shutdown during reboot. I've bisected it to a patch to the MTD: SPI-NOR subsystem about introducing the "concept of a bank"
> Basically something about the new code is improperly handling the memory size on this machine. It's not complex but I haven't dug any deeper since I want it posted as quickly as possible. To reproduce, run any of these 3 commands and the system will hang:
> 
> echo freeze > /sys/power/state
> echo mem > /sys/power/state
> sudo reboot
> 

For the full thread, see bugzilla.

Fortunately, the reporter also sent out potential fix for this regression;
but to be sure it doesn't fall through cracks, I'm adding it to regzbot:

#regzbot introduced: 9d6c5d64f0288a https://bugzilla.kernel.org/show_bug.cgi?id=217448
#regzbot title: SPI NOR bank divide by zero on Lenovo ThinkPad X1 Titanium
#regzbot fix: MTD SPI-NOR: BUG FIX of divide by zero in new n_banks value

Thanks.

[1]: https://bugzilla.kernel.org/show_bug.cgi?id=217448

-- 
An old man doll... just what I always wanted! - Clara

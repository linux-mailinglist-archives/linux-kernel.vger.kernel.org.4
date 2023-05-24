Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F343D71018D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 01:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237780AbjEXXLK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 19:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236418AbjEXXLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 19:11:08 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6941A99
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:11:06 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64d2467d640so1708677b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 16:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1684969866; x=1687561866;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pe7gaA9UsfRuwKM22JT9QpzO4MPDni9Xx35THIw0/Sc=;
        b=nUdfLTJ9VXB4wv2uw4rTFXldJ6hEnnl/9n+CZ3JkG+aT0voqj3TrFZDAt2Q28c0THo
         YuTu6F0JK3xReQo9yXuLvzzkW7tNgk6prvoCONpLoYmXY1Y4ecakBH1gWCVrDJ+SQpyX
         UFtPcdm2Rg31k3hHkqztUBvjXqmUvL7y/O+HNbYDvmOixVWhoe6TzjT8bvdYVj6hn3G8
         IGV2Et1NOv62l45AiIKSRhTuWJ+3xhb5DRJpW9N1ezgZeESSLDGqmvc31ujVFbFYvM7X
         vNIHNigqhGdGFAWI5AEEFNMsBkR0bPjKtNWsj15aV3Oxz6XbI4uxvRF32GQPasV6ISns
         T0gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684969866; x=1687561866;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pe7gaA9UsfRuwKM22JT9QpzO4MPDni9Xx35THIw0/Sc=;
        b=WUk26OndCEE8jKAp622RFlo2x4m1NeafHINJv2E8vhJsiZYXPSzpXlNmdo0UB7X6Vz
         vi6UgfWW0HOH2w/vNSqiIWkD3VDR7ucRENr4HJzusC+X0+SmfjsxVO00K3erpv0AuWq5
         4Y6LESa+J2lwUNb4+40ZGKrfIvLIAAUZHvRP9REdzGbGrSLedvWmMFHgeRXyRzZwutlg
         rSSaLeu2lDPuF2YtBgCMsb/9Oml2B1euC81RSxPLc8cG8gq3hedFdwdZFRk6t69S2kTG
         JCv0s3K2LkxjyvJRjrT0JxTh2o2vnyeEFHtnt1j74YqYfVs9kvX7CVsgb1i64eaqEpVQ
         Tvhg==
X-Gm-Message-State: AC+VfDyVw+Te4A+DmPgGiKZQCgJjgoMDv9hv2FAqdN/tt7JZYLQtUAj9
        phHoh0XTyV53Ie5hcQwVwEu56A==
X-Google-Smtp-Source: ACHHUZ5obUwMpsIPazuOVWmOubniktGfHOyfscZDmvlWCHJd4LOz14T+fX5wTLTyVKpkDbu+dfUXGw==
X-Received: by 2002:a05:6a20:728c:b0:ff:da37:ae9 with SMTP id o12-20020a056a20728c00b000ffda370ae9mr22151852pzk.53.1684969865718;
        Wed, 24 May 2023 16:11:05 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id v4-20020a17090a458400b00246f9725ffcsm27113pjg.33.2023.05.24.16.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 16:11:05 -0700 (PDT)
Date:   Wed, 24 May 2023 16:11:05 -0700 (PDT)
X-Google-Original-Date: Wed, 24 May 2023 16:10:39 PDT (-0700)
Subject:     Re: linux-next: Tree for May 15 (several RV64 build errors)
In-Reply-To: <20230524-scalping-number-63ec10c1f7bf@spud>
CC:     rdunlap@infradead.org, Arnd Bergmann <arnd@arndb.de>,
        alex@ghiti.fr, Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-29a35d51-8791-449e-96f6-a7faf77f3f36@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 15:49:41 PDT (-0700), Conor Dooley wrote:
> On Wed, May 24, 2023 at 03:41:15PM -0700, Randy Dunlap wrote:
>> On 5/23/23 23:23, Arnd Bergmann wrote:
>> > On Wed, May 24, 2023, at 03:29, Palmer Dabbelt wrote:
>> >> On Tue, 23 May 2023 17:22:20 PDT (-0700), rdunlap@infradead.org wrote:
>> >>> On 5/23/23 06:07, Alexandre Ghiti wrote:
>> >>>> On 23/05/2023 04:28, Randy Dunlap wrote:
>> >>>>> On 5/19/23 03:42, Alexandre Ghiti wrote:
>> >>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .data LMA [000000000041a000,00000000075bffd7] overlaps section .text LMA [00000000000f09d4,00000000033562ab]
>> >>>>>>>> /opt/crosstool/gcc-12.2.0-nolibc/riscv64-linux/bin/riscv64-linux-ld: section .init.pi.text LMA [00000000033562ac,0000000003359137] overlaps section .data LMA [000000000041a000,00000000075bffd7]
>> >>>>>>>
>> >>>>>>> I'll check this one too which seems to be related to kernel/pi introduction.
>> >>>>>>
>> >>>>>> Thanks to Bjorn: this is caused by XIP_KERNEL, which is known to have limited size, hence the overlap, so no fix for this one. Is there a way to exclude this config from randconfig?
>> >>>>> Does this mean exclude XIP_KERNEL or something else from randconfigs?
>> >>>>
>> >>>>
>> >>>> I meant excluding XIP_KERNEL from randconfigs: it has very strict constraints regarding what can/can't be enabled then it needs human intervention to make sure the error above does not happen. So I would not bother testing this in randconfigs if possible.
>> >>>
>> >>> I can exclude it from my randconfig builds, but I don't know of a way to exclude it from randconfig builds in general (i.e., for everyone).
>> >>
>> >> Arnd had suggested a trick related to menus that would result in 
>> >> randconfig never enabling some config.  It'd suggested for 
>> >> CONFIG_NONPORTABLE, but we didn't use it because it'd reduce randconfig 
>> >> coverage.
>> >>
>> >> Maybe we should add a CONFIG_VERYSPECIAL of some sort and hide things 
>> >> like XIP behind it (maybe M-mode too)?
>> > 
>> > I usually add 'depends on !COMPILE_TEST', that excludes it from most
>> > build bots.
>> 
>> XIP_KERNEL already has "depends on !COMPILE_TEST", since April of 2021.
>
> Half of me wants to say just remove XIP_KERNEL entirely. Or make it
> depend on BROKEN, since noone seems to actually test it and I don't
> think we even know if it works right now?

Ya, let's do it.  If it's broken and nobody has said anything but 
randconfig, then probably nobody's using it.  Let's mark it as broken or 
deprecated or whatever and then see if anyone complains.

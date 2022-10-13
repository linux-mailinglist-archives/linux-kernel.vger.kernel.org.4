Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4065FDEAD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJMRKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJMRKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:10:18 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3F14D800
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:10:17 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id g28so2496026pfk.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zmAVjflQECCsyuXdQ9DTog+keMBod15Gf86x/VCpEmQ=;
        b=bvaH6QmBDklxeLgR6dX5IIz9uZ0wCsjvs/S7fgGREjAk4/ww8YzIfiGJtg82/v1e2z
         D2nfkXDN19cOnfH4DK8xHTsoLTNO1nH1I3U4uVw8oNEaa/Qfl/E/Oao6i1NDxpiJyoKr
         vQUcOzRMtDAX5O8l6IM+ZFA3TNlFy5WgQ+Pms1M5zWmBLS7Ex27RerkP6B5IdjKzSO+9
         FUjNyRcW086ZM6x15B84UoK1yQquSEeR7+yfEjMZSd0sC4rS9bsJEsqMYRu/rnzz1iHM
         +/SE39XR1NOczLHzCheiCYS8TA2QO6EZ8cBgUVY7tVZKeaJWveFoVZpAXsNLBR60CtN4
         ySLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmAVjflQECCsyuXdQ9DTog+keMBod15Gf86x/VCpEmQ=;
        b=3iZ+YzJp847n+QOi/JQDe09nenFZjf6N7kB+Q9t0G2G/NGacKhVPu+JLDQMd/rgLcT
         ycyAFqFXYG2A/OI4ZBUjzP1BzzAODH9h0Q08qUOENu+ouCM64e2yMmSKHVP7CMM93c4M
         bQz1B3nk4z7ZyMDl5T0TIymHYZ0PgMYjOI5wfdFwmai81YcDjbH5uB5DWPo1w0s8Ro/v
         muzb6RR8nK2sy2gjGNwCx1K5E3yWTM6rAvlVYUUqH5sE2zZTjuFvTEVbtysQweNUvloG
         QZJ9SI8ro8OLbzXsLbgQhfJhtuOJg9+yYcPqG4uZgMIlvFLCaWBhdhmrm6L4ZD26xMlo
         3w6g==
X-Gm-Message-State: ACrzQf2DqTD3DlhRGWVy8JobFvr7qtcBMafWuN7VrxELw4wCPY81h/q2
        z+pJxyrQ7o9K1mgevK2kPJfYHEDgXTSQuw==
X-Google-Smtp-Source: AMsMyM6BehDWIQLNvawv1HtwrMIf/ivu2t2YzN3OUijyCZ5d/MKpJeA0ZTXg0f7pM0LOia0T8B8UWQ==
X-Received: by 2002:a65:6e0e:0:b0:434:59e0:27d3 with SMTP id bd14-20020a656e0e000000b0043459e027d3mr725314pgb.185.1665681016703;
        Thu, 13 Oct 2022 10:10:16 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902cf0b00b00176acd80f69sm115872plg.102.2022.10.13.10.10.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 10:10:16 -0700 (PDT)
Date:   Thu, 13 Oct 2022 10:10:16 -0700 (PDT)
X-Google-Original-Date: Thu, 13 Oct 2022 10:10:25 PDT (-0700)
Subject:     Re: [PATCH] MAINTAINERS: Move from git://github.com to https://github.com
In-Reply-To: <Y0hEt51q+Fs0ICbB@spud>
CC:     f.fainelli@gmail.com, sbranden@broadcom.com,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     Conor Dooley <conor@kernel.org>
Message-ID: <mhng-0881314d-117e-437e-920d-611c7fe0139f@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2022 10:02:47 PDT (-0700), Conor Dooley wrote:
> On Thu, Oct 13, 2022 at 08:32:58AM -0700, Palmer Dabbelt wrote:
>> Github deprecated the git:// links about a year ago, but it looks like
>> there's still a handful of them in the MAINTAINERS file.  Conor pointed
>> this out about the RISC-V KVM tree, but I figured it'd be better to just
>> fix them all -- I've got a bunch of insteadOf so I didn't even notice
>> the deprecation, but new contributors probably don't and might get a bit
>> confused.
>>
>> Reported-by: Conor Dooley <conor@kernel.org>
>> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
>> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
>> ---
>> @@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
>>  M:	Scott Branden <sbranden@broadcom.com>
>>  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>>  S:	Maintained
>> -T:	git git://github.com/broadcom/mach-bcm
>> +T:	git https://github.com/broadcom/mach-bcm
>
> This link is dead, I can't find a repo with that name on their GitHub
> profile.
> @Florian, should this be updated to the stblinux repo instead?
>
>>  F:	arch/arm/mach-bcm/
>>  N:	bcm281*
>>  N:	bcm113*
>> @@ -4055,7 +4055,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
>>  R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>>  S:	Maintained
>> -T:	git git://github.com/broadcom/stblinux.git
>> +T:	git https://github.com/broadcom/stblinux.git
>>  F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>>  F:	arch/arm/boot/dts/bcm7*.dts*
>>  F:	arch/arm/include/asm/hardware/cache-b15-rac.h
>
> Other than that, I clicked all the links - some look dead but that's not
> the point of this patch..

Thanks, I just spot checked a few to make sure nothing went way off the 
rails.  I guess we could leave the broken ones as git:// to make it 
clear they need to be updated?  Not sure that helps any, though.

> Tested-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.

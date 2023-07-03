Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0356B746329
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGCTD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjGCTD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:03:26 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 083EFCA
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 12:03:25 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso2474002b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688411004; x=1691003004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2RYZRLdkNoiixgGGXsCAsn40wE9t2aXAfVNzXokwOc=;
        b=YRPxXzGc4UuYzbUAXbPHrASt5qkMMnE+qv577e9xoiY0qIQ7l7/oStaFPnopW0oxCG
         AiMz0AKa25o4ThiYM9wkdLrVxFOwAPhvifaGRw8kbuk8uVl7dBiKjQXarb5rYmbfnA5T
         IQdEBHnH5pwK+Uopjec2Mgd0ZJHfOnt6eNkLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688411004; x=1691003004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2RYZRLdkNoiixgGGXsCAsn40wE9t2aXAfVNzXokwOc=;
        b=dpuRRyE9x072/SJfRX6dLgV7SHAjBinMeZkYiNixNRV7T10ih5SNCA01hhzr6rWWRJ
         V8u2ndukXEnQHpaveCZORwi8UcHVJeQyIdUAyg+oAAqedtT02cEWL0v7vEtZTtCP0Vvp
         xqzh+XHXRGChbbmcFuvy5awC/sxHN9Su1eyczFvFh3BVIb7LcL7T/8fvjVSkN3MAE1OH
         4CroWfJtHx06Ze8KPr1VRsEsZ3y1ayPNBYiiqijqw9go6B0/y2KwEi44acF1yNZYj6pd
         2qox7gkGCUmb86UjX1IKxPiNhiqMpY/sx1jXoDOUVCdoPA7ymIatxCOF4lom3d83qvD2
         EvyA==
X-Gm-Message-State: AC+VfDxVcMZfDmy0emEaZAKZSVZmneCg4RqQBm6pFW43lE4D/+M8DPqA
        vP6N2c3xuF35oKRSiG2zSLriKA==
X-Google-Smtp-Source: ACHHUZ6IXmGjtNBPTn5F9tKfIIbMruqpzIVIdDTQJTrxxqTXR2sQw4qGgV7Jdg1/hPAZMZHNu2YuRg==
X-Received: by 2002:a05:6a20:1013:b0:128:ffb7:dcff with SMTP id gs19-20020a056a20101300b00128ffb7dcffmr10025060pzc.11.1688411004501;
        Mon, 03 Jul 2023 12:03:24 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x16-20020a056a00271000b0067459e92801sm12973915pfv.64.2023.07.03.12.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 12:03:23 -0700 (PDT)
Date:   Mon, 3 Jul 2023 12:03:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux LLVM <llvm@lists.linux.dev>,
        linux-kbuild@vger.kernel.org,
        Linux Regressions <regressions@lists.linux.dev>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-hardening@vger.kernel.org
Subject: Re: [CRASH][BISECTED] 6.4.1 crash in boot
Message-ID: <202307031149.823F9A3@keescook>
References: <9a8e34ad-8a8b-3830-4878-3c2c82e69dd9@alu.unizg.hr>
 <ZKIoBVzrjZ+Ybxy9@debian.me>
 <202307022018.B26F5795@keescook>
 <625e951e-9922-d15d-5520-e8cd5eba1995@roeck-us.net>
 <4fa56264-f188-46f9-cc77-117b469b3328@roeck-us.net>
 <2b1a4f49-ba18-0246-af09-4e4133814411@alu.unizg.hr>
 <202307022230.6121D6896@keescook>
 <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed3e4315-b149-2f9e-70d4-45d7f83b9922@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 09:03:38AM +0200, Mirsad Goran Todorovac wrote:
> On 3.7.2023. 7:41, Kees Cook wrote:
> > On Mon, Jul 03, 2023 at 07:18:57AM +0200, Mirsad Goran Todorovac wrote:
> > > I apologise for confusion. In fact, I have cloned the Torvalds tree after
> > > 6.4.1 was released, but I actually cloned the Torvalds tree, not the 6.4.1
> > > from the stable branch as the Subject line might have misled.
> > 
> > Thanks, no worries! I got myself confused too. :)
> > 
> > The config you sent looks like I'd expect now too. Questions for you, if
> > you have time to diagnose further:
> > 
> > - Are you able to catch the very beginning of the crash, where the Oops
> >    starts?
> 
> It scrolls up very quickly. Couldn't catch that with the camera.
> 
> > - Does pstore work for you to catch the crash?
> 
> Haven't tried that yet. I will have to do some homework.

Try adding this to the .config:

# Enable PSTORE support
CONFIG_PSTORE=y
CONFIG_PSTORE_DEFAULT_KMSG_BYTES=10240
CONFIG_PSTORE_COMPRESS=y
CONFIG_PSTORE_DEFLATE_COMPRESS=y
# Enable UEFI pstore backend
CONFIG_EFI_VARS_PSTORE=y
# CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE is not set
# Enable ACPI ERST pstore backend
CONFIG_ACPI=y
CONFIG_ACPI_APEI=y

A go write-up about using it is here:
https://blogs.oracle.com/linux/post/pstore-linux-kernel-persistent-storage-file-system
and covers the systemd-pstore details too. Note that in the config I
suggested, I've enabled the efi backend by default.

> > - Can you try booting with this patch applied?
> >    https://lore.kernel.org/lkml/20230629190900.never.787-kees@kernel.org/
> 
> Sure, but after 4 PM UTC+02 I suppose.

Cool. xhci-hub is in your backtrace, and the above patch was made for
something very similar (though, again, I don't see why you're getting a
_crash_, it should _warn_ and continue normally). And, actually, also
include this patch:
https://lore.kernel.org/lkml/20230614181307.gonna.256-kees@kernel.org/

> > I'll try to see if I can figure out anything more from the images you
> > posted.

Yeah, the xhci-hub bit is the only clue I can see here. It's also in the
IRQ handler, which reminds me of this bug that we still don't have a
root-cause for the _crash_ during the warning here:
https://lore.kernel.org/oe-lkp/202306131354.A499DE60@keescook/
but I the new patch I linked to above fixes the source of the warning.

> I really couldn't figure out myself what went wrong with this one?

Having the crash scroll off the page is pretty frustrating. I wonder if
the kernel crash handler could changed to repeat the RIP at the end of
the crash...

-Kees

-- 
Kees Cook

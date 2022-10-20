Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482A460694D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 22:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbiJTUE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 16:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiJTUEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 16:04:25 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C89218A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:04:21 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id g10so841894oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 13:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FSU5vZGhDL5YE71yQgT2MCPFUtVB8F01lbEJpFp9jbA=;
        b=Q6F9AqN3FN/RTaVkWHIa3ScXqM05Qtup60Em3+Rz76spzTfg1C/MkzL+NIqHGDcf01
         0rJD8BSjrTMbwQsIgE2MiB+iNrdYDZQPqx841hNZiy/cVA67zPIy+VDYXlFKczVxMa6n
         57I5om8tS3qGSUKHTS+b9ZQR39LzbPJcBqCF+FRd8girnE1rnxeza9cVL1/otV0DkmU3
         udLrdRHUVrMJvbQiyweKSeUX0QOn27QdsS0+gp1K7UD75yt5Th+A/aEJzDAxOV62uXG4
         dTMwBhY4Kpt4QHC9CuAEfebfF53/FkCRTRG4eJAFnlGWIr3CF30sDs6ZXWTLZbKNskG7
         rqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FSU5vZGhDL5YE71yQgT2MCPFUtVB8F01lbEJpFp9jbA=;
        b=I9krPjFn6/vjdqVRqjHVRxxuMjtKDljuH1ySZZHWcZYJINq4VUFjx/WhJv/T3QIlcF
         danVOFiFYFYW/Bx9MNggfRLk12fhNzla471Bjp3JuuVOR6jDz9aSiUxoU6TmK1qQY7KH
         DsQm4D1vqrI2qZGfJIG+I2iCJFF1qMGjKZHxYWZ1KitTfJnTb3af2OjSVSkpgForxo2H
         a6NmcXT+/Z5ASy+bItQOTEvyCHJpTCJFBpc5nADtUmMDeW6JRcagV8GVKesxd+8xaMZk
         uzGwfli0OBM0qHoijqghNPASFypg+rwTczrqm6V+Z0lbLNRWWIlh+mLlnlI0/P17s+Ot
         /TtQ==
X-Gm-Message-State: ACrzQf0BGz7++Y9CZ/s7JwM9PQSXxJ34UEPP3FgAINZLSHWBHro7pHJ7
        amflzJq4N/wp3k2xzUr+ZJE=
X-Google-Smtp-Source: AMsMyM5nv9xsZ1BmIlThgWA9q+BIVrSil2nTeD7KA1/FccIg0h2nXg7E8StyDJuEcqfWv0kKk+/DVg==
X-Received: by 2002:a05:6808:138e:b0:355:2b42:1580 with SMTP id c14-20020a056808138e00b003552b421580mr14067581oiw.91.1666296260944;
        Thu, 20 Oct 2022 13:04:20 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id 22-20020a544196000000b00354978180d8sm337695oiy.22.2022.10.20.13.04.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 13:04:20 -0700 (PDT)
Date:   Thu, 20 Oct 2022 13:02:07 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Dennis Zhou <dennis@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [RFC PATCH 0/2] Switch ARM to generic find_bit() API
Message-ID: <Y1GpP+aY0o40MTNS@yury-laptop>
References: <20221020032024.1804535-1-yury.norov@gmail.com>
 <Y1F8ljDDqYElE3aT@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1F8ljDDqYElE3aT@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 05:51:34PM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 19, 2022 at 08:20:22PM -0700, Yury Norov wrote:
> > Hi Russell, all,
> > 
> > I'd like to respin a patch that switches ARM to generic find_bit()
> > functions.
> > 
> > Generic code works on par with arch or better, according to my
> > testing [1], and with recent improvements merged in v6.1, it should
> > be even faster.
> > 
> > ARM already uses many generic find_bit() functions - those that it
> > doesn't implement. So we are talking about migrating a subset of the
> > API; most of find_bit() family has only generic implementation on ARM.
> > 
> > The only concern about this migration is that ARM code supports
> > byte-aligned bitmap addresses, while generic code is optimized for
> > word-aligned bitmaps.
> > 
> > In my practice, I've never seen unaligned bitmaps. But to check that on
> > ARM, I added a run-time check for bitmap alignment. I gave it run on
> > several architectures and found nothing.
> > 
> > Can you please check that on your hardware and compare performance of
> > generic vs arch code for you? If everything is OK, I suggest switching
> > ARM to generic find_bit() completely.
> > 
> > Thanks,
> > Yury
> > 
> > [1] https://lore.kernel.org/all/YuWk3titnOiQACzC@yury-laptop/
> 
> I _really_ don't want to play around with this stuff right now... 6.0
> appears to have a regression on arm32 early on during boot:
> 
> [    1.410115] EXT4-fs error (device sda1): htree_dirblock_to_tree:1093: inode #256: block 8797: comm systemd: bad entry in directory: rec_len % 4 != 0 - offset=0, inode=33188, rec_len=35097, size=4096 fake=0
> 
> Booting 5.19 with the same filesystem works without issue and without
> even a fsck, but booting 6.0 always results in some problem that
> prevents it booting.
> 
> Debugging this is not easy, because there also seems to be something
> up with the bloody serial console - sometimes I get nothing, other
> times I get nothing more than:
> 
> [    2.929502] EXT4-fs error (de
> 
> and then the output stops. Is the console no longer synchronous? If it
> isn't, that's a huge mistake which can be seen right here with the
> partial message output... so I also need to work out how to make the
> console output synchronous again.

Got it.

I you think that EXT4 problems are due to unaligned bitmaps, you can take
1st patch from this series to check.

Thanks,
Yury

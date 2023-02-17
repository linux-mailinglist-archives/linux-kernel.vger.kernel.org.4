Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748F469B4A9
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjBQVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:24:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBQVYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:24:09 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012445FC72
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:23:52 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id m16so722919ilq.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 13:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1676669032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KEMNOuO8+jl8HrgRQYisWklYternUWLl59Yj+DzOu5Y=;
        b=Twm0LBWYpmVFprJhsa+ePCdzTFalANv8TPbn+PtACdxjR5/chuimox7tNJ9gzZPWdm
         Ivnw5TEUlJt2G1IfHauzFT9WJbzgyioPoSSiYpcU3ku4TLBOZ3Dz111VynWhu0CYiKJS
         Gi4aBn1EUyqAwSr1wbxAday4ZSod9vHW6qhWgGJqCXSMDvtLElwbLk0/LarfUbzjetq8
         wBZWP64hrkQ2QLzGD0UHLyfNHk5XHAU237Li2YZhS3x68R8r7JKs91furK9iHagz3H33
         jk83OPSNemuowSXMZDNhAbELVYtTr2pvIEMxJqUZOCvzmXc19x1Ef1URprtdlhoYhiuC
         8btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676669032;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEMNOuO8+jl8HrgRQYisWklYternUWLl59Yj+DzOu5Y=;
        b=YFo9EL9Lgrg+iIYxcdNzBItIwp91W+4ih5WySZLZ7wf8d4hIhTErKkGresk+eg8KuS
         LmFaPtf0ilegO2qMCpmiaShZh4NMKkC/sUKuk4IIkxoS4fKuCtZUECry15CFdHE7wq1Q
         N6N0dKrI5I2dhg1G/dGyyoFeuBGPgOeu79/ZsaJ1Hc14elwcePwpbBaOgdKcDoMtC7Kt
         C6eSKmrs73zl3fldLnHXtXj1fwowYvjlBBWfBFxF0BFwep8z6GjN92vjLJ7/2OOoubMP
         HDUkUO+YPT7uwxWcjyqM19VPySDG4SzQjflx9oanrQ2oj9zlkANV8ouv9gXJt7qi+rdn
         SBvw==
X-Gm-Message-State: AO0yUKUbLJlHKdXRjUuREgKpTCIOREALPW6Lq9pEhG++lLI5wSUgXTL5
        8rY6yb6zy7Lx4WM4owe1g53Eog==
X-Google-Smtp-Source: AK7set8oK+xWLmt8H/nJcfJrDmqcrK/zK5exSB3Nm35mqoz3QWa1kIcohnyQrqrkiF4nEFngviGyxw==
X-Received: by 2002:a92:1910:0:b0:315:8bf9:53d8 with SMTP id 16-20020a921910000000b003158bf953d8mr3528045ilz.2.1676669032256;
        Fri, 17 Feb 2023 13:23:52 -0800 (PST)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id u13-20020a92da8d000000b003154f7c11f7sm1627591iln.39.2023.02.17.13.23.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 13:23:51 -0800 (PST)
Message-ID: <151a00d9-0ea2-eadb-72b4-fa8a2dd41bfc@kernel.dk>
Date:   Fri, 17 Feb 2023 14:23:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: Re: [regression] Bug 217037 - cmb attributes missing from the nvme
 class under sysfs
To:     Keith Busch <kbusch@kernel.org>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, michallinuxstuff@gmail.com
References: <52f9afe2-f621-77d8-9d10-449d539e901d@leemhuis.info>
 <Y+5JdR02tlzD/TFS@kbusch-mbp>
Content-Language: en-US
In-Reply-To: <Y+5JdR02tlzD/TFS@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 8:19 AM Keith Busch <kbusch@kernel.org> wrote:
>
> On Thu, Feb 16, 2023 at 10:28:55AM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> > Hi, this is your Linux kernel regression tracker.
> >
> > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > kernel developer don't keep an eye on it, I decided to forward it by
> > mail. Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=217037 :
> >
> > >  michallinuxstuff@gmail.com 2023-02-14 14:16:26 UTC
> > >
> > > For the CMB-capable nvme ctrls, kernel was exposing couple of related attributes under the sysfs. E.g.
> > >
> > >
> > > # grep . /sys/class/nvme/nvme0/cmb*
> > > /sys/class/nvme/nvme0/cmb:cmbloc : x00000062
> > > /sys/class/nvme/nvme0/cmb:cmbsz  : x0008021d
> > > /sys/class/nvme/nvme0/cmbloc:98
> > > /sys/class/nvme/nvme0/cmbsz:524829
>
> The breakage is that the attributes are decided before we've setup the cmb
> regions. I'll send a fix shortly.

Michael, have you tested this? It's queued up for inclusion, but I don't
see any evidence that this was tested.

-- 
Jens Axboe


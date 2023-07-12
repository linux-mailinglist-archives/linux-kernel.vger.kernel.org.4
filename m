Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECF574FD7F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 05:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjGLDMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 23:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230474AbjGLDMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 23:12:06 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C22C1709;
        Tue, 11 Jul 2023 20:12:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-51e6113437cso2436915a12.2;
        Tue, 11 Jul 2023 20:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689131523; x=1691723523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1X3rocWR9NzmQmqjmOM0ugmoajYZ3hSwDhfHwSLSQ3Q=;
        b=gQGYGgLTZE4hIV/zsGR9mAw57f5zWDw80SpAUvdmQR+K8UYWILPzN7IAN3M6ZULyw/
         NeWp+eDPQrfDx8W5jIneQ4l0maWD/4vgSgmQrfPEZi1YOpTWFw5w7xBDGTWhJxMzMozu
         vdK0RHbQr3/iR2HmYSaMrR/S3pN7g2RSGww0hVHEK6rWi1kzvv5Uu7Ls/sSb64fLUUo0
         YEyIJcxoyxTVbxED8+Sxnk0zA+R/4JdOrwAwNfbYqzKgK/gXT3I2ueua06kKkuJerKSJ
         4zBAAiVzo9kIm/sRvcwFnv98SQ1n5Dzo7kuj0V3Vxx/tYwC1ZxHEHRlYqBmHeg3CJ8Xk
         lAQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689131523; x=1691723523;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1X3rocWR9NzmQmqjmOM0ugmoajYZ3hSwDhfHwSLSQ3Q=;
        b=hZelMMDmx8wxEh69K/7YFQgUoLRqD75MXiZlX58IFQ+TBKjt2GTizjJKYYLDu56ZMM
         SIBZTcbY4X0Df9JoWSkIcJoLmZzMbHKOAEcLysDyTEC6slnBqZsyYuFs5QTDATFMK2z9
         zZIurPzC/gJyoresXbfNczuI/hamHYt9dBLU1XBrl+34lX7mEFgHe8XYrJ4OprTJks2T
         AGUj4fHFtfPNbnJZ0J2knuXvdk6SS9CREtUGwoVH4IWcYfIelXlKv/nIZZ+cOR74RQsC
         cT8bgLuMg4pAMHN1SIZbLJJ7oCq2Tsq/u6wSDbHvv+B4am/QXQAoiJenB48GsFwF2he3
         CmEQ==
X-Gm-Message-State: ABy/qLZdVcyT/cdcqPU6wN1tWhMH7XWcC/xwRdGxfzqMz7L+RAYuQ0LB
        yjv9W7+/2O0zLsZ/Y56WdKVZRPJD/TBjoEfnnoglMzvLeGg=
X-Google-Smtp-Source: APBJJlFOibZl9aL1Dpq+SinnDJNzTDJUaEkYNCn6AgwkhLnpQUPdWFcpmLRHK8MDsHhUwm7VQm8d3az4DbMwGyBHYS4=
X-Received: by 2002:a50:fc1a:0:b0:51d:92bf:e6ae with SMTP id
 i26-20020a50fc1a000000b0051d92bfe6aemr15563303edr.18.1689131522838; Tue, 11
 Jul 2023 20:12:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230710080348.4137875-1-chunyan.zhang@unisoc.com>
 <fb86f01a-81b3-62c5-050f-f44e591bf272@linux.alibaba.com> <CAAfSe-ttuTvOE-BbnNk5LiAqhZHcPEe9XSeunCxkpG4-95Tcjg@mail.gmail.com>
 <dcc75737-35b8-eb44-559c-9d9697195879@linux.alibaba.com>
In-Reply-To: <dcc75737-35b8-eb44-559c-9d9697195879@linux.alibaba.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 12 Jul 2023 11:11:25 +0800
Message-ID: <CAAfSe-vNv=58k2b31xDqLmzSonWTsb5QJcXEyE3CoX81ND57mQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: sprd: Assign sprd_port after initialized to
 avoid wrong access
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 09:39, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 7/11/2023 10:57 AM, Chunyan Zhang wrote:
> > On Mon, 10 Jul 2023 at 17:57, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> >>
> >>
> >>
> >> On 7/10/2023 4:03 PM, Chunyan Zhang wrote:
> >>> The global pointer 'sprd_port' maybe not zero when sprd_probe returns
> >>> fail, that is a risk for sprd_port to be accessed afterward, and will
> >>> lead unexpected errors.
> >>>
> >>> For example:
> >>>
> >>> There're two UART ports, UART1 is used for console and configured in kernel
> >>> command line, i.e. "console=";
> >>>
> >>> The UART1 probe fail and the memory allocated to sprd_port[1] was released,
> >>> but sprd_port[1] was not set to NULL;
> >>
> >> IMO, we should just set sprd_port[1] to be NULL, which seems simpler?
> >
> > This patch just does like this indeed, in the label of 'clean_port'.
> > Adding a local variable instead of using global pointer (sprd_port[])
> > to store the virtual address allocated for sprd_port can avoid
> > overmany goto labels.
> >
> >>
> >>>
> >>> In UART2 probe, the same virtual address was allocated to sprd_port[2],
> >>> and UART2 probe process finally will go into sprd_console_setup() to
> >>> register UART1 as console since it is configured as preferred console
> >>> (filled to console_cmdline[]), but the console parameters (sprd_port[1])
> >>> actually belongs to UART2.
> >>
> >> I'm confusing why the console parameters belongs to UART2? Since the
> >> console_cmdline[] will specify the serial index, that belongs to UART1.
> >
> > The same virtual address stored in sprd_port[1] was reallocated to
> > sprd_port[2] after the UART1 probe returned failure.
> >
>
> After more thinking, I understood your case. :)
>
> But I see a nit in this patch, you added a 'clean_port' label to clear
> the resource for the fail-probe-port instead of sprd_remove(), however
> sprd_remove() will call sprd_rx_free_buf() to free the DMA buffer
> originally. I know the 2nd patch will add it back, but patch 1 is not
> git-bisect safe, right?

Actually it doesn't make git-bisect unsafe, the driver can work with a
memory leak issue which has been there and fixed in another patch.
But I can add back sprd_remove() to keep the unrelated code logic the same.

Thanks for the review,
Chunyan

>
> So I think you should also add sprd_rx_free_buf() under the 'clean_port'
> label in patch 1, then patch 2 moves the sprd_rx_free_buf() to the
> correct place.
>

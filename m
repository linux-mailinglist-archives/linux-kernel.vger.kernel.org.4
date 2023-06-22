Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A84E73A8C3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbjFVTDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjFVTDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:03:53 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DFF4186
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:03:51 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-51bec5c09ecso1024245a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687460629; x=1690052629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jd5WjCPFoP9daREip6mX62pgI0wMzSdCCjGL7ZKd2pU=;
        b=QkgtomfQATAGzTsLuzh39mv8ZnW735GXGVwS9SOCx62YjErfuwNWw1HpGXOK0O0SdB
         5ZLm6sIALaLBC3gOQGJHM4CcHObOzZ//DW0+hUxykKB5CG7plTCLK0NxOqGSF0kEjGMK
         egzKGLrcQAf9cUQBogkETRuGmF1g6EHLOWJz8fddhdxBeAC/QZEFCvsvn2MlWCMRXbvM
         3cr0FokqzK69WAORfD2VnjAR4guTon2Qw4mtqi7OQIZjrtcx7fcGd3XQmbLZr1u9fTd1
         4Ub4MKksgvuaau/wIrcs0T0AyIQGhlIhtwdj0tUOFBEXrnhQBIXgzzm+Bbi58ufCMNlX
         ZlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460629; x=1690052629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd5WjCPFoP9daREip6mX62pgI0wMzSdCCjGL7ZKd2pU=;
        b=AuMizgUMc/S+RE9jsapJMDgN61JzE8CEiBPSPKj4YNafuoeqo292mqNvkOM+OXQ0jQ
         QWTMW3/1p+wTjH96wP0qUPllodlV7rwc1nn841WrFj/gRmX6prE5fu/+0br7Lusl2rnF
         dBGFX5YiGJatBbge4llsa8P9qxsO5VqTDDDLKNlzRsvJs1LesRg5OTsIeuaRO3X2yD2z
         28ksTCNYH/nXLKi4d8H5UPGywZBVIpThxjnfF/3BqnedQ2x3aEpno2AH+QQ3tFubj5DH
         qn9+D680vOnIkCnu8gZrGmoXZMjGlWBwbl8NBSYvdo75C0zuc3h+XDP54i8hT5EczpJ5
         8XNA==
X-Gm-Message-State: AC+VfDz6yCxaItaHqByla/vBja1gq6GbkeLPNhHmD1jICW3l5CoU5WQh
        FyYg2isNQKDkI2wYRELhpeKFywpNV2dd1219FD8IOA==
X-Google-Smtp-Source: ACHHUZ5FPpu8RIJRu78y2BGapyPe97lCs0kqbcxbWD4gzS9XFDbyaz2lX0MVWr90I/F4TgxZ+lx8yg==
X-Received: by 2002:aa7:d981:0:b0:51b:ebea:18ee with SMTP id u1-20020aa7d981000000b0051bebea18eemr1715358eds.22.1687460629655;
        Thu, 22 Jun 2023 12:03:49 -0700 (PDT)
Received: from hera (ppp089210114029.access.hol.gr. [89.210.114.29])
        by smtp.gmail.com with ESMTPSA id b23-20020aa7c6d7000000b005187b5b82f7sm4405925eds.9.2023.06.22.12.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 12:03:49 -0700 (PDT)
Date:   Thu, 22 Jun 2023 22:03:47 +0300
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Jan Kiszka <jan.kiszka@siemens.com>
Cc:     Masahisa Kojima <masahisa.kojima@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v6 0/4] introduce tee-based EFI Runtime Variable Service
Message-ID: <ZJSbE/82z+319sTL@hera>
References: <20230622085112.1521-1-masahisa.kojima@linaro.org>
 <8ce9f761-347d-1e8c-17d7-241d88c82451@siemens.com>
 <CAC_iWjJ28uKVpz_FrJ6dcUjCkrV9w5UO4WRr9SQxYFPmtmj59w@mail.gmail.com>
 <65d010fa-c801-eb4f-352f-8bfb52a67c85@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65d010fa-c801-eb4f-352f-8bfb52a67c85@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 08:32:44PM +0200, Jan Kiszka wrote:
> On 22.06.23 17:04, Ilias Apalodimas wrote:
> > Hi Jan,
> >
> > On Thu, 22 Jun 2023 at 17:56, Jan Kiszka <jan.kiszka@siemens.com> wrote:
> >>
> >> On 22.06.23 10:51, Masahisa Kojima wrote:
> >>> This series introduces the tee based EFI Runtime Variable Service.
> >>>
> >>> The eMMC device is typically owned by the non-secure world(linux in
> >>> this case). There is an existing solution utilizing eMMC RPMB partition
> >>> for EFI Variables, it is implemented by interacting with
> >>> OP-TEE, StandaloneMM(as EFI Variable Service Pseudo TA), eMMC driver
> >>> and tee-supplicant. The last piece is the tee-based variable access
> >>> driver to interact with OP-TEE and StandaloneMM.
> >>>
> >>> Changelog:
> >>> v5 -> v6
> >>> - new patch #4 is added in this series, #1-#3 patches are unchanged.
> >>>   automatically update super block flag when the efivarops support
> >>>   SetVariable runtime service, so that user does not need to manually
> >>>   remount the efivarfs as RW.
> >>
> >> But that is not yet resolving the architectural problem with that
> >> userspace daemon dependency. What are the next steps for that now?
> >
> > We are trying to find some cycles to work on that, however, I don't
> > have a time estimate on that.  But the question is different here.
> > Since this addresses the problems distros have wrt to SetVariableRT
> > (even for a limited set of platforms) are we ok pulling this in?  I
> > can't think of a technical reason we shouldn't.  The supplicant
> > limitations are known and the firrmwareTPM has a similar set of
> > problems.
>
> It will not change we have to do on the distro side because we have to
> deal not only with the startup issue and StMM but also with fTPM and
> with shutdown. Only an in-kernel supplicant for RPMB would resolve that
> according to my understanding.
>

Exactly and it's worth noting that even that will come with some minor
limitations.  E.g the randomseed variables set by the efistub currently
won't be supported as the modules will come alive way later.  But it's all
reasonable compromises for hardware that wasn't designed to have a
dedicated storage in the secure world and support runtime variables sanely.

> But the question is fair if we can evolve from this stage here to an
> in-kernel approach without causing breakages or other headache to
> distros adopting it (too early). That's why I asked for the roadmap.

Exactly and this is my point as well.  I can't see a technical difference
other than 'you won't need to launch the supplicant'.  The only thing we
need to keep in mind is introduce the fallback between the supplicant and
the (future) kernel supplicant gracefully.  People might still need to run
the supplicant for other reasons.  But if we design it with the kernel
module taking precedence over the supplicant we should be fine.

So since we lived with it a for a few years, I suggest we let it soak a bit
and get tested while we try to move the supplicant bits needed over to the
kernel. In the meantime patch #4 needs some adjustments, so I'll rethink
the supplicant vs kernel module scenario in case I missed something.

Thanks
/Ilias

>
> Jan
>
> --
> Siemens AG, Technology
> Competence Center Embedded Linux
>

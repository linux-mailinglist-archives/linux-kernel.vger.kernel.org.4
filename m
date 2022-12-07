Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18A264572A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 11:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLGKIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 05:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiLGKIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 05:08:43 -0500
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BFF29C92
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 02:08:40 -0800 (PST)
X-KPN-MessageId: 1c8b243d-7617-11ed-97dd-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 1c8b243d-7617-11ed-97dd-005056abad63;
        Wed, 07 Dec 2022 11:08:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:from:to:subject:mime-version:date:message-id;
        bh=dcZxkIgsXiP5No5awWGbrW9LWMFxyRSZX9pAr84k0FE=;
        b=t5Qp8bjpGxZJ53ZfMt92QufNUYG4xEimUjFuo9EGRplD32Pre2FnLnS7G0ADg5EqgGqSVdr1FMb97
         bv0Gb/ZD/hFjcfQFShY/RMeGd+Mj1bMnlI2fA6zVVKhmoBjl2zGw3jnWzX6Xrmi0tNYqEKsz1IO2hd
         09v7sbG1fDlWz8M2rBPoBQD+v4b0BuPMXpuE1fCm2TA/ziZUmJxjp+R6Wj+1snKZ5Hqk77L5wiqG1P
         SuMxrGteyUQEg+h+E9JhFTXJlPP3HvM8ArcbOb9UWOD/HyxMARAkZB2Q3jd5AMCPHjXPMfRzbYumFj
         2xYvEvxs6GOokuMPt5JcbPhvQCZWk9w==
X-KPN-MID: 33|llIboo3TtsDibD9OxK1HzEi9yIkyLaEr7GrgY/49E3cXBxO7c7YxhbEDQgKCtda
 quGRuSD35Axk/MVYC7USB3cTnJ0jy2Obzff0tqYF5qnI=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|+Pwbvb1VhlDEvO4WDfeBZAayJMnYDnnD8FzZXJgK8a8nuvs2vuGLVoGqn8Bqlhf
 8I9GkWNkbtdIKSOON4x9rhA==
X-Originating-IP: 173.38.220.42
Received: from [10.47.77.219] (unknown [173.38.220.42])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id 1da16f9e-7617-11ed-927c-005056ab7584;
        Wed, 07 Dec 2022 11:08:38 +0100 (CET)
Message-ID: <e250c025-65c4-1760-bcfe-7efb116b5c9d@xs4all.nl>
Date:   Wed, 7 Dec 2022 11:08:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: linux-next: Signed-off-by missing for commit in the v4l-dvb-next
 tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221207075657.39b5552c@canb.auug.org.au>
Content-Language: en-US
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20221207075657.39b5552c@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/22 21:56, Stephen Rothwell wrote:
> Hi all,
> 
> Commits
> 
>   85abf40b56af ("media: ipu3-cio2: make the bridge depend on i2c")
>   ca61babacbe8 ("media: MAINTAINERS: Add Hans de Goede as staging/atomisp maintainer")
> 
> are missing a Signed-off-by from their committer.
> 

They have a SoB, but there is a 'Link:' tag right before that:

commit 85abf40b56af5f3130a4f9dcdb808c7feb64e083
Author: Adam Borowski <kilobyte@angband.pl>
Date:   Fri Sep 16 00:33:18 2022 +0100

    media: ipu3-cio2: make the bridge depend on i2c

    drivers/media/pci/intel/ipu3/cio2-bridge.c: In function ‘cio2_bridge_unregister_sensors’:
    drivers/media/pci/intel/ipu3/cio2-bridge.c:258:17: error: implicit declaration of function ‘i2c_unregister_device’; did you mean ‘spi_unregister_device’? [-Werror=implicit-function-declaration]
      258 |                 i2c_unregister_device(sensor->vcm_i2c_client);
          |                 ^~~~~~~~~~~~~~~~~~~~~
          |                 spi_unregister_device

    Link: https://lore.kernel.org/linux-media/S230142AbiJTWql/20221020224641Z+958@vger.kernel.org
    Signed-off-by: Adam Borowski <kilobyte@angband.pl>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

commit ca61babacbe8ada7a0671f910c22b8758f481c0c
Author: Hans de Goede <hdegoede@redhat.com>
Date:   Wed Nov 23 16:14:47 2022 +0000

    media: MAINTAINERS: Add Hans de Goede as staging/atomisp maintainer

    Add myself as maintainer for the drivers/staging/media/atomisp code.

    Link: https://lore.kernel.org/linux-media/20221123161447.15834-1-hdegoede@redhat.com
    Signed-off-by: Hans de Goede <hdegoede@redhat.com>
    Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
    Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Could that be the cause? checkpatch doesn't complain about this.

Regards,

	Hans

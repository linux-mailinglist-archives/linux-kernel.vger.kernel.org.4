Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5216C0007
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 09:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbjCSI2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 04:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjCSI2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 04:28:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7816C14B
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 01:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1DF6BB80ABE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE73C4339E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 08:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679214505;
        bh=fZ6XoNISYIT6yg304yM11lHKvXoxE5fP1aialrWSmvg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ARyancN5Q2f68o2J7emRdamkDkV4RK7NovUHETM5O0ri2w6ufFNJaqt5h9YvavR0m
         WOfOuNM2FyLaRbIwxptKlsWFt6bRaVckXBzxnGlrvdFBiFGx1ijgM8HzA4ankCRvk2
         N99RJAAwEBpfTL6PL0dWU6tycGcBuI/Wp12fRguJcWZeka5PQi4B4GfY/XbOKYvL6p
         hJc+2w1qkieR8kPpXnezcZI1gA5iD8SgyMEBTV6GYtqYNbJDOPYmx22IRu8IHCKVCE
         L0pxdHnXhj4nFbVNdjseL1Hb19h+n+elIo5Rg2GxKzj3jOOE2H7on5DVV2qTkb/Eqi
         NWywuZdOih+eg==
Received: by mail-yb1-f181.google.com with SMTP id y5so9791554ybu.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 01:28:25 -0700 (PDT)
X-Gm-Message-State: AO0yUKWjsy7ri6pe7e2uAEDKfCiaPeIJnlpJgXr+5u9Kyq2R+ugnEQbA
        6xkcWLBZBLKYRpPl+iOXyAs6qw9lepnpP+bERPM=
X-Google-Smtp-Source: AK7set+JKtbAD/Anf5+ED4jF0G35zJiqQm0MoN2pOx8irOFBOsqdLL0Z/bBLl43Q4o3uUSeJ6WDaneGRNbhrbOibGSg=
X-Received: by 2002:a05:6902:1105:b0:b2f:bdc9:2cdc with SMTP id
 o5-20020a056902110500b00b2fbdc92cdcmr3097169ybu.7.1679214504826; Sun, 19 Mar
 2023 01:28:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230307043525.25660-1-bagasdotme@gmail.com> <babfe305-04cd-7213-8e1e-8fbcb2da10ae@quicinc.com>
In-Reply-To: <babfe305-04cd-7213-8e1e-8fbcb2da10ae@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Sun, 19 Mar 2023 10:27:58 +0200
X-Gmail-Original-Message-ID: <CAFCwf10_uqp=LGDUqu9SUyHmrvKNHbniUD8XfNj7KtPFax-BPw@mail.gmail.com>
Message-ID: <CAFCwf10_uqp=LGDUqu9SUyHmrvKNHbniUD8XfNj7KtPFax-BPw@mail.gmail.com>
Subject: Re: [PATCH] accel: Link to compute accelerator subsystem intro
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Melissa Wen <mwen@igalia.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Airlie <airlied@redhat.com>, Dylan Le <self@dylanle.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 6:04=E2=80=AFPM Jeffrey Hugo <quic_jhugo@quicinc.com=
> wrote:
>
> On 3/6/2023 9:35 PM, Bagas Sanjaya wrote:
> > Commit 2c204f3d53218d ("accel: add dedicated minor for accelerator
> > devices") adds link to accelerator nodes section of DRM internals doc
> > (Documentation/gpu/drm-internals.rst), but the target doesn't exist.
> > Instead, there is only an introduction doc for computer accelerator
> > subsytem.
> >
> > Link to that doc until there is documentation of accelerator internals.
> >
> > Fixes: 2c204f3d53218d ("accel: add dedicated minor for accelerator devi=
ces")
> > Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Thanks.
Will upstream through my tree (habanalabs-next)
Oded

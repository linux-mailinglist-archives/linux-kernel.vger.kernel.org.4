Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35F067146D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 07:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjARGks (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 01:40:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbjARG00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 01:26:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA23F5AA4F
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7121461671
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD210C433F0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674022553;
        bh=xAwPgAk3uvmqnBOgCnj/zIwcntbxU1M7GzwDPVEI9Io=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XxhkJkoF1KKNhXaM5ZPvV37uImU1ovykdn+7DkdyoBO3GBdfJhctQ1mwiBb/WwulS
         Sy99rzAUY6UvaJrn8fkdoNoepofV7/8QifGdPm5iSlDg5OPUNx9o+Czb7ERaVfbytn
         9Q4u4nWFYr7chU/tGRtx9oIql+Isp+ThM06X6xoBYmLzhkBcQekUgmkhaxURyEG/uY
         iydd7qmoRm8rJCbaxidElB/a1joD3mLtU6hAeLA0nInJIRB4r+7JMbWTmcDdy41Dcx
         5gKZBST2fQPcuZQR3NsoKNe2Q0KVL6U0k+W54uxgN0nHVCUacjxDk0JEHMMoKG+r9L
         ReWBuYo9o2mtA==
Received: by mail-yb1-f171.google.com with SMTP id 203so36919334yby.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 22:15:53 -0800 (PST)
X-Gm-Message-State: AFqh2kqtV74HYgjvl3E8RpjEiFXG+0ZaM4Q+jJyaY99miEYfnMdC1FdI
        bQiILrIC0ZdUuT8yHTiFO+f3+B+ntJN4BuUTUkk=
X-Google-Smtp-Source: AMrXdXt8KdQLPinhpBGYHp9Tcz1YySs/rR98VHNcNtzs1UXQGh6QyGMHvZFywNdOZi7ZwW/GeD5grHDpXTegtYzcd8U=
X-Received: by 2002:a25:d06:0:b0:799:3955:201f with SMTP id
 6-20020a250d06000000b007993955201fmr732112ybn.94.1674022552856; Tue, 17 Jan
 2023 22:15:52 -0800 (PST)
MIME-Version: 1.0
References: <1673978670-10110-1-git-send-email-quic_jhugo@quicinc.com>
In-Reply-To: <1673978670-10110-1-git-send-email-quic_jhugo@quicinc.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Wed, 18 Jan 2023 08:15:26 +0200
X-Gmail-Original-Message-ID: <CAFCwf12U-g1Z8w-AwgaBHUsUPPtwOWjSJBzpE+LgzGkoCx-ZBg@mail.gmail.com>
Message-ID: <CAFCwf12U-g1Z8w-AwgaBHUsUPPtwOWjSJBzpE+LgzGkoCx-ZBg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS/ACCEL: Add include/drm/drm_accel.h to the
 accel entry
To:     Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, 2023 at 8:10 PM Jeffrey Hugo <quic_jhugo@quicinc.com> wrote:
>
> get_maintainer.pl does not suggest Oded Gabbay, the DRM COMPUTE
> ACCELERATORS DRIVERS AND FRAMEWORK maintainer for changes that touch
> the Accel Subsystem header - drm_accel.h.  This is because that file is
> missing from the Accel Subsystem entry.  Fix this.
>
> Signed-off-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 31ffd4b..7995ec7 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6754,6 +6754,7 @@ C:        irc://irc.oftc.net/dri-devel
>  T:     git https://git.kernel.org/pub/scm/linux/kernel/git/ogabbay/accel.git
>  F:     Documentation/accel/
>  F:     drivers/accel/
> +F:     include/drm/drm_accel.h
>
>  DRM DRIVERS FOR ALLWINNER A10
>  M:     Maxime Ripard <mripard@kernel.org>
> --
> 2.7.4
>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
I'll merge it through my tree.
Thanks,
Oded.

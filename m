Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB726369C9
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 20:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239725AbiKWTTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 14:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238966AbiKWTTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 14:19:36 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5480CE3B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:19:35 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id a19so4170793uan.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 11:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwMzuEDw937D1BNWUA0+s7FH/Sv/GWnLAgn8jMy5G/0=;
        b=g/nn420R1OojaK+ZrP5yWqCPRWhqBR3yJ1bGeZnSy5rk1jJk4NsK6VjXpTG+jsegam
         dBm2h9744Pvni4Tx3Vg54pqwd9DZjb1z22H0MRPKB+9jQeP56FN28EFvVyFJz2E5LBJ9
         oImZsEE9BVhSfGNwgLNk2FshAC5d0BF1yGL9i7WxmEAZHKb39SwzeGlFMlYz+KbBSU/1
         OBcH6y45lXdKxud/yud4DKrczBhWp7gVspfwxvN5+bANrEhxzl32kMonJcRnomPu/vRA
         fHY4Ktf8hzgF8/QRtPHetAsVza0ZL9CslbOCwPxxHRp9lsOejr9Lr8cvglm0ml7YP14v
         LTmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwMzuEDw937D1BNWUA0+s7FH/Sv/GWnLAgn8jMy5G/0=;
        b=S8B1fPMfKoOp1MbfERH40q6FOjmsqqmpWrAkeYFy2BGbooCHC8o//fy4OcGhg/yzzx
         +/LYA3FVq3LIc9KLply3D9VJ1/PyTpkSd2ceGHFPG6mSEYkc3BKC8sMpGrfCdRdKVyLi
         jfcjfPweoM9ibTQAxg5HqrqKiII+zXdnxgDl+cQweRiTIYI3XxIWy2GKgYd7hkBAtpnL
         j+cYK3+Ge3AWDzBl6EmmnQVfe3o4BVe1GSMMglcc/YGd3rdml4q/8GV5WwC/Us/VoksH
         c0XwXNcT/nQmCMRtB6cA4BJIbCSadQ5PNVDZVRYRToj6CFimbbvhfjE8HALH8xCa1f0u
         3ejQ==
X-Gm-Message-State: ANoB5pkpzj0Y9eQ37WMjUHtfb+ZQN+nb2TcwNFJp+OA1mAxCz+K3OJEg
        3gAuObBnT2mqKd/g3bdT20rn02aptsGxoQMxHEsc
X-Google-Smtp-Source: AA0mqf7ymL6DaildKXguHmgnNFyFiHrXAqeOVxwz1oN82oZWA+QVsylDv6FEwr3OYMAtZxhB6iEMFSrnXPfn7MTN3I8=
X-Received: by 2002:ab0:4986:0:b0:414:4bb5:3e54 with SMTP id
 e6-20020ab04986000000b004144bb53e54mr6742748uad.121.1669231174806; Wed, 23
 Nov 2022 11:19:34 -0800 (PST)
MIME-Version: 1.0
References: <TYCP286MB2323873BBDF88020781FB986CA3B9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <TYCP286MB2323894F9939C27291FD998CCA0A9@TYCP286MB2323.JPNP286.PROD.OUTLOOK.COM>
 <56393e84-485b-42ba-5fce-d4a0d0017653@amd.com>
In-Reply-To: <56393e84-485b-42ba-5fce-d4a0d0017653@amd.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 23 Nov 2022 11:19:24 -0800
Message-ID: <CANDhNCrKaa580Hb-w5GcGxo-h5xr9_GSq86JUSfR+meVLqiY1g@mail.gmail.com>
Subject: Re: [PATCH v4] dma-buf: fix racing conflict of dma_heap_add()
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Dawei Li <set_pte_at@outlook.com>, sumit.semwal@linaro.org,
        benjamin.gaignard@collabora.com, labbott@redhat.com,
        Brian.Starkey@arm.com, afd@ti.com, sspatil@android.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:24 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Hi Dawei,
>
> from the technical description, coding style etc.. it looks clean to me,
> but I'm the completely wrong person to ask for a background check.
>
> I have a high level understanding of how dma-heaps work, but not a
> single line of this code is from me.
>
> Feel free to add my Acked-by, but Laura, John and others do you have any
> opinion?

No objection from me.
Thanks Dawei for submitting this improvement!

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

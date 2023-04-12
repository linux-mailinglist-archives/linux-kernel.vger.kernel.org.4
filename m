Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6066DEB71
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 07:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjDLFwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 01:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDLFwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 01:52:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0217B1FEA;
        Tue, 11 Apr 2023 22:52:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PxBg814h6z4xDn;
        Wed, 12 Apr 2023 15:52:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1681278724;
        bh=jqtJJylomYzYVkCC66q6zDwuo6aVxIv4ryKs0Q31Tkw=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=frI2z76QxUdVGt9vzxq4XlF8uIotArtGilXmy4Yiw8TO9qGru44k0P9sUscx6dYta
         6bw/iiIXrmh7BO+CxEEmfkdPJFXeMQmvDVeWGzfNcuM1LNApk5hChKNhblcZ4Potc8
         DwUdvWd0xL/zjaJhYelrU1Q2HcuCtDYwXyyn7VK2Po1+ybtVBHy58g0maVIKFYhTY9
         IQZBAnSE9vDm4/nGjVFO+W3+sF8IEdupCmqw9SMyGlmO6PGIQmjqJrncKfqDZE/4F3
         miVoHKYSz0H1/39qk1WWoYYJwFt6CqbTC10JJqwJXxGl7HfF8vpCvMrNbd5Vb8kxHT
         IwP/U1veucJHQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@redhat.com>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm tree with the powerpc tree
In-Reply-To: <20230412112213.59365041@canb.auug.org.au>
References: <20230412112213.59365041@canb.auug.org.au>
Date:   Wed, 12 Apr 2023 15:51:57 +1000
Message-ID: <87ttxlir5u.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's linux-next merge of the drm tree got a conflict in:
>
>   drivers/gpu/drm/amd/display/Kconfig
>
> between commit:
>
>   78f0929884d4 ("powerpc/64: Always build with 128-bit long double")
>
> from the powerpc tree and commit:
>
>   4652ae7a51b7 ("drm/amd/display: Rename DCN config to FP")
>
> from the drm tree.

> I fixed it up (I used the powerpc version - with "(PPC64 && ALTIVEC)")
> and can carry the fix as necessary.

Thanks, that's the right resolution.

Not much we can do to avoid that conflict, we'll just have to tell Linus
about it at pull request time.

cheers

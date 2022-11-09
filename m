Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81A462355D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 22:04:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbiKIVEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 16:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiKIVED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 16:04:03 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670BF18392;
        Wed,  9 Nov 2022 13:04:02 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 06D44740;
        Wed,  9 Nov 2022 21:04:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 06D44740
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1668027842; bh=bgviE9aE9WNQ0wB7voneVvsBm89jpDB2NeI0Kh668PQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Ts2d+wt26q9s/bK3t2Y2qKcIHIDROXqWkRHg0WNdduxP1z9R++WDT43FyCWmIFgD+
         0GrMHluJ61KXvgUkSsgsny2up4KnNDQUK8KcsW74gdhHwnH22TM8M3JqSvW7DnsmPn
         QG3VPM5i8h8ToYIH7Y/fCt1FhiBkQxEGjtMOHV0244A1FsjKjixvRN7sFLDXE5ILy7
         Tm9K9OvsqCKyTlh/zBCVH4XuBtaKkNVi11vkZVqKUMs2O1i8cQlt4/APOhRgAPMOHF
         BEV4GwADgbYm/xiMIQrykLH4kR2dgv6dJ1N1iweMGHhFYaNN5Gv/a1N56GGi4OjC0q
         lpdX9thA0P8Qg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-doc@vger.kernel.org
Cc:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: ia64: Fix a typo ("identify mappings")
In-Reply-To: <20221101160609.961950-1-j.neuschaefer@gmx.net>
References: <20221101160609.961950-1-j.neuschaefer@gmx.net>
Date:   Wed, 09 Nov 2022 14:04:01 -0700
Message-ID: <87leojj0vy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> The correct term here, also used in the next line, is "identity
> mappings". "itentify mappings" was probably just a typo.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---
>  Documentation/ia64/aliasing.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/ia64/aliasing.rst b/Documentation/ia64/aliasin=
g.rst
> index a08b36aba0159..36a1e1d4842b8 100644
> --- a/Documentation/ia64/aliasing.rst
> +++ b/Documentation/ia64/aliasing.rst
> @@ -61,7 +61,7 @@ Memory Map
>      The efi_memmap table is preserved unmodified because the original
>      boot-time information is required for kexec.
>
> -Kernel Identify Mappings
> +Kernel Identity Mappings
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Applied, thanks.

jon

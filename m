Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154D163955D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 11:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiKZKdV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 05:33:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiKZKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 05:33:18 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACF802655F;
        Sat, 26 Nov 2022 02:33:16 -0800 (PST)
Received: from sopl295.home (unknown [IPv6:2a01:cb19:8d70:d500:b9f9:2ddd:cb4c:4b34])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id A135419F58D;
        Sat, 26 Nov 2022 11:33:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1669458795;
        bh=trAIjXQgfCOT8mzOtZdvR3zVgqjE7H8j/IocuQbKRJk=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=Bnu/qzCNRGjdyWnC0iBqjA+c8e8NRppn+0rODqBXa2M2Gr8Y7agMcXlgWyjTkc+ex
         gteir53YVC5gzVR8YC17uG8PWG1FpHGCiJq8+s2or81HuHV9wgKA/IxQ5NrSFVMxo+
         hVgCSo6Dq6UL78B1Zh7zjJLx3OPjM/2CtwpTaUu4K3UNN+AhtBNBzjLeYEO1JZUmZH
         D2ew+zCMsJLNAFm9DzW/MKOCi+fw4029mLo/a9mWhVVKZIDnH+9Oi9rc5UvMo0LTAT
         SzgeQbF0m+ke44EnqcPBrGayckNYxNOQPGz3dkPqfJpv92LyDW0hJzGY4/O7unURW7
         Y6vf4PX4prX0Q==
References: <20221124100112.4172513-1-j.neuschaefer@gmx.net>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: pxa2xx: Don't mention &pwri2c where it
 doesn't exist
Date:   Sat, 26 Nov 2022 11:32:07 +0100
In-reply-to: <20221124100112.4172513-1-j.neuschaefer@gmx.net>
Message-ID: <m2a64ef1jz.fsf@sopl295.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net> writes:

> The pwri2c node does not exist in all PXA2xx SoCs (specifically=20
> not
> in PXA25x), and thus isn't defined in pxa2xx.dtsi. It is,=20
> however,
> currently mentioned in /aliases, causing an error when building=20
> a
> devicetree that doesn't define it.
>
> Move the mention of &pwri2c in /aliases to the files that define=20
> it
> (pxa27x.dtsi and pxa3xx.dtsi), to avoid the error mentioned=20
> above.
>
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert

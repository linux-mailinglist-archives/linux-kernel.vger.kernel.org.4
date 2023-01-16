Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09E4D66C423
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjAPPlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:41:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjAPPkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:40:47 -0500
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF3EA262;
        Mon, 16 Jan 2023 07:40:44 -0800 (PST)
Date:   Mon, 16 Jan 2023 15:40:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail; t=1673883642; x=1674142842;
        bh=hMNV5Q9auz+Z6acJq71QxOGvPxX4ImxbwQzC4E0AbgQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sscnZ5efTfSAVNeNKWUeE1is2n/3P5oD3G+PoCtR1sDcIqV48NZNheA+tvWANEMzn
         QQnu9O9Csq22VlTBKOhSjUVMn3oFkfYF4+3yo2GEYPzGvKLW+of5bNM7q4TEM5wNYa
         zIfCwpFT2qBQ816PBBbqqP0Gk5uuxDMQghwecURaxXGRIGp2CE5F1pwG+lmSpTfjKR
         yH2V/GVXXbEMbdBI3EvUyxV73nQmMEkkEY73iFLepyUHIRV8CZWDW4LbGAICAn3KdA
         eHeaRXPs+8h+ysLb0bGPnic2loSkMtWWyndqJoUaqN+jAUEO1qmw0AhAV4nVwLyLvn
         qkJFdBF7xYqww==
To:     Conor Dooley <conor.dooley@microchip.com>
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: x86 - exit fpu context earlier in ECB/CBC macros
Message-ID: <dmhKJenSmPJOEexgrs2dFRol14c34HKqMXwGjS-CXVJKZ2hCmR5yN1BG8osscOQvgJaR0wx2AOenX5Zkq34TPpf1BJ9a6zB7ZN79N51wOTI=@n8pjl.ca>
In-Reply-To: <Y8VuB7kmn9dQ8/en@wendy>
References: <IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1HaoPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=@n8pjl.ca> <CAMj1kXGjOF7bNCS-v02aTZWmzvM-Ad-VYiNbHEmYf5RMHL57bQ@mail.gmail.com> <T7YG602WaDuPk4rYB6-BwCn0pdxSTJxyOR7-vs59gUu1sXMFtkbjCUd1DZ9xuFy9724II9A1qQWf0hKsLJ04qawtcrfO90FA5eYn5hyLzvw=@n8pjl.ca> <Y8VuB7kmn9dQ8/en@wendy>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > My apologies. I was having difficulties configuring git send-email,
> > but now I believe that I have the issues resolved. Future patches will
> > be properly formatted.
>=20
>=20
> It landed okay on lore:
> https://lore.kernel.org/linux-crypto/IBooTlGWpNE7pOelt0gm21bxW7wBILNYJ1Ha=
oPbbfdEEMwz0Pp92vpd_OUlhNFNAitFThTi27P6q6NvcYMKm-y7tjwiF9YbImWjhgC3UDMk=3D@=
n8pjl.ca/#t

Yup, that's why I'm not resending it.

>=20
> I've seen enough of these now to know where this is going, I'd bet that
> you're a protonmail user...

You would be quite correct. They do like making your life difficult when
it comes to using smtp.

Anyway, the patch landed fine on lore and patchwork and I've (finally)
configured git-send-email properly, so I think that this should be all=20
good now.

Again, sorry for the issues,
Peter Lafreniere

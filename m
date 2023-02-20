Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2145769C3C3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 01:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjBTAzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 19:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjBTAzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 19:55:37 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B92C662;
        Sun, 19 Feb 2023 16:55:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PKkVZ0LWxz4x7y;
        Mon, 20 Feb 2023 11:55:34 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1676854534;
        bh=wxqOjIm9/rnhk0pS41BKLly/M/tr+p6ZjiKfnuxgXX4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=hASHGpraEGVm1pbs2YxrgdCHJmBkRxLZE04kXhblwxeU26unJMQrUr/wTLRkDiQE3
         ar48nDqIlr11/lMClSplUY99AYwMfD8ND/tvgG3+NZepWy7kFQKDt0Et7dM5rhHdbx
         jh1b4myf3hFibcDyVRnP/eR5fufZoq+lsuCW5Q8wZhnBKtsO1WD2GmZAgDwgs39pY8
         BnEXJeDHbIZFiZDOS5kHsVBEbqVGeSGud76Zz4k22VzoSxAdeySkCtpcP8xgWK4Muq
         k6bp51hxRQDLFGfNq4rqLY30bSnr/IaUreM57mVtEaIlA9chO0wlfGw8jDd5LVUuJ6
         PJPEnRt1CCtEg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 3/3] powerpc: dts: turris1x.dts: Set lower priority
 for CPLD syscon-reboot
In-Reply-To: <20230218120525.7zplk5zdg5qmkmaz@pali>
References: <20220820102925.29476-1-pali@kernel.org>
 <20221226114513.4569-1-pali@kernel.org>
 <20221226114513.4569-3-pali@kernel.org>
 <20230209001021.oitnv6x7ilwvy4it@pali>
 <20230218120525.7zplk5zdg5qmkmaz@pali>
Date:   Mon, 20 Feb 2023 11:55:33 +1100
Message-ID: <878rgtyx2y.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pali Roh=C3=A1r <pali@kernel.org> writes:
> On Thursday 09 February 2023 01:10:21 Pali Roh=C3=A1r wrote:
>> On Monday 26 December 2022 12:45:13 Pali Roh=C3=A1r wrote:
>> > Due to CPLD firmware bugs, set CPLD syscon-reboot priority level to 64
>> > (between rstcr and watchdog) to ensure that rstcr's global-utilities r=
eset
>> > method which is preferred stay as default one, and to ensure that CPLD
>> > syscon-reboot is more preferred than watchdog reset method.
>> >=20
>> > Fixes: 0531a4abd1c6 ("powerpc: dts: turris1x.dts: Add CPLD reboot node=
")
>> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
>>=20
>> May I ask who can take this 3/3 patch? powersupply or powerpc tree?

I assume the fact that Sebastian applied patches 1 & 2 means he didn't
want to take this one.

So the best way to get it applied by me is to send a new version with
just patch 3, with the changelog explaining that commit xxxyyy
implements the property and this patch is just wiring it up.

cheers

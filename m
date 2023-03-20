Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EFCC6C0C45
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 09:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjCTIcG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 04:32:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjCTIcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 04:32:05 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F3D15141
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 01:31:54 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 6FE3B5FD0A;
        Mon, 20 Mar 2023 11:31:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679301111;
        bh=nCjWaZrZpveRJdJhStKp788sVaok0j0QE/XqyN78228=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=RyU+MUJ9Lc8lrCzACtmLWzV+hCAXUxm6kEskUIkw1eqVeusbNiZrNULwv9EpSsJOp
         j3MwKQidCiyGanpUBTTt+pCBs455WSFV9Ai0Axre9jdb8mlw0dGfLy7fvKKLFfgW9O
         xnCAKdm+bc4RuRxd9HqqtdmElaCOEXx3DPh1+aHO3z4jqAiGQsKyZKTy9P5HEMc8CC
         7DchiC6MbyB2A1C6S9CHqU1jdF/tQ1VliqxnpaVzVaRjcDCgzUuVpd0bwQkan5vQ0F
         8/6AVkL53mWejXzFMBFpmYfPnpLClEsC/ts5F5nTsi0qrstLcdhll2IULkbBTRRthc
         faAqilZ9Npn7A==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 20 Mar 2023 11:31:50 +0300 (MSK)
Date:   Mon, 20 Mar 2023 11:31:49 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Joe Perches <joe@perches.com>
CC:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <apw@canonical.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <kernel@sberdevices.ru>,
        <linux-kernel@vger.kernel.org>, <rockosov@gmail.com>
Subject: Re: [PATCH v1] checkpatch: add missing bindings license check
Message-ID: <20230320083149.3adlrk7cpyec6gde@CAB-WSD-L081021>
References: <20230317201621.15518-1-ddrokosov@sberdevices.ru>
 <8dcc23061db363d894a5c8219076cd41f99163c1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8dcc23061db363d894a5c8219076cd41f99163c1.camel@perches.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/20 04:57:00 #20976224
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

Thank you for quick review. Please find my comments below.

On Fri, Mar 17, 2023 at 03:28:16PM -0700, Joe Perches wrote:
> On Fri, 2023-03-17 at 23:16 +0300, Dmitry Rokosov wrote:
> > All headers from 'include/dt-bindings/' must be verified by checkpatch
> > together with Documentation bindings, because all of them are part of
> > the whole DT bindings system.
> > 
> > The requirement is dual licensed and matching string:
> >     'GPL-2.0-only OR BSD-2-Clause'
> > 
> > The issue was found during patch review:
> > https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> >  scripts/checkpatch.pl | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3709,7 +3709,8 @@ sub process {
> >  						WARN("SPDX_LICENSE_TAG",
> >  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
> >  					}
> > -					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> > +					if (($realfile =~ m@^Documentation/devicetree/bindings/@ ||
> > +					    $realfile =~ m@^include/dt-bindings/@) &&
> 
> I prefer aligning to open parens
> 
> >  					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {

Okay, no problem, will send new version today.
> 
> And if it's really a strict bit about the required license,
> why not make it match exactly?
> 
>  					    $spdx_license !~ /GPL-2\.0(?:-only|-or-later|\+)? OR BSD-2-Clause/) {
> 

I think, it's a good idea.

> >  						my $msg_level = \&WARN;
> >  						$msg_level = \&CHK if ($file);
> 
> $ git grep -oh 'SPDX-License.*$' -- Documentation/devicetree/bindings/ include/dt-bindings/ | \
>   sort | uniq -c | sort -rn
>    1597 SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>     611 SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>     540 SPDX-License-Identifier: GPL-2.0
>     355 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>     285 SPDX-License-Identifier: GPL-2.0 */
>     179 SPDX-License-Identifier: GPL-2.0-only */
>     102 SPDX-License-Identifier: GPL-2.0-only
>      93 SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
>      56 SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
>      47 SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>      36 SPDX-License-Identifier: GPL-2.0+ */
>      34 SPDX-License-Identifier: GPL-2.0-or-later */
>      33 SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
>      28 SPDX-License-Identifier: GPL-2.0+
>      21 SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>      19 SPDX-License-Identifier: (GPL-2.0+ or MIT) */
>      17 SPDX-License-Identifier: (GPL-2.0 OR MIT) */
>      12 SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
>      11 SPDX-License-Identifier: (GPL-2.0+ OR MIT) */
>       9 SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
>       8 SPDX-License-Identifier: GPL-2.0 OR MIT */
>       8 SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
>       7 SPDX-License-Identifier: GPL-2.0-or-later OR BSD-2-Clause
>       7 SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
>       7 SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
>       6 SPDX-License-Identifier: (GPL-2.0)
>       5 SPDX-License-Identifier: GPL-2.0+ OR MIT */
>       5 SPDX-License-Identifier: (GPL-2.0 OR MIT)
>       5 SPDX-License-Identifier: (GPL-2.0 or MIT) */
>       4 SPDX-License-Identifier: GPL-2.0-or-later
>       3 SPDX-License-Identifier: (GPL-2.0+ OR X11)
>       3 SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause) */
>       3 SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
>       3 SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
>       3 SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause) */
>       3 SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) */
>       3 SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause) */
>       2 SPDX-License-Identifier: (GPL-2.0+ or MIT)
>       2 SPDX-License-Identifier: GPL-2.0-or-later OR MIT */
>       2 SPDX-License-Identifier: (GPL-2.0-or-later OR MIT)
>       2 SPDX-License-Identifier: GPL-2.0+ OR BSD-3-Clause */
>       2 SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)*/
>       1 SPDX-License-Identifier: (GPL-2.0-or-later OR MIT) */
>       1 SPDX-License-Identifier: (GPL-2.0-or-later or MIT) */
>       1 SPDX-License-Identifier: GPL-2.0-or-later or BSD-2-Clause */
>       1 SPDX-License-Identifier: (GPL-2.0-or-later)
>       1 SPDX-License-Identifier: GPL-2.0+ or BSD-3-Clause */
>       1 SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
>       1 SPDX-License-Identifier: GPL-2.0-only or X11 */
>       1 SPDX-License-Identifier: (GPL-2.0-only OR MIT) */
>       1 SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause */
>       1 SPDX-License-Identifier: (GPL-2.0-only)
>       1 SPDX-License-Identifier: BSD-2-Clause
> 

I've noticed it too, asked Krzysztof about this situation in the below
review:

https://lore.kernel.org/all/9d176288-cd7c-7107-e180-761e372a2b6e@linaro.org/

Krzysztof mentioned, that he checked the purpose to have different
license each time manually. But by default, it should be strict.

-- 
Thank you,
Dmitry

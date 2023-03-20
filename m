Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C318A6C2196
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjCTTdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjCTTdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:33:03 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48440F5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:27:44 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id BC9905FD1C;
        Mon, 20 Mar 2023 20:28:47 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679333327;
        bh=+9A+OBPp9h/vWXiJ3aZ/vtEgB5t551UfABhAqc1sk4I=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=KIzlT7C3tUe5cHopaddRjJnl7+eQjPDqggzwkPkiOVFccXNLs0k4uMW/qXHxTeRqN
         k84vE/NVJ7bcwZ9QfGsbTprcyTgJXo5rolxtKYbiAQFq8bDLH0yFZqM88uFj0Kfrb6
         V9A88zVQigTzr7OwxCy/Xld7tGkJAd6qS7wuB3fa/LYhIbCGEi65mcUSjQvZMTPj08
         OrVee6mNkx2VS19fm0egCTB3ws57z224vv11PRXfpOj1APt0tB4XNhJzaFt5NCSvRb
         sNxVTOKSvYAL9I15VbT82F6Tc7d2HTdNeE3HTyflCUcT1huR1vCKBoXFUF4DWM3/nH
         JZYOUGlNNcqDA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Mon, 20 Mar 2023 20:28:46 +0300 (MSK)
Date:   Mon, 20 Mar 2023 20:28:45 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Joe Perches <joe@perches.com>
CC:     <krzysztof.kozlowski@linaro.org>, <robh@kernel.org>,
        <apw@canonical.com>, <dwaipayanray1@gmail.com>,
        <lukas.bulwahn@gmail.com>, <kernel@sberdevices.ru>,
        <linux-kernel@vger.kernel.org>, <rockosov@gmail.com>
Subject: Re: [PATCH v2] checkpatch: add missing bindings license check
Message-ID: <20230320172845.eaqbbrdxrafylbtn@CAB-WSD-L081021>
References: <20230320100027.27788-1-ddrokosov@sberdevices.ru>
 <cb29cc23e6b2a261eafa0a2baf6acf61e44829de.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cb29cc23e6b2a261eafa0a2baf6acf61e44829de.camel@perches.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/20 09:56:00 #20977321
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 10:12:27AM -0700, Joe Perches wrote:
> On Mon, 2023-03-20 at 13:00 +0300, Dmitry Rokosov wrote:
> > All headers from 'include/dt-bindings/' must be verified by checkpatch
> > together with Documentation bindings, because all of them are part of
> > the whole DT bindings system.
> > 
> > The requirement is dual licensed and matching pattern:
> >     /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> > 
> > The issue was found during patch review:
> > https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> > 
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> > Changes v2 since v1 at [1]:
> >     - include/dt-bindings check is aligned to open parens
> >     - introduce more strict pattern for bindings license:
> >       /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> > 
> > Links:
> >     [1] https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sberdevices.ru/
> > ---
> >  scripts/checkpatch.pl | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> OK but:
> 
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3709,8 +3709,9 @@ sub process {
> >  						WARN("SPDX_LICENSE_TAG",
> >  						     "'$spdx_license' is not supported in LICENSES/...\n" . $herecurr);
> >  					}
> > -					if ($realfile =~ m@^Documentation/devicetree/bindings/@ &&
> > -					    not $spdx_license =~ /GPL-2\.0.*BSD-2-Clause/) {
> > +					if (($realfile =~ m@^Documentation/devicetree/bindings/@ ||
> > +					     $realfile =~ m@^include/dt-bindings/@) &&
> > +					    not $spdx_license =~ /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/) {
> 
> I believe this is the only checkpatch use of
> 	not <foo> =~ <bar>
> instead of
> 	<foo> !~ <bar>
> 
> I prefer !~
> 

You are totally right. Only this place uses such strange comparing. Let
me fix it and prepare new version quickly :)

-- 
Thank you,
Dmitry

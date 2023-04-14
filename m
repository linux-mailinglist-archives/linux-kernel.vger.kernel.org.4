Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283276E226A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjDNLjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDNLjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:39:21 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278F81A4
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 04:39:18 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id BE2FD5FD22;
        Fri, 14 Apr 2023 14:39:14 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681472354;
        bh=oAmm4S4lepCFCmNjwz8gpkUJJ8vjdtIQRSsp3NHrAVs=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=U9b9iI8y6au7fQpKj8dBLvaAkuvwlxly+tTQMp3RlVkiCCSsWgcRmVGQaxs74Svim
         Gd5/phUNQR7F4GBm6EUdvW2CNT1ql150KViq8KbShco5Rr0wGc2vA93uxmNoUI5/ts
         712sM+R2PzI07WJ8gq6uuvEQTY2OigUDOM6ZYZcBh0/EB7S5FKTw1gCKXlBOEb2XRF
         FejMe+bdXW/Jx12geM4TxI5imXRFGWU8amhTotPl7c7I5wDUYQCl27UC3cPel+bxtJ
         bJWYgfEklvLXNeNeyTbxhISGGEBG7+XEXKE2NhiIhAzl8hkMTmGUH7VoMbcUpVowws
         amNFJwYRe4reA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 14 Apr 2023 14:39:13 +0300 (MSK)
Date:   Fri, 14 Apr 2023 14:39:07 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     <joe@perches.com>
CC:     <krzysztof.kozlowski@linaro.org>, <apw@canonical.com>,
        <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
        <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <rockosov@gmail.com>, <robh@kernel.org>
Subject: Re: [PATCH v5] checkpatch: introduce proper bindings license check
Message-ID: <20230414113907.xzjxp4233f35ja6t@CAB-WSD-L081021>
References: <20230404191715.7319-1-ddrokosov@sberdevices.ru>
 <CAL_Jsq+o452r9SzyT=9XPTYKu0hPkHWZWH8Og3VjKdxaGxDKRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_Jsq+o452r9SzyT=9XPTYKu0hPkHWZWH8Og3VjKdxaGxDKRA@mail.gmail.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/04/14 08:08:00 #21104846
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Joe,

On Tue, Apr 11, 2023 at 09:29:36AM -0500, Rob Herring wrote:
> On Tue, Apr 4, 2023 at 2:17 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> >
> > All headers from 'include/dt-bindings/' must be verified by checkpatch
> > together with Documentation bindings, because all of them are part of
> > the whole DT bindings system.
> >
> > The requirement is dual licensed and matching patterns:
> > * Schemas:
> >     /GPL-2\.0(?:-only)? OR BSD-2-Clause/
> > * Headers:
> >     /GPL-2\.0(?:-only)? OR \S+/
> >
> > Above patterns suggested by Rob at:
> > https://lore.kernel.org/all/CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com
> >
> > The issue was found during patch review:
> > https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> >
> > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > ---
> > Changes v5 since v4 at [4]:
> >     - only capital OR is acceptable for SPDX per Rob's suggestion
> >
> > Changes v4 since v3 at [3]:
> >     - introduce separate pattern for dt-bindings headers following Rob's
> >       suggestion
> >
> > Changes v3 since v2 at [2]:
> >     - replace 'not =~' expression with '!~' to be aligned with other
> >       checkpatch lines
> >
> > Changes v2 since v1 at [1]:
> >     - include/dt-bindings check is aligned to open parens
> >     - introduce more strict pattern for bindings license:
> >       /GPL-2\.0(?:-only|-or-later|\+)? (?:OR|or) BSD-2-Clause/
> >
> > Links:
> >     [1] https://lore.kernel.org/all/20230317201621.15518-1-ddrokosov@sberdevices.ru/
> >     [2] https://lore.kernel.org/all/20230320100027.27788-1-ddrokosov@sberdevices.ru/
> >     [3] https://lore.kernel.org/all/20230320203350.13696-1-ddrokosov@sberdevices.ru/
> >     [4] https://lore.kernel.org/all/20230331121017.14324-1-ddrokosov@sberdevices.ru/
> > ---
> >  scripts/checkpatch.pl | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> Reviewed-by: Rob Herring <robh@kernel.org>

Are you okay with this patch version? Rob is good with that, so please
advise what the next step is.

-- 
Thank you,
Dmitry

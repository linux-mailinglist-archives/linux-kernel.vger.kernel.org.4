Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBE6E266B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjDNPHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjDNPHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:07:07 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 518DEE49
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:07:00 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 132265FD0A;
        Fri, 14 Apr 2023 18:06:57 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1681484817;
        bh=bqw6ltPu+TV2zLK1w5B5OExZ8sLFZ0/tYlcX3VI/uq0=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=aKCa7/s6Pw3h9qS0qCY3qm9HkB3//Qgu55S8WgIsBt3GhitlqXmKhUEi1D6JFY/oz
         FWosvdXboHjDLaTsho0n6Mnf3YBYzEjKUZdfajbqnfsfbRukawgF8DKRB8fOqWfan/
         XGFUZbbq6iBtI+LCQqKk5LofioGbFxBgdPK9qdAUAL9GkxPgxgZ0JugxkW7WC66PlK
         yxDOA+lHvpP+HqinrMH/jCR60g5hvnpLY219wUxr/Gk/KKyGR+NyV6OmWLFj4gEH2A
         81mMXPZebGTO17vBzflGcBBidt5JSqdqmOBpQXaODexPIToJhhAGNLZvBErt+q89hk
         60el/PMQ3lPkA==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Fri, 14 Apr 2023 18:06:56 +0300 (MSK)
Date:   Fri, 14 Apr 2023 18:06:55 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <krzysztof.kozlowski@linaro.org>, <apw@canonical.com>,
        <dwaipayanray1@gmail.com>, <lukas.bulwahn@gmail.com>,
        <kernel@sberdevices.ru>, <linux-kernel@vger.kernel.org>,
        <rockosov@gmail.com>, <robh@kernel.org>
Subject: Re: [PATCH v5] checkpatch: introduce proper bindings license check
Message-ID: <20230414150655.x7mgnonrm7doyvpq@CAB-WSD-L081021>
References: <20230404191715.7319-1-ddrokosov@sberdevices.ru>
 <CAL_Jsq+o452r9SzyT=9XPTYKu0hPkHWZWH8Og3VjKdxaGxDKRA@mail.gmail.com>
 <20230414113907.xzjxp4233f35ja6t@CAB-WSD-L081021>
 <20fea31d91329f44181dc74443359494e5baeac4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20fea31d91329f44181dc74443359494e5baeac4.camel@perches.com>
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

On Fri, Apr 14, 2023 at 08:02:53AM -0700, Joe Perches wrote:
> On Fri, 2023-04-14 at 14:39 +0300, Dmitry Rokosov wrote:
> > Hello Joe,
> > 
> > On Tue, Apr 11, 2023 at 09:29:36AM -0500, Rob Herring wrote:
> > > On Tue, Apr 4, 2023 at 2:17 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> > > > 
> > > > All headers from 'include/dt-bindings/' must be verified by checkpatch
> > > > together with Documentation bindings, because all of them are part of
> > > > the whole DT bindings system.
> > > > 
> > > > The requirement is dual licensed and matching patterns:
> > > > * Schemas:
> > > >     /GPL-2\.0(?:-only)? OR BSD-2-Clause/
> > > > * Headers:
> > > >     /GPL-2\.0(?:-only)? OR \S+/
> > > > 
> > > > Above patterns suggested by Rob at:
> > > > https://lore.kernel.org/all/CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com
> > > > 
> > > > The issue was found during patch review:
> > > > https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> > > > 
> > > > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > > > ---
> > > > Changes v5 since v4 at [4]:
> > > >     - only capital OR is acceptable for SPDX per Rob's suggestion
> []
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > 
> > Are you okay with this patch version? Rob is good with that, so please
> > advise what the next step is.
> 
> Yes, I'm fine with it.  Andrew Morton can apply it at his leisure.
> 

Sure, I look forward to receiving Andrew's comments in due course.

Thanks a lot for quick feedback!

-- 
Thank you,
Dmitry

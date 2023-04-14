Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36AF96E2662
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 17:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjDNPDE convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 14 Apr 2023 11:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbjDNPDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 11:03:02 -0400
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0DE171F
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 08:03:00 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay04.hostedemail.com (Postfix) with ESMTP id AA2BE1A0334;
        Fri, 14 Apr 2023 15:02:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 90F8F60010;
        Fri, 14 Apr 2023 15:02:54 +0000 (UTC)
Message-ID: <20fea31d91329f44181dc74443359494e5baeac4.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: introduce proper bindings license check
From:   Joe Perches <joe@perches.com>
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     krzysztof.kozlowski@linaro.org, apw@canonical.com,
        dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
        kernel@sberdevices.ru, linux-kernel@vger.kernel.org,
        rockosov@gmail.com, robh@kernel.org
Date:   Fri, 14 Apr 2023 08:02:53 -0700
In-Reply-To: <20230414113907.xzjxp4233f35ja6t@CAB-WSD-L081021>
References: <20230404191715.7319-1-ddrokosov@sberdevices.ru>
         <CAL_Jsq+o452r9SzyT=9XPTYKu0hPkHWZWH8Og3VjKdxaGxDKRA@mail.gmail.com>
         <20230414113907.xzjxp4233f35ja6t@CAB-WSD-L081021>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Rspamd-Queue-Id: 90F8F60010
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout03
X-Stat-Signature: z4iesttwif9q956wqyid546gf5he3koe
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Jg29Z37Uv3bDXFMDTCGCbwtoHOtAWMFo=
X-HE-Tag: 1681484574-674280
X-HE-Meta: U2FsdGVkX1/M/EiZPSYCqwziK0C0WEBaCRNgRW7i5FxWOX9tnSeaETsdeR+oZu14diEOZFh7K5Th37/mBz6cwA==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-04-14 at 14:39 +0300, Dmitry Rokosov wrote:
> Hello Joe,
> 
> On Tue, Apr 11, 2023 at 09:29:36AM -0500, Rob Herring wrote:
> > On Tue, Apr 4, 2023 at 2:17 PM Dmitry Rokosov <ddrokosov@sberdevices.ru> wrote:
> > > 
> > > All headers from 'include/dt-bindings/' must be verified by checkpatch
> > > together with Documentation bindings, because all of them are part of
> > > the whole DT bindings system.
> > > 
> > > The requirement is dual licensed and matching patterns:
> > > * Schemas:
> > >     /GPL-2\.0(?:-only)? OR BSD-2-Clause/
> > > * Headers:
> > >     /GPL-2\.0(?:-only)? OR \S+/
> > > 
> > > Above patterns suggested by Rob at:
> > > https://lore.kernel.org/all/CAL_Jsq+-YJsBO+LuPJ=ZQ=eb-monrwzuCppvReH+af7hYZzNaQ@mail.gmail.com
> > > 
> > > The issue was found during patch review:
> > > https://lore.kernel.org/all/20230313201259.19998-4-ddrokosov@sberdevices.ru/
> > > 
> > > Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> > > ---
> > > Changes v5 since v4 at [4]:
> > >     - only capital OR is acceptable for SPDX per Rob's suggestion
[]
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> Are you okay with this patch version? Rob is good with that, so please
> advise what the next step is.

Yes, I'm fine with it.  Andrew Morton can apply it at his leisure.


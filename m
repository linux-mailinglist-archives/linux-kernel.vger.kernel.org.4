Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA36A6E2CBE
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 01:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjDNXNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 19:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNXNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 19:13:05 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC14B30D8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 16:13:04 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pnSb0-0005eK-1N;
        Sat, 15 Apr 2023 01:12:46 +0200
Date:   Sat, 15 Apr 2023 00:12:44 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        Nicolas Schichan <nschichan@freebox.fr>,
        George Kennedy <george.kennedy@oracle.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        yi zhang <yi.zhang@huawei.com>
Subject: Re: [PATCH -next v3] ubi: Fix failure attaching when vid_hdr offset
 equals to (sub)page size
Message-ID: <ZDnd7KmiRDhFuhhF@makrotopia.org>
References: <20230306013308.3884777-1-chengzhihao1@huawei.com>
 <20230324161923.1456371-1-nschichan@freebox.fr>
 <2c2c2ce9-795b-4f76-cde9-db4a4066dcc1@huawei.com>
 <20230329175421.3bd4906e@xps-13>
 <53992166.434647.1680125620704.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <53992166.434647.1680125620704.JavaMail.zimbra@nod.at>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Richard,

On Wed, Mar 29, 2023 at 11:33:40PM +0200, Richard Weinberger wrote:
> ----- Ursprüngliche Mail -----
> > Von: "Miquel Raynal" <miquel.raynal@bootlin.com>
> >> Thanks for testing.
> >> 
> >> > Tested-by: Nicolas Schichan <nschichan@freebox.fr>
> > 
> > Same here.
> > 
> > Tested-by: Miquel Raynal <miquel.raynal@bootlin.com> # v5.10, v4.19
> 
> Applied to next, PR will follow soon.

As stable linux trees are affected I wonder when this will hit
linux-stable, ie. will it be part of 5.15.108, for example?


Cheers


Daniel

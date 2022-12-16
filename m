Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2DD264E798
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiLPHKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbiLPHJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:09:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA84747FB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:07:04 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A84268BEB; Fri, 16 Dec 2022 08:06:22 +0100 (CET)
Date:   Fri, 16 Dec 2022 08:06:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Phil Chang =?utf-8?B?KOW8teS4luWLsyk=?= 
        <Phil.Chang@mediatek.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 2/4] tee: Remove vmalloc page support
Message-ID: <20221216070621.GA24832@lst.de>
References: <20221002002326.946620-1-ira.weiny@intel.com> <20221002002326.946620-3-ira.weiny@intel.com> <CAFA6WYOGT1sJLA4c_B88NaXgxv4fm-idi5QMYvXdXB0acCF3sw@mail.gmail.com> <TYZPR03MB65279558CC22F5130B710EA8FB5D9@TYZPR03MB6527.apcprd03.prod.outlook.com> <CAFA6WYMT9S1Di6DN_UXc823f0ZTkqerE1PB=oG6wmfx28vEbDg@mail.gmail.com> <CAHk-=whVyH-wSWLd=Zn4rwo+91T+qzRvfMPC2yFX98GxykOqOw@mail.gmail.com> <CAHUa44GkTLCzuSij5FbjBXFBM1CCQROtrCtHHtj70ZRi-3K7uA@mail.gmail.com> <Y5u+oOLkJs6jehik@iweiny-desk3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5u+oOLkJs6jehik@iweiny-desk3>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 04:41:04PM -0800, Ira Weiny wrote:
> Overall I feel like submitting this series again with Christoph and Al's
> comments addressed is the best way forward to get rid of kmap_to_page().  I
> would really like to get moving on that to avoid any further issues with the
> kmap conversions.

Yes.  While the flag is really odd, killing kmap_to_page should be the
priority.


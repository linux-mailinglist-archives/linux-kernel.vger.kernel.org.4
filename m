Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D848628768
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237668AbiKNRrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:47:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237435AbiKNRrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:47:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905DB7EC;
        Mon, 14 Nov 2022 09:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uC2or5Vi29/ILL+10ZunUsXoSK2kh2fnZB6/reHnjHU=; b=eixZyTc84zaknlvIhRid19qxBv
        1ErWk6J1F6A5nX9R3Gq1xqT3S452frgG5qvxXsSeOBb29oqb9giLYMGzwt1BQiyS0zLW8CBJ7T3Wc
        IcuCuIc/FUMLYb5ikR7pyoIP9rkKawUPtzIzfCDacq+J+jMM1+wacfwbd1QwvRM/61TvXCaAWpUY2
        802jFBXCWyQxTSBSpyQuqQcDQQNhh42Yc+zOMrBbx+8eYqwpHEuzS/O1Fb0+YRpeN3zmynbe1CdgV
        NTwTsYp8ECm3e504wlVNbiwLg5+K5+fFBAzx66zNmw6bTGiSwXvIKETxqE8S+/7/MdvalhTVu1d8G
        ZM9LI9Mg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oudYH-00FcPV-4x; Mon, 14 Nov 2022 17:47:21 +0000
Date:   Mon, 14 Nov 2022 17:47:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, Kevin Cernekee <cernekee@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1 1/4] list: Introduce list_count() to count existing
 nodes
Message-ID: <Y3J/KUBu3adGPiwT@casper.infradead.org>
References: <20221114112842.38565-1-andriy.shevchenko@linux.intel.com>
 <202211142350.i0ngTfIl-lkp@intel.com>
 <Y3JmtNExJulq2CEE@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3JmtNExJulq2CEE@smile.fi.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 06:03:00PM +0200, Andy Shevchenko wrote:
> Oh, nice! I will fix this for v2.

list_count() is an antipattern.  I don't have any of the patches in
my inbox, so maybe there's a great reason for doing this, but my
immediate response is: NAK.

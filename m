Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D103962A409
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiKOVZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 16:25:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiKOVZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 16:25:24 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37FD1115;
        Tue, 15 Nov 2022 13:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Had04J9P5Vsju0/PzF3EVxNTwGTiLJcT7wb5/iaijj0=; b=xzxTxaI1eYTB8w8acxwXxJACos
        vMUlUjQl9Kf3ltDYTVZ3C+slp/bZaToYc/AmiI+pgmo9mnozdXGnCy5EIeEEF05M1pRDVYUgbA3NJ
        HgJM4SjRMAgBdZjWUlaI5ep8qgVNV0iJuVH0eN8bf2FySrcMZuqC2XTGSo7BqV5r481ICR5cMsKSu
        jbKLQPdGPpQbLHO1Qzsyqk+s5oS9R7+X3YSjuxLRMKE9NLPZEOf4UK1/h87VNIlECytUscRosvcGB
        Mbs1cQ5mALcHLYRBLdykH9Veml2JaNdmV20SZhfLOLwi2WLiUGsymGy/ObQ1npOUoPH0xOD2Uwm9W
        j2HmdsWA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ov3QI-00F2d4-4M; Tue, 15 Nov 2022 21:24:50 +0000
Date:   Tue, 15 Nov 2022 13:24:50 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>, masahiroy@kernel.org,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com, Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v9 7/8] kallsyms: add /proc/kallmodsyms for text symbol
 disambiguation
Message-ID: <Y3QDoqa4gW8Y0hUG@bombadil.infradead.org>
References: <20221109134132.9052-1-nick.alcock@oracle.com>
 <20221109134132.9052-8-nick.alcock@oracle.com>
 <Y3Bjy8UlZXdpWMYn@bombadil.infradead.org>
 <87r0y5v5hu.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0y5v5hu.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 04:57:17PM +0000, Nick Alcock wrote:
> > I'd like much more review from other parties other than Oracle on this then.
> 
> Well, yes. That's what these postings are all about. If I was supposed
> to get review from someone else as well, I'm happy to add those people
> to the Cc: of future iterations.

Yes, given Zhen is active on the same exact area I figured his input
would be of great value here too. I'd be wonderful if you can get
those eager to see this upstream on the toolside too.

  Luis

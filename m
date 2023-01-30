Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31165680682
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 08:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbjA3Hdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 02:33:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjA3Hda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 02:33:30 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAA41A4A5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 23:33:28 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E812368BEB; Mon, 30 Jan 2023 08:33:24 +0100 (CET)
Date:   Mon, 30 Jan 2023 08:33:24 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Arnd Bergmann <arnd@kernel.org>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Finn Behrens <me@kloenk.de>, Miguel Ojeda <ojeda@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfio-mdev: add back CONFIG_VFIO dependency
Message-ID: <20230130073324.GA590@lst.de>
References: <20230126163719.3585002-1-arnd@kernel.org> <20230126103811.56d71351.alex.williamson@redhat.com> <20230126174044.GA15999@lst.de> <20230126104515.3fcb3abf.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126104515.3fcb3abf.alex.williamson@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 10:45:15AM -0700, Alex Williamson wrote:
> The culprit is already in my next branch, we just need a fix that
> includes all the cases.  A respin of Arnd's patch would be preferable
> to keep the fixes in one place.  Thanks,

Arnd, do you plan to resend the patch, or should I take care of it?

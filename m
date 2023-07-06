Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A91749BD8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 14:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjGFMdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 08:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjGFMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 08:33:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAC91BF0;
        Thu,  6 Jul 2023 05:33:10 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99EAF67373; Thu,  6 Jul 2023 14:33:06 +0200 (CEST)
Date:   Thu, 6 Jul 2023 14:33:06 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     syzbot <syzbot+dfe2fbeb4e710bbaddf9@syzkaller.appspotmail.com>
Cc:     axboe@kernel.dk, brauner@kernel.org, davem@davemloft.net,
        edumazet@google.com, hare@suse.de, hch@lst.de,
        johannes@sipsolutions.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [wireless?] WARNING in restore_regulatory_settings (2)
Message-ID: <20230706123306.GA12417@lst.de>
References: <0000000000001432c105ffcae455@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000001432c105ffcae455@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 10:35:58PM -0700, syzbot wrote:
> The issue was bisected to:

I suspect this bisection would benefit from a re-run, as thecode is
entirely unrelated.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82086C7FDE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 15:29:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbjCXO3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 10:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbjCXO3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 10:29:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84041F91C;
        Fri, 24 Mar 2023 07:29:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 12A30CE260C;
        Fri, 24 Mar 2023 14:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783FBC433EF;
        Fri, 24 Mar 2023 14:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679668144;
        bh=JR7DtGUAL0wRPxeOGOkH9j4FO+RrH8rOYrb6nK8zEKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bi385WymzMnJLfB+DcsYMW7VqXYHbySd/VOag/CG+QAI6QFyhFzazgjVAoHGovlTr
         upImmDezWJgOYwwFQ1SQ7mOJhFkMKCQOM/xj8+YOHJe2M11a1J/64RtHFqrmQyVxA+
         Hu5I9jF7AaJ97yvLpnv80EQainiNZTsvKNxFz08A=
Date:   Fri, 24 Mar 2023 15:29:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZB2zrHSzmi8FXABI@kroah.com>
References: <20230302211759.30135-1-nick.alcock@oracle.com>
 <20230302211759.30135-11-nick.alcock@oracle.com>
 <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
 <ZArc0ib697JIwKou@kroah.com>
 <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
 <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
 <ZB1p5zRp7rlGGuCP@kroah.com>
 <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
 <87h6uamdzw.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6uamdzw.fsf@esperi.org.uk>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:16:03PM +0000, Nick Alcock wrote:
> On 24 Mar 2023, Geert Uytterhoeven uttered the following:
> > I (still) agree with that, and I saw similar comments from others as well.
> > Unfortunately these comments are spread across tens of threads :-(
> 
> Ugh. Should I do this sort of thing in one big commit next time? That
> would fix that problem, but at the cost of others. Lumping seems to me
> to be troublesome because it makes it harder to accept/reject different
> bits, but would it be *as* troublesome as this much splitting?

The problem is, some of us disagree that this should be done at all, so
reverting all of the individual parts is going to be hard now.

Please put back the license bits that you removed, as it is not a good
idea to remove that if the file does not have a SPDX entry at the very
least.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D661671659
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 09:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbjARIfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 03:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230157AbjARIe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 03:34:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A14867D672
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 23:55:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D643B81B7F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 07:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76BDCC43392;
        Wed, 18 Jan 2023 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674028493;
        bh=JQqmecIfxMxs6vGsi0JIQw3M+U0/4vAHWi7GNsHJJ3E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i6UB2wEEhG4vs88TVqHkMCneQlSv6t2Zn7QLhxudRpswKV+QTeBXJHF/69aATL3g7
         3dzTz7hXn/wq1hIGhfR/4iuwxklMkUtRkmPwgqaOjaXpE+KvdPu/aycHl5BAYUEU8c
         URBZaI32QAxrx3OhBqgkrPrOVtTtXP9nQKALGk+U=
Date:   Wed, 18 Jan 2023 08:54:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] driver core: bus.h: document bus notifiers better
Message-ID: <Y8elymzNMSHjDE/P@kroah.com>
References: <20230111092331.3946745-1-gregkh@linuxfoundation.org>
 <CAJZ5v0hOOeGBKiOpnsQSm=CKum-JEASmygKXrU76WK7gynVdKw@mail.gmail.com>
 <baf03556-718b-ea50-db48-04819a9cb094@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <baf03556-718b-ea50-db48-04819a9cb094@infradead.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 11:29:12AM -0800, Randy Dunlap wrote:
> 
> 
> On 1/11/23 01:54, Rafael J. Wysocki wrote:
> > On Wed, Jan 11, 2023 at 10:23 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> >>
> >> The bus notifier values are not documented all that well, so clean this
> >> up and make a real enumerated type for them and document them much
> >> better.  When doing this, remove the hex values and just rely on the
> >> enumerated type instead as that is all that is needed.
> >>
> >> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> >> Cc: Randy Dunlap <rdunlap@infradead.org>
> > 
> > I would add a Co-developed-by for Randy along with his sign-off (which
> > was given IIRC).
> 
> or
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Either way; doesn't matter.

Thanks, I'll take it this way I don't have to respin it again :)

It's always the "simple" patches that take the most revisions...

greg k-h

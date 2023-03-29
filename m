Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB386CD1CC
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 07:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbjC2Fqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 01:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjC2Fqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 01:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350AD35A8;
        Tue, 28 Mar 2023 22:46:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99ABA61A4E;
        Wed, 29 Mar 2023 05:46:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C72C433EF;
        Wed, 29 Mar 2023 05:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680068797;
        bh=+iww93uuVjdBhdL0/L8gZYSOkFBuwO8g7kYZXV0Bk/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZlRhu5f5otMVqSpA3zlttXBVbmcSXqMzRTDVDn+SFVKcIYGvS5O037AptWC0fF+dR
         odGGjujVEdBIpNVASHexeGHQh/pusth+SYQYcoFWWsPyi3GPY/zbtBCCgs/bGt+O6U
         6xM+i8MpWOImV7SibLT8qt9mTHD6nvQi2JuuDQ6I=
Date:   Wed, 29 Mar 2023 07:46:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, rafael@kernel.org,
        christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com
Subject: Re: [PATCH 6/7] debugfs: add debugfs_create_atomic64_t for atomic64_t
Message-ID: <ZCPQug6kTUbCgGnu@kroah.com>
References: <20230329053149.3976378-1-mcgrof@kernel.org>
 <20230329053149.3976378-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329053149.3976378-7-mcgrof@kernel.org>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:31:48PM -0700, Luis Chamberlain wrote:
> Sometimes you want to add debugfs entries for atomic counters which
> can be pretty large using atomic64_t. Add support for these.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> ---
>  fs/debugfs/file.c       | 36 ++++++++++++++++++++++++++++++++++++
>  include/linux/debugfs.h |  2 ++
>  2 files changed, 38 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00913720B03
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjFBVfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbjFBVfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E8E48
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 14:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A77B76187E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 21:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2154AC433EF;
        Fri,  2 Jun 2023 21:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685741696;
        bh=x2Bq6SqRV41prwMJ381Fmp+/QUaGoTrwFGIS9pRTnm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEmhvo6Xb4s96CHynJIOTGFU7GR2g5BCkPcTHJtX6QmTtiWR3Z9NDsvD29kTj4402
         dusEnc8hvXtHWM3Yk5asN4iuDcgYgAR8q/EPXYXBjtMFUzP1k7XBl8QmcCQLuKOhSQ
         wielXXa4N+/S+MHpsKtwCRVlQUNkbAxjdcThJISVlfvrhBmE+akCKXhiGTxIBdxhGI
         bSqjqH9tKRgLKxEaStWPXwabrSqo0xANa6kIGNYc2QKB6KErCDNiUQTffAh3Nyxu1e
         Amm0RF5Nlb/vOhR0clGs9YgeQ06fpRVt9/AiQc54VXA4Awbog+Xz5IxXB/wWvatfMk
         s2yNHjND6aNHg==
Date:   Fri, 2 Jun 2023 14:34:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Coiby Xu <coxu@redhat.com>
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        x86@kernel.org, dm-devel@redhat.com,
        Pingfan Liu <kernelfans@gmail.com>,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>,
        Kairui Song <ryncsn@gmail.com>,
        Jan Pazdziora <jpazdziora@redhat.com>,
        Thomas Staudt <tstaudt@de.ibm.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS
 volume key
Message-ID: <20230602213452.GC628@quark.localdomain>
References: <20230601072444.2033855-1-coxu@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601072444.2033855-1-coxu@redhat.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 03:24:39PM +0800, Coiby Xu wrote:
> [PATCH 0/5] Support kdump with LUKS encryption by reusing LUKS volume key

The kernel has no concept of LUKS at all.  It provides dm-crypt, which LUKS
happens to use.  But LUKS is a userspace concept.

This is a kernel patchset, so why does it make sense for it to be talking about
LUKS at all?  Perhaps you mean dm-crypt?

- Eric

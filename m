Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DEC6B732B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjCMJvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231341AbjCMJuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:50:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A744A255
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7966FCE0FA4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 09:50:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD09C433D2;
        Mon, 13 Mar 2023 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678701049;
        bh=GMpaLnOqXb+7MPkHeMOKZKNyvoOvPhAmgpt/cCCapG4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IlKbUZTEfaWxHP6cZkwLsDTXGNL3BXy7K86TuZ25hVU7t44PnNf+2Eplg+Ys7L2hc
         un8IrYMbyS29LC1JTQaiL3LLbvPhsFqIvlqX+HBNVhBkOEiaIYIBYqLh+IiH8JTEKM
         ugvtGLUPSuiaHpstiWhgD/FRR5b5KhI8FovbBwzU=
Date:   Mon, 13 Mar 2023 10:50:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
        willy@infradead.org, Suren Baghdasaryan <surenb@google.com>,
        jgg@ziepe.ca, Liam.Howlett@oracle.com,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [RFC PATCH v1 1/1] linux: mm_types: allow to modified the
 vm_flags in vm_area_struct
Message-ID: <ZA7x9y60sfGOanHl@kroah.com>
References: <20230312224250.425727-1-vincenzopalazzodev@gmail.com>
 <20230312175703.d8d8e0192387dfa9592ee8e5@linux-foundation.org>
 <CR55BD4YCDR1.22R5TLYJW6YS0@vincent-arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CR55BD4YCDR1.22R5TLYJW6YS0@vincent-arch>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:25:19AM +0100, Vincenzo Palazzo wrote:
> P.S: regaring the warning at compile time the __deprecated looks a good
> fit to generate error message, but to me in this particular case do not.

__deprecated does not work in the kernel tree, sorry.  We have tried
that in the past and it just gets ignored.  Instead, we fix up all
in-kernel users and continue on.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFAC673DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:36:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjASPgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjASPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:36:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A1F4AA7D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:36:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5A0A61CAB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:36:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F54C433D2;
        Thu, 19 Jan 2023 15:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674142600;
        bh=W9u0ghQp7d7SCJKd2B0KI95GYN8AzW6Xlg6C+RRPznk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KiugIs2sQyMP/yqnF6qhaHIvatzWSQ88LKbmCQ5kKPJfjYQDV2Xwq70i+vtucK+qL
         b+rXwhdG73w9z8QnVBFEExKpd121QT9qCSVov6TxOzBTeltKbLRDWY5iCfF35r176Z
         ECLzzFODjau8eTnJQbvlZOTCLTHC9u4blkFavJM0=
Date:   Thu, 19 Jan 2023 16:36:37 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        vishalc@linux.vnet.ibm.com, peterz@infradead.org,
        srikar@linux.vnet.ibm.com, sshegde@linux.ibm.com,
        vincent.guittot@linaro.org, vschneid@redhat.com,
        ritesh.list@gmail.com
Subject: Re: [RESEND PATCH] sched/debug: Put sched/domains files under the
 verbose flag
Message-ID: <Y8ljhaw51IVpYo7A@kroah.com>
References: <20230119150758.880189-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119150758.880189-1-pauld@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 10:07:58AM -0500, Phil Auld wrote:
> The debug files under sched/domains can take a long time to regenerate,
> especially when updates are done one at a time. Move these files under
> the sched verbose debug flag. Allow changes to verbose to trigger
> generation of the files. This lets a user batch the updates but still
> have the information available.  The detailed topology printk messages
> are also under verbose.
> 
> Discussion that lead to this approach can be found in the link below.
> 
> Simplified code to maintain use of debugfs bool routines suggested by
> Michael Ellerman <mpe@ellerman.id.au>.
> 
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Vishal Chourasia <vishalc@linux.vnet.ibm.com>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Link: https://lore.kernel.org/all/Y01UWQL2y2r69sBX@li-05afa54c-330e-11b2-a85c-e3f3aa0db1e9.ibm.com/
> ---
> 
> Resending due to typo in lkml address... sorry about that.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

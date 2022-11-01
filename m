Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58CF615262
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 20:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKATg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 15:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiKATgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 15:36:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB941DF06;
        Tue,  1 Nov 2022 12:36:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BDCFD6171D;
        Tue,  1 Nov 2022 19:36:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F84C433C1;
        Tue,  1 Nov 2022 19:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667331384;
        bh=AP596yVVEDsxPMT/I21iYenq7eC8RlBYr6K+iZZTV3k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XP8BFOGCJpEYCiLPhFfjvF8d/7338MBysHlO7tiV7q++0KwsQdsmd+Uapf8HBiVAE
         1hlf7Z6FuvslZTwLXTQBNZNUW9NMNNFt6BcjdZciJ73s09Nbly7NyU2JTMYjTfnBHi
         boNi0SNQDNFSq8nLdaQsxYwN9cKWuby8dtR4hWCk=
Date:   Tue, 1 Nov 2022 20:37:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     bvanassche@acm.org, hare@suse.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, yi.zhang@huawei.com,
        yukuai1@huaweicloud.com, yukuai3@huawei.com,
        stable-commits@vger.kernel.org
Subject: Re: Patch "scsi: sd: Revert "scsi: sd: Remove a local variable"" has
 been added to the 4.14-stable tree
Message-ID: <Y2F1bsrDoUA6vHIM@kroah.com>
References: <20221101013124.2615274-1-yukuai1@huaweicloud.com>
 <166733132219544@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166733132219544@kroah.com>
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2022 at 08:35:22PM +0100, gregkh@linuxfoundation.org wrote:
> 
> This is a note to let you know that I've just added the patch titled
> 
>     scsi: sd: Revert "scsi: sd: Remove a local variable"
> 
> to the 4.14-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

Oops, nope, not 4.14, sorry for the noise, now dropped from there.

greg k-h

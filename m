Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14916687A49
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 11:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjBBKcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 05:32:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjBBKcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 05:32:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF45939BB8;
        Thu,  2 Feb 2023 02:32:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F44FB8254B;
        Thu,  2 Feb 2023 10:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86861C4339B;
        Thu,  2 Feb 2023 10:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675333956;
        bh=f5BlT6ka4S5TqXSK7USea+D18Qq7XLw3q+6gEZ8NSSY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eIQGMD4Jfs51Wz1wAHt74Z6rftyCorPrvv+wUDT3yAWu9Nxh8NSAv23RumQJpLL75
         o81uWiR0b7442wIF49GpmSthGfxd0u40Javs/oU1RhJ8KdUdC0hbFfQfC1LyMWFVmO
         922iZmQTfZJ4jspm+UMfFdOdHdZBMKo094aZ/QL8=
Date:   Thu, 2 Feb 2023 11:32:33 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Viken Dadhaniya <quic_vdadhani@quicinc.com>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_msavaliy@quicinc.com,
        quic_vnivarth@quicinc.com, quic_vtanuku@quicinc.com,
        quic_arandive@quicinc.com
Subject: Re: [PATCH V2] Serial: core: Add compat ioctl support
Message-ID: <Y9uRQb72Y7byQiXa@kroah.com>
References: <20230125113418.7221-1-quic_vdadhani@quicinc.com>
 <Y9EfYCBngFAG+RBw@kroah.com>
 <10d91214-4106-7a9d-b1ac-68df1aa5f6c9@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10d91214-4106-7a9d-b1ac-68df1aa5f6c9@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Thu, Feb 02, 2023 at 03:44:45PM +0530, Viken Dadhaniya wrote:
> Hi Greg,
> 
> "Can you point us at the out-of-tree code please?"
> 
> Please refer: https://git.codelinaro.org/clo/la/kernel/msm-5.10/-/blob/KERNEL.PLATFORM.1.0.r3-01300-kernel.0/drivers/tty/serial/msm_geni_serial.c#L750

As this is a 5.10 link, are you sure this is the same codebase you are
using?

That ioctl handler does not touch the arg parameter at all, so what
would a compat_ioctl() handler be required for?

confused,

greg k-h

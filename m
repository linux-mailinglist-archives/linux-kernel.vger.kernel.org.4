Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779C64070E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 13:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiLBMpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 07:45:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiLBMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:45:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCBAC9369;
        Fri,  2 Dec 2022 04:45:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C2BF62287;
        Fri,  2 Dec 2022 12:45:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81452C433C1;
        Fri,  2 Dec 2022 12:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669985120;
        bh=t8sfzuCCm/l1EfBEcwE/jqM8rHmm3bbGkjPYzubDMJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ytE8GeHLff7hf4iEvcna2HVbbmem732Xkmerlqym0++r60F6nJkCwF3ACXkTk5uCZ
         YFUudt8Ras2gvk0lMBVF71NegjxLvAGYsTkTmNdwRyX79nYtOpWymjTluJq1YSSNGz
         r71OkRQJDo+uYEmXAx1VORokECwRu1nJn7Jhurzs=
Date:   Fri, 2 Dec 2022 13:45:15 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v5 0/1] Fix CONFIG_USB=y && CONFIG_MODULES not set
Message-ID: <Y4nzW92fRB2kQvbv@kroah.com>
References: <CAJzde07w6U83U_63eaF0-6zaq0cOkaymuLb3CBZ++JQi+Y9JdA@mail.gmail.com>
 <20221201211630.101541-1-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201211630.101541-1-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 03:16:29PM -0600, Allen Webb wrote:
> # Patch Review Discussion
> 
> Luis Chamberlain <mcgrof@kernel.org> would prefer something generic and
> mentioned kmod already has builtin.alias.bin.

This does not start well as this makes no sense at all if someone reads
this from top to bottom, right?

confused,

greg k-h

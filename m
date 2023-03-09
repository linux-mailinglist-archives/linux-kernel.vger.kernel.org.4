Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF86B2AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 17:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjCIQj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 11:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjCIQi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 11:38:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623D23D95;
        Thu,  9 Mar 2023 08:28:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F07B2B81FB1;
        Thu,  9 Mar 2023 16:15:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0031AC433EF;
        Thu,  9 Mar 2023 16:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678378501;
        bh=HcwHDBfFsKMC1NScBUvgLRXeM273n/hMohRdHJg+Xh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fBn4ORoJgJ9/ZDEE2QDPdiUpLhPiB3wJmlLoxIWFeUqajPrUSr+S11Zigs2yTXH96
         kkTgc+dwJ7CKAesmoXOXwMrbASlFFyuTfSDrlvwyXnsqF/QuP52I3WFxRH+4uBmUWi
         HrYhjtJs4yCrPkjhHWFvi6esIdYgZGPSUpxPcNjQ=
Date:   Thu, 9 Mar 2023 17:14:58 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     mcgrof@kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 00/20] MODULE_LICENSE removals, fifth tranche
Message-ID: <ZAoGAj3sRXKYzwc2@kroah.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228130215.289081-1-nick.alcock@oracle.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 01:01:55PM +0000, Nick Alcock wrote:
> This series, based on current modules-next, is part of a treewide cleanup
> suggested by Luis Chamberlain, to remove the LICENSE_MODULE usage from
> files/objects that are not tristate.  Due to recent changes to kbuild, these
> uses are now problematic.  See the commit logs for more details.

Why isn't kbuild fixed instead?  These files can have MODULE_AUTHOR()
and other macros when built into the kernel, what is so special about
MODULE_LICENSE() that prevents this from working properly?

There should not be a need to remove these markings in my opinion, why
treat one MODULE_* macro more special than others?

thanks,

greg k-h

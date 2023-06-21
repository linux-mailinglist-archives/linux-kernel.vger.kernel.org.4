Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C17738FCE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjFUTO0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjFUTOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:14:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7017B1BDA;
        Wed, 21 Jun 2023 12:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05728616AA;
        Wed, 21 Jun 2023 19:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18E63C433C8;
        Wed, 21 Jun 2023 19:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687374842;
        bh=QaPsmfBqIsm6jwVGOfOGqf5F/kYdyLOVSDcXFQMo7p8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nuOvWfkIDOfM8oOjCWPghndHSIXPstAthl23hpPMKlfVB/gjIMs4melt5WfYNx4En
         UmiTTwP2JsACvzwRUUFt+bp25VG1IXbufkr5sURLZtBVPm3W5FhsbBdfzfuWrPFR8o
         orkL/5zBPXL073rFApC6DA4Z1+STO1VDEfD701cc=
Date:   Wed, 21 Jun 2023 21:13:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] interconnect changes for 6.5
Message-ID: <2023062117-angles-staff-b31c@gregkh>
References: <20230621172121.2049612-1-djakov@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621172121.2049612-1-djakov@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 08:21:21PM +0300, Georgi Djakov wrote:
> Hello Greg,
> 
> This is the pull request with interconnect changes for the 6.5-rc1 merge
> window. In contains a mix of core and driver changes. The details are in
> the signed tag.
> 
> All patches have been in linux-next during last 10+ days. Please pull into
> char-misc-next when possible.
> 
> Thanks,
> Georgi
> 
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
>   Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-6.5-rc1

Pulled and pushed out, thanks.

greg k-h

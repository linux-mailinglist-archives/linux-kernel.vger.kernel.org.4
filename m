Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5C0728FA2
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 08:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjFIGIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 02:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjFIGI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 02:08:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D831FE6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 23:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCFA065191
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 06:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3364C433EF;
        Fri,  9 Jun 2023 06:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686290907;
        bh=FU6XI80Mtpu1ZsJI4FK+BKj2igRR6RprCkI2he4ChN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KUWTfS1XwwwWRh5mANvNrGp7PR4HA84OVbND2Osc4rdeGuvAF2YrH6D94SSCY5Hif
         drb/T9z9+ykuy187lqopqc1Xuyn00zSmWSRAX3YTV9BhIS+/C7O9eg/5pIdHce5qtx
         lxuqdPvROG0kZhpvLyZO0nx6IDNB50+CDZG9VwbM=
Date:   Fri, 9 Jun 2023 08:08:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>
Cc:     linux-kernel@vger.kernel.org, srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] Update comment to include stepping
Message-ID: <2023060943-muskiness-chooser-dfde@gregkh>
References: <20230609044222.18928-1-sumeet.r.pawnikar@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609044222.18928-1-sumeet.r.pawnikar@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 10:12:22AM +0530, Sumeet Pawnikar wrote:
> Wildcard for stepping "X86_STEPPING_ANY" is also defined here.
> So, update comment to include "stepping".
> 
> Signed-off-by: Sumeet Pawnikar <sumeet.r.pawnikar@intel.com>

Hi,

Please follow the internal Intel-documented rules for how to submit a
kernel patch. As-is, we can not accept this because that did not happen.

thanks,

greg k-h

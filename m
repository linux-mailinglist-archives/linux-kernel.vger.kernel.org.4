Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024AA6E7A55
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:10:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbjDSNKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDSNKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:10:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90CDAB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:10:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A5B63890
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:10:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B6A4C433D2;
        Wed, 19 Apr 2023 13:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681909845;
        bh=k4YCObGJ+C+Vyl3QuUc3sk/QjpCB5IvZqqIEZKCTk50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NBSZOADtYp9S+zb5r0V8tgRyWQWdNAEGnt3eGx5es+PWCZRcEH9RKNt4C+CjmW4Mi
         b69ixsv6Hyp7CibfrWdxo/pw7lcO4pxbqAXqC15B0aE8XPegB11eNIAXLyaFqUa0+f
         gs/rr8qZuhK3E++mSDjxjVp60HG/QiWT2ykV29Ww=
Date:   Wed, 19 Apr 2023 15:10:43 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Pierre Gondois <pierre.gondois@arm.com>,
        ALKML <linux-arm-kernel@lists.infradead.org>,
        linux-riscv@lists.infradead.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: [GIT PULL] cacheinfo/arch_topology: Updates for v6.4
Message-ID: <2023041935-undrilled-french-b251@gregkh>
References: <20230417181540.1926349-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417181540.1926349-1-sudeep.holla@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 07:15:40PM +0100, Sudeep Holla wrote:
> Hi Greg,
> 
> Couple of the patches are fixes but I wanted them to be in the next for some
> time to get better testing. Few others are addressing issues in RT kernel.
> 
> Please pull !
> 
> Regards,
> Sudeep
> 
> -->8
> 
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/sudeep.holla/linux.git tags/cacheinfo-updates-6.4

Pulled and pushed out, thanks.

greg k-h

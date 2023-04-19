Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B6C6E7A50
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 15:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjDSNJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 09:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjDSNJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 09:09:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA90AB
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 06:09:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB9D463EE2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 13:09:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB86EC433EF;
        Wed, 19 Apr 2023 13:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681909756;
        bh=f1moSFCROgEh58mrQbilscCSWCC6RomoomQxBffMnnM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QhofbyL48eHNFqtYHO5svXT0FqHDEXI9g/5aT18oVeSluILeUsmo8SKsu/3PJpNYP
         /Yw7K3v9Lw3xdn6CWrFclVITpB9Bnvwx09nioI4bmEZA0ljde/QKVCsotZn6K7CE+s
         z0NigDvns4O2dBkCqggnhxqzIakJVpmuXyBbM1C0=
Date:   Wed, 19 Apr 2023 15:09:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     mathieu.poirier@linaro.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, leo.yan@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] coresight: Updates for v6.4
Message-ID: <2023041957-glider-reckless-737b@gregkh>
References: <20230418165644.114745-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418165644.114745-1-suzuki.poulose@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 05:56:44PM +0100, Suzuki K Poulose wrote:
> Hi Greg,
> 
> Please find the updates for coresight self hosted tracing targeting v6.4
> Kindly pull.
> 
> Suzuki
> 
> The following changes since commit 197b6b60ae7bc51dd0814953c562833143b292aa:
> 
>   Linux 6.3-rc4 (2023-03-26 14:40:20 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux.git tags/coresight-next-v6.4

Pulled and pushed out, thanks.

greg k-h

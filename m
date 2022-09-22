Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87235E65FC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 16:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232042AbiIVOlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 10:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231968AbiIVOkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 10:40:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5A410550
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 07:39:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9259B837B5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 14:39:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C65C433C1;
        Thu, 22 Sep 2022 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663857581;
        bh=NmalYTWlpegPNmSebz1/TB8RUDKxWyIKj7C0uvuCoM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jc2+8Rdli5YQaCocPz4uhs4DUXLrQpuIF7DTgiz76h9QOyMFH5D138dcgx0Uej7xh
         lnST5TYcPtoh9mQGpm0MyT6C4pWxaNtq9dCEwOleOx43ttp8cbzP6HS5n48NQegTvf
         VF/AXFgfuIHLMEfmrdvtwB63rf88Vsi5kNXuQr6U=
Date:   Thu, 22 Sep 2022 16:39:38 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] GNSS updates for 6.1-rc1
Message-ID: <YyxzqmMY6cs31Fu+@kroah.com>
References: <YyxoYMIT4lMw/O5f@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyxoYMIT4lMw/O5f@hovoldconsulting.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 03:51:28PM +0200, Johan Hovold wrote:
> The following changes since commit a111daf0c53ae91e71fd2bfe7497862d14132e3e:
> 
>   Linux 5.19-rc3 (2022-06-19 15:06:47 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-6.1-rc1

Pulled and pushed out, thanks.

greg k-h

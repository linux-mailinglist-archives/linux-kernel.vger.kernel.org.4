Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D18714B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjE2N4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbjE2N4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:56:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1BB1BB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 06:56:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A969F61488
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 13:53:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD00FC4339B;
        Mon, 29 May 2023 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685368432;
        bh=jVDsGL+dLqD9K1LG+CET/uN8pHwWk1DdYzI4yZ1/8nQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s0cCKHCXDli2lqMwKffWE3VnfTnCd8vyQyB43t4UIU2JZZjBVz8TkemVrLv8fyBN4
         N6IBS8GsO9+lvMNRONbiG+Q4DYg6xFs4LMtXr6nhD5KLvSaU0hhJGJUpX2/x6eIWpR
         nOpTkXCtYh9ZtgLD1tjwVCKhcjCDzvJkEPxTQrdg=
Date:   Mon, 29 May 2023 14:53:49 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Winiarska, Iwona" <iwona.winiarska@intel.com>
Cc:     "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] PECI fixes for v6.4
Message-ID: <2023052904-platypus-mower-0e01@gregkh>
References: <f8506bf66b8bdaa85b5a2bec48bcdcc6a2853da7.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8506bf66b8bdaa85b5a2bec48bcdcc6a2853da7.camel@intel.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 22, 2023 at 09:24:26PM +0000, Winiarska, Iwona wrote:
> Hi Greg,
> 
> please pull PECI update for Linux v6.4.
> 
> Thanks
> -Iwona
> 
> The following changes since commit c21c0f9a20a963f5a1874657a4e3d657503f7815:
> 
>   Binder: Add async from to transaction record (2023-05-13 20:38:12 +0900)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/iwi/linux.git tags/peci-fixes-6.4

This includes some random Binder changes that do not belong in my
char-misc-linus branch right now for 6.4-final

> 
> for you to fetch changes up to 849b391254bf64796655868dbb6dee23551ff7d3:
> 
>   peci: Constify struct peci_controller_ops (2023-05-22 22:16:16 +0200)

Why is this a bugfix that needs to get merged now?  Shouldn't this be
for 6.5-rc1?

thanks,

greg k-h

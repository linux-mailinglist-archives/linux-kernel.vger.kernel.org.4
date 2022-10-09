Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C3B55F89D5
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 08:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbiJIGwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 02:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiJIGw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 02:52:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B732A426;
        Sat,  8 Oct 2022 23:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 53813B80B02;
        Sun,  9 Oct 2022 06:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F405C433C1;
        Sun,  9 Oct 2022 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665298345;
        bh=hY2moWN7aawBvjhYz3VFmMcafpGLPLpnIUUqaC4drow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fHNCuCS+gEepH4lsAV9JqYFZIn/NCllLjIpdUjNP0iOxVlrodnLjY9xleiEM1vNJw
         SohQbjKkag8Tb6GxJhyT+sPdBi1aItTWHMCZjY2MXFp1zPw/byzs5IKh3AbOWGo0fW
         O6j2I0Q4qCl0XhCHhS3LwEwTtuXyHINnlsMye1zk=
Date:   Sun, 9 Oct 2022 08:53:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        Dongliang Mu <mudongliangabcd@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: cdns3: adjust the partial logic of cdnsp_pci_remove
Message-ID: <Y0Jv0zkDYM9nuPol@kroah.com>
References: <20221009053245.154922-1-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221009053245.154922-1-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 09, 2022 at 01:32:45PM +0800, Dongliang Mu wrote:
> From: Dongliang Mu <mudongliangabcd@gmail.com>
> 
> In cdnsp_pci_remove, if pci_is_enabled returns true, it will
> call cdns_remove; else it will call kfree. Then both control flow
> goes to pci_dev_put.
> 
> Adjust this logic by modifying it to an if else.
> 
> Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>

Your email address does not match your From: address, and your From:
address is saying it is being spoofed and not correct :(

Please work with your school to fix your email system and do not use
gmail to hide it.

thanks,

greg k-h

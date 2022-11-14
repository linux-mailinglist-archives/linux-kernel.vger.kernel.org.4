Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24110627C68
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 12:34:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236119AbiKNLeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 06:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiKNLeE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 06:34:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1710CE09E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 03:34:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7387B80E04
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 11:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B84C433C1;
        Mon, 14 Nov 2022 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668425640;
        bh=MunztYmjYzSwPB7BJisv1LFGgh+doIRNYlMHEkJPVTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEU7/PRuHPugtaXjvj9Yex5i8zVN24TMzd1lXWXEZpREuC54HnYAPpyAcp7rTGdmO
         IYWdnb3v6exS6yh1wHVHWROBbhFxspKd22x7hvRIR9VgJ4LcptSUjt/4bKaSY9GxSo
         yJhIxFWoNdIO3Ie7mcTPZ/NH1Gh8RR6OJgqbVHKg=
Date:   Mon, 14 Nov 2022 12:33:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cuigaosheng <cuigaosheng1@huawei.com>
Cc:     dinguyen@kernel.org, richard.gong@intel.com, atull@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: stratix10-svc: Fix IS_ERR() vs NULL check in
 stratix10_svc_drv_probe()
Message-ID: <Y3InpOKpj9qD8pYL@kroah.com>
References: <20221114025921.1194834-1-cuigaosheng1@huawei.com>
 <Y3HtGbqAvb15Sa9a@kroah.com>
 <4cb8207d-e2c1-b459-e456-d8998f8180c8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cb8207d-e2c1-b459-e456-d8998f8180c8@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 07:11:16PM +0800, cuigaosheng wrote:
> > How was this found and tested?
> 
> Thanks for taking time to review this patch.
> I found this through the cocci script, I made the patch based on the code logic,
> but I have not tested it due to the lack of hardware devices.

As per our documentation, you have to explain how stuff like this is
found and tested.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D46A26E3238
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 18:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbjDOQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 12:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOQCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 12:02:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BDB1B0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 09:02:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66CE061590
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 16:02:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73DC4C433D2;
        Sat, 15 Apr 2023 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681574520;
        bh=2lxNx7dI1f2VCmdKpHS7oTJtbs5wANZA9fpjkO9Vgx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q0XP0174xStEWXWeFFPe0+WirBJj6nldDTsyDpJPIZ5unZQIOfSQX+eKgWRrgsirW
         /s73QAKT9u5oPNOuCeaO9Y91ZCGhcR7kjTkU24RGPIqE/QNGKlG0lR5NwwLSM57qOZ
         1v/xXWwZGtiGQjRYPT3tQCdQJR/ajuNea1Ok/baU=
Date:   Sat, 15 Apr 2023 18:01:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dalvin-Ehinoma Noah Aiguobas <pharcodra@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: remove typedef declaration
Message-ID: <2023041533-idealness-stand-8909@gregkh>
References: <20230415120141.GA6585@koolguy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415120141.GA6585@koolguy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 15, 2023 at 02:01:41PM +0200, Dalvin-Ehinoma Noah Aiguobas wrote:
> Fix checkpatch.pl warning for enums.
> 
> Change typedef cvmx_helper_interface_mode_t to
> enum cvmx_helper_interface_mode in ethernet.c

You did much more than that here in this patch, so obviously we can't
take this as-is, right?

thanks,

greg k-h

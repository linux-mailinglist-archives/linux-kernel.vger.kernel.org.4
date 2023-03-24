Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA076C7EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 14:41:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCXNlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 09:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbjCXNlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 09:41:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A295E3588
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 06:41:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 592A8B82373
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 13:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E3CC433EF;
        Fri, 24 Mar 2023 13:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679665294;
        bh=rA1qZ0HoorQz4ApkFS8rkxmcQ6ub1F7xDJ+dPGqOup8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbNkT2xCrc7Jo9ojb9jbCg+bwNXuPP0R/NVY/f30hTsdINkwMdWzRmay1sj1qMKmu
         52IWaHb0CepumZ4PjwBnZxbfPhgkHz+ZVXdKTV+2UyDIAxscjjecGiW6fr2ZPZo+27
         MQ64Pu4LJbI6xHZX3yYLnXQfXXWN90eaiTGA/8jM=
Date:   Fri, 24 Mar 2023 14:41:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] driver core: device.h: remove extern from function
 prototypes
Message-ID: <ZB2oitEd4SLhOJfl@kroah.com>
References: <20230324122711.2664537-1-gregkh@linuxfoundation.org>
 <CAJZ5v0gPL9Zk65tXvc7hxySNdJgCj-si84mBq0iiHTHv7dmuXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gPL9Zk65tXvc7hxySNdJgCj-si84mBq0iiHTHv7dmuXA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 02:35:12PM +0100, Rafael J. Wysocki wrote:
> On Fri, Mar 24, 2023 at 1:27 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > The kernel coding style does not require 'extern' in function prototypes
> > in .h files, so remove them from include/linux/device.h as they are not
> > needed.
> >
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>
> 
> for this one and the rest of the series.

Thanks for the review!

greg k-h

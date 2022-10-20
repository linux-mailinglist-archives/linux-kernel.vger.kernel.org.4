Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36118605681
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiJTE5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTE5L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:57:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07ED162513
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:57:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2CA7B822C8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4000AC433D6;
        Thu, 20 Oct 2022 04:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666241826;
        bh=Ni4r2wMFH0K6x/UKO1tZ8E4iMWvcsU87QJi7cnK12BA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DrLjh0yhAZ5zE3jnwCwfCq45IvFU167umi6Bn41dUmXPpRtTMDX7DqQC9XgsNjBxi
         tXjn2atJNeClii/ysuCTmXrktwS1IGlEx/91yGDsr0mJQYmS5odoEIXeACAukFL9Qa
         bOzZPyXz4YUFh8bYceke5YD3k2ozzi/L6P1jR4rM=
Date:   Thu, 20 Oct 2022 06:57:03 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Emily Peri <eperi1024@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: rtl8723bs: fix white space warnings
Message-ID: <Y1DVH+UatalfjDN5@kroah.com>
References: <cover.1666230736.git.eperi1024@gmail.com>
 <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45558673b486808e7978e2e4838c6ce5a2485b8b.1666230736.git.eperi1024@gmail.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 07:10:51PM -0700, Emily Peri wrote:
> Fix the following checkpatch warnings in rtw_ioctl_set:
> 1) Add missing blankline after declaration
> 2) Replace spaces used for indent with tab
> 3) Remove space before tab

When you have to list the different things you do, you should really
break that up into individual patches.  This should be 3.

thanks,

greg k-h

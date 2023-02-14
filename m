Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF8F6959AD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 08:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjBNHH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 02:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjBNHHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 02:07:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 857391E2B4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 23:06:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6F0A61462
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8235C433D2;
        Tue, 14 Feb 2023 07:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676358414;
        bh=hC3l/+y6uwVYPPTbvHEPM4NEa2wabflPEzAauRmEjpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JmpVs+JIaoQcEJGCba93ZR2qqwHdiWTArQCcsbAl5PjTd7y8SCEa1cFynHpoJfHXN
         biYVAYS76ozOdG2tWwerN4kg+786RUi5bjpr1IQg1C9QH1aICn/9YjXyLrZwhzfwE6
         4ai6ZXc+0jZTYc0Wklk7w01al7uCB9aCXVQY3MCY=
Date:   Tue, 14 Feb 2023 08:06:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH v3 4/6] sign-file: cosmetic fix
Message-ID: <Y+szC9rMhKu4s5Xa@kroah.com>
References: <20230213190034.57097-1-sshedi@vmware.com>
 <20230213190034.57097-4-sshedi@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230213190034.57097-4-sshedi@vmware.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 12:30:32AM +0530, Shreenidhi Shedi wrote:
> In the previous patch for adding bulk modules support, this was not done
> because it will add a lot to review in one patch.

This changelog text means nothing, what would you do if you were reading
this and had to review it?

thanks,

greg k-h

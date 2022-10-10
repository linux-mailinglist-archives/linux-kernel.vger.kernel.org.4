Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA575F9847
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiJJGW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231371AbiJJGW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:22:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1BC14BD06
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 23:22:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 426E6B80E36
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:22:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0100C433D6;
        Mon, 10 Oct 2022 06:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1665382942;
        bh=eU6nKUGRICKBPqnh8VlPl5I90p3qXrHPn9KVy3p8Wqw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UEfO3gHb80kHnvl6D2XTXYxjI0ALQtEYiyS/FSVrfgB7xyyLbdnkTFowyQd6AD8p8
         oIMicDWuLAILcgn5X0EyzRvaC2nflcsTKmFOr25TWz2l/7vdhU3puvBtbj4qC8cwOn
         1vY4Vq/6m8qseY50lN1rBUs37PSA9uD5mZkgJTrs=
Date:   Mon, 10 Oct 2022 08:23:05 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yi Jiangshan <13667453960@163.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: Re: Re: [PATCH] staging: rtl8723bs: fix spelling typo in comment
Message-ID: <Y0O6SckZK8a9FNG2@kroah.com>
References: <20221009065647.2635700-1-13667453960@163.com>
 <Y0MROo7YMrVoYyZ8@kroah.com>
 <382427df.1d30.183bfdca4b0.Coremail.13667453960@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <382427df.1d30.183bfdca4b0.Coremail.13667453960@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 11:07:31AM +0800, Yi Jiangshan wrote:
> 
> At 2022-10-10 02:21:46, "Greg KH" <gregkh@linuxfoundation.org> wrote:
> >On Sun, Oct 09, 2022 at 02:56:47PM +0800, Jiangshan Yi wrote:
> >> From: Jiangshan Yi <yijiangshan@kylinos.cn>
> >
> >Then why is this being sent from a 163.com address?
> >
> 
> >What is wrong with using your real mail server?
> 
> 
> There is a problem with the company's mailbox, and sometimes I can't receive emails. So I temporarily use my personal mailbox to send patches, so that I can receive feedback from the community in a timely manner.

But how do I know that this is a valid company email address at all?
It's not authenticated as such, so many companies do not like people
faking their address.

Please send from your company address and you can always cc: the 163.com
one, right?

thanks,

greg k-h

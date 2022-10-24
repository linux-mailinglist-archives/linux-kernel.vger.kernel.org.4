Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 473AF60B126
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiJXQQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbiJXQMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:12:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DD72AC5A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:02:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCB26B80EE6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:36:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CA9C433C1;
        Mon, 24 Oct 2022 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666622175;
        bh=gwfiJkXT4vQgGzm7tBqH9t2IbWqn36DC5eH2R2xulhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CU88enVxowdSFaIFhw3WyvzsEMBJ7M2EOdZu0jxZ/EMYmN5m2eNPiM/3TJtADNHsR
         3pWWPW1fipdmjx/t1ymsgfVSKiJiikXzVIBYAb8VURO2Tcu9yiDxyfgEotqiHaZhvP
         q+ik3JQTkjnMLvv2AVeWP21P2nyKDgdyKkFbfmIE=
Date:   Mon, 24 Oct 2022 16:37:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Starke, Daniel" <daniel.starke@siemens.com>
Cc:     "pchelkin@ispras.ru" <pchelkin@ispras.ru>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/2] tty: n_gsm: revert tx_mutex usage
Message-ID: <Y1ajEC1o9D0yrDE1@kroah.com>
References: <DB9PR10MB58817A08B92BA7F943CDD9B2E02E9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB9PR10MB58817A08B92BA7F943CDD9B2E02E9@DB9PR10MB5881.EURPRD10.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:30:23PM +0000, Starke, Daniel wrote:
> I have checked both patches. Those appear to be correct.
> Furthermore, I also recommend to bring in these reverts.

Can you send a "Reviewed-by:" tag for me to apply?  Hint, don't send it
in an HTML email so that lore.kernel.org will properly pick it up.

thanks,

greg k-h

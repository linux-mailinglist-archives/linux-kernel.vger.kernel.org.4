Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B8EA657545
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiL1K1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:27:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiL1K1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:27:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B65FDDC;
        Wed, 28 Dec 2022 02:27:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1782CB81623;
        Wed, 28 Dec 2022 10:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7148DC433EF;
        Wed, 28 Dec 2022 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672223227;
        bh=kFO5Z3PYwEsWLeiDYZIAncNIUmeQESZu27Pq7T4qfas=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p1gkDlhTh3sQvegGD/Ecemc0nvQRuZpD/DaZ0z8pF4JU/psaGFtO2eJfPC8pNacWb
         XfLUddxy/Tl9cxA1ObXJ9n2t3x07CZanTK8XVR98xbYRv3LtuEgk3EER0rCxGamYB9
         3nHkRvQiKl/tSWSZ7DKnsK7a209ZJ2Co6e70TQlI=
Date:   Wed, 28 Dec 2022 11:27:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gongwei Li <lifangpi@hotmail.com>
Cc:     mathias.nyman@intel.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, 972624427@qq.com,
        Gongwei Li <ligongwei@kylinos.cn>
Subject: Re: [PATCH V2] usb: Fix typo in comment
Message-ID: <Y6wZ+FWhuV8pVl1E@kroah.com>
References: <SI2PR02MB4603F6E3B7E062EF76656956DDED9@SI2PR02MB4603.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR02MB4603F6E3B7E062EF76656956DDED9@SI2PR02MB4603.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2022 at 02:59:30PM +0800, Gongwei Li wrote:
> From: Gongwei Li <ligongwei@kylinos.cn>

Please fix your corporate email systems so that you do not have to use
a hotmail.com account.  Otherwise how can we verify that this email
address really is the one to be attributed to this change?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E83E65A36D
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 10:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLaJ5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 04:57:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiLaJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 04:57:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5C3E0BD
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 01:57:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C707BB802C4
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 09:57:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3469EC433EF;
        Sat, 31 Dec 2022 09:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672480635;
        bh=AXXOh/RY6WDMCQPMGkbuxwLrHQ9KX6rDRlQcTaOGsqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hE08b1hgNn0QNDUXcxgqBA25nWgMPQVoaySOwt2XjEibMBlH0NVcAFUL1wMhOj516
         q1XKmOf/19l81ZFGTbuor2/8OgkdL0KCtZuXwTzRX4zXKU53zoDPSPkytydOSd2xJ3
         g3HR0Z5TeHmVizar0W7TluODc7RA+wa8+CxsyUS0=
Date:   Sat, 31 Dec 2022 10:57:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yoochan Lee <yoochan1026@gmail.com>
Cc:     matt.hsiao@hpe.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] misc: hpilo: Fix use-after-free in ilo_open
Message-ID: <Y7AHeYJhQEC1/bAb@kroah.com>
References: <20221231055310.2040648-1-yoochan1026@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221231055310.2040648-1-yoochan1026@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 02:53:10PM +0900, Yoochan Lee wrote:
> A race condition may occur if the user physically removes the
> hpilo device while calling open().

How did you test any of this, and how can you remove one of these
devices like this?

thanks,

greg k-h

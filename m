Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57A93642854
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbiLEMWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:22:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbiLEMWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:22:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9D2F589
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:22:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2D48B80EDA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:22:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C645C433C1;
        Mon,  5 Dec 2022 12:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670242948;
        bh=qRF5edHMbAecWo8CQr4Qqz1yhE/mivsv7gKQsDWYevE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dbkyuHMWyoweKu+FVXYm+8Q1GioiZ91EeGR7pCkjU1/Kd6aIXaT3ob4Z8fzx3aYDH
         qycukLKE41MqFsX6bxdvqeddbXUez1R+SIZL7xYTgjyiftnpguICG/SzGas7ZATbMD
         DQ6HZb603IYtigmrevb/jKhVNBHjJtZvtzjC6sVo=
Date:   Mon, 5 Dec 2022 13:22:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dongliang Mu <dzm91@hust.edu.cn>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mingyi Kang <jerrykang026@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH 2/2] staging: vme_user: fix coding style
Message-ID: <Y43igvotWRmQzn+e@kroah.com>
References: <20221126125642.16358-1-dzm91@hust.edu.cn>
 <20221126125642.16358-2-dzm91@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126125642.16358-2-dzm91@hust.edu.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 08:56:34PM +0800, Dongliang Mu wrote:
> Fix coding style enforced by Linux kernel

What coding style was changed?  Please always be specific.

thanks,

greg k-h

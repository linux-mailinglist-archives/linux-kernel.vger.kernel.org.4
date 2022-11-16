Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED0562B30B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 07:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232115AbiKPGBZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 01:01:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKPGBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 01:01:22 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B351624F3C;
        Tue, 15 Nov 2022 22:01:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D35061A1D;
        Wed, 16 Nov 2022 06:01:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EA32C433C1;
        Wed, 16 Nov 2022 06:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668578480;
        bh=V3w/kxz51DnumUTH5v4zQSaLT0XLgiO8uDxw/pJHIU4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pvN+3IyO8UA7f6xFOeMDQQv9Kv97zU38WUIaE0eSGDb0gTCbz5P10hsuUqQBRedGt
         3L4p5gw33HnP5o25S9uCOMRgLvmoRREsj4xxBgQKtUty0iPQBeSVEbMmjLIt3f+03y
         EgrVKmz8trzApbMI1XDtSMjUyD6Ryua6dwPGPZgI=
Date:   Wed, 16 Nov 2022 07:01:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Duke Xin <duke_xinanwen@163.com>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, jerry.meng@quectel.com,
        duke.xin@quectel.com
Subject: Re: [PATCH]     USB: serial: option: add Quectel EM05-G modem
Message-ID: <Y3R8rENevX3UHw1J@kroah.com>
References: <20221116052537.239117-1-duke_xinanwen@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116052537.239117-1-duke_xinanwen@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:25:37PM +0800, Duke Xin wrote:
>     The EM05-G modem has 2 USB configurations that are configurable via the AT
>     command AT+QCFG="usbnet",[ 0 | 2 ] which make the modem enumerate with
>     the following interfaces, respectively:

Why do you have extra spaces in your subject and in the text here?

Please fix up.

And properly version your patches, as the documentation asks you to.

thanks,

greg k-h

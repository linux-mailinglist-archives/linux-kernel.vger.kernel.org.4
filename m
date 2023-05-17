Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A8570673E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 13:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjEQLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 07:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbjEQLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 07:55:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05FF14EED;
        Wed, 17 May 2023 04:55:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 974D5645E2;
        Wed, 17 May 2023 11:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BD8C433EF;
        Wed, 17 May 2023 11:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684324503;
        bh=QjDFl8qsl03ACnGAbCKclbpn19nXKOIYeuXTrdd8eZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ivjWWGpkKIxKbRePBSUDBR19USoPr1sjD+M51FUV/EWRT/dNdB95SwVosxsbWkJQ7
         F4rwDngxsTxPI3elfg5qWSgFtZrFr2keW9w4vGL4USJGmPtiZgn+UOKw7aFoheDhMQ
         6G8Uy4oXZhCBwU7+VGsjhHI6uIZhsjkQblyFuoFg=
Date:   Wed, 17 May 2023 13:54:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hongyu Xie <xiehongyu1@kylinos.cn>
Cc:     linux@armlinux.org.uk, jirislaby@kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        xy521521@gmail.com
Subject: Re: [RFC PATCH -next] tty: serial: add panic serial helper
Message-ID: <2023051713-velcro-revolving-0660@gregkh>
References: <20230517101403.232594-1-xiehongyu1@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517101403.232594-1-xiehongyu1@kylinos.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 06:14:03PM +0800, Hongyu Xie wrote:
> +// SPDX-License-Identifier: GPL

That is not a valid SPDX identifier, didn't checkpatch.pl tell you that?

Please use the proper one when you resend this, we can not take this
as-is, sorry.

greg k-h

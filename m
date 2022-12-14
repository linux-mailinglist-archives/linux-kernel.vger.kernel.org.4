Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060CE64C50D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 09:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237567AbiLNI0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 03:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237779AbiLNI02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 03:26:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA121F9D0;
        Wed, 14 Dec 2022 00:26:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id ECB6BCE17F3;
        Wed, 14 Dec 2022 08:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF8CC433D2;
        Wed, 14 Dec 2022 08:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671006384;
        bh=YwJTEZ71O3ZucE2faqH1tiLkYHePrkLe0wFnTl3Tk7g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cGpJmIl9Hb3N2ECi+W+zsv+WGY+cr/aewW3yqZ0bGEoI6FMnCJMpcWdbPRpPtwRjt
         WW50PGu/9f3VsfLwxA0lTmHxbJhgAjzAChwaOrAyn98v5k0FsltoMYt0ox4+oCyAP2
         tW2iBxmUb2RRdkxsUYVOdFV37NpWb0V3+iKLLbUU=
Date:   Wed, 14 Dec 2022 09:26:21 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "atsushi.nemoto@sord.co.jp" <atsushi.nemoto@sord.co.jp>,
        "tomonori.sakita@sord.co.jp" <tomonori.sakita@sord.co.jp>
Subject: Re: [PATCH V3 0/3] fsl_lpuart: improve Idle Line Interrupt and
 registers handle in .shutdown()
Message-ID: <Y5mIrXNjivMXVnNi@kroah.com>
References: <20221125101953.18753-1-sherry.sun@nxp.com>
 <AS8PR04MB8404BABDC0FD4FAB0D89534B92E09@AS8PR04MB8404.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR04MB8404BABDC0FD4FAB0D89534B92E09@AS8PR04MB8404.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 02:43:16AM +0000, Sherry Sun wrote:
> Gentle ping for this patch set...

It's the middle of the merge window and we can not do anything until
6.2-rc1 is released, sorry.

thanks,

greg k-h

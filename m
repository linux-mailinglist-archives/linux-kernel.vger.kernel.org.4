Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF425BDEC1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbiITHt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiITHsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:48:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A552E61DA4;
        Tue, 20 Sep 2022 00:48:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 646CEB82565;
        Tue, 20 Sep 2022 07:47:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE1DC433C1;
        Tue, 20 Sep 2022 07:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663660069;
        bh=sF/ekF++TcP0EdKsQUTmJOSIuGh0DPHLXbPRTcGIJbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PTY8p8PhZeAtZSW1M+vf67xJFDsPYFPQ/e5Mz9HMARCtZ6kjzGdcgwWG+2nCTz9W/
         p5d6wPpNLH6MABboHJZ0hZ5Kf1ddr5pWLdEoMopL0vqnwQQCWPqtYp0OqJXUwNvnCC
         oQbS4alP4dMvhPlzcCSlGDDCEX9RCErurfogtQlykOTzsREvL+7z8HwGjPmRy0+duE
         upaKexSU1/0NLkWxW6byVwm4wSdKEmViu+KtKcf3RiiyIpkivGIW56R7f/yICcJfWS
         OgJJZ9Snb1x1/YCeLESsOkFmFJY3hpN0+h7q0Jq47MMCNIdLoBYkIz8NV9GlNbKwbz
         YSzYiAus5Y4FQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oaXyx-0001kJ-Rr; Tue, 20 Sep 2022 09:47:51 +0200
Date:   Tue, 20 Sep 2022 09:47:51 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB: serial: ftdi_sio: misc clean ups
Message-ID: <YylwJ4V2XE2J8wYN@hovoldconsulting.com>
References: <20220919132456.20851-1-johan@kernel.org>
 <Yylrwo9nXL9mD0HE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yylrwo9nXL9mD0HE@kroah.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 20, 2022 at 09:29:06AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Sep 19, 2022 at 03:24:53PM +0200, Johan Hovold wrote:
> > Here are some clean ups on top of the recent dev_groups attribute
> > conversion.
> > 
> > Johan
> > 
> > Johan Hovold (3):
> >   USB: serial: ftdi_sio: clean up attribute visibility logic
> >   USB: serial: ftdi_sio: move driver structure
> >   USB: serial: ftdi_sio: clean up driver prefix
> > 
> >  drivers/usb/serial/ftdi_sio.c | 144 +++++++++++++---------------------
> >  1 file changed, 54 insertions(+), 90 deletions(-)
> 
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks for reviewing. Now applied.

Johan

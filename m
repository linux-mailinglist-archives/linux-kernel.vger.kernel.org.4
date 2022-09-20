Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D954A5BDE27
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 09:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiITH2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 03:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiITH2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 03:28:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9724458DD9;
        Tue, 20 Sep 2022 00:28:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4A37DB819F9;
        Tue, 20 Sep 2022 07:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4463DC433C1;
        Tue, 20 Sep 2022 07:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663658917;
        bh=FJaiWAaFHeQgP4x9w+wFbcktUFzt9Ep0Da3Dc5/WxXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dn/zG13Zxvy5eVJD8CmZWmy3RY0TcsFb1sD+H4oppF1id5LSEF0Rpb38Og2aJImAC
         OWslrji463NT+jZdiEXTsEfTNqxUFMBTiVIb9Fla6VOqVhL7jV1t/Vl8erFJsb/rAi
         3kkpefnM8NhR9q4NrR2vTyGrJN6vwBaIlUfgiH90=
Date:   Tue, 20 Sep 2022 09:29:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Jiasheng Jiang <jiasheng@iscas.ac.cn>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] USB: serial: ftdi_sio: misc clean ups
Message-ID: <Yylrwo9nXL9mD0HE@kroah.com>
References: <20220919132456.20851-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919132456.20851-1-johan@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 19, 2022 at 03:24:53PM +0200, Johan Hovold wrote:
> Here are some clean ups on top of the recent dev_groups attribute
> conversion.
> 
> Johan
> 
> Johan Hovold (3):
>   USB: serial: ftdi_sio: clean up attribute visibility logic
>   USB: serial: ftdi_sio: move driver structure
>   USB: serial: ftdi_sio: clean up driver prefix
> 
>  drivers/usb/serial/ftdi_sio.c | 144 +++++++++++++---------------------
>  1 file changed, 54 insertions(+), 90 deletions(-)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

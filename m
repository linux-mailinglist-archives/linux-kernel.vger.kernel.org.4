Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE3305B5BE6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 16:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiILOGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 10:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiILOGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 10:06:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FBC30568;
        Mon, 12 Sep 2022 07:06:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B9D06120A;
        Mon, 12 Sep 2022 14:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 974BFC433D6;
        Mon, 12 Sep 2022 14:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662991569;
        bh=4cCtUudbawm+UnJWnu2b2CxDIiQ72+u7muiS4i6vKbY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rnzmyd5PvhOikIOgOx8xNMjTTNq4XHXQt2egSv8MvTHSQ5atjCyaighWtEVKyJwKj
         ceuX91psVzoG56cJPSJaKH4eYMCwuDtbalQp8tSLsFrXEuOpUDTegj0KzQTTRaDb0J
         stcx8rVuEiA5DrhKxEfIuMy8bmSm8oCclI4nMu9k=
Date:   Mon, 12 Sep 2022 16:06:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cgel.zte@gmail.com
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xu Panda <xu.panda@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] USB: serial: ftdi_sio: remove the unneeded
 result variable
Message-ID: <Yx886nuo3NG+hOho@kroah.com>
References: <20220912133826.18517-1-xu.panda@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912133826.18517-1-xu.panda@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 01:38:27PM +0000, cgel.zte@gmail.com wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> Return the value usb_control_msg() directly instead of storing
> it in another redundant variable.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> ---

Also, as stated numerous times to your team, I can not accept patches
like this because of the previous issues have not been resolved at all
(email, ignoring the researcher rules, etc.)

Please fix that up first if you wish to have patches accepted.

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501575B6D6A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 14:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiIMMjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 08:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiIMMjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 08:39:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0276024BCE;
        Tue, 13 Sep 2022 05:39:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94C2F61451;
        Tue, 13 Sep 2022 12:39:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3601C433D6;
        Tue, 13 Sep 2022 12:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663072752;
        bh=VXIjPCa2kQ7oHQwQm/BZ4yK1duwVEMdgVhmEzngpzMo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k3stjfb9gGQnqEjnrK4lGgGJ91Vtp6MFp2/aH2PEYJnauTMQGjqY6eC7o61Iq1gd8
         4dH6MNSBd9ILciD6MsC87LWN1eOtwR/+NzN8NITF7IIcntZqQUZmY8xE1QeDVsK/22
         FQ8H78kKqWizYZhWjXWIphHni0oB1fWtrqQW4yNln+ssrSmWexmo9ouOI01KSaUSsd
         AGHEO3muttN5WjNo08FS+XT0ynoWzc/B3Zd7mO7oq/LedTX+IeCtIEWIaf1oTshF3S
         lu1YwTYaBbb8PNzzYgPqv1Imw8Jt6pYl+A/CxDOGvXkV43fpehhlVdNzut9b2dGkIj
         xT4yiVXOB8njg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oY5C2-0006N9-QP; Tue, 13 Sep 2022 14:39:11 +0200
Date:   Tue, 13 Sep 2022 14:39:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Carl =?utf-8?B?WWluKOaut+W8oOaIkCk=?= <carl.yin@quectel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Quectel BG95 0x0203 composition
Message-ID: <YyB57gXxByYOuZlW@hovoldconsulting.com>
References: <TYZPR06MB42704394860A86F0167F3E84867A9@TYZPR06MB4270.apcprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <TYZPR06MB42704394860A86F0167F3E84867A9@TYZPR06MB4270.apcprd06.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 09:49:43AM +0000, Carl Yin(殷张成) wrote:
> Add support for the following Quectel BG95 composition:
> 
> 0x0203: Diag + GNSS + Modem + ECM
> 
> usb-devices output:

> Signed-off-by: Carl Yin <carl.yin@quectel.com>

Now applied, thanks.

Johan

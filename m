Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6AF74C7E7
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 21:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjGITtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 15:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjGITtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 15:49:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907E9F9;
        Sun,  9 Jul 2023 12:49:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AA5460C38;
        Sun,  9 Jul 2023 19:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFD64C433C7;
        Sun,  9 Jul 2023 19:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688932142;
        bh=8raNvB95wa/j9bjSKifzW/pDQ17nJxXPJcuKG+ZvqD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vu2q3JdRDyLLGVc9lLrvZUu+zMJrK7eivF5OXVL6aPzTduc6//yyast3Y7kID9GpO
         eiI7d7xYW/XKjG6DfrBmC0dCkDXCOGrxzHqrL2hEzLu4N2QMciarzFAhIOULTvdYcJ
         QZGG236uG1oq7JUB4KmMpLXAbaga3crx+1YvZrAU=
Date:   Sun, 9 Jul 2023 21:45:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mohsen Tahmasebi <moh53n@moh53n.ir>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mostafa Ghofrani <mostafaghrr@gmail.com>
Subject: Re: [PATCH] USB: serial: option: add Quectel EC200A module support
Message-ID: <2023070902-scarf-gaming-137e@gregkh>
References: <20230709174130.8867-1-moh53n@moh53n.ir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230709174130.8867-1-moh53n@moh53n.ir>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 09, 2023 at 09:11:30PM +0330, Mohsen Tahmasebi wrote:
> Signed-off-by: Mohsen Tahmasebi <moh53n@moh53n.ir>
> Tested-by: Mostafa Ghofrani <mostafaghrr@gmail.com>

We can't take patches without any changelog text, sorry.

thanks,

greg k-h

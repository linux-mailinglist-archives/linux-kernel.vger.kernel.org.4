Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEC8473F8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 11:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjF0JWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 05:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbjF0JWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 05:22:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24F6FD;
        Tue, 27 Jun 2023 02:22:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41FD961089;
        Tue, 27 Jun 2023 09:22:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23153C433C8;
        Tue, 27 Jun 2023 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687857728;
        bh=XrG4FmjkYdqbee2LOkEbKggy1wU0b6pIOpPabzWshTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oqqnyuuunEp9xq1PQ+L2v+3pjjgP45bFgpSrnzgW1Ld6hL0xiIGHczKe5ZtqoNpht
         5h6YgXXEfKaFiMN0nFAK2VVFi7Lq+cIu6bbl7xKzT7zjO2jMUVb5fDRCYZx5TXp3uC
         dPZBVQyOhhB+MiYocdagxQ4CjB0iti6Ny3QPJtXs=
Date:   Tue, 27 Jun 2023 11:22:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rene Treffer <treffer@measite.de>
Cc:     Vinod Koul <vkoul@kernel.org>, Anne Macedo <retpolanne@posteo.net>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Christian Lamparter <chunkeey@googlemail.com>
Subject: Re: [PATCH] usb: host: xhci: remove renesas rom wiping
Message-ID: <2023062721-prevent-shallot-a292@gregkh>
References: <20230626204910.728-3-retpolanne@posteo.net>
 <ZJqUMWv1jM2KQsYu@matsya>
 <CALD2-c+Zp4B_zAXO0qnZcQh+geyWhi+ycv=FpL9TKhr4ZfVHJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALD2-c+Zp4B_zAXO0qnZcQh+geyWhi+ycv=FpL9TKhr4ZfVHJg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023 at 10:44:44AM +0200, Rene Treffer wrote:
> Hi,

<snip>

Sorry, but you sent html email which is rejected by the mailing list,
and you top-posted, which isn't all that good from a "getting stuff done
in a technical way" point of view.

Can you resend it so that the list does accept the response?

thanks,

greg k-h

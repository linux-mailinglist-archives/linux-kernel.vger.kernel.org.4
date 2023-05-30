Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1590716259
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232775AbjE3NnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjE3Nm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:42:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E35C5;
        Tue, 30 May 2023 06:42:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1DAC62EEC;
        Tue, 30 May 2023 13:42:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E9EDC433D2;
        Tue, 30 May 2023 13:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685454178;
        bh=88twlvhBpz/dbRVQNZujTvpnfWesPLuIsK8tph8tdlg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jVKnFkvJq39Cvb+WW3ywNYWG9VAHM6Lwf/cJgsbIqABjC3ecepZZVvquVtHE2yO/j
         ysknKcnQx5aWgWvNEUzXbouSVaS+HSF+mmCyP/4W0rMnPif2GRs5UxLcQNezRzHdsv
         rwXYVapbMGdwgefrS0ormPmbxqx+xhfdg8kNX77U=
Date:   Tue, 30 May 2023 14:42:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragos-Marian Panait <dragos.panait@windriver.com>
Cc:     stable@vger.kernel.org, Ruihan Li <lrh2000@pku.edu.cn>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.14 0/1] Hardening against CVE-2023-2002
Message-ID: <2023053030-moaning-endanger-ac26@gregkh>
References: <20230530131740.269890-1-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530131740.269890-1-dragos.panait@windriver.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:17:39PM +0300, Dragos-Marian Panait wrote:
> The following commit is needed to harden against CVE-2023-2002:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=000c2fa2c144c499c881a101819cf1936a1f7cf2
> 
> Ruihan Li (1):
>   bluetooth: Add cmd validity checks at the start of hci_sock_ioctl()
> 
>  net/bluetooth/hci_sock.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> 
> base-commit: b3f141a5bc7f877e96528dd31a139854ec4d6017
> -- 
> 2.40.1
> 

Nit, for 1 patch series, no need for a cover letter, you can put the
same info below the --- line if that's easier.

thanks,

greg k-h

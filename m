Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8FE74E759
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbjGKGbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjGKGbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC93B8
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0A68361325
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA75C433C8;
        Tue, 11 Jul 2023 06:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689057090;
        bh=qu1pd3b272tPo8ITAHMdIXv+6whUB9sDBn0ZFcwWQkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=brPXcBjoP+slwSVt0HXm6purXk9H9Ym82SraRQtgIczKBKhPyGcO1FqMKMCU4AkuA
         tYmJjh8RhHZub5hKpB4g2jLRO2MDbGD8ql5nl3EOamC0/Pc96x16+aqOrilbW6Tv/S
         XNz8Be2FtWMAOlLbT+Zm6kCVXNjmiNgDj7GrgznglK0pELVE0BpnaVy1ty7rUJoadT
         kCFVEYjxfYsdgX088XjIXR7EueoKXX7MStYFINNKqXHvFzyg8/gEG1ti029LqtPm/7
         xgx3QHPPa2kVwSKq6eVsDe6SU+Fzt0/vSs7MBp/BzNYlzxEtobfLdR94sbNwMsXGDU
         FVzgXH5D6KcwA==
Date:   Sun, 9 Jul 2023 12:35:05 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
        hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4] octeontx2-pf: Add additional check for MCAM rules
Message-ID: <20230709093505.GB7619@unreal>
References: <20230706173723.2226030-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706173723.2226030-1-sumang@marvell.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 11:07:23PM +0530, Suman Ghosh wrote:
> Due to hardware limitation, MCAM drop rule with
> ether_type == 802.1Q and vlan_id == 0 is not supported. Hence rejecting
> such rules.
> 
> Fixes: dce677da57c0 ("octeontx2-pf: Add vlan-etype to ntuple filters")
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> ---
> Changes since v3:
> - moved assignment of vlan_etype before the if check

And what were changes in previous versions?

Also you should write the target net or net-next in the patch subject.

Thanks

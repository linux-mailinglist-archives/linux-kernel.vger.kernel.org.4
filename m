Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F033724E8B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 23:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjFFVNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 17:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjFFVNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 17:13:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F9B41701
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 14:13:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE57D60B83
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 21:13:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCA1C433D2;
        Tue,  6 Jun 2023 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686085995;
        bh=R04WYpn2Yn/2CI+p7yTj26c1Zcz5H3XWzXyGd969w1w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tOG3vGI9CgA0P3q+XPd+npFBCvAWDee15veR3ePiUB38NyTVaDsylmOE9W5kBD2dQ
         KdI02sONG/xZUDqGgMumQBY3dj0HyWwo7pt0KjVTVPvFwWKgpUAc+7U2fiMClvgIt5
         GWnngAINtxCsYptJG2NMhOpgHQKyPcWknASBOfY+UavKOYmnNpsbdZSeUrfntKgcFs
         4p1id2yuXh+I3ymYAUvW9t2U0aC00+PczG7iDLXb3Il1lZl5bccEK/Gnb5EMMZEXp7
         GaxLdL/4uRCFisAcGYJl5E9TYZ6fdjLaZXXw34kpddMRLQlv0q3vPZtq7m6sWKiQH0
         vg4BKJMDC9TAw==
Date:   Tue, 6 Jun 2023 14:13:14 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc:     <wei.fang@nxp.com>, <claudiu.manoil@nxp.com>,
        <vladimir.oltean@nxp.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: enetc: correct the indexes of highest and 2nd
 highest TCs
Message-ID: <20230606141314.7d82d9ad@kernel.org>
In-Reply-To: <ZH+MBdlRAybwqFo8@boxer>
References: <20230606084618.1126471-1-wei.fang@nxp.com>
        <ZH+MBdlRAybwqFo8@boxer>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 21:41:57 +0200 Maciej Fijalkowski wrote:
> On Tue, Jun 06, 2023 at 04:46:18PM +0800, wei.fang@nxp.com wrote:
> > From: Wei Fang <wei.fang@nxp.com>  
> 
> if you are a sender then you could skip line above.

Git generates it because the From in the headers does not have the
names, just the email addr. It's better to keep it.

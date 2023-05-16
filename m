Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056117044BC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 07:35:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjEPFfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 01:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjEPFfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 01:35:08 -0400
Received: from mg.ssi.bg (mg.ssi.bg [193.238.174.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC4F3A9C
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 22:35:06 -0700 (PDT)
Received: from mg.ssi.bg (localhost [127.0.0.1])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTP id ABCACCCD8;
        Tue, 16 May 2023 08:35:03 +0300 (EEST)
Received: from ink.ssi.bg (ink.ssi.bg [193.238.174.40])
        by mg.bb.i.ssi.bg (Proxmox) with ESMTPS id 8CCC4CCD7;
        Tue, 16 May 2023 08:35:03 +0300 (EEST)
Received: from ja.ssi.bg (unknown [178.16.129.10])
        by ink.ssi.bg (Postfix) with ESMTPS id 35C533C080D;
        Tue, 16 May 2023 08:35:03 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
        by ja.ssi.bg (8.17.1/8.16.1) with ESMTP id 34G5Z1sr009900;
        Tue, 16 May 2023 08:35:02 +0300
Date:   Tue, 16 May 2023 08:35:01 +0300 (EEST)
From:   Julian Anastasov <ja@ssi.bg>
To:     Abhijeet Rastogi <abhijeet.1989@gmail.com>
cc:     Simon Horman <horms@verge.net.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netdev@vger.kernel.org, lvs-devel@vger.kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ipvs: increase ip_vs_conn_tab_bits range for 64BIT
In-Reply-To: <CACXxYfy+yoLLFr0W9HYuM78GjzJsQvbHnm43uRQbor_ncQdMgw@mail.gmail.com>
Message-ID: <02f51077-3cda-b4aa-a060-3c420cc72942@ssi.bg>
References: <20230412-increase_ipvs_conn_tab_bits-v2-1-994c0df018e6@gmail.com> <56b88a99-db88-36e4-9ff1-a5d940578108@ssi.bg> <CACXxYfy+yoLLFr0W9HYuM78GjzJsQvbHnm43uRQbor_ncQdMgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On Mon, 15 May 2023, Abhijeet Rastogi wrote:

> Hi Julian Anastasov,
> 
> >Can you keep the previous line width of the above help
> because on standard 80-width window the help now gets truncated in
> make menuconfig.
> 
> Refer this screenshot: https://i.imgur.com/9LgttpC.png
> 
> Sorry for the confusion, I was already expecting this comment. The
> patch had a few words added, hence it feels like many lines have
> changed. However, no line actually exceeds 80 width.
> 
> Longest line is still 80-width max. Do you prefer I reduce it to a
> lower number like 70?

	I'm checking in menuconfig where the help text is displayed.
The word "lasting" is visible up to "last". So, 3 columns are not
visible. In editor, this line is 84, may be up to 80 should be good.
You are using editor that represents Tabs as 4 spaces, that is why
it looks like it fits in 80. Open Kconfig in less. But in editor/less
does not matter because menuconfig simply ignores the leading spaces
in Kconfig and considers the text length which should be no more
than 70.

Regards

--
Julian Anastasov <ja@ssi.bg>


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F85633344
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 03:27:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiKVC1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 21:27:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiKVC1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 21:27:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C30261E
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 18:27:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7C46B818E7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 02:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB3E8C433D6;
        Tue, 22 Nov 2022 02:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669084029;
        bh=f8p3NDnP/ojCepGk1AfQOss+D4LjgykOMOD0RmRlGuY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=E5+sYQuKK2lhq+DeQ130EEzF0FrgB7RmSmgtfMWx0SAUYOdv3FqvcLjKJCCWBSaiM
         mjw1/nBicH/Z48AK2xGmScKOTVNBJCBhq0mYDdPzpjMcFmaWdp2WzkOgd6s0qHRktS
         bBsj83kgnscLSe3eKy1kOYt58hZloDz7mBDFc86Nm0s4IizQ9Fpvwut7LsYilwWVON
         X8OMr/0QQMdWFXL1YjpvWZ6yVu13arhmPaXL09cuzU26r4WhN/FAXzZa6MxR1Jo/Wg
         4qzgE3G7hgynJQro473jfFw/ehKsoUfH793UVunXmi/sOlk4AvKciTXZLqzbJuLiPA
         rt1/5+MeVKTVg==
Date:   Mon, 21 Nov 2022 18:27:08 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        GUO Zihua <guozihua@huawei.com>
Subject: Re: [PATCH 0/2] net/9p: fix response size check in
 p9_check_errors()
In-Reply-To: <cover.1669072186.git.linux_oss@crudebyte.com>
Message-ID: <alpine.DEB.2.22.394.2211211826570.1049131@ubuntu-linux-20-04-desktop>
References: <cover.1669072186.git.linux_oss@crudebyte.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Nov 2022, Christian Schoenebeck wrote:
> Follow-up fix for:
> https://lore.kernel.org/linux-kernel/Y3hADWgV9JeajmfF@codewreck.org/
> 
> Stefano, I am optimistic that this also works with Xen, but I have not
> tested it.

Tested-by: Stefano Stabellini <sstabellini@kernel.org>


> Christian Schoenebeck (2):
>   net/9p: distinguish zero-copy requests
>   net/9p: fix response size check in p9_check_errors()
> 
>  include/net/9p/9p.h |  2 ++
>  net/9p/client.c     | 12 ++++++++----
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> -- 
> 2.30.2
> 

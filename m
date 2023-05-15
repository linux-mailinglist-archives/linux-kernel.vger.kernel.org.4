Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933C5702B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 13:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbjEOLFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 07:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241084AbjEOLFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 07:05:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B054310FB;
        Mon, 15 May 2023 04:05:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D94D6228B;
        Mon, 15 May 2023 11:05:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EFE9C4339B;
        Mon, 15 May 2023 11:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684148702;
        bh=NghsNVLtn2JgTdeoRFwN9eKB00Dm9jlnwQxjILz0lks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ELKC7UFSxHoz8aSWh9DlNUT+4aUg9w0AYq5Vlpn4BHHK9uvi+703WJ8n+EXtOOXNo
         WOLtjR8V2JFI9DokQfJG37gnANTeF4UO7DtfdVYozfDgaTlm71HhTLAEhPU+KsNBcv
         InwPsX8+oW5lcGs5WNno20yJm0AIJ5pKEjuuKjTKoldkWQtNi+4OAxHkZ4cHxMci73
         8qJmawUKPJsVrJfro4cr+1P6iae91vIBbJH43A2t/nbQklenl3uChlntp/90HeBEbk
         3axD6xh+a32paxkbQg2nzC4rq/5csvXWM/jPt69hQWoO8LKCIr8unTekwBg96/ayaP
         j+D14hTfSInFw==
Date:   Mon, 15 May 2023 13:04:58 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     miklos@szeredi.hu, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] ovl: Fix null ptr dereference at realinode in
 rcu-walk
Message-ID: <20230515-befestigen-stopfen-ab8100cb6a00@brauner>
References: <20230505122452.405661-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230505122452.405661-1-chengzhihao1@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 08:24:50PM +0800, Zhihao Cheng wrote:
> Zhihao Cheng (2):
>   ovl: get_acl: Fix null pointer dereference at realinode in rcu-walk
>     mode
>   ovl: ovl_permission: Fix null pointer dereference at realinode in
>     rcu-walk mode
> 
>  fs/overlayfs/inode.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)

Seems fine to me. Thanks for fixing this,
Reviewed-by: Christian Brauner <brauner@kernel.org>

(One thing that might be possible is to move this into a tiny static
inline helper but might not be worth it.)

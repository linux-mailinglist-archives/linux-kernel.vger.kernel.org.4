Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0FD705E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 05:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbjEQDnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 23:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjEQDnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 23:43:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0857335A4
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 20:43:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 98AC561259
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 03:43:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF9FC4339B;
        Wed, 17 May 2023 03:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684295012;
        bh=CJLZ9WG82ZCCQiQbLCmrLAxhuqRoqcXOdpEago8o7qI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HPlmQmSpJmKanQGBKHF6no2TOxgwxkIsWVhlpF0nXhUvxD/7kO7YvVFlXW0gHwFgh
         E9NFOpZlzYj5jVp1NuDH47L4i3F4MKiwvtE9YxP9FBoiqMZji/LMDLLu3kP+a4H8bG
         XZB26s8VfJehSYu8ZnJPD9WLy4I8vZczhPQJZ3HSpRYBmt1rg0lt2DZ6Fw11qGTG7h
         84LAs5Zt63rPHCgjTvrjXWtw8RDLSvljz8ug2W1eHvkjq4zy9jN+F5oBUu9bjaImBW
         8Vakoy7D6dSXAyCgdijlU/sica3lKFIz0DuqD1sGXuLf1AyXk3XWDw74S74VB8zxqC
         UaA5Bz6aGY7QQ==
Date:   Tue, 16 May 2023 20:43:30 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Angus Chen <angus.chen@jaguarmicro.com>
Cc:     davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, idosch@idosch.org, petrm@nvidia.com
Subject: Re: [PATCH v3] net: Remove low_thresh in ip defrag
Message-ID: <20230516204330.1443bc7c@kernel.org>
In-Reply-To: <20230517001820.1625-1-angus.chen@jaguarmicro.com>
References: <20230517001820.1625-1-angus.chen@jaguarmicro.com>
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

On Wed, 17 May 2023 08:18:20 +0800 Angus Chen wrote:
> As low_thresh has no work in fragment reassembles,mark it to be unused.
> And Mark it deprecated in sysctl Document.
> 
> Signed-off-by: Angus Chen <angus.chen@jaguarmicro.com>

We need to revert the old patch first, we can't remove the commit from
the git history because it would change all later hashes and break
rebasing.

Why are you renaming the member? Just add the comment and update the
documentation. You said you had a tested complaint, the tester will
only read the docs, right?
-- 
pw-bot: cr

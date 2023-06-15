Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2D0731EC5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 19:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238266AbjFORNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 13:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbjFORNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 13:13:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68B9199
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:13:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CC91624D1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 17:13:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C0C433C0;
        Thu, 15 Jun 2023 17:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686849192;
        bh=6SSLfq7V5KSJahhpCRu3vSuXfzu8zM6CNBuGD++Tk0k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=phCffPkLNX0UBga6d1orlfNRaESNiSxbsmQERAK3BObYlcIhwwrUTZ4/YTrNV+cRe
         9CWWLJuh2C24kTQbg97+zMch/haxICc6NsOk52eMBCFHyvM+f6VyWPMaDoeDRcY4Fb
         ZBEMGiYxkUkHJ46BqIFm5F6FVVgyqRpLaJgwKIko88DUbbl9BzYsPbcdznq8f1r/bh
         gACE7I3Zar6yxyDY++P39TDUe76zY7YIR0JrWGiENZCsCqBehHl58hIk//b4WZNuE+
         HNQSKN9i3hbxJ04RACBVWoor9jXCbbDn5iSshUsXVeANn1DDhnzRsh+ByBKwBlgNRD
         1f7KBK4OjMN5w==
Date:   Thu, 15 Jun 2023 10:13:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Sathesh Edara <sedara@marvell.com>
Cc:     <linux-kernel@vger.kernel.org>, <sburla@marvell.com>,
        <vburru@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: update email addresses of octeon_ep driver
 maintainers
Message-ID: <20230615101311.34f5199e@kernel.org>
In-Reply-To: <20230615121057.135003-1-sedara@marvell.com>
References: <20230615121057.135003-1-sedara@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 05:10:57 -0700 Sathesh Edara wrote:
> Update email addresses of Marvell octeon_ep driver maintainers.
> Also remove a former maintainer.

What does it mean to be a maintainer to you?

$ git log --author=sedara@marvell.com
$ git log --grep=sedara@marvell.com
$ 

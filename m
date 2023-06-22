Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E311E73961F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 06:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbjFVEF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 00:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjFVEFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 00:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1994420A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 21:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3EE1F61751
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 04:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C96CC433C0;
        Thu, 22 Jun 2023 04:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687406499;
        bh=I/DPIBH9Y5es+NWOTv9QziljXOlqUkgepZjrEJoMG/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lWV53gdPK3qQT3ZsPuMCXuQQb6X4lk5ia78C9oIbTZXealwnrpixoj3eU3q0zviDi
         VbbcWJWltWw9Yfo2069YpYrurq/gq3mRINh7NYiZNIY5xUD8Cfm2cXNnGVxWTkB+NB
         4l+I43NDZxOUUZrxehgj6TCYnMeu/ygIp+zTOJnbrpKfh6E8nmLmee4ANr1JMe9xFB
         bEX2r1/RGPCMXvNoCLnVOA7zmjRN4VkJGX49TOgOIv+V4hfjHPtHuWzkEK5syOu/7y
         ngcIGiqNd6K5cZBX7siLzeZbgIE+tHAOp6fbabIT2SA+zMo63iS35vJLHfNMb9snrD
         1BFzRLMHAhUaQ==
Date:   Thu, 22 Jun 2023 12:01:33 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 26/79] erofs: switch to new ctime accessors
Message-ID: <ZJPHnQXvsKhdPb6g@debian>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Gao Xiang <xiang@kernel.org>, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20230621144507.55591-1-jlayton@kernel.org>
 <20230621144735.55953-1-jlayton@kernel.org>
 <20230621144735.55953-25-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230621144735.55953-25-jlayton@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:45:39AM -0400, Jeff Layton wrote:
> In later patches, we're going to change how the ctime.tv_nsec field is
> utilized. Switch to using accessor functions instead of raw accesses of
> inode->i_ctime.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

Acked-by: Gao Xiang <xiang@kernel.org>

Thanks,
Gao Xiang

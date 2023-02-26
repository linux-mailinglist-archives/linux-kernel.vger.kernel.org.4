Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9DAC6A33C2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 20:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjBZTpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 14:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBZTpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 14:45:15 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9C61287A;
        Sun, 26 Feb 2023 11:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 95B8EB80C8D;
        Sun, 26 Feb 2023 19:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6DC1C433EF;
        Sun, 26 Feb 2023 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677440712;
        bh=OSwtZh3LVmcBE8L5v7Q9+ZP5zaBH8RmFfr6WYe81suE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nWLt8iPZi1F6Q6kRLiWNkjYEJoFkVMqsWrJHSh1zNZeLfyM3gkZ74ifkZ7f4MWpe0
         6fVydqDUa/UUaKkQCWnnJzlBNm2SiKINCup0TilEjxKDxfCwR8VNljNqBe+9o3fKGn
         VJJJEkGetXiABdKXw042fauR2pzWXZeCCpnPV2OFe16J72nx9c6VQxkNBZ2C7R/p0n
         85p8cwIAScEyXckthaTVqzXLMr7aLdBCkdzwuDx8c0yaLqy4u/yR6iSHXEhxf2nYYk
         AXLAyA/33pOdHHjrQGFq7MRQyhxzQa5SQF4xSdJgv8ULiALab86CcBSRaqdZfHMhvi
         IpJktS5fuATIA==
Date:   Sun, 26 Feb 2023 20:45:08 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org, "Paul E. McKenney" <paulmck@kernel.org>,
        rcu@vger.kernel.org
Subject: Re: [PATCH RFC v2] rcu: Add a minimum time for marking boot as
 completed
Message-ID: <Y/u2xK8FHwKMsJNh@lothringen>
References: <20230225033421.3323164-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230225033421.3323164-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2023 at 03:34:21AM +0000, Joel Fernandes (Google) wrote:
> On many systems, a great deal of boot happens after the kernel thinks the boot
> has completed. It is difficult to determine if the system has really booted
> from the kernel side.

Is this only about kernel booting? What makes it hard to determine if the
system has really booted?

Thanks.

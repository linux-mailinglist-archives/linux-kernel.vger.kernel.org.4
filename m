Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86510737151
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjFTQSF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 12:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjFTQSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 12:18:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46E7CF
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 09:18:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3FE1E61314
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 16:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D9E7C433C8;
        Tue, 20 Jun 2023 16:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687277881;
        bh=wBA0Y9Ha6H9ZxemUE1WcIWZcdsauUIHysTV95xMBlbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=szyVySQzzS8HwDYR6rOQ7eMA98hrqGmEHdDyArc/vFhMv5MBwwTPO+dCIKe8dwVAx
         /I3xmOA2A7pjhqaMUWqkYtMJccFXzhV6NdbHx4k8McuNZINpM8bQAXWlMFZS1zJEAW
         Geuhcpk/Mj9/9LjyphIaKdqHrRPZnIBBjf9FPvTBjZHFT4qYhgd3gUyk3ok0ivsuna
         YU0wj5N4tyVAkaOvhqWnuvbF7RwBeq1P2gK7usgYTAwifD8kLQ7FsyGqPlo5u4+yXB
         1f32qZKJAcEmiCTy49yga2KxQYNZk05Ie6JXzo1zkEngDI9iERp4Y0z2wz7sjUOlpy
         6jjPSFlBxvFdg==
Date:   Tue, 20 Jun 2023 09:18:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Veerasenareddy Burru <vburru@marvell.com>
Cc:     Sathesh B Edara <sedara@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Satananda Burla <sburla@marvell.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] MAINTAINERS: update email addresses of
 octeon_ep driver maintainers
Message-ID: <20230620091800.736bf269@kernel.org>
In-Reply-To: <20230616101229.1e7339f0@kernel.org>
References: <20230615121057.135003-1-sedara@marvell.com>
        <20230615101311.34f5199e@kernel.org>
        <BYAPR18MB2423D248B84D85F3C1A48159CC58A@BYAPR18MB2423.namprd18.prod.outlook.com>
        <20230616101229.1e7339f0@kernel.org>
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

On Fri, 16 Jun 2023 10:12:29 -0700 Jakub Kicinski wrote:
> > Sathesh will also be maintaining and submitting the changes for
> > octeon_ep drivers, going forward.
> >
> > Is the right way for this is, add Sathesh to MAINTAINERS list along
> > with his first patch/patchset submission ?  
> 
> The patch is perfectly fine. Please see my question as half survey half
> commitment device. I don't think we have a crisp enough understanding
> of responsibilities of "corporate" maintainers. It always worries me
> when I see someone who never (AFAICT) sent an email to the list before
> get nominated as a maintainer.
> 
> So I'd like to hear from Sathesh, clearly stated, what responsibilities
> and SLAs he's taking on. Once we gather input of this nature from a
> handful of maintainers maybe we can distill a guide in
> Documentation/process/...

Let me suggest one responsibility:

 - reply to maintainers' questions in a timely manner...

Please repost with the answer folded into the commit message
once you figure out what to say.
-- 
pw-bot: cr

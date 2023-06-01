Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03187197C5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 11:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbjFAJwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 05:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjFAJwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:52:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5D5136;
        Thu,  1 Jun 2023 02:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E9C3A642AA;
        Thu,  1 Jun 2023 09:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301C8C433EF;
        Thu,  1 Jun 2023 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685613146;
        bh=+C6KoTnzYoqe2NGMblFrRlx+vs7d7T9fhqlO/pPMxd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c1DAIlN8riwWFivON4JTRO9vAukPRUemXUBiab1A2/KrRKpBjGcyVU5PxkzRgnUjK
         0QffO/tpTWBgTzgAvw4pS+y7dYHxbMjUQplLlCsfySwbb52i3p2GnYpfHLOhu1gS7h
         fG2G4igdRuBzVq5NxAbJkmE4AUeB/rbaRKsRVzOSMntJSLulAEIwpQj9RjyUXRwX3s
         Kk5DFVNfq9FSQZa8Pi2balNYZVq6P2+tmkCoyEZnfBG5qCchDRZ+E1pex4MWlAIeLr
         bik+WrBZ1JnUzbWQ/aBion9cej695aexz7tXM7JtibW/GLFQbC/zpih9BwxY9OWyBg
         dq/CSd9UJvEdw==
Date:   Thu, 1 Jun 2023 05:52:24 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Andrey God <andreygod83@protonmail.com>,
        Christoph Hellwig <hch@lst.de>, kbusch@kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 6.3 01/67] nvme-pci: add NVME_QUIRK_BOGUS_NID for
 HS-SSD-FUTURE 2048G
Message-ID: <ZHhqWIU/YrJwzyYl@sashalap>
References: <20230525183144.1717540-1-sashal@kernel.org>
 <20230525190201.GA1266801@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230525190201.GA1266801@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 07:02:01PM +0000, Eric Biggers wrote:
>Hi Sasha,
>
>This feedback is on the whole 67-patch series.  I'm replying to patch 1 because
>this series lacks a cover letter.  Please include a cover letter next time.
>
>This series doesn't apply because the following error happens on patch 35:
>
>    Applying: tipc: add tipc_bearer_min_mtu to calculate min mtu
>    error: patch failed: net/tipc/bearer.h:146
>    error: net/tipc/bearer.h: patch does not apply
>    error: patch failed: net/tipc/udp_media.c:738
>    error: net/tipc/udp_media.c: patch does not apply
>    Patch failed at 0035 tipc: add tipc_bearer_min_mtu to calculate min mtu
>
>For the base commit I tried the latest linux-6.3.y, both with and without the
>latest queue-6.3 applied.

Yup, it was based on the prior release, and the conflict you see here is
because the patch in question was brought in to the stable tree via a
different route.

>As with any kernel patch series, please make it clear what the base commit is.
>Otherwise the series is unreviewable and untestable.

Ack, I can add annotation of the base. In general - if an AUTOSEL patch
fails to apply/build when brought to a newer release, it'll simply get
dropped.

-- 
Thanks,
Sasha

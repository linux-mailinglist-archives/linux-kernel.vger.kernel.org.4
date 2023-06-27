Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E754C7403AD
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjF0S7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjF0S72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:59:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B949419A9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:59:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55D92611FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 18:59:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C81CC433C8;
        Tue, 27 Jun 2023 18:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687892366;
        bh=jrWpCrzpq9YG0+S/IRAGmEuhe4lIZLpzAlVkc1cLz7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WcKXcba4+0jmSpEQOldnayk5/DNFBwkWx+lPEW/Qi41+DufsY7n9ZLEyOlljTskcW
         K9kqXwDwJjNZhuM/Km8xXnMjjsP4c78rZi0D5e9W1daLNQnKgfxrEg+Jh5SFZZBl23
         iJUNkIrYemmLMVYMI2eH9iPnOxR7AeH5EnjLYBIyffVv3qYugqoL+ev+5g1AGtIfjn
         YEQcBk1DEFOeLtF6O1kG3fhW9KK+zqhFIKW9qpQfFpERAoKoEgnOj8A6zbaUX1dQbt
         WBzzo8tCWStyCEY34lQ/SGyczqQqfeaeyiXQNghOS3Sbz4UbK/WFWJ+G/ZCXsSfqJo
         2nxMyjgCfIJAA==
Date:   Tue, 27 Jun 2023 11:59:25 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, pabeni@redhat.com,
        bpf@vger.kernel.org
Subject: Re: [GIT PULL] Networking for v6.5
Message-ID: <20230627115925.4e55f199@kernel.org>
In-Reply-To: <20230627184830.1205815-1-kuba@kernel.org>
References: <20230627184830.1205815-1-kuba@kernel.org>
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

On Tue, 27 Jun 2023 11:48:30 -0700 Jakub Kicinski wrote:
> WiFi 7 and sendpage changes are the biggest pieces of work for
> this release. The latter will definitely require fixes but
> I think that we got it to a reasonable point.

I forgot to mention a conflict, there's a trivial one because of
adjacent changes in fs/splice.c. Stephen has the resolution:
https://lore.kernel.org/all/20230613125939.595e50b8@canb.auug.org.au/

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F9165F791
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 00:27:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235947AbjAEX1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 18:27:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjAEX1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 18:27:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BBF06B195;
        Thu,  5 Jan 2023 15:27:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 59060B81BFD;
        Thu,  5 Jan 2023 23:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FB6C433F0;
        Thu,  5 Jan 2023 23:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672961253;
        bh=GDR8HSbg/WmeXUCW15Fyk5FciQGWW6q5WD/eBBW/FfE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S9JXptszgbfUqQNz89o+J7IkN5OYbyTAJGBQa8KQLXt3kl/72xLQ46N04wFtN3xIf
         kUuEN30jh0KJC3KTqPUqPmnjabnu59FKRcKo0nC8GLeNzRIMAWEwxYW6HxwUytuEXJ
         haa9F2l/0uLWIVKoUd8qInAlXC/3ZCsZ2v67fahEF37+VLEy/fbOpcSmZNt8YWPPAm
         yf8uiDKiIwaypFz0hWomJTP2UmqUVuELtd/u90WduCIoL9eo/wBCYdwLMeH4BF0g82
         ybs6wxjHmS3PqxYFjKNxyakGpimeyKdeQHulhZKGYIP7U3//FO2y6XZLk4xZT4JSQe
         S1HJvc5RH4yOQ==
Date:   Thu, 5 Jan 2023 15:27:31 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        kernel test robot <lkp@intel.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sean Anderson <sean.anderson@seco.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Amit Cohen <amcohen@nvidia.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] ethtool: Replace 0-length array with flexible array
Message-ID: <20230105152731.44d4cbfb@kernel.org>
In-Reply-To: <20230105214126.never.757-kees@kernel.org>
References: <20230105214126.never.757-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  5 Jan 2023 13:41:34 -0800 Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct ethtool_rxnfc's
> "rule_locs" 0-length array with a flexible array. Detected with GCC 13,
> using -fstrict-flex-arrays=3:

You gotta CC netdev to get it into patchwork etc.

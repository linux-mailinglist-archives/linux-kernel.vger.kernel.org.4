Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1101A748A76
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 19:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjGERby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 13:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjGERbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 13:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B121BCB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 10:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 73D8661642
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:31:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBD7C433C7;
        Wed,  5 Jul 2023 17:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688578272;
        bh=u0jGPwyF5W+GPgmlKbTrpvhnlr4JFUEeciYVh9XcQiI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZM1qGa1ol/JmRR+D26/xCKiHBx5+S+HxW+KaNVZWIv7MD+R1c0WXbZGArE1wAj3q
         0714IDwKUZokt2phMjqikW70TCadkUBH9+siwwUOnudstPQSzRkSjDPrQve4dpKypC
         H29EUcOkMitHDOGq4uv61EluPKvRZXmuTiVoNQkCzC3/I48ZT3yAO9Wc6XFm/Ifi7I
         2e96sxBtRxPouJ1WSWMGzWJ9ij8ggR5fJQyzxZQIeRm3hDZs3WV5v7pL0+CbMvbBzU
         mZ+CjH7JCn6QNwgWDVXZTe1SZBFtMPHYkYTdAQBfcPuTjBPu9e1FaxF1fYLEQicM2m
         0uIMmhqk1jyPg==
Date:   Wed, 5 Jul 2023 10:31:11 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "M. Haener" <michael.haener@siemens.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <20230705103111.1a7fb88b@kernel.org>
In-Reply-To: <20230704065916.132486-1-michael.haener@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
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

On Tue,  4 Jul 2023 08:59:03 +0200 M. Haener wrote:
> This patch series brings SERDES support for the mv88e632x family.

Not sure if this was said already - you'll need to repost once
Russell's patches are merged. It's a good practice to send patches 
with unmet dependencies as RFC.

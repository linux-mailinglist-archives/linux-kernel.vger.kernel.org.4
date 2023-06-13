Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65FD972E59D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242775AbjFMOW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242670AbjFMOWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:22:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C2B187;
        Tue, 13 Jun 2023 07:22:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F0E361846;
        Tue, 13 Jun 2023 14:22:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66085C433F0;
        Tue, 13 Jun 2023 14:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686666172;
        bh=uaFeJzmCxlczQeNB4wjNR1p0Vrwz4zgph2jIve82GkA=;
        h=From:To:Cc:Subject:Date:From;
        b=ZuISURTvbhSW/SoXlALwokHgjZzX5GB4acwTW7pOvOm1WaVJ/yM9OPv3mQ1wQn1z7
         OGMI/SlP7+KxqnTJUzRHls3cnE0tKBjg57xnBXrTWTR2uuhy8K+/y6xTmxWs2LITc9
         +EzI1xlyUA4Zc5z3L3kU9LyU6r6EBk+iu1mjDa4o+kxiTL6/DgLS4PWjYzTfBbcmTn
         V1k30kU/KwJ8ZOeP6V5+tMiJmJ75luLSSMBrxr+oaCE4Mx0TJWfweH0RcfDZvjMDVE
         9Pm+KV5djfrgBR5SYq3ya90zL5dG93tkzvOExr0cVX+qbH2EkE6wJ6dK0G3LCNRg7L
         7h7sz1ezBqNUQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     linux-wireless@vger.kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Closing down the wireless trees for a summer break?
Date:   Tue, 13 Jun 2023 17:22:47 +0300
Message-ID: <87y1kncuh4.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Me and Johannes are planning to take a longer break from upstream this
summer. To keep things simple my suggestion is that we would official
close wireless and wireless-next trees from June 23rd to August 14th
(approximately).

During that time urgent fixes would need go directly to the net tree.
Patches can keep flowing to the wireless list but the the net
maintainers will follow the list and they'll just apply them to the
net tree directly.

The plan here is that -next patches would have to wait for
wireless-next to open. Luckily the merge window for v6.6 most likely
opens beginning of September[1] so after our break we would have few
weeks to get -next patches ready for v6.6.

And the v6.5 -next patches should be ready by Monday June 19th so that we
have enough time to get them into the tree before we close the trees.

What do people think, would this work? This is the first time we are
doing this so we would like to hear any comments about this, both
negative and positive. You can also reply to me and Johannes privately,
if that's easier.

Kalle

[1] https://phb-crystal-ball.sipsolutions.net/

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

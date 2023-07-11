Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B484674E793
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 08:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGKG5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 02:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGKG5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 02:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117B0188
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 23:57:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99CCE61329
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:57:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 440CBC433C8;
        Tue, 11 Jul 2023 06:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689058626;
        bh=E7aOphHfxIvPiM7w+nvQL4QDcpx4xw+fA9HR0KeNyPM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WPqcmstoqnpoSua2xZYMl8b/Foa3vObKoL/CfIEEGmdcjP41UxX8YjSUGden4yoa1
         OuRcJDjjSw+OVzeef0RSM+OQevEEfQh7nZkMqdh5QryzRfEuA9tsADGad1qgLNb85r
         h2iKYhakcg93jeHbTh5KDuhWnpv8wMjaBJjgPm0BrEuM0V3XCKhCNbirIffDf8HKAS
         ngmp+PADfCp/0hCKBJ9wEOeLqSPoV04XR6W6Hk5NgZ7bYNINvoogurVXLFBk7N3m0t
         ++g5BEc+Nid+wSpUr147Y1YWBvhVfZIU7HLHOws9jiSrZBcp+zg+q1IObiEavc3nPk
         iU21U0XNChTRA==
From:   Kalle Valo <kvalo@kernel.org>
To:     "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Manikanta Pubbisetty <quic_mpubbise@quicinc.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Atheros 11K <ath11k@lists.infradead.org>
Subject: Re: Fwd: ath11k: QCN9074: ce desc not available for wmi command
References: <1326a6e4-758d-3344-d90c-8a126748b034@gmail.com>
        <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info>
Date:   Tue, 11 Jul 2023 09:57:02 +0300
In-Reply-To: <6a0c3aa0-86a8-8c06-81df-2d7085946cf5@leemhuis.info> (Linux
        regression tracking's message of "Mon, 26 Jun 2023 14:49:32 +0200")
Message-ID: <87o7kj7x6p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Linux regression tracking (Thorsten Leemhuis)"
<regressions@leemhuis.info> writes:

> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
>
> Hmmm, there afaics was no real progress and not even a single reply from
> a developer (neither here or in bugzilla) since the issue was reported
> ~10 days ago. :-/
>
> Manikanta, did you maybe just miss that this is caused by change of
> yours (and thus is something you should look into)?

No reply from Manikanta so I think I'll just revert the commit. I have
assigned bug #217536 to me now.

The wireless trees are closed for July but my plan is that I submit the
revert directly to net tree.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

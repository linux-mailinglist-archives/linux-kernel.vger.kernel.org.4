Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC8C6B8B08
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 07:16:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjCNGQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 02:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCNGQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562AD76F62;
        Mon, 13 Mar 2023 23:16:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DFC3B615E0;
        Tue, 14 Mar 2023 06:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52909C433D2;
        Tue, 14 Mar 2023 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678774611;
        bh=M7/IuZ+P1PMkCewwA2wliaQ2VYsdEdrWZtoteqZE3uM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ivZPgp0fzFpzbl1PePSR8pwCNcHXAJaX2T3GyMbcDDOMUbn1DBf9GKrrS8U7gbhsY
         Q53u0QX9HeFEndORdqZyOKJsfkvkQQSYdgWF4V0S+kcnfz/MGX5ufmB7B2JiLmVwRX
         YReLflmWli8DuDTMoNMipfIE+0zuj3iXBCFTliZRQlSrsDXGqzHXHDheKLnK9XiyP8
         Emq20yvt2jZbewrLjx7Zp2Yv3i+lDSzQrqnfaHuNZBS2LZa+SeE/3YND1o9RM4YH3Z
         nyxseywQcU3L8guRB82gWXeAWs1aJrqYsWnn3e7sVOA3B1Ycah3edOBiXEXPzE8hQS
         adS2PC+qUZa6A==
From:   Kalle Valo <kvalo@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: adjust file entries after wifi driver movement
References: <20230314041848.5120-1-lukas.bulwahn@gmail.com>
Date:   Tue, 14 Mar 2023 08:16:45 +0200
In-Reply-To: <20230314041848.5120-1-lukas.bulwahn@gmail.com> (Lukas Bulwahn's
        message of "Tue, 14 Mar 2023 05:18:48 +0100")
Message-ID: <87ttynyi0i.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> writes:

> Commit f79cbc77abde ("wifi: move mac80211_hwsim and virt_wifi to virtual
> directory") and commit 298e50ad8eb8 ("wifi: move raycs, wl3501 and
> rndis_wlan to legacy directory") move remaining wireless drivers into
> subdirectories, but does not adjust the entries in MAINTAINERS.
>
> Hence, ./scripts/get_maintainer.pl --self-test=patterns complains about
> broken references.
>
> Repair these file references in those wireless driver sections.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Oh man, forgot about that. Thanks for fixing this.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

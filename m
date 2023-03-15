Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8CB6BACD1
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbjCOJ6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjCOJ6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:58:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C35DE56782;
        Wed, 15 Mar 2023 02:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52C2761CB0;
        Wed, 15 Mar 2023 09:56:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99320C433EF;
        Wed, 15 Mar 2023 09:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678874197;
        bh=ZsCoH6gXfPOQPU0Q8DkUoSBRwHepwaB8kOQvLfn7Otc=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=RJ7Hjfi+aaL9fNoAu7UhZf/oUnuRaiLlMuaH6h23u40hIleMJEDeYih2GJDvIFmLY
         YtZ7kxZ0KjWBeWcFWko68fvd02SFcXSO9rzIW5gjuCJeZw+WHWfGjN8qdUFgglWdva
         AUTwcspRHq4R7fZuCNhxQcaXG2IcuChha1ftd1SkRpvLvxBJF3BQUALhSVqSCE61Dn
         yfkWTPoq2fTIWvkf2WbvYNtZcQHiDR7LtQ650nVA5EeBHut6IRF72a96Ffedu75GpY
         7tjvjiYEY3etBe0IulBoSIz9f1ez7nPfTy07xXVUP+aTEJwEVTxLu4fzQNb4tkJ5dP
         fmwl7gqYmSFhw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] MAINTAINERS: adjust file entries after wifi driver
 movement
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230314041848.5120-1-lukas.bulwahn@gmail.com>
References: <20230314041848.5120-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <167887419453.6018.12311006787807569673.kvalo@kernel.org>
Date:   Wed, 15 Mar 2023 09:56:36 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

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

Patch applied to wireless-next.git, thanks.

3b50d9a17457 MAINTAINERS: adjust file entries after wifi driver movement

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230314041848.5120-1-lukas.bulwahn@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


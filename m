Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC05E7110B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbjEYQQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236553AbjEYQQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:16:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9A910B;
        Thu, 25 May 2023 09:16:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBF0F646FC;
        Thu, 25 May 2023 16:16:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C07C433EF;
        Thu, 25 May 2023 16:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031383;
        bh=6ZS+JewzrsEl5c4hlSmkFuo3KTaV9uNqyLqzWKxDag0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=qQlniOxqZw95XLB0l9BujNVQJ30cVfKbNMKChcgQEVuvk5K6AGcowwduamUIHOqBS
         dXO1ZSM3w7E+OhxCA4bwltsHW7QlXGtGdYkXJ3ftOGUJaKDXbEWDwDh/zS3LuJOdtS
         tAYN/UW9yVEXvGh8inR9u2rb8U3Ms4c9128p1aDk/pyPa0XwXJB1tkzthYNtUuM3vb
         7bXjqboO87zQ9j86fTLakkM3uH9cqR+s7tDJ6SZ3BHSJjzzOa2c1dlNiwCHtIaGFdf
         mbAfr2p6dLC7OR9vgeQWBMyC0wMDjI930mnCIAmkKvfN2CJzomQmpGMf5IdbW65lLs
         20aQuEE5STIcA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] wifi: atmel: Fix an error handling path in
 atmel_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <1e65f174607a83348034197fa7d603bab10ba4a9.1684569156.git.christophe.jaillet@wanadoo.fr>
References: <1e65f174607a83348034197fa7d603bab10ba4a9.1684569156.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Simon Kelley <simon@thekelleys.org.uk>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503137997.22756.2567638220136601707.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:16:21 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Should atmel_config() fail, some resources need to be released as already
> done in the remove function.
> 
> While at it, remove a useless and erroneous comment. The probe is
> atmel_probe(), not atmel_attach().
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

6b92e4351a29 wifi: atmel: Fix an error handling path in atmel_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1e65f174607a83348034197fa7d603bab10ba4a9.1684569156.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 263B47110AD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235794AbjEYQQH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235665AbjEYQQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:16:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86951AC;
        Thu, 25 May 2023 09:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F74B619F2;
        Thu, 25 May 2023 16:15:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 590A7C433D2;
        Thu, 25 May 2023 16:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031355;
        bh=JNoc179/cAHrp19A11V5S9TV9gSF7FSRJ85UagYYaKs=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=dAZpSutYwggbM2T1+7QbkaFttah7qshM07OjCraDDyOxEb3eknujm3st2d2lmRig5
         fRvNqEJISxRFLJ45C8Uc3VQhZjUf2j0abZpDzZ2NPoYPtDab97QI/mlPQw+LyrbLtj
         icHSUsjuXDWz8P1NwwOYTWv0IsaJcALMqVWNxpK/DNZFn6EJC/kxNob+q9EIRG6FS4
         2+sbE+b0VazZJ1XrL/3JpT/Qmp9fIogFtcnhSGd0OVHLM0587FKUzBQ38Rd/ZumHRh
         pjZPlP7anWun0laWx0tyv31y/Gotl8s55CVCt1VrejQpOkd3XiMFMx6/3zMxJqH09R
         eIiqaINTsSiKg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: wifi: orinoco: Fix an error handling path in orinoco_cs_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <e24735ce4d82901d5f7ea08419eea53bfdde3d65.1684568286.git.christophe.jaillet@wanadoo.fr>
References: <e24735ce4d82901d5f7ea08419eea53bfdde3d65.1684568286.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503135247.22756.3646215071088340877.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:15:54 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> wrote:

> Should orinoco_cs_config() fail, some resources need to be released as
> already done in the remove function.
> 
> While at it, remove a useless and erroneous comment. The probe is
> orinoco_cs_probe(), not orinoco_cs_attach().
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Patch applied to wireless-next.git, thanks.

67a81d911c01 wifi: orinoco: Fix an error handling path in orinoco_cs_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/e24735ce4d82901d5f7ea08419eea53bfdde3d65.1684568286.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E52637110BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbjEYQSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbjEYQRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:17:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784DFE43;
        Thu, 25 May 2023 09:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0060B64768;
        Thu, 25 May 2023 16:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B06DC433D2;
        Thu, 25 May 2023 16:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685031469;
        bh=VicTrJ2ntuwnnu4pbUhx/YvsuZlVA4KOAzl8vhAzKbM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=pTjBla7PsTgrYjSSKANIBu0STb/AChcsymUF6Z0bOspy5WMUDGFaD+gVPAcja4KVX
         cx7cAsL2jcd01YCWce2g4Wu0uK/+0VXzCKLthCk6nXM59pxrJRO/KXZg7A0dV1zJVH
         L6i0M0mNqe/F+oISfg8e0PiayFzT+Bjgaaqe+m4NvVDVqKD7pSnX8yAuInKneMiMMq
         x0PlNRopDI1Dg9ARwqrRiq2S6tfRjlMWyjP6ev0JrlA/YVW3DKogIo9i74GkjhLjpC
         5O05XrDuvUDlaFUNUYtebgfhugeilfo62+kSZQ51M/6WCq8UphnR3k8NXtE7gmauOS
         cRSrnW23HSgTQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [wireless] wifi: ray_cs: Fix an error handling path in
 ray_probe()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <8c544d18084f8b37dd108e844f7e79e85ff708ff.1684570373.git.christophe.jaillet@wanadoo.fr>
References: <8c544d18084f8b37dd108e844f7e79e85ff708ff.1684570373.git.christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168503146551.22756.9737707686556677922.kvalo@kernel.org>
Date:   Thu, 25 May 2023 16:17:47 +0000 (UTC)
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

> Should ray_config() fail, some resources need to be released as already
> done in the remove function.
> 
> While at it, remove a useless and erroneous comment. The probe is
> ray_probe(), not ray_attach().
> 
> Fixes: 15b99ac17295 ("[PATCH] pcmcia: add return value to _config() functions")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Patch applied to wireless-next.git, thanks.

4f8d66a9fb2e wifi: ray_cs: Fix an error handling path in ray_probe()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/8c544d18084f8b37dd108e844f7e79e85ff708ff.1684570373.git.christophe.jaillet@wanadoo.fr/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


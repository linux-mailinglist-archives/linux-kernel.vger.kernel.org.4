Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC46D2389
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 17:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232829AbjCaPFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 11:05:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjCaPFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 11:05:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613A220DB7;
        Fri, 31 Mar 2023 08:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5FE72B8304B;
        Fri, 31 Mar 2023 15:04:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43034C433D2;
        Fri, 31 Mar 2023 15:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680275092;
        bh=BvBm9fUn3QNIzLXWNQgC4UmwP/EmRcOe56OegwFsU7k=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=FdGRvzYXJHRkgIk51cxHb8kxLJo6lfM3dR2Z8pDm7el0FOYkVI5o2MLTWscPmcR6S
         m0V3MjI4wqu4DXAcLbw/FV2+m59V+HTt1IAF9KCWx87g6cE7NJ3hoVZTpz9Es0O/+4
         2foJPx6k8ypDJu5G6JWtljAz75FGehg7UnGN5qxWzdJ/QqvpNpsQKPqqkovYmHJI6g
         dNU4GROVKkwpP4klSOMzMAE/1BZq6Yff2gt0RvvDXClBCt0j0qfmrQl/M3MooV2u+n
         IeluVhxAPEUPUq/KEW1mJt+tnzuLRsZwvUvd/sMppZw2AW7rD6cbGHyujYtDIAJCll
         1tPU+K1sBCblA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] bcma: Use of_address_to_resource()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20230319163159.225773-1-robh@kernel.org>
References: <20230319163159.225773-1-robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <168027508728.20708.3591527572162084381.kvalo@kernel.org>
Date:   Fri, 31 Mar 2023 15:04:51 +0000 (UTC)
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Herring <robh@kernel.org> wrote:

> Replace of_get_address() and of_translate_address() calls with single
> call to of_address_to_resource().
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Patch applied to wireless-next.git, thanks.

767d011dc39d bcma: Use of_address_to_resource()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20230319163159.225773-1-robh@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


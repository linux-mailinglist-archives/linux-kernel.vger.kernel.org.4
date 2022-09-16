Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19055BB124
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 18:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIPQh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 12:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIPQhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 12:37:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E199088DF2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 09:37:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8AF1B82865
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 16:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4795C433C1;
        Fri, 16 Sep 2022 16:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663346241;
        bh=vLKW3Gq6muuTLKVz5phR18jx4OuzQbbEePlcPKmt4oo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sj+xbk4MXxrHXdhICPcKsreC2faYMsGk+DvIEUmZ9rbxopWBVIaSfPMVS4MB3z0fX
         bwrOfcnvn2C8tK8+O5zANRFoMd9TfsPZ29Vy8mcAWkIihafPE0Wqe/uHR1Ozko0/ED
         VKEPQfi+y3MYSLYh5YzaIMKN3a15EjKt44aG2hcNfm+TwQJTiQIcP5v+9QOsBqb2QB
         01fjiK8lJ1XRuXHnJ+jpHXlmuycYsYLMmCGWRRuMBIO2UejhRsidKd5T2+TgUlEuTw
         p8Futp9m2xy4jDbtd6JWYYeVDUo2JwXjHEZvZ04qu2y3uSoOsrLnxtdbO+TlFEWjdh
         TVLGslW9yRcQg==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH] mm/damon: return void from damon_set_schemes()
Date:   Fri, 16 Sep 2022 16:37:19 +0000
Message-Id: <20220916163719.17577-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663341635-12675-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Sep 2022 23:20:35 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> There is no point in returning an int from damon_set_schemes().
> It always returns 0 which is meaningless for the caller, so
> change it to return void directly.
> 
> Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>

Reviewed-by: SeongJae Park <sj@kernel.org>


Thanks,
SJ

[...]

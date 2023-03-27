Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EE716CA873
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjC0PBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232986AbjC0PBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:01:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4943469E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:01:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65EC7B81072
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 15:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA77BC4339C;
        Mon, 27 Mar 2023 15:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679929298;
        bh=NjhCMaPewoICrJh9Z9618eiVF0koMBRwUG8Wrh6b/gY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kd2yaAbktCYb2s3KEbaST0VeXK9m6OGl56xSpU5tv8a+zNM6qSlgGgF8NwUIch94C
         fdA0cGMqrRE6cOATUEVNBVV/0WjYLfKpTDBuKrSd6QqoMpDmoxQ+EOtpNekQA/BROK
         LgX20vujq6eN3PtXj7Xc7HXCG/vpy4eEgZUN1OL2cLI6pX8e8w/4ry8w6oS75l9+Yv
         irFfH6OqL4Sm7BUwjCwbP0wbwgUUxkKiJlTkfbA7UPN6rvTCJcP/WhGc4Tpp1r3Yjv
         NrjTSl0Ww9vzzbki8fjkog3Iwhqn8HkdeuUamLiJc63GjSmzGgHNMxm75yh/jglmXj
         YaWH/pI/VVJqQ==
From:   Will Deacon <will@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>, xueshuai@linux.alibaba.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drivers/perf: Use devm_platform_get_and_ioremap_resource()
Date:   Mon, 27 Mar 2023 16:01:16 +0100
Message-Id: <167992615002.3835148.5719003832525419389.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230216063403.9753-1-yang.lee@linux.alibaba.com>
References: <20230216063403.9753-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Feb 2023 14:34:03 +0800, Yang Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied to will (for-next/perf), thanks!

[1/1] drivers/perf: Use devm_platform_get_and_ioremap_resource()
      https://git.kernel.org/will/c/bc12f344d5de

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

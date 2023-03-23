Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119D46C6C02
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjCWPOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbjCWPOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:14:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E2F3C2B;
        Thu, 23 Mar 2023 08:14:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E751962799;
        Thu, 23 Mar 2023 15:14:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AF3C433EF;
        Thu, 23 Mar 2023 15:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679584483;
        bh=FS7Qmlv48Y/JVCUmH6OOtLmuiOQYPg6s33kW0vJpsYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4YbO3/841/AetiCUA0KzSlOCPaCv/pYCakilNwjt+CuSEDyxNda0kv3VpXp2aMDA
         yTxkI+WM0JcIB5iiWqOMzJFcXWzoBahaySxE25SplJkECVWm1h50dqVTN/cFu9eN3x
         PXoDK7tFqmD5FVtIp4Aect5fSd3Mo3hdBIZuQM0TssmcJBTKB1B1fC1hPIrdf1Ie9W
         I+mmjwU9+GArlNL2G5/BtpWcy+AxD+NM3oK91eOgDOl4NXbOwwQDLI6Rks2soMf98u
         D+q6aWmr2egDmVzbLs5NqXxyTe97jT0gMxfs+kDFpVQ5ZSH2L+NFNlcUHVI6O5+ef+
         Zyuh4w3k/dDPA==
Date:   Thu, 23 Mar 2023 15:14:38 +0000
From:   Lee Jones <lee@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     ChiYuan Huang <cy_huang@richtek.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the leds-lj tree
Message-ID: <20230323151438.GO2673958@google.com>
References: <20230323142904.1a136fdf@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230323142904.1a136fdf@canb.auug.org.au>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Mar 2023, Stephen Rothwell wrote:

> Hi all,
>
> After merging the leds-lj tree, today's linux-next build (htmldocs)
> produced these warnings:
>
> Documentation/leds/leds-mt6370-rgb.rst: WARNING: document isn't included in any toctree
> Documentation/leds/leds-mt6370-rgb.rst:39: WARNING: Literal block ends without a blank line; unexpected unindent.
> Documentation/leds/leds-mt6370-rgb.rst:41: WARNING: Line block ends without a blank line.
> Documentation/leds/leds-mt6370-rgb.rst:46: ERROR: Unexpected indentation.
> Documentation/leds/leds-mt6370-rgb.rst:44: WARNING: Inline substitution_reference start-string without end-string.
> Documentation/leds/leds-mt6370-rgb.rst:50: WARNING: Literal block expected; none found.

What wizardry is this?

> Introduced by commit
>
>   4ba9df04b7ac ("docs: leds: Add MT6370 RGB LED pattern document")

There is a fixing set on the list that I need to review.

Please bear with me.

--
Lee Jones [李琼斯]

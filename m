Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C056F2F01
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 09:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjEAHMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 03:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjEAHME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 03:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928EAE79
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 00:12:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E402616C4
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 07:12:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E98C433D2;
        Mon,  1 May 2023 07:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682925122;
        bh=thfg1C6UTynhMv/UPp/PbhaX4JB2Y4gtnhvhX/6mCwU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=G3Z0m3RubgC6d2GugIt9vwZRjUzBFSUtAxxdXEVntPwYS4//jFeCDEqQddaD93KrR
         3GHZWaDfwwXknnrK/+llxFlTWKtHi+dsALKbdfwL4xLIIhiawOcZxjpSqsztUIXl+T
         t00/mej2Ph9B0+XG6CuKd34JIekyGR0RRFrv/X00tsi+HJYvdolbmrK1aB7rRI5p3Z
         RuGOFQ8PWCMqBG81/52AnGDLx6WUsvqv5813n0mr4bVAM+cfYmIsJ7G3m1j0IGTEp/
         LDgc2nDSofB3jOmvUdWRKWDQp9XcHta81iKtiqoGDTNQlSaTMmq2u709STGmGMqwak
         rwHfvWmtbVdFw==
Message-ID: <aad49eef-7499-bc78-12e2-24fe275d2ade@kernel.org>
Date:   Mon, 1 May 2023 09:11:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 2/2] dt-bindings: gnss: Add U-Blox Zed-F9
Content-Language: en-US
To:     alison@she-devel.com, johan@kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org, achaiken@aurora.tech
References: <20230430174820.748119-1-alison@she-devel.com>
 <20230430174820.748119-3-alison@she-devel.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230430174820.748119-3-alison@she-devel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2023 19:48, alison@she-devel.com wrote:
> From: Alison Chaiken <achaiken@aurora.tech>
> 
> Add support for the U-Blox Zed-F9P GNSS device.
> 
> Signed-off-by: Alison Chaiken <achaiken@aurora.tech>

No improvements, so the same comment:

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested.
Please resend without skipping necessary entries.

Best regards,
Krzysztof


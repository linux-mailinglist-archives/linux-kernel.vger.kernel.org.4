Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0F03603711
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 02:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbiJSAXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 20:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbiJSAXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 20:23:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BBED7E37;
        Tue, 18 Oct 2022 17:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CF2161737;
        Wed, 19 Oct 2022 00:23:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDBFC433C1;
        Wed, 19 Oct 2022 00:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666139001;
        bh=oASso4BIYNm9JMmqjfxz8f0HQ79E5O2lTIOHLXPL0F0=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=PDHGHS97RFLJsZTpkxwvWWCTrsmWHx4z61HucmdeKqSlwVMSnwZOdd25TOvQ6SbGh
         Bwd0Uy/rt+3/Juw8gVXfku90/lBsoxdZjrkLEVZ9LgoIJT/IM7wNYPexqa0nIDMRqx
         QcC6n4jxWysUwYy5bdNhisjSS3ehTtue50p4PWn4j9gfRyljFYP+8xdmgKQ9E9/Wo/
         up2bno5VVqfQBZ9SEXTLfbxgn6msorPshxoTpWFH5wWbtdhIYsKp8n0Rdaj+OUZOzR
         JMUFi8Uo7/LEMEKvQGYyZ3TusYgzDQelkg/kKyP5+i1q5bgs+QjQm6Lmgvq1Y5kGNq
         wSTybumv5qSUw==
Message-ID: <7443664d-6be2-6b3c-e211-d23636d66dfc@kernel.org>
Date:   Tue, 18 Oct 2022 17:23:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] arc: update config files
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vineet Gupta <vgupta@kernel.org>,
        linux-snps-arc@lists.infradead.org
References: <20220929101421.31590-1-lukas.bulwahn@gmail.com>
Content-Language: en-US
From:   Vineet Gupta <vgupta@kernel.org>
In-Reply-To: <20220929101421.31590-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/29/22 03:14, Lukas Bulwahn wrote:
> Clean up config files by:
>    - removing configs that were deleted in the past
>    - removing configs not in tree and without recently pending patches
>    - adding new configs that are replacements for old configs in the file
>
> For some detailed information, see Link.
>
> Link:https://lore.kernel.org/kernel-janitors/20220929090645.1389-1-lukas.bulwahn@gmail.com/
>
> Signed-off-by: Lukas Bulwahn<lukas.bulwahn@gmail.com>

Thx for the fix. Added to for-curr.

-Vineet

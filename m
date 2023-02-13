Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C04694C39
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 17:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjBMQRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 11:17:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjBMQRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 11:17:01 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A571ADEA
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 08:17:00 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 723428562B;
        Mon, 13 Feb 2023 17:16:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1676305019;
        bh=BKIo3Vf9dIwGtqVPAbNt3QosdZas/pJkFbDSPtQs+Ts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cNu9EQj0BaWbFPcvqPFd+eJZTyFzPN3zeql2lO/cE1ORMudStIF/hlEgbh5zEJ4+X
         qRG4qNAHa8ZF+YizOXHBmqoguoDnw0OY/83O/7z35Wts3r2vay3RbvK1PoJCAzItUk
         PRaabjigJDy0LyslBam3aBpRhHGi25eJVVlbGQhobSpVD7M7nDeEC0x6P0+ja/uf/M
         MGTlkSt5oHc54IPcoC1Njvz/w4R2IWwt0uc+qp2fSBwf06NbBo9+Qcptx2z36vf6k9
         OiF1fuRymhalHczslSyvCFX2L4jn2P38lIYGrKjhRjjY3f1ey5twmiJ7sYfnEtW3K1
         iHc4SPpQE4sTw==
Message-ID: <ee7d0f98-3ae9-7e66-785e-65c9e11a7232@denx.de>
Date:   Mon, 13 Feb 2023 17:16:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/6] Revert "regulator: pca9450: Add SD_VSEL GPIO for
 LDO5"
Content-Language: en-US
To:     Frieder Schrempf <frieder@fris.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Per-Daniel Olsson <perdo@axis.com>,
        Rickard x Andersson <rickaran@axis.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
References: <20230213155833.1644366-1-frieder@fris.de>
 <20230213155833.1644366-4-frieder@fris.de>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230213155833.1644366-4-frieder@fris.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/13/23 16:58, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This reverts commit 8c67a11bae889f51fe5054364c3c789dfae3ad73.
> 
> It turns out that all boards using the PCA9450 actually have the
> SD_VSEL input conencted to the VSELECT signal of the SoCs SD/MMC

'connected' , typo .

btw would it make sense to squash 3..5 patches into a single patch ?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DD6163AA3E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 14:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiK1N6Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 08:58:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiK1N5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 08:57:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0622AE8D;
        Mon, 28 Nov 2022 05:57:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09F6BB80D9E;
        Mon, 28 Nov 2022 13:57:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A17CC433D6;
        Mon, 28 Nov 2022 13:57:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669643859;
        bh=3iAjCz8Po6UxsVaFN66Kyn/1QE3Uxx8DWu4pZB3HbEM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=H5FhmdZdWirC9HOnQW/3HbTLnGxregpR1YVsc6aDopEp2rolsPDSrPjxv4dZmBYuF
         3z2C0shBk8SBfpgATE0mBtzB8GD5Ju0aCEr6NgVGOisvmjGA+q/htKLvSEOnsl/39k
         ewgsG0FMjTSw+B2tVwHL3gHsB6lTEqNzRQHc5Gffn33nJ7SBIHpMxke9AcR0xBVnCe
         bJrpvvtYa8+aJkfp/0LGTWj+pLSOQhD6FPGZCH7CtmfcYmWh8Z5jGGuoI/nWh6cVh4
         dEgeKbvhnHIV0LJ3cUNXqHcLOnfImQNaqCL2WvvtL74TlFItTWCrqW3USArtLM6uwJ
         QPorcHjt1TiOg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: b43: remove reference to removed config B43_PCMCIA
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221122131248.23738-1-lukas.bulwahn@gmail.com>
References: <20221122131248.23738-1-lukas.bulwahn@gmail.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166964385630.4701.15876061507595016726.kvalo@kernel.org>
Date:   Mon, 28 Nov 2022 13:57:38 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 399500da18f7 ("ssb: pick PCMCIA host code support from b43 driver")
> removes the config B43_PCMCIA.
> 
> Clean up the last reference to this removed config B43_PCMCIA in the
> b43_print_driverinfo() function.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Patch applied to wireless-next.git, thanks.

3ca7f0b2523c wifi: b43: remove reference to removed config B43_PCMCIA

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221122131248.23738-1-lukas.bulwahn@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


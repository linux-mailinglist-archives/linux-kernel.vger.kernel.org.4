Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86E06906EF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbjBILWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjBILVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:21:14 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E475A241D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:18:06 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4D5708572D;
        Thu,  9 Feb 2023 12:17:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1675941452;
        bh=q67GX9sZXA2ZZiVpedSbRNrWSOAhsd1h3b2UCkP8KN4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oDKft0kZ9OocFX8WS/+kYY+sqeuKn2V2ikH7BILKBTLNcL4JDNjq6FuMADVkHcLKN
         I/BNSF9eiOuDj6ihg/icXHeEqBmq5HvrAYBhV6BThFOL0I3uRsTw11Ps1IIStCAtbl
         dw3c1pEv2Wd8Rw0Ox3MOgFxGEiGiYTQIO+SaMse+xnZDXKOjKvaTUlKVXqDOHXOj6O
         PNV2l3G3ak130US0eu5H0lSOOwo0oioxRrAkVmuJN4n5MtJz/i0+dq+0u6Aq7ZtZsQ
         CaKfFmV41l382QYNSUeLgnqWsinoAdS/M70GzPFf2GC7nWTOUHRlE3szLzon2JfTNB
         Ku/4e+TY7IbEw==
Message-ID: <f98e6367-ecf9-4b3b-1ae4-4ade0679d06f@denx.de>
Date:   Thu, 9 Feb 2023 12:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V2 1/2] mfd: da9062: Remove IRQ requirement
Content-Language: en-US
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Lee Jones <lee@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, kernel@dh-electronics.com,
        linux-kernel@vger.kernel.org
References: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230209105144.9351-1-cniedermaier@dh-electronics.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/23 11:51, Christoph Niedermaier wrote:
> This patch removes the requirement for an IRQ, because for the core
> functionality IRQ isn't needed. So this makes the DA9061/62 chip
> useable for designs which haven't connected the IRQ pin.
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> ---
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: kernel@dh-electronics.com
> Cc: linux-kernel@vger.kernel.org
> To: linux-arm-kernel@lists.infradead.org
> ---
> V2: - Rebase on current next 20230209
>      - Add Lee Jones to Cc list

Reviewed-by: Marek Vasut <marex@denx.de>

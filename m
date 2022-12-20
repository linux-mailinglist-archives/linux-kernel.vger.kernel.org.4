Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A77765220A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiLTOI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:08:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiLTOI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:08:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CC5DF95;
        Tue, 20 Dec 2022 06:08:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 51E7AB81339;
        Tue, 20 Dec 2022 14:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9869C433D2;
        Tue, 20 Dec 2022 14:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671545304;
        bh=TKstLQD0PQuncfO+Ytp0bIaVnXlc1sa3aOMQKwadUvg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rs3h9OonrRmvMOtp2JFH/C1q0H+h8vLjFDKlhOTkiyDFI1V2H4+y3Ndf82gsHttWp
         VYn0jIEfiB4e2RhZFbxh2PmimEiWzTlvRUAFk8uiRfpjsFbqyYzL41iIgwEjOFX9cm
         GugCKn5do4Ol1fQI/yd64aL932SBeGEJfWMzSmsfsDTiBrMOLYQlZtoK/zsg4diWZe
         MhThsrDm9GtGbGFn2hx3j5yjwDS1XLHTnHy140rYH1yDs4CoDc4FzoyQ1B82Htaxyf
         1dqNSCjafy5/fkp4RWefa2y8wp/0nZQM0hv5t2WBGCvBZVYoduWEJ4GwOzX8URAXyN
         95QDrBopS4fyA==
Message-ID: <2828ed41-895d-a4ee-5511-b1246ff76ec0@kernel.org>
Date:   Tue, 20 Dec 2022 15:08:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 2/7] spi: cadence: Change dt-bindings documentation for
 Cadence XSPI controller
Content-Language: en-US
To:     Witold Sadowski <wsadowski@marvell.com>, broonie@kernel.org
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jpawar@cadence.com,
        pthombar@cadence.com, konrad@cadence.com, wbartczak@marvell.com,
        wzmuda@marvell.com
References: <20221219144254.20883-1-wsadowski@marvell.com>
 <20221219144254.20883-3-wsadowski@marvell.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20221219144254.20883-3-wsadowski@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/12/2022 15:42, Witold Sadowski wrote:
> Interrupt property is not mandatory.
> Driver will switch into pooling mode if property
> will not be avalible.

1. Use subject prefixes matching the subsystem (git log --oneline -- ...).

2. Please use scripts/get_maintainers.pl to get a list of necessary
people and lists to CC.  It might happen, that command when run on an
older kernel, gives you outdated entries.  Therefore please be sure you
base your patches on recent Linux kernel.

3. Run also spellcheck.

Best regards,
Krzysztof


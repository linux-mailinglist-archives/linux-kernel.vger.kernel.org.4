Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566AE73250A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 04:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbjFPCIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 22:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240062AbjFPCIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 22:08:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F5F296E;
        Thu, 15 Jun 2023 19:08:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 09AFE61C7B;
        Fri, 16 Jun 2023 02:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A383BC433C8;
        Fri, 16 Jun 2023 02:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686881325;
        bh=6wd1dENbjJGqsMvXOT3ybKeD4330B+8abgekXrXfRCw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m0wrhpfohPopHFJTcXhWcC7h/4hplsO/dIete8rbVvw7W2ShFCCkNNZxQiUJkGX/0
         HrJ6aDu3LtzygncqD3blyKCpgYONLIjdMLDVMNhcqmES3Y8tpNL1aFJo/n5Ukd6+uK
         k/ntHSLHhfIl1LT/i2eDN5/nPfwafIiMdZWHeafpusK66yo8Tdxf1xqnpUfaFcpw+P
         khO++vDGsGoXZG2JjDyFC8GtUT+65B94hccLMSBd1tUzNawMtLutdL0s85vNrUzUmg
         BkhKRyzu1zumB3wfOaTZZWRTOlj6Pms6NppWDBROWuPwuTHeZSzvLuWDzhM8MUBQj7
         xztQ0jciBgozA==
Message-ID: <347be649-ab06-f12d-cfab-8576e6409426@kernel.org>
Date:   Fri, 16 Jun 2023 11:08:43 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230614173633.2430653-1-robh@kernel.org>
 <20230614173633.2430653-2-robh@kernel.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230614173633.2430653-2-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/15/23 02:36, Rob Herring wrote:
> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
> allyesconfig/allmodconfig builds. There's a dependency on MIPS headers,
> so other arches can't be enabled.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied this and 1/2 to for-6.5. Thanks !

-- 
Damien Le Moal
Western Digital Research


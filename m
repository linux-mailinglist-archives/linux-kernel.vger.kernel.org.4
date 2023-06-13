Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EDA72D8A1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 06:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbjFMEb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 00:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239923AbjFMEbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 00:31:33 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3E564ECA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 21:28:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 58BD71FB;
        Mon, 12 Jun 2023 21:28:48 -0700 (PDT)
Received: from [10.162.42.9] (unknown [10.162.42.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 16A713F587;
        Mon, 12 Jun 2023 21:27:59 -0700 (PDT)
Message-ID: <34360cc9-b2ef-ec44-db93-b93b224fe1cb@arm.com>
Date:   Tue, 13 Jun 2023 09:57:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V2 00/14] arm64/sysreg: Convert TRBE registers to
 automatic generation
Content-Language: en-US
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, broonie@kernel.org,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20230602062552.565992-1-anshuman.khandual@arm.com>
 <ZIISaXnrhDtauY2G@arm.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ZIISaXnrhDtauY2G@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/8/23 23:09, Catalin Marinas wrote:
> Hi Anshuman,
> 
> On Fri, Jun 02, 2023 at 11:55:38AM +0530, Anshuman Khandual wrote:
>> Changes in V2:
>>
>> - Renamed each individual TRBE register fields as per auto-gen tools
>> - Converted each individual TRBE registers as per auto-gen tools
>> - Added new register fields as per DDI0601 2023-03
> 
> Mark had some comments about using Enum for some bitfields. While not
> essential, it would be nice to have those fixed. It's probably easier to
> do an incremental patch fixing those, so please post one (or repost the
> whole series, whatever is easier for you).

Sure, will fold in those suggested changes and re-post the series soon.

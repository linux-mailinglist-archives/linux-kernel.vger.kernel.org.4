Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF946EE106
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbjDYLYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233451AbjDYLYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:24:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B7F29D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 04:24:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 161EF4B3;
        Tue, 25 Apr 2023 04:24:50 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 59D923F5A1;
        Tue, 25 Apr 2023 04:24:04 -0700 (PDT)
Date:   Tue, 25 Apr 2023 12:24:01 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, andersson@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        shawnguo@kernel.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        soc@kernel.org, wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>, liuyonglong@huawei.com,
        huangdaode@huawei.com
Subject: Re: [PATCH] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Message-ID: <20230425112401.d4oggwwrzdgnnss7@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <faa32ce0-00cd-d24c-f505-beb637904af1@kernel.org>
 <edef5e7f-2d5c-d79a-1ac6-286299fb0f8c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <edef5e7f-2d5c-d79a-1ac6-286299fb0f8c@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 11:16:32AM +0800, lihuisong (C) wrote:
> Hi Krzysztof,
> Thanks for your review. My reply is as follows.
> 
> 在 2023/4/24 16:42, Krzysztof Kozlowski 写道:

[...]

> > Maybe leave a comment that all these are ACPI-only and are not allowed
> > in DT usage. Without bindings we are not going to review them. OTOH, I
> > think we don't have a process for such cases in general.
> Thanks for your suggestion. will add it.

Please look at my response and continue the discussion as why _CRS can't
be used[1] before you add any DT bindings. I would prefer to avoid any
DSD style properties especially if it is used only in ACPI.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/all/20230425103040.znv66k364ant6klq@bogus/

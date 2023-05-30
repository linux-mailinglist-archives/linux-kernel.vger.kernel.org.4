Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBAF7158F2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjE3Inc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjE3Ina (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:43:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD64BB2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:43:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C80D3AB6;
        Tue, 30 May 2023 01:44:13 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D600F3F663;
        Tue, 30 May 2023 01:43:26 -0700 (PDT)
Date:   Tue, 30 May 2023 09:43:24 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, shawnguo@kernel.org,
        arnd@arndb.de, krzk@kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, soc@kernel.org,
        wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        liuyonglong@huawei.com
Subject: Re: [PATCH v2 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Message-ID: <20230530084324.m47xvpqrga6tegpd@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230522072211.8894-1-lihuisong@huawei.com>
 <20230522072211.8894-2-lihuisong@huawei.com>
 <20230523093922.f2y4wrz3vkzi7kmw@bogus>
 <b29eab0c-4084-0e91-3e31-7f7c264ad629@huawei.com>
 <20230525073539.waaa7wpudohullcg@bogus>
 <5e0d81c8-5f52-82e5-5509-785e87a9a17e@huawei.com>
 <7852a2b4-b601-f4e8-bc5f-7b1bc9d9dc69@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7852a2b4-b601-f4e8-bc5f-7b1bc9d9dc69@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 10:53:38AM +0800, lihuisong (C) wrote:
> Hi Sudeep,
> 
> 
> 在 2023/5/25 16:12, lihuisong (C) 写道:
> > 
> > 在 2023/5/25 15:35, Sudeep Holla 写道:
> > > On Thu, May 25, 2023 at 10:41:51AM +0800, lihuisong (C) wrote:
> > > > Hi Sudeep,
> > > > 
> > > > Here, the interface is used to determine whether a port is in use or
> > > > enabled.
> > > > If we just use 'status', it cannot inidicates its own meaning by name.
> > > > What do you think?
> > > > 
> > > How about "port_status" or "port-status" ?
> > The meaning of this status is a little board.
> > How about 'enable'? just a read-only entry.
> > 
> > 
> "using_status" --> "enable" ? What do you think?
> Its original purpose was to determine whether a port is in use or enabled.
>

That's fine. The main point I was trying to make is plain "status" or
"using_status" is prone to conflict as you have ports, lanes, ...etc.
Adding "port_" to the name whatever you choose is better.

-- 
Regards,
Sudeep

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FE8710689
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 09:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbjEYHhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 03:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjEYHgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 03:36:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A876210D2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 00:35:44 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A34F1042;
        Thu, 25 May 2023 00:36:29 -0700 (PDT)
Received: from bogus (unknown [10.57.96.86])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD4CD3F762;
        Thu, 25 May 2023 00:35:41 -0700 (PDT)
Date:   Thu, 25 May 2023 08:35:39 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     "lihuisong (C)" <lihuisong@huawei.com>
Cc:     andersson@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, shawnguo@kernel.org,
        arnd@arndb.de, krzk@kernel.org, linux-kernel@vger.kernel.org,
        soc@kernel.org, wanghuiqiang@huawei.com, tanxiaofei@huawei.com,
        Sudeep Holla <sudeep.holla@arm.com>, liuyonglong@huawei.com
Subject: Re: [PATCH v2 1/2] soc: hisilicon: Support HCCS driver on Kunpeng SoC
Message-ID: <20230525073539.waaa7wpudohullcg@bogus>
References: <20230424073020.4039-1-lihuisong@huawei.com>
 <20230522072211.8894-1-lihuisong@huawei.com>
 <20230522072211.8894-2-lihuisong@huawei.com>
 <20230523093922.f2y4wrz3vkzi7kmw@bogus>
 <b29eab0c-4084-0e91-3e31-7f7c264ad629@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29eab0c-4084-0e91-3e31-7f7c264ad629@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:41:51AM +0800, lihuisong (C) wrote:
> Hi Sudeep,
> 
> Here, the interface is used to determine whether a port is in use or
> enabled.
> If we just use 'status', it cannot inidicates its own meaning by name.
> What do you think?
> 

How about "port_status" or "port-status" ?

-- 
Regards,
Sudeep

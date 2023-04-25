Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC84D6EE41F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 16:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbjDYOmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 10:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234254AbjDYOmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 10:42:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F2DE349DF;
        Tue, 25 Apr 2023 07:41:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3E534B3;
        Tue, 25 Apr 2023 07:42:41 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 035533F587;
        Tue, 25 Apr 2023 07:41:55 -0700 (PDT)
Date:   Tue, 25 Apr 2023 15:41:53 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Huisong Li <lihuisong@huawei.com>, rafael@kernel.org
Cc:     robbiek@xsightlabs.com, linux-acpi@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-kernel@vger.kernel.org, rafael.j.wysocki@intel.com,
        wanghuiqiang@huawei.com, zhangzekun11@huawei.com,
        wangxiongfeng2@huawei.com, tanxiaofei@huawei.com,
        guohanjun@huawei.com, wangkefeng.wang@huawei.com,
        huangdaode@huawei.com
Subject: Re: [PATCH v3 0/2] mailbox: pcc: Support platform notification for
 type4 and shared interrupt
Message-ID: <20230425144153.czk3avypfmxfjdot@bogus>
References: <20221016034043.52227-1-lihuisong@huawei.com>
 <20230423110335.2679-1-lihuisong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423110335.2679-1-lihuisong@huawei.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On Sun, Apr 23, 2023 at 07:03:33PM +0800, Huisong Li wrote:
> PCC supports processing platform notification for slave subspaces and
> shared interrupt for multiple subspaces.

Can you please take this via your tree ? It has been reviewed and
tested now. If it is too late for this merge window, are you happy to
pick it up if posted at -rc1 for next merge window ?

-- 
Regards,
Sudeep

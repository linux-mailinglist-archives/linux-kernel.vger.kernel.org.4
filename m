Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC1873D043
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbjFYLJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbjFYLJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:09:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D2AB8F;
        Sun, 25 Jun 2023 04:09:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E04231FB;
        Sun, 25 Jun 2023 04:09:53 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5CA33F663;
        Sun, 25 Jun 2023 04:09:00 -0700 (PDT)
Message-ID: <6c5f8eef-3373-0012-e811-3b1eb8930d22@arm.com>
Date:   Sun, 25 Jun 2023 16:39:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V13 03/10] arm64/perf: Add branch stack support in struct
 arm_pmu
Content-Language: en-US
To:     Namhyung Kim <namhyung@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org
References: <20230622065351.1092893-1-anshuman.khandual@arm.com>
 <20230622065351.1092893-4-anshuman.khandual@arm.com>
 <CAM9d7cgTyowSHTydOUprPMn80POvbtYetrHTA_eU-wL0B_Cr8g@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAM9d7cgTyowSHTydOUprPMn80POvbtYetrHTA_eU-wL0B_Cr8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/24/23 04:51, Namhyung Kim wrote:
> Hello,
> 
> On Wed, Jun 21, 2023 at 11:55 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> This updates 'struct arm_pmu' for branch stack sampling support being added
>> later. This adds an element 'reg_trbidr' to capture BRBE attribute details.
> reg_brbidr, right?

Yes, it's a typo indeed.

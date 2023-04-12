Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A126DEE1C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbjDLIkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjDLIkC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:40:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F3A077AB8;
        Wed, 12 Apr 2023 01:39:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56691D75;
        Wed, 12 Apr 2023 01:39:12 -0700 (PDT)
Received: from bogus (unknown [10.57.57.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10F8F3F587;
        Wed, 12 Apr 2023 01:38:25 -0700 (PDT)
Date:   Wed, 12 Apr 2023 09:37:23 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, lkp@intel.com
Subject: Re: [PATCH v2 0/2] Allow parameter in smc/hvc calls
Message-ID: <20230412083723.r4vnkl3c7ykauzps@bogus>
References: <20230409181918.29270-1-quic_nkela@quicinc.com>
 <20230410182058.8949-1-quic_nkela@quicinc.com>
 <20230411130136.lkblyfg3jaeitzrt@bogus>
 <ef3ae792-8900-d4c4-7fba-cbfc636a0315@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3ae792-8900-d4c4-7fba-cbfc636a0315@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 07:42:50AM -0700, Nikunj Kela wrote:

> that's a good suggestion. Any solution you propose shouldn't just limit to
> only one parameter. IMO, there should be some way to pass all 6 parameters
> since we do have a use case of at least two parameters.

Please elaborate on your use-case.

> The shmem proposal is fine however please also incorporate passing of other
> parameters.

You are missing the point here. SMC/HVC is just a doorbell and the main point
I made earlier is that there is no need for vendors to try colourful things
here if it is not necessary. So no, I don't want any extra bindings or more
than one param is that is not needed. I will wait for the reason as requested
above.

-- 
Regards,
Sudeep

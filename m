Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40926FCAA3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 18:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbjEIQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233731AbjEIQBF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 12:01:05 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2EF9D30DB;
        Tue,  9 May 2023 09:01:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D440FEC;
        Tue,  9 May 2023 09:01:48 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B0E7F3F663;
        Tue,  9 May 2023 09:01:02 -0700 (PDT)
Date:   Tue, 9 May 2023 17:01:00 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     cristian.marussi@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Allow parameter in smc/hvc calls
Message-ID: <20230509160100.2reb4il5enadjaum@bogus>
References: <20230506182428.25343-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230506182428.25343-1-quic_nkela@quicinc.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 06, 2023 at 11:24:26AM -0700, Nikunj Kela wrote:
> Currently, smc/hvc calls are made with parameters set
> to zeros. We are using multiple scmi instances within
> a VM. We are sharing the same smc-id(func_id) with all
> scmi instance. The hypervisor needs a way to distinguish
> among hvc calls made from different instances.
> 
> This patch series introduces new compatible string which
> can be used to pass shmem channel address as parameters
> to smc/hvc calls.
> 
> ---
> v5 -> avoid computing page and offset in send function
> Link: https://lore.kernel.org/all/20230418185659.29745-1-quic_nkela@quicinc.com/
>

Thanks for the updated patch. I will pick this up for v6.5 and update
once queued.

-- 
Regards,
Sudeep

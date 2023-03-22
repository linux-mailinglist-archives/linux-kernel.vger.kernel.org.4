Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30616C50EF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjCVQkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjCVQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:40:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF23A18149
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:40:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B8DD04B3;
        Wed, 22 Mar 2023 09:41:25 -0700 (PDT)
Received: from bogus (unknown [10.57.52.160])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8125F3F67D;
        Wed, 22 Mar 2023 09:40:40 -0700 (PDT)
Date:   Wed, 22 Mar 2023 16:40:07 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: Re: [PATCH v5 4/4] firmware: arm_scmi: optee: use optee system
 invocation
Message-ID: <20230322164007.hjsjifg4wznxkgdz@bogus>
References: <20230320162801.2811542-1-etienne.carriere@linaro.org>
 <20230320162801.2811542-4-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320162801.2811542-4-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 05:28:01PM +0100, Etienne Carriere wrote:
> Changes SCMI optee transport to call tee_client_system_session()
> to request optee driver to provision an entry context in OP-TEE
> for processing OP-TEE messages. This prevents possible deadlock
> in case OP-TEE threads are all consumed while these may be waiting
> for a clock or regulator to be enable which SCMI OP-TEE service which
> requires a free thread context to execute.
>

Assuming it will be routed via OPTEE tree,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep

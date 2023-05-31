Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AF2717FE4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235672AbjEaM0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjEaM0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:26:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FBEA125;
        Wed, 31 May 2023 05:26:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 835441042;
        Wed, 31 May 2023 05:27:33 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0C9C73F67D;
        Wed, 31 May 2023 05:26:46 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Nikunj Kela <quic_nkela@quicinc.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, cristian.marussi@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] Allow parameter in smc/hvc calls
Date:   Wed, 31 May 2023 13:26:44 +0100
Message-Id: <168553587753.1312594.1314699083240878506.b4-ty@arm.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230506182428.25343-1-quic_nkela@quicinc.com>
References: <20230506182428.25343-1-quic_nkela@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 06 May 2023 11:24:26 -0700, Nikunj Kela wrote:
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
> [...]

Applied to sudeep.holla/linux (for-next/scmi/updates), thanks!

[1/2] dt-bindings: firmware: arm,scmi: support for parameter in smc/hvc call
      https://git.kernel.org/sudeep.holla/c/8f9d530cffc1
[2/2] firmware: arm_scmi: Augment SMC/HVC to allow optional parameters
      https://git.kernel.org/sudeep.holla/c/5f2ea10a808a

--
Regards,
Sudeep


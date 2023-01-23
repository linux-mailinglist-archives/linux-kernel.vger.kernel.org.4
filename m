Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E8E6787B0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 21:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjAWUZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 15:25:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjAWUZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 15:25:55 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38CFF212E;
        Mon, 23 Jan 2023 12:25:53 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674505551;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qA/YV51x0NzBgSINPoR//MrOdoxZaOLSq8U1gyTnrk4=;
        b=qWEhA45TXBuxhF+vl52y/3zWz2cXV0daunb7EabtOQLzm/+kO+uQ0jESmd/SEjh/Ii4Qk9
        MPmSWGPb8HuPmdypo59cKjmFeLA4/Ga4oKmEgz8V/nX4YThMMdHFf8KTIeCg8qBzIHc2Oj
        nEh2g9uT4hX0yUZwC/a/90FiWxJHVoY=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, kernel-janitors@vger.kernel.org,
        kvmarm@lists.cs.columbia.edu
Subject: Re: [PATCH v2] KVM: arm64: vgic-v3: Use kstrtobool() instead of strtobool()
Date:   Mon, 23 Jan 2023 20:25:37 +0000
Message-Id: <167450419464.2571033.6082403533536145707.b4-ty@linux.dev>
In-Reply-To: <f546e636c6d2bbcc0d8c4191ab98ce892fce4584.1673702763.git.christophe.jaillet@wanadoo.fr>
References: <f546e636c6d2bbcc0d8c4191ab98ce892fce4584.1673702763.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 14 Jan 2023 14:26:15 +0100, Christophe JAILLET wrote:
> strtobool() is the same as kstrtobool().
> However, the latter is more used within the kernel.
> 
> In order to remove strtobool() and slightly simplify kstrtox.h, switch to
> the other function name.
> 
> While at it, include the corresponding header file (<linux/kstrtox.h>)
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] KVM: arm64: vgic-v3: Use kstrtobool() instead of strtobool()
      https://git.kernel.org/kvmarm/kvmarm/c/016cbbd2ba55

--
Best,
Oliver

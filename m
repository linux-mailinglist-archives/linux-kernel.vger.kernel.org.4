Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2392C681A20
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 20:15:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbjA3TPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 14:15:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjA3TOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 14:14:48 -0500
X-Greylist: delayed 73 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 30 Jan 2023 11:14:37 PST
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [95.215.58.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832C33253A
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 11:14:37 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675105998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bEgfb7WC/FbKfkUgiPWhmA26LlczTITd+x7HMoE+TUo=;
        b=gDaUtIjfgDNSE4Msu5ujMGoB4zZWEhCaltCNnH8DYKe4cYm1Fvz/tbPNAeN40y4B0zReqb
        gILZ0QnkubKW7YUPqRjFeZTjsLOyV0770X7ANY6xBI6e4O++7pveK4Hapbj7gbC9mgEVVp
        cY9yiMSJVQPpwq1JP3aeUWXVtbWs8N4=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     maz@kernel.org, Oliver Upton <oliver.upton@linux.dev>
Cc:     pbonzini@redhat.com, linux-arm-kernel@lists.infradead.org,
        seanjc@google.com, catalin.marinas@arm.com, suzuki.poulose@arm.com,
        james.morse@arm.com, will@kernel.org, linux-kernel@vger.kernel.org,
        yuzenghui@huawei.com, kvm@vger.kernel.org, kvmarm@lists.linux.dev
Subject: Re: [PATCH] MAINTAINERS: Add Oliver Upton as co-maintainer of KVM/arm64
Date:   Mon, 30 Jan 2023 19:13:10 +0000
Message-Id: <167510336268.1083059.4102647014719707182.b4-ty@linux.dev>
In-Reply-To: <20230123210256.2728218-1-oliver.upton@linux.dev>
References: <20230123210256.2728218-1-oliver.upton@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        TO_EQ_FM_DIRECT_MX autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 21:02:56 +0000, Oliver Upton wrote:
> Going forward I intend to help Marc with maintaining KVM/arm64. We've
> spoken about this quite a bit and he has been a tremendous help in
> ramping up to the task (thank you!). We haven't worked out the exact
> details of how the process will work, but the goal is to even out the
> maintenance responsibilities to give us both ample time for development.
> 
> To that end, updating the maintainers entry to reflect the change.
> 
> [...]

Applied to kvmarm/next, thanks!

[1/1] MAINTAINERS: Add Oliver Upton as co-maintainer of KVM/arm64
      https://git.kernel.org/kvmarm/kvmarm/c/58817be46762

--
Best,
Oliver

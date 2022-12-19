Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7896B650917
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 10:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbiLSJJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 04:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiLSJJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 04:09:10 -0500
Received: from mail.nearlyone.de (mail.nearlyone.de [IPv6:2a01:4f8:1c1e:abde::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FB2B1E5;
        Mon, 19 Dec 2022 01:09:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B4E07DB18B;
        Mon, 19 Dec 2022 10:09:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
        t=1671440946; h=from:subject:date:message-id:to:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=cCM0WmhdJCB7i3ercJ6r0ihv7WIKNB9Qtht577iiRX0=;
        b=GrULWLSZpCG6P+seTrUM1VfwacW7JunPwNLoENFUgsiaS4+ZSAGYnejfxLE7d5V9mb/sOZ
        IdzXf9+WEJnbkePe+tghwDrlS9tFhEAhK7AXzsN+DnzD/nBQCxJsrhQSOgpzf8XA1rxPW4
        Tzh//OIZDyEXcbDKBmCgn+F6o1xAFztjeWMRfzxmtu8hofpH0xowro8CeX+bfYKLnEk6AG
        jSH5/6XfAW46D2qcfpYj20PKJks6Zw96wwDB2sVS+bcEF8yc3upDn+FXTmUd0eh6LsxEmj
        flptNesuMzKWBdMnO60osBug+UcDLEy46MctI0QFgEd+pe+YB9mZPPsnGrFp9g==
From:   Daniel Wagner <wagi@monom.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     Daniel Wagner <wagi@monom.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4.19-rt] Revert "percpu: include irqflags.h for raw_local_irq_save()"
Date:   Mon, 19 Dec 2022 10:08:58 +0100
Message-Id: <167144091839.4434.12706685546162320277.b4-ty@monom.org>
In-Reply-To: <Y5O/aVw/zHKqmpu7@decadent.org.uk>
References: <Y5O/aVw/zHKqmpu7@decadent.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 00:06:17 +0100, Ben Hutchings wrote:
> This reverts commit 0d796a9e6a93608b4dd84fbd09f01e912ae34bdc.
> 
> After merging stable release 4.19.266 into the -rt branch, an x86
> build will fail with the following error:
> 
>     .../include/linux/percpu-defs.h:49:34: error: 'PER_CPU_BASE_SECTION' undeclared here (not in a function); did you mean 'PER_CPU_FIRST_SECTION'?
> 
> [...]

Applied, thanks!

[1/1] Revert "percpu: include irqflags.h for raw_local_irq_save()"
      commit: 2c16891623cc7e8c0c4144f8665d117c7fc94552

Best regards,
-- 
Daniel Wagner <wagi@monom.org>

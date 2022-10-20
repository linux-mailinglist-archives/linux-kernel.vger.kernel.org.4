Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EDF60626D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 16:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbiJTOFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 10:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJTOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 10:05:05 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D1F2BE06;
        Thu, 20 Oct 2022 07:04:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 433807DE;
        Thu, 20 Oct 2022 14:04:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 433807DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666274698; bh=E92+sUdsg8GiHgaJBt6aQosVFgYkKcKE8A9XCxa+Of8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=aqoRBqNdc8JOhpEgAc66Szt0A+Knisvf70Zva3i8xQkLPMVdDRQCIeIkkNoXcTTAH
         UAejZo/Hi56JFH7PbceExicGx3oZyj3pxSTVl25X8fBPpIzyKYsPdE54CjQF4BRdz7
         EyO8/HEqnmAIdKFQi75ZGaI6HSEH2Ggsigd0e16TmR8BXefgVa7UmtQ5ukYub7aP4W
         pie7r/RWUE+KMjGZVhaty+58QcOVLLz/ZqQsEIoE/tX0coV9L6LpxKuX+E7Sl2WLEj
         lrFnBdmEdf0imt48X7MxNaE9at9kyOx5C7avf24AzP/vVb+6NtOTJVKoW/UHIez0PY
         O8DgcsF/6WqSw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Yanteng Si <siyanteng@loongson.cn>,
        Alex Shi <alexs@kernel.org>
Cc:     Wu XiangCheng <wu.xiangcheng@linux.dev>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] docs/zh_CN: Add staging/xz Chinese translation
In-Reply-To: <63950114-5716-4de6-3c5f-1910c2c628be@lirui.org>
References: <cover.1666181295.git.me@lirui.org>
 <52f8c1c138d0c2d799c57bba1b7c4cac4c0bf899.1666181295.git.me@lirui.org>
 <804134df-e984-6ebe-6fb2-c52d91974f8b@loongson.cn>
 <63950114-5716-4de6-3c5f-1910c2c628be@lirui.org>
Date:   Thu, 20 Oct 2022 08:04:57 -0600
Message-ID: <87pmembng6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Li <me@lirui.org> writes:

> Thanks for your reminding. I ran the check patch script before sending
> this patch.  However, the original file Documentation/staging/xz.rst
> seems not has SPDX-License-Identifier header.

You cannot know what the license of the source file is, since it hasn't
been declared there.  What you *do* know, though, is that it must be
GPLv2 compatible.  Your translation can thus be strictly GPLv2.  My
suggestion in such cases would be to put:

.. SPDX-License-Identifier: GPL-2.0

into translations of documents that lack an SPDX line of their own.

Thanks,

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7247099F7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjESOgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjESOgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:36:32 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2066099;
        Fri, 19 May 2023 07:36:31 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id ABB1E7C0;
        Fri, 19 May 2023 14:36:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net ABB1E7C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1684506990; bh=v5msYPZ8MfU03mnhJ5WlE1hAE0QORWOcmar/Ec4pGAY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=f50H3s0lUEV0Xs4leFUXJTQ+C+zxRunJqDfi8+tJRXRx84RZ4khmvGYyrSSxk8s8Y
         Jg5aJhdqtBVbWpdrNmc0SryfxVa1jHGxzk8ckoWSq3qkWhjP+JddGKZ2vtLpikCvci
         usX45qdPowiLREaBUMDvgox/nTYFysM+E3mP9ptG/rqS96bNprqgPKYMI5tv01dL/n
         WxfFXdHBcHoZwjy6HotLx5pgLr1ZEpbHav4ap7a/vaiNUk2mTn/D60l+wX7vbYK/U3
         H0DrTyQbEhae1xUgFEm/FNM5fczvBIbwCdNr7jfjuQYVYmZyRFGQtasQclfLtAm8Py
         e7pxTH2oDY6NA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Natesh Sharma <nsharma@redhat.com>, chenhuacai@kernel.org,
        dave.hansen@linux.intel.com, geert@linux-m68k.org, axboe@kernel.dk,
        linux@zary.sk
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Natesh Sharma <nsharma@redhat.com>
Subject: Re: [PATCH] docs: admin-guide: Add information about intel_pstate
 active mode
In-Reply-To: <20230427083706.49882-1-nsharma@redhat.com>
References: <20230427083706.49882-1-nsharma@redhat.com>
Date:   Fri, 19 May 2023 08:36:29 -0600
Message-ID: <87o7mgo0b6.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Natesh Sharma <nsharma@redhat.com> writes:

> Information about intel_pstate active mode is added in the doc.
> This operation mode could be used to set on the hardware when it's
> not activated. Status of the mode could be checked from sysfs file
> i.e., /sys/devices/system/cpu/intel_pstate/status.
> The information is already available in cpu-freq/intel-pstate.txt
> documentation.
>
> Link: https://www.kernel.org/doc/Documentation/cpu-freq/intel-pstate.txt
>
> Signed-off-by: Natesh Sharma <nsharma@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)

I have applied this - after reformatting the new text to stay within 80
columns and removing the obsolete documentation link.

Thanks,

jon

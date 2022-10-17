Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4A6010D8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiJQONi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbiJQONg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:13:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D7305F12A;
        Mon, 17 Oct 2022 07:13:36 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id D877C60C;
        Mon, 17 Oct 2022 14:13:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D877C60C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1666016016; bh=YgPNMTma5N6dvd1itH4n52kI8dGg/Qktzp1L17N5tB8=;
        h=From:To:Subject:In-Reply-To:References:Date:From;
        b=J6n1Qs68GOVpwf7WyDr8M9rCnh/vvcws5Q51Sl2Iv8sN8AYYVwBeJwEBDSNlzn1QM
         a6htDihddf/AwFjpWgj94GUHy3N4fEMcbQf/lFT295eyEm+6VA8HDMA2MJyNjPFRcH
         75zc4dVlj+3ina0f2FOiNkRHx4ULG7gC/8859EE7echGz26OCnG4xgiiGiUB0B9MOy
         wLIJQn9whmilttZ09zIuI2mAhuWhwBSoGyeA3ltP9SY4q5O8UebePoWJ7E1F24hG3P
         oZQa2LxxFR1kztJmB7CiEtwUPuZkkLZO/yy0Fha/Ym8AMpJJKg46YZosTIubIFLmdd
         oOzL39Cr3s01g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rui Li <me@lirui.org>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 0/2] docs/zh_CN: Add userspace-api/index and ebpf
 Chinese translation
In-Reply-To: <b75832fc-67bb-22b9-39b3-c0816b7ca254@lirui.org>
References: <cover.1666009558.git.me@lirui.org>
 <87pmeqftfw.fsf@meer.lwn.net>
 <b75832fc-67bb-22b9-39b3-c0816b7ca254@lirui.org>
Date:   Mon, 17 Oct 2022 08:13:35 -0600
Message-ID: <87h702fshc.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rui Li <me@lirui.org> writes:

> So sorry if disturbing. After sending the first patch set, a
> maintainer contacted me and pointed out my email server
> is incorrectly handling DKIM and Message-Id. That causes
> inconvenience for maintainers to review.
>
> I changed my email service and hopefully the DKIM check
> and Message ID won't be wrong. I am not quite sure if I
> should resend or add PATCH v1 version.
>
> Sorry again if I disturbed anyone.

No worries, I was mostly wondering.

As a general rule, whenever you resend a patch series, it is good to add
a note saying why so that others don't have to try to figure it out on
their own.

Thanks,

jon

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399886A10BA
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 20:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjBWToP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 14:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBWToO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 14:44:14 -0500
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00F61B56B;
        Thu, 23 Feb 2023 11:44:06 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2F228784;
        Thu, 23 Feb 2023 19:44:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2F228784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1677181446; bh=64VkXebpNK385VTZueWR6QyF6c90MfxQomeaG87dtf8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=fMVgG//paYBRuxNItl4sFB85qWLZnFl5cFuDcWDQ9uLOk1oE02sbUgHJzkZiUJkP1
         3YK+QZTicojdXoe3jA3yMDT5JQpGahuPqjSKuxmXCN9vJwwSBi2vswJuT7ibWyadeJ
         Xk0YOQXxrcW8V4yasGBLoD4QgVisdGhDJhFVhKOUVoZSBPl2P8lMRmHdPyr5JqbuoN
         3WeXf1Dm+wND4YoYb7WNPaUucp2GZ1PYf3WUv7fEIhtXrS9cOKRyQp/4WYgYoW5ydP
         NBqjGQWYbq/cDsuem23zr/Q6RG8sQ+ZH9dx5oHfUkXg+0JT1tSwUHqmM4MNNo0V+CD
         TDrPj+5uaHeaA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Carlos Bilbao <carlos.bilbao@amd.com>
Subject: Re: [PATCH] docs/sp_SP: Add process programming-language translation
In-Reply-To: <20230207220844.2661295-1-carlos.bilbao@amd.com>
References: <20230207220844.2661295-1-carlos.bilbao@amd.com>
Date:   Thu, 23 Feb 2023 12:44:05 -0700
Message-ID: <87356w5fqy.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

> Translate Documentation/process/programming-language.rst into Spanish.
>
> Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
> ---
>  .../translations/sp_SP/process/index.rst      |  1 +
>  .../sp_SP/process/programming-language.rst    | 53 +++++++++++++++++++
>  2 files changed, 54 insertions(+)
>  create mode 100644 Documentation/translations/sp_SP/process/programming-language.rst

Applied, thanks.

jon

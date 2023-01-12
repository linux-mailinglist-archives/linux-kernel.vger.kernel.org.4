Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E52F667D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjALSFa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:05:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbjALSDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:03:49 -0500
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [IPv6:2001:67c:2050:0:465::101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1400A3A5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 09:30:28 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4NtBQR09qtz9sQf;
        Thu, 12 Jan 2023 18:30:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
        t=1673544623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CCFjBz2hYq3TvSF0xDnw8claIbG4q/174RUpdE5mixI=;
        b=Oc1/v/Y8NQbsKUqbeEEe66McESrOQ9WBX6VQxzcAgvzNl5i4XCjuD3Nti9ZIZ7Yt4Ye91d
        ieHvxNVaKQaVQyIpNMj96enhfl6HChHWkAYaB3YcGbFLav7e9dI1MjIqbkff0+7iYsXxa+
        AmSx69UOH0sGRVH+1+Q8eZ/KfLxCH3eJ5Ge8EhpBNs+a/kJT8uSuTlf61dS/O+awgD0yGK
        L28v0fmj/1BdhH/3WMFb2zF/6VXF4nPooP1CxZOyn2dc8p5+IOB7I48TH5fk76Vj8Qqgw+
        UJirEcQjHvdSyN98lyTaqRcwl+CbzM0idRZWUcbjWfQZaJmXeUEXS1F/k5TfJw==
Date:   Thu, 12 Jan 2023 18:30:19 +0100
From:   "Erhard F." <erhard_f@mailbox.org>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH] kallsyms: Fix scheduling with interrupts disabled in
 self-test
Message-ID: <20230112183019.29171b26@yea>
In-Reply-To: <20230112105426.1037325-1-npiggin@gmail.com>
References: <20230112105426.1037325-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: xqkqy8u3bf6p9jxw384of8zg4x1f9ydc
X-MBO-RS-ID: 46d80a206f044f72537
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Jan 2023 20:54:26 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> kallsyms_on_each* may schedule so must not be called with interrupts
> disabled. The iteration function could disable interrupts, but this
> also changes lookup_symbol() to match the change to the other timing
> code.

Just tested your patch. It fixes the problem on the G5. Thanks!

Regards,
Erhard

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A475EFDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 21:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiI2TJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 15:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbiI2TJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 15:09:26 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D371914FE0B;
        Thu, 29 Sep 2022 12:09:25 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73:8b7:7001:c8aa:b65f])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6E5D02C5;
        Thu, 29 Sep 2022 19:09:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6E5D02C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1664478565; bh=k5z3F0/xzWULuI2Tv5PQzUKwfSUJnGgVlsClzxy7Fac=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=XW0sRaxynQ3YPDubaI1qOGKoZqRdAYpHHtrZAq7I/17jvtYPoSX4cmrrqRMUJP8h+
         DbyXMfDSDGrVpeWHwuilwI8BtXub/v/8rVtW1qAQYbSoRTqnKjT2fonFDtdERV8+0y
         0iqwXZGk92IrgQv7Qpbrxc8AYtGEM+irKN9IHfXzvRNXzEAMxfbWA43OXzwym8bR7Z
         Ufi555s79KAzWDfLUYIYlB8DjfI9R6ezoBHd+518edkLZXXaB2sx++r/LKxrxOCUuv
         9g9l4EqBrEkIUBr7lCyPc767yg9YEoDAJpSoHk++LegT45X5xDfpvRbAkPEElGkyiv
         +6Yu5QQ5EXdCQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs, kprobes: Fix the wrong location of Kprobes
In-Reply-To: <20220926142218.100e0d9b@gandalf.local.home>
References: <1663322106-12178-1-git-send-email-yangtiezhu@loongson.cn>
 <20220926142218.100e0d9b@gandalf.local.home>
Date:   Thu, 29 Sep 2022 13:09:24 -0600
Message-ID: <87edvuhuaj.fsf@meer.lwn.net>
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

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 16 Sep 2022 17:55:06 +0800
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
>> After commit 22471e1313f2 ("kconfig: use a menu in arch/Kconfig to reduce
>> clutter"), the location of Kprobes is under "General architecture-dependent
>> options" rather than "General setup".
>> 
>
> Probably add a "Fixes:" tag for the above mentioned commit.
>
> Anyway, Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

When you embed a tag like that, b4 doesn't pick it up anymore...but I
was amending the commit to add the Fixes tag so I put it in too...:)

Applied, thanks.

jon

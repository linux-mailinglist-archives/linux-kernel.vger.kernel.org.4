Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B226010B6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230210AbiJQODw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiJQODr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:03:47 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC20212A81;
        Mon, 17 Oct 2022 07:03:45 -0700 (PDT)
Message-ID: <b75832fc-67bb-22b9-39b3-c0816b7ca254@lirui.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666015423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rwkjmSZHT/cg5CxEyPSYVXlGko/3a4QvL9viNdnNJH0=;
        b=PyCqPJGa9PViula8mn24m3UZtNZkUYf+Iea8i3aTwyl24rULBErv/94hcD6uSM2KGKNix2
        tMQHtpPd3wy3Ue3qCgTouMhKApRUVLmW9i7gQ70bLq3X504uVQpTBKikObwqp7gdtS/s2g
        FIPd2TF+2AJsyH469mXwxGcGjkOI3tg5GjTDWX7nRHW8KqH3NCyQH5TgaN6N4e1O9UoOx/
        nXOofTMfATTJ+DKEpoD4D+AwKj/Y4IjLs0KIHMI//j/cLCI6+dLF4jrEVy4A0O/r0blyOy
        56/lMt5q2Cmk/mw1bRr8pn5iggVyiNEuEEfosWIYMsHwUWFPlL5owYOUeSa8AA==
Date:   Mon, 17 Oct 2022 22:03:32 +0800
MIME-Version: 1.0
Subject: Re: [RESEND PATCH 0/2] docs/zh_CN: Add userspace-api/index and ebpf
 Chinese translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666009558.git.me@lirui.org> <87pmeqftfw.fsf@meer.lwn.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rui Li <me@lirui.org>
In-Reply-To: <87pmeqftfw.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/10/17 21:52, Jonathan Corbet wrote:
> Rui Li <me@lirui.org> writes:
>
>> Translate the following documents into Chinese:
>>
>> - Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
>> - Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
>> - Documentation/translations/zh_CN/userspace-api/index.rst
>>
>> Add userspace-api into the menu of zh_CN index.
>>
>> Rui Li (2):
>>   docs/zh_CN: Add userspace-api/ebpf Chinese translation
>>   docs/zh_CN: Add userspace-api/index Chinese translation
>>
>>  Documentation/translations/zh_CN/index.rst    |  2 +-
>>  .../zh_CN/userspace-api/ebpf/index.rst        | 22 ++++++++
>>  .../zh_CN/userspace-api/ebpf/syscall.rst      | 31 ++++++++++++
>>  .../zh_CN/userspace-api/index.rst             | 50 +++++++++++++++++++
>>  4 files changed, 104 insertions(+), 1 deletion(-)
>>  create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/index.rst
>>  create mode 100644 Documentation/translations/zh_CN/userspace-api/ebpf/syscall.rst
>>  create mode 100644 Documentation/translations/zh_CN/userspace-api/index.rst
> Why are you resending this patch set after one day?
>
> jon

So sorry if disturbing. After sending the first patch set, a
maintainer contacted me and pointed out my email server
is incorrectly handling DKIM and Message-Id. That causes
inconvenience for maintainers to review.

I changed my email service and hopefully the DKIM check
and Message ID won't be wrong. I am not quite sure if I
should resend or add PATCH v1 version.

Sorry again if I disturbed anyone.

Rui


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C026010E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiJQORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbiJQORn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:17:43 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DD662A92;
        Mon, 17 Oct 2022 07:17:42 -0700 (PDT)
Message-ID: <2d3ae469-88bc-32e9-56c1-79142633da0c@lirui.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lirui.org; s=key1;
        t=1666016260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nrtIEgsBdYVG+U7/eLdkZfooUmYs1u+mOfxbESahnKE=;
        b=RyKkensVS80Dm+ggNvPs4bMXzh7BiHlt7jpku/FIchf/sRsoLMlMYhF+Ycj+c9dDORgpCs
        aRvEckWUBA5EzjYAN+BoI3j8qFPFODZQ0qk5QJzj4ulHTAROrZwQtXtYC3TCF+Ip4vXY1x
        +/4XENSLhZWQFkIEr36FH7zWQuwtfM310n6S+nbDgmqfaUi7WV3tG7G21JuNM8Qiukbnnd
        2CNWVaAtEecmHFUYBTN3UDcR+ePjbDNJaomAFNT44GxaZW3eNWpcCed+9zMaFUGtQZ4tuq
        pPXBxRpN7AnS7YAPF2rWIsnb6+MhbZRQpvaMjs3x8SQdrYFuxyh25Xjh2l22ow==
Date:   Mon, 17 Oct 2022 22:17:23 +0800
MIME-Version: 1.0
Subject: Re: [RESEND PATCH 0/2] docs/zh_CN: Add userspace-api/index and ebpf
 Chinese translation
Content-Language: en-US
To:     Jonathan Corbet <corbet@lwn.net>, Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1666009558.git.me@lirui.org> <87pmeqftfw.fsf@meer.lwn.net>
 <b75832fc-67bb-22b9-39b3-c0816b7ca254@lirui.org>
 <87h702fshc.fsf@meer.lwn.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Rui Li <me@lirui.org>
In-Reply-To: <87h702fshc.fsf@meer.lwn.net>
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

On 2022/10/17 22:13, Jonathan Corbet wrote:
> Rui Li <me@lirui.org> writes:
>
>> So sorry if disturbing. After sending the first patch set, a
>> maintainer contacted me and pointed out my email server
>> is incorrectly handling DKIM and Message-Id. That causes
>> inconvenience for maintainers to review.
>>
>> I changed my email service and hopefully the DKIM check
>> and Message ID won't be wrong. I am not quite sure if I
>> should resend or add PATCH v1 version.
>>
>> Sorry again if I disturbed anyone.
> No worries, I was mostly wondering.
>
> As a general rule, whenever you resend a patch series, it is good to add
> a note saying why so that others don't have to try to figure it out on
> their own.
>
> Thanks,
>
> jon

Thanks so much for advice. I will pay attention next time.

Wish you have a good day.

Rui

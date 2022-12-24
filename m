Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF786655B22
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 21:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiLXUBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 15:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXUBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 15:01:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 298F760D7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 12:01:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D35560A0B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Dec 2022 20:01:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9977AC433D2;
        Sat, 24 Dec 2022 20:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1671912102;
        bh=/Qy/Qj1Vx3zw2T5R9Nv13yC4ShJH4FPtaZmfesPEDwo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tMN7gQcD5yBjzxR+WuSsdhW8Xxq6SKLBACPV8bpoCCOrSd+vhQJxT8bd36liEq8hY
         4UvHMc0wD8ACDEmTLMqsokXiXqj/RUqaTrjhJ9JCSKYR2pE8R5FvIs6i3mwLY7pry+
         LzKLh049Z6awy520Wc4ZSxvrzvHicUqsBAz5VBag=
Date:   Sat, 24 Dec 2022 12:01:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Cc:     "manfred@colorfullife.com" <manfred@colorfullife.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "1vier1@web.de" <1vier1@web.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>
Subject: Re: [PATCH 3/3] kernel/irq/manage.c: disable_irq() might sleep.
Message-Id: <20221224120141.0cb4a82c548c3177f4498fe2@linux-foundation.org>
In-Reply-To: <9593a9758731af70bdb6ad4f73af3ddc102571f1.camel@siemens.com>
References: <20221216150155.200389-1-manfred@colorfullife.com>
        <20221216150441.200533-1-manfred@colorfullife.com>
        <20221216150441.200533-3-manfred@colorfullife.com>
        <ca1972cec9724189b5a97a09069f3ee4f8c3f97c.camel@siemens.com>
        <1540f1d0-4fda-aaf4-acda-f5aaa6952a00@colorfullife.com>
        <9593a9758731af70bdb6ad4f73af3ddc102571f1.camel@siemens.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 11:22:30 +0000 "Sverdlin, Alexander" <alexander.sverdlin@siemens.com> wrote:

> But I don't have a strong opinion on
> that and it looks like it has been taken into mm tree already.

It can be taken out again ;)  Hence the "mm-unstable" name.

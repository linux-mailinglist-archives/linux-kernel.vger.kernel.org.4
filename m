Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 336D85EDE09
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbiI1NoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:44:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiI1NoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:44:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260AEA74C8
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=2S5bCE90ALJgS362zIKqVG0EZgFFSlA8L7arkIqrt/0=; b=d1vajE+ofAJsS1SUgsa036tBmR
        BxuCc0uGn+tB7bhSZjuAMnJlEUGq0eUCgUnFpdgserkqGmnTwdW7wtxHNls0kJsiBRHiDI/H/OfQa
        ZfC9/un7dpUhFp8A8A+AXv7o4vNFeEFyAn3HmVMWcNbYP+UNKE4/ir5AL5pDz3AvGg3JxEv1NZeI7
        5PapTqxEe25JlVUulXDHYP71sz2CAwrPVt34H3dtEgWrCPpkBrc4o+bEJh++QKl1qPA1hiATzVq7a
        X7+M4Bmm1fQYuDhkcP1q0lzzV7jSF/mhgVdgDTKAbVCjWlmsQWNBglXfcdv+AOKKnKs1Ouh5voj8r
        /DP9+oJA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odXLs-00Gb0Z-BJ; Wed, 28 Sep 2022 13:43:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8119F3001D7;
        Wed, 28 Sep 2022 15:43:51 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5B1252BE3417C; Wed, 28 Sep 2022 15:43:51 +0200 (CEST)
Date:   Wed, 28 Sep 2022 15:43:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kassey Li <quic_yingangl@quicinc.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        quic_namajain@quicinc.com
Subject: Re: [PATCH v2] kernel/hung_task: add option to ignore task
Message-ID: <YzRPl/R7o6qjbsM1@hirez.programming.kicks-ass.net>
References: <20220928074841.22545-1-quic_yingangl@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928074841.22545-1-quic_yingangl@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 03:48:41PM +0800, Kassey Li wrote:
> By default, hung_task will iterate the tasklist and check
> state in TASK_UNINTERRUPTIBLE with a given timeout value.
> 
> Here we add an option for task_struct so it can be ignored.
> Set this flag to default true, it do not break the origin design.
> 
> This is useful when we set timeout value to 5s, where we just want
> to detect some tasks interested.

What the hell for?

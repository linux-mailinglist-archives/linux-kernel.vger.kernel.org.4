Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F24664EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjAJWoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234891AbjAJWnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:43:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4885EC07
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 14:43:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3FF5DB819AB
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 22:43:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0CAC433EF;
        Tue, 10 Jan 2023 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673390629;
        bh=0ioneHU7ugcs0+ecN8LTgSUVarTdJg17Ond7WSxkiKw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MakqXsGDacT8n9AYXJ3GDWMRPnilxCjA/yGHkP0xetGTIU66p9DELsZwQP98Uay14
         D5B2mLo2Wuh/4D4K6zkEyZBTpI61DoxvcTYII1hKLmUVckpMLdbnt/vuxVfPjOVnoo
         iSDEkAqQ/ZfWeH1SQhvi4pUhz1+tcHG2omrfApTg=
Date:   Tue, 10 Jan 2023 14:43:49 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] userfaultfd: Fix vma iterator conversion.
Message-Id: <20230110144349.43380df0c5714ec015a151b9@linux-foundation.org>
In-Reply-To: <20230110184247.1268710-1-Liam.Howlett@oracle.com>
References: <20230110184247.1268710-1-Liam.Howlett@oracle.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jan 2023 18:43:03 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> Please squash this patch.

It throws a reject.

This series is getting pretty mauled.  I think I'll drop it and ask for a v2, please.

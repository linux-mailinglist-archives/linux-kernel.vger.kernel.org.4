Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258C6716BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjE3SDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbjE3SDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:03:05 -0400
X-Greylist: delayed 2235 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 May 2023 11:03:02 PDT
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CC6EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
        MIME-Version:Date:Message-ID:content-disposition;
        bh=24Ry0beQgWrLSFF8krNBwN4KJRINBEkewKnwBgtX8s0=; b=IXdLdyGG3/j+MW0vZgOMVsZew4
        EQGHw0rZ/Qs/tVekOd/EA0IXxQUyJ4eUybgB6Zqzh80ikhKQd9h6gxjv7NX53TEOoYyG/LhjowQmn
        TG/u7iYYPAwDYfVtPtfHtbBXcQTKfgck38ghgHXddVNwdaybMLMEz9YSjFNcA6owTljt2GczGBWvC
        N5a/P+mDnHmGlQ8AxESLLF8Y+W2+Y3j14xHBInQkanZR0k5I7MBvp3+AxjZBa/GsgbdYgWKuSlpCj
        Yndybi5XQK5GV2xuzH1nFjq/yf3FQ8auqtcDKz4CxK6GYh2GI23rhZvuGflKVMvvDjwIld9cJVWjA
        65a9QJUw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <logang@deltatee.com>)
        id 1q433y-00DzWB-3A; Tue, 30 May 2023 11:23:14 -0600
Message-ID: <8a411404-a2fc-694c-c41e-5d7efba38472@deltatee.com>
Date:   Tue, 30 May 2023 11:23:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-CA
To:     Robin Murphy <robin.murphy@arm.com>, hch@infradead.org
Cc:     m.szyprowski@samsung.com, iommu@lists.linux.dev,
        catalin.marinas@arm.com, linux-kernel@vger.kernel.org
References: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
From:   Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <fa2eca2862c7ffc41b50337abffb2dfd2864d3ea.1685036694.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: robin.murphy@arm.com, hch@infradead.org, m.szyprowski@samsung.com, iommu@lists.linux.dev, catalin.marinas@arm.com, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
Subject: Re: [PATCH] dma-mapping: Name SG DMA flag helpers consistently
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023-05-25 11:46, Robin Murphy wrote:
> sg_is_dma_bus_address() is inconsistent with the naming pattern of its
> corresponding setters and its own kerneldoc, so take the majority vote
> and rename it sg_dma_is_bus_address() (and fix up the missing
> underscores in the kerneldoc too). This gives us a nice clear pattern
> where SG DMA flags are SG_DMA_<NAME>, and the helpers for acting on them
> are sg_dma_<action>_<name>().
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Looks good to me. Thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

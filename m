Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB86964D9B1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 11:47:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiLOKq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 05:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbiLOKqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 05:46:52 -0500
Received: from mx1.veeam.com (mx1.veeam.com [216.253.77.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C5A1C410;
        Thu, 15 Dec 2022 02:46:49 -0800 (PST)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.veeam.com (Postfix) with ESMTPS id D099241D42;
        Thu, 15 Dec 2022 05:47:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx1-2022; t=1671101262;
        bh=xhll34qBllbleKx66EAPbdWrQOO5TZUZ0637lrp11Nc=;
        h=Date:Subject:To:CC:References:From:In-Reply-To:From;
        b=TKrwTfOBXBuHz/g0VqQ2IiMSFrcARyCoIRxkmMNuLSh3CfzQE5657obtdA8fxCebV
         VR09826PnxKczE2lZv0AUwj2g7e1g0UJoxqpvMdHcOdk+paSt3nJORTW+kYmD3ZMC/
         FFpjN6uHi2LuGH4aOVDc9mb05UUXP8W1CoGb9YrzmI9/9uJIoXnq9iRbUHYAOFjz/4
         3zcWPe4GuMFHoZfSqu7artJAHbCTbLAzsLG+l+bbJY2u21J8STR9+OXhgLvak5Glxs
         dqhFxDCLLCC1m/TQCOe0YSjPStdyUPu9S4NZAZyldw7Nj3OwWEbrHEnquUdBVbd7dz
         pQBWfxyL+K7sg==
Received: from [172.24.10.107] (172.24.10.107) by prgmbx01.amust.local
 (172.24.128.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.20; Thu, 15 Dec
 2022 11:46:43 +0100
Message-ID: <28b715eb-f9bc-c0d3-8dfd-22d0f84080c0@veeam.com>
Date:   Thu, 15 Dec 2022 11:46:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 02/21] block, blkfilter: Block Device Filtering
 Mechanism
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
CC:     <axboe@kernel.dk>, <corbet@lwn.net>, <linux-block@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20221209142331.26395-1-sergei.shtepa@veeam.com>
 <20221209142331.26395-3-sergei.shtepa@veeam.com>
 <Y5roR3jjhQwgFWVM@infradead.org>
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
In-Reply-To: <Y5roR3jjhQwgFWVM@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.10.107]
X-ClientProxiedBy: colmbx01.amust.local (172.18.0.171) To prgmbx01.amust.local
 (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29240315566D7061
X-Veeam-MMEX: True
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am very glad to see your comments, Christoph.
Thank you so much for the review.

I have read all the comments and agree with them.
Now I see new ways to make the code of the filter and the blksnap module better.
There seems to be a lot of work to be done. :)

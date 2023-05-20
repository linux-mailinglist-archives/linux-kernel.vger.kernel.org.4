Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3A170AAC8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 21:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjETTv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 15:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjETTvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 15:51:24 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB0134;
        Sat, 20 May 2023 12:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zldLMHVF0+enwbK2bn/xN8WyjQjwKAb0RoO4puGTpSI=; b=4/scPaQ7R+UjY3VrwQe3NIl2rv
        jTVfqC0RfpavNd3s0YxuC0NJ4Q95HfQu2uMcpZmx4158//F4Ylu+9P/PxS4X2OAyTaQh/vZ4JY20/
        iFG5F/mH2t+b8eKMHTnMrj0h1AL9WHs1KsEl8YqNGbh2D6bKVh37Rdj9PWE5iXxs0xJ5U+mOYqh8A
        k0cVuxZ4Ctuar6hZ5X91qLzPY9CXewlijpDsrjTlk4CC3AOB5ELPEQR4HMbj+lCHCKvbDZdNwrrCy
        yG2tX1EzWH231gQhe56wfExLIgX5T7gtl7aoo7Fi4Vz7jPwJUNKRB0RGshwilQGU3U2u68N/B8RMu
        L4VcX4/w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q0Sbp-002AGG-0l;
        Sat, 20 May 2023 19:51:21 +0000
Message-ID: <aa3c7839-82b4-608a-0fd8-62beca5f075e@infradead.org>
Date:   Sat, 20 May 2023 12:51:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: linux-next: Tree for May 19 (drivers/interconnect/icc-clk.o)
Content-Language: en-US
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
References: <20230519130753.3a9d3d65@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230519130753.3a9d3d65@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/23 20:07, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20230518:
> 

ERROR: modpost: missing MODULE_LICENSE() in drivers/interconnect/icc-clk.o



-- 
~Randy

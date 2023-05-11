Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D74866FEB58
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236758AbjEKFnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237084AbjEKFnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:43:25 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C22946B6;
        Wed, 10 May 2023 22:43:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NwSO9TDmqyQQo7gy+ZlsPYYNJY8eYNENQuHNztbBKig=; b=JPK9vySYgVaWwc5xUZZvipUD8x
        9CWFVkKKnzGEqNtoM72RsvC4mmPTPIACGFS2IxhfZKBB/jjjSNaoZZOFoA0W+S195RPJ1R6xdIfRo
        n5Xhd8y/vge3BqazFtU9WThKYbD68jMeekV9w+Zm0mACq2VW73fqxvR66Kzl0gl4Aig4fnfa3dTHz
        3Vmol8YpBxvks4AjsJktKRMbcw2K3KZw0kaMKTcTDIbJtO1JLO2lAhwxiZKILotCRO3Q+7FENwJ7A
        nEA8rA/SxEQu2zGJAHmc6jZNT23NjCcaJXYPaRgnXaBDwh0N4RVx0ImFdda/GUrpJ8b1XWGTWzB8E
        Ej4zzBaw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pwz51-001ciu-2Q;
        Thu, 11 May 2023 05:43:07 +0000
Date:   Thu, 11 May 2023 06:43:07 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     ye.xingchen@zte.com.cn
Cc:     sumit.semwal@linaro.org, christian.koenig@amd.com,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-buf: Use fdget()
Message-ID: <20230511054307.GK3390869@ZenIV>
References: <202305051018472856954@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202305051018472856954@zte.com.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 05, 2023 at 10:18:47AM +0800, ye.xingchen@zte.com.cn wrote:
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> convert the fget() use to fdget().

NAK.

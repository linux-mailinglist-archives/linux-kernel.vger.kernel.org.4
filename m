Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F0C70905A
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjESH3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESH3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:29:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B4122
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 00:28:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE1526546B
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 07:28:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BBEC433EF;
        Fri, 19 May 2023 07:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684481338;
        bh=lmXXYGrj6hHqqS4zlT/BiecD6RymwCiSsssvAM5GCeM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JcO76wyOkdYa2q5zd9GXcVEk04wSX1zNTJtAOACHFkOIOwwtRKtJyZMHt/0Ke8EU2
         DN4nmXcHGyX7fiBmLiFvDbz4uiaB9nHOJuB9mEZmtFyi/eBMRNdgkidNmKpmLi90tr
         a6WPfCTJXBk2h9J+qUCsVEFEiRBVAuv8DTmOM8PY=
Date:   Fri, 19 May 2023 08:28:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jane Chu <jane.chu@oracle.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm, hwpoison: When copy-on-write hits poison,
 take page offline
Message-ID: <2023051938-pelvis-stucco-0c49@gregkh>
References: <20221021200120.175753-1-tony.luck@intel.com>
 <20221031201029.102123-1-tony.luck@intel.com>
 <20221031201029.102123-3-tony.luck@intel.com>
 <71cdf8cc-a640-ec06-fca5-ed4d948c4880@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <71cdf8cc-a640-ec06-fca5-ed4d948c4880@oracle.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 18, 2023 at 02:49:44PM -0700, Jane Chu wrote:
> Hi, Tony, Greg,
> 
> Does it make sense to include this patch series in the
> 5.15.y LTS kernel?  I just checked: it's not in 5.15.112.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

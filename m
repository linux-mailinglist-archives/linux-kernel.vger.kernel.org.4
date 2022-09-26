Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D03025EA8A7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbiIZOkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235075AbiIZOjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:39:23 -0400
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A54C684E62
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 06:01:10 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id C514B222722;
        Mon, 26 Sep 2022 15:01:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1664197268;
        bh=1Q4KS+kJWmn8dojcJlNBkaBQbp7UKdMZq2hj4C2yZbQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A3P6ejM47UAW0veZN2gqdNKTFtYqiN8SN+WESnMKU1PxO/j1PnokK0mdSPa1IJHPU
         NyzwJrqaK9dHRJj9nTNOPyQ4JICPDNXuAIzGW8xm9VSqCnZWA7JvkQTjlfmXYS7SGW
         zFVZSF7snXjvmiUB+DeKFQEJVErPBlFzAsgOOgWK1ILB4uUOo5uYod/XA70amKrCCY
         FAV7jCd2Rv9w9bQo9VjoVMSpPYS50QoJUCk7K55hU9A4Tq9njgQhSGOvDiA0KOaNEc
         nJSrou6SzSPG3b0NFmatrr9Ww4Lt5YbAEBtkG7gqS8ywzQivawgBnIczQfXCrzxK0r
         ORPoPbudNwamg==
Date:   Mon, 26 Sep 2022 15:01:07 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] [PULL REQUEST] Intel IOMMU updates for Linux v6.1
Message-ID: <YzGik3y4J0Fkc9fd@8bytes.org>
References: <20220923004206.3630441-1-baolu.lu@linux.intel.com>
 <YzGX7ri+CYTpKfeP@8bytes.org>
 <64405aee-0701-5b1f-084a-f0750372a563@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64405aee-0701-5b1f-084a-f0750372a563@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 08:38:09PM +0800, Baolu Lu wrote:
> Do you prefer applying de9f8a91eb32 to vt-d branch, or let me send a new
> v6.0-rc7 based pull request?

Yes, please send a v6.0-rc7 pull-request. I'd like to carry the conflict
resolution in the merge commit for next.

Regards,

	Joerg

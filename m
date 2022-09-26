Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBC225EA6E5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 15:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiIZNPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 09:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234879AbiIZNPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 09:15:08 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BEB94937AF
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 04:43:53 -0700 (PDT)
Received: from 8bytes.org (p549ad5ad.dip0.t-ipconnect.de [84.154.213.173])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 406DF22264E;
        Mon, 26 Sep 2022 13:31:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1664191903;
        bh=NsNWAeCq66HrW1GGxO8USl6J4kFilGYZmkinmTsFGgI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nayy4gxca25kl8M2YW+Fv9qPGKUoX1SzDHBtYmPKTzLCnQxdAqcWhWm74X5JNpA/m
         BcXcZq77s7qPqZfDnv0vjW2hq6AStGXOR9mlJrO4TDvT84J41F2csLWq0AbJ9U/T/9
         CjrQY+aN/WRvx2UlJr54aAAkNNOAzCJLp6hlrwclA+Iv+6TbZnpzpG8TnhItfK8LW/
         x5osLluUTHqmwEsehGq68XfuvfGs0rf9x+YL/0Dqj6Jr8JCDn/AICWQ+/IQncQeRzf
         UC5gPvnCKxTgGWlE5MB8HpFI4OU5VHv1W+/lBm1qUUaiKHRG8duI7KmS063w61rFK6
         fOved/jCrO/jA==
Date:   Mon, 26 Sep 2022 13:31:42 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH] iommu/iova: Fix module config properly
Message-ID: <YzGNnmE6ZnPFI4fk@8bytes.org>
References: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <548c2f683ca379aface59639a8f0cccc3a1ac050.1663069227.git.robin.murphy@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 12:47:20PM +0100, Robin Murphy wrote:
>  include/linux/iova.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

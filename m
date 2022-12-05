Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B6564288F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiLEMgE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:36:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiLEMgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:36:02 -0500
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFE101759C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:36:00 -0800 (PST)
Received: from 8bytes.org (p5b00664c.dip0.t-ipconnect.de [91.0.102.76])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 5673D220316;
        Mon,  5 Dec 2022 13:35:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1670243759;
        bh=JmjGyGgFbEPCHfCKnomLro85Cn13iOUcjUEX60upBhw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2gEWG5PZW7/JK/XVunOJxtWTX99r1jC8p4WwNLWWyCTadLkF4intiLocaQgjl9FEI
         YOY5dIgmnr9N2KcIHFdsnyAFZpr0p/yPl80INWMKLmkuv7fJFAmZasli4TwWNOCoD+
         o0u7nIL4BGXfjVppE6XjhYtDzFkssHepXW9HUZuDIe47/8J7w19HpiuQsu7jfhb9Nn
         8W+neZP4cWxfJP0X5TgMPIh4iUuxOeAR6wdVblgxOCVk6S4RR+2Q9nq/BVfBGsJgek
         OR6o6+ejWSUb54auqEPQCeC7Pa3AMITBXE5GKzCjx8McNEbJd4fhQnQJfnVF5S0tia
         Rxy6pUflmC18Q==
Date:   Mon, 5 Dec 2022 13:35:58 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, iommu@lists.linux.dev,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Raj Ashok <ashok.raj@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        Yuzhang Luo <yuzhang.luo@intel.com>
Subject: Re: [PATCH v3] iommu/vt-d: Add a fix for devices need extra dtlb
 flush
Message-ID: <Y43lrlOGNm7XdyZ7@8bytes.org>
References: <20221130062449.1360063-1-jacob.jun.pan@linux.intel.com>
 <Y43LUVS1heMxGBC7@8bytes.org>
 <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64c5b16-79bd-182d-354b-73a74430a8cc@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 06:59:19PM +0800, Baolu Lu wrote:
> But this patch has already been merged in v6.1-rc7.
> 
> https://lore.kernel.org/linux-iommu/Y4oF8e7quzjm2kzD@8bytes.org/

Ah right, Linus did pull it. I though it wasn't pulled because I didn't
get a bot message about it. I will merge the fix.

Thanks,

	Joerg

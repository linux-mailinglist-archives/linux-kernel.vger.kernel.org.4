Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A449970C203
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233871AbjEVPLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234478AbjEVPKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:10:54 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94AF1BF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:10:52 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id BF5242434D7;
        Mon, 22 May 2023 17:10:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684768251;
        bh=C4XRXQaWxNO+0o7ACwltK3KeZDgZy5l9Ut9az/WeKWc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tYka/2TpLB1hp6tTFWBmjTyMisi9YFS3e87jSNTdM5gvOZEQUrb97Mhs5W7/22cle
         NQMqshCUsOl639oxngV3aVfoAocqjrJbbnyrNtuqKIjslkxpqL7sZmVzA9Q4Gf8+sY
         mlddOaVNNzyEeMgns7+lC8ln7ccAqLJxlK49Fr+w3Tp+DeThgTSns2D4O4tELwF9Qc
         o9n0DKa30+a/37mpGCdGEYNXosafshxjI8ZcG6vAKeXDHZrs0HFfh+AfwYfYEY2rkk
         ssbemiJfbIBAfNr6gmSomA74QZ/i27DmigT9JEhdHkeJSiLNKUJZ9C7qQcZCedqpkn
         8UIebWA3lieqQ==
Date:   Mon, 22 May 2023 17:10:50 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/iova: Optimize iova_magazine_alloc()
Message-ID: <ZGuF-m-RzLo-ujZs@8bytes.org>
References: <20230418062518.852-1-thunder.leizhen@huawei.com>
 <e9b912ee-6b49-f369-82ff-daff49dc7511@arm.com>
 <b6bf601b-0466-cb94-22b2-1189724410c9@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6bf601b-0466-cb94-22b2-1189724410c9@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 07:52:14PM +0800, Leizhen (ThunderTown) wrote:
> Yes, sizeof(*mag) is the more recommended usage, I will post v2 tomorrow.

Somehow v2 didn't make it to my inbox, but I found it on lore. This is
applied now, thanks.

Regards,

	Joerg

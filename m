Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DFA70C225
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbjEVPSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 11:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjEVPSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 11:18:14 -0400
X-Greylist: delayed 861 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 22 May 2023 08:18:13 PDT
Received: from mail.8bytes.org (mail.8bytes.org [IPv6:2a01:238:42d9:3f00:e505:6202:4f0c:f051])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F864CA
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 08:18:13 -0700 (PDT)
Received: from 8bytes.org (p200300c2773e310086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:773e:3100:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 8BB4A248084;
        Mon, 22 May 2023 17:18:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1684768692;
        bh=OmBVHj3DPBXJcYJPJ1O/w+bYN5WmqeyFhld5P3BR4ls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IHxjIrksQ8WBNCLwx7fuFwqt5WJNdeTFinZz32zZ0Nxmip9ma63L9EifyRALWOUqx
         MBTyFRxxjxogk9sU2YVOLQJ3HlQ0VWxc0Fhw1KFUfcxgYRfYApOu6ox2vNaJ2hqHhE
         MPgb17Z0QoM77ZB5wPtr7UNCb7JWLWrIvU/EzA6l9sobqwodwKg8xM+6eTJAqq4IOs
         eWkr7w/Pp3tKzNPDE6rCxDhObZ9SV9nNmngoJ9Ja71RdhHKKBUl185dQ3pPrQoaK7B
         ySvAeTBqVDTEkfFsha568U5nIWHh27s1vNtTubrtZ0vlfaJyVXxlyYrxNyabTUl/MB
         e/rgEfcQ3YsAw==
Date:   Mon, 22 May 2023 17:18:11 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Jerry Snitselaar <jsnitsel@redhat.com>
Cc:     iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH] iommu: amd: Use page mode macros in fetch_pte
Message-ID: <ZGuHs7TIR0fcFfdo@8bytes.org>
References: <20230420080718.523132-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230420080718.523132-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 01:07:18AM -0700, Jerry Snitselaar wrote:
>  drivers/iommu/amd/io_pgtable.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

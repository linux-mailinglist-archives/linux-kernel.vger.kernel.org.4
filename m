Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7207333C5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345180AbjFPOjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjFPOjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:39:02 -0400
Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8980E2700
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 07:39:01 -0700 (PDT)
Received: from 8bytes.org (p200300c27725a60086ad4f9d2505dd0d.dip0.t-ipconnect.de [IPv6:2003:c2:7725:a600:86ad:4f9d:2505:dd0d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.8bytes.org (Postfix) with ESMTPSA id 521DD226A72;
        Fri, 16 Jun 2023 16:39:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
        s=default; t=1686926340;
        bh=KTpj5Fsy2wKYCCe/sKhg7+iN9JCgxD+6LBbN5hC3GyI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pSvu/L/D2Cd5yZw8rC6gj5SE9cXOUN6Yi65oTkpgU0VQL18Vg+tKX0h795H9e0En0
         rgiCStQNI/uPieEClaA0/nCIhpxXPl9UKIzdgsNLdO+GLyY0bZGli9FFpJ0eJOGC2x
         793hLUijKrhJuE0v6rLiu78zcxHw1cxvOe1b7BtvDN4UZh68p5piR77MAQFOhnIhDy
         xGm4/SiQqf2dVJ5HUPJSu1lm6gm5IcXx/M8xuyTu1zCk5AEcUT3JvREqOY8LcE1qb9
         QVksjrPrIPKGdXm5cUqr53+VwlZQvKB5Y1SlALx8fhBxnXGnTcvF6lQnauNPnsIXKt
         bKdPnh1xZRKfg==
Date:   Fri, 16 Jun 2023 16:38:59 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Yanfei Xu <yanfei.xu@intel.com>, Suhui <suhui@nfschina.com>,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] [PULL REQUEST] Intel IOMMU updates for Linux v6.5
Message-ID: <ZIx0A7oRIJJvrg73@8bytes.org>
References: <20230614024705.88878-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614024705.88878-1-baolu.lu@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:47:01AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> This includes patches queued for v6.5. They are:
> 
>  - Small and misc cleanups
> 
> The whole series is based on v6.4-rc6 and also available at:
> https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.5
> 
> Please pull them for x86/vt-d branch.

Pulled, thanks Baolu.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506455EED98
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 08:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiI2GJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 02:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbiI2GJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 02:09:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129E911C144;
        Wed, 28 Sep 2022 23:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=8glxvAsCfjK/Oq/Yba1pToU5yEMO+RQjzWfqMG6Hn3g=; b=RId2ByHt48Mp7EmYN+XtwX62Ad
        cpwaMQc6GjQrCk4SyBrhlafzpe4LFf1/OPvZduDJmUi7wPgjMSaffoP4CQsm5MDBg0KsXs6Vjll70
        AGc0kfUxszlG+X9hu8kRpByPd7mv9JQdIwl3QlAjfWuzwizfgjNP3E7kQRdfbKGxgV035eCAbcxU4
        Q6SozNVM4fseDu78STIIeqabKDkAjbKcyIIqOw2Bj4020Gk3sDqqM4IX8wJcxoljD1jytRhTAQWhI
        /cDPDLSMmgf3JADJW1+S6RVmJJ8GPtp+1r2Wd2PsyXddVWfEsGfRpPFly1cgkWVDfTl6eP7YxoHvT
        4VzhDBXg==;
Received: from [2601:1c2:d80:3110::a2e7]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1odmjf-001Ks1-G4; Thu, 29 Sep 2022 06:09:27 +0000
Message-ID: <68689c5b-327f-65df-0d34-a7e1a851f568@infradead.org>
Date:   Wed, 28 Sep 2022 23:09:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: Tree for Sep 28
 (drivers/gpu/drm/msm/msm_gem_shrinker.c)
Content-Language: en-US
To:     broonie@kernel.org,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        Rob Clark <robdclark@chromium.org>
References: <20220928192605.247546-1-broonie@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220928192605.247546-1-broonie@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/28/22 12:26, broonie@kernel.org wrote:
> Hi all,
> 
> Changes since 20220927:
> 

on x86_64:

../drivers/gpu/drm/msm/msm_gem_shrinker.c: In function ‘can_block’:
../drivers/gpu/drm/msm/msm_gem_shrinker.c:29:28: error: ‘__GFP_ATOMIC’ undeclared (first use in this function); did you mean ‘GFP_ATOMIC’?
   29 |         if (sc->gfp_mask & __GFP_ATOMIC)
      |                            ^~~~~~~~~~~~
      |                            GFP_ATOMIC



-- 
~Randy

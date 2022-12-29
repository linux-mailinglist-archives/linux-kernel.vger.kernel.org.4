Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D2659096
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 19:53:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbiL2SxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 13:53:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiL2SxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 13:53:03 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F119713F91
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 10:52:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iqDL55PZjFw0FUAHHyyr6Jd1zLLkgLC+5qYAWmFxvZs=; b=eq7pvj408N3kIsUohCTeCO6a2g
        mmrVBqz0/SFyK14/fjQQ19EytJdmLRYMx2eKhv9PpqJGvuFk5AOR0YYbg6LC8QWjfbSFDDXrX0lEN
        Auzoq3hTaf6E0KGHBForIWe0B4vmabqPX3ca8vttgvysN4pVMo/FGCu6s2dPCSDzdY9a/yIifd/BO
        njzlznkelJJcuNNSh6aKHVbXOilrfajTEJgOKR85NjMs5PgtuTQkp7JAoBA6pp0dz6cNJYLCRIHzI
        NGfBBq84DIlOBhk67bH5O5ZjDE+Q6rSzHEo+2JYLk4COq9G7EdIxkJ+wEvw6mkFVoxLHB+GXz1YRi
        ZNTilwEg==;
Received: from 189-47-75-109.dsl.telesp.net.br ([189.47.75.109] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pAy1O-00CmeZ-Jf; Thu, 29 Dec 2022 19:52:54 +0100
Message-ID: <27b562b1-ca1c-9b69-b9bc-bf5bcd004b9c@igalia.com>
Date:   Thu, 29 Dec 2022 15:52:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1] drm/scheduler: Fix lockup in drm_sched_entity_kill()
Content-Language: en-US
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     airlied@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        luben.tuikov@amd.com, Melissa Wen <mwen@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Christian Koenig <christian.koenig@amd.com>
References: <3f87a88c-c375-4a02-0f09-4831544e5f96@igalia.com>
 <41aecacc-44e5-1455-48cb-20e32187610c@collabora.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <41aecacc-44e5-1455-48cb-20e32187610c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/12/2022 07:15, Dmitry Osipenko wrote:
> [...]
> I'll push the patch to misc-fixes as soon as it will be rebased on
> 6.2-rc. Thanks!
> 
> Best regards,
> Dmitry
> 

Thank you Dmitry, much appreciated!
Cheers,


Guilherme

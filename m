Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41E7706359
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjEQIxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEQIxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:53:37 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4C181A5
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:53:35 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:33730.1113338956
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id 1FA161002EB;
        Wed, 17 May 2023 16:53:33 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-prw2v with ESMTP id 17a0017565504ef1b191c3c72f991489 for javierm@redhat.com;
        Wed, 17 May 2023 16:53:35 CST
X-Transaction-ID: 17a0017565504ef1b191c3c72f991489
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <53b02c0d-069d-e923-1c11-6da4e8d83470@189.cn>
Date:   Wed, 17 May 2023 16:53:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/drm_atomic.h: fixup typos
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, liyi <liyi@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20230517082322.3230271-1-suijingfeng@loongson.cn>
 <877ct79wu8.fsf@minerva.mail-host-address-is-not-set>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <877ct79wu8.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023/5/17 16:38, Javier Martinez Canillas wrote:
> Hello Sui,
>
> I would still add something to the commit description even when your
> changes are trivial.


OK, that sounds fine. I'm agree.


> Sui Jingfeng <suijingfeng@loongson.cn> writes:
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
> The fixes look good to me though
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3BC4706346
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjEQIsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 04:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQIsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 04:48:31 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EF1BB4C3C
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 01:48:26 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.31:59340.234832183
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.31])
        by 189.cn (HERMES) with SMTP id 1A8E11002E1;
        Wed, 17 May 2023 16:48:20 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-2qvwx with ESMTP id bb5ef2c8a7554d65add99f78c2e17e1f for javierm@redhat.com;
        Wed, 17 May 2023 16:48:22 CST
X-Transaction-ID: bb5ef2c8a7554d65add99f78c2e17e1f
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <9ccad690-15a0-82a6-f8b0-572323a42e3d@189.cn>
Date:   Wed, 17 May 2023 16:48:19 +0800
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
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, thanks a lot


On 2023/5/17 16:38, Javier Martinez Canillas wrote:
> Hello Sui,
>
> I would still add something to the commit description even when your
> changes are trivial.
Ok, I remember this, I will respin patch with this instruction in mind 
in the future.
>
> Sui Jingfeng <suijingfeng@loongson.cn> writes:
>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
> The fixes look good to me though
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

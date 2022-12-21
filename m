Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3A86533BC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:58:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLUP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiLUP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:58:26 -0500
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9649413D4F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:58:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1671638279; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=R4M5zinm++np+BA4HudMlH3uOWC0Mn1BnGE0uXGjJ1MREO6sgz+G3EdZvj13nVOUQ/rMR4fb8gPe/spJaoz4MDixGCw6yn1ir0r8iVSDlLleKBR58fs4OYZgnz3d0BQtU9ri90RGJfusGb+2ShvaGOneDef5ZnYU+A2f0uncZt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1671638279; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Of6vrR1lUd/EV67jSnxQeaQIY4MOTKhA+LjhfYeG4/0=; 
        b=TD6hAwMy8mgMDMS5vGQtPqAeZQrwoWM/2VDAivAHPZshz/RgmcXwBEIZg4KuwVF6qXTMsGKp4ELNi9w7hVPe7rN/bJB2/k2y8iePHERaePq+SnZH6z/Ff3C821OHHcFzBtfX9gWPk8SZzcUJYJAwoN6SwuWvSl46WHuQ7tQa8Ys=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1671638279;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Of6vrR1lUd/EV67jSnxQeaQIY4MOTKhA+LjhfYeG4/0=;
        b=oaRwvIHBMd8+sh8uRX1DWmJjMiTivq/CzkDAIb6qQWjc34F1Z2D5zVHdlUwvZRb/
        Wkf6XT+y0nmYbGa7g57viGT2t+vnuVF33dlnv1qPucvypxSrcuOcqmeKQXRFJQmU6lE
        2pF2g0WRyks0uRIMxm+21JqV3Xn6mUp9ckzC+2W0=
Received: from [192.168.1.9] (110.226.31.37 [110.226.31.37]) by mx.zoho.in
        with SMTPS id 1671638277556109.11418111263356; Wed, 21 Dec 2022 21:27:57 +0530 (IST)
Message-ID: <251def1c-5577-6b7b-4ebe-4a1feb4687af@siddh.me>
Date:   Wed, 21 Dec 2022 21:27:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 00/10] drm: Remove usage of deprecated DRM_* macros
Content-Language: en-US, en-GB, hi-IN
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
References: <cover.1671566741.git.code@siddh.me>
 <339505f3-9005-df0b-3c73-b54320568db2@suse.de>
From:   Siddh Raman Pant <code@siddh.me>
In-Reply-To: <339505f3-9005-df0b-3c73-b54320568db2@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21 2022 at 14:46:12 +0530, Thomas Zimmermann wrote:
> Hi
> 
> Am 20.12.22 um 21:16 schrieb Siddh Raman Pant:
>> This patchset aims to remove usages of deprecated DRM_* macros from the
>> files residing in drivers/gpu/drm root.
>>
>> In process, I found out that NULL as first argument of drm_dbg_* wasn't
>> working, but it was listed as the alternative in deprecation comment,
>> so I fixed that before removing usages of DRM_DEBUG_* macros.
>>
>> This patchset should be applied in order as changes might be dependent.
>>
>> Please review and let me know if any errors are there, and hopefully
>> this gets accepted.
> 
> Thanks for the patchset. Overall this looks fine.
> 
> But the use of pr_() functions is not optimal in my opinion. I know that
> I recommended using it, but at a closer look, I think we might want to
> reconsider that. I wouldn't like losing the '[drm]' tag, but adding them
> to each pr_() call isn't a good idea either.
> 
> I think it would be nicer to replace DRM_INFO with drm_info(NULL, ).
> Depending on the device being NULL, the helpers would select dev-based
> messages or printk-based messages. It would then work like drm_dbg_().
> But it needs some additional changes.
> 
> Can you first move all pr_() related changes into a new patchset? The
> trivial conversion were the device is known and not NULL can remain in
> this patchset and be merged soon. We can afterwards have a separate
> discussion for the changes that currently involve pr_().
> 
> Best regards
> Thomas

Maybe I can just cope for NULL in __drm_printk and change all pr_*()
changes in this patchset to the appropriate ones.

Something like:
#define __drm_printk(drm, level, type, fmt, ...)				\
({										\
	drm_ = __drm_print_dev(drm);						\
	if (drm_)								\
		dev_##level##type((drm_)->dev, "[drm] " fmt, ##__VA_ARGS__);	\
	else									\
		pr_##level##type("[drm] " fmt, ##__VA_ARGS__);			\
})

Thanks,
Siddh

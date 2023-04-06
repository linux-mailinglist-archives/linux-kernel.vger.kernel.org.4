Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15386D9541
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 13:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237926AbjDFLch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 07:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237770AbjDFLcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:32:18 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6FE9744
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8YyNubASXgqzuAszxAEBZMdUvN7vGFCZr8m0DMH+wl4=; b=Qjge+YxKanAjlN/WTvbJxc46ib
        bRUwXsrnKAVK6pvWJOKwoBzP/kn1Q0tzUIYdhDoB8a0PI3vwq5RgCAEFA19+aTazBJ3FPrljyvb7G
        URiksvI1rpfZl2pk/YOglMpZusik2fJqwQsH561oFIdLh1FnTsLjLAIMFiDPl1+/ui2BLPWyxk+K+
        eJJIUxes7siMIMrIMa+JNvJ3g6Xfd4gpbQHtR87m0Sd4AyfWuYMMolFHRdKt/i3ZFYOO07t2VAoKo
        YJ62CncxoL7ZjMtFUZhPNAcDmUH48HbXsS3e5RG0GHV1cP/whdvSEnVQt1dl7h8G1hVSFQkoR2UDj
        m0ICheMg==;
Received: from [187.36.234.139] (helo=[192.168.1.195])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pkNqN-0080Ca-UI; Thu, 06 Apr 2023 13:31:55 +0200
Message-ID: <b2cdb1fd-2559-5ae7-7d3c-0706969a85e2@igalia.com>
Date:   Thu, 6 Apr 2023 08:31:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 0/2] drm/vkms: A couple of trivial cleanups
Content-Language: en-US
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Marius Vlad <marius.vlad@collabora.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        dri-devel@lists.freedesktop.org
References: <20230406110235.3092055-1-javierm@redhat.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mcanal@igalia.com>
In-Reply-To: <20230406110235.3092055-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Reviewed-by: Maíra Canal <mcanal@igalia.com>

for the series.

Thanks for helping to cleanup vkms!

Best Regards,
- Maíra Canal

On 4/6/23 08:02, Javier Martinez Canillas wrote:
> Hello,
> 
> This series contains two trivial cleanups for the vkms driver.
> 
> Patch #1 just gets rid of a wrapper helper that wasn't really adding that
> much value and patch #2 drops the <drm/drm_simple_kms_helper.h> header
> that was only used to call the drm_simple_encoder_init() function helper.
> 
> Best regards,
> Javier
> 
> 
> Javier Martinez Canillas (2):
>    drm/vkms: Drop vkms_connector_destroy() wrapper
>    drm/vkms: Remove <drm/drm_simple_kms_helper.h> include
> 
>   drivers/gpu/drm/vkms/vkms_output.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 77d08a2de6a43521f5a02848f11185b6f46af21c

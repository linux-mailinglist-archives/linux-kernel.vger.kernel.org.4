Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D338658B96
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 11:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbiL2KSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 05:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbiL2KRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 05:17:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA91313FAF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 02:15:14 -0800 (PST)
Received: from [192.168.2.235] (109-252-113-89.nat.spd-mgts.ru [109.252.113.89])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B5B5660036C;
        Thu, 29 Dec 2022 10:15:11 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672308912;
        bh=0kQT8Bh1gpTI0PhTVbpVVPlgGNzAygaDOS3KBPSE7kU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=C69GwGwqAdptSU2nE5YnNU+Zs2QRdOblVvLaqpzlNVf6V+g84Y5P+5fr1s49N7wmX
         Eys8dD9ikMyekdpwuql8FK1NcH3WMPcW7FP3hZtGLME3nnl2DgcCWEFaNtNt3LQaG4
         8pkMYaIk9kbx+Mxb6JqdRlTRfmaFCrKveX+QcemDz0YV7udfOQnV2d4CgKeXAf5nZc
         gUHOO39HdVGxi8siBJ0snIgZAuOA9lxqSKI1Z1RQWysDde372JfZ3Pm6uGIA5EomCP
         py34SBKYg28JW0/ep3U9rn51D6hwljmpZaJPKCl7VSb0IeVPGrWId7m9M9v/SunmKo
         jLmO0VgLFe40A==
Message-ID: <41aecacc-44e5-1455-48cb-20e32187610c@collabora.com>
Date:   Thu, 29 Dec 2022 13:15:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v1] drm/scheduler: Fix lockup in drm_sched_entity_kill()
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Christian Koenig <christian.koenig@amd.com>
Cc:     airlied@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        luben.tuikov@amd.com, Melissa Wen <mwen@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>
References: <3f87a88c-c375-4a02-0f09-4831544e5f96@igalia.com>
Content-Language: en-US
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <3f87a88c-c375-4a02-0f09-4831544e5f96@igalia.com>
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

Hi,

On 12/27/22 22:28, Guilherme G. Piccoli wrote:
> Hi Dmitry / Christian, thanks for the fix!
> 
> (And thanks Melissa for pointing that, saving me lots of time in
> research heh)
> 
> Is this fix planned to be released on 6.2-rc cycle? I've just tested it
> on Steam Deck, and it resolved a lockup observed (since v6.2-rc1) -
> exactly the same thing mentioned in the commit message.
> 
> FWIW:
> Tested-By: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
I'll push the patch to misc-fixes as soon as it will be rebased on
6.2-rc. Thanks!

Best regards,
Dmitry


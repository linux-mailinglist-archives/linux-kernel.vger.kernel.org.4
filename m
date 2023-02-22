Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C523B69F83A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 16:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjBVPjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 10:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbjBVPjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 10:39:51 -0500
Received: from srv6.fidu.org (srv6.fidu.org [159.69.62.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F616EBC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 07:39:21 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by srv6.fidu.org (Postfix) with ESMTP id 5E251C800A1;
        Wed, 22 Feb 2023 16:39:08 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at srv6.fidu.org
Received: from srv6.fidu.org ([127.0.0.1])
        by localhost (srv6.fidu.org [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id omRYXuwRoT6b; Wed, 22 Feb 2023 16:39:08 +0100 (CET)
Received: from [192.168.176.165] (host-88-217-226-44.customer.m-online.net [88.217.226.44])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: wse@tuxedocomputers.com)
        by srv6.fidu.org (Postfix) with ESMTPSA id B3F6FC800A0;
        Wed, 22 Feb 2023 16:39:06 +0100 (CET)
Message-ID: <647c8ea1-4f3d-1538-a78f-b71122e9c4f9@tuxedocomputers.com>
Date:   Wed, 22 Feb 2023 16:39:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/2] Add quirk to disable PSR 2 on Tongfang PHxTxX1 and
 PHxTQx1
To:     jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        airlied@gmail.com, daniel@ffwll.ch, jose.souza@intel.com,
        jouni.hogander@intel.com, mika.kahola@intel.com,
        ville.syrjala@linux.intel.com, lucas.demarchi@intel.com,
        Diego.SantaCruz@spinetix.com, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20230222141755.1060162-1-wse@tuxedocomputers.com>
Content-Language: en-US
From:   Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20230222141755.1060162-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 22.02.23 um 15:17 schrieb Werner Sembach:
> On these Barebones PSR 2 is recognized as supported but is very buggy:
> - Upper third of screen does sometimes not updated, resulting in
> disappearing cursors or ghosts of already closed Windows saying behind.
> - Approximately 40 px from the bottom edge a 3 pixel wide strip of randomly
> colored pixels is flickering.
>
> PSR 1 is working fine however.
>
> This patchset introduces a new quirk to disable PSR 2 specifically on known
> buggy devices and applies it to the Tongfang PHxTxX1 and PHxTQx1 barebones.
>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
>
>
Parralel to this there is a patch fixing the root cause of this issue: 
https://gitlab.freedesktop.org/drm/intel/-/issues/7347#note_1785094

So this quirk might only be relevant for stable kernels, depending on when that 
other patch gets merged.


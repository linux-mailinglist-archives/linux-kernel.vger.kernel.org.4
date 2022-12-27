Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDF3656E55
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbiL0T3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:29:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiL0T3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:29:04 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21B51C2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From
        :Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EB1EKzN3ai6ze9SRsR9S4454yQU2uLLWQ5OZm9VPszk=; b=hnZx4cNlF9vuqStU1wBNKgPCr/
        FOixaDQYI0qbQscSfi/Jrhp4TJexXfUaavjFKJhfWHKXgbu5H0pZ+vrHoiRPHYWkqAFPOR9ZbV7Mo
        gfWuI8al/63vT3a9joAX3vgveFs+OMs/004QZimUjF9iAQuWlXIwQ+4FOPznf7fQd/i3j4D4FIvLs
        OuwCpIcbIUwX+W466StSVMa9x+XHmUIi17AVx0tGlKRgRU2rWrao0NZmLGPD/r+vppiLULprNnwIj
        d+QeYRR5BY/tAGaxmL6diRyv3rfztKDK6uqz+w8+4of/Oyu6yLgV9v4DYjoyg9F5qPBFlMRVtwhlD
        q/aoDZyA==;
Received: from [177.103.98.201] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1pAFd8-00BKsL-70; Tue, 27 Dec 2022 20:28:55 +0100
Message-ID: <3f87a88c-c375-4a02-0f09-4831544e5f96@igalia.com>
Date:   Tue, 27 Dec 2022 16:28:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     dmitry.osipenko@collabora.com,
        Christian Koenig <christian.koenig@amd.com>
Cc:     airlied@gmail.com, Daniel Vetter <daniel.vetter@ffwll.ch>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        luben.tuikov@amd.com, Melissa Wen <mwen@igalia.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>, gpiccoli@igalia.com
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: Re: [PATCH v1] drm/scheduler: Fix lockup in drm_sched_entity_kill()
In-Reply-To: <20221123001303.533968-1-dmitry.osipenko@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry / Christian, thanks for the fix!

(And thanks Melissa for pointing that, saving me lots of time in
research heh)

Is this fix planned to be released on 6.2-rc cycle? I've just tested it
on Steam Deck, and it resolved a lockup observed (since v6.2-rc1) -
exactly the same thing mentioned in the commit message.

FWIW:
Tested-By: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck

Cheers,


Guilherme

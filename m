Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13D6A2939
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 12:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjBYLIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 06:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjBYLIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 06:08:41 -0500
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962A816AE4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 03:08:39 -0800 (PST)
Date:   Sat, 25 Feb 2023 11:08:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1677323316; x=1677582516;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dmZJ3blwc/a2BHKtjRPKieHAlthKq3OHiYt2iVRf44w/S5uZu2gyuOXLp0oZ730c1
         CJfxtW0NdRZOr5FZlKFhcCxt4SUmxm2emyB4xbb39MVNueOSWGCaCATUVGFgrNnX+/
         JalOTufubWz3sbfvOHwcLOKQpcglZmpEAvZ0ZU7tBWRe6z84imrgmoLwXax3chDRdb
         X8fvVS1lZUGneCMx+qD+CIAEGJPSwhXWujxwm/NctcSUdKZVc0G551JNhkIV5dLxTr
         U9x/b+39DmYqy6y1/ueKekUw5H1PEX/vmkTluDfTCmHIC9cWcpmSzYK+v5bmxZl5wv
         qspTRCZcaLjrQ==
To:     Petr Tesarik <petrtesarik@huaweicloud.com>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        petr@tesarici.cz, roberto.sassu@huawei.com
Subject: Re: [PATCH] drm/prime: Fix documentation of drm_gem_prime_fd_to_handle()
Message-ID: <GLe6vWnaxm8W1VD0ltNz62HDAhn5b1rgraCJchuToDl-vb5m9gsGl2ml2xeTQfRwlWlTQXvqOUzYiSgz1GmOk76Jag5VR7Pzwm0iM-86igQ=@emersion.fr>
In-Reply-To: <20230224120931.1024-1-petrtesarik@huaweicloud.com>
References: <20230224120931.1024-1-petrtesarik@huaweicloud.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9656C1074
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 12:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCTLNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 07:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjCTLMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 07:12:53 -0400
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7064DBE1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 04:10:11 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:10:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail; t=1679310608; x=1679569808;
        bh=dJZln88lN2ZOtbXwmt+yMlSaTT1Nk8VC901yTzLI2ig=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=h/4qo/V8KsRx1BwwYxr3xodV6q+lYad3q+r0EcS/2CoA8PV9x+NVV7I0jH1P/QAB8
         ELC93I7D0Uk7mw8GsGiJX3zwqnvKF7oYVJHz10YIQPAaE+S/mCF+GrhqMFTynfGZrs
         8x3HoihoypOg47284V0pw4AAFx1mKL+j2qBFfsK1MSoNBU4Zw77Rbx0uS8MEwz0qPP
         p+j6woXdglZ/rERdXVXHPpiAmKhgHpt8hkF/gVUanEMvVl4QTDwgMluArU3iZrzLSD
         i1A4lLWx6H9/Md+9k3svYD20k298UYZgz7u5VV4XdRbTNm9Qydo8aXtUDi8GoLD5v2
         nNlbkw8ZyX6vw==
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
Message-ID: <Df--jGGCv5NJg1pmpWj1t2W6ndLBt56vWwEpi81s22ddGn39zPZOq1pdEaRud5P8PqiRexkHjTiByoOi0IEl_7pTQsrNFWLOmlWYGRUzWds=@emersion.fr>
In-Reply-To: <20c0416b-90f7-7fa3-5f32-a44400817f4d@huaweicloud.com>
References: <20230224120931.1024-1-petrtesarik@huaweicloud.com> <GLe6vWnaxm8W1VD0ltNz62HDAhn5b1rgraCJchuToDl-vb5m9gsGl2ml2xeTQfRwlWlTQXvqOUzYiSgz1GmOk76Jag5VR7Pzwm0iM-86igQ=@emersion.fr> <20c0416b-90f7-7fa3-5f32-a44400817f4d@huaweicloud.com>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pushed to drm-misc-next, thanks!

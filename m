Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA625BFA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbiIUJLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiIUJLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:11:40 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023C289CCC
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:11:36 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y17so12137065ejo.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hlC2p+E/yc6bwCFB5rHdNjGD3v4BzbiXxKD6+IxrA4w=;
        b=Jx0F84042gQuC89Ameu9TN2kZwDhxx/lJ5KA/eLm1Uwq9Z8TCHSQYr/2G+Ebtvl4Yb
         Qix3GWI32LGeKyNNC76h5+V3GISpuVL31z20P7lb1J1QduuILrRJTBxhYPbxNmzKgKoY
         YoNDA7tVKJZVcm16TziNbtw1sibOjFtmVrWew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hlC2p+E/yc6bwCFB5rHdNjGD3v4BzbiXxKD6+IxrA4w=;
        b=atUEqfQbDHJ2L7sAlkig9SWvA1pYeNnDsL/6O/FEHf0+OsFZKp6fvHe0MP/Z8g3BWl
         YbVMYv3Lwp70FdlnKKoF6g4yCBZy7fPDwJ17ru5nN/zxN9rqR6ycdhR2GlhUUniaKQJ1
         38cu5yAzgrE2FY3oBVVZ5eWLp66511O3DiwR8CgEiQTmVpsQ+dteRDsHAZqOJmbYcsMv
         F0rueXRMKEUz7V57Ze9yaNGkxofCCrX/RyZc6U641AwhHjuAbYJom3HcK5xSQVawC3D9
         zThcAHv93kbmzjTWIHXiPZB/Av5Cu/i7Kj/G214lTzWKFXHcD+5ge7f+KE8R7pWnxeP/
         yQdQ==
X-Gm-Message-State: ACrzQf1B8ufGiAFAGIyHMALvxsIcK3XnfS89jgoTOpxFILe9ECQRZjqB
        CLiIDUJghrjeypTmXuKtVbTrhzzdhq0WS5jr
X-Google-Smtp-Source: AMsMyM6gh29yNviXmhHMEYJUnt8aXyuQYYrcsm6GXA5KZueXMCxCcEDVGE/tBgDtIPB4CaOg0x+cPQ==
X-Received: by 2002:a17:906:5a4c:b0:76f:3e98:b453 with SMTP id my12-20020a1709065a4c00b0076f3e98b453mr20386077ejc.509.1663751495050;
        Wed, 21 Sep 2022 02:11:35 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id r14-20020a056402034e00b004478be33bddsm1469726edw.15.2022.09.21.02.11.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Sep 2022 02:11:34 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id w28so7669004edi.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 02:11:34 -0700 (PDT)
X-Received: by 2002:a05:6402:3547:b0:451:3be6:d55b with SMTP id
 f7-20020a056402354700b004513be6d55bmr23668147edd.57.1663751494159; Wed, 21
 Sep 2022 02:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220920-standard-menues-v2-0-a35af3243c2f@chromium.org>
 <20220920-standard-menues-v2-1-a35af3243c2f@chromium.org> <YypjfCLkmHRrsD66@pendragon.ideasonboard.com>
In-Reply-To: <YypjfCLkmHRrsD66@pendragon.ideasonboard.com>
From:   Ricardo Ribalda <ribalda@chromium.org>
Date:   Wed, 21 Sep 2022 11:11:23 +0200
X-Gmail-Original-Message-ID: <CANiDSCsk7nOTjW2j08LM4++221TXTrZHpMuJwtBF8rHp_x+MZg@mail.gmail.com>
Message-ID: <CANiDSCsk7nOTjW2j08LM4++221TXTrZHpMuJwtBF8rHp_x+MZg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent

On Wed, 21 Sept 2022 at 03:06, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.

Thank you for the review. I think I have addressed all your comments.

I have tested it on real hardware at
https://git.kernel.org/pub/scm/linux/kernel/git/ribalda/linux.git/log/?h=ribalda-next

And this set conflicts with the v4l2-compliance one. So I have rebased
this set on top of the other one.

Thanks!

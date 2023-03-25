Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824226C8C12
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 08:07:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbjCYHHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 03:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjCYHHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 03:07:14 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A816E166CE;
        Sat, 25 Mar 2023 00:07:13 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id eg48so15954988edb.13;
        Sat, 25 Mar 2023 00:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679728032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Q0JH6W4/yY2MilP9/4zYKwAOQZp+GiB+9fzoz6C1dc=;
        b=kUBMkODkInJF27YtBQrcC6Nm5HrEiTr+mNjOq2KIOYwWKfd47NPu6ebm5shYZN1cbp
         VxxdDcljYPc33BNhd1wQQQsCe2g7P8cf2ZmX4Q9UeHNde212WYIo+8YZCs888vY3TeB2
         I4qvzTyb9KAYxfHDn3kBU8kDkjVAW/GbeEhXoTkKrLWqCVHZucn+ozpQ+XjybpxoOwg2
         muB2bouPnn/eRMkFhT4jPT/cnCQKazH3RCtrALN1MQE5gfq6aQSasLOQR5QYAzaI5D4q
         ouzqF6FB5whyLOvtdZHCrAeOm4gqpy4bdUsNFtslhc96F/p6OT7i8bimDngCi0cWaQCt
         DbHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679728032;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Q0JH6W4/yY2MilP9/4zYKwAOQZp+GiB+9fzoz6C1dc=;
        b=IAfa4Bjv27vDKOLKaAXk+3KEp76Zxp2bgnja8fZhEV0qPCJyB6nHOZmkpnbqNHSqrY
         izrnfzCbyaZzArJNkJEzvmRRbQOj8HII83UUJ8PbchNVdQVZVbIBDoAwJ7RSUPFrDjIO
         hEi6o6P2OJs/soOqHrPEXoFktmQrTiLYrhRQZANSPs7S2aISBGtOoYavibMTYOq6gPyh
         Exd8AooT8TnlETvYLUiOpRYlN36BKevFOnKpC0EvJPQuPNZgRg+akzGSUc4dsHdy0S/f
         23fgo1uH6Ra75lRemdEmnaH9Rl1zEYfxWBW0bO4Tg4cSqitQaJooN5r0j9/uPKHHlZzT
         5dcw==
X-Gm-Message-State: AAQBX9efbBrU83K77QeiYjrSOawYoT3gFuwS6rYwEc9vPJ1F/XOc9Ngl
        Oih7qTOyMbI4ecOGZOWv10J1FhNXSiI=
X-Google-Smtp-Source: AKy350YzkkEr+eWLFvy3HtMXGEGhUEod/T9NIEQXirQUXevaNPV0e6du5VZvgcfYic5BjjeA7SqNiQ==
X-Received: by 2002:a05:6402:3445:b0:4fd:2b05:1722 with SMTP id l5-20020a056402344500b004fd2b051722mr5004664edc.7.1679728031897;
        Sat, 25 Mar 2023 00:07:11 -0700 (PDT)
Received: from kista.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id u5-20020a50d505000000b004c09f0ba24dsm11801358edi.48.2023.03.25.00.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 00:07:11 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Adam Pigg <adam@piggz.co.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH 3/9] media: v4l2: Introduce compressed pixel encoding definition
 and helper
Date:   Sat, 25 Mar 2023 08:07:10 +0100
Message-ID: <4786897.GXAFRqVoOG@kista>
In-Reply-To: <20230324151228.2778112-4-paul.kocialkowski@bootlin.com>
References: <20230324151228.2778112-1-paul.kocialkowski@bootlin.com>
 <20230324151228.2778112-4-paul.kocialkowski@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 24. marec 2023 ob 16:12:22 CET je Paul Kocialkowski napisal(a):
> Some pixel formats (such as JPEG) have their data compressed and
> encoded in a specific way, which is not directly YUV, RGB or Bayer.
> 
> Add a new definition and helper for compressed pixel encoding to
> represent this situation.
> 
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



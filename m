Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3FE62CF23
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 00:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiKPXyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 18:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233023AbiKPXyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 18:54:07 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A4F560372
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:54:07 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id c203so111384pfc.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 15:54:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKLh4nbG4Qk0R0afjpKyHapW+0zwGvWxJ/QZwrLbzaU=;
        b=dvcFIYe8HehEzFplwKB93F9O/TNw95uNq/vU3FgzpCV+oeorRSSFg/HeVg7YALNa+8
         OdrvT7mjsrDOoDEdYfLJse43jVBS8OIvzEQoTwZJwd7NmIN+EukDg2s2sr9CX5Gqpayh
         ita6hX+AFJbppb2A2tAuJveqcLXIXKzIw7gYrh7PVmjPXF1LobDUR1DOiJSgkM7Js32D
         pa8J4s2mYJ9+c75pnfi4Dg8t8BwAzpCA+0pIXaRDafcJRL7RRSlW4nqGuU3sBm2XQECW
         WtPb0eSbDoyBWmmdsNFybU+vIm00rfBUjxE3FM+l3Gv+xDWgAtKs0aRcVHH0gw4/jh4q
         q7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKLh4nbG4Qk0R0afjpKyHapW+0zwGvWxJ/QZwrLbzaU=;
        b=KYMEYuEXZK4bAqUGJfs5spZLbgxStJvvosV7+IOyihi3WAIbCZ3RRGh6QVseuMH/aH
         +Vf3hk5h15WYCWYumNktsenQ3QPb5QzJifBIS8B+odWOzbw77Id3xSWNtKybw7tHo7QJ
         lhJ8yQOtSTcKxyrPtYph/yHXOWGesFqJ30ruaLyaVUdDKGBY610nKWybFU8yatLxXMnH
         CE4mwgmtbUv+TtyhQDnPpS7qLtT19BjR5Yi9hWxcl0RbVMAf4gwAHoOHaJ0htYMg7IlO
         ezzbdynTG9hz0JeNdT+H7wRF372yXv0RZ+MJQfp2TNRw9jUk1ljt9QCfTwbx5LT7IqCN
         8jQQ==
X-Gm-Message-State: ANoB5pn3z9NcddHFoedUcJOqjFhiOhzVORqN1GkqOkBjzapyD8y8KeGJ
        yr6/Uc3zZm5cB/XF7k4xMLJK/utyhHM=
X-Google-Smtp-Source: AA0mqf4CGrAn2ypkAOFajk9B2STQb65zhMm1nKqDeA51MIPFZ6Scn9aHiYYBaPDGkQogQ7C9OgFe1A==
X-Received: by 2002:aa7:8d06:0:b0:56d:570a:ef1c with SMTP id j6-20020aa78d06000000b0056d570aef1cmr427339pfe.22.1668642846402;
        Wed, 16 Nov 2022 15:54:06 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb51:2ecd:7287:8649])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b00186b04776b0sm12832475pli.118.2022.11.16.15.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 15:54:05 -0800 (PST)
Date:   Wed, 16 Nov 2022 15:54:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Prashant Laddha <prladdha@cisco.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] fixp-arith: do not require users to include bug.h
Message-ID: <Y3V4Gt3OVR1BQ2/W@google.com>
References: <Y3SgVdVey9legtX+@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3SgVdVey9legtX+@dc75zzyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 10:33:25AM +0200, Matti Vaittinen wrote:
> The fixp_sin32_rad()() contains a call to BUG_ON(). If users of
> fixp-arith.h have not included the bug.h prior including the fixp-arith.h
> the compiler will not find the BUG_ON. Thus every user of fixp-arith.h
> must also include bug.h (or roll own variant of BUG_ON()).
> 
> Include bug.h from fixp-arith.h so every user of fixp-arith.h does not
> need to include the bug.h prior inclusion of fixp-arith.h
> 
> Fixes: 559addc25b00 ("[media] fixp-arith: replace sin/cos table by a better precision one")
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

Applied, thank you.

-- 
Dmitry

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEDCD6A3BAB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 08:23:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbjB0HXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 02:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjB0HXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 02:23:18 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F38FB442
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:23:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id r18so5117195wrx.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 23:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=InPnkM8NHOwVAlAHVMP17m0ZROfItRQFV6JlGSsqPgc=;
        b=eN+YM348oSNBYu9bE+/139yGNbbjYtmLJeppjYOfFZZbb8OSKaLsGSkFo9kX5BJa8M
         DDTTWrEjolLEA5419o9Mkyu8+an2B0lp2whNihFGZvMu3DBQL5wMoS6Whs7qONzYRxkQ
         w2WploIg8rUCuJ/SXjD2JDWCtDvCBGfa76CWUjBqqueGPXdPjw8VmrAvBMelhgN8PNAP
         GnXYSRsSqdkbLhmxr+xdxhclIorhPMQ58h4T9Pmi03akqfkLW+8cV3Caf8+o0ulpeerI
         hlgyGma8g5VtRtHbATubVOA2wYNZ+zUjQTMa/T6ed5+HEEFD3baelCgtjXFN17EMFzcr
         8XTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=InPnkM8NHOwVAlAHVMP17m0ZROfItRQFV6JlGSsqPgc=;
        b=NWfBJWNbH0BzeZIRN5kjQ9U6s6Laq6qqCNhWJ06FlK1JPg8wvfY0JJaC3oDjNbkVks
         Pv1G6BeGHYGe8kdrOvakacGlSMf1rhKzYUEgH/Lo2Nvs4HrhZyhLX3voPdNUa7NOY+gH
         BpdD9/p0yzh1Z2FHYZAj+EdFWMb2+RR5pk4vaQyZVq3Use+aFofj8XP0R0XFS3wVrUOQ
         9poTgt94Exn6hEQcASpyWsX075Ff5OlezgNuQa1VtgVeTw7eZCqPm63u+CO1Dj/HpRup
         0gZUuW5sdRNB2WJQ5d+IgYsgc/PkohURBDPJtlF6k1q6r8SIBq7hl6ej9Z17I0UkW7Yy
         8Y8A==
X-Gm-Message-State: AO0yUKXKEsk+4yKHd9CpalQwPcsarihxTVbGLmqyhven7QdcK15FmNHp
        b6cN+Q1YCq6tDE9BI/ccm8c=
X-Google-Smtp-Source: AK7set8zUmOM7r6ONEZ/XM/ecICQnd5Os6zYo6/uphRo+BijSp8jj7AaZy56b26n+Zt01cA0ZwQ5UA==
X-Received: by 2002:a5d:4ccf:0:b0:2c9:c90d:6869 with SMTP id c15-20020a5d4ccf000000b002c9c90d6869mr5551277wrt.42.1677482595823;
        Sun, 26 Feb 2023 23:23:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q10-20020adfea0a000000b002c567b58e9asm6262303wrm.56.2023.02.26.23.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 23:23:15 -0800 (PST)
Date:   Mon, 27 Feb 2023 10:23:11 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Kang Chen <void0red@gmail.com>
Cc:     paskripkin@gmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: add a null check of kzalloc in
 go_add_group_info_attr
Message-ID: <Y/xaXw9LAOizJEBL@kadam>
References: <20230226132500.3933232-1-void0red@gmail.com>
 <Y/w16PI4klfJaeXA@kadam>
 <CANE+tVpqZusCq4EXi7UV+jY0XBG+9x6UWh_JGCWKs3pZRMFBXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANE+tVpqZusCq4EXi7UV+jY0XBG+9x6UWh_JGCWKs3pZRMFBXA@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 03:11:21PM +0800, Kang Chen wrote:
> Hi, Dan,
> 
> Thanks for your review.
> I noticed there is no error handling in the origin design (this call chain).
> go_add_group_info_attr returns a len-like value indicating the length
> of pbuf.
> I don't think throwing an error to the caller is a good idea, the caller
> doesn't seem to care about it.
> So inserting a netdev_dbg or pr_debug here might be enough.
> Do you have a better idea?
> 

The bug is real, yes.  But you have your static checker which can detect
it and I also have an unpublished static checker test which detects this
bug.

drivers/staging/r8188eu/core/rtw_p2p.c:106 go_add_group_info_attr() warn: 'pdata_attr' was never checked for NULL

If we just hide the bug enough for so that the static checker cannot
find the bug then we're taking a step backward.  When this driver is
ready to leave staging then normally I review every static checker
warning.  But if we hide the warning then it will never be fixed.

regards,
dan carpenter


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411F6634357
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 19:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiKVSJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 13:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiKVSJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 13:09:15 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2C7CB8D;
        Tue, 22 Nov 2022 10:09:12 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id jn7so12569245plb.13;
        Tue, 22 Nov 2022 10:09:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KRMhYB9UPO2WtEP0UfvsFBZ6e6YdwWgScP76/C9Yycs=;
        b=M+5E7ETSufWPx+E2mZBDiYBpsWvhg9NS+0oud8xN7L+y/ywZzwWx/9Yk/wEeBqhXWv
         7HrtF9k+BVmfh30B3TvMo3srXrtTKrKImB11ADbg1f6WsBv8/+LRwJRqE2Q2ZoycdkUM
         yVYfNaFdBfvZtt0zDSu2yVoH73SydK6cyBkNUXm1Xvd8zNFMJAs2SwlqDJbo++OFjXNf
         yJNhBwgY6ZC8S79K4yR70xw96ZczaPZj9p6nLble4XdItCPmSGZ/FyJbZVjHQ1/2TECb
         4W2ozvOAxBJZkfCy7UCiNbT9O5FjRR1FKuS74TUBYfJMPe0ds2AH3L+N7xW4T2fSVNyO
         J3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KRMhYB9UPO2WtEP0UfvsFBZ6e6YdwWgScP76/C9Yycs=;
        b=en4BCtfh+3sJ6myaPGF149TuHOgHhjfTKoBlzMNi2PZbmg9SZ/FNhU1MfYCdd+Zc2m
         r2/Eac6v1ZDZiuomSzTcJqsPeEoggMuD1IriMbf6yp0G1MG56/Lto2NwP+xGX9D8qIZl
         qSm68MFoVd435+aSKoEM7G/r01oQGY1/k04paipz6vimT0uE9Vb4c7PX2GZZbfbvXu1p
         YNtP37vqLPxcsL4IVCzkEIuz8xn4feu4OszatT72reipjfygsKxsUsU0hmHe4EpYGd3F
         GQ2CoIfwQoYpqa8h/DznGPu/AuqoWEeIUDs//eXRT2nW8G5vartb29kXaTksj6eJ6uOK
         HKlQ==
X-Gm-Message-State: ANoB5pkxT3A2rKcG5+jUfD1PIuWKb0Y3WfM0FiN7H6GvqvGJEay9WJOS
        RQlj30LopA6yEZ2QIcgu5C8g3qhodzX4STnwC/g=
X-Google-Smtp-Source: AA0mqf4AGbu14xUfrouQH/rCMsj54a7vqxbpp4i6D4+jiZZqOK8c52s9h5B66FphmMpWdVoYct8FUOYE5AJyW6IBqDc=
X-Received: by 2002:a17:90a:4147:b0:214:2214:869e with SMTP id
 m7-20020a17090a414700b002142214869emr33794590pjg.76.1669140552412; Tue, 22
 Nov 2022 10:09:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1669013346.git.Sandor.yu@nxp.com> <be4532b834109595b0fbf3562bf072caf2852a01.1669013346.git.Sandor.yu@nxp.com>
In-Reply-To: <be4532b834109595b0fbf3562bf072caf2852a01.1669013346.git.Sandor.yu@nxp.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 22 Nov 2022 15:08:54 -0300
Message-ID: <CAOMZO5AwwyZofwQNRnamNiLcj74HayNgocKsKx9epNGm8O-8-A@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] drm: bridge: cadence: convert mailbox functions
 to macro functions
To:     Sandor Yu <Sandor.yu@nxp.com>
Cc:     andrzej.hajda@intel.com, neil.armstrong@linaro.org,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
        daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kishon@ti.com, vkoul@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, alexander.stein@ew.tq-group.com,
        kernel@pengutronix.de, linux-imx@nxp.com, oliver.brown@nxp.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandor,

On Mon, Nov 21, 2022 at 4:27 AM Sandor Yu <Sandor.yu@nxp.com> wrote:
>
> Mailbox access functions could be share to other mhdp driver and
> HDP-TX HDMI/DP PHY drivers, move those functions to head file
> include/drm/bridge/cdns-mhdp-mailbox.h and convert them to
> macro functions.

What is the reason for converting the functions to macro?

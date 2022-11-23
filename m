Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D925635272
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiKWI03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235846AbiKWI0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:26:25 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA767FC708;
        Wed, 23 Nov 2022 00:26:22 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id i131so20081572ybc.9;
        Wed, 23 Nov 2022 00:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+vdSZUc9Cdn1ZhJJ+Fng27BZDbqUH9AaKPQTnbAy+Bg=;
        b=M0XAuBQmpPt9pujQvqUHu35tYqAZwS+WBIzqVJH7bcdmzt3KK5cIHKAIL1da3c8AB4
         MD8lWbHSozfZZ3qQmWKJ6jPOXf3OrVEH9UrgGPmXHUM7pSkC5dk8sePdH85APmj5tGKZ
         sWrWKv15KtBcu4mkgN0gXtiNEz2Qstkh4+YMaXdzzcPBqc3+qU9jWhLKdFmQ/V8Yhs8W
         vVu79A+t9pLWywG7rMWx3OiXOjzbvxelGk17j1+405UfvWjNDj0zbesGTvPeYaNjNXIx
         LZa3gPXq/paolCcjOH86Gb0oLx+2RPvNdp8vinlAioi0J5Jx61Tuye8nByVgpnkq5UBt
         NnCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vdSZUc9Cdn1ZhJJ+Fng27BZDbqUH9AaKPQTnbAy+Bg=;
        b=aFz5oiwEyGjebRgzM6jZM/ltFt6Fflql2lk2XJeGtwbnqxDiXr66Yowriw34NfEw+W
         bGhMMMlC6afrcckLDPqKyw5wtwMCH0Qp/4gsdE6QgkMTLvw2FSi/lbS6d0jZmrwD0jIa
         yls4yjPLZM83iXzbzE+zScuZpYZiXu8lTPMZjzqSrcbfeGthXg9WPwaRc3dwNVr9LbiP
         b6dTpQlAlNLJvSuW6fhpjT2C/NcRgdcp+SazCdvANT7UtE2oHAZj3L+uf9GzNzvy2z3y
         I5NgcpALPEzMTZTMT72kqh9ZXVYzd7wB7PeXi9koWQO+OiVvtEGu3+rJwsVa+YGmA0SE
         SyTg==
X-Gm-Message-State: ANoB5pkAlEOWuCJhNGXj6x+B7yOqRufFAVCmlPANz8wctWj8OzXio3Qy
        qa++CyqD54yowt1W76r2edKMWejurlj87xRioeE=
X-Google-Smtp-Source: AA0mqf7LtWV3L4qOZbf/svyFsK/ngz1Evoo8n+CSOf2TWrYIx7V+QH0FNPMCuKl9E67tRfAtXQ8DJFnAMP0oaX+QLtY=
X-Received: by 2002:a25:5cb:0:b0:6e7:868:405d with SMTP id 194-20020a2505cb000000b006e70868405dmr13744528ybf.389.1669191982012;
 Wed, 23 Nov 2022 00:26:22 -0800 (PST)
MIME-Version: 1.0
References: <20221122132330.30408-1-lukas.bulwahn@gmail.com>
 <20221122160937.GB39395@tom-ThinkPad-T14s-Gen-2i> <CAKXUXMxk-YoG4TdB8Em+cEMF8NA7rdMAboQz8nmhfVmVQ8oATA@mail.gmail.com>
 <Y33SxLh9xD8fQHAo@kadam>
In-Reply-To: <Y33SxLh9xD8fQHAo@kadam>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 23 Nov 2022 09:26:11 +0100
Message-ID: <CAKXUXMwZ=t0wW8FPSnsJ2EjFMQGv=nfADXzB=RKropHAyNhvRQ@mail.gmail.com>
Subject: Re: [PATCH] media: imx: remove code for non-existing config IMX_GPT_ICAP
To:     Dan Carpenter <error27@gmail.com>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Nov 23, 2022 at 8:59 AM Dan Carpenter <error27@gmail.com> wrote:
>
> On Wed, Nov 23, 2022 at 08:56:06AM +0100, Lukas Bulwahn wrote:
> >
> > Strangely, my checkpatch invocation on next-20221116 did not show that
> > warning and I am unaware that I made any specific changes to
> > checkpatch or its configuration.
> >
>
> I think you need to apply the patch and retest with the -f option.
>

Thanks, Dan, for the hint. Now, I know. I need to see if this can
become part of my usual patch submission workflow.

Lukas

> regards,
> dan carpenter
>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE5F68C321
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjBFQY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:24:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjBFQYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:24:55 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD751DB86;
        Mon,  6 Feb 2023 08:24:54 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-16a27344a17so6361878fac.4;
        Mon, 06 Feb 2023 08:24:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVdEfaHPNvG0NSE6JjcsflluK8VNeZ/QnBR/Yy8Yfwo=;
        b=WNoysfO5QDsoFt2TM6/TyF29xYjHxpmbaaMtxQ9Hh/TXgP+M/0ibdw/QDt8VTuUqus
         vNsSYKNylzyxRIjYiIr+6zIUlWxbYGu7wcwpJKxd/NZHzms0EUr43+lgWSw5+pLeemsQ
         Vsmil7f6GdgInNvS7Mi8dx6+Yi6E2q2eFb2ccpXS0yuFMZqeiVvs+lySpQiyrZMSlfqK
         AXO6Z4fLxOu8Rmm0eKW6HrzjpoFw0i2+V3IlAazAsonosQ4UvfFL4WDEL1SLDrW9ZSqi
         mmQ8PpYqhdC27rj5tP9DBGiS/NFAWrAVPMErJIuozc2RnrdEUqoUkLgkqnqb7tYz02pd
         DETA==
X-Gm-Message-State: AO0yUKWfZHzLSOem5pgOCYahL5Ra5i2puoEkqlXafYMJZTImidC+B7wN
        Soq/sXpIdZVJ3lqecyGqwQ==
X-Google-Smtp-Source: AK7set+bcnXsXhM4q6OCRwl2Yk3Kr76aWyOuHT9lgcEuSwu66HgEvT4hjcIHkxamVPDQAurQM7GQ2g==
X-Received: by 2002:a05:6870:ac0f:b0:15f:b635:8c4a with SMTP id kw15-20020a056870ac0f00b0015fb6358c4amr11706655oab.55.1675700694258;
        Mon, 06 Feb 2023 08:24:54 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ee15-20020a056870c80f00b0014fb4bdc746sm4306918oab.8.2023.02.06.08.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 08:24:53 -0800 (PST)
Received: (nullmailer pid 179634 invoked by uid 1000);
        Mon, 06 Feb 2023 16:24:53 -0000
Date:   Mon, 6 Feb 2023 10:24:53 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] of: make of_node_ktype constant
Message-ID: <167570067760.179257.13965747777319057031.robh@kernel.org>
References: <20230204-kobj_type-of-v1-1-5910c8ecb7a3@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230204-kobj_type-of-v1-1-5910c8ecb7a3@weissschuh.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 04 Feb 2023 05:47:03 +0000, Thomas Weiﬂschuh wrote:
> Since commit ee6d3dd4ed48 ("driver core: make kobj_type constant.")
> the driver core allows the usage of const struct kobj_type.
> 
> Take advantage of this to constify the structure definition to prevent
> modification at runtime.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  drivers/of/kobj.c  | 2 +-
>  include/linux/of.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!


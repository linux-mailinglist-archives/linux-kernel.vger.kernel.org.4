Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11DB15EB200
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiIZUTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiIZUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:19:34 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0162C25CF;
        Mon, 26 Sep 2022 13:19:32 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1279948d93dso10728457fac.10;
        Mon, 26 Sep 2022 13:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=aQfzdQ+UJIYZ23laeVhF1EqXXgml+Qpqh/yayVl2B6I=;
        b=RbheJcAqZFtseaIBE0jcbS5SGeWJdlJpMTU1t2ah/D5gxRD6wz8ql9QY1YvziaWZJK
         6fn/f9IXqgCWa+tSsN0+YsiOrpdULrhIX7+oRVQ6TsPHMSOC1t563kNwsBzp24waKn62
         kX18yZh9GSQRKJpZy+buYAjMz/JS8nMwXL4kEbt3/XtF2PMBr6Y7D7an4MwPgyKe823V
         HEl6soXRMCtJveAbkKFdqbYMOfv1YVJAqoO29OF415nZYesHQPGrxVxwKD89mVtpJnkX
         qqxtbfClQJwxHy3JpNXMOtLhIZIPYK79MissMiRxvbxXRidvviQSvMlLYcTlUsL/AvPy
         afTw==
X-Gm-Message-State: ACrzQf0+OjCWvDp2sIWz3JrjKFkMDRTX0tjMit/27AatVD/qLjKNhpi1
        uX64/5fSB14RZn1gMdzEaw==
X-Google-Smtp-Source: AMsMyM6J4xhTg7YRyF3BsYNaKHmzybiexgs0F0ILJnB/C9J3KDxPSiEvNW66ufrHbq4gm6gbJUcSFw==
X-Received: by 2002:a05:6870:c095:b0:127:4189:776f with SMTP id c21-20020a056870c09500b001274189776fmr285511oad.84.1664223571364;
        Mon, 26 Sep 2022 13:19:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x27-20020a4a2a5b000000b0044afc1ba91asm6973846oox.44.2022.09.26.13.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:19:30 -0700 (PDT)
Received: (nullmailer pid 2735662 invoked by uid 1000);
        Mon, 26 Sep 2022 20:19:30 -0000
Date:   Mon, 26 Sep 2022 15:19:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Matt Ranostay <mranostay@ti.com>
Cc:     vigneshr@ti.com, devicetree@vger.kernel.org, nm@ti.com,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/9] dt-bindings: PCI: Add host mode device-id for
 j721s2 platform
Message-ID: <20220926201930.GA2735628-robh@kernel.org>
References: <20220921031327.4135-1-mranostay@ti.com>
 <20220921031327.4135-8-mranostay@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921031327.4135-8-mranostay@ti.com>
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

On Tue, 20 Sep 2022 20:13:25 -0700, Matt Ranostay wrote:
> Add unique device-id of 0xb013 for j721s2 platform to oneOf field.
> 
> Signed-off-by: Matt Ranostay <mranostay@ti.com>
> ---
>  Documentation/devicetree/bindings/pci/ti,j721e-pci-host.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 814F5681E1D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 23:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjA3WbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 17:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjA3WbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 17:31:10 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F63026862;
        Mon, 30 Jan 2023 14:31:10 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-15ff0a1f735so17114033fac.5;
        Mon, 30 Jan 2023 14:31:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDWY395vuCmDiyBkeEOIvzr6ntXJiykJFZrgzrklF+g=;
        b=A/BfnE7bX12cZX3mFpxBTdTbfE5AqztuzsJ09Xod61jfpYpFVJ8pqS3BBA6bm48jyc
         Xj16VTFVENfxLhGRO2OAHwZ+QydibUWvIFyLQ1z7V3UA/p6QxOF6U7Qlru56/rCXevUk
         6qB7tf7dLaviWWrvs0o4uPzHkcdLhk7N6Y1L8kJAsZ/nohntHz2gH+fORQ3HRAIJsrB5
         L+Bvpw5VQ2eVO+1g2zbImGWwyFDdsPsjlbBenQPwBetvOeaK/dTKw7np8tqCzGrR+9Hm
         x4OdDI9dq6jEGTehWwlpRxTmk+2TdwwsWINLLxt8qWB2ZPhHHtX6ujekc+vmY0KMujM1
         4h/A==
X-Gm-Message-State: AO0yUKVZibztMXOFbUFsoTy34lh4Lcyilmguhh+OGeUBF3W/P90RnkIF
        e6zqaKVlIzayPUhlKxUleA==
X-Google-Smtp-Source: AK7set+VfaTqVIhneHfeRitw7Q4QTnCuXWYVVHjLER/pj6nQy+rkRdGII1zu8evGnCYxYL9TgW81TQ==
X-Received: by 2002:a05:6870:d1c8:b0:163:5526:81df with SMTP id b8-20020a056870d1c800b00163552681dfmr8970079oac.42.1675117869218;
        Mon, 30 Jan 2023 14:31:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r12-20020a05687080cc00b00163af122666sm2010774oab.3.2023.01.30.14.31.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 14:31:08 -0800 (PST)
Received: (nullmailer pid 3644245 invoked by uid 1000);
        Mon, 30 Jan 2023 22:31:08 -0000
Date:   Mon, 30 Jan 2023 16:31:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, l.stach@pengutronix.de,
        shawnguo@kernel.org, lorenzo.pieralisi@arm.com, peng.fan@nxp.com,
        marex@denx.de, marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        frank.li@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-imx@nxp.com
Subject: Re: [PATCH v7 1/5] dt-bindings: imx6q-pcie: Prepare to separate the
 Endpoint binding document
Message-ID: <20230130223108.GA3642291-robh@kernel.org>
References: <1675049539-14976-1-git-send-email-hongxing.zhu@nxp.com>
 <1675049539-14976-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1675049539-14976-2-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 11:32:15AM +0800, Richard Zhu wrote:
> Prepare to create one separate DT-schema for i.MX PCIe Endpoint
> controllers in another commit.

This and patch 2 should be 1 commit. It is 1 logical change. With only 
this commit, fsl,imx8m*-pcie-ep becomes undocumented.

Rob

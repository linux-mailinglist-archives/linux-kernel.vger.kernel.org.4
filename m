Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8256A4D03
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 22:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjB0VSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 16:18:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjB0VSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 16:18:33 -0500
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8E865A2;
        Mon, 27 Feb 2023 13:18:01 -0800 (PST)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-172b0ba97b0so8834574fac.4;
        Mon, 27 Feb 2023 13:18:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zX271Z17IYJYFZ6+Pw+108O6ngWW7LHtxo4jChDSQAk=;
        b=4TvjRj0zDDnuuomX39E/b65iiPdsiSpxuQf+FSpiw6tXNbixJhn9qseslBCofqv94H
         x4tvCnntD9bEpP87aVy6GVXFD6RPprnT3HbJp9weana2JStkPi0Je4Sm/Nnimz7R7OW6
         Im9x4T1M5k9p5M8w72/OSNNhB+4s9+xYzpocTeTgQWBeytIy+l0+BjXep08zczPQWpPg
         UK/UIn2+sfqfLPLb5iQWNONajB4CbAnL0eaTvyV3QzliMqTIvqLWzKm+tULw5QmmBWqE
         pxw716uUXtDnnHySAsTI9qvRZQGzejswdhF5ohpOOlzaJQRTnVvmO+01goLvHSxmUQ3C
         x4NQ==
X-Gm-Message-State: AO0yUKXgGCdmg2nrL7kY3hIqli99nq3FAtqYmsCZv5lbtWgMf8awwAn9
        PbzSDlAzn4qyodruR7p3AQ==
X-Google-Smtp-Source: AK7set87cmHJ99JvcXzPYgR9FAh4isXl9RqfL2fZbfCBS7wGcQ6E0/WU3h+pSrDm2KXqH5Egd/UlcQ==
X-Received: by 2002:a05:6870:4796:b0:15f:4dc3:8800 with SMTP id c22-20020a056870479600b0015f4dc38800mr97787oaq.23.1677532680017;
        Mon, 27 Feb 2023 13:18:00 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g5-20020a4ae885000000b004a3d98b2ccdsm3050775ooe.42.2023.02.27.13.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 13:17:59 -0800 (PST)
Received: (nullmailer pid 993604 invoked by uid 1000);
        Mon, 27 Feb 2023 21:17:58 -0000
Date:   Mon, 27 Feb 2023 15:17:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, kernel@pengutronix.de,
        linux-usb@vger.kernel.org, jun.li@nxp.com, robh+dt@kernel.org,
        festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, s.hauer@pengutronix.de,
        devicetree@vger.kernel.org, xu.yang_2@nxp.com, linux-imx@nxp.com,
        shawnguo@kernel.org
Subject: Re: [PATCH V3 7/7] dt-bindings: usb: usb-nop-xceiv: add
 power-domains property
Message-ID: <167753267847.993544.14425185872687600268.robh@kernel.org>
References: <20230226130539.277336-1-peng.fan@oss.nxp.com>
 <20230226130539.277336-8-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230226130539.277336-8-peng.fan@oss.nxp.com>
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


On Sun, 26 Feb 2023 21:05:39 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add power-domains optional property
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-nop-xceiv.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


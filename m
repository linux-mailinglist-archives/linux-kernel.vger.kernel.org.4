Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FF564A5A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 18:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiLLRM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 12:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiLLRMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 12:12:54 -0500
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E433912610;
        Mon, 12 Dec 2022 09:12:53 -0800 (PST)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-1322d768ba7so9171891fac.5;
        Mon, 12 Dec 2022 09:12:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvFA20U6Mkz3QyBDOAMdECYf/B+92PGnyWsHrRN56bM=;
        b=Ajdw+g76tnd7vfnVcUT5dynukV4yKDiluamQFK7wnDvuUE3FB1VbMYtv7kK3qSvtPX
         sYceFynAPUk3TroxAI9ufOi4WGKuvrrhuIpSkVIEwo1QEGwfiEhnLlrQgMokmgZ2ak0C
         YlBWOg+MNYo8Aige0q/AcXFDFHkAxldh6XGi/SMBSDg1+ZGoTqE81NxPp/hAQiDVW+Lk
         2dE3bbqAscDLthgcWkPZifI6sVK/gnY21EPXj6preQ2cSukaColxzdH9nkQtruvW1wT1
         VGy0kZlwdSWmPNy7Wn6w83XbYrRhNNxB+Mb716CfseInS3CJK0fJeTeX6xGWeI0kEbUK
         mkcg==
X-Gm-Message-State: ANoB5pmBl+MCGJfXp+5SSdfMvseq95YJ9fUNwA6Su26Y9MQVq2biH62h
        2FNYzFqr9Am7/K6vuPnFkA==
X-Google-Smtp-Source: AA0mqf6nsnie5WDBxmo74YMu9eXA7ZT9hMxxT11E1vCXQPpQV4RlWJz3ZGoeFZP2o95aGpTZ7Lolzw==
X-Received: by 2002:a05:6870:3b19:b0:148:2c02:5322 with SMTP id gh25-20020a0568703b1900b001482c025322mr4246505oab.26.1670865173196;
        Mon, 12 Dec 2022 09:12:53 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w20-20020a4ad034000000b004a0b424f99dsm103772oor.43.2022.12.12.09.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 09:12:52 -0800 (PST)
Received: (nullmailer pid 1146475 invoked by uid 1000);
        Mon, 12 Dec 2022 17:12:51 -0000
Date:   Mon, 12 Dec 2022 11:12:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?utf-8?B?77+9?= Chmiel <pawel.mikolaj.chmiel@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        ", Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: dt-bindings: silabs,si470x: Convert to DT schema
Message-ID: <167086517001.1146391.18433456059392851926.robh@kernel.org>
References: <20221209175926.335227-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209175926.335227-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 09 Dec 2022 18:59:26 +0100, Krzysztof Kozlowski wrote:
> Convert the Silicon Labs Si470x FM Radio Receiver bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/media/si470x.txt      | 26 ----------
>  .../bindings/media/silabs,si470x.yaml         | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  3 files changed, 49 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/media/si470x.txt
>  create mode 100644 Documentation/devicetree/bindings/media/silabs,si470x.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>

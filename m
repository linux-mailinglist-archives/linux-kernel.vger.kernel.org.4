Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543B369D853
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 03:10:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBUCKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 21:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbjBUCKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 21:10:10 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09712BDFB;
        Mon, 20 Feb 2023 18:10:10 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id w7-20020a056830280700b0068dbf908574so610604otu.8;
        Mon, 20 Feb 2023 18:10:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p3Gcf8LkDG3VS7vwVyjaiQMkBrfXaJ1jO/Cq3quHl28=;
        b=kyEtouE0emEcQPMRp4ROZvhqO+RnkwDUPY9AAiHfoIUlefyTbxX4M/LPhJgfwCBtSZ
         qnJq0bjD+sPVKO1mk39LrgHJv5QEpkCGgVIjFi+t9kTjsqoEpYd8z14hV7dPRBXaBFqa
         SiZL2FkQzGko6InO1Ts7PSabnHB8eXX4K0wczL5mbM4uyI1tEuNkuMOJyUepUN9e6Gld
         7w5JMrbkC436wS3xStcz0Cvm8/k3LjpbtWnog7IWdGaEZwSkWxlPNMBCshRkvQfRNBvF
         WdN3DvkSFWZg35bqEFVB8PpDNoPN0uJI3n6x8u12hDjCG5kFrRzopLAYbY37PR+dJXCY
         zDQw==
X-Gm-Message-State: AO0yUKXxKePOBcbWJbZVUvrY3kPks8jy4mcc9a4hbzUqs/QlyO3dgbjd
        UKiMrGLZT7fBT5c6N6kp6g==
X-Google-Smtp-Source: AK7set9bAWW4zsaz4XGis1qaApLFdentDhXXsZbhblN1tIOfXeMTi65ShE+zEW8WCdXFiL5kqEIzRg==
X-Received: by 2002:a9d:6c7:0:b0:68b:e2bb:8027 with SMTP id 65-20020a9d06c7000000b0068be2bb8027mr990166otx.14.1676945409236;
        Mon, 20 Feb 2023 18:10:09 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v11-20020a9d5a0b000000b00684bede5359sm5679163oth.42.2023.02.20.18.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 18:10:08 -0800 (PST)
Received: (nullmailer pid 823652 invoked by uid 1000);
        Tue, 21 Feb 2023 02:10:07 -0000
Date:   Mon, 20 Feb 2023 20:10:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nipun Gupta <nipun.gupta@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, alex.williamson@redhat.com,
        cohuck@redhat.com, rafael@kernel.org, will@kernel.org,
        jgg@ziepe.ca, jeffrey.l.hugo@gmail.com, michal.simek@amd.com,
        eric.auger@redhat.com, git@amd.com, linux-kbuild@vger.kernel.org,
        joro@8bytes.org, robin.murphy@arm.com, ndesaulniers@google.com,
        masahiroy@kernel.org, harpreet.anand@amd.com,
        linux-kernel@vger.kernel.org, mchehab+huawei@kernel.org,
        gregkh@linuxfoundation.org, yishaih@nvidia.com,
        devicetree@vger.kernel.org, f.fainelli@gmail.com, jgg@nvidia.com,
        krzysztof.kozlowski+dt@linaro.org, okaya@kernel.org,
        Michael.Srba@seznam.cz, mani@kernel.org,
        song.bao.hua@hisilicon.com, saravanak@google.com,
        rdunlap@infradead.org, nikhil.agarwal@amd.com, robh+dt@kernel.org,
        maz@kernel.org
Subject: Re: [PATCH v8 3/7] dt-bindings: bus: add CDX bus controller for
 versal net
Message-ID: <167694540701.823591.3473910684799952854.robh@kernel.org>
References: <20230217132830.3140439-1-nipun.gupta@amd.com>
 <20230217132830.3140439-4-nipun.gupta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217132830.3140439-4-nipun.gupta@amd.com>
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


On Fri, 17 Feb 2023 18:58:26 +0530, Nipun Gupta wrote:
> Add CDX bus controller device tree bindings for versal-net
> devices.
> 
> Signed-off-by: Nipun Gupta <nipun.gupta@amd.com>
> Tested-by: Nikhil Agarwal <nikhil.agarwal@amd.com>
> ---
>  .../bindings/bus/xlnx,versal-net-cdx.yaml     | 82 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/xlnx,versal-net-cdx.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


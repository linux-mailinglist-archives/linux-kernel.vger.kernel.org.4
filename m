Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5201F5B9C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 15:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIONoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 09:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiIONoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 09:44:03 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA467CB6E;
        Thu, 15 Sep 2022 06:43:56 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-1280590722dso47595631fac.1;
        Thu, 15 Sep 2022 06:43:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ewl9ccoqSS/pK38WPwPo/QqMTNkX57cZ/0yi66bbkzk=;
        b=AhXMoNI11g2zTc1xFJ05ivgrKW2fNDlYK8pBg9FEHCbBpIwidfgvN4yohw+5JbhYSc
         PwmvPT9VVy8r/3bCw0lXd+Tr68Zakz5T6ZtvGOWkob8S1sI6AO8WbyFMjx3yi87frw31
         9vWkL+bmsKf6n1MBNNOpHvTwA5gRTSKNkGwQeoNGkmQEvP0pKVOeU0T1ePfdgSFkkxuR
         a3KD1Op5EL5EKwR+g0sv4535p1t8dwFGOKGadLlDIXi7BGfBIINHmVMeuFqeoIPamC/f
         XaIesUksVSrAJCAj9v9AMZvDobdDYpUg1nvqVeLBsfcvc1ssPKVASUIt1d4+dXiqpfVA
         kZdw==
X-Gm-Message-State: ACgBeo2C4rvIB7hbBQedONMCP3saINlL1Dn39LbCXnGRshXstOWDLms8
        PNORMsXgnyk42d2DB7xolw==
X-Google-Smtp-Source: AA6agR7KpuyZQGv01An5Z6T7hcfabP9X2k1fxaer8B7wdoNGNu8YinFps4J/+3gx+pBofhHdaMN4bw==
X-Received: by 2002:a05:6870:b494:b0:126:b7fa:f235 with SMTP id y20-20020a056870b49400b00126b7faf235mr5308587oap.266.1663249435226;
        Thu, 15 Sep 2022 06:43:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b14-20020a056870160e00b00127fbb7afffsm1402056oae.5.2022.09.15.06.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Sep 2022 06:43:54 -0700 (PDT)
Received: (nullmailer pid 1168692 invoked by uid 1000);
        Thu, 15 Sep 2022 13:43:53 -0000
Date:   Thu, 15 Sep 2022 08:43:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     cy_huang <u0084500@gmail.com>
Cc:     matthias.bgg@gmail.com, devicetree@vger.kernel.org,
        cy_huang@richtek.com, linux-mediatek@lists.infradead.org,
        alice_chen@richtek.com, robh+dt@kernel.org, lee@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, chiaen_wu@richtek.com
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the indentation in the
 example
Message-ID: <20220915134353.GA1168381-robh@kernel.org>
References: <1663157936-5010-1-git-send-email-u0084500@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663157936-5010-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Sep 2022 20:18:56 +0800, cy_huang wrote:
> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> Fix the indentation in the binding example. There're two redudant space
> charactors need to be removed.
> 
> Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> ---
> Since v2:
> - Add Fixes tag in commit message
> 
> ---
>  Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC7026C6C4B
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232143AbjCWP2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjCWP2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:28:44 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675D832E4E;
        Thu, 23 Mar 2023 08:28:43 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id 103-20020a9d0870000000b0069f000acf40so9893858oty.1;
        Thu, 23 Mar 2023 08:28:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679585322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lMC9l9Xu+R4kY0unfw7S3jTRffsrFJM0dcw4eNt4L4=;
        b=nlk/B+HieGujYOuOVgGs36Xhbm76oh3ubYH6RWTo0UNZJkdRrve9AGsjXOFJeoVQDo
         9DBPaT5CsP7XAtaymO29WPAo+mGOVIX3Y4zJUaJYncgdalS1JwSrdsUwtkVkZB/wgth3
         cOZawB6uJcqSd5w1gcZ3mfKeSxzBdru5Qw0gMalnI5uOH6/DTaz2oYw8IDNCB0Vj0z7C
         iHY4GPTd+OOrLbcAM5Z9tYH5yczTJVCB0ePbJTVawJIYB/b38PrP4fwM9QXN+goHdGNc
         KLfta5h6Q6KJIo2Mzf7b5ti8c5RqsK9CSfMfcf2iS6f1ZRCjSdHnBavuFXNgRblbcFaw
         31mw==
X-Gm-Message-State: AO0yUKVwszJ6NvQn69TyXLBQAwLQG0yDZ7kRqF+jeDE7Sq9KXb6ybWN0
        qPm4SE83KTRl9PTpQL7J9A==
X-Google-Smtp-Source: AK7set/TI9oZV8LrGVWiAqlaRR1tJHqqMU6cCKVVJ8hOeATVMGV7fOq4p/87Qdp/qx7+W40LEtpk7A==
X-Received: by 2002:a05:6830:1b70:b0:69f:8f30:89b5 with SMTP id d16-20020a0568301b7000b0069f8f3089b5mr2810365ote.19.1679585322633;
        Thu, 23 Mar 2023 08:28:42 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q3-20020a9d6303000000b0069f17869390sm5195536otk.2.2023.03.23.08.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 08:28:42 -0700 (PDT)
Received: (nullmailer pid 3289654 invoked by uid 1000);
        Thu, 23 Mar 2023 15:28:41 -0000
Date:   Thu, 23 Mar 2023 10:28:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     gregkh@linuxfoundation.org, Peng Fan <peng.fan@nxp.com>,
        s.hauer@pengutronix.de, linux-usb@vger.kernel.org,
        shawnguo@kernel.org, xu.yang_2@nxp.com, linux-imx@nxp.com,
        robh+dt@kernel.org, kernel@pengutronix.de, jun.li@nxp.com,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        festevam@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V7 02/10] dt-bindings: usb: ci-hdrc-usb2: convert to DT
 schema format
Message-ID: <167958532041.3289575.14742530117909404528.robh@kernel.org>
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
 <20230322052504.2629429-3-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322052504.2629429-3-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Mar 2023 13:24:56 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Convert the binding to DT schema format. To fix the dtbs_check
> error, some properties were also added, such as nvidia,phy, reset-names
> ulpi; missing compatibles are added.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../devicetree/bindings/usb/ci-hdrc-usb2.txt  | 159 -------
>  .../devicetree/bindings/usb/ci-hdrc-usb2.yaml | 447 ++++++++++++++++++
>  2 files changed, 447 insertions(+), 159 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
>  create mode 100644 Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>


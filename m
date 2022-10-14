Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0205FF0A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJNOxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJNOxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:53:14 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555591CEC22;
        Fri, 14 Oct 2022 07:53:14 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id g130so5253858oia.13;
        Fri, 14 Oct 2022 07:53:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn7Y8kThp8XtftksJqeo5xI5LmU58Usc6BTLEgTHKvk=;
        b=1qpcUFCX1vueRg/stbpiIo17HUJHAyNRGMJgxNWio44hLPYrlfPhJgdYSs58qJWPQO
         GS1lqTg02g8kGGzVZjo8rWjfSf8MVr14s2VgqB42VT0Zbj51AqTPAXFyTSzi2KZ7wmqU
         waJ3SBminyoYoVxTvYKnVLN5TI+EpVJfubw3YY0UdT83TPDwP0WfYvLCIwriiaQL2NpZ
         5jaBaKGs8oDksPkNohh1THbxjhR8zhsTs45RJPGZVhC7p47X627I8PfyyLqNyXzGS5/u
         szk/u0riH8hrWbrz4aTDVVzomloesn9TgNRCy0Y9tFDUv1kj6sI1cPHg7eZRirxbp9Pm
         TZhQ==
X-Gm-Message-State: ACrzQf2vb+oz3LhWxh91Bj5P2MKjXIngmxIB7QI8bg/mrIPNT59GNC0I
        rGxfZsnss0fvlYQprDKVuw==
X-Google-Smtp-Source: AMsMyM6B+JtQpFGXxpapm5ZUHiU7FJO30R/aRF0zjEtkjW16zVOuh6rYoox76AvpEqbB5UeriXcr8g==
X-Received: by 2002:a05:6808:1390:b0:350:45fd:7d31 with SMTP id c16-20020a056808139000b0035045fd7d31mr2768478oiw.253.1665759193592;
        Fri, 14 Oct 2022 07:53:13 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l14-20020a4ac60e000000b004805cfab0ffsm993195ooq.31.2022.10.14.07.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 07:53:13 -0700 (PDT)
Received: (nullmailer pid 1939841 invoked by uid 1000);
        Fri, 14 Oct 2022 14:53:13 -0000
Date:   Fri, 14 Oct 2022 09:53:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        linux-imx@nxp.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        linux-kernel@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, gregkh@linuxfoundation.org,
        xu.yang_2@nxp.com, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>, linux-usb@vger.kernel.org,
        jun.li@nxp.com, devicetree@vger.kernel.org
Subject: Re: [PATCH V2 5/6] dt-bindings: usb: ci-hdrc-usb2: add
 i.MX53/6SLL/UL compatible
Message-ID: <166575919335.1939785.16844042573876965198.robh@kernel.org>
References: <20221014095148.2063669-1-peng.fan@oss.nxp.com>
 <20221014095148.2063669-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014095148.2063669-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Oct 2022 17:51:47 +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add i.MX53, i.MX6SLL, i.MX6UL compatible
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

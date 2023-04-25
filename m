Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913906EE7E6
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbjDYS4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjDYS4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:56:15 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEB218B9F;
        Tue, 25 Apr 2023 11:55:52 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-187fc21f6acso2242955fac.2;
        Tue, 25 Apr 2023 11:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682448951; x=1685040951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZOYO9VcZmL3OuUTiqSJiXINw03Ze8xYqi62GLai31bU=;
        b=Uvq+RUL3H7M/gO0x0v8e1ii741DkCwXcmrU0VEeeNiq5EP7498cMfrngnZk0X5tTv1
         QvBkgSMj7tAY2PVfHqjyyNMEqVtKflCJu0GyqpzWuLzagLeu7cVtBMavXuXCtHbVh4+9
         dGisVtPwR039iZat/cKSP6TgO+DnL2Aft0BQ9yL5oBTIspW2me+IOBr7gsWXMTrV3QCa
         FM0GTA6qLUKW97V1lO6FrOnij3EzIsnVU3qwDiy7rM7ECqSrl/1Evo7bLc+8lZ8uIs4m
         v/cqwyoZkgl9vmUjxVvviCdK16PiJopNzGFDpx5WkHJESnxOL8NscEYtQT9+GSB679Ie
         k4Ow==
X-Gm-Message-State: AC+VfDzLQ7AJFZFAe9H+M4IqaXNePGxf5tWAJtmlQ9JS8uVt3/Sddbw2
        K8+Zl1R+eyVSHTOmjANcxQ==
X-Google-Smtp-Source: AKy350ZFzcrzJb63mNKNH0YEsQQiHvjn8FXThu1xVj9+IaSO0IdB0kkzpV7zE31AxJ15OFZoudPEIA==
X-Received: by 2002:a05:6870:1699:b0:18e:bbfc:4ee2 with SMTP id j25-20020a056870169900b0018ebbfc4ee2mr3428485oae.41.1682448951528;
        Tue, 25 Apr 2023 11:55:51 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w2-20020a9d6382000000b006a41ab165dfsm6042065otk.34.2023.04.25.11.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 11:55:51 -0700 (PDT)
Received: (nullmailer pid 2080853 invoked by uid 1000);
        Tue, 25 Apr 2023 18:55:50 -0000
Date:   Tue, 25 Apr 2023 13:55:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: leds: Drop redundant cpus enum match
Message-ID: <168244894963.2080814.13396719387956216399.robh@kernel.org>
References: <20230424151437.256073-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230424151437.256073-1-nm@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 24 Apr 2023 10:14:37 -0500, Nishanth Menon wrote:
> Commit e91a4d5deb96 ("dt-bindings: leds: Document commonly used
> LED triggers") introduced a enum match for cpu, while a pattern
> '^cpu[0-9]*$' already exists.
> 
> This causes linux,default-trigger = "cpu" to have more than one match
> and generates the following dtbs_check warning:
> 
> arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dtb: leds: led-2:linux,default-trigger: More than one condition true in oneOf schema:
> 	{'$ref': '/schemas/types.yaml#/definitions/string',
> 	 'oneOf': [{'items': [{'enum': ['backlight',
> 	                                'default-on',
> 	                                'heartbeat',
> 	                                'disk-activity',
> 	                                'disk-read',
> 	                                'disk-write',
> 	                                'timer',
> 	                                'pattern',
> 	                                'audio-micmute',
> 	                                'audio-mute',
> 	                                'bluetooth-power',
> 	                                'cpu',
> 	                                'flash',
> 	                                'kbd-capslock',
> 	                                'mtd',
> 	                                'nand-disk',
> 	                                'none',
> 	                                'torch',
> 	                                'usb-gadget',
> 	                                'usb-host',
> 	                                'usbport']}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^cpu[0-9]*$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^hci[0-9]+-power$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^mmc[0-9]+$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'},
> 	           {'items': [{'pattern': '^phy[0-9]+tx$'}],
> 	            'maxItems': 1,
> 	            'minItems': 1,
> 	            'type': 'array'}]}
> 
> Drop the explicit match against cpu since the pattern match already
> covers the same.
> 
> Fixes: e91a4d5deb96 ("dt-bindings: leds: Document commonly used LED triggers")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/common.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


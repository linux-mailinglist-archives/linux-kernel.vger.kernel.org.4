Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E986B24EB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 14:07:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231162AbjCINHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 08:07:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCINH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:07:27 -0500
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0785BDD25;
        Thu,  9 Mar 2023 05:07:25 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 3E74AD5A;
        Thu,  9 Mar 2023 14:07:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1678367243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ST5nqr0BxUU48s0KQPY9+fCv2sJlYQgHCP190g3oI2Y=;
        b=VgS75LPNt2wnGRYF/sRg3G/LOq9ufu+I3lQVy0iyiIE9Ojn2lUKD21D73dWepnj2JGfMOp
        yw5/jFUeK7zJVwQBRFzTNBwqudKu208BpwJ4IUqRk1muRqt1FAfUuMWtcbCEq5dxgl/WsC
        itdBG+Fk2oHJ91qOQUCJ2Xy5zmt3w5QnI604Se1SjNJx6/NInPOhGxiKLT6fb9PkCNFx+O
        +e6NWD7OJ8wrAtJXRWn2XZZKG3Ez+AqWnV7+GkLoG/EYhDJyTFYYPbKnoAar4zoDixc42U
        ZaomSg5W84bvGEEkQTm+ny0qlzxeAmTm2wHJ9HBPDJI1D2QPIQkmYwdlOkIyEQ==
MIME-Version: 1.0
Date:   Thu, 09 Mar 2023 14:07:23 +0100
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Ra?= =?UTF-8?Q?fa=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>
Subject: Re: [PATCH V2] dt-bindings: nvmem: layouts: add fixed-layout
In-Reply-To: <20230309113936.20162-1-zajec5@gmail.com>
References: <20230309113936.20162-1-zajec5@gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <8478b23e903d5236500ef2f6f7edb88f@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2023-03-09 12:39, schrieb Rafał Miłecki:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> With the introduction of NVMEM layouts we should prefer and support
> describing all NVMEM devices content in the "nvmem-layout" node. That
> inludes using it for fixed NVMEM cells (those with hardcoded offset &
> size).
> 
> This seems to be cleaner design and more explicit.
> 
> Introduce a binding allowing fixed NVMEM cells as a type of layout. To
> avoid code duplication put shared part in the fixed-cell.yaml.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

I don't feel comfortable to add an acked-by or reviewed-by here
because I don't do much with dt-bindings myself, but this looks
good to me.

 From a device tree binding POV, could there be a

nvmem-layout@0 {
   reg = <0>;
   compatible = "layout1";
};

nvmem-layout@1000 {
   reg = <1000>;
   compatible = "layout2";
};

for partitioned eeproms for example?

-michael

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEED66DDBD3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbjDKNNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDKNMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:12:55 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40764C24;
        Tue, 11 Apr 2023 06:12:48 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-183f4efa98aso15757102fac.2;
        Tue, 11 Apr 2023 06:12:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681218768; x=1683810768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pckccAp7p9UOxZhiRQnvdxqH17ms9wxsfF5/fgNK0dM=;
        b=6CI/CaUTVMQelxw/ZLyIrSUSFSnPDFtlJ6VHCKHBhhDxa8D3GLDwQGbclr3EQmeAYf
         DlZE4wBmW+CQYVertJKye0/WDxRscBi/cFuDJLyNadnYadE/uqKfATMzAfkb58XR0rcz
         DV58x5dtsnrIiyrZgItLghLbr13UgpQAvMUbHZA8YlpftlO0Q1TqaGjZ4PFjlFRfCa8c
         yh+eyA7I5F9vhUhQ4hO92aorMPpkx7s43bd3+MFA4yvVhrG+A2taT1O7GiR7ZySSxH5N
         7UK1twc/Irh9HhqKFywbOTuzNfuErMGksepL9Zdq6jb4D130ci6Brb6fI1np6EigPG2W
         8Q+Q==
X-Gm-Message-State: AAQBX9ctH4CbeX8tDGI1pKhtuHm9nd5B3hHQzMgChVR3hStoi2QrJFbR
        BZuqArnB1MyqCzA+CkpVNBj9p9jFmQ==
X-Google-Smtp-Source: AKy350a7k+yx6w4uQ7cVzonTmZ0r9ANmDkkNFbXN0pTorDSZAWXJsSA36PSohCeX2rIEeaDj1UnJaA==
X-Received: by 2002:a05:6870:b019:b0:184:581e:a998 with SMTP id y25-20020a056870b01900b00184581ea998mr2660857oae.53.1681218767938;
        Tue, 11 Apr 2023 06:12:47 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z2-20020a9d65c2000000b006a12509bd94sm5311280oth.13.2023.04.11.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:12:47 -0700 (PDT)
Received: (nullmailer pid 2908568 invoked by uid 1000);
        Tue, 11 Apr 2023 13:12:46 -0000
Date:   Tue, 11 Apr 2023 08:12:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        kernel@collabora.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv1 2/3] dt-bindings: usb: Add RK3588 EHCI
Message-ID: <168121876599.2908521.3687323183492928122.robh@kernel.org>
References: <20230406135552.23980-1-sebastian.reichel@collabora.com>
 <20230406135552.23980-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406135552.23980-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 06 Apr 2023 15:55:51 +0200, Sebastian Reichel wrote:
> Add compatible for RK3588 EHCI. As far as I know it's fully
> compatible with generic-ehci.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ehci.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>


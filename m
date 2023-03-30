Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 594786D061B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 15:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbjC3NM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 09:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjC3NMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 09:12:23 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F5AF15;
        Thu, 30 Mar 2023 06:12:21 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17aaa51a911so19645590fac.5;
        Thu, 30 Mar 2023 06:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680181941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPQzQo8Jh5OaRP5hyosVWpCjhmgG+NE4MN/r3d8MCe4=;
        b=Jyl5jQZ/WvPfTud9rDDg79M5pokrwCt/dzs2xU9TCCpX8TEEcZ9XYfkvHeYMqMkzkq
         kxCh3lOANP8ilpJrRxk+r72Jsif4QgCq6j4DAUDU2GsAuwVEvW8TEopIjykbYuOgdzjO
         PeWlVPHzILtGax4zQ4YG/MGT+LEd0TPdQtExJ3cFq9wHe25tPbErYTwSNSdTOIli3d3k
         LfYQaor4mIcoSnV80326a3THKT9uf0OYMvso7YuecY7bXQJWZktNSHLeYOOqbX5r0F7X
         gx37SCwrHu7KBf6YIFekq2BB+rA8yVbdpU76oPeqVtIpVB706TXADejwU8l/rM1ke3uQ
         Mryg==
X-Gm-Message-State: AAQBX9csP7JdBho63t7UP6VKLivjlzXoF9tqL4Fwx1IjCAPNi5PQOhhA
        uZ2pmpMNkyq91WuGKMyg5Q==
X-Google-Smtp-Source: AKy350YUGGhtzUhEfK9PPjVabQRIBlX6I3fqhjDdLsqM7UDzSDLbtMgV0AyCoAw0ZgMDft/Cr/REcg==
X-Received: by 2002:a05:6870:f14b:b0:17f:f665:bc07 with SMTP id l11-20020a056870f14b00b0017ff665bc07mr2710863oac.52.1680181941040;
        Thu, 30 Mar 2023 06:12:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id zq35-20020a0568718ea300b0017f647294f5sm3280997oab.16.2023.03.30.06.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 06:12:20 -0700 (PDT)
Received: (nullmailer pid 1854642 invoked by uid 1000);
        Thu, 30 Mar 2023 13:12:19 -0000
Date:   Thu, 30 Mar 2023 08:12:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: Re: [PATCH v6 07/12] dt-bindings: serial: Document ma35d1 uart
 controller
Message-ID: <20230330131219.GA1849090-robh@kernel.org>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
 <20230328021912.177301-8-ychuang570808@gmail.com>
 <be0bf335-39fc-2eac-ed37-112881bac675@linaro.org>
 <7b5e42bc-0788-5208-e97e-10502da1c238@gmail.com>
 <4c1fa450-79c9-2c66-4bb8-b880f2cf07a5@linaro.org>
 <8bf559ec-0f5f-7ac5-6400-ccd2395b3b95@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8bf559ec-0f5f-7ac5-6400-ccd2395b3b95@gmail.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 06:52:11PM +0800, Jacky Huang wrote:
> 
> 
> On 2023/3/30 下午 03:33, Krzysztof Kozlowski wrote:
> > On 29/03/2023 10:44, Jacky Huang wrote:
> > > Dear Krzysztof,
> > > 
> > > 
> > > Thanks for your review.
> > > 
> > > 
> > > On 2023/3/29 下午 04:20, Krzysztof Kozlowski wrote:
> > > > On 28/03/2023 04:19, Jacky Huang wrote:
> > > > > From: Jacky Huang <ychuang3@nuvoton.com>
> > > > > 
> > > > > Add documentation to describe nuvoton ma35d1 uart driver bindings.
> > > > > 
> > > > This depends on clock patches, so it must be taken together.
> > > > 
> > > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > 
> > > > Best regards,
> > > > Krzysztof
> > > > 
> > > OK, I will combine this patch with the clock patch.
> > I don't know what you mean by "combine", but I don't think this is what
> > we want. You must clearly state all dependencies and patch merging
> > strategy/way.
> > 
> > Best regards,
> > Krzysztof
> > 
> 
> Dear Krzysztof,
> 
> 
> I may be misunderstanding your request.
> I thought it was moving the "nuvoton,ma35d1-serial.yaml" to the patch of
> nuvoton,ma35d1-clk.h.
> Would you please provide guidance what should I do next on this [PATCH v6
> 07/12]. Thank you.

The only combining you should do is putting the 2 patches in the same 
series. Combining to 1 patch would be wrong.

Your other option is just drop the header in the example and use the 
raw numbers. Then there is no dependency to manage and each subsystem 
maintainer can take the relevant patches.

Rob

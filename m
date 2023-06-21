Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28357391E6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 23:58:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjFUV6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 17:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFUV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 17:58:31 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE7D1AC;
        Wed, 21 Jun 2023 14:58:30 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-780bd47ef93so36139239f.2;
        Wed, 21 Jun 2023 14:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687384709; x=1689976709;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4h3svhbv7w/46gguZ6sS+epoOSJySQs0s/cQe2gdmzk=;
        b=lyJblzlQJHQlF5Z89pF/WTn5W9qw3HcgpRCKrtz8IJFEJ6A+hvznb7Kas7eO3YHL4V
         TQVmxHY0TW+h7z77IZPnB4BUme3sD0niHgHiYzxuxiUcSVArHmem04GrgqV9XNsC8ru9
         tL5/AQOuq9mMyAHnIsmvMgNWtxwKiexJpbHRVY4h7/f7kPP6EouT8qLhIxO8bM4nIQ6w
         IHy9TDHg4MESpdXCCyT16mq/ZmKGTkLue8Qz7RKxikW18bb1HyKDrS/n38O3M45ceCiz
         gWjTGX0Ujpuf43S85cIMgdU9k4915Vs5+iyfs5MrUK3K+7XMdyh4bkM6QWs1hKoZxu6d
         uFBg==
X-Gm-Message-State: AC+VfDw9HHc1o0v2HAfFF2vFvazDV3Ygk/tu9X/fjAkxwfC3vBg3EJRS
        QV8tA7JTaF+UOvT1aNJAQg==
X-Google-Smtp-Source: ACHHUZ5+48Fo0SEsH+h5+n6acLLXkTwrIXm++OtwqQjj7KfADfIN5Novp3bamaoEEaBTIxcwcbUeWA==
X-Received: by 2002:a05:6e02:806:b0:343:9a7e:9f1a with SMTP id u6-20020a056e02080600b003439a7e9f1amr6811814ilm.1.1687384709256;
        Wed, 21 Jun 2023 14:58:29 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id f16-20020a92cb50000000b00341e5cde68dsm1597781ilq.78.2023.06.21.14.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 14:58:28 -0700 (PDT)
Received: (nullmailer pid 3614634 invoked by uid 1000);
        Wed, 21 Jun 2023 21:58:26 -0000
Date:   Wed, 21 Jun 2023 15:58:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pwm: drop unneeded quotes
Message-ID: <20230621215826.GA3555109-robh@kernel.org>
References: <20230609140709.64655-1-krzysztof.kozlowski@linaro.org>
 <20230612093315.gbabepl5qg44xf5d@pengutronix.de>
 <20230621205317.GA3493078-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230621205317.GA3493078-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 02:53:17PM -0600, Rob Herring wrote:
> On Mon, Jun 12, 2023 at 11:33:15AM +0200, Uwe Kleine-König wrote:
> > Hello,
> > 
> > On Fri, Jun 09, 2023 at 04:07:09PM +0200, Krzysztof Kozlowski wrote:
> > > Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> > > checking for this can be enabled in yamllint.
> > 
> > in my book quoting everything instead of dropping quotes is the better
> > option. While that policy adds more quotes, it prevents surprises like:
> > 
> > 	$ yaml2json << EOF
> > 	> countrycodes:
> > 	>  - de
> > 	>  - fr
> > 	>  - no
> > 	>  - pl
> > 	> EOF
> > 	{
> > 	  "countrycodes": [
> > 	    "de",
> > 	    "fr",
> > 	    false,
> > 	    "pl"
> > 	  ]
> > 	}
> > 
> > And if you use the "only-when-needed" rule of yamllint you have to write
> > the above list as:
> > 
> > 	countrycodes:
> > 	 - de
> > 	 - fr
> > 	 - "no"
> > 	 - pl
> > 
> > which is IMHO really ugly.
> 
> Agreed, but "no" and "yes" are unlikely values in DT.
> 
> > 
> > Another culprit is "on" (which is used e.g. in github action workflows),
> > so yamllint tells for example for
> > https://github.com/pengutronix/microcom/blob/main/.github/workflows/build.yml:
> > 
> > 	  3:1       warning  truthy value should be one of [false, true]  (truthy)
> > 
> > and there are still more surprises (e.g. version numbers might be
> > subject to conversion to float).
> 
> I'll add a meta-schema check for this. 'const' is already limited to 
> string or integer. That's missing from 'enum'. I think we can also check 
> that all items are the same type as well.

And of course, like every meta-schema addition, we find new errors in 
schemas:

/home/rob/proj/linux-dt/Documentation/devicetree/bindings/phy/brcm,brcmstb-usb-phy.yaml: allOf:0:if:properties:compatible:contains:enum: 'oneOf' conditional failed, one must be fixed:
        {'const': 'brcm,bcm4908-usb-phy'} is not of type 'integer'
        {'const': 'brcm,bcm4908-usb-phy'} is not of type 'string'
        {'const': 'brcm,brcmstb-usb-phy'} is not of type 'integer'
        {'const': 'brcm,brcmstb-usb-phy'} is not of type 'string'
        hint: "enum" must be an array with the same type for all items
        from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/home/rob/proj/linux-dt/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml: properties:microchip,mic-pos:items: 'oneOf' conditional failed, one must be fixed:
        {'items': [{'description': 'value for DS line'}, {'description': 'value for sampling edge'}], 'anyOf': [{'enum': [[0, 0], [0, 1], [1, 0], [1, 1]]}]} is not of type 'array'
        /home/rob/proj/linux-dt/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml: properties:microchip,mic-pos:items:anyOf:0:enum: 'oneOf' conditional failed, one must be fixed:
                [0, 0] is not of type 'integer'
                [0, 0] is not of type 'string'
                [0, 1] is not of type 'integer'
                [0, 1] is not of type 'string'
                [1, 0] is not of type 'integer'
                [1, 0] is not of type 'string'
                [1, 1] is not of type 'integer'
                [1, 1] is not of type 'string'
                hint: "enum" must be an array with the same type for all items
                from schema $id: http://devicetree.org/meta-schemas/core.yaml#
        from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/home/rob/proj/linux-dt/Documentation/devicetree/bindings/net/altr,tse.yaml: allOf:1:if:properties:compatible:contains:enum: 'oneOf' conditional failed, one must be fixed:
        {'const': 'altr,tse-1.0'} is not of type 'integer'
        {'const': 'altr,tse-1.0'} is not of type 'string'
        {'const': 'ALTR,tse-1.0'} is not of type 'integer'
        {'const': 'ALTR,tse-1.0'} is not of type 'string'
        hint: "enum" must be an array with the same type for all items
        from schema $id: http://devicetree.org/meta-schemas/core.yaml#


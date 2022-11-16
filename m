Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AAE62B0A6
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 02:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiKPBkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 20:40:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiKPBkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 20:40:39 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6793023E91
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:40:39 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so15056803plc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 17:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tC39c52VXlH1nLHOE32Z4yAFwh97BBwoEeu9XFxg7fM=;
        b=LFN77UazmWNU86etGthla4NIY+DMIOtHWFTsYHkQw1ZP+tJWXCdRp90H5t1p8jWSCk
         SrwYiySwZffeTN44dS+DClYvo5sM2qDaOSuElWyVgJU+6b0K4ZdVHEmYyRlP2sMaArzx
         VmP5+9Iaf7z0tmaBvSCiRpfGuxEMvyGqrVom4ZjM24OlGbI1z3GJSFZe1K/QFYwn3klf
         WEsDqM3n0rNhOSfxQ/za7xF0SgT+4X1NW0vqH54DbHocnRLFJqNDX/hGIr7gexroyxiI
         iKltQF6CwoLeVYM7bWxT9+qSlDoUUS1/a3ptNhDUV8qCz/6lqtOJxlXMpkHDp964Ox8s
         0qgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tC39c52VXlH1nLHOE32Z4yAFwh97BBwoEeu9XFxg7fM=;
        b=tzXT6GmDfNNlucUv65IIwTiHXGqPbwE0SX4IDHTQedrZtjuHa/77r3huiI25emJsm2
         6hEDo7BIHye/u8H0ifgTDWszHUTFC3kzOBt4UAVLfJWflN6H3Ha4R6aP6s3DaDwxtwPa
         082KTTMXZhe9CKv6HMQchdBXA+yzXjIJ1oOIGqIgtx8cDifWRKY3H1F+yPsdeaImARNK
         TfumbeRxDX/Kf6RHJiZpHl3ui0F7fiCdbo3k9yTTV313tNQlRGKt4n/0Gok8eDMEO6OU
         lP7DBf6QybAnOkUfzrdW+NHsTQMena4k/TKrj/++HIo7M+8LuZwVJqsLiyO8mGNKhrDm
         rm2g==
X-Gm-Message-State: ANoB5plUIDPaEEtEYKmnpfyjzWLx1iEeOmzE6V+s8PI2BcHz9NeKP4Kn
        aW1LvoV2NHEQOpV5tXDSssq8rwQ21fU=
X-Google-Smtp-Source: AA0mqf4FH1AyoCGGPQjYiNXznNXk6gMUe9N38XL1WWSBRft/ou8X2i72yV7p9JGRQIHXlpcaBZeVqQ==
X-Received: by 2002:a17:90a:a006:b0:213:e907:5c0d with SMTP id q6-20020a17090aa00600b00213e9075c0dmr1181126pjp.83.1668562838631;
        Tue, 15 Nov 2022 17:40:38 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:2d36:e9a0:170b:669f])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b00176ab6a0d5fsm10578774plw.54.2022.11.15.17.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 17:40:38 -0800 (PST)
Date:   Tue, 15 Nov 2022 17:40:35 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: mvebu: switch to using gpiod API in pm-board code
Message-ID: <Y3Q/k0hoPcnQhS8L@google.com>
References: <Y3Qc6et/d+vhd71Q@google.com>
 <Y3Q4hVn3GEOm4nMq@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3Q4hVn3GEOm4nMq@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:10:29AM +0100, Andrew Lunn wrote:
> > -		ret = gpio_direction_output(pic_gpios[i], 0);
> > -		if (ret < 0) {
> > -			gpio_free(pic_gpios[i]);
> > +		pic_gpios[i] = fwnode_gpiod_get_index(of_fwnode_handle(np),
> > +						      "ctrl", i, GPIOD_OUT_HIGH,
> > +						      name);
> 
> The old code passes value=0 to gpio_direction_output(). For
> fwnode_gpiod_get_index() you pass GPIOD_OUT_HIGH. Is this correct?

Yes, gpiod API works on logical states, whereas old gpio API used signal
levels. In arch/arm/boot/dts/armada-xp-gp.dts ctrl-gpios are described
as "active low":

	cpus {
		pm_pic {
			ctrl-gpios = <&gpio0 16 GPIO_ACTIVE_LOW>,
				     <&gpio0 17 GPIO_ACTIVE_LOW>,
				     <&gpio0 18 GPIO_ACTIVE_LOW>;
		};
	};

so gpiolib will translate GPIOD_OUT_HIGH to 0 when setting final state
of the pin.

There are discussions to rename GPIOD_OUT_HIGH and friends to something
like active/inactive for better clarity, but that has not happened yet.

Thanks.

-- 
Dmitry

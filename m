Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2594769F267
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 11:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjBVKD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 05:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjBVKD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 05:03:26 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDC6AD3C;
        Wed, 22 Feb 2023 02:03:24 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 3C92F1B002CC;
        Wed, 22 Feb 2023 12:03:22 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1677060202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=exZ+2D+ikB/9nLPlEHngENKCgT65ZuObGUogEQli4pA=;
        b=iM7XSy9rQUojZq8MuDChTQyu15wa3fSLO2mj3zGwpTI7Z9gRqpLnXpKyO9/NNF8Z0FpSAG
        mhVDgWdKuKTkEmvk0lGL2RONIIBlegYiXt3SkTYUEplmB3n9irOVXf/EcvdlpLA9Xurljy
        RxJIZR0HkY7cmRDfvftrcfi9xD2kHtYXInABTW4rf8SXlnmdofc26jLX8+jW7r6SafQXmT
        S0zV1+a8gtR3nNup33NC79MoNNru73d1v1FIb5EriNnrO8Zi0rfUva118uQCLLipkSek99
        xlqUud+4BIJ2t561EOAYh5PHEu52w/wD2Y6KVb+rriT4t5meR5Vy/G4pLBIvMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1677060202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=exZ+2D+ikB/9nLPlEHngENKCgT65ZuObGUogEQli4pA=;
        b=B9Kem2MqGSoeP0kQ4LaQFTPjRk4GrpdTRiQQulrcfhidi6SFEvy8iR7NZdFCEmzhXFAhxu
        PyNBqiYBqLz2YssK7LtPnI9uIf5jvmmfQpPQlAmjGOhDEngtZg7kxV22xQkW5TdTKt5mGv
        xdG6EejnXrAO28w6BSSFRVGNeB2RwWSvTsJMLxwaV9woP6/+EDOq/4xz2qxtwILy7eERzz
        Vlz1p6lsiZUphDaAyl05S7va2GWjGk6FRThI2j6qUcSduQ+sEZJv0LtoRtXRAQIk8speuh
        4Bvhiij5k3gcYmUHL6PVypOn/7ufnvcHtUcLqiY2XjnbLIG21sclQyc9k0DfHg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1677060202; a=rsa-sha256;
        cv=none;
        b=EyUujAl42kruHLbN+0OCGJ+UvVntSwxOLOBoOA/bVivh5QLPE+yWOmcTLQWNQ9XlzD/lTF
        XFg4GYEZlmInfh8eEueEMIZ6ppD30+O8hZ1d084GdKyzjWsvghyfPYD0p4UDxbwh9ZEuTH
        mRV6FT4BWjJACFDkwoeGDzhOm3rA6OgTVDzhHRNtAhiOxxRBoKmaoP/ZKoHxpq/gf1dSEl
        2TpAy/W0U/YZMp5RKme1Q8fds1X6mPZfl/vwdVDnnCyYQgbYCtPV9HmyPFAJWkDKeCk2Ly
        XfWVJvb31sNakPFjb6m/yDYyfSeN2pyv1LfUG2MXsCpWPcGQpKTv+FkFNXYGnQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 90CC7634C91;
        Wed, 22 Feb 2023 12:03:09 +0200 (EET)
Date:   Wed, 22 Feb 2023 12:03:09 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     shravan kumar <shravan.chippa@microchip.com>,
        paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        Prakash Battu <Prakash.Battu@microchip.com>
Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Y/XoXZJUKKGzGVVL@valkosipuli.retiisi.eu>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
 <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu>
 <Y/XnWOomz2N9fCvc@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/XnWOomz2N9fCvc@wendy>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:58:48AM +0000, Conor Dooley wrote:
> On Wed, Feb 22, 2023 at 11:14:29AM +0200, Sakari Ailus wrote:
> > On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> > > From: Shravan Chippa <shravan.chippa@microchip.com>
> 
> > > @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct v4l2_subdev *sd,
> > >  	struct v4l2_subdev_format fmt = { 0 };
> > >  
> > >  	fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY : V4L2_SUBDEV_FORMAT_ACTIVE;
> > > -	imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > > +	imx334_fill_pad_format(imx334, &supported_modes[0], &fmt);
> > 
> > Now that there are multiple modes supported, this would appear to get the
> > width, height as well as the other fields (apart from mbus code) from the
> > first mode.
> 
> Is this statement supposed to be a request to change something, or just
> a throwaway comment? It's a little hard for me to understand your
> intention here, sorry.

Just pointing to what looks like a bug.

-- 
Sakari Ailus

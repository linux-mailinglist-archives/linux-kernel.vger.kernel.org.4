Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AA206A1AA2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjBXKwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbjBXKwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:52:05 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01AB56509;
        Fri, 24 Feb 2023 02:52:02 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id D083E1B1926A;
        Fri, 24 Feb 2023 12:51:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1677235920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMX/SvCM5FiDgQ+z11AKxpaUrqr8yS8lrIi2hk5bw1M=;
        b=P6KQx+QhL9/YOi02zs4UH2p77smt4DhMwgwl5Qd7EfS9eOxBQwCpHfvPaqujVQtJtSgNaR
        RSqSn1hSpGnRybSvDJ2CR1no2/odeBWiJEbXAyVJNUuee0EEl7/gUR/M6kwji6F8iRCq+w
        661I8Hcxj/5GESzS+VWjXeYRbmw+Oqfj3fmt4fZGbYwgqkzGwdy3uerMpIBvI6/n7btl4J
        /FfYArC2WBN8NHvjoI8O9nwC5j4JgDvNbuMXduAgpwEDHi5V0/GrEQgcvk2ZwL2hrtjSN3
        dkeAkpXu0YtLr2Aib8oA8BPwLZMHgSbKk9cTkeTbi0OxjGBrlkAcC+sOuwmX3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1677235920;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hMX/SvCM5FiDgQ+z11AKxpaUrqr8yS8lrIi2hk5bw1M=;
        b=PBIvVx/9vUF8QPBmlH/Qcd+Za/ku6MMP41XWpF/vsbbWlNRD5twblSCfJPhSXKJzf9CLtD
        cNLIsmI321TCFiTz0FK7+sIFsIcuFjcLVUtHeCFsAfHtas1m2Ny71Hpyueif/jupyQ35xL
        MZm1nSrsyEY1MkRNDj3MSWAWSNFNzu87WHmmdzXjyGG+qUSscuh7HKsXk4y0GevAzWWlVZ
        SyJzyhcVANYyWLoN9Zp9r2PPb+ql7zmgFmh2HNeCoXKo1gTL6vfLqQVqMeKcCeX8Osxuyt
        XOja97jGGda03Z78DdDJo6ITe6se4UnnydsRWTr3dNBjSQ1+fhwOugS7keo1Sg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1677235920; a=rsa-sha256;
        cv=none;
        b=VuR0sDSN+Di59qrMbxZ9Z40kLyqrUg1JJuqP0CWiiFKCV/ZGHe6zt7AmTkTV5xMWVnTWoi
        H90TYSm01ScWmiz1ax3W5mcsKJTGx7pQ3wtFsFNyB5mvzNtrXD1SBEc7Iz1MzUlXsPZ2PR
        JFWIAa9sfxi47JmDT39Gh72BivC2VVdeuUHJMMpB8a4osaTl5S1KN/zRls4xclPXwHF3Jq
        gbRgKIyR7M8fSxh4B4EAS9gkLw926BPe1IHG3xoOY0KA8qr/gfJqQOGtDh/cLDb7KhREAu
        g+2x1cvbN2mq24u5AD0mmzHERQ1NSeu0SYOUJJ9FzNutsB0E2/QPHGjbUKKMjw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 687B0634C91;
        Fri, 24 Feb 2023 12:51:38 +0200 (EET)
Date:   Fri, 24 Feb 2023 12:51:38 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Shravan.Chippa@microchip.com
Cc:     Conor.Dooley@microchip.com, paul.j.murphy@intel.com,
        daniele.alessandrelli@intel.com, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        jacopo.mondi@ideasonboard.com, Prakash.Battu@microchip.com
Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Y/iWulpOQl3gG3QI@valkosipuli.retiisi.eu>
References: <20230208050915.1958183-1-shravan.chippa@microchip.com>
 <20230208050915.1958183-4-shravan.chippa@microchip.com>
 <Y/Xc9RCmO8P8eKtL@valkosipuli.retiisi.eu>
 <Y/XnWOomz2N9fCvc@wendy>
 <Y/XoXZJUKKGzGVVL@valkosipuli.retiisi.eu>
 <Y/XpClyi9KMtLKcF@valkosipuli.retiisi.eu>
 <PH0PR11MB5611D8EE3F896FC0BE9A842E81AA9@PH0PR11MB5611.namprd11.prod.outlook.com>
 <Y/X9YiLJxDfLPNUX@valkosipuli.retiisi.eu>
 <PH0PR11MB5611BB17A5DFAB0645D8DEB781A89@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB5611BB17A5DFAB0645D8DEB781A89@PH0PR11MB5611.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shravan,

On Fri, Feb 24, 2023 at 10:02:51AM +0000, Shravan.Chippa@microchip.com wrote:
> Hi Sakari,
> 
> > -----Original Message-----
> > From: Sakari Ailus <sakari.ailus@iki.fi>
> > Sent: 22 February 2023 05:03 PM
> > To: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>
> > Cc: Conor Dooley - M52691 <Conor.Dooley@microchip.com>;
> > paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > mchehab@kernel.org; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > s.hauer@pengutronix.de; kernel@pengutronix.de; festevam@gmail.com;
> > linux-imx@nxp.com; linux-media@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; jacopo.mondi@ideasonboard.com; Battu
> > Prakash Reddy - I30399 <Prakash.Battu@microchip.com>
> > Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower bandwidth
> > mode
> > 
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the
> > content is safe
> > 
> > On Wed, Feb 22, 2023 at 10:20:56AM +0000, Shravan.Chippa@microchip.com
> > wrote:
> > > Hi Sakari,
> > >
> > > > -----Original Message-----
> > > > From: Sakari Ailus <sakari.ailus@iki.fi>
> > > > Sent: 22 February 2023 03:36 PM
> > > > To: Conor Dooley - M52691 <Conor.Dooley@microchip.com>
> > > > Cc: shravan Chippa - I35088 <Shravan.Chippa@microchip.com>;
> > > > paul.j.murphy@intel.com; daniele.alessandrelli@intel.com;
> > > > mchehab@kernel.org; robh+dt@kernel.org;
> > > > krzysztof.kozlowski+dt@linaro.org; shawnguo@kernel.org;
> > > > s.hauer@pengutronix.de; kernel@pengutronix.de;
> > festevam@gmail.com;
> > > > linux-imx@nxp.com; linux-media@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
> > > > kernel@lists.infradead.org; Jacopo Mondi
> > > > <jacopo.mondi@ideasonboard.com>; Battu Prakash Reddy - I30399
> > > > <Prakash.Battu@microchip.com>
> > > > Subject: Re: [PATCH v11 3/5] media: i2c: imx334: support lower
> > > > bandwidth mode
> > > >
> > > > EXTERNAL EMAIL: Do not click links or open attachments unless you
> > > > know the content is safe
> > > >
> > > > On Wed, Feb 22, 2023 at 12:03:10PM +0200, Sakari Ailus wrote:
> > > > > On Wed, Feb 22, 2023 at 09:58:48AM +0000, Conor Dooley wrote:
> > > > > > On Wed, Feb 22, 2023 at 11:14:29AM +0200, Sakari Ailus wrote:
> > > > > > > On Wed, Feb 08, 2023 at 10:39:13AM +0530, shravan kumar wrote:
> > > > > > > > From: Shravan Chippa <shravan.chippa@microchip.com>
> > > > > >
> > > > > > > > @@ -666,11 +885,26 @@ static int imx334_init_pad_cfg(struct
> > > > v4l2_subdev *sd,
> > > > > > > >         struct v4l2_subdev_format fmt = { 0 };
> > > > > > > >
> > > > > > > >         fmt.which = sd_state ? V4L2_SUBDEV_FORMAT_TRY :
> > > > V4L2_SUBDEV_FORMAT_ACTIVE;
> > > > > > > > -       imx334_fill_pad_format(imx334, &supported_mode, &fmt);
> > > > > > > > +       imx334_fill_pad_format(imx334, &supported_modes[0],
> > > > > > > > + &fmt);
> > > > > > >
> > > > > > > Now that there are multiple modes supported, this would appear
> > > > > > > to get the width, height as well as the other fields (apart
> > > > > > > from mbus
> > > > > > > code) from the first mode.
> > > > > >
> > > > > > Is this statement supposed to be a request to change something,
> > > > > > or just a throwaway comment? It's a little hard for me to
> > > > > > understand your intention here, sorry.
> > > > >
> > > > > Just pointing to what looks like a bug.
> > > >
> > > > Ah, my bad. Please ignore the comment.
> > > >
> > > > This is indeed about init_cfg(), not s_fmt().
> > > >
> > >
> > > I will try to fix init_cfg()
> > 
> > There's no problem with it. Please ignore my original comment on this.
> 
> Just checking, Do I need to do any modifications or the current code is fine?

The init_cfg() implementation is, but please see my other e-mail.

-- 
Regards,

Sakari Ailus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83895F2303
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiJBMAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJBMAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:00:18 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC8F23CBFC;
        Sun,  2 Oct 2022 05:00:17 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 0A40320048;
        Sun,  2 Oct 2022 15:00:14 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1664712014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FrLYarGFShE9/eUllOiNTSAbdpMQ9Au96wPgn4COEuU=;
        b=ZjHXtiermOjpv2A5ZVQ2tYKiXDGhAL9g9bJlnhJA7t9f/OV4YqJDDXMlUMVJd5rOPtrB6X
        y911076nOaPPoAUfq5MEv8Mx9+Qbw7mazECe3ydvgqzWSYoD4Pg//aDa2AxcoD1NJqtlhs
        ml/7DC+LuLGHxTDvKjwN4x5A7hZ910E=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id CC0FA634CA9;
        Sun,  2 Oct 2022 15:00:12 +0300 (EEST)
Date:   Sun, 2 Oct 2022 15:00:12 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Shravan.Chippa@microchip.com
Cc:     paul.j.murphy@intel.com, daniele.alessandrelli@intel.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        Prakash.Battu@microchip.com
Subject: Re: [PATCH v4] media: i2c: imx334: support lower bandwidth mode
Message-ID: <Yzl9TCGtR/ddHNOG@valkosipuli.retiisi.eu>
References: <20220920051023.12330-1-shravan.chippa@microchip.com>
 <YymuoFhxHBQLAicQ@valkosipuli.retiisi.eu>
 <PH0PR11MB56118BCE8F6B5E045485A71C81529@PH0PR11MB5611.namprd11.prod.outlook.com>
 <YzHYi2FQN1R+Ge4w@valkosipuli.retiisi.eu>
 <PH0PR11MB5611B27A6A2EFA9ABD79AB5E81599@PH0PR11MB5611.namprd11.prod.outlook.com>
 <PH0PR11MB56110214AA9709893DD5100281589@PH0PR11MB5611.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR11MB56110214AA9709893DD5100281589@PH0PR11MB5611.namprd11.prod.outlook.com>
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1664712014; a=rsa-sha256; cv=none;
        b=rkkHVQtSTXbekkzy62GpZKwm4EdZQiGo6HSWJKd/SOItkK0gXOc2kT5xZvVCpVdAgbG6u+
        SQbJ+KKZ1vmRpp6Sh1I3k2vkQhLVtqpuwh2IZ3HTy9/lWFtmxdrw5CqQtsa7ViEfUDPD8l
        YVIxSSgp5DauiMc4z8cEAhApHceaJ1E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1664712014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FrLYarGFShE9/eUllOiNTSAbdpMQ9Au96wPgn4COEuU=;
        b=yOKT3+mqw9+96e/DEzHhyyb+AMRFaBx6XaFQ6wWPj6lswUhFfxM3TjvhqDMHMVakA9Y2hg
        4ucSSUrQz0T/vXYdJEgSfBcxVa+AsO0ZML8M9GkDM3cx0FT1XPNouagtuPo2d8T6h1cba/
        hsPvOz7qdYdQKB4zfK5Z1+5/Hba9vxo=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 02, 2022 at 04:42:06AM +0000, Shravan.Chippa@microchip.com wrote:
> > > > > > +830,13 @@ static int imx334_set_pad_format(struct v4l2_subdev
> > > > > > *sd,
> > > > > >
> > > > > >       mutex_lock(&imx334->mutex);
> > > > > >
> > > > > > -     mode = &supported_mode;
> > > > > > +     imx334->cur_code = imx334_get_format_code(imx334, fmt);
> > > > >
> > > > > This should be done only for the active format.
> > > > Are you expecting  if condition to check the current bus code with
> > > set_pad_fromat bus code?
> > >
> > > Only assign the cur_code field when setting the active format.
> > I have taken reference from imx219 driver cur_code will update if the requested
> > format bus code maches with available bus_codes list if not mached with
> > available bus_codes it will use defaults one only.
> > am I missing any thing here ?
> 
> R u expecting to change the current bus code when get the V4L2_SUBDEV_FORMAT_ACTIVE requested?
> I will try to modify in the next revision this case.

Yes, please.

-- 
Sakari Ailus

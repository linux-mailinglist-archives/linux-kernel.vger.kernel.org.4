Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C6161E5CE
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 21:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiKFUAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 15:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKFUAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 15:00:20 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B3910FF7;
        Sun,  6 Nov 2022 12:00:18 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z24so13407460ljn.4;
        Sun, 06 Nov 2022 12:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YdIXD62YRYwd2o9Gpu39oSjQE9YhzoJodAvTFDp9pKc=;
        b=U5DOEN7gFVqJ6jH+vtI8yJP+hq91bUZ0eQseTZCqbvW/ecO5gwtvcwwa9xHT4IXO+9
         G3/jWYbXho+5ZpGDiO7BHuAdHDMHI14cCA6oMAPWc45YyhZ9Ys6J+W/3Zjcw1G/fE2QI
         fGYF1J6wIwmMJMV7QUrpJoY3vGrGdsZMcdIoUxq6Z/M53AKoukK0LoGYPflYVNyPHJtj
         dE4bxl0sN8lEB/lg/6REU/nOU9JdY12SAZo3szKAOzlipzM/F0osRMs5WCV0y1SUFtH8
         j2UN+jhztd8eHrhC4tU+fRwWyoWqSxTfwCEv71po66+mllAgrusJMFZTFV/YdEu9W3QV
         whTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YdIXD62YRYwd2o9Gpu39oSjQE9YhzoJodAvTFDp9pKc=;
        b=20OO0UadjBqJx0mw63QyDFzscZpaY63oXvXEXqUA3Qkq4WabfamjUeDzT9KS5aZaq0
         HquyGZgl+xmFG4M/Nryv31CCyHAzkJdUgFUdD28OJXByfmHkLOapBQU3nggxAvMn3+BZ
         LEUZTOYD+M2XGuUQo47OTryy39P6oQ46pcqL5fkAeaDVXN3h6EeEUGAwRV5eeRA6mIU1
         MvccjSqtyeSvkIcjLtaO7wN7mIS/qGcrd/8n4gO5CSk3xCAUCfkd92yXHR/cJsPPZ9Av
         XB6j2oqVvjdR/33VZd9jaZZ/KF/ugnrc9zzwKcioMyjLrpl82QY4sLIVje59e4S/uE+H
         wPAQ==
X-Gm-Message-State: ACrzQf2gzp04md3SaN4sc1piLdMjSgKcgZr/k2iNaAfPwl5kztflFQDJ
        k4YL3Eyb5f+sPYupHj8Jm0eBuTpGa96pMQ==
X-Google-Smtp-Source: AMsMyM6bDLdQ7R2/7Gr7AP+9+4wrZNd37DLf3MWHlSURnzLv+D+uxSArxN7Ed2zNLCl+vNW7ilWAeg==
X-Received: by 2002:a05:651c:110e:b0:277:4a04:ad9a with SMTP id e14-20020a05651c110e00b002774a04ad9amr15371286ljo.379.1667764815944;
        Sun, 06 Nov 2022 12:00:15 -0800 (PST)
Received: from localhost.localdomain (static.9.224.99.88.clients.your-server.de. [88.99.224.9])
        by smtp.gmail.com with ESMTPSA id o13-20020ac24e8d000000b0048aa9d67483sm841196lfr.160.2022.11.06.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 12:00:15 -0800 (PST)
Received: from jek by localhost.localdomain with local (Exim 4.96)
        (envelope-from <jekhor@gmail.com>)
        id 1orlmO-001x4s-07;
        Sun, 06 Nov 2022 21:58:04 +0200
Date:   Sun, 6 Nov 2022 21:58:04 +0200
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>
Subject: Re: [PATCH] HID: hid-sensor-custom: Allow more than one hinge angle
 sensor
Message-ID: <Y2gRzHpH5FwNVBoO@jeknote.loshitsa1.net>
References: <20221105223422.417316-1-jekhor@gmail.com>
 <20221106173643.5b4f2a0b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106173643.5b4f2a0b@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 05:36:43PM +0000, Jonathan Cameron wrote:
> On Sun,  6 Nov 2022 00:34:22 +0200
> Yauhen Kharuzhy <jekhor@gmail.com> wrote:
> 
> > Some devices has two sets of accelerometers and the sensor hub exports
> > two hinge angle 'sensors' based on accelerometer values. To allow more
> > than one sensor of the same type, use PLATFORM_DEVID_AUTO instead of
> > PLATFORM_DEVID_NONE when registering platform device for it.
> > 
> > Checked on the Lenovo Yoga Book YB1-X91L tablet.
> > 
> > Signed-off-by: Yauhen Kharuzhy <jekhor@gmail.com>
> 
> Purely for curiosity sake, but where are the two sets of sensors?
> Doesn't look like it has two hinges at first glance!

It sounds crazy, yes :)

The Lenovo Yoga Book YB1-X91L looks to be strange device in many ways.

There are two accelerometers at display side and two at keyboard side (for
detecting the rotation movement as I understand). For
some reasons ISH exposed two virtual hinge angle sensors (I guess that
one for each pair of accelerometers):

...
[    6.230627] Registering platform device 'HID-SENSOR-INT-020b.35.auto'. Parent at 001F:8087:0AC2.0005
[    6.230658] device: 'HID-SENSOR-INT-020b.35.auto': device_add
[    6.230705] bus: 'platform': add device HID-SENSOR-INT-020b.35.auto
[    6.230737] PM: Adding info for platform:HID-SENSOR-INT-020b.35.auto
...
[    6.249248] Registering platform device 'HID-SENSOR-INT-020b.36.auto'. Parent at 001F:8087:8AC2.0006
[    6.249266] device: 'HID-SENSOR-INT-020b.36.auto': device_add
[    6.249295] bus: 'platform': add device HID-SENSOR-INT-020b.36.auto
[    6.249394] PM: Adding info for platform:HID-SENSOR-INT-020b.36.auto

This is senseless but it is what it is. Moreover, this 'sensor' is always
returns 360 degrees angle, although display and keyboard 'absolute' angles are
reported correctly.

In any way, this patch is generic and will be useful for other custom HID
sensors if they will be added in the future.

> 
> Jonathan
> 
> > ---
> >  drivers/hid/hid-sensor-custom.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> > index 32c2306e240d6..a6fc89ee1287c 100644
> > --- a/drivers/hid/hid-sensor-custom.c
> > +++ b/drivers/hid/hid-sensor-custom.c
> > @@ -862,7 +862,7 @@ hid_sensor_register_platform_device(struct platform_device *pdev,
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	custom_pdev = platform_device_register_data(pdev->dev.parent, dev_name,
> > -						    PLATFORM_DEVID_NONE, hsdev,
> > +						    PLATFORM_DEVID_AUTO, hsdev,
> >  						    sizeof(*hsdev));
> >  	kfree(dev_name);
> >  	return custom_pdev;
> 

-- 
Yauhen Kharuzhy

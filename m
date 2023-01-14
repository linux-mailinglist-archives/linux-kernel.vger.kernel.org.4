Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 953C166AE3A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 22:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjANVtP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 16:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjANVtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 16:49:07 -0500
X-Greylist: delayed 36696 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 13:49:05 PST
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D319EDF;
        Sat, 14 Jan 2023 13:49:05 -0800 (PST)
Received: from hillosipuli.retiisi.eu (dkwgw2td6j41r63crh2zt-3.rev.dnainternet.fi [IPv6:2001:14ba:448b:2b40:7a3e:2aed:5c4e:35a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id DDC4F1B002E5;
        Sat, 14 Jan 2023 23:49:02 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1673732943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7hLwEJw4Pb7qb2KhIKkhf2vUiG3X5VhrWk9rvmzvPY=;
        b=nhqhLjQT0fLgQJW1voOwxafw7q0M1KeoEJsZUW1a6FLutkQMk1DOlcnROZTMJYEkbMFz9T
        2hUkh0UN+hIovAaApPt0tjZdkEUpORAZ+puZZh5wP90AryXrl1P+OuJmeyclbFY2N5/01d
        M9dbyjvINCH2BgVttCfU3IoD3TzezYC/ZRW4/IY4nqIWGDm1EkE3PhgjqU5PjKVefyQt4I
        MmiLs5avL5wWTjOrLfR8FqcOSJP/TcWBnNY8mlW0MtRkwnCn5DQNYBcRBgnSYZEkvlWqTy
        OmIm0nHkEDA3/OTqsyvU4Y9mY5PrKz9nqF1xKIzqxM3m+QFSb44Jn99WJqV8/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1673732943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=N7hLwEJw4Pb7qb2KhIKkhf2vUiG3X5VhrWk9rvmzvPY=;
        b=IgIeVSwnpc1Wx/CAsLAUlwujHbXTuObgfgmSEIiebc699UcKXASR2KJ43+ARVlK4x4hXEI
        BpCwB/V0LCtF2wZR7Tlh80STTPSfzC+zvSGpm0podoOJ5uZBOnHwwYa3Cz6jaD1rDGXsjr
        tqyfkQuGYAl98Bcq/PWjT0K3JQCHJVuwzBSpNce5UjezClnTQ862IH0kYjolYp/d0wxu7H
        q8frsbLmwDVpMCVgJRcWzOvSa7Zp7txwvaitq1hduAdIOo8Odqkd02ETX4+cpNpAPqWGpu
        DAryGU6Dcv4oJb7BA/e7GdCj98S1K0j342sd+f0BEs5H/SLp3os+m1W9panw3A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1673732943; a=rsa-sha256;
        cv=none;
        b=m7KRI8Qr3qiNKxvJ2oKy5mtphFMEuKqm2PAOODaiQ1vjXCV/QEDeqT0ds8ydvpEBQjlGVL
        HbfqaMMh5rQqogkI5WomXlFd5xT/0MJcsSyUMDjc9QYdkxafeB0El0i0EHLpE49xh0YnZK
        UtW0WLKaKQ2vm/AXgLRcx7p3a8vzTxk+LwZhcltfGYTsch4ktKGgT40YdZinYOt/4srdov
        9zodTdVL4y+p2p4aBsy0U1akgnLHfOEB9YTPT+EXUEdzvYR1gVCOtyRfLFDq0Dk7Zurstd
        zutwpyOznZR/yV1KMInb1n4Rbip/nDvixlOrLYRVipNeRugUiDGomQHcciixFA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 5C92B634C91;
        Sat, 14 Jan 2023 23:49:02 +0200 (EET)
Date:   Sat, 14 Jan 2023 23:49:02 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov5640: Update last busy timestamp to reset
 autosuspend timer
Message-ID: <Y8MjThKZLWnqfe0I@valkosipuli.retiisi.eu>
References: <20230114112109.982005-1-andrej.skvortzov@gmail.com>
 <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
 <20230114151906.gkgmhzpq64dhwouu@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114151906.gkgmhzpq64dhwouu@uno.localdomain>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacopo,

On Sat, Jan 14, 2023 at 04:19:06PM +0100, Jacopo Mondi wrote:
> Hi Sakari
> 
> On Sat, Jan 14, 2023 at 02:29:14PM +0200, Sakari Ailus wrote:
> > Hi Andrey,
> >
> > On Sat, Jan 14, 2023 at 02:21:09PM +0300, Andrey Skvortsov wrote:
> > > Otherwise autosuspend delay doesn't work and power is cut off
> > > immediately as device is freed.
> > >
> > > Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> > > ---
> > >  drivers/media/i2c/ov5640.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> > > index ac35350..f71c0f7 100644
> > > --- a/drivers/media/i2c/ov5640.c
> > > +++ b/drivers/media/i2c/ov5640.c
> > > @@ -1238,6 +1238,7 @@ static int ov5640_write_reg(struct ov5640_dev *sensor, u16 reg, u8 val)
> > >  		return ret;
> > >  	}
> > >
> > > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> > >  	return 0;
> > >  }
> > >
> > > @@ -1305,6 +1306,7 @@ static int ov5640_read_reg(struct ov5640_dev *sensor, u16 reg, u8 *val)
> > >  	}
> > >
> > >  	*val = buf[0];
> > > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> >
> > I wouldn't add these calls to register accesses. It's generally relevant
> > with autosuspend_put().
> >
> > The rest seems fine to me.
> >
> 
> Does it mean the same should be done for the all the sensor drivers that
> use autosuspend ? I count 8 of them, not a huge number.

pm_runtime_mark_last_busy() should be called before
pm_runtime_put_autosuspend(). I was thinking of adding a helper that would
simply call both of them. We don't have that yet though.

> 
> > >  	return 0;
> > >  }
> > >
> > > @@ -3615,6 +3617,7 @@ static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
> > >  		break;
> > >  	}
> > >
> > > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> > >  	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
> > >
> > >  	return 0;
> > > @@ -3702,6 +3705,7 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
> > >  		break;
> > >  	}
> > >
> > > +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> > >  	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
> > >
> > >  	return ret;
> > > @@ -4034,8 +4038,10 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
> > >  out:
> > >  	mutex_unlock(&sensor->lock);
> > >
> > > -	if (!enable || ret)
> > > +	if (!enable || ret) {
> > > +		pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
> > >  		pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
> > > +	}
> > >
> > >  	return ret;
> > >  }
> > > @@ -4203,6 +4209,7 @@ static int ov5640_probe(struct i2c_client *client)
> > >
> > >  	pm_runtime_set_autosuspend_delay(dev, 1000);
> > >  	pm_runtime_use_autosuspend(dev);
> > > +	pm_runtime_mark_last_busy(dev);
> > >  	pm_runtime_put_autosuspend(dev);
> > >
> > >  	return 0;

-- 
Kind regards,

Sakari Ailus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33B1066AB58
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 13:29:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjANM3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 07:29:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbjANM3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 07:29:19 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA707683;
        Sat, 14 Jan 2023 04:29:18 -0800 (PST)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5B0801B001E0;
        Sat, 14 Jan 2023 14:29:15 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1673699355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RX8+ULODkz65zJx9VQad95+VUhDEkgtu+lSo5Iwr/n0=;
        b=JnJCNzzzsU6UNbHk1CGRtCt03M2x4NisqjMC180sM+8ma3Fwua5GOAswFA8ZVsLCbR+mDL
        FNDyPGv9718q0vwtlsJ2iRyv5uqJc31rs0wE2Np0e9j5hCqU2uiTFChjzCdZFeYWrExaI7
        fX1Mn0QQR45AcfJveDzN3mbsDl0qPVAKXPit2ELu8aPy1xtYOrmQ1XB5QlZkc153EfSBxp
        VsEoSXGGSMJU2yt4O3231shH6///IQXZB5g1cYN1p7tGbAS/l0qdupI7bPyZmQwdwxOml5
        1UlvQoIoGTQNfiLmARzglIHOKDXNf8lEzefMGrznd9fXsgyl8xKq5xZ6S7fSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1673699355;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RX8+ULODkz65zJx9VQad95+VUhDEkgtu+lSo5Iwr/n0=;
        b=skDo4sKgBahs/EN+ztEyq2UfLh+/LxzcoLOVubc2WtkB3m9wGTrNpvxPN1RxcDxG5hgrjz
        +ZMyg+gpuCcQEVj55ZgJAgzjTDZc111eDJb61B703QjkOHduvgpTCKwT/fDV4N8H0/WBR/
        eBjdKOvv5BSYA3CIhsT1zCsOhZLvV3j0xJd2k+avvQdALA/Da1ko6TsT1icC8XxVKWM3Ck
        x4mK034lFJJ4yPcumgFoPUsRx1z+siAzugMu7mHgHlOVN6SNtsXUApvUeNUslxZIRNDTD0
        EVlMRRwmhxfOqIpOya9iYeKSWfLA65HmQnZVeHvfojS/eiI3nNlq83oPJaMZHQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1673699355; a=rsa-sha256;
        cv=none;
        b=eJtpfH4q7M1iM0+iL2czkqKv2sJxL62fwjzQ/BwIuw57xisz5VsgUIdg0hlpM9eWQ/0kP3
        jXd2v+/x+JqQNExoLEAw76qJNfDkN6b8tayo7VyPRiPL1HFXfcyYoAkHDHlEez8zRREEZf
        yfrdg3onSXcFn65XMjjnTzdx05joMOEqM0En/WNarNZr2E5wnBz1yqCtI7Fa3PiksyXfKZ
        n0WxsBrKeCitaWsa4R/SEpzaayOQMD8no/+/X4q5gCXcOgUGjnQ7eONLLsNJOSGU4GK4KO
        ihVvH+6fjbVW3hViZwJHmFxSArnWGnNSSRaUpypaFhvTYPAMEnlrYKi6YGowSw==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 0790A634C91;
        Sat, 14 Jan 2023 14:29:15 +0200 (EET)
Date:   Sat, 14 Jan 2023 14:29:14 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc:     Steve Longerbeam <slongerbeam@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: ov5640: Update last busy timestamp to reset
 autosuspend timer
Message-ID: <Y8KgGhu0e/+xIfDm@valkosipuli.retiisi.eu>
References: <20230114112109.982005-1-andrej.skvortzov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230114112109.982005-1-andrej.skvortzov@gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On Sat, Jan 14, 2023 at 02:21:09PM +0300, Andrey Skvortsov wrote:
> Otherwise autosuspend delay doesn't work and power is cut off
> immediately as device is freed.
> 
> Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> ---
>  drivers/media/i2c/ov5640.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/i2c/ov5640.c b/drivers/media/i2c/ov5640.c
> index ac35350..f71c0f7 100644
> --- a/drivers/media/i2c/ov5640.c
> +++ b/drivers/media/i2c/ov5640.c
> @@ -1238,6 +1238,7 @@ static int ov5640_write_reg(struct ov5640_dev *sensor, u16 reg, u8 val)
>  		return ret;
>  	}
>  
> +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
>  	return 0;
>  }
>  
> @@ -1305,6 +1306,7 @@ static int ov5640_read_reg(struct ov5640_dev *sensor, u16 reg, u8 *val)
>  	}
>  
>  	*val = buf[0];
> +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);

I wouldn't add these calls to register accesses. It's generally relevant
with autosuspend_put().

The rest seems fine to me.

>  	return 0;
>  }
>  
> @@ -3615,6 +3617,7 @@ static int ov5640_g_volatile_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>  
> +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
>  	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
>  
>  	return 0;
> @@ -3702,6 +3705,7 @@ static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
>  		break;
>  	}
>  
> +	pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
>  	pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
>  
>  	return ret;
> @@ -4034,8 +4038,10 @@ static int ov5640_s_stream(struct v4l2_subdev *sd, int enable)
>  out:
>  	mutex_unlock(&sensor->lock);
>  
> -	if (!enable || ret)
> +	if (!enable || ret) {
> +		pm_runtime_mark_last_busy(&sensor->i2c_client->dev);
>  		pm_runtime_put_autosuspend(&sensor->i2c_client->dev);
> +	}
>  
>  	return ret;
>  }
> @@ -4203,6 +4209,7 @@ static int ov5640_probe(struct i2c_client *client)
>  
>  	pm_runtime_set_autosuspend_delay(dev, 1000);
>  	pm_runtime_use_autosuspend(dev);
> +	pm_runtime_mark_last_busy(dev);
>  	pm_runtime_put_autosuspend(dev);
>  
>  	return 0;

-- 
Kind regards,

Sakari Ailus

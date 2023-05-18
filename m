Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D0F67086A3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 19:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjERRVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 13:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjERRU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 13:20:59 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6842110EA
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:20:41 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id e9e14a558f8ab-331430faba8so6126235ab.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 10:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684430440; x=1687022440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vVSxvlh7OV4WgJkuSWdWlAS0yxwMUwbwpza12fN3Oyo=;
        b=eF4DxBhYcEzv/5dxQgfJJTfByYgKaFzDnWDv+j5fXUL0ox1dRJxp3J/LPL2pmGbMgd
         nPCH2I9zZHm8vHxIq0gaBkHk0yHXKGY7B6Qi17oT57TdU3xaBqh5tq81TNZ7qC444io3
         +ZRGPUCG+66O/7lyE7CXeS5J5Rwnd6FcMiOSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684430440; x=1687022440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVSxvlh7OV4WgJkuSWdWlAS0yxwMUwbwpza12fN3Oyo=;
        b=ZV0KxnYg6LsDUVuYZSwLSdGheM/njIXboXc0ChYg28Lf1tAD/s9/5IMaA1ZfFFsCzQ
         Fgj2GxyiIt5/l/fFn6zYK2wEVOjZL1JgNJjrBYLQc/6bpsUSuBaN3BGbbqRiJkIRJT5Z
         iAkgXqL9iFCpeY9O4aTW/WwLdexx60elHh+i9am13U+2qqrQNd+epavcCr/QoiVGybHW
         avL1FMWxnv0kZjqOcAM2jK1LAsWrAg4D7QNcoBwc5/qjRP5cMFH8PSDIj1MBRnhAwvAC
         6i2Iku+MNW3+hlJUTiQsrOUoFVcQSxjvobgTf4ZoRU/rhWs4BqGAuWafKVnKWjOMeJ3z
         h+2g==
X-Gm-Message-State: AC+VfDwOGAYQx4howQ9uPsTbX40qxrIeqlIsavk1dhW9d7uImac54VSp
        CHHrVNh3JJOAzrBz9l3I6+oiA/V687Ky8dJWhc4fvQ==
X-Google-Smtp-Source: ACHHUZ7BIfeS7AouCi74LtqEssczjpT7ICfhIRrBGjk8mAi/bXVB8gNf3yDX1HvrnQLoJq/kzufNAQ==
X-Received: by 2002:a92:c150:0:b0:329:5a6e:3a18 with SMTP id b16-20020a92c150000000b003295a6e3a18mr4248855ilh.4.1684430440398;
        Thu, 18 May 2023 10:20:40 -0700 (PDT)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id d99-20020a0285ec000000b0040fc2eebb90sm564556jai.171.2023.05.18.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 10:20:40 -0700 (PDT)
Date:   Thu, 18 May 2023 11:20:38 -0600
From:   Raul E Rangel <rrangel@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Input: libps2 - attach ps2dev instances as serio
 port's drvdata
Message-ID: <ZGZeZt8C8YzQLAdz@google.com>
References: <20230511185252.386941-1-dmitry.torokhov@gmail.com>
 <20230511185252.386941-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511185252.386941-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 11:52:41AM -0700, Dmitry Torokhov wrote:
> In preparation of having unified interrupt handler for PS/2 devices,
> instead of attaching instances of psmouse and atkbd structures as serio's
> driver data, switch to attaching ps2dev instances.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> ---
>  drivers/input/keyboard/atkbd.c     | 23 +++++++++++++-------
>  drivers/input/mouse/psmouse-base.c | 35 +++++++++++++++++-------------
>  drivers/input/mouse/psmouse.h      |  2 ++
>  drivers/input/mouse/synaptics.c    | 10 ++++-----
>  drivers/input/mouse/trackpoint.c   |  2 +-
>  drivers/input/serio/libps2.c       |  1 +
>  6 files changed, 44 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
> index 246958795f60..2fb2ad73e796 100644
> --- a/drivers/input/keyboard/atkbd.c
> +++ b/drivers/input/keyboard/atkbd.c
> @@ -309,12 +309,19 @@ static ssize_t atkbd_show_function_row_physmap(struct atkbd *atkbd, char *buf)
>  	return vivaldi_function_row_physmap_show(&atkbd->vdata, buf);
>  }
>  
> +static struct atkbd *atkbd_from_serio(struct serio *serio)
> +{
> +	struct ps2dev *ps2dev = serio_get_drvdata(serio);
> +
> +	return container_of(ps2dev, struct atkbd, ps2dev);
> +}
> +
>  static umode_t atkbd_attr_is_visible(struct kobject *kobj,
>  				struct attribute *attr, int i)
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct serio *serio = to_serio_port(dev);
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  
>  	if (attr == &atkbd_attr_function_row_physmap.attr &&
>  	    !atkbd->vdata.num_function_row_keys)
> @@ -399,7 +406,7 @@ static unsigned int atkbd_compat_scancode(struct atkbd *atkbd, unsigned int code
>  static irqreturn_t atkbd_interrupt(struct serio *serio, unsigned char data,
>  				   unsigned int flags)
>  {
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  	struct input_dev *dev = atkbd->dev;
>  	unsigned int code = data;
>  	int scroll = 0, hscroll = 0, click = -1;
> @@ -909,7 +916,7 @@ static int atkbd_reset_state(struct atkbd *atkbd)
>  
>  static void atkbd_cleanup(struct serio *serio)
>  {
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  
>  	atkbd_disable(atkbd);
>  	ps2_command(&atkbd->ps2dev, NULL, ATKBD_CMD_RESET_DEF);
> @@ -922,7 +929,7 @@ static void atkbd_cleanup(struct serio *serio)
>  
>  static void atkbd_disconnect(struct serio *serio)
>  {
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  
>  	atkbd_disable(atkbd);
>  
> @@ -1188,7 +1195,7 @@ static void atkbd_set_device_attrs(struct atkbd *atkbd)
>  
>  static void atkbd_parse_fwnode_data(struct serio *serio)
>  {
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  	struct device *dev = &serio->dev;
>  	int n;
>  
> @@ -1295,7 +1302,7 @@ static int atkbd_connect(struct serio *serio, struct serio_driver *drv)
>  
>  static int atkbd_reconnect(struct serio *serio)
>  {
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  	struct serio_driver *drv = serio->drv;
>  	int retval = -1;
>  
> @@ -1389,7 +1396,7 @@ static ssize_t atkbd_attr_show_helper(struct device *dev, char *buf,
>  				ssize_t (*handler)(struct atkbd *, char *))
>  {
>  	struct serio *serio = to_serio_port(dev);
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  
>  	return handler(atkbd, buf);
>  }
> @@ -1398,7 +1405,7 @@ static ssize_t atkbd_attr_set_helper(struct device *dev, const char *buf, size_t
>  				ssize_t (*handler)(struct atkbd *, const char *, size_t))
>  {
>  	struct serio *serio = to_serio_port(dev);
> -	struct atkbd *atkbd = serio_get_drvdata(serio);
> +	struct atkbd *atkbd = atkbd_from_serio(serio);
>  	int retval;
>  
>  	retval = mutex_lock_interruptible(&atkbd->mutex);
> diff --git a/drivers/input/mouse/psmouse-base.c b/drivers/input/mouse/psmouse-base.c
> index c9a7e87b273e..ed5376099fba 100644
> --- a/drivers/input/mouse/psmouse-base.c
> +++ b/drivers/input/mouse/psmouse-base.c
> @@ -116,6 +116,13 @@ static DEFINE_MUTEX(psmouse_mutex);
>  
>  static struct workqueue_struct *kpsmoused_wq;
>  
> +struct psmouse *psmouse_from_serio(struct serio *serio)
> +{
> +	struct ps2dev *ps2dev = serio_get_drvdata(serio);
> +
> +	return container_of(ps2dev, struct psmouse, ps2dev);
> +}
> +
>  void psmouse_report_standard_buttons(struct input_dev *dev, u8 buttons)
>  {
>  	input_report_key(dev, BTN_LEFT,   buttons & BIT(0));
> @@ -336,7 +343,7 @@ static void psmouse_handle_oob_data(struct psmouse *psmouse, u8 data)
>  static irqreturn_t psmouse_interrupt(struct serio *serio,
>  				     u8 data, unsigned int flags)
>  {
> -	struct psmouse *psmouse = serio_get_drvdata(serio);
> +	struct psmouse *psmouse = psmouse_from_serio(serio);
>  
>  	if (psmouse->state == PSMOUSE_IGNORE)
>  		goto out;
> @@ -1344,7 +1351,7 @@ static void psmouse_resync(struct work_struct *work)
>  		goto out;
>  
>  	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
> -		parent = serio_get_drvdata(serio->parent);
> +		parent = psmouse_from_serio(serio->parent);
>  		psmouse_deactivate(parent);
>  	}
>  
> @@ -1428,13 +1435,13 @@ static void psmouse_resync(struct work_struct *work)
>   */
>  static void psmouse_cleanup(struct serio *serio)
>  {
> -	struct psmouse *psmouse = serio_get_drvdata(serio);
> +	struct psmouse *psmouse = psmouse_from_serio(serio);
>  	struct psmouse *parent = NULL;
>  
>  	mutex_lock(&psmouse_mutex);
>  
>  	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
> -		parent = serio_get_drvdata(serio->parent);
> +		parent = psmouse_from_serio(serio->parent);
>  		psmouse_deactivate(parent);
>  	}
>  
> @@ -1476,7 +1483,7 @@ static void psmouse_cleanup(struct serio *serio)
>   */
>  static void psmouse_disconnect(struct serio *serio)
>  {
> -	struct psmouse *psmouse = serio_get_drvdata(serio);
> +	struct psmouse *psmouse = psmouse_from_serio(serio);
>  	struct psmouse *parent = NULL;
>  
>  	mutex_lock(&psmouse_mutex);
> @@ -1489,7 +1496,7 @@ static void psmouse_disconnect(struct serio *serio)
>  	mutex_lock(&psmouse_mutex);
>  
>  	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
> -		parent = serio_get_drvdata(serio->parent);
> +		parent = psmouse_from_serio(serio->parent);
>  		psmouse_deactivate(parent);
>  	}
>  
> @@ -1588,7 +1595,7 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
>  	 * connected to this port can be successfully identified
>  	 */
>  	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
> -		parent = serio_get_drvdata(serio->parent);
> +		parent = psmouse_from_serio(serio->parent);
>  		psmouse_deactivate(parent);
>  	}
>  
> @@ -1604,8 +1611,6 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
>  
>  	psmouse_set_state(psmouse, PSMOUSE_INITIALIZING);
>  
> -	serio_set_drvdata(serio, psmouse);
> -
>  	error = serio_open(serio, drv);
>  	if (error)
>  		goto err_clear_drvdata;
> @@ -1676,7 +1681,7 @@ static int psmouse_connect(struct serio *serio, struct serio_driver *drv)
>  
>  static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
>  {
> -	struct psmouse *psmouse = serio_get_drvdata(serio);
> +	struct psmouse *psmouse = psmouse_from_serio(serio);
>  	struct psmouse *parent = NULL;
>  	int (*reconnect_handler)(struct psmouse *);
>  	enum psmouse_type type;
> @@ -1695,7 +1700,7 @@ static int __psmouse_reconnect(struct serio *serio, bool fast_reconnect)
>  	}
>  
>  	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
> -		parent = serio_get_drvdata(serio->parent);
> +		parent = psmouse_from_serio(serio->parent);
>  		psmouse_deactivate(parent);
>  	}
>  
> @@ -1794,7 +1799,7 @@ ssize_t psmouse_attr_show_helper(struct device *dev, struct device_attribute *de
>  {
>  	struct serio *serio = to_serio_port(dev);
>  	struct psmouse_attribute *attr = to_psmouse_attr(devattr);
> -	struct psmouse *psmouse = serio_get_drvdata(serio);
> +	struct psmouse *psmouse = psmouse_from_serio(serio);
>  
>  	if (psmouse->protocol->smbus_companion &&
>  			devattr != &psmouse_attr_protocol.dattr)
> @@ -1815,7 +1820,7 @@ ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *dev
>  	if (retval)
>  		goto out;
>  
> -	psmouse = serio_get_drvdata(serio);
> +	psmouse = psmouse_from_serio(serio);
>  
>  	if (psmouse->protocol->smbus_companion &&
>  			devattr != &psmouse_attr_protocol.dattr) {
> @@ -1830,7 +1835,7 @@ ssize_t psmouse_attr_set_helper(struct device *dev, struct device_attribute *dev
>  		}
>  
>  		if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
> -			parent = serio_get_drvdata(serio->parent);
> +			parent = psmouse_from_serio(serio->parent);
>  			psmouse_deactivate(parent);
>  		}
>  
> @@ -1925,7 +1930,7 @@ static ssize_t psmouse_attr_set_protocol(struct psmouse *psmouse, void *data, co
>  	}
>  
>  	if (serio->parent && serio->id.type == SERIO_PS_PSTHRU) {
> -		parent = serio_get_drvdata(serio->parent);
> +		parent = psmouse_from_serio(serio->parent);
>  		if (parent->pt_deactivate)
>  			parent->pt_deactivate(parent);
>  	}
> diff --git a/drivers/input/mouse/psmouse.h b/drivers/input/mouse/psmouse.h
> index 64c3a5d3fb3e..4d8acfe0d82a 100644
> --- a/drivers/input/mouse/psmouse.h
> +++ b/drivers/input/mouse/psmouse.h
> @@ -130,6 +130,8 @@ struct psmouse {
>  	void (*pt_deactivate)(struct psmouse *psmouse);
>  };
>  
> +struct psmouse *psmouse_from_serio(struct serio *serio);
> +
>  void psmouse_queue_work(struct psmouse *psmouse, struct delayed_work *work,
>  		unsigned long delay);
>  int psmouse_reset(struct psmouse *psmouse);
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index fa021af8506e..ada299ec5bba 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -628,7 +628,7 @@ static void synaptics_set_rate(struct psmouse *psmouse, unsigned int rate)
>   ****************************************************************************/
>  static int synaptics_pt_write(struct serio *serio, u8 c)
>  {
> -	struct psmouse *parent = serio_get_drvdata(serio->parent);
> +	struct psmouse *parent = psmouse_from_serio(serio->parent);
>  	u8 rate_param = SYN_PS_CLIENT_CMD; /* indicates that we want pass-through port */
>  	int error;
>  
> @@ -645,7 +645,7 @@ static int synaptics_pt_write(struct serio *serio, u8 c)
>  
>  static int synaptics_pt_start(struct serio *serio)
>  {
> -	struct psmouse *parent = serio_get_drvdata(serio->parent);
> +	struct psmouse *parent = psmouse_from_serio(serio->parent);
>  	struct synaptics_data *priv = parent->private;
>  
>  	serio_pause_rx(parent->ps2dev.serio);
> @@ -657,7 +657,7 @@ static int synaptics_pt_start(struct serio *serio)
>  
>  static void synaptics_pt_stop(struct serio *serio)
>  {
> -	struct psmouse *parent = serio_get_drvdata(serio->parent);
> +	struct psmouse *parent = psmouse_from_serio(serio->parent);
>  	struct synaptics_data *priv = parent->private;
>  
>  	serio_pause_rx(parent->ps2dev.serio);
> @@ -672,7 +672,7 @@ static int synaptics_is_pt_packet(u8 *buf)
>  
>  static void synaptics_pass_pt_packet(struct serio *ptport, u8 *packet)
>  {
> -	struct psmouse *child = serio_get_drvdata(ptport);
> +	struct psmouse *child = psmouse_from_serio(ptport);
>  
>  	if (child && child->state == PSMOUSE_ACTIVATED) {
>  		serio_interrupt(ptport, packet[1], 0);
> @@ -688,7 +688,7 @@ static void synaptics_pass_pt_packet(struct serio *ptport, u8 *packet)
>  static void synaptics_pt_activate(struct psmouse *psmouse)
>  {
>  	struct synaptics_data *priv = psmouse->private;
> -	struct psmouse *child = serio_get_drvdata(priv->pt_port);
> +	struct psmouse *child = psmouse_from_serio(priv->pt_port);
>  
>  	/* adjust the touchpad to child's choice of protocol */
>  	if (child) {
> diff --git a/drivers/input/mouse/trackpoint.c b/drivers/input/mouse/trackpoint.c
> index 4a86b3e31d3b..5f6643b69a2c 100644
> --- a/drivers/input/mouse/trackpoint.c
> +++ b/drivers/input/mouse/trackpoint.c
> @@ -216,7 +216,7 @@ static umode_t trackpoint_is_attr_visible(struct kobject *kobj,
>  {
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct serio *serio = to_serio_port(dev);
> -	struct psmouse *psmouse = serio_get_drvdata(serio);
> +	struct psmouse *psmouse = psmouse_from_serio(serio);
>  
>  	return trackpoint_is_attr_available(psmouse, attr) ? attr->mode : 0;
>  }
> diff --git a/drivers/input/serio/libps2.c b/drivers/input/serio/libps2.c
> index 3e19344eda93..764990723847 100644
> --- a/drivers/input/serio/libps2.c
> +++ b/drivers/input/serio/libps2.c
> @@ -382,6 +382,7 @@ void ps2_init(struct ps2dev *ps2dev, struct serio *serio)
>  	lockdep_set_subclass(&ps2dev->cmd_mutex, serio->depth);
>  	init_waitqueue_head(&ps2dev->wait);
>  	ps2dev->serio = serio;
> +	serio_set_drvdata(serio, ps2dev);
>  }
>  EXPORT_SYMBOL(ps2_init);
>  
Reviewed-by: Raul Rangel <rrangel@chromium.org>

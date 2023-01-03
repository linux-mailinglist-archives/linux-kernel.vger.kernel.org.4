Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE365BC36
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjACI2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbjACI2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:28:02 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FC0DF72;
        Tue,  3 Jan 2023 00:28:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j17so23313890wrr.7;
        Tue, 03 Jan 2023 00:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RzTOHhbrAU0werJfvhfCcgLwro7YHGo+Gre2tM+aB2Q=;
        b=NP+Ao11IKxMjc4ptv31s8brg7cWgTw+sd/2DPUuhY/RUW6lZ1V1q4QmmxJu1KjpoAp
         slKmfucI2TNZwfyxKx8KiQe64NDXKAZtNdfQklGTPqfYnntOtgHny4BQ4y93xb5KT8z9
         VB/hg3q+FKmuaJqjXfXBwR8UbwvWyNC7Km3ZDWCpZTj7A9Qmza0b0kHizYtKsWid/u1X
         1DaSqxVusSD7zcYzoHLOShuPYDo5WIAf8/GoZSS6qXN2IECQoOYdoesyvMtrdCxb3aeY
         YxRxDC2O/5U+XiB2GuHeivcI/lFczY+gGY3Un1HgEQLLP365q23x2vPAYh+ZuV6sQI9b
         V61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RzTOHhbrAU0werJfvhfCcgLwro7YHGo+Gre2tM+aB2Q=;
        b=rqEwJYU/mpEYZw9D2Nu4AetC5bzPRN8w4Gt5B1r0E3gzkin3gTPh8cRjhfw2/KUCD8
         O5XvNfdkfbC5nRhd3ws6Sf0JG9E4aA9c8IfgBntFKJePvd+mlVb4uYuNbqf+sYm2JZlA
         6oBnOeRknKFajcoF0ggIC6J73PjRc88VyKW6OQVILhuObzfmalG0XACC6fq5y+0dFe2r
         tvlJS6ZuFP6PP5ws762KOKTWShLpeCG+H7Kjsbscq0ljH10+shb5yACmdvRfhcyIC5M2
         cq/Y2z8AlCWBHGw2AH8XUrBlFEQa3WzSewLjq9MSPjoVLvk+kw1eYDA7E9916ItO8Pas
         IyIg==
X-Gm-Message-State: AFqh2kpawrnMbYdY4SDvf8/Jh8Trg2j194d+vSeSh77BDJ96hETBZTgx
        9vfvZz9pX0sXoH7cby/Tcn4=
X-Google-Smtp-Source: AMrXdXtfY2MaSYxOP+b4pzEgCXz7mg9mYA+y/WFE2lqeXJ02PkIjNYmyuV1xJD3tJFVQbfcHhmUrjg==
X-Received: by 2002:adf:f5c6:0:b0:29f:ebd1:6a5 with SMTP id k6-20020adff5c6000000b0029febd106a5mr680513wrp.14.1672734480105;
        Tue, 03 Jan 2023 00:28:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id i18-20020adff312000000b0024274a5db0asm31060338wro.2.2023.01.03.00.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 00:27:59 -0800 (PST)
Date:   Tue, 3 Jan 2023 11:27:56 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Joshua Goins <josh@redstrate.com>
Cc:     linux-input@vger.kernel.org, jose.exposito89@gmail.com,
        kernel test robot <lkp@intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Artist 22R Pro
Message-ID: <Y7PnDMx1ztWgfA8W@kadam>
References: <2068502.VLH7GnMWUR@adrastea>
 <20230102194911.56083-1-josh@redstrate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102194911.56083-1-josh@redstrate.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 02:49:10PM -0500, Joshua Goins wrote:
> @@ -91,9 +115,27 @@ static int uclogic_input_mapping(struct hid_device *hdev,
>  	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
>  	struct uclogic_params *params = &drvdata->params;
>  
> -	/* Discard invalid pen usages */
> -	if (params->pen.usage_invalid && (field->application == HID_DG_PEN))
> -		return -1;
> +	if (field->application == HID_GD_KEYPAD) {
> +		/*
> +		 * Remap input buttons to sensible ones that are not invalid.
> +		 * This only affects previous behavior for devices with more than ten or so buttons.
> +		 */
> +		const int key = (usage->hid & HID_USAGE) - 1;
> +
> +		if (key > 0 && key < ARRAY_SIZE(uclogic_extra_input_mapping)) {

It's an unusual that zero is not valid but I don't know the code at all.

> +			hid_map_usage(hi,
> +				      usage,
> +				      bit,
> +				      max,
> +				      EV_KEY,
> +				      uclogic_extra_input_mapping[key]);
> +			return 1;
> +		}
> +	} else if (field->application == HID_DG_PEN) {
> +		/* Discard invalid pen usages */
> +		if (params->pen.usage_invalid)
> +			return -1;
> +	}
>  
>  	/* Let hid-core decide what to do */
>  	return 0;

[ snip ]

> +/*
> + * uclogic_params_init_ugee_xppen_pro() - Initializes a UGEE XP-Pen Pro tablet device.
> + *
> + * @hdev:	The HID device of the tablet interface to initialize and get
> + *		parameters from. Cannot be NULL.
> + * @params:	Parameters to fill in (to be cleaned with
> + *		uclogic_params_cleanup()). Not modified in case of error.
> + *		Cannot be NULL.
> + *
> + * Returns:
> + *	Zero, if successful. A negative errno code on error.
> + */
> +static int uclogic_params_init_ugee_xppen_pro(struct uclogic_params *params,
> +					      struct hid_device *hdev,
> +					      const u8 rdesc_frame_arr[],
> +					      const size_t rdesc_frame_size)
> +{
> +	int rc = 0;
> +	struct usb_interface *iface;
> +	__u8 bInterfaceNumber;
> +	const int str_desc_len = 12;
> +	u8 *str_desc = NULL;
> +	__u8 *rdesc_pen = NULL;
> +	s32 desc_params[UCLOGIC_RDESC_PH_ID_NUM];
> +	/* The resulting parameters (noop) */
> +	struct uclogic_params p = {0, };
> +
> +	if (!hdev || !params) {
> +		rc = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	iface = to_usb_interface(hdev->dev.parent);
> +	bInterfaceNumber = iface->cur_altsetting->desc.bInterfaceNumber;
> +
> +	/* Ignore non-pen interfaces */
> +	if (bInterfaceNumber != 2) {
> +		uclogic_params_init_invalid(&p);
> +		goto output;

So this is a success path?  "ret = 0?"  The comments kind of suggest
that but I want to be sure.

> +	}
> +
> +	/*
> +	 * Initialize the interface by sending magic data.
> +	 * This magic data is the same as other UGEE v2 tablets.
> +	 */
> +	rc = uclogic_probe_interface(hdev,
> +				     uclogic_ugee_v2_probe_arr,
> +				     uclogic_ugee_v2_probe_size,
> +				     0x03);
> +	if (rc) {
> +		uclogic_params_init_invalid(&p);
> +		goto output;
> +	}
> +
> +	/**
> +	 * Read the string descriptor containing pen and frame parameters.
> +	 * These are slightly different than typical UGEE v2 devices.
> +	 */
> +	rc = uclogic_params_get_str_desc(&str_desc, hdev, 100, str_desc_len);
> +	if (rc != str_desc_len) {
> +		hid_err(hdev, "failed retrieving pen and frame parameters: %d\n", rc);
> +		uclogic_params_init_invalid(&p);
> +		goto output;

This isn't correct.  You need to do something like:

		rc = (rc < 0) ? rc : -EINVAL;

regards,
dan carpenter

> +	}
> +
> +	rc = uclogic_params_parse_ugee_xppen_pro_desc(str_desc, str_desc_len,
> +						      desc_params,
> +						      ARRAY_SIZE(desc_params));
> +	if (rc)
> +		goto cleanup;
> +
> +	kfree(str_desc);
> +	str_desc = NULL;
> +
> +	/* Initialize the pen interface */
> +	rdesc_pen = uclogic_rdesc_template_apply(
> +				uclogic_rdesc_ugee_v2_pen_template_arr,
> +				uclogic_rdesc_ugee_v2_pen_template_size,
> +				desc_params, ARRAY_SIZE(desc_params));
> +	if (!rdesc_pen) {
> +		rc = -ENOMEM;
> +		goto cleanup;
> +	}
> +
> +	p.pen.desc_ptr = rdesc_pen;
> +	p.pen.desc_size = uclogic_rdesc_ugee_v2_pen_template_size;
> +	p.pen.id = 0x02;
> +	p.pen.subreport_list[0].value = 0xf0;
> +	p.pen.subreport_list[0].id = UCLOGIC_RDESC_V1_FRAME_ID;
> +
> +	/* Initialize the frame interface */
> +	rc = uclogic_params_frame_init_with_desc(
> +		&p.frame_list[0],
> +		rdesc_frame_arr,
> +		rdesc_frame_size,
> +		UCLOGIC_RDESC_V1_FRAME_ID);
> +	if (rc < 0) {
> +		hid_err(hdev, "initializing frame params failed: %d\n", rc);
> +		goto output;
> +	}
> +
> +	p.frame_list[0].bitmap_dial_byte = 7;
> +	p.frame_list[0].bitmap_second_dial_destination_byte = 8;
> +
> +output:
> +	/* Output parameters */
> +	memcpy(params, &p, sizeof(*params));
> +	memset(&p, 0, sizeof(p));
> +	rc = 0;
> +cleanup:
> +	kfree(str_desc);
> +	uclogic_params_cleanup(&p);
> +	return rc;
> +}



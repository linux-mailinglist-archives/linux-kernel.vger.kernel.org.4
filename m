Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7F10677A85
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 13:05:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231650AbjAWMFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 07:05:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbjAWMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 07:05:05 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C61227BE;
        Mon, 23 Jan 2023 04:05:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d4-20020a05600c3ac400b003db1de2aef0so8379432wms.2;
        Mon, 23 Jan 2023 04:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AMBmfoYya5PgXn4YZDfYUMtggySAK/HwKMtRK6plYP8=;
        b=aCU33KhsnXFUu/IDemepIQPPaq2LWevf+0j8EsEsDOKcPezA+2LRMTWVj6e7OhCTof
         74UbpHP/JGepMFB624HIud3lHqIYZ7ZTbcZ2rbBSRWQnegNZO8yeHwuSr99YMeyeHVJr
         EyObPon+WO0wm2A7JXtjbdr7TZnPYK9oO3MARvQzG8g4982t7Vwt+KYNKduRnoCFfrng
         RKugvQXK2NgH85j1FR1B8+7gDZYIKLI5mw25/eIwiaMR37J4PjB06vKn7+MNVR+Sr1BM
         P3Gdj+KFebm4nRw40LsUcpmUdktHz/xwmbTxbAaTpmgB+Mg01XaT7FpXBTWfQAw74EzU
         N/Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMBmfoYya5PgXn4YZDfYUMtggySAK/HwKMtRK6plYP8=;
        b=QyTjeA0Fz/MzkQkejzWa3RvbGB5SLFI3nAky5byPYH6u09zFnfT2cVtw5GXDtmly33
         pAi7r2B/t67YBhM6zvLJ7xKAH7UYQhbTNNEK5T2t+4d7jr1xCmGi9p/Ynn71j5ixkzao
         DbpH4G9aSy1aaWxx/K9Cybz4jvmz+rgY+Rz7FULA48JKIpHRxe70MPOBwuiTdcJovR2L
         JdQi7fHf5UgOovqLnl/FHUPbepPOBQITKd+lKu+TLokHGWIG6FgN6QkJ369QSk82/iOh
         bXcjCkmM4ssxDWRm131VGrBQrHIGFHd8/0aZjZllO6ZcY+GVDJ/oNLdnQp7RBijyEjN0
         rN9g==
X-Gm-Message-State: AFqh2kqO5t50z46eYdvm7W2dir4q9s0XVCWOBUU0cZbYwLZb88IP902W
        WFIS9LYvVPXP9TbFUWH2YuQ=
X-Google-Smtp-Source: AMrXdXtxDoap+d7zX3hP2ldTumD2iqOsEVcDveuuO4JcRCXk81Ogw0HNRqLo4TXJHw9H9gLnIDeBwg==
X-Received: by 2002:a05:600c:4e4b:b0:3db:2e6d:9f79 with SMTP id e11-20020a05600c4e4b00b003db2e6d9f79mr12360642wmq.39.1674475500256;
        Mon, 23 Jan 2023 04:05:00 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o21-20020a05600c4fd500b003c6f8d30e40sm11642757wmq.31.2023.01.23.04.04.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 04:04:59 -0800 (PST)
Date:   Mon, 23 Jan 2023 15:04:56 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Christian Hewitt <christianshewitt@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        linux-media@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-staging@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: Re: [PATCH] media: meson: vdec: esparser: check parsing state with
 hardware write pointer
Message-ID: <Y8536BzbbghJt0G2@kadam>
References: <20230123094300.2816812-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123094300.2816812-1-christianshewitt@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 09:43:00AM +0000, Christian Hewitt wrote:
> From: Neil Armstrong <narmstrong@baylibre.com>
> 
> Also check the hardware write pointer to check if ES Parser has stalled.
> 

Presumably this is something which has happens in real life?  Say a user
has this hardware and is wondering if this patch fixes their bug, what
does this bug look like to them?

Please add a Fixes tag.

> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
> ---
>  drivers/staging/media/meson/vdec/esparser.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/media/meson/vdec/esparser.c b/drivers/staging/media/meson/vdec/esparser.c
> index df5956c6141d..41b705f999b2 100644
> --- a/drivers/staging/media/meson/vdec/esparser.c
> +++ b/drivers/staging/media/meson/vdec/esparser.c
> @@ -300,6 +300,7 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>  	u32 num_dst_bufs = 0;
>  	u32 offset;
>  	u32 pad_size;
> +	u32 wp, wp2;
>  
>  	/*
>  	 * When max ref frame is held by VP9, this should be -= 3 to prevent a
> @@ -354,15 +355,21 @@ esparser_queue(struct amvdec_session *sess, struct vb2_v4l2_buffer *vbuf)
>  	}
>  
>  	pad_size = esparser_pad_start_code(core, vb, payload_size);
> +	wp = amvdec_read_parser(core, PARSER_VIDEO_WP);
>  	ret = esparser_write_data(core, phy, payload_size + pad_size);
> +	wp2 = amvdec_read_parser(core, PARSER_VIDEO_WP);
>  

Why is check not done inside the esparser_write_data() function?  It
really feels like doing a write where nothing happens should be a bug
for both callers...

The esparser_write_data() function returns > 0 on success, 0 on timeout
(I guess timeout is an error-ish) and negative if the user presses
CTR-C.  There are no comments to explain the unusual returns.  Could we
clean this up so it just returns negatives on error and zero on success
or if not then let's add a comment explaining what's going on?

>  	if (ret <= 0) {
> -		dev_warn(core->dev, "esparser: input parsing error\n");
> -		amvdec_remove_ts(sess, vb->timestamp);
> -		v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
>  		amvdec_write_parser(core, PARSER_FETCH_CMD, 0);
>  
> -		return 0;
> +		if (ret < 0 || wp2 == wp) {

So in this patch if there is a timeout but something was written then
that's kind of a success path?

regards,
dan carpenter

> +			dev_err(core->dev, "esparser: input parsing error ret %d (%x <=> %x)\n",
> +				ret, wp, wp2);
> +			amvdec_remove_ts(sess, vb->timestamp);
> +			v4l2_m2m_buf_done(vbuf, VB2_BUF_STATE_ERROR);
> +
> +			return 0;
> +		}
>  	}
>  
>  	atomic_inc(&sess->esparser_queued_bufs);


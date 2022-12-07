Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5064641D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 23:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiLGWaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 17:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiLGWaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 17:30:14 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A96B81D80
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 14:30:11 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b11so19057241pjp.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CkMKMEemwpbk/daVT3wz6uonUC/mWzDsPO2TugqFnFs=;
        b=fEcjMeBw8OEXjRzvgzIU6KrICKdIxvExhVmyoeFXQdzU+t4exH0ckCw9npkeE8vchO
         cWM34qCRH+j2gYVEZZhe8MkEJWPHYVlkL2ovKCcWWRLA2saIx91gryj1eOKdE4pTqRj0
         m+koQ/QOo28CKI8O2NOPg+zpR5tTJ6aWOy8LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CkMKMEemwpbk/daVT3wz6uonUC/mWzDsPO2TugqFnFs=;
        b=lU42+dc443Ts/vxjQ5AVwz8OY3EBh0CydW4wK69jt0n4xTQKQFq0xm7XT7B7LqbL4I
         ftHc5mLdIvHEIa1Q1mWyqgyLPjeM9+ttVmswf4Djn17OzxSodCY6EMtBws5fWOE3dC3d
         9d2vgLi/n1skw94sE1RD3BX70xDczh0oQdiuZOqaYK6/+Rg+jlRXD//ZMY8gva48Xj6L
         SnjIKPr31Rzt39Yx80MTaMTV9QZtwx4mPWcIH2JShbllsrFt1+NZzHoNWmwa4qKjZT1y
         RGVRaYPk2lgPJo0TWIn8bGTHWCAVZsywA86clieB+haiQe+cDo+a33yXvk8lLSlOMTSB
         8LGg==
X-Gm-Message-State: ANoB5pmWHxPvBn1sPYEAGe4H2gAsS39zLcWoQfOtVUvR478kZTwZGOxZ
        HUQdhJWpm6s7JhQbJ20dpo1xOA==
X-Google-Smtp-Source: AA0mqf6lIaq8B+RTyASAyN0TyOhkL3/MjzEkzcCUWjTPGU4+tm81VDg9C5AhrhmBVDx+w//M7VtPJg==
X-Received: by 2002:a17:90b:4c81:b0:213:f498:ebaf with SMTP id my1-20020a17090b4c8100b00213f498ebafmr1134142pjb.5.1670452210704;
        Wed, 07 Dec 2022 14:30:10 -0800 (PST)
Received: from chromium.org (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id nb14-20020a17090b35ce00b00219186abd7csm1659069pjb.16.2022.12.07.14.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 14:30:10 -0800 (PST)
Date:   Wed, 7 Dec 2022 22:30:09 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v10 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
Message-ID: <Y5ET8a3WBntlOfU5@chromium.org>
References: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207104005.v10.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark & Bhanu,

Mostly style nits; once addressed, please add my reviewed tag (FWIW):

Reviewed-by: Prashant Malani <pmalani@chromium.org>

On Dec 07 10:40, Mark Hasemeyer wrote:
> +
> +/**
> + * struct response_info - Encapsulate EC response related
> + *			information for passing between function
> + *			cros_ec_uart_pkt_xfer() and cros_ec_uart_rx_bytes()
> + *			callback.
> + * @data:		Copy the data received from EC here.
> + * @max_size:		Max size allocated for the @data buffer. If the
> + *			received data exceeds this value, we log an error.
> + * @size:		Actual size of data received from EC. This is also
> + *			used to accumulate byte count with response is received
> + *			in dma chunks.
> + * @exp_len:		Expected bytes of response from EC including header.
> + * @status:		Re-init to 0 before sending a cmd. Updated to 1 when
> + *			a response is successfully received, or a negative
> + *			integer on failure.
nit: You mean error number specifically, right? Otherwise it can just be
any negative integer, and the caller shouldn't bother checking anything other than " < 0".
> +
> +	memcpy(ec_uart->response.data + ec_uart->response.size, data, count);
> +
> +	ec_uart->response.size += count;
> +
> +	/*
> +	 * Read data_len if we received response header and if exp_len
> +	 * was not read before.
> +	 */
nit: Comment can fit on 1 line.

> +	if (ec_uart->response.size >= sizeof(*response) &&
> +	    ec_uart->response.exp_len == 0) {
> +		response = (struct ec_host_response *) ec_uart->response.data;
> +		ec_uart->response.exp_len = response->data_len + sizeof(*response);
> +	}
> +
> +	/*
> +	 * If driver received response header and payload from EC,
> +	 * Wake up the wait queue.
> +	 */
nit: Comment can fit on 1 line.

> +	/* Setup for incoming response */
> +	ec_uart->response.data = ec_dev->din;
> +	ec_uart->response.max_size = ec_dev->din_size;
> +	ec_uart->response.size = 0;
> +	ec_uart->response.exp_len = 0;
> +	ec_uart->response.status = 0;
> +
> +	ret = serdev_device_write_buf(serdev, ec_dev->dout, len);
> +	if (ret < len) {
> +		dev_err(ec_dev->dev, "Unable to write data");
nit: Please end with a "\n".
> +		ret = -EIO;
> +		goto exit;
> +	}
> +
> +	ret = wait_event_timeout(ec_uart->response.wait_queue,
> +				 ec_uart->response.status,
> +				 msecs_to_jiffies(EC_MSG_DEADLINE_MS));
> +	if (ret == 0) {
> +		dev_warn(ec_dev->dev, "Timed out waiting for response.\n");
> +		ret = -ETIMEDOUT;
> +		goto exit;
> +	}
> +
> +	if (ec_uart->response.status < 0) {
> +		dev_warn(ec_dev->dev, "Error response received: %d\n", ec_uart->response.status);
> +		ret = ec_uart->response.status;
> +		goto exit;
> +	}
> +
> +	response = (struct ec_host_response *)ec_dev->din;
> +	ec_msg->result = response->result;
> +
> +	if (response->data_len > ec_msg->insize) {
> +		dev_err(ec_dev->dev, "Resp too long (%d bytes, expected %d)", response->data_len,
nit: Please end with a "\n".

Best regards,

-Prashant

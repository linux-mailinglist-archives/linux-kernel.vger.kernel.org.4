Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90322610C13
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiJ1IRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJ1IRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:17:01 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3911C3E49;
        Fri, 28 Oct 2022 01:17:00 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l14-20020a05600c1d0e00b003c6ecc94285so5035960wms.1;
        Fri, 28 Oct 2022 01:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Ra/HUJ8vx8RFMX0smLDpTJL+boeXauNs2LJHWrZfRM=;
        b=K99f9p545uaTlS0j+QGsa1PESE9IVrNIYfBwH+JMskTB6I10pTxLuj2bC9q5joezyL
         XOk4SKHilTI6J6i+7Qjw3PkfGRfuYVf7SfNnfuNmVhpICoqPDvwzMWMMYLuQqdfEQsX6
         hPvyqHhDWBoWcTr+fh2WaXscJh6FwnmQZNBqbNMFbN8/bGGTUa0DMVRmSS5fqr5f4cTS
         QuPiN4ehZVUbcMe3+5b2FyJ6hG1zB1q1oJR+lw+jcY8OT3dFVPonzhtx5AlCspiDh5Sv
         0jH8nIJUkwwtn8GZicI2dF1bA++HlwEqjIqbYsbCEtBjnka8lO8u533JYIVZJ9f01hYS
         YHYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ra/HUJ8vx8RFMX0smLDpTJL+boeXauNs2LJHWrZfRM=;
        b=QmsJtDTHARC59mLlGMStDpn+qbx+Ow7Sut0iblv8nnegcKa5E+Wp49kkFwPYBgdfn5
         4ODLaat7cvRXF4tcSDLIXPG+AJRff1D18AtmEorsFEQAEHN/SMENgPhMQh27CFSwHKvE
         9O2vJYHitAZofbmf8I2VqBYAg1HCnWMff4g2jWc4seMSvQlx0S13dW4JeMNyibHgVdLI
         N9M0z5Key7me5vmg1CY53UrZrgC+6WQycj0JRSBhYcGRkHgprgfIuxVJkwr3Fpk9h8ix
         sqEoVVTqmQiRUg35iCwNuR2VUe3nlVgQ03K44Ii2uXnJaXoRldeH1IxCtatL4sjIqUzs
         28+w==
X-Gm-Message-State: ACrzQf1nJPpJlK8qRTzqRKcu7oFckI6+by2uHxDuVMZdtrI34vjr7VEj
        fpt6MLHompqWEsfx7+XhhdU=
X-Google-Smtp-Source: AMsMyM7v7psh9pUGqkAj5dB5OJPUVt+CU/Kat2cBo3h5wTtr9NL6N2Y1hnQ7ysynN+cMJQveQgD+LQ==
X-Received: by 2002:a05:600c:689b:b0:3c2:fd6e:1fe5 with SMTP id fn27-20020a05600c689b00b003c2fd6e1fe5mr8439785wmb.99.1666945018825;
        Fri, 28 Oct 2022 01:16:58 -0700 (PDT)
Received: from elementary ([94.73.35.109])
        by smtp.gmail.com with ESMTPSA id m18-20020adfe952000000b002368f6b56desm3764019wrn.18.2022.10.28.01.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 01:16:58 -0700 (PDT)
Date:   Fri, 28 Oct 2022 10:16:56 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     =?utf-8?Q?Barnab=C3=A1s_P=C5=91cze?= <pobrn@protonmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mia Kanashi <chad@redpilled.dev>,
        Andreas Grosse <andig.mail@t-online.de>
Subject: Re: [PATCH] HID: uclogic: Add support for XP-PEN Deco LW
Message-ID: <20221028081656.GA19766@elementary>
References: <20221027211021.230325-1-jose.exposito89@gmail.com>
 <2m7M7XFEGHGOu6Le-GK_9kDuuA3BltmE1I17zDsok382TFmgO2oDamLv7cWcXjYLdzdgwQli7Qe98xoe0tuVc4bg7sRbFG2LFZ6iYn0s3Fk=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2m7M7XFEGHGOu6Le-GK_9kDuuA3BltmE1I17zDsok382TFmgO2oDamLv7cWcXjYLdzdgwQli7Qe98xoe0tuVc4bg7sRbFG2LFZ6iYn0s3Fk=@protonmail.com>
X-Spam-Status: No, score=1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barnabás,

Thanks for reviewing the patch.

On Thu, Oct 27, 2022 at 09:32:24PM +0000, Barnabás Pőcze wrote:
> Hi
> 
> 
> 2022. október 27., csütörtök 23:10 keltezéssel, José Expósito írta:
> 
> > [...]
> > +/**
> > + * uclogic_params_ugee_v2_has_battery() - check whether a UGEE v2 device has
> > + * battery or not.
> > + * @hdev:	The HID device of the tablet interface.
> > + *
> > + * Returns:
> > + *	True if the device has battery, false otherwise.
> > + */
> > +static bool uclogic_params_ugee_v2_has_battery(struct hid_device *hdev)
> > +{
> > +	/* The XP-PEN Deco LW vendor, product and version are identical to the
> > +	 * Deco L. The only difference reported by their firmware is the product
> > +	 * name. Add a quirk to support battery reporting on the wireless
> > +	 * version.
> > +	 */
> > +	if (hdev->vendor == USB_VENDOR_ID_UGEE &&
> > +	    hdev->product == USB_DEVICE_ID_UGEE_XPPEN_TABLET_DECO_L) {
> > +		struct usb_device *udev = hid_to_usb_dev(hdev);
> > +		const char *lw_name = "Deco LW";
> > +
> > +		if (strncmp(udev->product, lw_name, strlen(lw_name)) == 0)
> 
> Please use `strstarts()` here instead.

Good point, I'll send v2 in a minute with this change.

Jose
 
> 
> > +			return true;
> > +	}
> > +
> > +	return false;
> > +}
> > [...]
> 
> 
> Regards,
> Barnabás Pőcze

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A329974B8AF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 23:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGGVfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 17:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjGGVfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 17:35:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1721D1FD9
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 14:35:11 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992f15c36fcso305545666b.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jul 2023 14:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688765709; x=1691357709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EreKLP61fJFEZifwXUgdWDfgup62n62CRKHFNhat6Mg=;
        b=e+fylLZ8AKeITK916W6p8mq1bmTwXBJYnAptPo3i6gOOrFhG/JqgrfWJFmcXfehF3T
         cgfCtRxiH5untqQDl4tcHKc62ERZyC0rEYmN/5XropK6wEkQ+vC61jIsHfcDXuZEauoy
         umbbJ9lsOdhLYlI73Kxq5mAGy514otKg9t5XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688765709; x=1691357709;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EreKLP61fJFEZifwXUgdWDfgup62n62CRKHFNhat6Mg=;
        b=giD9lGAhMNhkeArUAZkn6N/+aWlYmuA87T+0dzMlFkpByQWgtszxsiYQ9JkPB7S3C2
         fdUuaXBAvBYjTmtYfQWt393BvAqoa4OCyiv0Saeoxa14ODcIeEf9Xc7VJkXg5JuWQ9Ft
         DiUvyDGq5g9C/otoNkGnXaFxO6Sat+Bi3nLwNpOSAv/fafqC+p8LulllR/yJYIvfOhSS
         3I9EmFLbUGzdkuSpTl6druG+BZ1bUs1wSJGFfox1OcZVkniV6BQ9wqdP37393dih7Xyb
         qlBLAwRdheh30lAGcjbswnzqUczjwg6yW/FPvLtMbFvOfj4IGvPhAF7dLVpd9iOyHERd
         zM/w==
X-Gm-Message-State: ABy/qLbz0TjsXSMhhH0MwIk6KFm8bfdGKWdkjUor8qqsqsHTxM49Ma9+
        4LKhgvODiWjwoV7XgtzhHPPWGw==
X-Google-Smtp-Source: APBJJlF2514EjcgkLq4ojDadFsNSQboIYDjQfkCJeC1TaSLwGWfPChIEGA1mM5mMw/p77wQ0wNByjA==
X-Received: by 2002:a17:907:58d:b0:991:e815:a1ef with SMTP id vw13-20020a170907058d00b00991e815a1efmr4157392ejb.31.1688765709396;
        Fri, 07 Jul 2023 14:35:09 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id o13-20020a170906358d00b0098d15d170a0sm2605738ejb.202.2023.07.07.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 14:35:09 -0700 (PDT)
Date:   Fri, 7 Jul 2023 21:35:07 +0000
From:   Fabio Baltieri <fabiobaltieri@chromium.org>
To:     Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 RESEND] HID: hid-google-stadiaff: add support for
 Stadia force feedback
Message-ID: <ZKiFC1Llz8VFxrDR@google.com>
References: <20230707104035.1697204-1-fabiobaltieri@chromium.org>
 <87fs5zboej.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fs5zboej.fsf@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rahul,

On Fri, Jul 07, 2023 at 10:51:48AM -0700, Rahul Rameshbabu wrote:
> On Fri, 07 Jul, 2023 10:40:35 +0000 Fabio Baltieri <fabiobaltieri@chromium.org> wrote:
> > Add a hid-stadiaff module to support rumble based force feedback on the
> > Google Stadia controller. This works using the HID output endpoint
> > exposed on both the USB and BLE interface.
> >
> > Signed-off-by: Fabio Baltieri <fabiobaltieri@chromium.org>
> > ---
> > +static int stadiaff_init(struct hid_device *hid)
> > +{
> > +	struct stadiaff_device *stadiaff;
> > +	struct hid_report *report;
> > +	struct hid_input *hidinput;
> > +	struct input_dev *dev;
> > +	int error;
> > +
> > +	if (list_empty(&hid->inputs)) {
> > +		hid_err(hid, "no inputs found\n");
> > +		return -ENODEV;
> > +	}
> > +	hidinput = list_entry(hid->inputs.next, struct hid_input, list);
> > +	dev = hidinput->input;
> > +
> > +	report = hid_validate_values(hid, HID_OUTPUT_REPORT,
> > +				     STADIA_FF_REPORT_ID, 0, 2);
> > +	if (!report)
> > +		return -ENODEV;
> > +
> > +	stadiaff = devm_kzalloc(&hid->dev, sizeof(struct stadiaff_device),
> > +				GFP_KERNEL);
> > +	if (!stadiaff)
> > +		return -ENOMEM;
> 
> If we fail to allocate stadiaff, we abort init without ever initializing
> the spinlock and work struct.
> 
> > +
> > +	hid_set_drvdata(hid, stadiaff);
> > +
> > +	input_set_capability(dev, EV_FF, FF_RUMBLE);
> > +
> > +	error = input_ff_create_memless(dev, NULL, stadiaff_play);
> > +	if (error)
> > +		return error;
> 
> Lets say input_ff_create_memless fails. The spinlock and work struct are
> not properly initialized.
> 
> > +
> > +	stadiaff->removed = false;
> > +	stadiaff->hid = hid;
> > +	stadiaff->report = report;
> > +	INIT_WORK(&stadiaff->work, stadiaff_work);
> > +	spin_lock_init(&stadiaff->lock);
> > +
> > +	hid_info(hid, "Force Feedback for Google Stadia controller\n");
> > +
> > +	return 0;
> > +}
> > +
> > +static int stadia_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > +{
> > +	int ret;
> > +
> > +	ret = hid_parse(hdev);
> > +	if (ret) {
> > +		hid_err(hdev, "parse failed\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = hid_hw_start(hdev, HID_CONNECT_DEFAULT & ~HID_CONNECT_FF);
> > +	if (ret) {
> > +		hid_err(hdev, "hw start failed\n");
> > +		return ret;
> > +	}
> > +
> > +	stadiaff_init(hdev);
> 
> Is the intention for not error handling stadiaff_init to be able to use
> the HID device even if haptics are not enabled? I think that's fine but
> there are some design considerations that need to be made in order for
> this code to be safe in the context of stadia_remove.

Sorry, no, the intention was to catch the error here and fail the probe,
that's the pattern on other hid haptic drivers as well, would not really
want to get too creative about it here. I shuffled the code around a bit
and somehow missed this check, I think it addresses all the potential
unallocated dereferecing you pointed out.

I'll send a v3 with the check, thanks for spotting this.

> 
> > +
> > +	return 0;
> > +}
> > +
> > +static void stadia_remove(struct hid_device *hid)
> > +{
> > +	struct stadiaff_device *stadiaff = hid_get_drvdata(hid);
> 
> stadiaff is unsafe to use if we failed to allocate memory for it and do
> not set the hid device driver data. We would be dereferencing a
> driver_data pointer never set/initialized by this driver in this error
> path in stadiaff_init.
> 
> > +	unsigned long flags;
> > +
> > +	spin_lock_irqsave(&stadiaff->lock, flags);
> > +	stadiaff->removed = true;
> > +	spin_unlock_irqrestore(&stadiaff->lock, flags);
> 
> Attempting to lock/unlock a spinlock that may not have been initialized
> if an error occurred in the stadiaff_init path.
> 
> > +
> > +	cancel_work_sync(&stadiaff->work);
> 
> Attempting to cancel work on a work_struct that may not be properly
> initialized if an error occurred in stadiaff_init.
> 
> > +	hid_hw_stop(hid);
> > +}
> 
> Thanks,
> 
> -- Rahul Rameshbabu

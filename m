Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93FE692B81
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjBJXl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjBJXlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:41:25 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F302884517;
        Fri, 10 Feb 2023 15:40:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so5723507pjk.3;
        Fri, 10 Feb 2023 15:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9KMeQbkxBbzvMD3Sl9ck9O0fqetDFlWitYcAkilER14=;
        b=j3g6xSgVBMl0RZce22/nXAuvomW+22He2oG4WlKF/IoWovVhjhoh6RVxB/uq5zvv1S
         NPll0tfzJQ8pKVI65peoO8wkgDNUOeTm6AeD3bPG34tiFpzuezzkO12kXYPrx/Lp6bpH
         eGgIuvlrTGePFLSrn6VSg/tVhHF8iMC1RqdI4MpZK51kTQaEeBuG7Zf1RyYGUI3/tOtE
         Oqzz86pqPUd5qPVL+c3xyibkH6mku6T07VH6ftJMGs8sZyabRd1vswbr6v/YNg97EnmA
         guqxfIWivO0wuZX+VsIsU+NxsIr3wFBkgOVtYW2dCTI+1K+cexblV9WhhXg3MQ5vj2an
         9CKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9KMeQbkxBbzvMD3Sl9ck9O0fqetDFlWitYcAkilER14=;
        b=bjdcDfffUBG23p/IhfuXJmtmgWX534entqn+kP5PGwlVOELygAK06jW1LRPCx4Gu0A
         sBgyL2Ua0qRSQVq8eOJo+n0MqguMLINlpU36UnBkcde36CxIjx+zkukIN3dYtU4AM42r
         skWN8ccYf/FC8HGnWDPZrA6Q9vuFhp5uXQo1R/nwIlEjFPM3cwYq3EYVXmSLKlFCnXfp
         iaMcsL2o18uEoajcyqZuKbQvHfl5hLCAyyedz7GVemdSUa+R0A5f0c4DDvrjpchqfIOY
         dNKW/mNNNb7F/i2LiL1BkMJPlrGAQJEEohXTq4l/kNAPadhsl5R6uVQTkAxMb2e0W3Ls
         fbxw==
X-Gm-Message-State: AO0yUKWlN/GqJD1GohWKWz82mC3G3LXQnZtg6QInCSIOKqELw8G1ZfgY
        v+YhfbySrL5u4FzSJu8PwFk=
X-Google-Smtp-Source: AK7set+XBtj9eG/9r0dI6pCHyKxazkKCt2l/VJcnsuyMP5CelIxVLs3Lz67wacQ3226zSyl2840Xzw==
X-Received: by 2002:a17:90b:4d8a:b0:22c:4bc:2126 with SMTP id oj10-20020a17090b4d8a00b0022c04bc2126mr17815825pjb.45.1676072450148;
        Fri, 10 Feb 2023 15:40:50 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a4c8600b002339195a47bsm2070583pjh.53.2023.02.10.15.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:40:49 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:40:34 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [RFC PATCH 5/9] apple-gmux: Use GMSP acpi method for interrupt
 clear
Message-ID: <20230211104034.53e6f8ac@redecorated-mbp>
In-Reply-To: <ee952253-9ee4-aa81-fefa-609cbf6e1e2b@redhat.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
        <20230210044826.9834-6-orlandoch.dev@gmail.com>
        <ee952253-9ee4-aa81-fefa-609cbf6e1e2b@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 20:43:58 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/10/23 05:48, Orlando Chamberlain wrote:
> > This is needed for interrupts to be cleared correctly on MMIO based
> > gmux's. It is untested if this helps/hinders other gmux types, but I
> > have seen the GMSP method in the acpi tables of a MacBook with an
> > indexed gmux.
> > 
> > If this turns out to break support for older gmux's, this can
> > instead be only done on MMIO gmux's.
> > 
> > There is also a "GMLV" acpi method, and the "GMSP" method can be
> > called with 1 as its argument, but the purposes of these aren't
> > known and they don't seem to be needed.
> > 
> > Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> > ---
> >  drivers/platform/x86/apple-gmux.c | 26 +++++++++++++++++++++++++-
> >  1 file changed, 25 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/platform/x86/apple-gmux.c
> > b/drivers/platform/x86/apple-gmux.c index
> > 760434a527c1..c605f036ea0b 100644 ---
> > a/drivers/platform/x86/apple-gmux.c +++
> > b/drivers/platform/x86/apple-gmux.c @@ -494,8 +494,29 @@ static
> > const struct apple_gmux_config apple_gmux_index = {
> >   * MCP79, on all following generations it's GPIO pin 6 of the
> > Intel PCH.
> >   * The GPE merely signals that an interrupt occurred, the actual
> > type of event
> >   * is identified by reading a gmux register.
> > + *
> > + * On MMIO gmux's, we also need to call the acpi method GMSP to
> > properly clear
> > + * interrupts. TODO: Do other types need this? Does this break
> > other types? */
> >  
> > +static int gmux_call_acpi_gmsp(struct apple_gmux_data *gmux_data,
> > int arg) +{
> > +	acpi_status status = AE_OK;
> > +	union acpi_object arg0 = { ACPI_TYPE_INTEGER };
> > +	struct acpi_object_list arg_list = { 1, &arg0 };
> > +
> > +	arg0.integer.value = arg;
> > +
> > +	status = acpi_evaluate_object(gmux_data->dhandle, "GMSP",
> > &arg_list, NULL);
> > +	if (ACPI_FAILURE(status)) {
> > +		pr_err("GMSP call failed: %s\n",
> > +		       acpi_format_exception(status));
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static inline void gmux_disable_interrupts(struct apple_gmux_data
> > *gmux_data) {
> >  	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_ENABLE,
> > @@ -519,7 +540,10 @@ static void gmux_clear_interrupts(struct
> > apple_gmux_data *gmux_data) 
> >  	/* to clear interrupts write back current status */
> >  	status = gmux_interrupt_get_status(gmux_data);
> > -	gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS, status);
> > +	if (status) {
> > +		gmux_write8(gmux_data, GMUX_PORT_INTERRUPT_STATUS,
> > status);
> > +		gmux_call_acpi_gmsp(gmux_data, 0);  
> 
> Ugh no, please don't go around calling random ACPI methods from
> untested firmware revisions / device models.
> 
> ACPI code (even Apple's I have learned) tends to be full of bugs. If
> we did not need to call GMSP before then please lets keep not calling
> it on the older models. Just because it is there does not mean that
> calling it is useful, it might even be harmful.

I'll make it only use this ACPI method on MMIO gmux's in v2 then.

> 
> Regards,
> 
> Hans
> 
> 
> 
> 
> 
> 
> > +	}
> >  }
> >  
> >  static void gmux_notify_handler(acpi_handle device, u32 value,
> > void *context)  
> 


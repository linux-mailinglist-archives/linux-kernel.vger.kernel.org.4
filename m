Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED9D693FE9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 09:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjBMIqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 03:46:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjBMIqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 03:46:14 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D20A5C0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:46:12 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id e19so1208352edz.13
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 00:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIgYnkRqE95yz5AU0J8xpkq6tSZZZ239ZiNg9NKJsOQ=;
        b=edUWzbfhupqK2ITIOdrgOh3txyi1/YLjjJ63x2GD+0nTSY3mmoFh1yeuEIxJfET/nT
         KU4pHK3XPgwLKhVHfdjvgZBHHOnNfWXnyf4Omzo250nvN+wnsNnJlWgki3WFMxjXHKZX
         cslGK8Iohax64kLq36pMovjcVdjxmZVWicTA3WY/wcjTFodFjmt7epA9pYCWVnj3lxsr
         fyzfR/eoxyvoRdvlw2SdqagYD2L9tgVglLN8zLzhZyxThupIMcArR9Ah3pTXy4Hkt2An
         ugjJjgXVFBaKozxDQnF/Ty5urjJa4NGPIJwHXXPOIJjT4MlXdzDttAn//n/0hQCRvXVR
         Kmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aIgYnkRqE95yz5AU0J8xpkq6tSZZZ239ZiNg9NKJsOQ=;
        b=OYDq4+/v4CSnnKmS2PbomeTT1a9EkSySoiBcTd2KPuwKj2vW6tdCcQPyJNCIQ3U1aX
         +NvW4DFQhuGA3aBBl9YQXXn8RHQe9YBm4mdvrPtRHKl3mkibUGZsIGnpWEfzqwENJvIj
         MwhlLKebUPqhm2Td/bQQuS7qVbrlg2jGOmVIaQdLPcjA8F9wt3hsJoefG+74Djs3cV7R
         QpaFNtB4uCAYKkyU09fJQGBwQPFWRJajbje/BM6ElhWEhr+MN3TTgSboBDJHwwiXZoEP
         +r5R8PX2A++7uYkR9f1o2JrvFFVfh/h6VdZ2atzFLNCNHf4Yeqs2wNBXwLzzt5eFKG7g
         vxyA==
X-Gm-Message-State: AO0yUKVzYTc+v30dfa7ODKBnZz03LhxbQE4obIacpXXL2WtTTeIhXY95
        202OopaxEFBuAHz/jfCFUiNErRuJoxnoFGOiS4M=
X-Google-Smtp-Source: AK7set/moXJc7VDWLXdWvatj0NCmR7myiege10enZj6hGFtwtxlFvjaj+UElAuEchNhWUST4Aadqow==
X-Received: by 2002:a50:c048:0:b0:4ac:b5db:f3b3 with SMTP id u8-20020a50c048000000b004acb5dbf3b3mr6981942edd.18.1676277971578;
        Mon, 13 Feb 2023 00:46:11 -0800 (PST)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id l6-20020a50d6c6000000b004ab0e9e396bsm6285931edj.87.2023.02.13.00.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 00:46:11 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 13 Feb 2023 09:46:11 +0100
Message-Id: <CQHAY4Z0W4HZ.18W214TYCYNUK@otso>
Cc:     <tglx@linutronix.de>, <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH 3/3] genirq: Check for trigger type mismatch in
 __setup_irq()
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Luca Weiss" <luca.weiss@fairphone.com>,
        "Marc Zyngier" <maz@kernel.org>,
        "Manivannan Sadhasivam" <manivannan.sadhasivam@linaro.org>
X-Mailer: aerc 0.14.0
References: <20220530080842.37024-1-manivannan.sadhasivam@linaro.org>
 <20220530080842.37024-4-manivannan.sadhasivam@linaro.org>
 <8735gi5g7s.wl-maz@kernel.org> <CO9EJJ4E661K.21S3LVYWH9HMM@otso>
In-Reply-To: <CO9EJJ4E661K.21S3LVYWH9HMM@otso>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Nov 11, 2022 at 11:41 AM CET, Luca Weiss wrote:
> Hi Marc,
>
> On Mon Jun 6, 2022 at 10:49 AM CEST, Marc Zyngier wrote:
> > On Mon, 30 May 2022 09:08:42 +0100,
> > Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org> wrote:
> > >=20
> > > Currently, if the trigger type defined by the platform like DT does n=
ot
> > > match the driver requested trigger type, the below warning is shown
> > > during platform_get_irq() but only during the second time of the driv=
e
> > > probe (due to probe deferral or module unload/load).
> > >=20
> > > irq: type mismatch, failed to map hwirq-9 for interrupt-controller@b2=
20000!
> > >=20
> > > Consider a typical usecase of requesting an IRQ in a driver:
> > >=20
> > > ```
> > > 	/* Assume DT has set the trigger type to IRQF_TYPE_LEVEL_HIGH */
> > >=20
> > > 	q6v5->wdog_irq =3D platform_get_irq_byname(pdev, "wdog");
> > > 	if (q6v5->wdog_irq <=3D 0)
> > > 		return q6v5->wdog_irq;
> > >=20
> > > 	ret =3D devm_request_threaded_irq(&pdev->dev, q6v5->wdog_irq,
> > > 					NULL, q6v5_wdog_interrupt,
> > > 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > > 					"q6v5 wdog", q6v5);
> > > 	if (ret) {
> > > 		dev_err(&pdev->dev, "failed to acquire wdog IRQ\n");
> > > 		return ret;
> > > 	}
> > > ```
> > >=20
> > > For the first time probe of a driver, platform_get_irq_byname() does =
not
> > > return an error and it sets the platform requested trigger type. Then=
,
> > > request_irq() also does not check for the trigger type mismatch and s=
ets
> > > the driver requested trigger type. Later if the driver gets probed ag=
ain,
> > > platform_get_irq() throws the "type mismatch" warning and fails.
> > >=20
> > > Ideally, request_irq() should throw the error during the first time i=
tself,
> > > when it detects the trigger type mismatch. So let's add a check in
> > > __setup_irq() for checking the trigger type mismatch.
> >
> > No, that's wrong. The whole point is to be able to *override* the
> > default that is exposed by the device tree or ACPI. We have countless
> > examples of that, and they cannot be broken.
> >
> > If the issue exists after an unload, then it is a unload time that the
> > previous behaviour should be restored.
>
> So you're saying something like that the drivers where this issue
> appears don't free the irq properly? I've seen a very similar issue now
> on qcom-sm6350 platform with dwc3-qcom and qcom_q6v5_pas drivers.
>
> Temporarily I've adjusted dts to match the IRQ flags requested in the
> driver to avoid these "failed to map hwirq-" errors. I'd be happy to fix
> those drivers (if they should be) but I need some pointers here what
> needs to be done as from my understanding if an irq is requested with
> devm_request_threaded_irq (e.g. dwc3-qcom.c) then it should be freed
> automatically on EPROBE_DEFER because of devm?
>
> All commits in mainline that mention "failed to map hwirq" seem to just
> remove the hardcoded IRQ type from the driver instead.

I'm still interested in a way to fix this since I'm carrying a patch in
my own tree to adjust the dts. Please let me know how to proceed here.

Regards
Luca

>
> Regards
> Luca
>
> >
> > Thanks,
> >
> > 	M.
> >
> > --=20
> > Without deviation from the norm, progress is not possible.


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9C4615CFF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 08:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbiKBHcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 03:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiKBHcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 03:32:03 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A132528F;
        Wed,  2 Nov 2022 00:32:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id CE4F85C0082;
        Wed,  2 Nov 2022 03:31:59 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Wed, 02 Nov 2022 03:31:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1667374319; x=1667460719; bh=tjNciGfsgS
        gUkI6AndysubaRT3eHHI12Uie04qhAmh0=; b=UShU2c4UuH9O0ddC5fHgnXw+P1
        LHLgIobxEaT9eMmnEO2f+SZFwa4aOPnv6ZosuolyHg+EXWb7n4ZCSoL8Y/2iG2Pm
        SwcYhtqLWDuq5LM4htLEImoS13NKm4Gx8lKCBUp0567Hji4GFe6GHhtTTqx9Rgvt
        5zskIIoLoSGnU7fg46WkAYB4gmIt+y1LEwvrY2pVxw0u60S+VQNrct94Do24T4ft
        xgR225H2HjFaCIHURz142zpaNZ+3rU+ifa3Q3T72vUcj2WfJIHSXj8NSCVXMYK25
        EZg+CmKFZLDb2zQ+oFte3ivhlOB6riG91dVELjzOqNiPpcNwIQn7IGx7fyEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1667374319; x=1667460719; bh=tjNciGfsgSgUkI6AndysubaRT3eH
        HI12Uie04qhAmh0=; b=abzirlulPfkSCDmgHgvxI5Q70zVdESHnHjiptECBSIT0
        AfO+p7ct9hd6p/pzCJ7xfoFFYDKlJwzq5el0Uh2MNBRMSPa3+mvY0VjZx5l6uKd9
        617YAa6kRy5oYhxIj3v4bhq4fEp/LDORNPqL4pDAkQZPN2xLfTiciOMGwy8f/0hl
        mePnKhSyHHmpz3MwUfEbVuxGNIq+7baEp2azz+RjOwTb/fRKjLJ5EhHf+vJltbny
        y42DCVTVJzjLSEUuwzBbMP20GS/HXFk+loFeKByaVXAWS+YpBCZ0HRUOQLPYdXAJ
        Rl1t4aTZgIwgNwhZRUUAE74sz0N2rmBIZPKddA3QYA==
X-ME-Sender: <xms:7xxiY9WfD5GF8fblqnUbgBf9fhZpxhNrpzi7j_rcuyoKspRztJORVQ>
    <xme:7xxiY9mHkiO-dIjje1f9rCdLdhfpu0CsY9zSqC2siWkq10IHFZhj0iBiNSBqz-Aqc
    VICxBeYARlaqA_pQkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrudeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:7xxiY5Yl3Sy6tfaqgMzRH3yHkRiZUW71Rw8FhYOW02PSotj9BVoNVg>
    <xmx:7xxiYwUxGclLa7BaL5sj6hHtMG61wog1m9P_OswA4RVfdg1fj9bjVg>
    <xmx:7xxiY3khpAS_AbShjNwrJRwYqj_SMQ8cgptFEkfaXyTOLicwIKIBTg>
    <xmx:7xxiY3Odhs9OR2S2ZuYL-7toM3HelyCr0CZMEEpzkfCKGAD9PalpkQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 164CEB603D5; Wed,  2 Nov 2022 03:31:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1087-g968661d8e1-fm-20221021.001-g968661d8
Mime-Version: 1.0
Message-Id: <c1f86c53-1d9f-4faf-9313-de86d33e3739@app.fastmail.com>
In-Reply-To: <20221026185846.3983888-14-quic_eberman@quicinc.com>
References: <20221026185846.3983888-1-quic_eberman@quicinc.com>
 <20221026185846.3983888-14-quic_eberman@quicinc.com>
Date:   Wed, 02 Nov 2022 08:31:39 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Elliot Berman" <quic_eberman@quicinc.com>,
        "Bjorn Andersson" <quic_bjorande@quicinc.com>
Cc:     "Murali Nalajala" <quic_mnalajal@quicinc.com>,
        "Trilok Soni" <quic_tsoni@quicinc.com>,
        "Srivatsa Vaddagiri" <quic_svaddagi@quicinc.com>,
        "Carl van Schaik" <quic_cvanscha@quicinc.com>,
        "Prakruthi Deepak Heragu" <quic_pheragu@quicinc.com>,
        "Andy Gross" <agross@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>,
        "Jassi Brar" <jassisinghbrar@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Marc Zyngier" <maz@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Will Deacon" <will@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Srinivas Kandagatla" <srinivas.kandagatla@linaro.org>,
        "Amol Maheshwari" <amahesh@qti.qualcomm.com>,
        "Kalle Valo" <kvalo@kernel.org>, devicetree@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 13/21] gunyah: vm_mgr: Introduce basic VM Manager
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022, at 20:58, Elliot Berman wrote:

> +static const struct file_operations gh_vm_fops = {
> +	.unlocked_ioctl = gh_vm_ioctl,
> +	.release = gh_vm_release,
> +	.llseek = noop_llseek,
> +};

There should be a .compat_ioctl entry here, otherwise it is
impossible to use from 32-bit tasks. If all commands have
arguments passed through a pointer to a properly defined
structure, you can just set it to compat_ptr_ioctl.

> +static long gh_dev_ioctl_create_vm(unsigned long arg)
> +{
> +	struct gunyah_vm *ghvm;
> +	struct file *file;
> +	int fd, err;
> +
> +	/* arg reserved for future use. */
> +	if (arg)
> +		return -EINVAL;

Do you have something specific in mind here? If 'create'
is the only command you support, and it has no arguments,
it would be easier to do it implicitly during open() and
have each fd opened from /dev/gunyah represent a new VM.

> +	ghvm = gunyah_vm_alloc();
> +	if (IS_ERR_OR_NULL(ghvm))
> +		return PTR_ERR(ghvm) ? : -ENOMEM;

If you find yourself using IS_ERR_OR_NULL(), you have
usually made a mistake. In this case, the gunyah_vm_alloc()
function is badly defined and should just return -ENOMEM
for an allocation failure.

> +static struct gunyah_rsc_mgr_device_id vm_mgr_ids[] = {
> +	{ .name = GH_RM_DEVICE_VM_MGR },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(gunyah_rsc_mgr, vm_mgr_ids);
> +
> +static struct gh_rm_driver vm_mgr_drv = {
> +	.drv = {
> +		.name = KBUILD_MODNAME,
> +		.probe = vm_mgr_probe,
> +		.remove = vm_mgr_remove,
> +	},
> +	.id_table = vm_mgr_ids,
> +};
> +module_gh_rm_driver(vm_mgr_drv);

It looks like the gunyah_rsc_mgr_device_id in this case is
purely internal to the kernel, so you are adding abstraction
layers to something that does not need to be abstracted
because the host side has no corresponding concept of
devices.

I'm correct, you can just turn the entire bus/device/driver
structure within your code into simple function calls, where
the main code calls vm_mgr_probe() as an exported function
instead of creating a device.

      Arnd

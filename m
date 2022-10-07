Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031DD5F79F8
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 16:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbiJGOwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 10:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJGOwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 10:52:05 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C1766865;
        Fri,  7 Oct 2022 07:51:52 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 779EE320025E;
        Fri,  7 Oct 2022 10:51:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 07 Oct 2022 10:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1665154309; x=1665240709; bh=cbXxlpgk38
        Og2OSP3BeodMmIhEyN7me626e1pixIS0A=; b=aIPzan2K/5vwQr3WnGbKft/MgW
        JPGZlxE2o0tOeKglTTMczDdDL7JbYv9rOKwG/XlKMVhd0Ux97xTInMITTUI12vZj
        Vs/ZOPTYVzrGvDTig+9cFE/h0mL5blPZbQlu3wiu6G1LabZLDjmYLWgnn2FaRgFY
        gt8h3HXClEx/HULvjWErDnGBTOrX2vbhYFfFaLvZpDkImZrirbA+nEfRAOpy3yIK
        azG8KOWEjENV5M9d/wSEM7QVSNMJOKj44IesruQluxpdtZlcleN7mAk5/PKAgdVF
        sK0u7si7JPPNFVQFLS9CIKvCpQkI4RWFdzp94LyC9ir8cU2vaZ8Q9ko56OOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1665154309; x=1665240709; bh=cbXxlpgk38Og2OSP3BeodMmIhEyN
        7me626e1pixIS0A=; b=snGjR8CIxyRDi1bd8qkxVdrIhI15r1WXpAvJPKxKG4q4
        /F6y1Jdd7P+3JQjYs397XarlQoA7MdNHxLd/EN5Ad5OrFOUBLwyS5QD4A4JjhHQR
        kjlCk9J6+Sbr5oqrxAmOUAqFZagh7+PUIhgN9atbrmm/2hIZS7uALcx+ikIaz8TM
        986ouMn+UJS3/5ZVGKBjtmR1KTYNXAtFZTYgEEEBasgqEjTlK7ivfzzOukJV6UMl
        X9/9ABpgJSDm0bv25BKWU6YCwc16Cc5WHnjCFWKZfUxhZM9wlpNirqCO6B+04HoZ
        eXJK9TuDzAEjLESKDZj40vS09DdZe+FM4czuRnReGw==
X-ME-Sender: <xms:BD1AYy1_2ZOZUpxE6_a3TZsTRqdU65-R2RDKm611YXzdX2cOCHR5Mg>
    <xme:BD1AY1GwT-cC0kU7SM4HPMDPZDaTn8ndOoKDas96uKFfwUTDpXXtS_anmAU2Ge9-3
    pJWix0uSOzuzw>
X-ME-Received: <xmr:BD1AY64wY9Xh14lJyiK1raFmpMK-vjspn9YGSjwPRFnWmIa-ElO4grkHAHlr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeijedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:BD1AYz16QwKwJUZQaILrOIyFb8g5oxpXd4mF-nBVxqsX0qoRupC5Mg>
    <xmx:BD1AY1GeDWn6s677bS3Yjcx-1UoO-dlW961jtqxbM23r_PIM0mxfoQ>
    <xmx:BD1AY8_Km6gKn85xfUo1qo6davpj5oQFwW8VM7sF3aIt6tlAMxSx2Q>
    <xmx:BT1AY99mzHQEy5O-ygwPRc-OojV7e19P51nI6_W6Xe6_Dkre2QlrQQ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Oct 2022 10:51:48 -0400 (EDT)
Date:   Fri, 7 Oct 2022 16:52:31 +0200
From:   Greg KH <greg@kroah.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        tsbogend@alpha.franken.de, linux-api@vger.kernel.org,
        f.fainelli@gmail.com
Subject: Re: [PATCH v5] MIPS: Expose prid and globalnumber to sysfs
Message-ID: <Y0A9L2KajswAEKsu@kroah.com>
References: <20221007141207.30635-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221007141207.30635-1-jiaxun.yang@flygoat.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 07, 2022 at 03:12:07PM +0100, Jiaxun Yang wrote:
> Some application would like to know precise model and rev of processor
> to do errata workaround or optimization.
> 
> Expose them in sysfs as:
> /sys/devices/system/cpu/cpuX/regs/identification/prid
> /sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> 
> Reusing AArch64 CPU registers directory.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> v2: Drop static qualifier for kobj (gregkh)
> v3: Use kzalloc to allocate struct cpuregs.
>     note: When Greg mentioned about static I was thinking about
>     static qualifier of percpu variable. After reading documents
>     again it turns out kobjs should be allocated at runtime. Arm64's
>     cpuinfo kobj is also on a percpu variable... I guess that was a
>     intentional use?
> v4: Properly handle err of kobj creation. (gregkh)
> v5: Drop invalid kfree
> ---
>  .../ABI/testing/sysfs-devices-system-cpu      | 11 +++
>  arch/mips/kernel/topology.c                   | 99 +++++++++++++++++++
>  2 files changed, 110 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
> index 5bf61881f012..9fdfe2de0f76 100644
> --- a/Documentation/ABI/testing/sysfs-devices-system-cpu
> +++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
> @@ -512,6 +512,17 @@ Description:	information about CPUs heterogeneity.
>  
>  		cpu_capacity: capacity of cpuX.
>  
> +What:		/sys/devices/system/cpu/cpuX/regs/
> +		/sys/devices/system/cpu/cpuX/regs/identification/
> +		/sys/devices/system/cpu/cpuX/regs/identification/prid
> +		/sys/devices/system/cpu/cpuX/regs/identification/globalnumber
> +Date:		October 2022
> +Contact:	Linux MIPS Kernel Mailing list <linux-mips@vger.kernel.org>
> +Description:	MIPS CPU registers
> +
> +		'identification' directory exposes the Processor ID and Global Number
> +		registers for identifying model and revision of the CPU.
> +
>  What:		/sys/devices/system/cpu/vulnerabilities
>  		/sys/devices/system/cpu/vulnerabilities/meltdown
>  		/sys/devices/system/cpu/vulnerabilities/spectre_v1
> diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
> index 9429d85a4703..80aaaca3cfbc 100644
> --- a/arch/mips/kernel/topology.c
> +++ b/arch/mips/kernel/topology.c
> @@ -5,6 +5,8 @@
>  #include <linux/node.h>
>  #include <linux/nodemask.h>
>  #include <linux/percpu.h>
> +#include <linux/seq_file.h>
> +#include <linux/smp.h>
>  
>  static DEFINE_PER_CPU(struct cpu, cpu_devices);
>  
> @@ -26,3 +28,100 @@ static int __init topology_init(void)
>  }
>  
>  subsys_initcall(topology_init);
> +
> +static struct kobj_type cpuregs_kobj_type = {
> +	.sysfs_ops = &kobj_sysfs_ops,
> +};
> +
> +struct cpureg {
> +	struct kobject kobj;
> +	struct cpuinfo_mips *info;
> +};
> +static DEFINE_PER_CPU(struct cpureg *, cpuregs);
> +
> +#define kobj_to_cpureg(kobj)	container_of(kobj, struct cpureg, kobj)
> +#define CPUREGS_ATTR_RO(_name, _field)						\
> +	static ssize_t _name##_show(struct kobject *kobj,			\
> +			struct kobj_attribute *attr, char *buf)			\
> +	{									\
> +		struct cpuinfo_mips *info = kobj_to_cpureg(kobj)->info;		\
> +										\
> +		return sprintf(buf, "0x%08x\n", info->_field);	\

sysfs_emit() please.


> +	}									\
> +	static struct kobj_attribute cpuregs_attr_##_name = __ATTR_RO(_name)
> +
> +CPUREGS_ATTR_RO(prid, processor_id);
> +CPUREGS_ATTR_RO(globalnumber, globalnumber);
> +
> +static struct attribute *cpuregs_id_attrs[] = {
> +	&cpuregs_attr_prid.attr,
> +	&cpuregs_attr_globalnumber.attr,
> +	NULL
> +};
> +
> +static const struct attribute_group cpuregs_attr_group = {
> +	.attrs = cpuregs_id_attrs,
> +	.name = "identification"
> +};
> +
> +static int cpuregs_cpu_online(unsigned int cpu)
> +{
> +	int rc;
> +	struct device *dev;
> +	struct cpureg *reg;
> +
> +	dev = get_cpu_device(cpu);
> +	if (!dev) {
> +		rc = -ENODEV;
> +		goto out;
> +	}
> +	reg = kzalloc(sizeof(struct cpureg), GFP_KERNEL);
> +	if (!reg) {
> +		rc = -ENOMEM;
> +		goto out;
> +	}
> +	rc = kobject_init_and_add(&reg->kobj, &cpuregs_kobj_type,
> +					&dev->kobj, "regs");
> +	if (rc)
> +		goto out_kobj;
> +	rc = sysfs_create_group(&reg->kobj, &cpuregs_attr_group);
> +	if (rc)
> +		goto out_kobj;
> +
> +	return 0;
> +out_kobj:
> +	kobject_put(&reg->kobj);
> +out:
> +	return rc;
> +}
> +
> +static int cpuregs_cpu_offline(unsigned int cpu)
> +{
> +	struct device *dev;
> +	struct cpureg *reg = per_cpu(cpuregs, cpu);
> +
> +	dev = get_cpu_device(cpu);
> +	if (!dev || !reg)
> +		return -ENODEV;
> +	if (reg->kobj.parent) {

Why are you looking at the parent of a kobject?  Why not just always
remove the kobject if you have a reference to it now?  How does the
parent matter?

thanks,

greg k-h

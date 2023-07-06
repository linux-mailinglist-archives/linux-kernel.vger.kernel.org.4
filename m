Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19F0749F3D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233260AbjGFOmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbjGFOmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:42:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A508D199F;
        Thu,  6 Jul 2023 07:42:38 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 50B14D75;
        Thu,  6 Jul 2023 07:43:20 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF7333F762;
        Thu,  6 Jul 2023 07:42:36 -0700 (PDT)
Date:   Thu, 6 Jul 2023 15:42:34 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZKbS2jkl0R0Ul1a4@e120937-lin>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
 <d388c7af3f72fd47baffe0de8c6fec8074cb483c.1686063941.git.oleksii_moisieiev@epam.com>
 <ZKKgD1QxF085kE+c@e120937-lin>
 <20230706140937.GA821831@EPUAKYIW0A6A>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706140937.GA821831@EPUAKYIW0A6A>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 02:09:38PM +0000, Oleksii Moisieiev wrote:
> Hi Cristian,
> 

Hi Oleksii,

> Sorry for late answer.
> Please see below.
> 

No worries, not late at all.

> On Mon, Jul 03, 2023 at 11:16:47AM +0100, Cristian Marussi wrote:
> > On Tue, Jun 06, 2023 at 04:22:27PM +0000, Oleksii Moisieiev wrote:
> > > scmi: Introduce pinctrl SCMI protocol driver
> > >
> > 
> > Hi Oleksii,
> > 
> > spurios line above.
> 
> Yep thanks, I will remove.
> 
> > 
> > > Add basic implementation of the SCMI v3.2 pincontrol protocol
> > > excluding GPIO support. All pinctrl related callbacks and operations
> > > are exposed in the include/linux/scmi_protocol.h
> > > 
> > 
> > As Andy said already, you can drop the second sentence here, but I would
> > ALSO drop the GPIO part in the first sentence, since there is nothing
> > specific to GPIO in the SCMI spec and this patch is about the SCMI protocol
> > not the pinctrl driver.
> >
> 
> I've added few words about GPIO because in v2 series Michal Simek asked
> about it: https://lore.kernel.org/linux-arm-kernel/5bf0e975-d314-171f-b6a8-c1c1c7198cd3@amd.com/
> So I've decided to mention that there is still no GPIO support in the
> commit message to avoid this type of questions in future. But I agree
> that the commit message looks weird and will try to rephrase it.
>

Yes I remember that and I understand why you want to mention this, what
I am saying is that anyway is NOT something related to the SCMI Pinctrl
spec AFAIU (I may be wrong): I mean GPIO support is something you can
build on top of Pinctrl SCMI spec and driver NOT something that has
still to be added to the spec right ? and this patch is about supporting
the new SCMI protocol, so I certainly agree that can be fine to point
out that GPIO support is missing, just maybe this is a comment more
appropriate to be added to the Pinctrl SCMI driver than to the Pinctrl
SCMI protocol layer...(but maybe the Pinctrl subsys maintainer will
disagree on this :P)

> > > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > ---
> > >  MAINTAINERS                           |   6 +
> > >  drivers/firmware/arm_scmi/Makefile    |   2 +-
> > >  drivers/firmware/arm_scmi/driver.c    |   2 +
> > >  drivers/firmware/arm_scmi/pinctrl.c   | 836 ++++++++++++++++++++++++++
> > >  drivers/firmware/arm_scmi/protocols.h |   1 +
> > >  include/linux/scmi_protocol.h         |  47 ++
> > >  6 files changed, 893 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/firmware/arm_scmi/pinctrl.c
> > > 
> > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > index 0dab9737ec16..297b2512963d 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -20522,6 +20522,12 @@ F:	include/linux/sc[mp]i_protocol.h
> > >  F:	include/trace/events/scmi.h
> > >  F:	include/uapi/linux/virtio_scmi.h
> > >  
> > > +PINCTRL DRIVER FOR SYSTEM CONTROL & POWER/MANAGEMENT INTERFACE (SCPI/SCMI)
> > 
> > SCPI is a leftover here I suppose...
> > 
> 
> Thanks. I'll fix it.
> 
> > > +M:	Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> > > +L:	linux-arm-kernel@lists.infradead.org
> > > +S:	Maintained
> > > +F:	drivers/firmware/arm_scmi/pinctrl.c
> > > +
> > >  SYSTEM RESET/SHUTDOWN DRIVERS
> > >  M:	Sebastian Reichel <sre@kernel.org>
> > >  L:	linux-pm@vger.kernel.org
> > > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> > > index b31d78fa66cc..603430ec0bfe 100644
> > > --- a/drivers/firmware/arm_scmi/Makefile
> > > +++ b/drivers/firmware/arm_scmi/Makefile
> > > @@ -10,7 +10,7 @@ scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_VIRTIO) += virtio.o
> > >  scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_OPTEE) += optee.o
> > > -scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o
> > > +scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o powercap.o pinctrl.o
> > >  scmi-module-objs := $(scmi-driver-y) $(scmi-protocols-y) $(scmi-transport-y)
> > >  
> > >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> > > diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> > > index 5be931a07c84..a9fd337b9596 100644
> > > --- a/drivers/firmware/arm_scmi/driver.c
> > > +++ b/drivers/firmware/arm_scmi/driver.c
> > > @@ -3025,6 +3025,7 @@ static int __init scmi_driver_init(void)
> > >  	scmi_voltage_register();
> > >  	scmi_system_register();
> > >  	scmi_powercap_register();
> > > +	scmi_pinctrl_register();
> > >  
> > >  	return platform_driver_register(&scmi_driver);
> > >  }
> > > @@ -3042,6 +3043,7 @@ static void __exit scmi_driver_exit(void)
> > >  	scmi_voltage_unregister();
> > >  	scmi_system_unregister();
> > >  	scmi_powercap_unregister();
> > > +	scmi_pinctrl_unregister();
> > >  
> > >  	scmi_transports_exit();
> > >  
> > > diff --git a/drivers/firmware/arm_scmi/pinctrl.c b/drivers/firmware/arm_scmi/pinctrl.c
> > > new file mode 100644
> > > index 000000000000..fc0fcc26dfb6
> > > --- /dev/null
> > > +++ b/drivers/firmware/arm_scmi/pinctrl.c
> > > @@ -0,0 +1,836 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * System Control and Management Interface (SCMI) Pinctrl Protocol
> > > + *
> > > + * Copyright (C) 2023 EPAM
> > > + */
> > > +
> > > +#include <linux/module.h>
> > > +#include <linux/scmi_protocol.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include "protocols.h"
> > > +
> > > +#define REG_TYPE_BITS GENMASK(9, 8)
> > > +#define REG_CONFIG GENMASK(7, 0)
> > > +
> > > +#define GET_GROUPS_NR(x)	le32_get_bits((x), GENMASK(31, 16))
> > > +#define GET_PINS_NR(x)		le32_get_bits((x), GENMASK(15, 0))
> > > +#define GET_FUNCTIONS_NR(x)	le32_get_bits((x), GENMASK(15, 0))
> > > +
> > > +#define EXT_NAME_FLAG(x)	le32_get_bits((x), BIT(31))
> > > +#define NUM_ELEMS(x)		le32_get_bits((x), GENMASK(15, 0))
> > > +
> > > +#define REMAINING(x)		le32_get_bits((x), GENMASK(31, 16))
> > > +#define RETURNED(x)		le32_get_bits((x), GENMASK(11, 0))
> > > +
> > > +enum scmi_pinctrl_protocol_cmd {
> > > +	PINCTRL_ATTRIBUTES = 0x3,
> > > +	PINCTRL_LIST_ASSOCIATIONS = 0x4,
> > > +	PINCTRL_CONFIG_GET = 0x5,
> > > +	PINCTRL_CONFIG_SET = 0x6,
> > > +	PINCTRL_FUNCTION_SELECT = 0x7,
> > > +	PINCTRL_REQUEST = 0x8,
> > > +	PINCTRL_RELEASE = 0x9,
> > > +	PINCTRL_NAME_GET = 0xa,
> > > +	PINCTRL_SET_PERMISSIONS = 0xb
> > > +};
> > > +
> > > +struct scmi_msg_conf_set {
> > > +	__le32 identifier;
> > > +	__le32 attributes;
> > > +	__le32 config_value;
> > > +};
> > > +
> > > +struct scmi_msg_conf_get {
> > > +	__le32 identifier;
> > > +	__le32 attributes;
> > > +};
> > > +
> > > +struct scmi_msg_pinctrl_protocol_attributes {
> > > +	__le32 attributes_low;
> > > +	__le32 attributes_high;
> > > +};
> > > +
> > > +struct scmi_msg_pinctrl_attributes {
> > > +	__le32 identifier;
> > > +	__le32 flags;
> > > +};
> > > +
> > > +struct scmi_resp_pinctrl_attributes {
> > > +	__le32 attributes;
> > > +	u8 name[SCMI_SHORT_NAME_MAX_SIZE];
> > > +};
> > > +
> > > +struct scmi_msg_pinctrl_list_assoc {
> > > +	__le32 identifier;
> > > +	__le32 flags;
> > > +	__le32 index;
> > > +};
> > > +
> > > +struct scmi_resp_pinctrl_list_assoc {
> > > +	__le32 flags;
> > > +	__le16 array[];
> > > +};
> > > +
> > > +struct scmi_msg_func_set {
> > > +	__le32 identifier;
> > > +	__le32 function_id;
> > > +	__le32 flags;
> > > +};
> > > +
> > > +struct scmi_msg_request {
> > > +	__le32 identifier;
> > > +	__le32 flags;
> > > +};
> > > +
> > > +struct scmi_group_info {
> > > +	bool present;
> > > +	char name[SCMI_MAX_STR_SIZE];
> > > +	unsigned int *group_pins;
> > > +	unsigned int nr_pins;
> > > +};
> > > +
> > > +struct scmi_function_info {
> > > +	bool present;
> > > +	char name[SCMI_MAX_STR_SIZE];
> > > +	unsigned int *groups;
> > > +	unsigned int nr_groups;
> > > +};
> > > +
> > 
> > A small note related to Andy remarks about directly embedding here pinctrl
> > subsystem structures (like pingroup / pinfucntion) that I forgot to say
> > in my reply to him.
> > 
> > These structs above indeed are very similar to the Pinctrl ones but this is
> > the protocol layer inside SCMI, I would not mix here stuff from the Pinctrl
> > subsystem which is, at the end the, one of the possible users of this layer
> > (via the SCMI pinctrl driver) but not necessarily the only one in the
> > future; moreover Pinctrl subsystem is not even needed at all if you think
> > about a testing scenario, so I would not build up a dependency here between
> > SCMI and Pinctrl by using Pinctrl structures...what if these latter change
> > in the future ?
> > 
> > All of this to just say this is fine for me as it is now :D
> > 
> I agree with you.
> What we currently have is that scmi pinctrl protocol is not bound to
> pinctrl-subsystem so in case of some changes in the pinctrl - no need to
> change the protocol implementation.
> Also, as I mentioned in v2: I can't use pincfunction it has the following groups
> definition:
> const char * const *groups;
> 
> Which is meant to be constantly allocated.
> So I when I try to gather list of groups in
> pinctrl_scmi_get_function_groups I will receive compilation error.
> 
> Pinctrl subsystem was designed to use statically defined
> pins/groups/functions so we can't use those structures on lazy
> allocations.
> 

Indeed, I forgot that additional reason.

> 
> > > +struct scmi_pin_info {
> > > +	bool present;
> > > +	char name[SCMI_MAX_STR_SIZE];
> > > +};
> > > +
> > > +struct scmi_pinctrl_info {
> > > +	u32 version;
> > > +	int nr_groups;
> > > +	int nr_functions;
> > > +	int nr_pins;
> > > +	struct scmi_group_info *groups;
> > > +	struct scmi_function_info *functions;
> > > +	struct scmi_pin_info *pins;
> > > +};
> > > +
> > > +static int scmi_pinctrl_attributes_get(const struct scmi_protocol_handle *ph,
> > > +				       struct scmi_pinctrl_info *pi)
> > > +{
> > > +	int ret;
> > > +	struct scmi_xfer *t;
> > > +	struct scmi_msg_pinctrl_protocol_attributes *attr;
> > > +
> > > +	if (!pi)
> > > +		return -EINVAL;
> > 
> > You can drop this, cannot happen given the code paths.
> >
> 
> Ok. thanks.
> 
> > > +
> > > +	ret = ph->xops->xfer_get_init(ph, PROTOCOL_ATTRIBUTES,
> > > +				      0, sizeof(*attr), &t);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	attr = t->rx.buf;
> > > +
> > > +	ret = ph->xops->do_xfer(ph, t);
> > > +	if (!ret) {
> > > +		pi->nr_functions = GET_FUNCTIONS_NR(attr->attributes_high);
> > > +		pi->nr_groups = GET_GROUPS_NR(attr->attributes_low);
> > > +		pi->nr_pins = GET_PINS_NR(attr->attributes_low);
> > > +	}
> > > +
> > > +	ph->xops->xfer_put(ph, t);
> > > +	return ret;
> > > +}
> > > +
> > > +static int scmi_pinctrl_get_count(const struct scmi_protocol_handle *ph,
> > > +				  enum scmi_pinctrl_selector_type type)
> > > +{
> > > +	struct scmi_pinctrl_info *pi;
> > > +
> > > +	pi = ph->get_priv(ph);
> > > +	if (!pi)
> > > +		return -ENODEV;
> > 
> > You dont need to check for NULL here and nowhere else.
> > You set protocol private data with set_priv at the end of protocol init
> > which is called as soon as a user tries to use this protocol operations,
> > so it cannot ever be NULL in any of these following ops.
> > 
> 
> And what if I call set_priv(ph, NULL) on init stage?
> As I can see there is no check for NULL in scmi_set_protocol_priv. So
> theoretically I'm able to set ph->priv = NULL. Or did I missed some check in
> SCMI driver? Or maybe priv = NULL is expected scenario and I shouldn't
> return error here?

Well, you are right that you could set periv to NULL, but the whole
point of set_priv/get_priv helpers are to help you protocol-writer to
store your private data at init for future usage while processing the
protocol operations that you, protocol-writer, are implementing; the
idea of all of this 'dancing' around protocol_handle was to ease the
developement of protocols by exposing a limited, common and well
controlled interface to use to build/send messages (ph->xops) while
hiding some internals related to protocol stack init that are handled
by the core for you.

The priv data are only set and get optionally by You depending on the
need of the protocol, so unless you can dynamically set, at runtime, priv
to NULL or not-NULL depending on the outcome of the init, you should very
well know at coding time if your priv could possibly be ever NULL or it
cannot be NULL at all (like in this case it seems to me): so the check
seemed to me redundant...

...clearly, beside trying to help the protocol devel, the SCMI core
protocol 'framework' cannot prevent you from shooting yourself in the
foot if you want :P

Thanks,
Cristian


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB47673FC7
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjASRVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:21:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbjASRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:21:09 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632983DB;
        Thu, 19 Jan 2023 09:21:04 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id 3e5c0cf68ce6ed84; Thu, 19 Jan 2023 18:21:01 +0100
Received: from kreacher.localnet (unknown [213.134.183.25])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id 16AAF66B8AC;
        Thu, 19 Jan 2023 18:21:01 +0100 (CET)
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
Subject: Re: [PATCH 3/5] thermal/core: Remove unneeded mutex_destroy()
Date:   Thu, 19 Jan 2023 18:21:00 +0100
Message-ID: <12134920.O9o76ZdvQC@kreacher>
In-Reply-To: <54674d67-7be3-0abc-4252-e7f4158f56f2@linaro.org>
References: <20230118211123.111493-1-daniel.lezcano@linaro.org> <CAJZ5v0icp3nH+3-timEh2o8kxXpe4O2uMdJ8pSwe8fmY_OW4zA@mail.gmail.com> <54674d67-7be3-0abc-4252-e7f4158f56f2@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.183.25
X-CLIENT-HOSTNAME: 213.134.183.25
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedruddutddguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeetkeeigfegjeevudelvdejvdetteehleekjeegkeejiedvlefgheehieehgedugfenucffohhmrghinhepkhhosghjrdhnrghmvgenucfkphepvddufedrudefgedrudekfedrvdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudekfedrvdehpdhhvghlohepkhhrvggrtghhvghrrdhlohgtrghlnhgvthdpmhgrihhlfhhrohhmpedftfgrfhgrvghlucflrdcuhgihshhotghkihdfuceorhhjfiesrhhjfiihshhotghkihdrnhgvtheqpdhnsggprhgtphhtthhopeeipdhrtghpthhtoheprhgrfhgrvghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghnihgvlhdrlhgviigtrghnoheslhhinhgrrhhordhorhhgpdhrtghpthhtoheprhhuihdriihhrghnghesihhnthgvlhdrtghomhdprhgtphhtthhopehlihhnuhigqdhpmhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
 rhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrmhhithhksehkvghrnhgvlhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, January 19, 2023 5:39:29 PM CET Daniel Lezcano wrote:
> On 19/01/2023 16:05, Rafael J. Wysocki wrote:
> > On Thu, Jan 19, 2023 at 3:13 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 19/01/2023 14:24, Rafael J. Wysocki wrote:
> >>> On Thu, Jan 19, 2023 at 1:48 PM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 19/01/2023 13:11, Rafael J. Wysocki wrote:
> >>>>> On Thu, Jan 19, 2023 at 10:30 AM Daniel Lezcano
> >>>>> <daniel.lezcano@linaro.org> wrote:
> >>>>>>
> >>>>>> On 19/01/2023 08:41, Zhang, Rui wrote:
> >>>>>>> On Wed, 2023-01-18 at 22:11 +0100, Daniel Lezcano wrote:
> >>>>>>>> If the thermal framework fails to initialize, the mutex can be used
> >>>>>>>> by
> >>>>>>>> the different functions registering a thermal zone anyway.
> >>>>>>>
> >>>>>>> Hmm, even with no governors and unregistered thermal sysfs class?
> >>>>>>>
> >>>>>>> IMO, thermal APIs for registering a thermal_zone/cooling_device should
> >>>>>>> yield early if thermal_init fails.
> >>>>>>> For other APIs that relies on a valid
> >>>>>>> thermal_zone_device/thermal_cooling_device pointer, nothing needs to
> >>>>>>> be changed.
> >>>>>>>
> >>>>>>> what do you think?
> >>>>>>
> >>>>>> I think you are right.
> >>>>>>
> >>>>>> It would be nice if we can check if the thermal class is registered and
> >>>>>> bail out if not. But there is no function to check that AFAICS.
> >>>>>>
> >>>>>> Alternatively we can convert the thermal class static structure to a
> >>>>>> pointer and set it to NULL in case of error in thermal_init() ?
> >>>>>
> >>>>> It doesn't matter if this is a NULL pointer or a static object that's
> >>>>> clearly marked as unused.
> >>>>
> >>>> Without introducing another global variable, is it possible to know if
> >>>> the class is used or not ?
> >>>
> >>> If thermal_class.p is cleared to NULL on class_register() failures in
> >>> thermal_init() (unfortunately, the driver core doesn't do that, but
> >>> maybe it should - let me cut a patch for that), then it can be used
> >>> for that.
> >>
> >> It should be in class_unregister() too, right ?
> >>
> >> And is it possible to add a class_is_registered() ? in order to prevent
> >> accessing class structure internals ?
> > 
> > I suppose so.
> > 
> > And we'd like it to be used some places like
> > thermal_zone_device_register_with_trips(), wouldn't we?
> 
> Yes, in thermal_zone_device_register_with_trips() and 
> thermal_cooling_device_register().

Something like the patch below I think, because thermal_cooling_device_register()
is a wrapper around thermal_zone_device_register_with_trips().

It needs to be split into 2 individual patches.

---
 drivers/base/class.c           |   16 +++++++++++-----
 drivers/thermal/thermal_core.c |    3 +++
 include/linux/device/class.h   |    5 +++++
 3 files changed, 19 insertions(+), 5 deletions(-)

Index: linux-pm/include/linux/device/class.h
===================================================================
--- linux-pm.orig/include/linux/device/class.h
+++ linux-pm/include/linux/device/class.h
@@ -82,6 +82,11 @@ struct class_dev_iter {
 	const struct device_type	*type;
 };
 
+static inline bool class_is_registered(struct class *class)
+{
+	return !!class->p;
+}
+
 extern struct kobject *sysfs_dev_block_kobj;
 extern struct kobject *sysfs_dev_char_kobj;
 extern int __must_check __class_register(struct class *class,
Index: linux-pm/drivers/base/class.c
===================================================================
--- linux-pm.orig/drivers/base/class.c
+++ linux-pm/drivers/base/class.c
@@ -53,6 +53,8 @@ static void class_release(struct kobject
 
 	pr_debug("class '%s': release.\n", class->name);
 
+	class->p = NULL;
+
 	if (class->class_release)
 		class->class_release(class);
 	else
@@ -186,17 +188,21 @@ int __class_register(struct class *cls,
 	cls->p = cp;
 
 	error = kset_register(&cp->subsys);
-	if (error) {
-		kfree(cp);
-		return error;
-	}
+	if (error)
+		goto err_out;
+
 	error = class_add_groups(class_get(cls), cls->class_groups);
 	class_put(cls);
 	if (error) {
 		kobject_del(&cp->subsys.kobj);
 		kfree_const(cp->subsys.kobj.name);
-		kfree(cp);
+		goto err_out;
 	}
+	return 0;
+
+err_out:
+	cls->p = NULL;
+	kfree(cp);
 	return error;
 }
 EXPORT_SYMBOL_GPL(__class_register);
Index: linux-pm/drivers/thermal/thermal_core.c
===================================================================
--- linux-pm.orig/drivers/thermal/thermal_core.c
+++ linux-pm/drivers/thermal/thermal_core.c
@@ -1342,6 +1342,9 @@ thermal_zone_device_register_with_trips(
 	if (num_trips > 0 && (!ops->get_trip_type || !ops->get_trip_temp) && !trips)
 		return ERR_PTR(-EINVAL);
 
+	if (!class_is_registered(&thermal_class))
+		return ERR_PTR(-ENODEV);
+
 	tz = kzalloc(sizeof(*tz), GFP_KERNEL);
 	if (!tz)
 		return ERR_PTR(-ENOMEM);




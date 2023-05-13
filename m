Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634347018DB
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237625AbjEMR7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233748AbjEMR5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:57:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CB6C2125;
        Sat, 13 May 2023 10:57:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C4AD61CE4;
        Sat, 13 May 2023 17:57:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2A3C43324;
        Sat, 13 May 2023 17:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684000666;
        bh=u9kFggnQr7LxDCGoBJEsqutlWdxLNmjiS8oxIp04Bi0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jhi9BQd7V17leMQ1zYh9SV53benuySIO1sOsNLiVW4v3Mradzm5ycJtcfj7UwZb8k
         ubTpgIohNug1KedyKV4jBZD67BTCkguarXT8nJyo4aBo6Ulg7I/7Igu1exc06MT+4h
         9TzNt/8Q0ZfIe7IVSl/OXbUi7uoToXgS8XfVkpDcBwbwFe8jQ1IrF1XPVQdBwvuXiw
         tOOr0wLtlX4rKO/9jh87PI4X7MIR/P/Mf4ZuRKl+CKnfxAVHvLRgiN8EEU94g9PAhh
         0xUmatu8QawxBdDEVjpvEXcYFfEtaIaCKbNj0bCdVxxG1dWnPfMwMO7T4vpO9nS07e
         xMh4jW3XfmGmQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.96)
        (envelope-from <mchehab@kernel.org>)
        id 1pxtV1-001tyH-1o;
        Sat, 13 May 2023 18:57:43 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [PATCH 18/24] media: dvbdev: fix most coding style issues
Date:   Sat, 13 May 2023 18:57:35 +0100
Message-Id: <8dfc633c041c038631085cb02d8aac619ee647c9.1684000646.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
References: <53558de2b5c4f4ee6bfcfbe34e27071c2d0073d5.1684000646.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're doing several changes here, address coding style issues,
as reported by checkpatch.pl.

Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---
 drivers/media/dvb-core/dvbdev.c | 157 +++++++++++++++-----------------
 1 file changed, 74 insertions(+), 83 deletions(-)

diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvbdev.c
index a4b05e366ccc..fb81fa46d92e 100644
--- a/drivers/media/dvb-core/dvbdev.c
+++ b/drivers/media/dvb-core/dvbdev.c
@@ -61,21 +61,21 @@ static const char * const dnames[] = {
 #define DVB_MAX_IDS		4
 
 static const u8 minor_type[] = {
-       [DVB_DEVICE_VIDEO]      = 0,
-       [DVB_DEVICE_AUDIO]      = 1,
-       [DVB_DEVICE_SEC]        = 2,
-       [DVB_DEVICE_FRONTEND]   = 3,
-       [DVB_DEVICE_DEMUX]      = 4,
-       [DVB_DEVICE_DVR]        = 5,
-       [DVB_DEVICE_CA]         = 6,
-       [DVB_DEVICE_NET]        = 7,
-       [DVB_DEVICE_OSD]        = 8,
+	[DVB_DEVICE_VIDEO]      = 0,
+	[DVB_DEVICE_AUDIO]      = 1,
+	[DVB_DEVICE_SEC]        = 2,
+	[DVB_DEVICE_FRONTEND]   = 3,
+	[DVB_DEVICE_DEMUX]      = 4,
+	[DVB_DEVICE_DVR]        = 5,
+	[DVB_DEVICE_CA]         = 6,
+	[DVB_DEVICE_NET]        = 7,
+	[DVB_DEVICE_OSD]        = 8,
 };
 
 #define nums2minor(num, type, id) \
-       (((num) << 6) | ((id) << 4) | minor_type[type])
+	(((num) << 6) | ((id) << 4) | minor_type[type])
 
-#define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS*64)
+#define MAX_DVB_MINORS		(DVB_MAX_ADAPTERS * 64)
 #endif
 
 static struct class *dvb_class;
@@ -112,9 +112,7 @@ static int dvb_device_open(struct inode *inode, struct file *file)
 	return -ENODEV;
 }
 
-
-static const struct file_operations dvb_device_fops =
-{
+static const struct file_operations dvb_device_fops = {
 	.owner =	THIS_MODULE,
 	.open =		dvb_device_open,
 	.llseek =	noop_llseek,
@@ -147,7 +145,6 @@ int dvb_generic_open(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL(dvb_generic_open);
 
-
 int dvb_generic_release(struct inode *inode, struct file *file)
 {
 	struct dvb_device *dvbdev = file->private_data;
@@ -155,11 +152,10 @@ int dvb_generic_release(struct inode *inode, struct file *file)
 	if (!dvbdev)
 		return -ENODEV;
 
-	if ((file->f_flags & O_ACCMODE) == O_RDONLY) {
+	if ((file->f_flags & O_ACCMODE) == O_RDONLY)
 		dvbdev->readers++;
-	} else {
+	else
 		dvbdev->writers++;
-	}
 
 	dvbdev->users++;
 
@@ -169,7 +165,6 @@ int dvb_generic_release(struct inode *inode, struct file *file)
 }
 EXPORT_SYMBOL(dvb_generic_release);
 
-
 long dvb_generic_ioctl(struct file *file,
 		       unsigned int cmd, unsigned long arg)
 {
@@ -185,13 +180,13 @@ long dvb_generic_ioctl(struct file *file,
 }
 EXPORT_SYMBOL(dvb_generic_ioctl);
 
-
-static int dvbdev_get_free_id (struct dvb_adapter *adap, int type)
+static int dvbdev_get_free_id(struct dvb_adapter *adap, int type)
 {
 	u32 id = 0;
 
 	while (id < DVB_MAX_IDS) {
 		struct dvb_device *dev;
+
 		list_for_each_entry(dev, &adap->device_list, list_head)
 			if (dev->type == type && dev->id == id)
 				goto skip;
@@ -245,7 +240,7 @@ static void dvb_media_device_free(struct dvb_device *dvbdev)
 
 #if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 static int dvb_create_tsout_entity(struct dvb_device *dvbdev,
-				    const char *name, int npads)
+				   const char *name, int npads)
 {
 	int i;
 
@@ -387,7 +382,7 @@ static int dvb_create_media_entity(struct dvb_device *dvbdev,
 
 static int dvb_register_media_device(struct dvb_device *dvbdev,
 				     int type, int minor,
-				     unsigned demux_sink_pads)
+				     unsigned int demux_sink_pads)
 {
 #if defined(CONFIG_MEDIA_CONTROLLER_DVB)
 	struct media_link *link;
@@ -462,7 +457,8 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 
 	mutex_lock(&dvbdev_register_lock);
 
-	if ((id = dvbdev_get_free_id (adap, type)) < 0) {
+	id = dvbdev_get_free_id(adap, type);
+	if (id < 0) {
 		mutex_unlock(&dvbdev_register_lock);
 		*pdvbdev = NULL;
 		pr_err("%s: couldn't find free device id\n", __func__);
@@ -470,7 +466,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	}
 
 	*pdvbdev = dvbdev = kzalloc(sizeof(*dvbdev), GFP_KERNEL);
-	if (!dvbdev){
+	if (!dvbdev) {
 		mutex_unlock(&dvbdev_register_lock);
 		return -ENOMEM;
 	}
@@ -482,14 +478,13 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	 */
 	list_for_each_entry(node, &dvbdevfops_list, list_head) {
 		if (node->fops->owner == adap->module &&
-				node->type == type &&
-				node->template == template) {
+		    node->type == type && node->template == template) {
 			dvbdevfops = node->fops;
 			break;
 		}
 	}
 
-	if (dvbdevfops == NULL) {
+	if (!dvbdevfops) {
 		dvbdevfops = kmemdup(template->fops, sizeof(*dvbdevfops), GFP_KERNEL);
 		if (!dvbdevfops) {
 			kfree(dvbdev);
@@ -497,7 +492,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 			return -ENOMEM;
 		}
 
-		new_node = kzalloc(sizeof(struct dvbdevfops_node), GFP_KERNEL);
+		new_node = kzalloc(sizeof(*new_node), GFP_KERNEL);
 		if (!new_node) {
 			kfree(dvbdevfops);
 			kfree(dvbdev);
@@ -508,7 +503,7 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		new_node->fops = dvbdevfops;
 		new_node->type = type;
 		new_node->template = template;
-		list_add_tail (&new_node->list_head, &dvbdevfops_list);
+		list_add_tail(&new_node->list_head, &dvbdevfops_list);
 	}
 
 	memcpy(dvbdev, template, sizeof(struct dvb_device));
@@ -518,21 +513,21 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	dvbdev->adapter = adap;
 	dvbdev->priv = priv;
 	dvbdev->fops = dvbdevfops;
-	init_waitqueue_head (&dvbdev->wait_queue);
+	init_waitqueue_head(&dvbdev->wait_queue);
 	dvbdevfops->owner = adap->module;
-	list_add_tail (&dvbdev->list_head, &adap->device_list);
+	list_add_tail(&dvbdev->list_head, &adap->device_list);
 	down_write(&minor_rwsem);
 #ifdef CONFIG_DVB_DYNAMIC_MINORS
 	for (minor = 0; minor < MAX_DVB_MINORS; minor++)
-		if (dvb_minors[minor] == NULL)
+		if (!dvb_minors[minor])
 			break;
 	if (minor == MAX_DVB_MINORS) {
 		if (new_node) {
-			list_del (&new_node->list_head);
+			list_del(&new_node->list_head);
 			kfree(dvbdevfops);
 			kfree(new_node);
 		}
-		list_del (&dvbdev->list_head);
+		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 		up_write(&minor_rwsem);
 		mutex_unlock(&dvbdev_register_lock);
@@ -547,14 +542,14 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 	ret = dvb_register_media_device(dvbdev, type, minor, demux_sink_pads);
 	if (ret) {
 		pr_err("%s: dvb_register_media_device failed to create the mediagraph\n",
-		      __func__);
+		       __func__);
 		if (new_node) {
-			list_del (&new_node->list_head);
+			list_del(&new_node->list_head);
 			kfree(dvbdevfops);
 			kfree(new_node);
 		}
 		dvb_media_device_free(dvbdev);
-		list_del (&dvbdev->list_head);
+		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
 		return ret;
@@ -567,12 +562,12 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 		pr_err("%s: failed to create device dvb%d.%s%d (%ld)\n",
 		       __func__, adap->num, dnames[type], id, PTR_ERR(clsdev));
 		if (new_node) {
-			list_del (&new_node->list_head);
+			list_del(&new_node->list_head);
 			kfree(dvbdevfops);
 			kfree(new_node);
 		}
 		dvb_media_device_free(dvbdev);
-		list_del (&dvbdev->list_head);
+		list_del(&dvbdev->list_head);
 		kfree(dvbdev);
 		mutex_unlock(&dvbdev_register_lock);
 		return PTR_ERR(clsdev);
@@ -586,7 +581,6 @@ int dvb_register_device(struct dvb_adapter *adap, struct dvb_device **pdvbdev,
 }
 EXPORT_SYMBOL(dvb_register_device);
 
-
 void dvb_remove_device(struct dvb_device *dvbdev)
 {
 	if (!dvbdev)
@@ -601,19 +595,17 @@ void dvb_remove_device(struct dvb_device *dvbdev)
 
 	device_destroy(dvb_class, MKDEV(DVB_MAJOR, dvbdev->minor));
 
-	list_del (&dvbdev->list_head);
+	list_del(&dvbdev->list_head);
 }
 EXPORT_SYMBOL(dvb_remove_device);
 
-
 static void dvb_free_device(struct kref *ref)
 {
 	struct dvb_device *dvbdev = container_of(ref, struct dvb_device, ref);
 
-	kfree (dvbdev);
+	kfree(dvbdev);
 }
 
-
 struct dvb_device *dvb_device_get(struct dvb_device *dvbdev)
 {
 	kref_get(&dvbdev->ref);
@@ -621,14 +613,12 @@ struct dvb_device *dvb_device_get(struct dvb_device *dvbdev)
 }
 EXPORT_SYMBOL(dvb_device_get);
 
-
 void dvb_device_put(struct dvb_device *dvbdev)
 {
 	if (dvbdev)
 		kref_put(&dvbdev->ref, dvb_free_device);
 }
 
-
 void dvb_unregister_device(struct dvb_device *dvbdev)
 {
 	dvb_remove_device(dvbdev);
@@ -636,7 +626,6 @@ void dvb_unregister_device(struct dvb_device *dvbdev)
 }
 EXPORT_SYMBOL(dvb_unregister_device);
 
-
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB
 
 static int dvb_create_io_intf_links(struct dvb_adapter *adap,
@@ -669,9 +658,9 @@ int dvb_create_media_graph(struct dvb_adapter *adap,
 	struct media_entity *demux = NULL, *ca = NULL;
 	struct media_link *link;
 	struct media_interface *intf;
-	unsigned demux_pad = 0;
-	unsigned dvr_pad = 0;
-	unsigned ntuner = 0, ndemod = 0;
+	unsigned int demux_pad = 0;
+	unsigned int dvr_pad = 0;
+	unsigned int ntuner = 0, ndemod = 0;
 	int ret, pad_source, pad_sink;
 	static const char *connector_name = "Television";
 
@@ -795,18 +784,18 @@ int dvb_create_media_graph(struct dvb_adapter *adap,
 		media_device_for_each_entity(entity, mdev) {
 			if (entity->function == MEDIA_ENT_F_IO_DTV) {
 				if (!strncmp(entity->name, DVR_TSOUT,
-				    strlen(DVR_TSOUT))) {
+					     strlen(DVR_TSOUT))) {
 					ret = media_create_pad_link(demux,
-								++dvr_pad,
-							    entity, 0, 0);
+								    ++dvr_pad,
+								    entity, 0, 0);
 					if (ret)
 						return ret;
 				}
 				if (!strncmp(entity->name, DEMUX_TSOUT,
-				    strlen(DEMUX_TSOUT))) {
+					     strlen(DEMUX_TSOUT))) {
 					ret = media_create_pad_link(demux,
-							      ++demux_pad,
-							    entity, 0, 0);
+								    ++demux_pad,
+								    entity, 0, 0);
 					if (ret)
 						return ret;
 				}
@@ -864,8 +853,10 @@ EXPORT_SYMBOL_GPL(dvb_create_media_graph);
 static int dvbdev_check_free_adapter_num(int num)
 {
 	struct list_head *entry;
+
 	list_for_each(entry, &dvb_adapter_list) {
 		struct dvb_adapter *adap;
+
 		adap = list_entry(entry, struct dvb_adapter, list_head);
 		if (adap->num == num)
 			return 0;
@@ -873,7 +864,7 @@ static int dvbdev_check_free_adapter_num(int num)
 	return 1;
 }
 
-static int dvbdev_get_free_adapter_num (void)
+static int dvbdev_get_free_adapter_num(void)
 {
 	int num = 0;
 
@@ -886,7 +877,6 @@ static int dvbdev_get_free_adapter_num (void)
 	return -ENFILE;
 }
 
-
 int dvb_register_adapter(struct dvb_adapter *adap, const char *name,
 			 struct module *module, struct device *device,
 			 short *adapter_nums)
@@ -913,8 +903,8 @@ int dvb_register_adapter(struct dvb_adapter *adap, const char *name,
 		return -ENFILE;
 	}
 
-	memset (adap, 0, sizeof(struct dvb_adapter));
-	INIT_LIST_HEAD (&adap->device_list);
+	memset(adap, 0, sizeof(struct dvb_adapter));
+	INIT_LIST_HEAD(&adap->device_list);
 
 	pr_info("DVB: registering new adapter (%s)\n", name);
 
@@ -924,13 +914,13 @@ int dvb_register_adapter(struct dvb_adapter *adap, const char *name,
 	adap->device = device;
 	adap->mfe_shared = 0;
 	adap->mfe_dvbdev = NULL;
-	mutex_init (&adap->mfe_lock);
+	mutex_init(&adap->mfe_lock);
 
 #ifdef CONFIG_MEDIA_CONTROLLER_DVB
 	mutex_init(&adap->mdev_lock);
 #endif
 
-	list_add_tail (&adap->list_head, &dvb_adapter_list);
+	list_add_tail(&adap->list_head, &dvb_adapter_list);
 
 	mutex_unlock(&dvbdev_register_lock);
 
@@ -938,25 +928,26 @@ int dvb_register_adapter(struct dvb_adapter *adap, const char *name,
 }
 EXPORT_SYMBOL(dvb_register_adapter);
 
-
 int dvb_unregister_adapter(struct dvb_adapter *adap)
 {
 	mutex_lock(&dvbdev_register_lock);
-	list_del (&adap->list_head);
+	list_del(&adap->list_head);
 	mutex_unlock(&dvbdev_register_lock);
 	return 0;
 }
 EXPORT_SYMBOL(dvb_unregister_adapter);
 
-/* if the miracle happens and "generic_usercopy()" is included into
-   the kernel, then this can vanish. please don't make the mistake and
-   define this as video_usercopy(). this will introduce a dependency
-   to the v4l "videodev.o" module, which is unnecessary for some
-   cards (ie. the budget dvb-cards don't need the v4l module...) */
+/*
+ * if the miracle happens and "generic_usercopy()" is included into
+ * the kernel, then this can vanish. please don't make the mistake and
+ * define this as video_usercopy(). this will introduce a dependency
+ * to the v4l "videodev.o" module, which is unnecessary for some
+ * cards (ie. the budget dvb-cards don't need the v4l module...)
+ */
 int dvb_usercopy(struct file *file,
-		     unsigned int cmd, unsigned long arg,
-		     int (*func)(struct file *file,
-		     unsigned int cmd, void *arg))
+		 unsigned int cmd, unsigned long arg,
+		 int (*func)(struct file *file,
+			     unsigned int cmd, void *arg))
 {
 	char    sbuf[128];
 	void    *mbuf = NULL;
@@ -970,7 +961,7 @@ int dvb_usercopy(struct file *file,
 		 * For this command, the pointer is actually an integer
 		 * argument.
 		 */
-		parg = (void *) arg;
+		parg = (void *)arg;
 		break;
 	case _IOC_READ: /* some v4l ioctls are marked wrong ... */
 	case _IOC_WRITE:
@@ -980,7 +971,7 @@ int dvb_usercopy(struct file *file,
 		} else {
 			/* too big to allocate from stack */
 			mbuf = kmalloc(_IOC_SIZE(cmd), GFP_KERNEL);
-			if (NULL == mbuf)
+			if (!mbuf)
 				return -ENOMEM;
 			parg = mbuf;
 		}
@@ -992,15 +983,15 @@ int dvb_usercopy(struct file *file,
 	}
 
 	/* call driver */
-	if ((err = func(file, cmd, parg)) == -ENOIOCTLCMD)
+	err = func(file, cmd, parg);
+	if (err == -ENOIOCTLCMD)
 		err = -ENOTTY;
 
 	if (err < 0)
 		goto out;
 
 	/*  Copy results into user buffer  */
-	switch (_IOC_DIR(cmd))
-	{
+	switch (_IOC_DIR(cmd)) {
 	case _IOC_READ:
 	case (_IOC_WRITE | _IOC_READ):
 		if (copy_to_user((void __user *)arg, parg, _IOC_SIZE(cmd)))
@@ -1080,19 +1071,20 @@ static char *dvb_devnode(const struct device *dev, umode_t *mode)
 		dvbdev->adapter->num, dnames[dvbdev->type], dvbdev->id);
 }
 
-
 static int __init init_dvbdev(void)
 {
 	int retval;
 	dev_t dev = MKDEV(DVB_MAJOR, 0);
 
-	if ((retval = register_chrdev_region(dev, MAX_DVB_MINORS, "DVB")) != 0) {
+	retval = register_chrdev_region(dev, MAX_DVB_MINORS, "DVB");
+	if (retval != 0) {
 		pr_err("dvb-core: unable to get major %d\n", DVB_MAJOR);
 		return retval;
 	}
 
 	cdev_init(&dvb_device_cdev, &dvb_device_fops);
-	if ((retval = cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS)) != 0) {
+	retval = cdev_add(&dvb_device_cdev, dev, MAX_DVB_MINORS);
+	if (retval != 0) {
 		pr_err("dvb-core: unable register character device\n");
 		goto error;
 	}
@@ -1112,7 +1104,6 @@ static int __init init_dvbdev(void)
 	return retval;
 }
 
-
 static void __exit exit_dvbdev(void)
 {
 	struct dvbdevfops_node *node, *next;
@@ -1122,7 +1113,7 @@ static void __exit exit_dvbdev(void)
 	unregister_chrdev_region(MKDEV(DVB_MAJOR, 0), MAX_DVB_MINORS);
 
 	list_for_each_entry_safe(node, next, &dvbdevfops_list, list_head) {
-		list_del (&node->list_head);
+		list_del(&node->list_head);
 		kfree(node->fops);
 		kfree(node);
 	}
-- 
2.40.1


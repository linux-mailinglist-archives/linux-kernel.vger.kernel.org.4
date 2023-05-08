Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D628E6FAF9F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjEHMF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjEHMF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:05:56 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DD4194;
        Mon,  8 May 2023 05:05:55 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3489SlcP019527;
        Mon, 8 May 2023 12:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=6VbeoaEHTf+/Tf6Sb7yh4HGI0xkMXwbsdJJeo/xVGCQ=;
 b=Vm+na5tOaIzrvvSiBpViQkXTdkN4ctZJdzJctlvokeopRTNb17Z9EdprlzV0j8OriC0t
 GwG6r3DiGK8HLZojVj9JAYhCJULiR51stdl89FnseAC8NO+cM0P5hd+KozMd1v/npJ1f
 DvJseZp6SOhKBfk6ULRgexiDIFtAxseEnY253EqKdIB8rT8kU3XDKG8idgy+i2YkvII7
 WjH9oOjLrr26ozofLJMnUSfCigmyWJucYfIGw8bh0OnM0dPaeEp3YPvmFvD6vgta8kKo
 /pNFyx6NW+VH9kogOZD4St5vUGOswSopvu0k/H793sfyiaE4o1s1kM8cAGL1aBv0Tj9m 8Q== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qexf4g9jp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 12:05:50 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 348C5nUM003593
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 8 May 2023 12:05:49 GMT
Received: from hu-akakum-hyd.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 05:05:46 -0700
From:   AKASH KUMAR <quic_akakum@quicinc.com>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jing Leng <jleng@ambarella.com>
CC:     =?UTF-8?q?Pratham=20Pratap=C2=A0?= <quic_ppratap@quicinc.com>,
        Jack Pham <quic_jackp@quicinc.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        AKASH KUMAR <quic_akakum@quicinc.com>
Subject: [PATCH] usb: gadget: f_uac2: uevent changes for uac2
Date:   Mon, 8 May 2023 17:35:35 +0530
Message-ID: <20230508120535.31472-1-quic_akakum@quicinc.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZtDn_lrT1UgBjE_btB7nAnmDfv210-xa
X-Proofpoint-GUID: ZtDn_lrT1UgBjE_btB7nAnmDfv210-xa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_08,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 clxscore=1011 lowpriorityscore=0 mlxlogscore=925 priorityscore=1501
 impostorscore=0 spamscore=0 mlxscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080082
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding uvent from usb audio gadget driver for
uac2 playback/capture events, which userspace reads
and later reads sysfs entry to know if playback
or capture has stopped or started by host
application.

/config/usb_gadget/g1/functions/uac2.0 # cat c_status
1  --> capture started
0  --> capture stopped
/config/usb_gadget/g1/functions/uac2.0 # cat p_status
1 --> playback started
0 --> playback stopped

Signed-off-by: AKASH KUMAR <quic_akakum@quicinc.com>
---
 drivers/usb/gadget/function/f_uac2.c | 57 ++++++++++++++++++++++++++++
 drivers/usb/gadget/function/u_uac2.h |  7 ++++
 2 files changed, 64 insertions(+)

diff --git a/drivers/usb/gadget/function/f_uac2.c b/drivers/usb/gadget/function/f_uac2.c
index 0219cd79493a..d0a5fa6b49b8 100644
--- a/drivers/usb/gadget/function/f_uac2.c
+++ b/drivers/usb/gadget/function/f_uac2.c
@@ -1423,6 +1423,8 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 	struct usb_gadget *gadget = cdev->gadget;
 	struct device *dev = &gadget->dev;
 	int ret = 0;
+	struct f_uac2_opts *audio_opts =
+		container_of(fn->fi, struct f_uac2_opts, func_inst);
 
 	/* No i/f has more than 2 alt settings */
 	if (alt > 1) {
@@ -1454,6 +1456,7 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 			ret = u_audio_start_capture(&uac2->g_audio);
 		else
 			u_audio_stop_capture(&uac2->g_audio);
+		audio_opts->c_status = alt;
 	} else if (intf == uac2->as_in_intf) {
 		uac2->as_in_alt = alt;
 
@@ -1461,10 +1464,14 @@ afunc_set_alt(struct usb_function *fn, unsigned intf, unsigned alt)
 			ret = u_audio_start_playback(&uac2->g_audio);
 		else
 			u_audio_stop_playback(&uac2->g_audio);
+		audio_opts->p_status = alt;
 	} else {
 		dev_err(dev, "%s:%d Error!\n", __func__, __LINE__);
 		return -EINVAL;
 	}
+#ifdef CONFIG_USB_CONFIGFS_UEVENT
+	schedule_work(&audio_opts->work);
+#endif
 
 	return ret;
 }
@@ -1493,9 +1500,17 @@ static void
 afunc_disable(struct usb_function *fn)
 {
 	struct f_uac2 *uac2 = func_to_uac2(fn);
+	struct f_uac2_opts *audio_opts =
+		container_of(fn->fi, struct f_uac2_opts, func_inst);
 
 	uac2->as_in_alt = 0;
 	uac2->as_out_alt = 0;
+	audio_opts->p_status = 0;//alt;
+	audio_opts->c_status = 0; //alt;
+
+#ifdef CONFIG_USB_CONFIGFS_UEVENT
+	schedule_work(&audio_opts->work);
+#endif
 	u_audio_stop_capture(&uac2->g_audio);
 	u_audio_stop_playback(&uac2->g_audio);
 	if (uac2->int_ep)
@@ -2095,6 +2110,25 @@ UAC2_ATTRIBUTE(s16, c_volume_res);
 UAC2_ATTRIBUTE(u32, fb_max);
 UAC2_ATTRIBUTE_STRING(function_name);
 
+#define UAC2_ATTRIBUTE_RO(name)                                         \
+	static ssize_t f_uac2_opts_##name##_show(                       \
+			struct config_item *item,                       \
+			char *page)                                     \
+{                                                                       \
+	struct f_uac2_opts *opts = to_f_uac2_opts(item);                \
+	int result;                                                     \
+	\
+	mutex_lock(&opts->lock);                                        \
+	result = scnprintf(page, PAGE_SIZE, "%u\n", opts->name);        \
+	mutex_unlock(&opts->lock);                                      \
+	\
+	return result;                                                  \
+}                                                                       \
+CONFIGFS_ATTR_RO(f_uac2_opts_, name)
+
+UAC2_ATTRIBUTE_RO(c_status);
+UAC2_ATTRIBUTE_RO(p_status);
+
 static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_p_chmask,
 	&f_uac2_opts_attr_p_srate,
@@ -2119,6 +2153,8 @@ static struct configfs_attribute *f_uac2_attrs[] = {
 	&f_uac2_opts_attr_c_volume_min,
 	&f_uac2_opts_attr_c_volume_max,
 	&f_uac2_opts_attr_c_volume_res,
+	&f_uac2_opts_attr_c_status,
+	&f_uac2_opts_attr_p_status,
 
 	&f_uac2_opts_attr_function_name,
 
@@ -2136,9 +2172,26 @@ static void afunc_free_inst(struct usb_function_instance *f)
 	struct f_uac2_opts *opts;
 
 	opts = container_of(f, struct f_uac2_opts, func_inst);
+#ifdef CONFIG_USB_CONFIGFS_UEVENT
+	device_destroy(opts->device->class, opts->device->devt);
+	cancel_work_sync(&opts->work);
+#endif
 	kfree(opts);
 }
 
+#ifdef CONFIG_USB_CONFIGFS_UEVENT
+static void f_uac2_audio_status_change_work(struct work_struct *data)
+{
+	struct f_uac2_opts *audio_opts =
+		container_of(data, struct f_uac2_opts, work);
+	char *envp[2] = { "UAC2_STATE=Changed", NULL };
+
+	kobject_uevent_env(&audio_opts->device->kobj,
+			KOBJ_CHANGE, envp);
+	pr_debug("%s:uac2 state changed\n", __func__);
+}
+#endif
+
 static struct usb_function_instance *afunc_alloc_inst(void)
 {
 	struct f_uac2_opts *opts;
@@ -2180,6 +2233,10 @@ static struct usb_function_instance *afunc_alloc_inst(void)
 
 	snprintf(opts->function_name, sizeof(opts->function_name), "Source/Sink");
 
+#ifdef CONFIG_USB_CONFIGFS_UEVENT
+	INIT_WORK(&opts->work, f_uac2_audio_status_change_work);
+	opts->device = create_function_device("f_uac2");
+#endif
 	return &opts->func_inst;
 }
 
diff --git a/drivers/usb/gadget/function/u_uac2.h b/drivers/usb/gadget/function/u_uac2.h
index 0510c9bad58d..e05536c13c45 100644
--- a/drivers/usb/gadget/function/u_uac2.h
+++ b/drivers/usb/gadget/function/u_uac2.h
@@ -67,6 +67,13 @@ struct f_uac2_opts {
 
 	struct mutex			lock;
 	int				refcnt;
+	u8				c_status;
+	u8				p_status;
+	struct device                   *device;
+#ifdef CONFIG_USB_CONFIGFS_UEVENT
+	struct work_struct              work;
+#endif
 };
 
+extern struct device *create_function_device(char *name);
 #endif
-- 
2.17.1


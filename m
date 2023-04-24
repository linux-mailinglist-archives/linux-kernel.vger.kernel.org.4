Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7736F6ED7F1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjDXWam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232852AbjDXWaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:30:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D65E658F;
        Mon, 24 Apr 2023 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1682375395; i=w_armin@gmx.de;
        bh=2YrIKDNZDkQHrEt9bRGYeH12nvZWn7b5Z+NCxkBIups=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y8MLpEy65VYfq7tJD26XILAj2ooR+iEf6vms8AcH7yCanT/BGqeYrAEhDnCgbObCQ
         BQ/w6Zv8kwWocqM/PNPezHO0MVTsKuOfhizGWIqeS53hEMuO4YZEDFbDlsO1bZ8ftc
         Q3cecka58FaUz3BaKSayItE1g+oTs2rPDPgWUv4CJVCh/Td8GgT0VUV/G1DCoVn/92
         lrqKnSm75QMp79WxfbP4jizs6wJO1MftCF49g5JIg800gACnMDHew6caNqAwfNSEuR
         FqE/lP245pPbItK/933lshLUSRsrcOIgg26KfZJGqKoTAX7ZgaO1t1sTChGcShZFON
         4O5A1Rua1EFcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MmUHp-1qYy9K2sK1-00iRsO; Tue, 25 Apr 2023 00:29:55 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org, rdunlap@infradead.org
Cc:     corbet@lwn.net, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/4] platform/x86: wmi: Mark GUID-based WMI interface as deprecated
Date:   Tue, 25 Apr 2023 00:29:37 +0200
Message-Id: <20230424222939.208137-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230424222939.208137-1-W_Armin@gmx.de>
References: <20230424222939.208137-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Jv/gn/iU8iEbpWse970NO/spdEVRZL10JicOLpQBqcvKIijc9Dx
 uv0uQRB9fGbgisoAzqPYb/CCkEN1jbD1i0jIRfndxARu1dSC9zKrgZXc6Ev8B8h965h4A7u
 ZPTAJgiRXn/qwfMR4EKJuEQ22zcjF6QwIHyKQEYzIgSFWmi/ejwFlT1i1QHJlXsHte++0bA
 KvWQQ/miINcZhreBQznbQ==
UI-OutboundReport: notjunk:1;M01:P0:V+2ge/4u46E=;ChSDFo4TkbFqe38HJ5v/yOKkux1
 /d69AaXtveGKrxfO1XtVnmjNlyDeQgNyGMyjhtDHkakhR1Fio1JR6ZHS70KI4xcUNGsGv40rq
 S0Y9jzzyXXRrnbZAN5utwIrQPW/JJ73AsYrLYAXRuxv6gKLRx56cDWyXiulmBeRUDikC5I+Mn
 yoiJs1dt0P0xwlZSuLCKCi8LUHMHeyuJcZx8Xc2WA4oknsqCC4axW9uECqCSjh19ajezg2JmW
 GhIbN7SepvwFLkgs3LLc59awj50/b883Q5G2TggWhJB49O69N//cKXfO4zyedzUROthIzsGVv
 +ycP32O98E5qBUw/1EOswVWhkAw1FhXE4YIqJVbDUCn026W5yX6dhuWt3mYK5tCmeATAIlVRR
 A26XS8WJuc7mSM7VRHnDiRaCw/qMjamSXO2mhVNU56GtNEzNnWWn+2TkEAlivN4zdoqnpo713
 9y5oejNXcodPmiSOICTG4Vldfok4P324mi5WduTWFtOh/FYC7y+olCboDujWzkr/4QreLWmyH
 9S1nxJVieaQppjo1focMMRUOO/eJ2B8ZoRGXc6iirAWtXArDwRTAKk8EVYAVpLODqhDVAYijd
 hHPmUJ+cA8CeIlbLDGqgUPgbcOWYc88RhUN1MN1WnuyHDHQXzhaziHDRQM+Cwu40qxMxoayoD
 rIfaaLgp5v8x82CxOyfTp8LPGyO0aCR/Gt5/itF6ahVs+WPtP+U9g8LjH0Achgt6dx+xdtWDt
 9qTWcCN5ZPgw/1Nb4bFQd2XPtAjG2/V6zThGRlRCabrJg6v4leIbQFXuWXyAbU85GGkqrYs+N
 r7kCFA0IuoxjMNjt0FaDwz2gw5M/Gb2hYTWD8gZWq/1jAYW1INdyIJObK16JnPpUVv7iaseNc
 pmaBiCyhGwUX1t5vurzViUhyAn2XVwFte2qXjij9uVHsZIV3AUoxwW8e19Mv0Rs6bdcaxu6h2
 H60NdsB1G5C2tuShg0SRSg42uig=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WMI driver core supports a more mordern bus-based interface for
interacting with WMI devices. The older GUID-based interface depends
on each WMI GUID and notification id being unique on a given system,
which turned out is not the case.
Mark the older interface as deprecated since new WMI drivers should
use the bus-based interface to avoid this issues.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/wmi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 99af2cc03b0f..c226dd4163a1 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -264,7 +264,7 @@ int set_required_buffer_size(struct wmi_device *wdev, =
u64 length)
 EXPORT_SYMBOL_GPL(set_required_buffer_size);

 /**
- * wmi_evaluate_method - Evaluate a WMI method
+ * wmi_evaluate_method - Evaluate a WMI method (deprecated)
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
  * @instance: Instance index
  * @method_id: Method ID to call
@@ -457,7 +457,7 @@ union acpi_object *wmidev_block_query(struct wmi_devic=
e *wdev, u8 instance)
 EXPORT_SYMBOL_GPL(wmidev_block_query);

 /**
- * wmi_set_block - Write to a WMI block
+ * wmi_set_block - Write to a WMI block (deprecated)
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
  * @instance: Instance index
  * @in: Buffer containing new values for the data block
@@ -568,7 +568,7 @@ static void wmi_notify_debug(u32 value, void *context)
 }

 /**
- * wmi_install_notify_handler - Register handler for WMI events
+ * wmi_install_notify_handler - Register handler for WMI events (deprecat=
ed)
  * @guid: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
  * @handler: Function to handle notifications
  * @data: Data to be returned to handler when event is fired
@@ -614,7 +614,7 @@ acpi_status wmi_install_notify_handler(const char *gui=
d,
 EXPORT_SYMBOL_GPL(wmi_install_notify_handler);

 /**
- * wmi_remove_notify_handler - Unregister handler for WMI events
+ * wmi_remove_notify_handler - Unregister handler for WMI events (depreca=
ted)
  * @guid: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417f2f49ba
  *
  * Unregister handler for events sent to the ACPI-WMI mapper device.
@@ -661,7 +661,7 @@ acpi_status wmi_remove_notify_handler(const char *guid=
)
 EXPORT_SYMBOL_GPL(wmi_remove_notify_handler);

 /**
- * wmi_get_event_data - Get WMI data associated with an event
+ * wmi_get_event_data - Get WMI data associated with an event (deprecated=
)
  *
  * @event: Event to find
  * @out: Buffer to hold event data
@@ -700,7 +700,7 @@ bool wmi_has_guid(const char *guid_string)
 EXPORT_SYMBOL_GPL(wmi_has_guid);

 /**
- * wmi_get_acpi_device_uid() - Get _UID name of ACPI device that defines =
GUID
+ * wmi_get_acpi_device_uid() - Get _UID name of ACPI device that defines =
GUID (deprecated)
  * @guid_string: 36 char string of the form fa50ff2b-f2e8-45de-83fa-65417=
f2f49ba
  *
  * Find the _UID of ACPI device associated with this WMI GUID.
=2D-
2.30.2


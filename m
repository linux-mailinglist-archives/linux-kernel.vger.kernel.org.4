Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDBAE71296C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243949AbjEZP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243699AbjEZP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:26:51 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CAF1A8;
        Fri, 26 May 2023 08:26:29 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34QCOWeQ024951;
        Fri, 26 May 2023 15:25:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=content-type :
 message-id : date : mime-version : subject : to : cc : references : from :
 in-reply-to; s=qcppdkim1; bh=kaJdD29DyBEj0bSAMl67bvhcToCuaSvohNBa7tPzZQo=;
 b=kyAdmhA8aYHi9Su1VFKJNj6QQVY75gu+1E4LmIfJ/uu891rcf0HzqG+IZUg8E9QNpCwV
 05xemV5KGXc131gCib5VEr/TpMA7g28uncfWiG0uuZbp6d0znml5qZ6j1dkRtEVE5Nvn
 ikF0wZ+SAOXuAI0hLHWf/+Gf9myt6P2xRG1eONY0xb/dXRAZfAmRGQBBsA4hIMZkauY6
 2iMJbW5A9oMVCZIyT47dhA/bH3xvAJ9QBGNEA7eG2r31TnEjgMLaeW9oyQqxeCp3y2KU
 OIWUjUc2vftLcZgYo4YhRDlDlBQm1P+3+7rBhYSeX45PpDLW0dzYO3bOJXwQNQwnXqD1 Sw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qtp4wh9ke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:25:33 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 34QFPWnA017881
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 26 May 2023 15:25:32 GMT
Received: from [10.216.28.33] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Fri, 26 May
 2023 08:25:25 -0700
Content-Type: multipart/mixed;
        boundary="------------sA1M5es0yBbNuw0q3fFaTOni"
Message-ID: <37fd026e-ecb1-3584-19f3-f8c1e5a9d20a@quicinc.com>
Date:   Fri, 26 May 2023 20:55:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.1
Subject: Re: [PATCH v8 6/9] usb: dwc3: qcom: Add multiport controller support
 for qcom wrapper
To:     Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan@kernel.org>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Andy Gross" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_ppratap@quicinc.com>, <quic_wcheng@quicinc.com>,
        <quic_jackp@quicinc.com>, <quic_harshq@quicinc.com>,
        <ahalaney@redhat.com>
References: <20230514054917.21318-1-quic_kriskura@quicinc.com>
 <20230514054917.21318-7-quic_kriskura@quicinc.com>
 <20230515222730.7snn2i33gkg6ctd2@ripper>
 <20230526025554.ni527gsr2bqxadl3@ripper>
Content-Language: en-US
From:   Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
In-Reply-To: <20230526025554.ni527gsr2bqxadl3@ripper>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: fZLGWlJHhOvOedVoz7anpXDxDg-jvrVt
X-Proofpoint-ORIG-GUID: fZLGWlJHhOvOedVoz7anpXDxDg-jvrVt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-26_05,2023-05-25_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 phishscore=0 adultscore=0 clxscore=1015 suspectscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2304280000 definitions=main-2305260129
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--------------sA1M5es0yBbNuw0q3fFaTOni
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/2023 8:25 AM, Bjorn Andersson wrote:
>>> +
>>>   static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, u32 val)
>>>   {
>>>   	u32 reg;
>>> @@ -413,13 +423,16 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, bool wakeup)
>>>   {
>>>   	u32 val;
>>>   	int i, ret;
>>> +	struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
>>>   
>>>   	if (qcom->is_suspended)
>>>   		return 0;
>>>   
>>> -	val = readl(qcom->qscratch_base + PWR_EVNT_IRQ_STAT_REG);
>>> -	if (!(val & PWR_EVNT_LPM_IN_L2_MASK))
>>> -		dev_err(qcom->dev, "HS-PHY not in L2\n");
>>> +	for (i = 0; i < dwc->num_usb2_ports; i++) {
>>
>> In the event that the dwc3 core fails to acquire or enable e.g. clocks
>> its drvdata will be NULL. If you then hit a runtime pm transition in the
>> dwc3-qcom glue you will dereference NULL here. (You can force this issue
>> by e.g. returning -EINVAL from dwc3_clk_enable()).
>>
> 
> I looked at this once more, and realized that I missed the fact that
> dwc3_qcom_is_host() will happily dereference the drvdata() just a few
> lines further down...
> 
> So this is already broken.
> 
>> So if you're peaking into qcom->dwc3 you need to handle the fact that
>> dwc might be NULL, here and in resume below.
>>
> 
> We need to fix the dwc3 glue design, so that the glue and the core can
> cooperate - and we have a few other use cases where this is needed (e.g.
> usb_role_switch propagation to the glue code).
> 
Hi Bjorn, Johan,

   Thanks for the comments on this patch. I had some suggestions come in 
from the team internally:

1. To use the notifier call available in drivers/usb/core/notify.c and 
make sure that host mode is enabled. That way we can access dwc or xhci 
without any issue.

2. For this particular case where we are trying to get info on number of 
ports present (dwc->num_usb2_ports), we can add compatible data for 
sc8280-mp and provide input to driver telling num ports is 4.

For the first idea, I tried it out as follows:

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 959fc925ca7c..ce2f867d7c9a 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -91,6 +91,9 @@ struct dwc3_qcom {
         bool                    pm_suspended;
         struct icc_path         *icc_path_ddr;
         struct icc_path         *icc_path_apps;
+
+       bool                    in_host_mode;
+       struct notifier_block   xhci_nb;
  };

  static inline void dwc3_qcom_setbits(void __iomem *base, u32 offset, 
u32 val)
@@ -305,14 +308,6 @@ static void dwc3_qcom_interconnect_exit(struct 
dwc3_qcom *qcom)
         icc_put(qcom->icc_path_apps);
  }

-/* Only usable in contexts where the role can not change. */
-static bool dwc3_qcom_is_host(struct dwc3_qcom *qcom)
-{
-       struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
-
-       return dwc->xhci;
-}
-
  static enum usb_device_speed dwc3_qcom_read_usb2_speed(struct 
dwc3_qcom *qcom)
  {
         struct dwc3 *dwc = platform_get_drvdata(qcom->dwc3);
@@ -432,7 +427,7 @@ static int dwc3_qcom_suspend(struct dwc3_qcom *qcom, 
bool wakeup)
          * The role is stable during suspend as role switching is done 
from a
          * freezable workqueue.
          */
-       if (dwc3_qcom_is_host(qcom) && wakeup) {
+       if (qcom->in_host_mode && wakeup) {
                 qcom->usb2_speed = dwc3_qcom_read_usb2_speed(qcom);
                 dwc3_qcom_enable_interrupts(qcom);
         }
@@ -450,7 +445,7 @@ static int dwc3_qcom_resume(struct dwc3_qcom *qcom, 
bool wakeup)
         if (!qcom->is_suspended)
                 return 0;

-       if (dwc3_qcom_is_host(qcom) && wakeup)
+       if (qcom->in_host_mode && wakeup)
                 dwc3_qcom_disable_interrupts(qcom);

         for (i = 0; i < qcom->num_clocks; i++) {
@@ -488,7 +483,7 @@ static irqreturn_t qcom_dwc3_resume_irq(int irq, 
void *data)
          * This is safe as role switching is done from a freezable 
workqueue
          * and the wakeup interrupts are disabled as part of resume.
          */
-       if (dwc3_qcom_is_host(qcom))
+       if (qcom->in_host_mode)
                 pm_runtime_resume(&dwc->xhci->dev);

         return IRQ_HANDLED;
@@ -785,6 +780,41 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
         return acpi_create_platform_device(adev, NULL);
  }

+static int dwc3_xhci_event_notifier(struct notifier_block *nb,
+                               unsigned long event, void *ptr)
+{
+       struct dwc3_qcom *qcom = container_of(nb, struct dwc3_qcom, 
xhci_nb);
+       struct usb_bus *ubus = ptr;
+       struct usb_hcd *hcd;
+
+       if (event != USB_BUS_ADD && event != USB_BUS_REMOVE)
+               return NOTIFY_DONE;
+
+       //TODO: Check whether event generated is for this qcom 
controller or not
+
+       hcd = bus_to_hcd(ubus);
+       if (event == USB_BUS_ADD) {
+               /*
+                * Assuming both usb2 and usb3 roothubs wil
+                * be registered, wait for shared hcd to be
+                * registered to ensure that we are in host mode
+                * completely.
+                */
+               if (!usb_hcd_is_primary_hcd(hcd))
+                       qcom->in_host_mode = true;
+       } else if (event == USB_BUS_REMOVE) {
+               /*
+                * While exiting host mode, primary hcd is
+                * removed at the end. Use it as indication
+                * that host stack has been removed successfully.
+                */
+               if (usb_hcd_is_primary_hcd(hcd))
+                       qcom->in_host_mode = false;
+       }
+
+       return 0;
+}
+
  static int dwc3_qcom_probe(struct platform_device *pdev)
  {
         struct device_node      *np = pdev->dev.of_node;
@@ -884,6 +914,9 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
         if (ignore_pipe_clk)
                 dwc3_qcom_select_utmi_clk(qcom);

+       qcom->xhci_nb.notifier_call = dwc3_xhci_event_notifier;
+       usb_register_notify(&qcom->xhci_nb);
+
         if (np)
                 ret = dwc3_qcom_of_register_core(pdev);
         else
@@ -923,6 +956,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
  interconnect_exit:
         dwc3_qcom_interconnect_exit(qcom);
  depopulate:
+       usb_unregister_notify(&qcom->xhci_nb);
         if (np)
                 of_platform_depopulate(&pdev->dev);


I tested the patch on sc7280 and see that wakeup from system suspend 
works fine:

[    3.807449] K: Before notify register
[    3.810774] K: After notify register
[    3.814006] K: calling dwc3_qcom_of_register_core
[    3.818467] dwc3 a600000.usb: Adding to iommu group 8
[    3.840031] K: before plat adde
[    3.849151] K: before add hcd
[    3.852219] xhci-hcd xhci-hcd.12.auto: xHCI Host Controller
[    3.857956] K: usb_notify_add_bus: Before notify add bus event: 3
[    3.866481] K: dwc3_xhci_event_notifier recevied event: 3
[    3.874007] K: dwc3_xhci_event_notifier: its a bus add/remove event
[    3.880451] K: dwc3_xhci_event_notifier hcd added
[    3.885301] K: in host mode: 0
[    3.888441] K: usb_notify_add_bus: After notify add bus
[    3.893815] xhci-hcd xhci-hcd.12.auto: new USB bus registered, 
assigned bus number 1
[    3.903799] xhci-hcd xhci-hcd.12.auto: hcc params 0x0230fe65 hci 
version 0x110 quirks 0x0000000000010010
[    3.913564] xhci-hcd xhci-hcd.12.auto: irq 214, io mem 0x0a600000
[    3.919938] K: after add hcd
[    3.922913] K: before add shared hcd
[    3.926589] xhci-hcd xhci-hcd.12.auto: xHCI Host Controller
[    3.932327] K: usb_notify_add_bus: Before notify add bus event: 3
[    3.940973] K: dwc3_xhci_event_notifier recevied event: 3
[    3.948492] K: dwc3_xhci_event_notifier: its a bus add/remove event
[    3.954936] K: dwc3_xhci_event_notifier hcd added
[    3.959770] K: dwc3_xhci_event_notifier: Its shared hcd
[    3.965143] K: in host mode: 1
[    3.968283] K: usb_notify_add_bus: After notify add bus
[    3.973675] xhci-hcd xhci-hcd.12.auto: new USB bus registered, 
assigned bus number 2
[    3.981645] xhci-hcd xhci-hcd.12.auto: Host supports USB 3.0 SuperSpeed
[    3.988537] usb usb1: New USB device found, idVendor=1d6b, 
idProduct=0002, bcdDevice= 5.15
[    3.997024] usb usb1: New USB device strings: Mfr=3, Product=2, 
SerialNumber=1
[    4.004438] usb usb1: Product: xHCI Host Controller
[    4.009459] usb usb1: Manufacturer: Linux 
5.15.90-25532-g92932f8e612f-dirty xhci-hcd
[    4.017420] usb usb1: SerialNumber: xhci-hcd.12.auto

.....


[   90.809188] Resume caused by IRQ 211, qcom_dwc3 DP_HS

Attached the patch file as well as in mail.
Let me know if this is a good enough way to fix the layering violations.

Regards,
Krishna,
--------------sA1M5es0yBbNuw0q3fFaTOni
Content-Type: text/plain; charset="UTF-8";
	name="0001-usb-dwc3-qcom-Cleanup-layering-violations-in-dwc3-qc.patch"
Content-Disposition: attachment;
	filename*0="0001-usb-dwc3-qcom-Cleanup-layering-violations-in-dwc3-qc.pa";
	filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzYTMxOGFiMzhjNDk1OWIyMWRmM2NjZTZiOTMzYjZkMGFiZTVlYjRiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBLcmlzaG5hIEt1cmFwYXRpIDxxdWljX2tyaXNrdXJh
QHF1aWNpbmMuY29tPgpEYXRlOiBGcmksIDI2IE1heSAyMDIzIDE1OjAzOjA3ICswNTMwClN1
YmplY3Q6IFtQQVRDSF0gdXNiOiBkd2MzOiBxY29tOiBDbGVhbnVwIGxheWVyaW5nIHZpb2xh
dGlvbnMgaW4gZHdjMyBxY29tCgpJbXBsZW1lbnQgaG9zdCBub3RpZmllciBpbiBxY29tIHRv
IHJlbW92ZSBsYXllcmluZyB2aW9sYXRpb25zCgpTaWduZWQtb2ZmLWJ5OiBLcmlzaG5hIEt1
cmFwYXRpIDxxdWljX2tyaXNrdXJhQHF1aWNpbmMuY29tPgotLS0KIGRyaXZlcnMvdXNiL2R3
YzMvZHdjMy1xY29tLmMgfCA1NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0KIDEgZmlsZSBjaGFuZ2VkLCA0NSBpbnNlcnRpb25zKCspLCAxMSBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2R3YzMtcWNvbS5jIGIvZHJpdmVycy91
c2IvZHdjMy9kd2MzLXFjb20uYwppbmRleCA5NTlmYzkyNWNhN2MuLmNlMmY4NjdkN2M5YSAx
MDA2NDQKLS0tIGEvZHJpdmVycy91c2IvZHdjMy9kd2MzLXFjb20uYworKysgYi9kcml2ZXJz
L3VzYi9kd2MzL2R3YzMtcWNvbS5jCkBAIC05MSw2ICs5MSw5IEBAIHN0cnVjdCBkd2MzX3Fj
b20gewogCWJvb2wJCQlwbV9zdXNwZW5kZWQ7CiAJc3RydWN0IGljY19wYXRoCQkqaWNjX3Bh
dGhfZGRyOwogCXN0cnVjdCBpY2NfcGF0aAkJKmljY19wYXRoX2FwcHM7CisKKwlib29sCQkJ
aW5faG9zdF9tb2RlOworCXN0cnVjdCBub3RpZmllcl9ibG9jawl4aGNpX25iOwogfTsKIAog
c3RhdGljIGlubGluZSB2b2lkIGR3YzNfcWNvbV9zZXRiaXRzKHZvaWQgX19pb21lbSAqYmFz
ZSwgdTMyIG9mZnNldCwgdTMyIHZhbCkKQEAgLTMwNSwxNCArMzA4LDYgQEAgc3RhdGljIHZv
aWQgZHdjM19xY29tX2ludGVyY29ubmVjdF9leGl0KHN0cnVjdCBkd2MzX3Fjb20gKnFjb20p
CiAJaWNjX3B1dChxY29tLT5pY2NfcGF0aF9hcHBzKTsKIH0KIAotLyogT25seSB1c2FibGUg
aW4gY29udGV4dHMgd2hlcmUgdGhlIHJvbGUgY2FuIG5vdCBjaGFuZ2UuICovCi1zdGF0aWMg
Ym9vbCBkd2MzX3Fjb21faXNfaG9zdChzdHJ1Y3QgZHdjM19xY29tICpxY29tKQotewotCXN0
cnVjdCBkd2MzICpkd2MgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShxY29tLT5kd2MzKTsKLQot
CXJldHVybiBkd2MtPnhoY2k7Ci19Ci0KIHN0YXRpYyBlbnVtIHVzYl9kZXZpY2Vfc3BlZWQg
ZHdjM19xY29tX3JlYWRfdXNiMl9zcGVlZChzdHJ1Y3QgZHdjM19xY29tICpxY29tKQogewog
CXN0cnVjdCBkd2MzICpkd2MgPSBwbGF0Zm9ybV9nZXRfZHJ2ZGF0YShxY29tLT5kd2MzKTsK
QEAgLTQzMiw3ICs0MjcsNyBAQCBzdGF0aWMgaW50IGR3YzNfcWNvbV9zdXNwZW5kKHN0cnVj
dCBkd2MzX3Fjb20gKnFjb20sIGJvb2wgd2FrZXVwKQogCSAqIFRoZSByb2xlIGlzIHN0YWJs
ZSBkdXJpbmcgc3VzcGVuZCBhcyByb2xlIHN3aXRjaGluZyBpcyBkb25lIGZyb20gYQogCSAq
IGZyZWV6YWJsZSB3b3JrcXVldWUuCiAJICovCi0JaWYgKGR3YzNfcWNvbV9pc19ob3N0KHFj
b20pICYmIHdha2V1cCkgeworCWlmIChxY29tLT5pbl9ob3N0X21vZGUgJiYgd2FrZXVwKSB7
CiAJCXFjb20tPnVzYjJfc3BlZWQgPSBkd2MzX3Fjb21fcmVhZF91c2IyX3NwZWVkKHFjb20p
OwogCQlkd2MzX3Fjb21fZW5hYmxlX2ludGVycnVwdHMocWNvbSk7CiAJfQpAQCAtNDUwLDcg
KzQ0NSw3IEBAIHN0YXRpYyBpbnQgZHdjM19xY29tX3Jlc3VtZShzdHJ1Y3QgZHdjM19xY29t
ICpxY29tLCBib29sIHdha2V1cCkKIAlpZiAoIXFjb20tPmlzX3N1c3BlbmRlZCkKIAkJcmV0
dXJuIDA7CiAKLQlpZiAoZHdjM19xY29tX2lzX2hvc3QocWNvbSkgJiYgd2FrZXVwKQorCWlm
IChxY29tLT5pbl9ob3N0X21vZGUgJiYgd2FrZXVwKQogCQlkd2MzX3Fjb21fZGlzYWJsZV9p
bnRlcnJ1cHRzKHFjb20pOwogCiAJZm9yIChpID0gMDsgaSA8IHFjb20tPm51bV9jbG9ja3M7
IGkrKykgewpAQCAtNDg4LDcgKzQ4Myw3IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBxY29tX2R3
YzNfcmVzdW1lX2lycShpbnQgaXJxLCB2b2lkICpkYXRhKQogCSAqIFRoaXMgaXMgc2FmZSBh
cyByb2xlIHN3aXRjaGluZyBpcyBkb25lIGZyb20gYSBmcmVlemFibGUgd29ya3F1ZXVlCiAJ
ICogYW5kIHRoZSB3YWtldXAgaW50ZXJydXB0cyBhcmUgZGlzYWJsZWQgYXMgcGFydCBvZiBy
ZXN1bWUuCiAJICovCi0JaWYgKGR3YzNfcWNvbV9pc19ob3N0KHFjb20pKQorCWlmIChxY29t
LT5pbl9ob3N0X21vZGUpCiAJCXBtX3J1bnRpbWVfcmVzdW1lKCZkd2MtPnhoY2ktPmRldik7
CiAKIAlyZXR1cm4gSVJRX0hBTkRMRUQ7CkBAIC03ODUsNiArNzgwLDQxIEBAIGR3YzNfcWNv
bV9jcmVhdGVfdXJzX3VzYl9wbGF0ZGV2KHN0cnVjdCBkZXZpY2UgKmRldikKIAlyZXR1cm4g
YWNwaV9jcmVhdGVfcGxhdGZvcm1fZGV2aWNlKGFkZXYsIE5VTEwpOwogfQogCitzdGF0aWMg
aW50IGR3YzNfeGhjaV9ldmVudF9ub3RpZmllcihzdHJ1Y3Qgbm90aWZpZXJfYmxvY2sgKm5i
LAorCQkJCXVuc2lnbmVkIGxvbmcgZXZlbnQsIHZvaWQgKnB0cikKK3sKKwlzdHJ1Y3QgZHdj
M19xY29tICpxY29tID0gY29udGFpbmVyX29mKG5iLCBzdHJ1Y3QgZHdjM19xY29tLCB4aGNp
X25iKTsKKwlzdHJ1Y3QgdXNiX2J1cyAqdWJ1cyA9IHB0cjsKKwlzdHJ1Y3QgdXNiX2hjZCAq
aGNkOworCisJaWYgKGV2ZW50ICE9IFVTQl9CVVNfQUREICYmIGV2ZW50ICE9IFVTQl9CVVNf
UkVNT1ZFKQorCQlyZXR1cm4gTk9USUZZX0RPTkU7CisKKwkvL1RPRE86IENoZWNrIHdoZXRo
ZXIgZXZlbnQgZ2VuZXJhdGVkIGlzIGZvciB0aGlzIHFjb20gY29udHJvbGxlciBvciBub3QK
KworCWhjZCA9IGJ1c190b19oY2QodWJ1cyk7CisJaWYgKGV2ZW50ID09IFVTQl9CVVNfQURE
KSB7CisJCS8qCisJCSAqIEFzc3VtaW5nIGJvdGggdXNiMiBhbmQgdXNiMyByb290aHVicyB3
aWwKKwkJICogYmUgcmVnaXN0ZXJlZCwgd2FpdCBmb3Igc2hhcmVkIGhjZCB0byBiZQorCQkg
KiByZWdpc3RlcmVkIHRvIGVuc3VyZSB0aGF0IHdlIGFyZSBpbiBob3N0IG1vZGUKKwkJICog
Y29tcGxldGVseS4KKwkJICovCisJCWlmICghdXNiX2hjZF9pc19wcmltYXJ5X2hjZChoY2Qp
KQorCQkJcWNvbS0+aW5faG9zdF9tb2RlID0gdHJ1ZTsKKwl9IGVsc2UgaWYgKGV2ZW50ID09
IFVTQl9CVVNfUkVNT1ZFKSB7CisJCS8qCisJCSAqIFdoaWxlIGV4aXRpbmcgaG9zdCBtb2Rl
LCBwcmltYXJ5IGhjZCBpcworCQkgKiByZW1vdmVkIGF0IHRoZSBlbmQuIFVzZSBpdCBhcyBp
bmRpY2F0aW9uCisJCSAqIHRoYXQgaG9zdCBzdGFjayBoYXMgYmVlbiByZW1vdmVkIHN1Y2Nl
c3NmdWxseS4KKwkJICovCisJCWlmICh1c2JfaGNkX2lzX3ByaW1hcnlfaGNkKGhjZCkpCisJ
CQlxY29tLT5pbl9ob3N0X21vZGUgPSBmYWxzZTsKKwl9CisKKwlyZXR1cm4gMDsKK30KKwog
c3RhdGljIGludCBkd2MzX3Fjb21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRl
dikKIHsKIAlzdHJ1Y3QgZGV2aWNlX25vZGUJKm5wID0gcGRldi0+ZGV2Lm9mX25vZGU7CkBA
IC04ODQsNiArOTE0LDkgQEAgc3RhdGljIGludCBkd2MzX3Fjb21fcHJvYmUoc3RydWN0IHBs
YXRmb3JtX2RldmljZSAqcGRldikKIAlpZiAoaWdub3JlX3BpcGVfY2xrKQogCQlkd2MzX3Fj
b21fc2VsZWN0X3V0bWlfY2xrKHFjb20pOwogCisJcWNvbS0+eGhjaV9uYi5ub3RpZmllcl9j
YWxsID0gZHdjM194aGNpX2V2ZW50X25vdGlmaWVyOworCXVzYl9yZWdpc3Rlcl9ub3RpZnko
JnFjb20tPnhoY2lfbmIpOworCiAJaWYgKG5wKQogCQlyZXQgPSBkd2MzX3Fjb21fb2ZfcmVn
aXN0ZXJfY29yZShwZGV2KTsKIAllbHNlCkBAIC05MjMsNiArOTU2LDcgQEAgc3RhdGljIGlu
dCBkd2MzX3Fjb21fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIGludGVy
Y29ubmVjdF9leGl0OgogCWR3YzNfcWNvbV9pbnRlcmNvbm5lY3RfZXhpdChxY29tKTsKIGRl
cG9wdWxhdGU6CisJdXNiX3VucmVnaXN0ZXJfbm90aWZ5KCZxY29tLT54aGNpX25iKTsKIAlp
ZiAobnApCiAJCW9mX3BsYXRmb3JtX2RlcG9wdWxhdGUoJnBkZXYtPmRldik7CiAJZWxzZQot
LSAKMi40MC4wCgo=

--------------sA1M5es0yBbNuw0q3fFaTOni--

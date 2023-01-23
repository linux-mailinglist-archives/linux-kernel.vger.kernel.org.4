Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AEB678BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjAWXDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjAWXDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:03:35 -0500
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC45BAA;
        Mon, 23 Jan 2023 15:03:03 -0800 (PST)
Received: from pps.filterd (m0297265.ppops.net [127.0.0.1])
        by mx0a-00230701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30NJHGm5011247;
        Mon, 23 Jan 2023 15:02:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfptdkimsnps;
 bh=Oft6fXq8NPXJhy985ch9HhSCmLUvi5kcfv5Q6UUGkYk=;
 b=qv4sIqrC+9rKTYxdO+JcuhUqi+FMsWtd9n/MNvjm3ymSYEC1vQZmxGmFg9gXSJt2cc7P
 6g2q3AaJZhmj6sVOj3SCKDbytYIabGe9w1Gb6c4S407zbzUpe6iJ+J9RlMgGK/yWhCdP
 76SoyIOlyuk4bn1H3VK+cA+jqTxvi7Q7WunmzwUmun5wZE84dj1ZKLqCT/DuGtK41xZW
 ln4gpmaR7KdDp5ulZw/ggS2hzi1Pnkl/qCWB1PkqOi/fi3B1ifTyg6wMR7WuQOHNTs0Q
 YF9y24p4CiFtDGdIbjPMn4CyA8mW9J5Hdi/YIS2u7GyPWBjPZ0cuOSp4f0PxONIwLsU7 UQ== 
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 3n8fuycr50-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Jan 2023 15:02:42 -0800
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0575F4011D;
        Mon, 23 Jan 2023 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1674514961; bh=Oft6fXq8NPXJhy985ch9HhSCmLUvi5kcfv5Q6UUGkYk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=XWbeQLasXSJkSf7zh7n5gFIWwN8XNZ5/27ae8PsxcoiYDFEN85PAA1FFMVCNW9Mxf
         4L6qH9cpKExcjvd/SUwq1Wg4na23KnQoZ37sC6zucriE6Z4Qbg5SqL5s9kELvBK9iU
         YgSJOxMEf0mUFi7LQ91MHTNQIhIMlIakkiZ/ZV7Me5lsk9/wiZg/KH9gGEKRlg3JuL
         KDCqvPWUzW7HyBv7+n0BPFPTSD8GLeITuKTf3NE6xZ59thkr60eNrMLgc238KgUT9p
         vHu90DjEon0R1cY2qmuUUF+/wszTsHhAxu/FQSwhc+kZCgVriPfO/CUn9X/oXVjOiE
         t1PvIMMFvnJlg==
Received: from o365relay-in.synopsys.com (unknown [10.202.1.143])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 013DAA0084;
        Mon, 23 Jan 2023 23:02:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DF43DA0399;
        Mon, 23 Jan 2023 23:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KrOqugwwc+q7NpLhbhT/dz7naRJt+hF0I968A5CBBOcslLYMf2CHcYK7IVMDgI81ICP83ESejYKR838aUISE5/v5r+TkWCJNf2+iEOxA6whJtLIM+VLvODulSQ8Mv2EpQEO3UOStkk9dCWhfYWcFk5GerY4vK3fFExquv5FIls/dbNmFW3YjSCYKg54UYJGezPM+o5OVT5t7jOKutDSxvPMGNaCi9BMVZThd1/1D1NyMQKnoSZlHVvZOhHg/UJ6fgvk/BYH4Vl2slP4AJGG4BT96CHL/CRl0KvApoO/xNKQCSfN3+nvdwgvRHLe123KPyJTtEHP2JTeByKqo/azQOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oft6fXq8NPXJhy985ch9HhSCmLUvi5kcfv5Q6UUGkYk=;
 b=ReyLJJqkNNwyzTsvh/yJhITdeujguUPjj5m8oQ3M9g1TbQ+um1ekvTp7etI9XA37CUwMu/uIO20syh87dxmundkoWljnHm/nFG6G4kLFQKH8aXlNwcBexlrBYDkPrvnUhXJZN6loIeSUorJM0k9EzKD9VwOX3GP3qno3Zp3W46cWS3xBWT5FLs4A7FJap/ObrXexOhV2vPp61LJSSfYs6rWB+oieFfTyyLnlXHxlDsf4fysnQ65aEcMQxXfMgf7caWzWQX9xbMzAAxxpi97FtntDSwV/X+Q3zO3xrxPfbYADNpBpynUct8B+yMPSk4EnFdbW5LIE/kpDMCaffu8mSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oft6fXq8NPXJhy985ch9HhSCmLUvi5kcfv5Q6UUGkYk=;
 b=awwrJSfiTXmUAM+rW+tu6XrM3T+eSlHxXQVO9UFrDD+pi4ITte3g65bvF3a/JNNU8cgC/nFs6qyFGV1LTv1qJnThkLg/NQVGGaR7Q7dABF6QI7YEDR4iCBIStsh7mE1mRCtCu5S/eU7PxRgOKiWFKFAsx5VGXd9qqW6aVCQVtfo=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by DS0PR12MB8218.namprd12.prod.outlook.com (2603:10b6:8:f2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.33; Mon, 23 Jan
 2023 23:02:35 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::6f3c:bd8e:8461:c28c%7]) with mapi id 15.20.6002.033; Mon, 23 Jan 2023
 23:02:35 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Elson Serrao <quic_eserrao@quicinc.com>
CC:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Topic: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Thread-Index: AQHZKr5r/qObzpub/UasYeFFzcErsq6k+Y6AgAF5HgCAABEigIABfykAgAAEBYCAABpUgIAAAgCAgAABMYCAAAGWgIAER4UAgAAOlICAACvbgA==
Date:   Mon, 23 Jan 2023 23:02:35 +0000
Message-ID: <20230123230229.l7uie4tnfzvvgkq3@synopsys.com>
References: <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
 <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
 <20230121002059.mpiqavemelnntxd7@synopsys.com>
 <Y8tGAXbKDtzmW8+E@rowland.harvard.edu>
 <20230121020223.l2tyvyqifc7umqpy@synopsys.com>
 <Y8tIrx+F/4X9YyFT@rowland.harvard.edu>
 <20230121021219.udgpwt7tv7dfr3jk@synopsys.com>
 <20230123193320.sxywht5vr3sig2ur@synopsys.com>
 <dae761af-6db4-f611-21c9-122fda74c5b6@quicinc.com>
In-Reply-To: <dae761af-6db4-f611-21c9-122fda74c5b6@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB4791:EE_|DS0PR12MB8218:EE_
x-ms-office365-filtering-correlation-id: 5cb24101-6876-4a28-ab53-08dafd95eaa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EtfH9pucFpIeFAJmhLfqqSKFT9nRzp5vZ2NWYxp8GjU8fioNMchFUinvh0GdeLYfCZr+S/2NqDgHDu50HIK6atTElsQbEtCiHYrdtbXoUNYXsxt7fYLSRN5AOJcEbGWvXLhaAuldzJmLSNF1kOkbcFLiRINWmp0NHl+uRuCHUg6X8SDMtWsUksEvcxPaRWeWAVLCYib/Sls48xbNUXX4Tu/AbuSLfGVsZy2XS17rALCUyCH0nXMP8svnrSOvkgg5Lkbx5imE55yMtga1Di0WWtiF+AM1F5f9IAAnjTiu3jfwZKFqHi1uZSM8Nq/uDsWbnPrsSDHovCrVu7mpznVa3PYfnBokVyJ4CYsBGj+N9vPA5V7hppSjGJti15rqZZzdM9kVq4LUPhQb9z5xQ93S22Vvb03JrYnBlGFG+yixhJANZKg4li50NOP1HE4cWukYANIwtJk+XjxYgMOHli8zDMNphz9AKQu2LzMh4PbW2Sj2WUW6ewH8gf2lOk2o8XOdChZ2r36fAMcWSPPDISRtiDxkNM9eiscUo1SHSok4V8dA78sUVjQKr/Qkey76/ntNTsi9nytxG+cgahA70oZgaCaP0q5qyiGazXak+Qkm3xiNy493fmcm9/tHKi5N8uVR4JNeDlsAQCP2wEcB87EAHzmx8Dhd4zn989AOP1owb28xBDs9NMbmX2Q/5MTky+ovfYPGKciOfKIm5BLI5ZS+kQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(122000001)(38100700002)(83380400001)(38070700005)(41300700001)(86362001)(2906002)(8936002)(5660300002)(4326008)(8676002)(6916009)(26005)(6512007)(53546011)(6506007)(186003)(66556008)(66476007)(316002)(76116006)(64756008)(2616005)(66446008)(54906003)(1076003)(66946007)(91956017)(478600001)(71200400001)(6486002)(66899015)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3poNUFIMkNublRHcXVIU2lIRFhCTUlQekpqMEVxOEo2MlRNK2lmMVNaOTJt?=
 =?utf-8?B?YlRUSDBVRmlGQ0xNNjlnc3FTMzFUMTZINW1QUkU1SGRyeUxZWUNuSnd2UlBn?=
 =?utf-8?B?T0dLbnhNSmdteUVqYnJuem4zaGZuQ2kyUTdIMmJHZkloOUJhNEZZUDh1T2Rx?=
 =?utf-8?B?bEUvT3dyTDBOdGZ5V0F4UDc0NG0rZjM0NlBoS01xTWs3RWFjYWE3NWFuNEc1?=
 =?utf-8?B?aFFXR0Rrc0hYMXNFTzkxWTRvTng1eGZXYXhsa1ljTVJzNEtGanp3a2ZpVVZR?=
 =?utf-8?B?UDIzaWYyZVNucDJPMU50LysyOEtIam1SQmVJUENIQmdad2RXYXhPdS92c1BW?=
 =?utf-8?B?ZXVMZW1IR01SQlZzNlhXVVdHY2NTeDk1Nk1Wci9nY1pVSXphdnlnNXQ5T0Qv?=
 =?utf-8?B?ZThRRFZUdWwvOVNtT2lWKzh5bXVrVWZXMSs4Qm9Ddms1ZGRPdlA5OStrY2RF?=
 =?utf-8?B?UDJBNWQwUDBpeDZPVWlvS0lvMFhIRGluZVVrTFN0OE9QYXJsV1N3QUVwY3I3?=
 =?utf-8?B?QWNJaDFuM3lzWmlnT3ZYdU5KcU9lT09Zd21aMFVjMjdWenhnMTdHUCs3b3dF?=
 =?utf-8?B?bEZWc0crU1BUbGNEdndGbUZ1ZkdmZFY2R1NIQWJrK1VtNWVrV3dhYWhXczdH?=
 =?utf-8?B?UENOUXdOQ0JzTXBhM0JhT3o3bi9yWWwyYWxiYXd2b0lIQzl2aGpwUE8wYldD?=
 =?utf-8?B?Y2pQdFI0TnltYWpHbmtnM0I0Wlc4QXVJQy9jRndXdTAvZ0pnc21SckZzNEZn?=
 =?utf-8?B?aDV0VEdYU2FPSnVrdzRjWFg0ajc1a3ZpUEVFR0p3VG8yZlIxR2xZWlN0bEFi?=
 =?utf-8?B?NUdOSXVFb0JIWUpUTEt1SkdQbW5jckQxalRNcXk1V0wrUVhKUG9xejFtYVhz?=
 =?utf-8?B?RDJaZ01iVjhyWTB2WCtsZnhXUHMrT3V3ME1DOE01QWpCenRKWkNDSHVndVR1?=
 =?utf-8?B?YTZCSUdKQkZqOENWSDRBaUpxZE9UZG1BQm9FL3I0VGhQOEhTSjJ0eGVmRGJF?=
 =?utf-8?B?Ynl1cTVnNWwyUlhlSlc3aDRmSnBlNVBxWjJUQ3BNcWNqUWlPY3dWRlkyTnla?=
 =?utf-8?B?Sk1IOEtxeFQ5ZjhwREJka0VBQjNkbW1yeEVxQWJOVlcxa3E3ZUd4TTJJanBN?=
 =?utf-8?B?UENyaGYxU1Nqc0lTSDVlM1FBeFlNbDVZamtxSnJBVFZqYTNCbFVWZHovazVy?=
 =?utf-8?B?UGorWldxb2d3SlY4ZERjWnlKaHAzRE4wejhmNU1ER0xDWElBUW1OakZWM3F5?=
 =?utf-8?B?Q3N5STViNTZYVDczOVZ4bk5HVWlpMXJFQ3QvbVBLUjkrR0JyMEtoTDRBaUNv?=
 =?utf-8?B?eC91eWlQcWwzL01URG9YM2ppZnJCaDZ5ZDROK0FRQU1nYWRDTVVFR3p0Vmcz?=
 =?utf-8?B?cXpVcEdQcXhoSGt4SXV3LzlGSGkzUC9WVm1NcnRRM0x2YmNtbmN4UENlL05V?=
 =?utf-8?B?WnNMRnBZY2puK0MzNk56ODd1anVQZjlIYWNvRllIQ0ZxY0NHdlh4empVRW11?=
 =?utf-8?B?cWpyYVljdEl2aEdhempQTGNNMVJZd1hwdUFlZDhPeWxyV29zaHQ5aWZ0SWxK?=
 =?utf-8?B?a0JXRVNrWlRVY0l2UkNJZ2FCNUV6U1kvZGpmdkNXZWxYWEJjbVNDQ3ROT1px?=
 =?utf-8?B?NGRtUksyQWgwYVp0a2RXckE5cEFkZXlrbXE0dUh4dWM3WE8wdGMwU0RjcWl0?=
 =?utf-8?B?dXk3OHZkU3UzeHYrUWwzaXluVVJxL0pQV0gvbm1ZQ3VhUUpMOEkrMWc4OWpO?=
 =?utf-8?B?bURSTXZxa3VmL21ja21TTG9LR0J2aEEyZlNPWklYalRPL1Q1UFBCdzdWWlEz?=
 =?utf-8?B?akRWZysxY0dEb1h2VmR6KzFMM3NxK0xoakd5aGtNcXI2bXN2aTVvVExHYVEw?=
 =?utf-8?B?ZnZEL0dKOWFPQTJsMytKSVU0TzMzbERFQkErbTA1NEFQTlFRM1VqUmtkNTlt?=
 =?utf-8?B?VjYxNGZ2dW5Wc1U5c1VXZ2lXeEpGWUFaYUVJNm5Mc2RZS0hRZHlZRnF4Q2xy?=
 =?utf-8?B?ckNHbnRSNUo2ME01MlZoazhoaUNCb25qbFNOcE1halFBeCtQRHJIOThQOEpp?=
 =?utf-8?B?UWQ3NlFjRFdWZitBR0dTTmdCaHcyNlhadzREMmh2emZDdjErL0p3ek1RcXNX?=
 =?utf-8?B?ejB5N29ESVU4WTB1b1dsTlpZN3FKWlV2ZlZPSlNoWnh3OHpuMkRIcnh0Ry90?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C89F770F7C078042B4A8118948AD6DA8@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?MEZHZ2o1SXhrTWNPZVAvdnJZWU40TVliNTFlQ2cxTDh5L1Z6SkcyU2U2aXVM?=
 =?utf-8?B?b0Jid3ZJVkdZMHA1UDJ0TWV0S1ZLK3RKWFluK3QxZFcxVVRvOHRId3lhREhK?=
 =?utf-8?B?ZlFuZk5tRmRhNFRMWFZLVFBTV29BNC80VmIyczRZbTlNajlIWUNUcytHY2VV?=
 =?utf-8?B?R3hUaUFmM2RFWXd2d25TRms5V0ZUUkk0Ry8vVmxvL1dZdEhYS0dSUXJFYm54?=
 =?utf-8?B?VzJQOExyK09GRkNuVXIzOUxBeklUWkd0eEtzOHFZeGVwRWZGdk5ZczhERi8v?=
 =?utf-8?B?VDZSdGpCTDJiMHVNWGpBdVNQcUFtRFNvNnFVMmQvRDNEbkF0UXM2dWNBUHVZ?=
 =?utf-8?B?VEc1WkJCck8vcGtKakVIRGJmTTBVaCtDQXgzQS9EOGc1U21acjRuVjJ3MnNz?=
 =?utf-8?B?Y0J5STRtOC9od0tVNDVTZ1M5MTRCT3pCRUc0bFBxbnN1ZElXMVBiODRIR1gz?=
 =?utf-8?B?SjcrdlhXa0huaGdEYWV2d1JCeUFWRjh3S0RkYTFBNzRoR0JwWGlGZWhxbzR0?=
 =?utf-8?B?RXZiRGliMzRHa21qTlozRzFkSHk0Z0ZHOUtaMm9teFRiZXNvbjc4K1FROEIv?=
 =?utf-8?B?L2V0UDNFTTY3a3VCVTdVdk1GYWZqRGVFc0VvRVJSTUNDU0ZSUHo1Vk1qS1BL?=
 =?utf-8?B?a2NEY0tHenhKYW4xZFhrOE9lSzQ0cWE3dllMSVRnTDFrOVNQQ0RvNjY1b3Bn?=
 =?utf-8?B?bDQwS1Vic1NoVmJ6YnBGelpQbHYrL3kvUUIrQ0Q5OTRRTEtSY1N3Z1N4UEE3?=
 =?utf-8?B?bW5GYXA4ejhreEdMTjdyWlBFZWNtUURTdFZxU3EyTDFWd29KeTYvbW1PTGs1?=
 =?utf-8?B?elNlNEIxNzE0UjUrWksvdTM5T0cwS2JvSitpSXVkdm5xTXlsbDMzbjF5a3R1?=
 =?utf-8?B?ZUNTOW1zZFFkb2hpWTc4SHFsSFNocGxOVUhZeTFiek9xUC9CMm1TRHdvcElo?=
 =?utf-8?B?RnFMN09Vd3FldDN3b1cycWtjMmYxWTNCMnZCQlpJUGNPbS82UlVGdjVKUmZU?=
 =?utf-8?B?UFEwbXR6TkRUZ0lqYlhBb2kyTFE0NmgxS2NSZnc3Qkw4SlNlcmFwM0xsa05W?=
 =?utf-8?B?a2piRUFxSjFaekhsT1d6RUhmcnFRbWJpYmhYQ2FhdHBNWG9HSW8vYWlzMzVk?=
 =?utf-8?B?ZXc0cENKdzNtdlFXVnhRNTdpSWpKeHl1ZXFaS3FvcG1PalFQOU93QWdNTDhE?=
 =?utf-8?B?VU5JMXcwNHlWSkg4QkdJTWNxSzV5RXNHSWR6Z2xrdDBpTk52djFQTjBibkJH?=
 =?utf-8?B?T29jS042NGhUL2V5dzZlOG54VUo2OEZUTnM2UjNGRXBaNFk0SEVMK3o0Qm96?=
 =?utf-8?Q?GY1ZsqYHmiNBU=3D?=
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cb24101-6876-4a28-ab53-08dafd95eaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2023 23:02:35.4976
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XFhQLeJnPkQ8DEsu8IhqVxPWiNSBduH8vz+QPk1eSBPMcrOdLXgOkaIKKiqmADQwRT+eXYKAa3ErtqzRLtWeCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8218
X-Proofpoint-GUID: 3A3-f2WsGUh56n1gRuZt_Yy7eFc9PBBa
X-Proofpoint-ORIG-GUID: 3A3-f2WsGUh56n1gRuZt_Yy7eFc9PBBa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-23_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=608 spamscore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2212070000 definitions=main-2301230218
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBKYW4gMjMsIDIwMjMsIEVsc29uIFNlcnJhbyB3cm90ZToNCj4gDQo+IA0KPiBPbiAx
LzIzLzIwMjMgMTE6MzMgQU0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiBPbiBTYXQsIEphbiAy
MSwgMjAyMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gT24gRnJpLCBKYW4gMjAsIDIwMjMs
IEFsYW4gU3Rlcm4gd3JvdGU6DQo+ID4gPiA+IE9uIFNhdCwgSmFuIDIxLCAyMDIzIGF0IDAyOjAy
OjM2QU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+ID4gPiBPbiBGcmksIEphbiAy
MCwgMjAyMywgQWxhbiBTdGVybiB3cm90ZToNCj4gPiA+ID4gPiA+IEEgVURDIGRlc2lnbiBtaWdo
dCBoYXZlIG11bHRpcGxlIHZlcnNpb25zLCBzb21lIHN1cHBvcnRpbmcgcmVtb3RlIHdha2V1cA0K
PiA+ID4gPiA+ID4gYW5kIG90aGVycyBub3QuICBCdXQgZHJpdmVycyBnZW5lcmFsbHkgdXNlIGEg
c2luZ2xlIHN0YXRpYw0KPiA+ID4gPiA+ID4gdXNiX2dhZGdldF9vcHMgc3RydWN0dXJlLCBhbmQg
dGhleSBkb24ndCBtb2RpZnkgaXQgYXQgcnVudGltZSB0byBhY2NvdW50DQo+ID4gPiA+ID4gPiBm
b3IgaGFyZHdhcmUgZGlmZmVyZW5jZXMuICBTbyBpZiBhIHNpbmdsZSBkcml2ZXIgY29udHJvbHMg
dGhvc2UgbXVsdGlwbGUNCj4gPiA+ID4gPiA+IHZlcnNpb25zLCB5b3UgY2FuJ3QgcmVseSBvbiB0
aGUgcHJlc2VuY2Ugb2YgZ2FkZ2V0LT5vcHMtPndha2V1cCB0bw0KPiA+ID4gPiA+ID4gaW5kaWNh
dGUgd2hldGhlciB0aGVyZSBhY3R1YWxseSBpcyBoYXJkd2FyZSByZW1vdGUgd2FrZXVwIHN1cHBv
cnQuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IElkZWFsbHksIHRoZSB1c2JfZ2FkZ2V0IHN0
cnVjdHVyZSBzaG91bGQgaGF2ZSBhIHdha2V1cF9jYXBhYmxlIGZsYWcNCj4gPiA+ID4gPiA+IHdo
aWNoIHRoZSBVREMgZHJpdmVyIHdvdWxkIHNldCBhcHByb3ByaWF0ZWx5IChwcm9iYWJseSBkdXJp
bmcgaXRzIHByb2JlDQo+ID4gPiA+ID4gPiByb3V0aW5lKS4NCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IA0KPiA+ID4gPiA+IEkgd2FzIHRoaW5raW5nIHRoYXQgaXQgY2FuIGJlIGhhbmRsZWQgYnkg
dGhlDQo+ID4gPiA+ID4gdXNiX2dhZGdldF9lbmFibGVfcmVtb3RlX3dha2V1cCgpIHNvIHdlIGNh
biBkbyBhd2F5IHdpdGggdGhlDQo+ID4gPiA+ID4gd2FrZXVwX2NhcGFibGUgZmxhZy4NCj4gPiA+
ID4gDQo+ID4gPiA+IHVzYl9nYWRnZXRfZW5hYmxlX3JlbW90ZV93YWtldXAoKSBnZXRzIGNhbGxl
ZCB3aGVuIHRoZSBnYWRnZXQgb3INCj4gPiA+ID4gZnVuY3Rpb24gaXMgc3VzcGVuZGVkLCByaWdo
dD8gIEJ1dCBhIGdhZGdldCBkcml2ZXIgbWF5IHdhbnQgdG8ga25vdyBsb25nDQo+ID4gPiA+IGJl
Zm9yZSB0aGF0IHdoZXRoZXIgdGhlIFVEQyBzdXBwb3J0cyByZW1vdGUgd2FrZXVwLCBpbiBvcmRl
ciB0byBzZXQgdXANCj4gPiA+ID4gaXRzIGNvbmZpZyBkZXNjcmlwdG9yIGNvcnJlY3RseS4NCj4g
PiA+ID4gDQo+ID4gPiANCj4gPiA+IE5vLCB0aGlzIGlzIHRvIGJlIGNhbGxlZCBkdXJpbmcgc2V0
IGNvbmZpZ3VyYXRpb24uIElmIHRoZSBjb25maWd1cmF0aW9uDQo+ID4gPiBkb2Vzbid0IHN1cHBv
cnQgcmVtb3RlIHdha2V1cCwgdGhlIGRldmljZSBzaG91bGQgbm90IGJlIGFibGUgdG8gc2VuZA0K
PiA+ID4gcmVtb3RlIHdha2V1cC4NCj4gPiA+IA0KPiA+IA0KPiA+IE9uIHNlY29uZCB0aG91Z2h0
LCB5b3UncmUgcmlnaHQgYWJvdXQgdGhlIGRlc2NyaXB0b3IuIEl0J3MgYmV0dGVyIHRvDQo+ID4g
d2FybiBhbmQgcHJldmVudCB0aGUgcmVtb3RlIHdha2V1cCBiaXQgZnJvbSBiZWluZyBzZXQgaW4g
dGhlIGRlc2NyaXB0b3INCj4gPiBpZiB0aGUgVURDIGRvZXNuJ3Qgc3VwcG9ydCByZW1vdGUgd2Fr
ZXVwLiBXYXJuaW5nIHRoZSB1c2VyIGF0IHNldA0KPiA+IGNvbmZpZ3VyYXRpb24gaXMgdG9vIGxh
dGUuDQo+ID4gDQo+ID4gU28sIHdlIG5lZWQgYm90aCByd19jYXBhYmxlIGZsYWcgYW5kIHVzYl9n
YWRnZXRfZW5hYmxlX3JlbW90ZV93YWtldXAoKS4NCj4gPiANCj4gPiBUaGFua3MsDQo+ID4gVGhp
bmgNCj4gDQo+IERvIHdlIG5lZWQgdXNiX2dhZGdldF9lbmFibGVfcmVtb3RlX3dha2V1cCgpIGdh
ZGdldC1vcCA/DQo+IEFzIHBlciB0aGUgZGlzY3Vzc2lvbiwgd2UgY2FuIGhhdmUgcndfY2FwYWJs
ZSBmbGFnIGluIHVzYl9nYWRnZXQgc3RydWN0IGFuZA0KPiBzZXQgaXQgZHVyaW5nIGdhZ2RldCBp
bml0L3Byb2JlIGlmIHRoZSBVREMgc3VwcG9ydHMgcmVzdW1lIHNpZ25hbGxpbmcgT1INCj4gd2Fu
dHMgdGhlIHJlbW90ZSB3YWtldXAgZmVhdHVyZSB0byBiZSBlbmFibGVkLg0KPiBUaGlzIGZsYWcg
bm93IHJlcHJlc2VudHMgVURDIGNhcGFiaWxpdHkgdG8gaW5pdGlhdGUgcmVzdW1lIHNpZ25hbGxp
bmcuDQo+IA0KPiBEdXJpbmcgZW51bWVyYXRpb24gcGhhc2UsIHdoZW4gcHJlcGFyaW5nIHRoZSBj
b25maWcgZGVzY3JpcHRvciB3ZSBjYW4gdXNlDQo+IGdhZGdldC0+cndfY2FwYWJsZSBmbGFnIHRv
IHJpZ2h0bHkgbW9kaWZ5IHRoZSByZW1vdGUgd2FrZXVwDQo+IGJpdC4gQmFzZWQgb24gdGhpcywg
aG9zdCB3aWxsIGRlY2lkZSB3aGV0aGVyIHRvIGFybSB0aGUgZGV2aWNlIGZvciByZW1vdGUNCj4g
d2FrZXVwIG9yIG5vdC4NCj4gDQoNCklmIHRoZSBjb25maWd1cmF0aW9uIGRvZXNuJ3QgYWxsb3cg
cmVtb3RlIHdha2V1cCwgdGhlIGRldmljZSBzaG91bGQgbm90DQpiZSBhYmxlIHRvIHNlbmQgc2ln
bmFsIHRvIHdha2UgdXAgdGhlIGhvc3QgcmVnYXJkbGVzcyB3aGV0aGVyIHRoZSBob3N0DQphcm1l
ZCB0aGUgZGV2aWNlIGZvciByZW1vdGUgd2FrZSBvciBub3QuDQoNClRoZSByd19jYXBhYmxlIGZs
YWcgd2lsbCBpbmZvcm0gdGhlIGNvbXBvc2l0ZSBsYXllciB3aGV0aGVyIHRoZSBVREMgaXMNCmNh
cGFibGUgb2YgcmVtb3RlIHdha2V1cC4gVGhlIGNvbXBvc2l0ZSBsYXllciBuZWVkcyB0byB0ZWxs
IHRoZSBVREMNCndoZXRoZXIgdGhlIGNvbmZpZ3VyYXRpb24gYWxsb3dzIGZvciByZW1vdGUgd2Fr
ZXVwLg0KDQpXaGV0aGVyIGl0J3MgdXNiX2dhZGdldF9lbmFibGVfcmVtb3RlX3dha2V1cCgpIG9y
IHRoZSByZW1vdGUgd2FrZXVwIGJpdA0KaW4gdGhlIGJtQXR0cmlidXRlLCB0aGUgY29tcG9zaXRl
IGxheWVyIG5lZWRzIHRvIGNvbW11bmljYXRlIHRoYXQgdG8gdGhlDQpjb250cm9sbGVyIGRyaXZl
ci4gQnV0IHdlIHNob3VsZCBub3QgZXhwZWN0IHRoZSBVREMgZHJpdmVyIHRvIHBhcnNlIGZvcg0K
dGhhdCBiaXQuIFRoZSBwcmVwYXJlZCBjb250cm9sIHRyYW5zZmVyIGZyb20gdGhlIHRoZSBjb21w
b3NpdGUgbGF5ZXINCnNob3VsZCBiZSBhYnN0cmFjdGVkIGZyb20gdGhlIFVEQyBkcml2ZXIuDQoN
Cj4gRm9yIGdhZGdldC0+b3BzLT53YWtldXAgY2FsbGJhY2sgc3VwcG9ydCB3ZSBhbHJlYWR5IGhh
dmUgZXhwbGljaXQgY2hlY2tzDQo+IHdoZW4gaW52b2tpbmcgdGhpcyBnYWRnZXQgb3AgYW5kIGRl
dmljZSB3b250IGJlIGFibGUgdG8gc2VuZCByZW1vdGUgd2FrZXVwDQo+IGlmIGNhbGxiYWNrIHN1
cHBvcnQgZG9lc24ndCBleGlzdC4NCj4gUGxlYXNlIGxldCBtZSBrbm93IGlmIEkgYW0gbWlzc2lu
ZyBzb21ldGhpbmcuDQoNCkFzIG1lbnRpb25lZCBwcmV2aW91c2x5LCB3ZSBzaG91bGQgYWxzbyB3
YXJuIHRoZSB1c2VyIGlmIHRoZSBVREMgZG9lc24ndA0Kc3VwcG9ydCByZW1vdGUgd2FrZXVwIGFu
ZCBwcmV2ZW50IHRoZSByZW1vdGUgd2FrZXVwIGJpdCBiZWluZyBzZXQgaW4gdGhlDQpkZXNjcmlw
dG9yLg0KDQpMZXQgbWUga25vdyBpZiBpdCBtYWtlcyBzZW5zZS4NCg0KVGhhbmtzLA0KVGhpbmgN
Cg==

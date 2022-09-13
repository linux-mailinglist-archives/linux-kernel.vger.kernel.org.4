Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB855B6A59
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbiIMJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiIMJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:10:34 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0B56BBE;
        Tue, 13 Sep 2022 02:10:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28D98sSW032502;
        Tue, 13 Sep 2022 09:10:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=XYOdTicy6OZ9/eLWiLxFGiDiz/6toMybYi4fsr2amnU=;
 b=D3kXcrjYBUF0vi8d3/7LQ8tTLWV5PFF3cm4A3+5FW+2nJl1yIZ43fRW+KEjvJQGZQctO
 kg+E3sBM8EOe8aED2Agfp88GArm2qe2XGKwAT1AKLRfJowGGxmxM2PXAvJWUc0UkapGU
 OoBMC6dSXpyhoPMQ+lhz/nTUBccj961T5qr5h0+TVfNleF2cDIrXvdLqawvmqu0nqNU/
 YkVieIdcYoYVBuSwBriK2J0Wl6GG1ZQzBTttjBS7Li9g0FgVuGd4QNpNzXrkrABTOfrc
 SRd2Ax4zpifd5uc7+BJ9eJwXSlvQ1uuooRyXG7a3UpCA1pRKbUozefHMaeAgJGNmI3pm wA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jghc2p79g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 09:10:13 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28D8TVZ5020613;
        Tue, 13 Sep 2022 09:10:12 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jj6b2cqas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Sep 2022 09:10:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7WoO+bZHohRLL88aSD20bQnGyzKg+R/Jf2MjakSZV2JWFdgPSVIuQI1OQo/QBHfLZ8Lb95YHOcLatxnFG5u6W/J85R0E2zdAD3sh/7wuS582NbjK6jIOuh/282Xg1+9hENB0uwikgzlNfDsyAQmMAdQWV0VLcMo1DVVtGMeStjyvsJQZAGKOZu8mNqy0xaFZYQOKgU85e0RpxOB1HV7Z20aoZykx8GAGZclrTa/gJXYCsPtjIey0eY2/EO0v6ZTyrCG9pdJBAYEPUcjiywfwHfdgnYDr3vW8TIVXlW+q/vcRdR73cNSZaeV1Md+iaaB+nX0qr1q22hGfLnqrbv0mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XYOdTicy6OZ9/eLWiLxFGiDiz/6toMybYi4fsr2amnU=;
 b=e53617ZxF4MT3ysSrjEa6HpjhACHZ3CmFu1pF3C7fcs25bMEafJppkdMmoWAzz23CLWMPw/PVi+MNDwsHuNrmQelwdWLkK7MIkPIlgS1Hy7kgcttQkNdaEqj/qACUFT0RMexUGpHMv5SABSUb5Icz+udCVSYaxmz42qOl1K5uzds/aQa+lwQgdd0GpwTbrs6bJ0Jn83A7+HH/VIDAhb1+vI6O2T5Fcomdu2iy3LGm9sOSht9COXBIyHP4/bksOD4rdVNmfgOiyTPaUYxZY63xMjj9PJ3iNnkPjvpMfFjK7F/13aq0AGq7d3O6FiK7RXPTfX1/1dzB6qZjUoRsB+n/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XYOdTicy6OZ9/eLWiLxFGiDiz/6toMybYi4fsr2amnU=;
 b=SzosR3Vyv5uiZXcdnx//SNIidcptXq73KFKcPyCYWtI/BqHw333YWEI65yd5l4ERj2dOzOcOC+JsJyhyygKfah1Ao2XIk1oFGbkP8/vW9lptKB+8qUahLmpIo6u9E9hLfYMyCQnD46fW5E8+pgyITYS+Kyrv+jk+GAsQcDxjLcA=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by IA1PR10MB6052.namprd10.prod.outlook.com
 (2603:10b6:208:3af::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Tue, 13 Sep
 2022 09:10:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5612.022; Tue, 13 Sep 2022
 09:10:10 +0000
Date:   Tue, 13 Sep 2022 12:09:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jagath Jog J <jagathjog1996@gmail.com>,
        alexandre.belloni@bootlin.com, a.zummo@towertech.it,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jagathjog1996@gmail.com
Subject: Re: [PATCH v1 2/2] rtc: maxim: Add Maxim max31329 real time clock.
Message-ID: <202209110621.NTvdfL0p-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220904044708.7062-3-jagathjog1996@gmail.com>
X-ClientProxiedBy: MR1P264CA0131.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::16) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|IA1PR10MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: ac990b7a-550d-47f8-2b0f-08da9567c1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPE2B+gLCuohvir3rMTy1+JHuH1Cx9AvzCLSvtL5H2vqnvZZMMYwtGPzLyYs/aqqf7HV4gA/wV0NNiZJq0s5XfxycuOeEzYfmr++nh/K20BE7FW52hIAqQyc7t13g8FZn5+oHQMNdubkielmByKEsxDOgvXpxqZxk/TYc5VStcrSogDVNhZBlAKtPoJuT1hvd9v0e52L8XegYIwA6hxHWOxnZIm2c/owBgZQL3+KecTq+mcbLumywXR6pgo29R0PiNsLLU6Tw1CgJZWaaw0i+mYSn2T8Vq/LaMbR1eKn+WaukgLm3ogM+ajMh9r1x+my18XuE2q0bkA1nFWe0xOuKU3s8zXK4hxcpOiEy6TG+r+0omy6VV/nRGfByq78EKglHmU5rQpGL9GjBVm6DyyV9SDww6ieaIPOUlLI2YHI7Aw4t0yMjsI/AF4a6QUOqwqMIoNldJRg7j0yWUKhN1e7u2mif3ehStVioIJ037x8M4e+Lp3LHIiZ+yQ+NDPQlPooil56WfLs05i4abaRJ+E/S0CDKn0i+uKONdyC2US9j0RehpHG4G25bmxCkcnedEUVgPw//IP37oVeEmDJ40t7abSPy8P3pn0+YFFEsa5rbno9SVrpmgvTt1TOKO1C3IADm1r8LJSUMQPkiryn87QqrRk1vACO9CYb6Oq+OAKYFF+HJe3MNkPRxfveHLMBY62bBTW6lcptTc63LIuEd3ZRgLsLSG0q6rRRyLYpE7WvZo2srp483QA4I3ypd4804ePCPGvvOjZpw3NLx0riwXRh/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(136003)(396003)(451199015)(966005)(6506007)(2906002)(6486002)(8676002)(26005)(83380400001)(6666004)(4326008)(186003)(66556008)(5660300002)(66946007)(44832011)(9686003)(7416002)(66476007)(41300700001)(38100700002)(316002)(8936002)(36756003)(86362001)(478600001)(1076003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zVj3HNpgQOGoBYHaEEhPCw9/IxNofLyAqXtSEBOBjbKYnU7cyeSIiGZrlS16?=
 =?us-ascii?Q?Lmn8jaNNQMTqNfMGvjlsORo5xo4Fx7ZdOlnTj3ym1b+7ftcUuNE2vPzfRYmb?=
 =?us-ascii?Q?Y3diRhVmIUwLXDRsvKStC1/pbi170JN5fdEwd6Xeg+SJO2EHMmNoKXhts7Q0?=
 =?us-ascii?Q?Jlj/1gaXES2Ung2MkWmWiO49H4SuMwsT6MkGbgWEjlk8gRXuaxw6Ek0/c05E?=
 =?us-ascii?Q?LEX9m159prDZobtCl8HzwJj4dLRpfBprlWjJTO2DnMsZt/PJDwNEF3mFF5Da?=
 =?us-ascii?Q?ojKKetGellsDbHvRLmD9QV7cB0DgS0/ygQkj8CR+cWlNep4PD6d6RFfPmUm9?=
 =?us-ascii?Q?azQLDBstfTUnJm0XadhMJO12zYSqM7NywYb4BKD04aBY8RYHVZAGKGsymFJB?=
 =?us-ascii?Q?37q21yddXw4ljirQRN8Oc5J3wjddywkRnUeyJiODZsxHY7iGGXvAazIm38WC?=
 =?us-ascii?Q?HnWtJp2T4RXxvvaZJ0yQCIsJXsKGIpGuGgn32RbTGgD80d8Nf+iiCy0fS+2s?=
 =?us-ascii?Q?hAJsnLqg66QnBDSBerUdImdCCWTwCRpn+FvTpkocSsC5/rxSVDiZIIwvFRpn?=
 =?us-ascii?Q?SWXLbN9UDL5qgJyTftVZ1obEdjtNykgohgIKIZxxFI7qnLmOe6hbkzhOwci4?=
 =?us-ascii?Q?ciao+JnRtGf9IOmTT9R5uNNj/BLCCAuZq7+LzHgAySgTZpw2Dt3J4zcPxjY8?=
 =?us-ascii?Q?7CAgbrtVTnWqd1WAJJaGAKISLDcC4WLgDBx1tcHak6sFx5HGRSQAlsqpZ7RP?=
 =?us-ascii?Q?vHVUGEEhGyokO9+SEy9fy83VbxkhvcOk89tbkpL9tmSqyLt/hW+603lZJA3B?=
 =?us-ascii?Q?AmhOp9fJ4DdsZRBLz2is4GZsHdczmvpx2AELYUBS8/OGIniz+8exB5eueuUg?=
 =?us-ascii?Q?pKXs7ngDLRod6Z3p71XnFWwd3ZqnLwX62VSresvyhtmADVhzrIDOqySOYpbz?=
 =?us-ascii?Q?4OpTjb8U7NyGnNS3g5EqkIbRVrTytBfcI+cFWYo7tk8le2/pVYtJlH9OU2A7?=
 =?us-ascii?Q?KNcldG6qyENDnfksQP/SfxC+YqKz7AggdD12FnOFrL1rY/22b/gH8eZsMrmN?=
 =?us-ascii?Q?UQhV7fpJ/y4bU4f9VWtIvCJB24OPs1RxWUT5VTDBxliG3n0nrFsYTSxyBGdc?=
 =?us-ascii?Q?iwn+UKRa1R9EDVp9AU5qibuIpq4Jq2cVr/orNFplgBaCnA+4A0xiNJ//b7Ph?=
 =?us-ascii?Q?EvA9ylyQcZnu7kBDpZ+zJkIh4bOffd361rhmgiUA93fpPWsDJxu1vTlJ4ex1?=
 =?us-ascii?Q?zab1FC+Hf8HAFvPSk+KE7masGDprBDSLZMKwzXN8dnMlm8lwl0Z+YHLvedi1?=
 =?us-ascii?Q?qYjZi6i15ZwCubUqYw7E4wB/CNP0kKfZccWfhIyrb1vZiynVIrWghTt2J6UR?=
 =?us-ascii?Q?MOx/Yg97R9Kei1tLVs/C1l2TG/vwkzmTCjl0i1bXTcdXHGgAalSMRRi6E7ft?=
 =?us-ascii?Q?GaeGMWhBjCGx2VwzstALzNTIxEMngxVsH/aDdctl9XoCN3JIn4Ey/70IZayL?=
 =?us-ascii?Q?sTmhG/YLK7pTMr6dz3i+F2OXZoW6s++VmlL1POlXRuX8fTP5fiheDJSi7TK+?=
 =?us-ascii?Q?dfwf4S8WGP2YbO0DN9ukM+4AGle0uRH2KpOxz5iP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac990b7a-550d-47f8-2b0f-08da9567c1e2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2022 09:10:10.0528
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FmtoTxOMSSm2D36a85X8iZjMW8nWsVUAmLAajfZ/xmF/hCscgXxCKi7+BdcxSLNgXfDapDbAplHhNyH/UTT1kbOq+S86pn+RTl8PEkhbC8M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6052
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-13_03,2022-09-12_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2207270000
 definitions=main-2209130040
X-Proofpoint-ORIG-GUID: iOsR4R1fpDFg6FyRHTQ8foFPXXpmEPDO
X-Proofpoint-GUID: iOsR4R1fpDFg6FyRHTQ8foFPXXpmEPDO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jagath,

https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jagath-Jog-J/rtc-add-Maxim-max31329-real-time-clock/20220904-124909
base:   https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git rtc-next
config: m68k-randconfig-m031-20220909
compiler: m68k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/rtc/rtc-max31329.c:276 max31329_irq_handler() error: uninitialized symbol 'events'.

vim +/events +276 drivers/rtc/rtc-max31329.c

f26f983311b011 Jagath Jog J 2022-09-04  250  static irqreturn_t max31329_irq_handler(int irq, void *dev_id)
f26f983311b011 Jagath Jog J 2022-09-04  251  {
f26f983311b011 Jagath Jog J 2022-09-04  252  	struct device *dev = dev_id;
f26f983311b011 Jagath Jog J 2022-09-04  253  	struct max31329_data *max31329 = dev_get_drvdata(dev);
f26f983311b011 Jagath Jog J 2022-09-04  254  	unsigned int flags, controls;
f26f983311b011 Jagath Jog J 2022-09-04  255  	unsigned long events;

Needs to be initialized to zero.

f26f983311b011 Jagath Jog J 2022-09-04  256  	int ret;
f26f983311b011 Jagath Jog J 2022-09-04  257  
f26f983311b011 Jagath Jog J 2022-09-04  258  	ret = regmap_read(max31329->regmap, MAX31329_INT_EN_REG, &controls);
f26f983311b011 Jagath Jog J 2022-09-04  259  	if (ret) {
f26f983311b011 Jagath Jog J 2022-09-04  260  		dev_warn(dev, "Read IRQ control register error %d\n", ret);
f26f983311b011 Jagath Jog J 2022-09-04  261  		return IRQ_NONE;
f26f983311b011 Jagath Jog J 2022-09-04  262  	}
f26f983311b011 Jagath Jog J 2022-09-04  263  
f26f983311b011 Jagath Jog J 2022-09-04  264  	ret = regmap_read(max31329->regmap, MAX31329_STATUS_REG, &flags);
f26f983311b011 Jagath Jog J 2022-09-04  265  	if (ret) {
f26f983311b011 Jagath Jog J 2022-09-04  266  		dev_warn(dev, "Read IRQ flags register error %d\n", ret);
f26f983311b011 Jagath Jog J 2022-09-04  267  		return IRQ_NONE;
f26f983311b011 Jagath Jog J 2022-09-04  268  	}
f26f983311b011 Jagath Jog J 2022-09-04  269  
f26f983311b011 Jagath Jog J 2022-09-04  270  	if (flags & MAX31329_STATUS_A1F) {
f26f983311b011 Jagath Jog J 2022-09-04  271  		flags &= ~MAX31329_STATUS_A1F;
f26f983311b011 Jagath Jog J 2022-09-04  272  		controls &= ~MAX31329_INT_EN_A1IE;
f26f983311b011 Jagath Jog J 2022-09-04  273  		events = RTC_AF | RTC_IRQF;
f26f983311b011 Jagath Jog J 2022-09-04  274  	}
f26f983311b011 Jagath Jog J 2022-09-04  275  
f26f983311b011 Jagath Jog J 2022-09-04 @276  	if (events) {
f26f983311b011 Jagath Jog J 2022-09-04  277  		rtc_update_irq(max31329->rtc, 1, events);
f26f983311b011 Jagath Jog J 2022-09-04  278  		regmap_write(max31329->regmap, MAX31329_STATUS_REG, flags);
f26f983311b011 Jagath Jog J 2022-09-04  279  		regmap_write(max31329->regmap, MAX31329_INT_EN_REG, controls);
f26f983311b011 Jagath Jog J 2022-09-04  280  		return IRQ_HANDLED;
f26f983311b011 Jagath Jog J 2022-09-04  281  	}
f26f983311b011 Jagath Jog J 2022-09-04  282  
f26f983311b011 Jagath Jog J 2022-09-04  283  	return IRQ_NONE;
f26f983311b011 Jagath Jog J 2022-09-04  284  }


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEE668E1CC
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 21:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbjBGUUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 15:20:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjBGUUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 15:20:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E27265BA;
        Tue,  7 Feb 2023 12:20:04 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 317K5mT8015219;
        Tue, 7 Feb 2023 20:19:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=vZVIaaA78XHkuKa+tXSssMsVSW80aDf9RNAdkPXHfZo=;
 b=q9vcMYl+miIuWtpjK0LhWU6tUdk50AnX91M2V4z1tbIHackatGadrQF60TEaqBBRvAda
 2tXNphlFqywQfReVY7zaYNMACcBNufAVwpK1ebdd1OkWR5TQ7k+d7w45E/3ys76KZLmC
 OH4orWAi/YAYoEwtHJpbe62ouL0GkZZwjoQxpj38RX8r5jHbTrvEqYZlJDAe6Wp5tAdI
 L7zgsYfAhrOVJIjWHw/A2q0ha+gaX8Eabw69808dWcR7+g+z1nWcQHMT+OIgruYS930r
 yQT0FR/j4WqXw9St3eRd8VBmzEQjj2vh8S3gdCNamMxk9OsTp5OoiibN4/2cO9HyftFW 2Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwu6gmj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 20:19:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 317JRxQ3024885;
        Tue, 7 Feb 2023 20:19:57 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbaqn8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Feb 2023 20:19:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kU4Uy0He3ys2FhkNIlft9RG/nsoBRDZZMCQ3HF4OHbGTfk1KhP1qvLsP73kt31bEpnozZFR35XKTHLkurr46tjNpdFxObrdH2penX5Zq/Fqmzl7WDWj8Aitl5j+VjbLFFCHv+0D5QSm9ZPkmpO2iX/6Bsq2tQXjjRBfU1v0MZPtJFBQ92sJSXvw/w6KV3eauzFNcbf5TMQCA4dKXTFEBPo2RXDfNHdm6Bkyd2zTXFWInFhK4szokuDYHiS13fgkMh0wyuowe/4+n3IInms4HGHJkDx7EZOWL4ubWi/A/nsY/1I72rMNTbHcOYnVKTPEEMlNBCn/WPWGDn5o8/MYWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZVIaaA78XHkuKa+tXSssMsVSW80aDf9RNAdkPXHfZo=;
 b=XhK/OjnrpavS/iiFv4rZro4drzzX2s1jsRzRfNo9abfN6/smfvZyKPMfONqM3akIXjuo8vwTNa/qBYtPzAS0/O8+WKdhexM2WmKSuFjqJZF7XTBvHN/Ne0PzcOSTboTXB83H0HF4CqbE5HcsaGbhLM9ItYXdmQppC/EcZRodngFwI5wuF74E4bLW4LrfZpZ6H762nIQlJdqlYbVME/zmQtrn4zZbH9ndwwL4aiQwouRAgxXKVaUf5qC7QqZwKiKCi3R3LSGOZHhlEaaNspdbh0VBIF6NiHT0p7NkM0I67YdKtplQ+ZH2vjiilYIPxwMFMW03f85kpYFisdistr8Tiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZVIaaA78XHkuKa+tXSssMsVSW80aDf9RNAdkPXHfZo=;
 b=AcYyz8hYUMP8L0Tu4pFnnJoARVzSEA8oLw0w9tWtxn5RgWYB4JmvV5F6FuFGUkZG6Dc852ZPbxv/LkFLRu/+yLicZHQkC4a92BKEg4dQq1HhpGfjQQTK6r5t5P96U+qxfNXRRqs6ibRiRXv5oD9LtHkBBbD6Y+RmOObCsQvdCaA=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SN4PR10MB5560.namprd10.prod.outlook.com (2603:10b6:806:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.7; Tue, 7 Feb
 2023 20:19:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c7e9:609f:7151:f4a6%4]) with mapi id 15.20.6086.017; Tue, 7 Feb 2023
 20:19:55 +0000
To:     Deepak R Varma <drv@mailo.com>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Khalid Aziz <khalid@gonehiking.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>
Subject: Re: [PATCH] scsi: FlashPoint: Replace arithmetic addition by
 bitwise OR
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq17cwt2s0r.fsf@ca-mkp.ca.oracle.com>
References: <Y+I0HXsHezZRtFOM@ubun2204.myguest.virtualbox.org>
        <9a78cdd254d5d962450242d2e01c3a0f702a63a0.camel@linux.ibm.com>
        <Y+KOeP0OOiem3lR5@ubun2204.myguest.virtualbox.org>
Date:   Tue, 07 Feb 2023 15:19:52 -0500
In-Reply-To: <Y+KOeP0OOiem3lR5@ubun2204.myguest.virtualbox.org> (Deepak
        R. Varma's message of "Tue, 7 Feb 2023 23:16:32 +0530")
Content-Type: text/plain
X-ClientProxiedBy: SA1PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:806:2d3::16) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SN4PR10MB5560:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3cdd4d-74e7-4939-071c-08db0948ad06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OtqoXnk09sek7DzfaeUvkBF/E3y+gfAkN/YFWPzPiMWx9/K4OnW70kFDa/QEWylLkeRUxermn4d5Z5HIFB6dIoB5Wvmu3/1wXmmxgm0PyL8epoifXDi+hND8VaPI09H2BPTp8SQyb3YA5nmv2XW5NYDaI8oIQVSD9Jx/gCy6rDMxsdA+K70OuwJ3woZ+2oMMpJpfNLNmmq1X5yfAUqMHUsd6aVsa8gerZ88AeE6TfAuFI2crPBXFnwaDQIpuWSoA0wCvqy6pYECtj2KeM5cdM2GRb2Vtt9NrW7pvdtt93TBzqsZOOgwCJ9MG8RRtFu0h5ff+UNb5yjUF++1BA5mXDRBI4aznlAzTNFosTNqr3l9kjvxElPHpJ9DUURWxAkrDOXFIQLeipSmTc/cQSlzn2bThRFcxci3TadUlxxUjz5HROO4F5uSQHxG9yfccTDpNcAASPeg+R6Dr+yqZ686+wx9WfcVktvaQpYk2y0k10ivqPQyfDmBvEIXu3SK/gbLl1Xr2SB84KKrCrX3JzItPjhXJZvsleiUuowiM4sy81FI9dHtITpVLD0PRicYtJyDj6BYWxVg0lMVf1J68odHs3G+xi+OYz/j3H2DfZsST6+lVEwNoFalZKXlwK2dYzztnT3Nd6KxrrJor4nRD+1Vrbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199018)(5660300002)(2906002)(478600001)(186003)(8936002)(6666004)(26005)(6506007)(83380400001)(6512007)(4326008)(6916009)(66556008)(316002)(66946007)(41300700001)(8676002)(6486002)(86362001)(38100700002)(54906003)(66476007)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWc6DYkYUdiRQ2aaE4eyw533f5wzIdsTtR7KOj/HHrjZlypuLCVImP3mGfhL?=
 =?us-ascii?Q?hNZIYJLl/TDrdI+sGvritHnEunexkTGVsMor9WwpndjrPv64Iwnn5zGXQffN?=
 =?us-ascii?Q?ks7LljAvDSTp8qa44vhxG4TzTzXTKtXbb3L6O0FBauJSxa/sjiyJIAp6JtSI?=
 =?us-ascii?Q?DwZnRG+EUPD0zXt102lVOKjwiPmu2hNZq+35yZLauYt1JDmhNo9wuVAL0ABp?=
 =?us-ascii?Q?ezFYpuRxXVYsFhMIt9sMLSeg7feJy9aXfEfe5d2q739A32cErRzZ1Kvr6Pbf?=
 =?us-ascii?Q?GtzlWE9H0kLn91m7K7Tw+xIWV5JtwdEucwHUtefVKYmiRdtAlMhBLSuQe5UL?=
 =?us-ascii?Q?fBylapYOP4yGoP0NtKQGKlOjbqMWbtMjVN7SDEi/xFVM3gZ7k5YTOQMY+WcY?=
 =?us-ascii?Q?/DlqHmzQUzarphS8xztx0F311W3+CV+K4jqpK/7HrxKOGf+LC6SiI9TFruGn?=
 =?us-ascii?Q?uIHM2sAXr9mG3gup+EyIREuzviZ5D0iYFQRUPGLj3ZZwCjyZ3dKGY1j7L+Ox?=
 =?us-ascii?Q?uw8Zm12mgi67k5U/CSz0NUn0wZOuguuCObyNq5//4REVLB8XxAK/NW+ZrfTs?=
 =?us-ascii?Q?AvnUfXzCVf5DepqOieYp6JDIlw/ecGhTQqs7Ur89RTA28h2PNV7JtDY3+/8Z?=
 =?us-ascii?Q?oTV9f2ZypoZbOTqBB0znLDpnOI1OUrPfp0W6PB66FdmuZFZTwOdQBop5OeHn?=
 =?us-ascii?Q?P292OitkDO9p/nmZdcr8lPNJ7T9wf6KzwR0l1Po86rjDx34/YWxnn02so7ib?=
 =?us-ascii?Q?5Qsn9GB9kwhLcV9kecvlYKJW4S3E9O4jQXrsAwZWFIchbBOKKOo1F7/q8h6e?=
 =?us-ascii?Q?GdgFLXP1fYBQ7gcAOUuhRfJe7ZnwWEJuQKUgwt5P4+Qir3jm0KjW48CAn1Ff?=
 =?us-ascii?Q?XCOf184/CWJm7RVl82Xp+FihS/16k6gfUiPE/wzKNoB45jkK8vkKn6XtQzWz?=
 =?us-ascii?Q?RqSIIPdLGW7AP5VGTpi7rJ4R+6K0cm4HMf9tkUm9HturfCYuYwtiMDkUYY85?=
 =?us-ascii?Q?X2naMlNinVQWRF4NxAuKPscskF8uKF87a7rPh4awkepJu6uBR+S97226X1QZ?=
 =?us-ascii?Q?97gt/GnMGklyPsnsfJebh6MdxodMPLA+gqb8hlIWPieIWN20d/ddfrcAOXT+?=
 =?us-ascii?Q?fnf9btGZVTadt/GwV57HJI45KvZPc5Ns38qz4Xem8sJM1t/3sDFOaAZPfXsY?=
 =?us-ascii?Q?jkfRba1GgGvumJOJL1pL3yO/tU5I2/2GeDeJIkP2VwrLkDCa2cih/MnFd4S7?=
 =?us-ascii?Q?5n04ihb/JQYy5eSMKwKMNSt8u8L3zFCGWeC7xGT0TzIg6LtBailpBkhzydmo?=
 =?us-ascii?Q?T815O4XIdCS6WoUOnB+COpCNxxqPN2JRl+pKKgS8IlO9E2aCmt/NS7kc7p6u?=
 =?us-ascii?Q?jjabmDZN6cRi0D3/HZUtjprEzdg6u/VzDjT+xSynPLaTqpb8DuTtsa6q50FH?=
 =?us-ascii?Q?hlHJRFHX8LHCnjk8jk2jPcOUUo2pmEvRTuzCnSmQRm7fJ/TSodBTdsAsOkAe?=
 =?us-ascii?Q?yVAvokN2Wnn4AYE1+UPuSBOhaKpGFVZ55EiDOHmMPT2wwYnf+sLjrR2/oQGJ?=
 =?us-ascii?Q?XtkmiqqZxZRyAX6B6z/JX85BgYf6UMSmu17EqBbElYoyI+s6MazXxBnjuJhz?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?QbARj3dCN76kUr8fUWDUgS+ZyYGMp0j7RrI4NxmM9xOfWXh6dz792g8s89it?=
 =?us-ascii?Q?+Wn0oSwi5ISG02UOeA8r5H2TvxfRlDClXfCOzw01TaoaIQJElAg2rw/Xt00+?=
 =?us-ascii?Q?b9p6pc1gZ0y73GjGb1gcQoovhqyiTwNaRwHRsto90e3WUdZgdEvlcfvppQQO?=
 =?us-ascii?Q?x70NlsADXIf5tREbWfYPn2CBfyXV/Vmwe/hHEC7pCe3tzdSD+goP7YeE2nsv?=
 =?us-ascii?Q?XpUHu6ZAtZORK1D8vW4FhTOIzn7V5LUzBkxiJh4+u9t5NRJjebQ4pcaUpSXD?=
 =?us-ascii?Q?XL++9cazXsCAyQbgJ6dm0lhodHgBxJ3Nj9KtvRua6ndPBAgjXFks3HMflVZy?=
 =?us-ascii?Q?PP/ADv6AXxNCKUdSuouXEyhMWfNmtlCTmERtxYyXmRRpIsMmx6XPgwaqQqAC?=
 =?us-ascii?Q?X1rOrkOuFhmFqQVRpKrRWkjQXI89Obfe2e1P6TfTxDXF66Gtsk195qKYehLz?=
 =?us-ascii?Q?d7cqc1zTtPpAmImBRmJwLjeS5a5/IQYc7Gg7GNw0nAQG8s9zIM6hAd7vapbX?=
 =?us-ascii?Q?mtflndEqvzkFEalCQVUhMZ6YBcMVtRzo+sC2aboj0okFCs7SaRFZI+J/mc+6?=
 =?us-ascii?Q?/GmBZxK3YhOP5i2iOQ93hb8BDSiqieQqNJAmgyFlytomMaDg+kXgUvu98Eru?=
 =?us-ascii?Q?CjxGl+Kxp5RT0KcF6VavBIo8iRdi7TeOAue8UDnJt6LrPzdH9AWLjPNUUnN0?=
 =?us-ascii?Q?CmlP49TwlmxhMQFsc4l9r38+P7V9YJJ1srHgmfCzKmaXJyrHeO+Z1fqxt6Dt?=
 =?us-ascii?Q?WovhQLi9V9rrB3Rz/GUgClvffxWtFarJ6inWNVvNO9qrul8lFQ+gdikOg73Z?=
 =?us-ascii?Q?tabqa0nYuw6BupbYX6M+UHxFW0ukct/HsREuVHwqcfPdQYmDL4pgoToSJt0X?=
 =?us-ascii?Q?WZh/opFnGWMt5Pjp+FUt0xI41uKAsHDpCTCji3VPT5QQcj7DHSRVDQEIWLxG?=
 =?us-ascii?Q?pCjuPjdXAlMtpQbuTQak6w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3cdd4d-74e7-4939-071c-08db0948ad06
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 20:19:55.0085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TQ96U5iHNaM/oRh4jV7DbaeIw3ty6YCs5r+jnvAuC+F2xSUMVL3BQkKwv7WnA74P65fRFa4smso6/wq2OYnXrAUU/Ko3Vueq1rCFwYs2JSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5560
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-07_11,2023-02-06_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=742 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302070176
X-Proofpoint-GUID: Pxr_DdiJiP1yXKASOffDMI6KhWBUTQD0
X-Proofpoint-ORIG-GUID: Pxr_DdiJiP1yXKASOffDMI6KhWBUTQD0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Deepak!

> James, there are a few other patch submissions for the scsi subsystem
> that I submitted in last few weeks. I sent couple of reminder request
> for comments on those submission, but still waiting. Could you please
> also review those and share your feedback?

I only merge cleanup patches if the relevant driver maintainer reviews
and acks them. And there needs to be sufficient justification, of
course.

As an example I will observe that your sysfs patches say:

"According to Documentation/filesystems/sysfs.rst, the show() callback
function of kobject attributes should strictly use sysfs_emit() instead
of sprintf() family functions."

That's a "should", not a "shall". IOW, a recommendation. Also, there is
no "strictly" requirement to be found in sysfs.rst. So the patch
justification is lacking.

We definitely use sysfs_emit() for new code. But it is not clear that
there is any value in changing old code predating sysfs_emit() to comply
with a mere recommendation. It's just additional work and comes with a
substantial risk of introducing regressions since virtually no cleanup
patches have actually been tested on the relevant hardware.

Nobody has access to all the devices required to validate the many, many
drivers we have in SCSI. So unless the driver maintainer (who presumably
has hardware) is willing to test, it is impossible for me to qualify
whether a patch introduces a regression.

One option is demonstrating that the patch does not change the generated
object code as James suggested. But even if the binary is unchanged,
cleanups often involve stylistic changes or switching to a more "modern"
approach. And for those changes I still want the driver maintainer to
ack. It's their driver.

To pick another example from your posted patches, it not immediately
obvious that using min() is superior to an if-else statement. Sometimes
it is clearer to express things as a conditional even though it takes up
more vertical space (or maybe because it does?). In any case that's a
personal preference and the driver maintainer's choice.

Hope that helps!

-- 
Martin K. Petersen	Oracle Linux Engineering

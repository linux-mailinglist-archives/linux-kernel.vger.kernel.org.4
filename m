Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440DC6207B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiKHDrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:47:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbiKHDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:47:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C940431212;
        Mon,  7 Nov 2022 19:47:05 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80Nrul014382;
        Tue, 8 Nov 2022 03:47:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=3lUqH36ZHz1dmTLuHw4sgxl50G7mxRmj/4wwYB3B94Q=;
 b=qIXTEOOG5g7ZaShZrByP/qkhRi1bSCA1O9WTXYwQq002zHZ6t/9WAPfzNoww1db7BBDj
 zYSvYFP4oNwKv54dQOkYwk2oKCTDkETyiVresq2FgNgXNMvixZMTAB97Urv5pQYdRS+T
 cWkKYRBh1sMANoVoysb1jTeMzfzjwmsuF0xmY8CmNZRjTzZV8wt/F2HQWe6lhySAJXO4
 T0cWZqY7wiFrmAsnUxqN9+IlpITyvjHaTOzDdNfYKSZ8h/FoSJ1uLkeECESgs0gGmtv+
 tblkEF36Nzdyu18MexVxe+V2UQ4DhhBvghDLx9mqlhNkCtnvU7njZdWYid3n6vpx0q7O QQ== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kngmj5njg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:47:02 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2A80carH003347;
        Tue, 8 Nov 2022 03:47:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kpctbq8an-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Nov 2022 03:47:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cl4gN+5c4R9/cIVqKkkGa9BOD518PQHsMzgB9Ai/GHvRyyna0ND3kisnB9xpYQ/mjDdpv26E5ubYNFGVZinLgucfGfZveboPufh//A5O7FdzxIvymR/L40vMpc2fnaWafXY//oV9BBv9WMsqwDPKNogiw+tRcjXXf9G3DcINb6WRAQhCqQiOwU0Zv8k8zgooZQgzmGmI7qI+3Tc1U/JpjNAPbhrwXTH/CedanBO7eOaY4EdHtOin2XWV3+KxYTzKpJfyRsYIpAUm5v313V0h9rCdpu4XQFRJyTJbHBZWGGNkdQpmSlpjlRXqIenBIoqZAqW9ddhn5Ri6L7dH+UGH5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3lUqH36ZHz1dmTLuHw4sgxl50G7mxRmj/4wwYB3B94Q=;
 b=WibI01ZXq1fHFc9nlLh1RxGXwp/py6jhuosxdcj9JKHPcUN9o+oxx8ys3smpxy8rG4khJJ2Zpqxc9uvFCj9LfWrTHvA7jLIBTG85FpCggeFTu38TXBiu45uhFtDZSdxfvzBm+Uav19qqQH4EbIUdiTIFE66HpuQhiVP6UcucEFC4u8I8w9dw4LFW8N4fWvXX6bEaoLtICQIbqO6mgHvpXewGfGlYCciC2HObNWSqO/qaV+gpeZ1omquz9LHSfyd5Ho5ZYfZKuyqtxoKkVITEu6w2cMntEMbUDZ8LebaLFRaJVRwaBi0e+RiYcnnMe20cteR82q7EAAwvoAFPSNnr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3lUqH36ZHz1dmTLuHw4sgxl50G7mxRmj/4wwYB3B94Q=;
 b=ts5DrNbZJ8QihPgDm7wOjFfWybqtqErzR8w9hnc073srreVGHHRJP7fCfFX6rmNQpJNdKbqbNicZI8QWbLkERb7vIAdU8tBo69ixt5TCNAPqTqAX8pol5oTR716l1bh1goM2F2fl8OMI9F3C+sxOBdia8QeFHZcHFSsqMPgEDpc=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB5883.namprd10.prod.outlook.com (2603:10b6:303:18f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Tue, 8 Nov
 2022 03:46:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::f77e:1a1a:38b3:8ff1%9]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 03:46:59 +0000
To:     James Smart <james.smart@broadcom.com>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: remove redundant pointer lp
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1smi03t.fsf@ca-mkp.ca.oracle.com>
References: <20221101115657.48267-1-colin.i.king@gmail.com>
Date:   Mon, 07 Nov 2022 22:46:56 -0500
In-Reply-To: <20221101115657.48267-1-colin.i.king@gmail.com> (Colin Ian King's
        message of "Tue, 1 Nov 2022 11:56:57 +0000")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR12CA0013.namprd12.prod.outlook.com
 (2603:10b6:5:1c0::26) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 620b292d-24d6-400a-3061-08dac13be3ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X7pwLgpxxU5iytEMWAt1GtUsiS1iTyD1NTMidQ8Lp2DstRdH1z2W5lbL7m2FuIxGMPRwfV+pAdy4p+0W22tqHRQ2pAO4RBhcFR4MATfpPUKDfFHVryeDwNliD3GkBxI++Dhy4DxiABi4pPSCWlgI5QK3hHEH05yzIWBbAo3Otc1Md+sSmqW7nqOczekGNixg4cFv7rMKl+M+FtfHEMUfkJy2btYU/NO6kXunChaxjVeunKf+qIWsbSJiFLY04l783Kh3HLQoRpL8SlnPEkmKGTiMWGON07Nih+QesJdteNTWpR1iwvkxzdk33IHO3FHcpAxTE0HYB2okZe64vbEehvbdl0j3ThUF5dNKmozF+h7+nE0wy9TOq7fSvuVyJeiOJ6XTPizGPOcqgNp7FKgGCDDTks4+bussNxTN6Q1w1XU6cPwnxeOdF+JAX8IVgyS/YI2dUM6vifJH6sVyGjjIEJ/fomsaLV4iGX7GGE5ckgruxcvhVe2h9EVTO/XgElM9CrmMtRsalDEGYOjqirw7V8nw1K1reXqumGcTt7n+7K0QurxHmFLlu5ASnaCjhcRghnHXbENUHAx6fuxkUtlV6kwOCVxp0wXFaP0WDOPavM9FNdAqLsUb+UxslEVDR0oTF6Oe+GJntf5OpdQAu3FuH2SdWhVBJp7U4i3ORXtzYOedxnDp4VPLam2jlFBDLbXG65/9vPfbSh0K4Ydri9evuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(38100700002)(36916002)(86362001)(26005)(6486002)(478600001)(8936002)(316002)(2906002)(6506007)(66556008)(66476007)(66946007)(4744005)(4326008)(54906003)(6666004)(8676002)(110136005)(5660300002)(41300700001)(6512007)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6KFvdr3BhI/2rzn7aoLOZ+ZCNtMibXcVuTDbliPlyKuNGY7R8xOsYbQWJZ5e?=
 =?us-ascii?Q?UTKQF3G8mglyqabIer8dEhBnha3IS2FJwdi0M1jNlUKfOPrEjD9zYQ7hLhxV?=
 =?us-ascii?Q?4YO59njWg3akfa7lGBMgHyc9H064JU+t4ismDRUpHWRxbSRXG2MffuJKAEn4?=
 =?us-ascii?Q?8OlwQ4tX9XbOys3b5bvjWs6ccIpncoOOlEB/EpX7kml6Gg0Dps61KkCgoLEH?=
 =?us-ascii?Q?XCaenCq1FxYoTaqCq4hpNHor+yZIchmAy+L2FkTfMmPU8/cmo9rJAjbsPptr?=
 =?us-ascii?Q?+kPu7UrEovq8kbw/LgbJY4173x0MXltkJm24XryuImel3mogsP+1K3+6aB4B?=
 =?us-ascii?Q?7uxq8yQoBfQa1pyW7K8zUglosUWiqRwp1PEXcECY5mMhik/v0Z3oRJYL5IAV?=
 =?us-ascii?Q?hZXFoh7QG3cZ1IIevLnjh7gmFodi7NuXYIb565TTLewiQNih9+NqWxPN3Giq?=
 =?us-ascii?Q?lhwYTV2Oe8HtK5MqyIY9uV+G3/pU+aQ8aQVf4kxP2fl9nr4c56oMYsVv5qQB?=
 =?us-ascii?Q?5CwGsyEwE3asNzrVL78DrPmjVV7npAzgtC4RrOMVaKKadlwr1FeU3MYcT2NA?=
 =?us-ascii?Q?gmiD66x18wMLmZpQOQXuZdbIQJwJ3deCDrjqlQsjVCi9Yg1zHnWWbQtHyOng?=
 =?us-ascii?Q?PERqslL8e7QmRLo+4h20eT67yqXGAB7tF8+EmjJMiaSW7P0ugA89nduP8FiV?=
 =?us-ascii?Q?jyi9EIsHhE+7oSd56UxlZS5IbW8h/0QIsW0Y8skDvBui270DcFX/wYWg6g6K?=
 =?us-ascii?Q?XU15KNIeTKx528RxABVh6TRUzVBbW9ZnGnWCvNvYPNxMnQTrI8EfMjPDgoUE?=
 =?us-ascii?Q?eyA69HRob9THIreIxhaMHTTf+LnBZicwJzxm0CezSPmSOgbG3hqpjNJhUp63?=
 =?us-ascii?Q?KV3B+IKlxW1YlALY2Jby7iVrGqgYoeI5VXwLkTsx8XY0EEIrjDlUrcL9/PeS?=
 =?us-ascii?Q?dHVfP82Mst3kWN0aXY5UMDZ4KEN5Kjw8kpBSLEdn8vf5W6en86ku3axGRxF/?=
 =?us-ascii?Q?eNOHTddQ43HOEHB0neHKe/tL5SHHW2WE4/ZmSOHDwcPDpL2Haff1BQkw66rv?=
 =?us-ascii?Q?Nr1xcKNloDaLg8grBdGsvhC4OYUtxcuU8djEnYX+awZgjbLksgpv6KYs2UsC?=
 =?us-ascii?Q?m5/Lgoi+Xushj5gFtAil9koTYCUSNwRLth0zCO52hSX3Kz/Y+JdwcRRPsRMf?=
 =?us-ascii?Q?H9NR4NyePTDqocCGbynrTt82895YDpW+HFMjoV0Rw5EdoMd/LZhEWX3REtH/?=
 =?us-ascii?Q?SU5z3o8R1OTk0DeaSjRCgp29jE9+szdDt0mBSEhlpyC6+JJWCNxGMr078qEs?=
 =?us-ascii?Q?CMsd6lXZNBuoM5AMWeyrbWJLMdEtW7xL7tzNI2zVbApfqxX2yZNAK82c4LmX?=
 =?us-ascii?Q?Zhz0VJOTHbSHGkw6n6U7xKeFR6Ja7zvByGbK8RpgRigylAjb7Qjq0rIj/JCe?=
 =?us-ascii?Q?BX6q3JJdNMBVKPDQ1uUZhH7PVmyBU1vWoDUoOSfUr46wWC/nVOb42ZTj96pM?=
 =?us-ascii?Q?MfA+EQQjwj8fC4v+HmR2MCgYjE0vCZYfdvtT2RPtlRPf+8O5txs3w40GxMu8?=
 =?us-ascii?Q?OynVJ/K/YyT233D6C66Xs8jHYsV+EqfBkZvzTHVQplF6onnQqg6qGRUTXAsC?=
 =?us-ascii?Q?zw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 620b292d-24d6-400a-3061-08dac13be3ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 03:46:59.4827
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zmFAtOVUCqF69S0gm6m2efO1khJUW4Eg0pwBT/WRfU2i28Q13xEvEs4bMOqyle+GjomxWiTTtTPrw8GlPFgO9qkAqAXLMUS488aRT45+hPE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5883
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211080018
X-Proofpoint-GUID: nJh7PYcLkgTwxoyQhY-Gpc3m3riD_uML
X-Proofpoint-ORIG-GUID: nJh7PYcLkgTwxoyQhY-Gpc3m3riD_uML
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Colin,

> Pointer lp is being initialized and incremented but the result
> is never read. The pointer is redundant and can be removed.

> @@ -9173,14 +9173,11 @@ lpfc_els_rcv_farpr(struct lpfc_vport *vport, struct lpfc_iocbq *cmdiocb,
>  		   struct lpfc_nodelist  *ndlp)

Looks like this function has been dubious for a long time. From a quick
glance it doesn't appear to have done anything useful with those
variable assignments since back in the 4.x days.

James, please have a look.

-- 
Martin K. Petersen	Oracle Linux Engineering

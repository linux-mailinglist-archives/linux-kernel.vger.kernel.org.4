Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F8E602145
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:41:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiJRCk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJRCky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:40:54 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B47F8708B;
        Mon, 17 Oct 2022 19:40:53 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29HNYFRf016326;
        Tue, 18 Oct 2022 02:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=m+bZUiGj6L/BBzGB9Y5p+hhAF3raVKr7jXj8PPjKhXI=;
 b=jbDNJ+cHmF3OmBaOj/h9KfiSMjLJ0F4XFTpAjRvG1rwWpmGJ8ZqVWM/VASDpZleF63ev
 XWvxsHG7Kuh5ts1UiXk/GYvf3NgDoHuYB9tJ6tF/liXHZjl3bK9ZKCYHutQ1pbpPj5PO
 CrQTuZ6SKp9EkT8WBkHkgz83ZRYPJiCDCjt1JmqvGZ5n4vkubZQnsE0uN+971vkMRKZ8
 tjtcumyRxodapkCb54ag8kwoNVCokqJQDMWxnOclCyRP+S/O6S8mOFvm2OF2Ff3U22vr
 H5fC1DU4opnb4AI5ui5N7pI0IBXOcvOrWugw4OhJH13M9o/7ab+7HiVVYP0hLZtEZ4vp lQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k7mw3d7h8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:40:35 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29I0DuYt015922;
        Tue, 18 Oct 2022 02:40:34 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hqy4ypc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Oct 2022 02:40:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OV1XJHbet4ViLRNRDz8yaaJy8jX60yrUsU5z83otFP++eItnZeCr+ADVRi0M/Dv9aoUm/qJG6Aven3n0eY++nKntmy8s+3mXYjQR68CIkDgsls8/AqN195S8OOqVEHu8WtTM2Iw178Sqb+JBdK2bHarN4qjLz6599R563kIr43S5biL1gXlGQkh3UgmJPGBs3nqdBj5EvN+IcfWD+ZqFqFzRKgokvz8/+a5gAxvjWnmmUQU1sagd0LTTg6Qm97f1DE3tKmqOCmkl+pq+EKw1BWNw1xwddtNp5y2G4LBIpPCaQHR1saX85DoG6A6mNJONlSqwJrwyl+x1EvjE9py67g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m+bZUiGj6L/BBzGB9Y5p+hhAF3raVKr7jXj8PPjKhXI=;
 b=ZY68JbYKvtnCO611EcgHHnnasMJoA+3wPJ8CgUoXtw23yt7nC37la1BIdwqJhWC2lQt32NqMi3gBgRMZA/apOBeagKoijtDf8hr43vX/k5Dg+3Rd63ea1AwoqQmwNKG11hiyT8MuCopx4rfXy2uB5WbYSX3+bkPUKHuJ1P8jxdrifMNgejuG7V+MGrL/wLaqSbXXBIvldB3/6Pf3DHZ76UJ7zzG4bYM8UTewXfOBOm8PxlVzGZ67ldH9ELvF/ZEksJm76bY92Kp6a34jMlHyt2g+dA5z3DaC1Ktau+gPXlJfs0bW9VRoCzRzmpPUj/KhrzFLgIiNsM16V2NSUhKDkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m+bZUiGj6L/BBzGB9Y5p+hhAF3raVKr7jXj8PPjKhXI=;
 b=oDQOGqpghvx1v5Rn4QN1/s/h731FN2Y+cC8S+AOhMsTN/qgnNbNA//pMj2JW+6EnI0V5Fq8DoiKMDnQeiE1LvdIlhFFFZkb6BLTjgXL2bSJDeWnBa3HeZqiGW1YPo/JbDwy2rS09xWfQMXgPnkufopkdcZAfNluAKQ9Aou+CU0E=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by MW4PR10MB6347.namprd10.prod.outlook.com (2603:10b6:303:1eb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.30; Tue, 18 Oct
 2022 02:40:32 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%6]) with mapi id 15.20.5723.033; Tue, 18 Oct 2022
 02:40:32 +0000
To:     John Garry <john.garry@huawei.com>
Cc:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>,
        <jinpu.wang@cloud.ionos.com>, <damien.lemoal@opensource.wdc.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <yangxingui@huawei.com>,
        <niklas.cassel@wdc.com>
Subject: Re: [PATCH v6 0/8] libsas and drivers: NCQ error handling
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1czap26t2.fsf@ca-mkp.ca.oracle.com>
References: <1665998435-199946-1-git-send-email-john.garry@huawei.com>
Date:   Mon, 17 Oct 2022 22:40:29 -0400
In-Reply-To: <1665998435-199946-1-git-send-email-john.garry@huawei.com> (John
        Garry's message of "Mon, 17 Oct 2022 17:20:27 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0052.namprd07.prod.outlook.com
 (2603:10b6:5:74::29) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|MW4PR10MB6347:EE_
X-MS-Office365-Filtering-Correlation-Id: cff52e0a-613b-4c18-395e-08dab0b22052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7j4rVivPK2R/ysNwfSaw0iiKEPIghVJYGSUfDBksYaXoOpK1IkyOa0g5jrWeXT5b1Ow7T8pJj59LhYGrOIZWxcDL+Y1EziaarmfJPfnvCkmtCvENpqhjL+pf3ZZ2H5cZkBAo7fdUOvpaXlp8fH/oTmk1UBVo/7nNQwtKwqzOZs6Of/rDSjp2hd8Mfczo/Y9HlwWi11oaTAVllWV7OVBVBID5KAMqteJrFf6Xt3A3uR4qrn5sM+AO9IUUqvVgz0zfwghzFyIV7pwAR9rJMi3m7I5DG0zw0Y+ThnlYY11esrYUSpTlAcwfZNN8BaARuW2ofwOarZPJj/uLq1MtPNw0YFPOa7TjELhFswyZqFkf8lJD03K3bKgFlKYAxO4aNFQNeeYaAlum9EO936nZQFuG1pXYP3JZIOCj86jCsrZCpSqEQlYA8QXm/rVbNoVSRqLKp1yh7Nl9ZLt51YgQoR6CRnyPVSxjIxx+vSEHpLE+eoH5zoLnHv1NlAJfn1KFyneTh0ZiPC4W221L9VT69S9OhrYNOEo3pbGQlogcXb0kQ1ukzXQ/irfu12USg3VGZjdu4mU9h2kqXzpVuKuyTByay0eHS+diNgWuDDUqVHJ9Vlv3kbSnRWfV9OwGANxZa1GjDaqdB4dtGiHSkriYi0dLla2FXDREKZ5/kQkG8yYj/dh8zKOrFu2JHwJdFv/OwKJppyE5JRFrFx/2U3SfkIHzBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(136003)(366004)(396003)(346002)(376002)(39860400002)(451199015)(86362001)(478600001)(6486002)(4744005)(186003)(6506007)(8936002)(26005)(6512007)(36916002)(6916009)(54906003)(316002)(6666004)(66946007)(2906002)(38100700002)(66556008)(66476007)(41300700001)(5660300002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/P17qjuJcGZ/Cp33xKGq3bltd1ygU8R1N6pKTNNoAGJXhLt7vM5OCn6icYcT?=
 =?us-ascii?Q?TnrgFjiJlIINOsJoD+SnDPu7DAnmFkZDaSMEIS3HJ3/ul56vEvoUV0PdUpTg?=
 =?us-ascii?Q?CMZub070seDgc1oEthp3iIluHcufqWiSvyseXvFhJF9lwiOiqSXlOEo1TI8v?=
 =?us-ascii?Q?JUkt3hTfCNcxNep/yPnIaSFfsIRrYV4s/raLmiUo71//v9SGYNgGNA0kO+w7?=
 =?us-ascii?Q?wXVMN8KjENJoFHJjpVyTPPUP//h9O63GlWe1f6XfdPmdjDSnabsT7IqyaPkV?=
 =?us-ascii?Q?Ec6SwL657A9+dA6TwlsCEmDMtyAHdC90KIb1fq8oWY9G1HvaafrhU3ZLeYoK?=
 =?us-ascii?Q?uSiH+ldPtvztA1XbMtVFB7Jz9rpwgKSayQL5Uic5S0lTg7MYjytuVzi7nJVq?=
 =?us-ascii?Q?zKkqF3cZMdw+r181gtXPXeyJ0ke6UZaL3Iptgflv3QWdKjDxeFBQfpZPGK9I?=
 =?us-ascii?Q?cfomfgWipwufCvjp8cdt3g0MYwPhGo8zHiSpGatWTK3b770cTZ/GmLHCHiaM?=
 =?us-ascii?Q?uX7LPZiAR8snPZRAxPzyIUxKRebkoyD0n2jXIRolXcJuSgZjWZweMQAsjYgK?=
 =?us-ascii?Q?zKok1857FWY3Dvl2YDwS/1hprPu8A5t6uhFJCkWuwtSqIA7PVKwgo278nxWa?=
 =?us-ascii?Q?oLFWAAmA5dXtHMZ3wthKY9xDY7wBNVRo8CA1t0feUtkg1Ptt/ZuHtP3UUsou?=
 =?us-ascii?Q?epZNWEY2/ynka5emc3tQCz9s/DtvPKi66jEiB0up7KjJWwSFQB2XRLB4BfbP?=
 =?us-ascii?Q?CDuCDl0TL2+yAUDvUn2MnbAPSeblsIWZuE5LBJciMQ2GOhsnhvKAY2Mtn9V4?=
 =?us-ascii?Q?f5YtrPFZgQ3IREy3yV9xvsIZTpPGUB9FsxoNy2qYdpyGJhu2qzspPM4rZE6B?=
 =?us-ascii?Q?xywAZ2EyQ2mvYvSbj78I+YzBabMRJbki8IIrhjrzHlT3vlk1pFyuQNHPq87S?=
 =?us-ascii?Q?E0AtEBcWcvhEDCnjT7CgBWfh87Mq+2/omUW2arK5U0WAKSMdjDKJk2fYl31y?=
 =?us-ascii?Q?9kEVASK+pS/Sba3rpnXSn+Xp0U3/CwRVzvzZExVO9dj6YMBnfeywBSySYzqO?=
 =?us-ascii?Q?8bpRuXrUyKIlhyxCWPO1BjCxp+DwMZhADflSd2mzaD+keAEkr0szPR8Sowvy?=
 =?us-ascii?Q?f0zIY8wA3mj8nIEgJSb/BZrKgjmLzD8DV0EIsuvQVHZ7/iF85E7u88SOhdBK?=
 =?us-ascii?Q?1/C2ushbpRFUtKBVav4WHxYYA9pZJU4WHOGI46jkVAxVvYoFitkEbQv7MkTI?=
 =?us-ascii?Q?2ihMdobKERNXcCaXsrDabN0Ci6i+Rc9AsRWxiQ1jDa850ZaPqtSKC5JURmSM?=
 =?us-ascii?Q?IZnt0CQ/jciKxxZjlmAQmxJ/Wvb3immZuWeVt1T4FxA5P6jGp6ZNFwuSjyZE?=
 =?us-ascii?Q?CiIOnLY8J0La/wWPBUs1eEbiXWQaGHNQwPNF96ByY8+lPniD9Zm55lpsT1wf?=
 =?us-ascii?Q?YCUBuNla03Bklo4rHxzGiNgmeLEQj/kruzManF0XH8KExla1RmeEcsupLzy2?=
 =?us-ascii?Q?5cBB+I90R0ZtbDlup0paERvJxiIsjvhF9aC3hTiNnEi22QkLEmVWKv/uFp92?=
 =?us-ascii?Q?SYiJ89qAdlpBcBWf/R/yYBLjK59cWgGaz5wAIOrvrcEnSmKqwoiUzGdYxobs?=
 =?us-ascii?Q?DA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cff52e0a-613b-4c18-395e-08dab0b22052
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2022 02:40:32.1459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /wrDYWvYlvHGEWwkNtLBVv8/+QxX8w1Gr3aQFrWLR52F5EqSLR0upw2unLb72P6MJ3kgFDwfRWmYCj815ZwOqZcIUwgEMN2m772RCTQxpoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-17_13,2022-10-17_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 phishscore=0 mlxlogscore=788 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210180013
X-Proofpoint-ORIG-GUID: 7AQngRA6-HvPfP-AO_7D8GQ0jInRoN8S
X-Proofpoint-GUID: 7AQngRA6-HvPfP-AO_7D8GQ0jInRoN8S
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


John,

> As reported in [0], the pm8001 driver NCQ error handling more or less
> duplicates what libata does in link error handling, as follows:
> - abort all commands
> - do autopsy with read log ext 10 command
> - reset the target to recover, if necessary

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

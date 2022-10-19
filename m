Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADCB604CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 18:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiJSQKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 12:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231205AbiJSQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 12:10:14 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C24050073;
        Wed, 19 Oct 2022 09:09:56 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29JFORYt032340;
        Wed, 19 Oct 2022 16:09:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2022-7-12; bh=C96t3jLA8YmtlhjUkB0sJ03pZwJjCbsS60vpKYg8TSo=;
 b=JSv/FZ9AphH9yL0seZCxMikTl9U/O5KhYXLEze4HxZ662yjodhwmVbQ8iVJYVIHvImRu
 maex808LjOAr+M++kAFoJBHWq4qTPXkoVTWUE6gvWRM2s8gMFUe+/HquUTbqG3+8otvb
 OlHhkGR8dMLvY7asM0YVk2WIKs0cmK2eMTaELgqxvbu07AcpFNdH5xvLXPHhi/WvWeu1
 JQ94LbERbAamuAuz0IoSERwPEIHdol0WsmOzGKz+wcazGvo6eU01SpxcWoIyCYiMk1Qc
 AzhMtqUYQX9aNAI42gqCdgeX/yxsgwx6GvU2yaOgB3/CuLAV11PUE92rSnedNn7c/tZk ow== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3k99ntem1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 16:09:26 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29JE98dV040606;
        Wed, 19 Oct 2022 16:09:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3k8hu7un26-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Oct 2022 16:09:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JACFycyKKMh1ijVnqUWJ4Mw3RDwvgBvI87eMSqCaCR1wp8Dqcu83OeVzbTumSm9XT9Wm+Yr6f1PIEo1M6fTfUIy1p4/bsdjOSxrCGbfgnf6ouvEoSvimHT80j1bectdHvMPov+6JNR82Mg1oJRcHdtCsUEbI7y9ijWy2lk80LUcWzGq4+PZ7DVi+Y4SWtWESZT9Ba4gVbWy5GUySU0cAeVCUv3eNHKDEEmfMTz7fuysOHKyfReKqyNIIdUpp2Lo5jkof+9DeOVy/a+fARKN3T2pkpnunuWRTyJ4VlHuu+DC9zDYa6kY+pA1futQCyIEPvtS5EYBt+5nYXi+Iz3dJhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C96t3jLA8YmtlhjUkB0sJ03pZwJjCbsS60vpKYg8TSo=;
 b=jL3xw9yCcXX1pxVjXwfO6Uw04Vg+nsiAxiNixfN0budim9mUas4SWFPaYRJYGKwKh+mNb0GIHnDp7GCUPE3sq1wd1OC4xmKcR/rqkTtO5Rh2yxaDxV+JRpCeUw2wHr0L+b9dkTPfXPkE3P7xQKRkN/zzyfi/1AKrTBt03Q/WBrkecfWVtntaaVXcDNVnQasjSeUM9D4T/5efOVSw6Z7OU2i4g6kBg04691QTUv3Fmahjir9EIZD/+23DIci6yTD7cHseAmoJRp6mmN8ZgLoDGRZNxfYzMIro7KihzWhoezAP0LncUDK0GpcSesgF3TUeFTHwKpwR57a33ApwwYWhpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C96t3jLA8YmtlhjUkB0sJ03pZwJjCbsS60vpKYg8TSo=;
 b=JvkPOIXaEIFZ3zv1U9BsBJozilPRuPa2YJ8ZuN5Lj2gvLhuulrosdPJdNrQpS9SJUh1gewK3q6J2KtxlmuNP2bbzxHofC9yf+ogZri83r2BseC/79N99oSG+dReEOEIXFfZGQjVF3Cm7Y0KBA8J2aTK2aHAQxwyxApbP2EEz1SU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MW5PR10MB5827.namprd10.prod.outlook.com
 (2603:10b6:303:19c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.32; Wed, 19 Oct
 2022 16:09:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::1b8e:540e:10f0:9aec%4]) with mapi id 15.20.5676.031; Wed, 19 Oct 2022
 16:09:22 +0000
Date:   Wed, 19 Oct 2022 19:09:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>,
        jic23@kernel.org, lars@metafoo.de
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        rajat.khandelwal@intel.com,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Subject: [kbuild] Re: [PATCH v2] iio: temperature: Add driver support for
 Maxim MAX30208
Message-ID: <202210191943.Pn4IKb2u-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019115539.779804-1-rajat.khandelwal@linux.intel.com>
X-ClientProxiedBy: MRXP264CA0001.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:15::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|MW5PR10MB5827:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f94e632-fd91-415b-cae2-08dab1ec48e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tB3vYbAxgs0dc4jPT34hiD/TJjpQHW2RiJHSoueo/Axru8fKzu1Sci8iGKCraaF/BM8OMEIW98+UipeDJUVR525fFOaj8CQSvNrwbnik/APWgr65rX80MyYpnLDrYv4B/A7gfcnl1s5sroLks48pQbXhkchABzmYRJHWHHYQLTbnN49JDrKhNKG9jLcSVAXJPZPYKp9gl1rw6wO4t85qe/2pzjmsw1q7hL/iWx6qyPRa8d8KHtJKLJ1l7l1sAuXHS95bY0jmTUlKeMbEQX+z+ZgN7RrIe1t9PNAAiwDYU2rJeWlt8ttLgcng/4FXKNI21RvLQNGkKki0eruvDl6oMfPUkXwnegqT3gzXVNL6t5TQkKt7KomWczcQx5glxN5tIdCjexN2AfCCOKGDqNStKntx4PlZS6amJsLJ4tSqfgPV1AT2QRAeuCrrx5CxUOmXmwQDIitC5+u8gfv55D5+vaxR2V6aBjVMqdWkJ2tjoAbK0vYtyDSI6z9njvgBzhiP0q2Nzoiv1qVC6bNNnZlKfmwkuxqNhO7xgSaZ4VaOvCtqSPMdi8kCPSYMiL9JiN8X1hHarxaRW4OCar4ZjCs8LbojGrc/nHabtVhCUO/8tj/fhdRWaQhuynE7ocB6q2BWnK4Z58Z2l6AGJDAgoYBdWC4pJTH9S22ox9PiLKbki183J5dTEy0w11jac613qFUcOsVh6yJ5iD8Sv+HaeWwhFiSOJahrEvLEsnbVLwT+zA7Gx6U4RmyffTSkon3XXpsLmutWG4fV6ihNJVjNMnFKAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(136003)(376002)(396003)(39860400002)(451199015)(1076003)(186003)(83380400001)(26005)(86362001)(44832011)(5660300002)(4001150100001)(2906002)(38100700002)(8936002)(966005)(4326008)(8676002)(478600001)(9686003)(6486002)(6506007)(316002)(41300700001)(66946007)(6666004)(66476007)(6512007)(66556008)(66899015)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5JZx6dSSI0CZtYqphkZ41wmLdovKAz0tpQsc+tVM9fUnkrUrESD7asGD2Igs?=
 =?us-ascii?Q?J+f4royIsGk/ZqNf814G1n8DPrvWfxi839w07Krqu+RIK1IEI6pQ9LrAY7Jz?=
 =?us-ascii?Q?PNk39nUl9pw7um1xzQM+FiSyneLNAtuadpdZ+SitBAdEuA/jWygOF16fe2U8?=
 =?us-ascii?Q?FMp5XfLSRyW497WCFVfrrRhsnI4RJu+Ql7xL0AR35Dc2WdNT/SEl+713GbNP?=
 =?us-ascii?Q?AszU0BeU64RoMJRFjCg75VhxZxwKeKfYNr5xkkrIobRhNLCYsvhRORHUFyPM?=
 =?us-ascii?Q?ux/50pTMokS9+HL/i+ZOt8n5p6v2HH+uDDRqQnuXB/IJooVwU4kwxL6ALAtO?=
 =?us-ascii?Q?llhwCXO0fZpexqk2q+bcLo2YIBW4+blGVGCJ+LAL0QtKha223IB+cVM1ZKh3?=
 =?us-ascii?Q?2PuTs52JxSz0R2XpcMFvJdfQmKOraZV9+tDHc7jhgZ0hGG5AL9+nMHXYMeGF?=
 =?us-ascii?Q?jHyc19T3R+Gz042aipYWYOLB+X7N5hL/EX6waHj4W2B2EfCUhHPmceM60pSe?=
 =?us-ascii?Q?+eOwxFkTUu3Z6K+K3pVG6dUbvW0HgUbFZwbE//6SRUKYKRWKf3agD6ozReHQ?=
 =?us-ascii?Q?k5nYOheiW48BQ0IPTHul5dPp/cdSvrhmB2N2xjDF5jPGSg3Fi0tvNaiTbQPW?=
 =?us-ascii?Q?bB+TnQfApnzwun4otoKyTQc47fbyEtQLBJUdAm112IGkvGDAY1nYzrm6aZEr?=
 =?us-ascii?Q?CbSuTqJokAe0vOANe0JA7dFYmUWE37GUIZs128XdyjPyztK73ibclZVEVU2G?=
 =?us-ascii?Q?GW+G4q527qprrdEmIzX1BGXq3MlxQK5HvP+7R2naemVEnOUMbY7zYKMaSgSs?=
 =?us-ascii?Q?Os187m7h/Nusagznat4GpAbODHB1XCsK7VO9b7/UoZYLx/tT1D7vVB3LzJ2Q?=
 =?us-ascii?Q?/EsHZIA7dYSkzJ58LB/hOIwy/0iUaUirXtYG5Mjm+f1WAcs+NU5UAlF2c4YA?=
 =?us-ascii?Q?1myBBrjmusuryEMImtrSwRwDnHYVRrI7euaCshDAX7XWsLg31oCVtONwDHIE?=
 =?us-ascii?Q?AgJ4xniElSbKYipAnJJnEeMU11JqwB2YF30O2n67tHc19t/v4fbYVTqydOqS?=
 =?us-ascii?Q?O3AH/haob/PJO4eCqj/HDVW9TVQ83OVL6b6FZmbJpjiAjwfZMCzHdXwzheM0?=
 =?us-ascii?Q?dQ0JRqANLgHReFDQm3g3JfKZec1sqb9DFZuALEUfiamtrB/++u3C5CMhuxDA?=
 =?us-ascii?Q?JLJ5Dljc24IyWA9nZPMHDly2Uquw4jsYM/bzpfIRgmnHumzRBhC+ZnbjKIZG?=
 =?us-ascii?Q?d8ZzO24zbzLvJqfseUbhhP/hebJePaYUxCkya6mgkPFdtV+0IlGhgB1aMg9a?=
 =?us-ascii?Q?/qEm6X8NwnS0bsNM/5ffFD+KOVIRrPf8YoBAYBn8T5+dTbmmzaZxWZHYn6Is?=
 =?us-ascii?Q?MRONuALVv1jVxJBdHXd5VZSBIds4bagQGEzXZcu2EE0YNlKq92XLGZU4H5Cj?=
 =?us-ascii?Q?qgEnyiUwOX5N5AlVwSkLBXlDtciOFgYkgpG0EgELqS5uBaW1dP45jBgSJDFd?=
 =?us-ascii?Q?hjLhGTTOZmSbjhOIkHzjHxCkxiH/GoKSh4IBi7cKBbjjxDfdOA2NenPDVvC3?=
 =?us-ascii?Q?wydXta+LBQ8roiUMrC/sQixHdy0PZoc5h29845j7rj1xwGBU44jRVn4oRQoO?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f94e632-fd91-415b-cae2-08dab1ec48e5
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 16:09:22.2263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2DFsmm1X5EgpzDZzCs78ByApQODL+K4KcP3/LcF6f7IASeMcpIRAxCcZg525kI4J0IHx2q53YODpemu9vLzNdg++t3a3AlBwpX5z5+HbbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5827
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_09,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210190091
X-Proofpoint-ORIG-GUID: IKfxpuLz-P2ZNtc-PfFUHzq-6Ts0KPa8
X-Proofpoint-GUID: IKfxpuLz-P2ZNtc-PfFUHzq-6Ts0KPa8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rajat,

https://git-scm.com/docs/git-format-patch#_base_tree_information  ]

url:    https://github.com/intel-lab-lkp/linux/commits/Rajat-Khandelwal/iio-temperature-Add-driver-support-for-Maxim-MAX30208/20221018-195706  
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git   togreg
patch link:    https://lore.kernel.org/r/20221019115539.779804-1-rajat.khandelwal%40linux.intel.com  
patch subject: [PATCH v2] iio: temperature: Add driver support for Maxim MAX30208
config: openrisc-randconfig-m041-20221019
compiler: or1k-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/temperature/max30208.c:161 max30208_update_temp() warn: inconsistent returns '&data->lock'.

vim +161 drivers/iio/temperature/max30208.c

b9d159ff5aa726 Rajat Khandelwal 2022-10-19  108  static int max30208_update_temp(struct max30208_data *data)
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  109  {
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  110  	u16 temp_raw = 0;
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  111  	s8 data_count;
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  112  	int ret;
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  113  
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  114  	mutex_lock(&data->lock);
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  115  
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  116  	ret = max30208_request(data);
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  117  	if (ret < 0)
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  118  		return ret;
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  119  
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  120  	ret = i2c_smbus_read_byte_data(data->client, MAX30208_FIFO_OVF_CNTR);
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  121  	if (ret < 0) {
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  122  		dev_err(&data->client->dev, "Error reading reg FIFO overflow counter\n");
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  123  		return ret;

goto unlock;

b9d159ff5aa726 Rajat Khandelwal 2022-10-19  124  	} else if (!ret) {
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  125  		ret = i2c_smbus_read_byte_data(data->client,
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  126  					       MAX30208_FIFO_DATA_CNTR);
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  127  		if (ret < 0) {
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  128  			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  129  			return ret;

goto unlock;

b9d159ff5aa726 Rajat Khandelwal 2022-10-19  130  		}
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  131  	}
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  132  
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  133  	data_count = ret;
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  134  
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  135  	/*
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  136  	 * Ideally, counter should decrease by 1 each time a word is read from FIFO.
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  137  	 * However, practically, the device behaves erroneously and counter sometimes
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  138  	 * decreases by more than 1. Hence, do not loop the counter until it becomes 0
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  139  	 * rather, use the exact counter value after each FIFO word is read.
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  140  	 * Return the last reading from FIFO as the most recently triggered one.
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  141  	 */
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  142  	while (data_count) {
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  143  		ret = i2c_smbus_read_word_swapped(data->client,
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  144  						  MAX30208_FIFO_DATA);
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  145  		if (ret < 0) {
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  146  			dev_err(&data->client->dev, "Error reading reg FIFO data\n");
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  147  			return ret;

goto unlock;

b9d159ff5aa726 Rajat Khandelwal 2022-10-19  148  		}
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  149  
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  150  		data_count = i2c_smbus_read_byte_data(data->client,
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  151  						      MAX30208_FIFO_DATA_CNTR);
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  152  		if (data_count < 0) {
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  153  			dev_err(&data->client->dev, "Error reading reg FIFO data counter\n");
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  154  			return data_count;

goto unlock;

b9d159ff5aa726 Rajat Khandelwal 2022-10-19  155  		}
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  156  	}
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  157  	temp_raw = ret;
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  158  

unlock:

b9d159ff5aa726 Rajat Khandelwal 2022-10-19  159  	mutex_unlock(&data->lock);
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  160  
b9d159ff5aa726 Rajat Khandelwal 2022-10-19 @161  	return temp_raw;
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  162  }
b9d159ff5aa726 Rajat Khandelwal 2022-10-19  163  


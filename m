Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38E45F1BAC
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 12:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiJAKB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 06:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJAKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 06:01:45 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051F6105D45;
        Sat,  1 Oct 2022 03:01:43 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2914pbTX029740;
        Sat, 1 Oct 2022 10:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=FV0XYytKYJ3AXimb25CEhmQGj8QeDOkeBIYeyAzhqaU=;
 b=Vt8+al5iuLzgsVOw8CtVOWta64h/ZX1ruv0QLj7klvU4derV3LwiCDtOrGRG2zOS+NWh
 ejiPUeCBVCOs97WrGoThV5ZSn1aj4HHxKHxXyk+Ep77WLV5MLNgy7HOKAxfOGjIUcKa3
 BsUdUBnXG8UH/E6eEeJSgDuUA2JJfb4D5MyIdV3etaJpmMm2i+UAyv8gtXG/7ZpD0Ehw
 zNQZnJLhioZV37jFKZ9BmLcsE0AYXxSpv57o+Hf2+qNuORSLWmBFCUr1wSo0xosDTnMe
 1hV2brhKc4ranFO5oQaajzlHtZrBq4ckXzacU+MkGmEO8nup44orDs1K1lInNgqagz5q Ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxbyn0gx4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 10:01:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2919HuhK011806;
        Sat, 1 Oct 2022 10:01:36 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc026fnf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 01 Oct 2022 10:01:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XimMOh3riRQup6rRkT3eV/Yt7xBEKwyqs0ZfNmNXd+YOfVva50EMM+3nUeKixzIKQ0cIbk4yYvQ0/e71f8vbA8wvyoSupVj1f56JF/QPeT7j8ko9Lhb1VtQ3BVbLOQ9LJHpAjxyGS1FFr2xwZe4VQ7AFbNkVlLPeYtfWjascNVr3plOoewU8kPRUi6XEUnni+c3W2n9xrQNpayhfhkYraqadvBhnvz7AyloAat1HB+NlpE/iLuiNSjSItzc271zIzd6qw09SoRWIBEl+ZNM6VXRyJqdUEGBkhxp160gUsvtrT/PMeeLBhpATje37yKrbtqYHNo6YvRg0N3NebgFQ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FV0XYytKYJ3AXimb25CEhmQGj8QeDOkeBIYeyAzhqaU=;
 b=ObozjkHbmofwk6Pl35L9cYS5+0IOS4f5UIjrhHdNoALFAapzRWIOVtK4IUf+huZkUh1lZo6GdhJbrvg8IvRtt/NKwhTyOQOHNWOgXOvwHcGDbkMJqjVC9hpGQNKM28Qy58QkCUwJAWRxZjrYyr1wRxLZ5NfLZfEmJXtkcxwkyFVR2HVGFymst3yEEu4tLLplMAwa8X5nZhlVUhineYqHDfy94ngewfm7qAoRqs1TvYs5RNtxLvOtt2Al+qypI3m/9YA/94JLkdhE35JicTlhtT7d7MA446A5dw3VErBxssUFNF3frreUZ/aYQ72qhiLYAUHik4xPa2e72rRcfGxAog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FV0XYytKYJ3AXimb25CEhmQGj8QeDOkeBIYeyAzhqaU=;
 b=rnfiIY3psA78yADMI+SPwfk7qUoUYv1zTHyQAjDhcRiOAOwM7e/KFD98ZAgpX7HFlcgC78KqnXQduXyjBZMAYYJu9h7SD30kRhqlFHEilp4G4w6Op56jGJJLCI2Nm/q5cLmtUAl4eo57PiHGUKuVN8Wm2drPPLUSaAoER23Ttj8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH7PR10MB6311.namprd10.prod.outlook.com (2603:10b6:510:1b2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.24; Sat, 1 Oct
 2022 10:01:34 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a497:8929:2c6f:7351%6]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 10:01:34 +0000
To:     Rafael Mendonca <rafaelmendsr@gmail.com>
Cc:     James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Gaurav Srivastava <gaurav.srivastava@broadcom.com>,
        Hannes Reinecke <hare@suse.de>,
        Muneendra Kumar <muneendra.kumar@broadcom.com>,
        James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: lpfc: Fix memory leak in lpfc_create_port()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfk7j21y.fsf@ca-mkp.ca.oracle.com>
References: <20220916035908.712799-1-rafaelmendsr@gmail.com>
Date:   Sat, 01 Oct 2022 06:01:32 -0400
In-Reply-To: <20220916035908.712799-1-rafaelmendsr@gmail.com> (Rafael
        Mendonca's message of "Fri, 16 Sep 2022 00:59:07 -0300")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0048.namprd11.prod.outlook.com
 (2603:10b6:806:d0::23) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|PH7PR10MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fc6526-b932-4890-c6a1-08daa393ec1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MN9wIcs9Z1Tev8A+5Tk3CDTVQx2jYjKTv0xHGp1pKRK0q2+nQbg1wANGS/sRsKWuWGba3LuLO8RIaO/1EQ51O1fZc5NXtgZYPhz3z1SxihagAhFhHKygND1xzhloze5wkpzzjOXjKl855G4YCQqFfRxaYMTpTQqWAH6pJnnM/nZLcCaffaamnSAZ9qdZC95s3QlfGSyIzcdrfwV3+nKicJ6dLf5Y8e5dTP+ZVH31L9uA0Cu315DMTCoWGmWvmMfJtXsiDGxIId8rmR/n+vr4FTf9640RfvzCEbpV0YBuQZffZSAgB+Hm9A3Gm6ur5I5xkwy69fBiaxpsSNlv/m6rM24RwI1xSFgyirP7woSrqtVTPbL544+9sLeKFBBXAjReBM6WBjI+o/ABQruLy88iUdOPVce6+nFmwMfLFZAB2aF5tCv0zbJOhZW+7G6HS5ABcAIsNedynKUfEb63iN2vV81FYF2lReownsprsxwDj5OeobJGkplnqJYg+M9H0LkTLc2N+ZMdsIkj2i8EeGv/h24fAb+AR5aEA2m7Lh6l26E0lTpW+EFQsFrcNM1nuTQHOuM23Uf2lA7IpFBD0kb753dFlC0eVtPiGx7vJxYWpp6VtaAWpXgVRdaXIX4KOzlqv+V0x775OBbftMc7JuroZm8TcFKLf8gRbh9VG4WV7nIEtAfO4K67UT2Zzg6WPn5eoPY6GheBHQ1m4tc9azZIqQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(376002)(136003)(39860400002)(396003)(366004)(451199015)(6486002)(41300700001)(66556008)(66476007)(8676002)(66946007)(54906003)(5660300002)(6916009)(86362001)(4326008)(7416002)(38100700002)(4744005)(8936002)(316002)(6512007)(26005)(36916002)(186003)(2906002)(6506007)(478600001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mas6XxesUcE1gdR+ot2oegZpxrGnKYnQpqVMGSncwm2+Huz+oYV72IzTNB5M?=
 =?us-ascii?Q?/+u/JWwezwq/X05hvEPrpZJD3HyOGudrBYUVtGzcaU8smojhvHrRT/nj4Ofo?=
 =?us-ascii?Q?HGbOWvHBf6+6NwXlvHKIV+PTwLvAEmhS4nG1nKDMfNGAtApbilD9wyfEJI8j?=
 =?us-ascii?Q?KQD+jUsX8JWrO7dDMFLqW4kYTjKhJC12RZ4BvgXAEP5eFcVJzjgC2rsyWVS2?=
 =?us-ascii?Q?9/bvhn1L6HOF+5rqDK5MVnsQUjvSRuGG+VJ5Intl0AdNY3Z+MnT7ZqSfz7oc?=
 =?us-ascii?Q?7vRIpHhYNQAgskVEndxG1tch74dwHaLqL+N+ESSEb709YtxbkoGPR/oEs64w?=
 =?us-ascii?Q?ZpoAI4zLpCQGPoYHBlwQCV7Ds17gV5IGNahFFm86KbHWNPyfFi9BKE4JVYTq?=
 =?us-ascii?Q?EJGn9jSM8I/s2/DoeE7cmtUc8q836o9tzaxtspLN5ykPvF8RU0Tr5gh4b9j9?=
 =?us-ascii?Q?+VOIsdU1IyikM9mA6bIQyeeMr5MeBmXkLI2S1pqhgcLg5GAb1FUDezxfv8vC?=
 =?us-ascii?Q?1eQRUljUQaFIrFhuxN7gMuyYMA2WjXdivuABatg1mMoCms3iyZkoa02z4ymL?=
 =?us-ascii?Q?ZDfxUU9DCvGhJEqAN11Wr3YC/wrmC/nnQjwsT5bwEACWNSwBq+6TuxYbx9ep?=
 =?us-ascii?Q?N7hPRvY3Elwp3XMEPbRBAO8CUiUNAYgiZv3H7jUtnj+Tu42rC2uuf2lZkVcW?=
 =?us-ascii?Q?pADIMa/oMpoY2niQj3JlfddfdiENF20kwk1xDaEuLka7GX6dnbRED/NnDk4u?=
 =?us-ascii?Q?HkgVOfzX8MDVX98N1zhPG8UozY+wo7i49MH3DlXkNijOK+tdhIYyIhVv7+eY?=
 =?us-ascii?Q?nC3t5JvYwYVPJnZhZEv5aTzt6Hg7Dzaj7swhaNdJzXB/LJz9uAd9rJpw0j56?=
 =?us-ascii?Q?IVUVGtAlLN9JrRGQ5vzXRUlpsyPd5XuOs8kuYOH5u0Njn4us6ZcK8YDXYIQf?=
 =?us-ascii?Q?vLM6ai00iC21qiDZcuwfHnL8WGFwkw6tyq7/oVU8dua6Sb9hUeuIOvvHFuti?=
 =?us-ascii?Q?PhHGgfhH1pOa021hHaWgjfylVL583nCiojVsXrqmgh9VhMp+jGtGhjddQI66?=
 =?us-ascii?Q?8m85K/p+5CDRh+2+DIh7H4TIyJzHb2dyP6xkmth1CqDa+4iHUiKY4hzIWaPf?=
 =?us-ascii?Q?xX9k1ZdQ4J8BeyER269yjL57Ou5AGnCEvOZEljzA3J7vJZHgbS+h7WX3PWm6?=
 =?us-ascii?Q?ik6TwGU7zkiagg/H4eMriJ8NwcOERZLMNwe9WG3fQoOUzAaR46Vn0eIU6Sug?=
 =?us-ascii?Q?70JUJ1qn4dYLZlT4sDZr6WAz9sFMUzZ/BqXWhQ21uqUyxTpJ4eJ+Xl56+H0I?=
 =?us-ascii?Q?qYuPKDoWfL9Zh8S/hEK8iRTeS528uX80RI16BOVCNluIlLLAzgZSOykHOzqt?=
 =?us-ascii?Q?ZqEofg9dFkynwD+2fTMOCat7dGDBqpIxCwQrFHwgCN7ogd8xMKSG9FM+2PbY?=
 =?us-ascii?Q?r3bqvP86f38gsowvUfoDKGelos9EO0Wp3qI+xnJzFUX8xjZ0va9Xs9w6nvTg?=
 =?us-ascii?Q?WwUarPqUkNWd76SS3HwZyacLQOQyOj2OShsEhIcH3z3vAntUmMLtH429VIiC?=
 =?us-ascii?Q?q1EKLwzF6OswVeN5dakEe8qbeomfdGDf3oxKUSHqBez18+2Gj7OHB/nJRCBp?=
 =?us-ascii?Q?zA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fc6526-b932-4890-c6a1-08daa393ec1a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 10:01:34.4606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H9w/3pqzXuBShpLkjTXO2tzoMVP1PG4n2h3sRhaj3Z5hUaE42aZNjrhsBrq2is5hdz/GqcM0ACLiyWUfux0Qi8E8GBpwhl6tTTzyUK31zTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6311
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-01_06,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=920
 suspectscore=0 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210010063
X-Proofpoint-GUID: aEK5kggikroCWJf0yEqQ9tbnCoj7ftIc
X-Proofpoint-ORIG-GUID: aEK5kggikroCWJf0yEqQ9tbnCoj7ftIc
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Commit 5e633302ace1 ("scsi: lpfc: vmid: Add support for VMID in mailbox
> command") introduced allocations for the VMID resources in
> lpfc_create_port() after the call to scsi_host_alloc(). Upon failure on the
> VMID allocations, the new code would branch to the 'out' label, which
> returns NULL without unwinding anything, thus skipping the call to
> scsi_host_put().

Broadcom: Please review, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

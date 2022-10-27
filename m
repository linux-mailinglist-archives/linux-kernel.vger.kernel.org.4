Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48AA60EDE3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 04:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiJ0CWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 22:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiJ0CWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 22:22:32 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCFEE09FE;
        Wed, 26 Oct 2022 19:22:31 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29QLF2fO022198;
        Thu, 27 Oct 2022 02:21:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2022-7-12;
 bh=RUdrR9SsWBIFz5qfWYKyOKA25I/8ov9YyCZTmsCN6L4=;
 b=EKNbMvaLAA41n4XaUarSU5xRhrknega9wyDKkZ1qdjU3J39HAibWEGZ/sxXu8U3odl+S
 px7fRvD+VBUhsGn9fRk8/v+iAoEgnsIRpj5cbTeLS8w4hK4HL//FIeZIixavzuaOHMj2
 xw0NG5OV+7jvpWSNCdSChcozPL3rHL38Zx/XzywcXH2BrivvwYpXFCadKZHRussMDSj0
 DhZfvUIO9xHWxCmNsKzvjoWAk7jesgMQ3tqEEbiKnqAf4eP86YfAijhUUL85clTNJnf9
 DAOi9hlNJvJ+GMVt8mOhstfCONhXTsPg3Zv4B3sc/f/U/5ZM7Wqykxs+Y/AuISoDp4iP qQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfahe8ukh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:21:38 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29QM16s7009431;
        Thu, 27 Oct 2022 02:21:37 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagegn1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 02:21:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EtjNyv7VeZ9QXvmj0wd9kVAdirJ8Xkk3lSxPw3GdzIkdpPQAgzHRT3W62AkBOsqTRBllPz5Y9RDYpOkp1MBdfIeuMN8tggZbUQUSwIw6cIqxaWFTRTcoaAG9OwrTsBOEkeo4em/dd92daWrm/M7TvWOepheyiQim5b1bw5x7gK8/5+Xbc3mC8GbeIKWKw8D1ddaszWpWoRSZCGk0AvNvWAYC0cdVsAA2B3dwbrMSnC43owFUp3ypvwea3jSoFScmVWjFoH3XW5KiKewH8ycl0F5ObOesSNycl3/L6I0NfhhiiT7wVi7HX4t8/oci5UzMG91hM5fGlKutNN8Xh9++Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUdrR9SsWBIFz5qfWYKyOKA25I/8ov9YyCZTmsCN6L4=;
 b=eRrjnUFASER7+hu4Z+nkgwb6/bUrGoK7mcL4hbJ2Y4+i0T2XvasrSg0bdrUqri/Y4gz++Q6WbDGXqvV0H9+odHO2wjr0l4XK9Bt0byerg/F9Sm+4MWP7OCYowMwCEeAAksGX4NHbFW8nbjtnYdIfCRF2JVp8qwZvW9GHQTvBpkSe9sZ7BN7u03opD9SYaGh+SCj5jNVOrKj/QwvXVYW1yfSVbch6PdwcEFV1bYTLTDJGSScK3ndwQiEpNrzA3ZmOLMmMEVPmz/6bOHpx5gvc+vztnNI//Vv7sniqUmEUcFaVPc1ffG3HxvfDaPTMW+gnaA/EzRUp6E3UUj71/1S27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUdrR9SsWBIFz5qfWYKyOKA25I/8ov9YyCZTmsCN6L4=;
 b=k8KPc1G0d4h2+/BGicZ5lYUgVkeJgQHB7O6YRUsj2U+czUl2B1Q5ZkSjdVTwKbOakEtUBbdKyJ45WngMVD6bx6OhdnjGx0S4bhXtvHO4GpgKSeKYK/1AwyYC5sUypMZexqD5G0hP0DHN82HeMJXamnSS3WREiNr48uZiAEp31Yo=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ1PR10MB5955.namprd10.prod.outlook.com (2603:10b6:a03:48a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 02:21:35 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::17b2:d97c:d322:c28c%7]) with mapi id 15.20.5746.028; Thu, 27 Oct 2022
 02:21:35 +0000
To:     Bean Huo <beanhuo@iokpp.de>
Cc:     alim.akhtar@samsung.com, avri.altman@wdc.com,
        asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, bvanassche@acm.org, tomas.winkler@intel.com,
        cang@codeaurora.org, daejun7.park@samsung.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/3] Changes for ufshcd.c
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o7tyropo.fsf@ca-mkp.ca.oracle.com>
References: <20221025222430.277768-1-beanhuo@iokpp.de>
Date:   Wed, 26 Oct 2022 22:21:33 -0400
In-Reply-To: <20221025222430.277768-1-beanhuo@iokpp.de> (Bean Huo's message of
        "Wed, 26 Oct 2022 00:24:27 +0200")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR07CA0100.namprd07.prod.outlook.com
 (2603:10b6:5:337::33) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ1PR10MB5955:EE_
X-MS-Office365-Filtering-Correlation-Id: 30c8b2bc-7e17-45cb-3aee-08dab7c1f8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EIoPxY4S9lTwSxz/l4R86rfTZJo6R9CaofNrup8aXFKPCVy/7J5wiEUZmjslYnLf5fpnjvtfIXyRosS30Ieo9V7I9I2HSyTAVhluVFIxDwlevj2U2WEk6W2G+puoc1iLm73CFRB2vl48w7nx56Q6qe1qaHVosYRd7zNkD8oUIM0YwQgJInarr5KW4WGZXcMPwfBSOYfth8hRwQK2eBrhFmgr75aT+MeZbD8qzjdecH95htSjWA0ypGSJeyxWa//uvl+rMaCgDTlZFPcrSINWgk2hT22Bsv0f77GF3dqA6hG5qebuVr7Zudr9MUzgKVht1nErXoho0sP6fYqRoadQHATNTxJ9NHuHiVsrccMWAxep5IOMrLVhNiH+58Of9W6dHe0CO/QwPvaX5+U0eDr4z5VLeNBbcVj/mzjfgZoP2m0eoy4Zv4BBZJm1hkRdL9XbMMJkThXUBKVsHs6RD8Z2oJO62kE7w7xveMQ9COFXhR0dHw3+dNiDjGpC+pOxQaYxMmLQRYCOuJSapTAAqQTptSpSJdqSqwYZCdfhWfOHJ2w67gpHFcImL6Rs9p/RAV42Nb/wOVC4/XVOSFA6YDrW4hUeHixEkGwkIoIsyH/ycLlCkg5aWeMDhAizEjkDRcjueiy82QUxL4ZwVS2iz1jnrxRWxSY8S4tZyEuCqWqNsiqBDKY7WNUs8NPgyl+JVruUeicmHmoL3iCbapc5YeQCpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199015)(6506007)(6916009)(316002)(558084003)(4326008)(6512007)(5660300002)(26005)(7416002)(86362001)(66476007)(2906002)(66946007)(8676002)(41300700001)(66556008)(8936002)(478600001)(6486002)(36916002)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAG+X805N4gJuJquDUucDUJysMJm7SvuUF8d0ksUmyl1b3GtK7rnaQXsBE5G?=
 =?us-ascii?Q?bETylq2SE5qFmrjOoP6cjRmPtpiTFN80bO0D73h55mxfKYx7fWshqhPka/bS?=
 =?us-ascii?Q?EGLKaOm0tusaHjJ4BA8nR4oxMoql/7rVofPNamiwsVUX2zYShj8WflUtQEdK?=
 =?us-ascii?Q?XrKlPPiz7mbWUt/nJsKRU/ofJOgFWQCjZD6nlMGtAyp+22SbYLSxnlRlNA1/?=
 =?us-ascii?Q?rRYoNeyk/ppXgoTFLW+rVwx5+eAkXWKFdRLzhY6QUXS2w/EBUNZb72G4yJik?=
 =?us-ascii?Q?WA0hNVpMWYLjs86wQURdfRYdbzdX+dCUrsCzSFOewwGJbTOuQ4gW6VWPHit8?=
 =?us-ascii?Q?FHcu1ysyi1Ys9R4VDRIMvDp0YgxM5vt+QLbGF5XOw+ymN28hNSnTUOg9waw3?=
 =?us-ascii?Q?WobU3gxuWrQXFQrsgxlt0zn8LLDDZpPKwnB3fFZro3wRQs+TAY2AbyWNF67e?=
 =?us-ascii?Q?nR8+MHk/xk3AvXX4lxwoTOW6BRPxmOi7UckhwOhKoJ3gVzkMGNIRpWDYFpJS?=
 =?us-ascii?Q?mktca7JUjxQ1J8wKQHuT/HXF/U9YtaR9pP3wtykUfu0dQ5V4AwIX1UJcnPiv?=
 =?us-ascii?Q?IVhZ/UG1woftcuW6F+DyeAFBzkEkfQGbsC2vRxoDHY4p4vyCwrB068Tk37eD?=
 =?us-ascii?Q?F85Q8sv09EQ5GFaUIPOP4U0dor1G5WkQ8wP4h3PcWjSVwpFmdPmZPgDnf6zk?=
 =?us-ascii?Q?ZBS9buwHNShZXxfNVMDRjmdvGjzZH2CDHfri1FTdiCw2be3gzc1/FK5BEXDj?=
 =?us-ascii?Q?ouz23YBjWVnNFT0NGH9hP8dz34Ilkxns2TcEEaao3xQzj/o+tfA4nFMxRRoi?=
 =?us-ascii?Q?eTSPJzPiMp5pBG9DjKDj6W9PFb/3+TV3RSccmu8KdeqRIGgSNPG0pTYLUdnX?=
 =?us-ascii?Q?p35KDM/l2ZTqxfZq95WSmdhY7o2Z/9B8SEm3H4DC1NlOz8Rv3BEErVw8hP0l?=
 =?us-ascii?Q?ltGu8AVXcxeL+Yc04C7H/RdCTWgmP4ibjjCRpkw8a/fHGXmZt2Xa8R1HhHtC?=
 =?us-ascii?Q?gfNobs+j7AAxdkL/l7n0tK9+dx/pyePpH784QnaAy6kz0NqDesb1XaDi8cKX?=
 =?us-ascii?Q?lhvRuSPzfxEIQnbhUCOCt9Ig022ArXBeXTOu3CC/TGpDF7CQazwCKOJIYRiK?=
 =?us-ascii?Q?xm6sQhXw/tpoBhpegg0m8nuutajNMC8zIes2DBlIJrjpKgUlsvlK/lPA3vZY?=
 =?us-ascii?Q?5Gl/uu+gsxOt1pqXvw7SAmBY5Dn324OPH2Cb1jFA7DpbGQ/JekNm74kgXldV?=
 =?us-ascii?Q?oAuQAVF+3T94/2TAPjDb+1mgQ9fnPTgFYcRwAu7zjK348lxNH7lqyuGyS0BY?=
 =?us-ascii?Q?QzaJ2E5riQgIaZPwWUjBAedTh8qvwX+DttVCdGL/PBN2+PyWOyuBEGdf5po4?=
 =?us-ascii?Q?NCpodQd4/zRe0T3nLD4lDB3k82b1ZvKh0yKDhlY4tNHQsSZkpOUy7d5Mg1RO?=
 =?us-ascii?Q?+mgmwFOuIC792vfxm/W/8re/93cFVmcynThUa94XpBllj/lNkR7/a/7upRgS?=
 =?us-ascii?Q?nKOrbvmyGf/RU5JJAxpkLS10YekM+lO8oosdeO2WlScsfueSRCY5QbkhCuwL?=
 =?us-ascii?Q?GLIn9DWNA5ql68F7G/Z24LEhgIIquU/6oF3aq2Mw3CSFfLLpaIrjB4xCFlj7?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30c8b2bc-7e17-45cb-3aee-08dab7c1f8ae
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 02:21:35.7273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YgLJ7jPbhWLAtAGbanu2DaOA5bEWC6v3C4Nwyh5kz9X8Tmsvu9NBvwPxO8FPnYL3s00+nr263prEq5/O4Mj+lyk2yYbaVflkgmBOE4cbLyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5955
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-26_10,2022-10-26_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=936
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270012
X-Proofpoint-GUID: 37hTYHRI_Sji5gO7Cg0YCrlWF4VirNX8
X-Proofpoint-ORIG-GUID: 37hTYHRI_Sji5gO7Cg0YCrlWF4VirNX8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bean,

> Bean Huo (3):
>   scsi: ufs: core: Revert "WB is only available on LUN #0 to #7"
>   scsi: ufs: core: Cleanup ufshcd_slave_alloc()
>   scsi: ufs: core: Use is_visible to control UFS unit descriptor sysfs
>     nodes

Applied to 6.2/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering

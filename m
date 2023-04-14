Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D2F6E29D1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjDNSI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 14:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDNSIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 14:08:25 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762FB9EF7
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 11:08:15 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGv4S5019418;
        Fri, 14 Apr 2023 18:08:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=IfWrzQ/4jQ6iHGGEcbqxvtm3N9cw58nPvC/mpf9Easo=;
 b=dtuhXXvzeIW9nX2PXiwBHk9JTafVvAuXnAkUS8moX2q4RKxlxTM2wR4a0Ceui80Uee3w
 CRU4Lmd32B3W5g+1DlbGV8N8Btpc6esudiNFtOduRAvcW8Gc328htswHhb140D8WfHOa
 zfS0+JL6163hYAD3DasNmPWjurMm/edZ++9DWexTVoVe5fABwMVjMQe6mMgIrvlVj54+
 5ltcbXf9AEv2hwIyb9W7Hy1WQclPkkJgP8jq1cjyUs8ZQTM9ARObwBsb5mTvLbU5dFYU
 MPOuDIQ66cYDB2rOsGJVVBhyw83cZIBK9IISbf3ujyPRSJtTBNwIEvilvDJYbcQPOiDQ 6w== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0hcek40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 18:08:07 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33EGNwfY018894;
        Fri, 14 Apr 2023 18:08:07 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puwbte9qc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Apr 2023 18:08:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5xYvqyAeGnGHAIJbtbqMeE1OetbVxrnqMvESyfU6byCyKZNpgDWXUTJL/v4bKSritoLWEigH+4MqPGAhutXHu7QjpTYQ/qMI3uPvGCXxDGKSPHG/reCqrROF9Hc7h9GBgDTl14XgRvKoiQ9CFbuVAC8WickzittIuKDMUQNKMTJ/wdD+ZzVYW+ZNkHSASwceXsmHhQXRTg8vI+NZmULhX66Nb3HsOq3smQKYJHB7F9bcH/pPCqLP5yY9KDj5N9Ca37WftjZ+mlq/rb/0v5HqXKkC8EBAwneSku66dkdqGALboUA2MdwSsCkfj6yLHNUI5Xq5bBgImJcPTsxepVfRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfWrzQ/4jQ6iHGGEcbqxvtm3N9cw58nPvC/mpf9Easo=;
 b=dlvzvhcrCNqGW47wCMWBPGmo0p1nSrWzDczdDKvFpQyn2xxeycFyQ8qkaQIy07dN1lLA7eU5QK3VO1VPzgLlb9uXDpCaNTvHhCPdMqYIQ9eiWNVEMps+ZNoBXZTZ3ZgtIozpginog6/9mhbRyMBweIFmZMkCJ2WZQmIhO15NVmNHygIcpUGjpzFJaDrE81S4V721pK88KDXnW26b8cLt4FopU5+f3beexsjWIjSCMLA7KoKTXzjDkZLIi8I0MuSpLv3f3u/uc6yxD06yPDTpMQjeLwPGu36bVYeYyG9Cq1UW4tMkbbppCy4wmy4UX5z6pHfkqXgYuZsguWuk+PVB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfWrzQ/4jQ6iHGGEcbqxvtm3N9cw58nPvC/mpf9Easo=;
 b=xgo09vomc9gwBTSvLAh7Fj6SvpJN+0ne1Rt5wdlJgc/UYuOv7by32Su9+9GL/8ZzGo5oIe1dGKEBKag+OmQk2c5eK85IbuclUIRCqDwnxn3hMdEoBIAGXbfzSKP6qa4AA7GI2rqBVNx94mhS5XLZYuyQk60SIfI0GwJGgoWgyYI=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BLAPR10MB5300.namprd10.prod.outlook.com (2603:10b6:208:334::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 18:08:04 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8bb9:2bb7:3930:b5da%7]) with mapi id 15.20.6277.035; Fri, 14 Apr 2023
 18:08:02 +0000
Date:   Fri, 14 Apr 2023 14:07:59 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/mmap: Regression fix for unmapped_area{_topdown}
Message-ID: <20230414180759.zves3glmrptl6zog@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
References: <20230414145728.4067069-1-Liam.Howlett@oracle.com>
 <20230414145728.4067069-3-Liam.Howlett@oracle.com>
 <3bf69efaeddae3599a6d7ea8a225f64066811473.camel@intel.com>
 <20230414172610.f35pngvz6cilxsdq@revolver>
 <20230414172919.ynxybbocc4o4tbtd@revolver>
 <3f30fe59dd6b368db82ae91b61152bb133c4831f.camel@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <3f30fe59dd6b368db82ae91b61152bb133c4831f.camel@intel.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4PR01CA0091.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ff::29) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BLAPR10MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea69e0e-3fd3-4c44-21b7-08db3d133009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Zy3CQoV2Y+glOim8BNr7y7IijKIJZrl6E3pNGikChr5Sa9QHWgFWw4skErxEr9L2pZu3VvQuCt0b4dpkH3YC9unZ6/kxSjEYme1Jyvtq4VF7lMpRFuywwi6hxeMeyyz+E1YmRLq7Xrxsfog6k0sL/BD0Ne4ngbPD1qhbENW6sLRwyxJD3gQAOQC83/2FJyMhgrjlTdtd/1ln+YU5p3h3OVOn8S4jaojULD2hyyPvDlAQSDE02DcdeHrhIVac9uBEei5xDZ8sZ1XGtIxViCqO3+tGaRP8NG7IA6DRyohZCBeG7mF7FGVYlIy1f0HlmFcaHeBgK13lTMgLeCM01ag2Lf0FGBvgQJ0o3uRYPsOGZs22xp2y79XCp5e0KGZB2UFA6W45QqYfkzvjJv34QiAUtb0p40l9MGmTra6UGmGrXqW3+pz1RzEIdLKc5pRhlr1bed+Le8JDxFXb1QLSHeyYxelvCX5wm3aDmPdGXrrP2HAJU4HVC1RPQ2LOCSERTvhOzt9NJuNZ2o+lLOoA/UM+Bq2mjQYBViUcGhY5cC4Xpn/rqqaUKEZyvjOWOlcxJs3V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(451199021)(5660300002)(8936002)(478600001)(54906003)(6666004)(6916009)(41300700001)(83380400001)(8676002)(4326008)(66556008)(66476007)(66946007)(6486002)(316002)(6506007)(9686003)(6512007)(1076003)(186003)(26005)(2906002)(38100700002)(33716001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?6B+vfXhMTfaZnR/efax/pQCYj2AzMVP8CB1SoWu7o8pbrBv08lWXpaHezS?=
 =?iso-8859-1?Q?oXhfOXFb/D5sdQRy9T+eFQYQFPinqJp+Oa4W1G35Adby8zkoTyLbQXMIWa?=
 =?iso-8859-1?Q?ANtB+IxCzv10t+jVv7NjUpH9+Ows0ARdU2+b0Y5FYO2cTNjpnZHYyX9vPg?=
 =?iso-8859-1?Q?1PPuBZkQuwR8/89TMYaEUbJFootkeYQRVj6XdOxYFSMva69ijcucJa6hNA?=
 =?iso-8859-1?Q?mtkjcvzAkzqKJ/QGAfo9p4fFiGzcG8HQUbne6evqA30uweH+DPgLvRfGh6?=
 =?iso-8859-1?Q?qn22NDlkcUj/rIpaFxv1eD1R9qikcO6+8cJQ3NjMckUua2LfQAVw8eKGZM?=
 =?iso-8859-1?Q?7ca5VXjbomwpmZepkAAQ+XXTazjF/1VFL7VxK56vbcwQzzMQiBQkRp7/Lp?=
 =?iso-8859-1?Q?c4udAIykHGio5YZtRWRkr1MP/nlgeB4pxtlfSfrQ9gyyclKffgN90SiEJB?=
 =?iso-8859-1?Q?uosMvuakyBuI1jbtgNtyYuyHBKABqJxURw/C7YGl3c0uzkzVvLXwUZwqKW?=
 =?iso-8859-1?Q?oApffjfN+g71TqaaZEkYrWbtBMRWM43Fx4sO58zSuPUbUjXCVeG702kgu0?=
 =?iso-8859-1?Q?ipz9BuIbhNyuIQ0b5dxdquAnLNRrRxB/oZHl0sD02CsP1Adr+Iw1sFB8tF?=
 =?iso-8859-1?Q?Me9W9hXlR8AbLnqGgF7nNedv+WIX0ery2CkjatnTgNp/+vZtix1HNLqElo?=
 =?iso-8859-1?Q?aYH+4wh7RdVaB9Ydpa+U1Ds71GqbwdSyWrLn9PlVUSkG3VAXBCA3DGdN8z?=
 =?iso-8859-1?Q?k5mDsqdTSEn7ADFxWpwAvM4t7KoULxwdJC9EQwns0ccg+aVk122YNlfbUN?=
 =?iso-8859-1?Q?YPlCI9ud4ytalNMIalXKy+U7trxix5yXDwRzLm1BaQsQrHWYHpWKPOZrTX?=
 =?iso-8859-1?Q?wd2+OHd6uj6DGkhSXveV+xuhRTLeUZPo0uCD8eLikuUQ7yTIJtDJ9DW67S?=
 =?iso-8859-1?Q?cNME7Ef2Kc4uhMRnQ2XOvGUXocdcv2/bEzQlnkEOoLZ4nUdpZEzEk3LLbN?=
 =?iso-8859-1?Q?woGJdmStBs8KTrB3vFE9s7s+2Pr2L0b8/Eyomjx8hZTE/5wTI7z2PzRoC6?=
 =?iso-8859-1?Q?3eeMVF8yVPxZ6wAIbHVXaWEr60VqqrDRjFs/9dlsTGE6U8P8kNwTOhajNM?=
 =?iso-8859-1?Q?Xg9d/scOXr1/4WFl6oMoVjHW211KrdSVJtJxbqLN6l5utNX+N1MOwzMdxr?=
 =?iso-8859-1?Q?FXxBFvNPrntvTpGfDbVvIySF0gZXcw4SZMNiar2BgDz4iP1hYQxHz5ZlsW?=
 =?iso-8859-1?Q?smr/NtFQXk87F7gtfz6VbLrasYQVIqSsTXkEcRFpmD901U44J2+j6QDX5E?=
 =?iso-8859-1?Q?UFwPQDyw2bY76EzGqlfV76ruAsuW0o64+Xhl6XeyGzA4aGAG01P1AimD1P?=
 =?iso-8859-1?Q?0CE5D+sU61F2/YeLsDOraVWb9WjFJdUTtuThtCkwSa6zZ8iPc4fhSX0v8s?=
 =?iso-8859-1?Q?eqll3VRTfN5414tolDEgYYAVgNU81fgwdP/AOMHzOCCEFiTVSJfjhCOpfX?=
 =?iso-8859-1?Q?J0vsXMvHr+pOsWH9hhcxcpFBUHdv15cpf6LrQq6JC2/cKsiQ+faYI6+TFA?=
 =?iso-8859-1?Q?RP01ciZizn9EQNhBIsC2xpL4TyIFaB335/3OgKl8jFcV7gIZ9zxAdJdRRW?=
 =?iso-8859-1?Q?gS2sDVHs0jwlJQPbkDmx14yY4SEtH5iO9EFjsT5Z6Vqkf7jTznZ5TDlA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: KCE2wGIPTaz6qj03/jZ1oYnIlkoQvA2968e7YWFSvc9UzZtzhwV7VaOx58ZfX4zMeydiLAzdbcs01gj9XL5cXU+vqD16AyLYHQfhQUb42uQKlnw/x/2RsKLzAdu2giJpePvowHBWm1zBlYrTwxtYFc+iWX924jcmXs5Z+d3traYLA43ZTztxZX4m833+7TI0w0F4znuECTKK3CyYoQCXwErDtFK6nu+f1XOW35yxou/NVK4QWA7UbgqKFyV9r6ZYo3h857wruzGeucr1GmGpsOS0Bjcxj2pTwZ8W8TyzXZwoQaHdjnyFAPe6cs9/Kkd68e/7zP2frx1SD8Ior3C1+cXR8YMykAcqvvhcVwVFtvm0xPYwExdclZC14MhMrGUIAgt100GL/XxHvKcsZb+m/AB5t8nCE2pKwyoUx0gdCVM84tDR9pRuGfLv57Me466EyYIIu4zU5Ltr66YPPEAYYac/fC4gCHe0AXnY5CPki5CP4swE0LSa89DqU/8VBHssxLxDtmwxn82cGfS4QzBg1dU8+wE3SYc5lTEEBb0uwdYbtBFfmkIFb0ggurmKWcsQdl49XVMiQFBX1k6ZQ+Xr9rL7Lrm7VQjcgGEg4a5KpK3dPA80ylyqaTbMXBFgnpofJB1t2nyjQpb3xreY54gdh/GBPC0dkAXDWZQtUfHC11m5twrQrZK9NKRP90Dl6VHxoHFtdPcFCFmHocCfwnGYloWg4f6RXS+NaR0i3T3QZbgC5wXDrQCr1sZGnEyDFmiaMngSqOMrsymbLBKyxRdRHtHKUA0Wt860nWKqJUMPboOD75mCKwE9IiEnUL/7QrpOEVYTSSdk1oKiZlCPoCSrbExz/WqbTOALvX4Fji4tf03aU6KsFyorOFXd8nCo8/sx
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea69e0e-3fd3-4c44-21b7-08db3d133009
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 18:08:02.3600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PssiE105oaiOXAzJp/PfX9EN3YQAFRRR/AhYYXoYnzoN5kRhhiD8pgfTaWsca7ZNFrPy5ZR8DfMzOlLDVsRkZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_10,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140160
X-Proofpoint-GUID: J1L5pkc6kzH7a6Wx6wzToppgYiFQA5II
X-Proofpoint-ORIG-GUID: J1L5pkc6kzH7a6Wx6wzToppgYiFQA5II
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Edgecombe, Rick P <rick.p.edgecombe@intel.com> [230414 13:53]:
> On Fri, 2023-04-14 at 13:29 -0400, Liam R. Howlett wrote:
> > * Liam R. Howlett <Liam.Howlett@Oracle.com> [230414 13:26]:
> > > * Edgecombe, Rick P <rick.p.edgecombe@intel.com> [230414 12:27]:
> > > > On Fri, 2023-04-14 at 10:57 -0400, Liam R. Howlett wrote:<br>
> > > > > +=A0=A0=A0=A0=A0=A0=A0tmp =3D mas_next(&mas, ULONG_MAX);
> > > > > +=A0=A0=A0=A0=A0=A0=A0if (tmp && (tmp->vm_flags & VM_GROWSDOWN)) =
{
> > > >=20
> > > > Why also check VM_GROWSDOWN here (and VM_GROWSUP below)?
> > > > vm_start/end_gap() already have checks inside.
> > >=20
> > > An artifact of a plan that was later abandoned.
> > >=20
> > > >=20
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (vm_start_gap(tm=
p) < gap + length - 1) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0low_limit =3D tmp->vm_end;
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0mas_reset(&mas);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0goto retry;
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > > +=A0=A0=A0=A0=A0=A0=A0} else {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tmp =3D mas_prev(&m=
as, 0);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0if (tmp && (tmp->vm=
_flags & VM_GROWSUP) &&
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 vm_end_ga=
p(tmp) > gap) {
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0low_limit =3D vm_end_gap(tmp);=20
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0mas_reset(&mas);
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0goto retry;=20
> > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
> > > > > +=A0=A0=A0=A0=A0=A0=A0}=20
> > > > > +
> > > >=20
> > > > Could it be like this?
> > >=20
> > > Yes, I'll make this change.=A0 Thanks for the suggestion.
> >=20
> >=20
> > Wait, I like how it is.
> >=20
> > In my version, if there is a stack that is VM_GROWSDOWN there, but
> > does
> > not intercept the gap, then I won't check the prev.. in yours, we
> > will
> > never avoid checking prev.
>=20
> Hmm, I see. I guess I'm thinking ahead a bit to adding the shadow stack
> guard gap, but I can always add to these vm_flags checks.
>=20
> But are you sure this optimization is even possible? The old
> vma_compute_gap() had this comment:
> /*
>  * Note: in the rare case of a VM_GROWSDOWN above a VM_GROWSUP, we
>  * allow two stack_guard_gaps between them here, and when choosing
>  * an unmapped area; whereas when expanding we only require one.
>  * That's a little inconsistent, but keeps the code here simpler.
>  */

I didn't think this was possible.  ia64 (orphaned in 96ec72a3425d) did
this.

>=20
> Assuming this is a real scenario, if you have VM_GROWSDOWN above and
> VM_GROWSUP below, don't you need to check the gaps for above and below?
> Again thinking about adding shadow stack guard pages, something like
> that could be a more common scenario. Not that you need to fix my out
> of tree issues, but I would probably need to adjust it to check both
> directions.
>=20
> I guess there is no way to embed this inside maple tree search so we
> don't need to retry? (sorry if this is a dumb question, it's an opaque
> box to me).

Absolutely, and I'm working on this as well, but right now I'm trying
to fix my regression for this and past releases.  Handling this in the
maple tree is more involved and so there's more risk.


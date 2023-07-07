Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E428D74B25C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232620AbjGGOAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbjGGOAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:00:45 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FE72139;
        Fri,  7 Jul 2023 07:00:44 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 367Cx1SJ023994;
        Fri, 7 Jul 2023 14:00:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=kNOX3KOslx3Gsvk+8LuiA+qY4HeX4u6eFt08LSzyyBI=;
 b=xjCYzyj5UOUeFnRuVswFNkH2DlWsjIscnuuSiCIUO24020EK24gfWYL5hn9OaH6oJV13
 rcqWI5yO9Hlsl9rtzy3s4JHIqMyREeKcJOSK00GSc+zICdnHsU7KPKnCzauJqvIfj4l7
 1LerHRV6cr+G+vTLTNyLrV4y8dYw4kXWLqNO/I8VsnGNf4FyX27ubv94gWJIjVxnRTms
 N1vxEucx32f1lYY1qOR8grIv3pTrIz1MQ4mvD9VOzAqLpkDsI4T1p970d2R06BcATstc
 oH2k8Jey1iOR0A9mTIpxx8e/eRtNfhLePAdCuFn/xsgSbnBIiP40urDXeb0wJiUvWU+8 KQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rpfhprg83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:00:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 367DtVRD010256;
        Fri, 7 Jul 2023 14:00:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak8f99m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Jul 2023 14:00:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UDLZsqmJFHDVo59eppNatjhA8x0LUkxJ0Y8RlkPhCTYVbiifNtv7JmZbi0OeX+IL68j550vA6/l34nk45iEn2itU8me3ArLQqT/PK4tUTNP6JQBj43Oc0Bs5pYufzkmXxgjR5cnhfSFvTy+KPmiOOtzVd2kbdn4AKskYOnWwxE6MAVarwbqSoh4e3cdHBMWoqzyh+K0aqT5gt4nOVFxlEp/iQ/btrjnfBk4pmkEyh2SGyKDbl0e3CU5bPTQfFFkdipJ1wXUNMziJVuZhOrGdcxiEyOK9V6emp/mysLAufxVtFoY8f0iFFrtlu7Za3UOwsue/nkv1qLBNO9k3IdDW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNOX3KOslx3Gsvk+8LuiA+qY4HeX4u6eFt08LSzyyBI=;
 b=k4bTg6ZXRm6FtOEz0rxEIkVdEWihC8K8bQPh3mxPXQ0dTgmNCCsrhoB99TZellh9jYKRO8IR5S2dHSRsuotNo8q1Z+2YW+2NaImd8f6jYPdzGM6lBf9cOObcXV5yih8il08iicgw5nrjz7wd6P7srixzIHTU3QQBJDAwwm0pFKzFxpJDrtvn0qAQius86fGnmX9lVmqI4bL6+ArJqD3TMze4pI4hb5lnC8MDgQC4ZhBVzoe3seJHYBoo6oPue8ct9Nm7uOJglnTAXk2CP3mmbbwmf7kZH/drp+JLp9z+0Y91UmBtaVoVZ+GQsFXoj7C84xG1CROTTtBr49WQPOdntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kNOX3KOslx3Gsvk+8LuiA+qY4HeX4u6eFt08LSzyyBI=;
 b=gbf1nMreYzn4F5aZ9jz3jXadJ4Q+BWl8gETp+AAO7WNsvMzP18rM4FhCsRTQHVRqg5gDulW2XpmRXz+GgO0Wt5/I0RgfLVKRR6G1lNmiwhp4HAudtUAzeeDX1DTZJBri/rzdBOkyf4SKQ51VPNxB0KhahdnHziGnPRCIBEsWjRM=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by IA0PR10MB7644.namprd10.prod.outlook.com (2603:10b6:208:492::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Fri, 7 Jul
 2023 14:00:14 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6565.019; Fri, 7 Jul 2023
 14:00:14 +0000
Date:   Fri, 7 Jul 2023 10:00:11 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
Cc:     davem@davemloft.net, david@fries.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, zbr@ioremap.net,
        brauner@kernel.org, johannes@sipsolutions.net,
        ecree.xilinx@gmail.com, leon@kernel.org, keescook@chromium.org,
        socketcan@hartkopp.net, petrm@nvidia.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v7 2/6] netlink: Add new netlink_release function
Message-ID: <20230707140011.idtokbxklu2fyjat@revolver>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-3-anjali.k.kulkarni@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704001136.2301645-3-anjali.k.kulkarni@oracle.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: MN2PR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:208:c0::22) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|IA0PR10MB7644:EE_
X-MS-Office365-Filtering-Correlation-Id: 660e54cb-34b9-44e8-4cb1-08db7ef27cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s1+aamzQd3vAPAPgNZudYXLHrWmXx/3wPx9VAKg+MGO9IGeayxIWKOdW0kz58tO6eCZW97M0fdLHUgmTOVJo1GSTiZSDkBvmMB8P32HqwVfMVsbqAV34Ji69Hkpv9wQmINzy5FxsQG4EiWlK4bs+C2PvvPsU2uO9Qq3bBscM1pJP5fu0nttY0SNkqfOQXRp75tn6uENQt1On0ztlMjnVYsYuHMwUCYp3dLFRn/yrVdmP9fKbyc1LktoBFLjqJNsxsRA9tP21/JY8K3f7ChG6kFqEfL5uPjCZf91DCbYwa+KT21WB/9lb5vocLIXEHNSX7L9EsQei+YczqWGcoeSVbtKdvu1RRxK6DnUL53wJRaSsifgaRDqR5pbd2O2U9slpYZpIGblOR/Vix9g7WcgHzgDeoRVNMsZpzboF9zxov4KRUaV80GmyvjAydGCC4ACnFw6Db8qRnOteGH1MbUnXKrq6WGeb6+rWZ8MKwF1P85W9K6wozwqrUmqQDr+4MTrunO4J8PJ0Ta/FQl2/KHfuRhRTCX2LgwPz79WRbM5lExj5A0ys5CvCjihlnSQd+f9F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(136003)(376002)(396003)(366004)(39860400002)(451199021)(6862004)(8936002)(8676002)(2906002)(5660300002)(7416002)(186003)(6506007)(26005)(1076003)(41300700001)(66476007)(66946007)(6666004)(316002)(6486002)(6636002)(4326008)(66556008)(83380400001)(478600001)(86362001)(6512007)(9686003)(38100700002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ur0sxoMp0cM2B34zzr3jaOAFASKii5xjQYm2GEicqCQFcrc8KyZI5je1x1kx?=
 =?us-ascii?Q?gj+uGN5ZrpySeMKnAfVAqpqrPIc/pAtgWojmklcsyZ+gyCDLWShgX7bpwnT0?=
 =?us-ascii?Q?D2Az3XOgkpUvhKC4CCFf2zf3b4P90MTlTOibcHUGfxgcZJftbaGLqMC18Lmx?=
 =?us-ascii?Q?5SV1IM6TfJZXp1cmZZPE46sMHpuJZ1IgYYcAEAxZ5TSlhQvutMnnf8gbqC7F?=
 =?us-ascii?Q?XwzAunUIKtWuZb6o+DxV/TMio0nnmDnGWohF4XZJgy7+5FqHl9xSINJkR+Qu?=
 =?us-ascii?Q?8vFsAX6lpWE1gY1tJsr/Mt8GhIlV0rZWm6t3CQdNgQY+orJxSVTybyTEpLoc?=
 =?us-ascii?Q?jSLI5DQ0eh6UYNh2bkpEsfySvmooMEwKVPinpaGHP07YhGHaaefLgXSP/xad?=
 =?us-ascii?Q?murO6fn9gWXVF2UH6XhU02dyRJgKINUQOQ86TqJeJcXvbHv8lAzlk7a9k8H9?=
 =?us-ascii?Q?PRiroO9CrNb8dJhnjLRdZU7Gha8McR+g2Ja9tWlQSYz0K71lJB+SQp6HDhOe?=
 =?us-ascii?Q?LfDFBH9GaKVr5EM84zP50OPjxTJjGHa46yCDiCyi5bQkWSwVMRDlPd7uC4sy?=
 =?us-ascii?Q?at9JQhnBIIWdru/1VwElbrdfnclhLGUHrq63EJeKek4PnAGW7g22hTQsNOGI?=
 =?us-ascii?Q?YjHRAC3kAPfgQKgTrqsC/u0wDxNH+HHjtAwraVT/0/ywJQLXRKTltoBYln+z?=
 =?us-ascii?Q?oTOt+WSf7yEtccLXPApEl2MH7nEoyz47YneaKR0ZX//mUQvemK+4Y9ovb961?=
 =?us-ascii?Q?KqPJRLzSjs8JJoKYgm8JiK5n6G7LMugWTh6jIXquYw2w5RyQSSFolcuy+NIZ?=
 =?us-ascii?Q?xwlfKptsPFj7J/Bo5N2ffJKCOTYvixBsLiDrBiP8+Y8zbTeyPTtVW/S75OzQ?=
 =?us-ascii?Q?UTYG3KowODoGCPl0GSzIU08JSsCMLfXBaKFPAz5r/OEDvgFfPZ57XQjWLThd?=
 =?us-ascii?Q?bKwNvnI5g6IdiNX6vh5hSzNxIYx5hgbIwBaL+gJrzfInixRGKqjFp4gYds6n?=
 =?us-ascii?Q?F6x/golIKt/CZt4D3KlRCdN3onG6zOan3EIAfQwl19H2RjSEV1liqBFnoLH7?=
 =?us-ascii?Q?anBpcMqFff+7T8QPXZzTxjkpqMt4U8Mjuu7R3Y2Cci7/1NEEVOmnf02ZBnfA?=
 =?us-ascii?Q?0bLzZ/zfE/HU/hIz8M2I1nIwz8Nm4sLyJ8GQXED3GrQKsQmdTEW5kIQca3gg?=
 =?us-ascii?Q?HDRCI+CnWBG+ubTfSztEA3l5+9xCysVt8UCoebcaWtgVgPi17QIPPMS6TA4q?=
 =?us-ascii?Q?qw8ObfEDuScTLwF/l4kvs4vyHTI/88sXhCjvanN9vt9xOxNTmIKXx5sbcGoT?=
 =?us-ascii?Q?11E6p1Ew9KwDx+ZqDDnLR0myrEIUGrEAH2bvUp1b1D5qvD3MyUVkZvAYu07H?=
 =?us-ascii?Q?/6dJTRqg0zS/nbBXZAguEYaGALGOhXO4wt3kTqaP0w6k8Hq5nWGT250eS0OU?=
 =?us-ascii?Q?WYi4IhXxtM9+zAfRAqdEzmMBdujJmliOCrQoBfWE1zsHYA1bEvuwqq1ebPP6?=
 =?us-ascii?Q?2AgKj9u9fVJkUQxlwAWalJo48F8RBvf0MJQTa9TyZkASffqHz5cpBQ0srupZ?=
 =?us-ascii?Q?O4T34YSnOuTbkRCDpVzr2r28AaxcKo8HVtp8LSER9NVPdIUDgj9UoRg6sitY?=
 =?us-ascii?Q?pA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?TUyRXROcoUzOfv4N7ya1xux6/Zr5wWhR9Kdj5mrjWmtcO4dWy8nB6mktRm2H?=
 =?us-ascii?Q?3TZUyFn0+QRQ/3y7CaARoknb/+DkPhDMexvpcG0SnPGcTubICtTb8EdjyLRB?=
 =?us-ascii?Q?sXiyTZQ4w7qwQSLay4pV3H3rvu3Zm5/vvOAqZ9Y4i8Jho3cDlfZdvl1bfeBV?=
 =?us-ascii?Q?dcJ+gAcuSG3zjvsOyLgfGZxTvwQ0TNfxmfaKIpVEeJUatIynSB0utPPHBXkN?=
 =?us-ascii?Q?dDEz4aBJvFNCqI4P8mYhVGy1jstTTYi5udHAFN4sC48bRht2BqVQvMgy9o2c?=
 =?us-ascii?Q?c8NigpPV0JqdickFtMNi3wyok6PSmGGFY81RLYNW6MOvXXaW4nG7y99Reb1W?=
 =?us-ascii?Q?/JUmRkAmZ+geu9F3hFT+ufZg29ql4UI9V817//nL/8bU0zcqz5CcLPp/iDQR?=
 =?us-ascii?Q?yJ/MhJ4d2uodpPCyFOAtUUGWt1PYE2SdhhlPxeNV02wtzc3yyOUuvLuu+1fp?=
 =?us-ascii?Q?aHhMq8nfxkICVq71+5iZCKlaJx/8qslrNvkK6dHbNggyX10cru98ai6MKk/+?=
 =?us-ascii?Q?SSyA0r0WSLcpO9MFi7eAQbD/DUtMS1Im1NTy6Uo4rfQ1Sxe85EeNij492zwR?=
 =?us-ascii?Q?qU4i3WHR/wdN3QR+G522baFwibgLgoj8qVRwSWHr1GLhd17HSlFlq3vCwJZw?=
 =?us-ascii?Q?dz2Pkv6R9QX0L+v15XcSWiANNmKY3UNJF6SVN1yG4uAmPWwAzU7wE2gw1Fz3?=
 =?us-ascii?Q?DCs0JSOOfMcpoAr4c0M4V6IVcaJf672GkeQJlOsGH8NAaV0eUn5kTupmIBFK?=
 =?us-ascii?Q?3ALJrmxZK0+cPcTOWFCmiteUgJCHHN9/mJW5GRka77iCaKWonIiSqQoZlIux?=
 =?us-ascii?Q?13MjIBXp0vfWZtuEeeI5gRG5v7DUchPoWv3atfbmQ/hdgD5IsHrLfk+a+OoK?=
 =?us-ascii?Q?F1xWSDczyTFwKKVQepeyrI+xmCJcw0v2UdUwO6C2v6JLLBxCO8Ns5Jh2O4M1?=
 =?us-ascii?Q?yYlDjXHoXRhfGzk2CEci47PRBFU6gv83mmXoNI/ZPKFQIaBpAqJsjkVMV3T2?=
 =?us-ascii?Q?g84OUedIh45y1MAgs2EBhcpnkWT+W8OOfaZbDCL4cdY8c3XquMn+JM6mxesf?=
 =?us-ascii?Q?vxV94Zymec+ExzG5rni1zOkcnw21mwqsyGPs3XrmYz4w7BrAPvk=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660e54cb-34b9-44e8-4cb1-08db7ef27cdc
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 14:00:14.6104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ub1DZtlt/kdO68tOiUYuvYhA37Jk0+FEIh7WiC1A9eMk0dKzRhR4ewKr1GeOuPROhpOSJFdyj/p2kzPbbVZE7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7644
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-07_09,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307070129
X-Proofpoint-GUID: ohdveXhkEAO2dienu7uHWHD6iee46QOG
X-Proofpoint-ORIG-GUID: ohdveXhkEAO2dienu7uHWHD6iee46QOG
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [691231 23:00]:
> A new function netlink_release is added in netlink_sock to store the
> protocol's release function. This is called when the socket is deleted.
> This can be supplied by the protocol via the release function in
> netlink_kernel_cfg. This is being added for the NETLINK_CONNECTOR
> protocol, so it can free it's data when socket is deleted.
> 
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  include/linux/netlink.h  | 1 +
>  net/netlink/af_netlink.c | 6 ++++++
>  net/netlink/af_netlink.h | 4 ++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/netlink.h b/include/linux/netlink.h
> index d73cfe5b6bc2..0db4ffe6186b 100644
> --- a/include/linux/netlink.h
> +++ b/include/linux/netlink.h
> @@ -50,6 +50,7 @@ struct netlink_kernel_cfg {
>  	struct mutex	*cb_mutex;
>  	int		(*bind)(struct net *net, int group);
>  	void		(*unbind)(struct net *net, int group);
> +	void            (*release) (struct sock *sk, unsigned long *groups);
>  };
>  
>  struct sock *__netlink_kernel_create(struct net *net, int unit,
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index e75e5156e4ac..383c10c6e6e3 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -677,6 +677,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  	struct netlink_sock *nlk;
>  	int (*bind)(struct net *net, int group);
>  	void (*unbind)(struct net *net, int group);
> +	void (*release)(struct sock *sock, unsigned long *groups);
>  	int err = 0;
>  
>  	sock->state = SS_UNCONNECTED;
> @@ -704,6 +705,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  	cb_mutex = nl_table[protocol].cb_mutex;
>  	bind = nl_table[protocol].bind;
>  	unbind = nl_table[protocol].unbind;
> +	release = nl_table[protocol].release;
>  	netlink_unlock_table();
>  
>  	if (err < 0)
> @@ -719,6 +721,7 @@ static int netlink_create(struct net *net, struct socket *sock, int protocol,
>  	nlk->module = module;
>  	nlk->netlink_bind = bind;
>  	nlk->netlink_unbind = unbind;
> +	nlk->netlink_release = release;
>  out:
>  	return err;
>  
> @@ -763,6 +766,8 @@ static int netlink_release(struct socket *sock)
>  	 * OK. Socket is unlinked, any packets that arrive now
>  	 * will be purged.
>  	 */
> +	if (nlk->netlink_release)
> +		nlk->netlink_release(sk, nlk->groups);
>  
>  	/* must not acquire netlink_table_lock in any way again before unbind
>  	 * and notifying genetlink is done as otherwise it might deadlock
> @@ -2091,6 +2096,7 @@ __netlink_kernel_create(struct net *net, int unit, struct module *module,
>  		if (cfg) {
>  			nl_table[unit].bind = cfg->bind;
>  			nl_table[unit].unbind = cfg->unbind;
> +			nl_table[unit].release = cfg->release;
>  			nl_table[unit].flags = cfg->flags;
>  		}
>  		nl_table[unit].registered = 1;
> diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
> index 90a3198a9b7f..fd424cd63f31 100644
> --- a/net/netlink/af_netlink.h
> +++ b/net/netlink/af_netlink.h
> @@ -42,6 +42,8 @@ struct netlink_sock {
>  	void			(*netlink_rcv)(struct sk_buff *skb);
>  	int			(*netlink_bind)(struct net *net, int group);
>  	void			(*netlink_unbind)(struct net *net, int group);
> +	void			(*netlink_release)(struct sock *sk,
> +						   unsigned long *groups);
>  	struct module		*module;
>  
>  	struct rhash_head	node;
> @@ -64,6 +66,8 @@ struct netlink_table {
>  	struct module		*module;
>  	int			(*bind)(struct net *net, int group);
>  	void			(*unbind)(struct net *net, int group);
> +	void                    (*release)(struct sock *sk,
> +					   unsigned long *groups);
>  	int			registered;
>  };
>  
> -- 
> 2.41.0
> 

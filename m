Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54B470769F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 01:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjEQXyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 19:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEQXyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 19:54:05 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596773AA2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 16:54:04 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HIGmCv024470;
        Wed, 17 May 2023 23:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=UnreRQnfrAgJCI0KTOCi/IPUGexLfvTNWSLRyjXkvEA=;
 b=c9OqZ7dx6bVUBXRFVl+mXgsrchawCXtUTg/1O/TLApJH6yoir3HHKFiJ+k++Bh6PocxQ
 d2Rw28wgtHPZV4t69GOj5qDQGIyBuZ1aQTSlIe+fod7NQ3120zWxRbdQ/vl2xCeXLl8P
 x84JJQ16YmHPYiIFbFj4/yspfk+3LNPjFmFs2JanArkLTVP3TplNsR4HDePgmuBYVQEf
 fPFO6orlSXm6ICylVmfJVoXD/48xKMcz+OU+LlpPqT98Tu7Z8vqWeJczXOfjgN+0HW6Q
 WOOdlii7kMVXlmzOufiaifNFu7t2B6Do5/rEECTmTz4nqIZxSbu2MEpnzfjEQz5rbBfV jA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qmxwphcbu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:53:28 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34HMXLsZ024998;
        Wed, 17 May 2023 23:53:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qj10635cc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 May 2023 23:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UfFPxln/Req6BfOWlADR9vRScNmahb7ScROwSyxgmMl195ag0GBmJ90aDGbLMyYpBbFi79KD/8eG8IzfAVUkrqDYYlxmBn8SnVqCjvgwbo1PNBebdlStfx/k37gmh+Gg0PtOlb7GoJOBzRWLFIvudQPIqHP1HsBt1q506slsgg3ucAVni03+1f8luwTjZU6ntV5OZ+KThlYDzQ9yEajuhZmEx49IpdiZmFeH2lAkFWsxae0rFuCkVFb9msYeJG22ne1HL2qQVw2eQn9MdaEfYxbuH14DBNwURKB1La0hS38T8TxQo3V3HeuI78VfpEJbm1dsK5GEPija8hd7WdJqSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UnreRQnfrAgJCI0KTOCi/IPUGexLfvTNWSLRyjXkvEA=;
 b=nW/MM7MhVmngvo4Abz6g+h53uAeThmgeqHtCv7qo5a/6hI8DUuffI05zWcJesOK844SM58xYsHXibVq1dXYSwkZ+7USnupslo6yMdstBxKqUYJ4HwA03VVGAkSkkEBhneLo5vmn7TQOlLO/2O6dQBVwfsMLDRWPEqIyMMNNzzejjQxT1kSDyscZtTw6X3FPAzw4LNk2XYbFEpO2ZkYEKz2HK/XazSItVkPr657LrZ2HhTrpfiYbF8UiyxUY04T1nxYNJiBfmu5pU55zkGhW2psOi4hl06zGkpGCrpKbKP94+9jmZ/I26DJgMkDBt7htt19dH3ZQlWd90tj13ssyXgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UnreRQnfrAgJCI0KTOCi/IPUGexLfvTNWSLRyjXkvEA=;
 b=P/KMDokjj7MsFONn5fEfhr/iQRQxltd1eNY1NODuGA6WWslVWRK6R38viHYKfs8i44a4xw71n2GHLHwKluZXB40PEtqZvw4KrztiXic0759y027+uWivm/3pRt6X1+hws7zxf6BReii/YxelHQQ9ZXYcmwWxmE+eB7xURqVJpLE=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH7PR10MB7034.namprd10.prod.outlook.com (2603:10b6:510:278::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Wed, 17 May
 2023 23:53:17 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6411.017; Wed, 17 May 2023
 23:53:17 +0000
Date:   Wed, 17 May 2023 16:53:14 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Jiaqi Yan <jiaqiyan@google.com>
Cc:     songmuchun@bytedance.com, naoya.horiguchi@nec.com,
        shy828301@gmail.com, linmiaohe@huawei.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duenwen@google.com,
        axelrasmussen@google.com, jthoughton@google.com
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230517235314.GB10757@monkey>
References: <20230517160948.811355-1-jiaqiyan@google.com>
 <20230517160948.811355-2-jiaqiyan@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517160948.811355-2-jiaqiyan@google.com>
X-ClientProxiedBy: MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43)
 To BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH7PR10MB7034:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f493eea-0a5b-4b81-f82a-08db5731e27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nq0QQ/KG+6JJG27MmB2qRlbj1ap8n4budGd2NzXZadKZPs3FpdYRzFiN1uOcyQUx8n33/EUAGngRX/3xwrbAEXbbiCYj8E5lIWdSxFl65wS4LpjOBR/h1CUgHJ6uWvEsmsvQnc2DnVljiM0xPI2aQEodmgY7Tcljv9sdch70+uFG+QWIIF0Hs6iCXTCfuqAM+kHcaKun4+wZRW2zQ+uTDDLp8uuqpRqLHVpH2oH9uiS+BfVr/4CgXh9ERbXjONHu/soL65xQ58yBmvOcxf4mV/83oybQWgOX0/lQNYBiguQY5DcrPW+c13U/CvzNOlP3du5SyZkrZuIcUX30qB/XZoJuJGpwThzQTHhNaxAHf7icjuSo8QS5UfHaLaNp3QuYlYaaaDYm3ycCt5FfY4HU4EHpKjZCyM4t9aZyvOFIdpOpgJ41ywdtgxzUrg8Cnj4VRdMDioeUP1YQqj0yCKtwCWZ6NXpG0+B+CmHY/j53xPLySMKkXZlSsxnw9pkE6YN7gK6EL6TFDT6ob7UoT8QXqMye7Z21RkJFcEEBMwW2KlUhXG9P55MXLXSPshl2M5a5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(346002)(39860400002)(366004)(376002)(136003)(396003)(451199021)(33656002)(6486002)(316002)(86362001)(66556008)(6916009)(66476007)(4326008)(478600001)(66946007)(7416002)(33716001)(2906002)(8936002)(8676002)(5660300002)(41300700001)(44832011)(6666004)(38100700002)(186003)(6512007)(1076003)(83380400001)(53546011)(9686003)(6506007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RydVmbK47Cg9/YavmnGno5Z6G+GsLFq7k44esbj0E2LPxl8hWq+djtoscfOC?=
 =?us-ascii?Q?+QerFJN4taAgpdWAfINhyENiijUG7H6nZBFq1l/yFK4m3CZD1x0LF6EtL6U0?=
 =?us-ascii?Q?BnYhFGtC1WDY/ZMXUCd035XhAKmH5y1fOd+FgTu5MBge7Kz/ofsu8pKdmavX?=
 =?us-ascii?Q?YSBzcX25kJa5qUV5ElUeH/QTzNclegoxKohSLeRW/1klkIuUJeB6+e2rE67L?=
 =?us-ascii?Q?ID+4GHJQVDgnyUGxNjnJWRf4ojt6LVJEqs974Ll10It/XTuTMApORONSWdF0?=
 =?us-ascii?Q?7l13BFRtCWiBWvE5+szUqcaMNarOogk4czmpE0SCC3FmzJyuGdVYRw6OCBO4?=
 =?us-ascii?Q?95NQa36SM62oAlLtYurPoGE6VAgMZNHxK3b8lkbKVus4eDgzLikIY4ltnuV4?=
 =?us-ascii?Q?csxkOz5+NkEqKfeupiqSYWwpl7/N1MsyzT0rqAjTZkH2k91DGwjTRh+QtIbu?=
 =?us-ascii?Q?eaAf657b+U20V0Ae2ULhEzrOwTJDAuIxD2qhJX1K0DGaMDrdu08h0RScB5SF?=
 =?us-ascii?Q?Cx3E7T+5RfHllM+tiluiRmPjmypGsRaCJ3ORIoHPwFagxRVD7UKVOdxyn0Jx?=
 =?us-ascii?Q?FInnd3elgZt5m4pzBU4B/W6/w1BUcKwoMZIb7x2170kgAwxfchfjcM1F3YkM?=
 =?us-ascii?Q?AzRu1qQ2CqjFMQik03szifxeaJlKkgO7qNaq2xKpEtS3bW2ht4aQx6dVIJ0F?=
 =?us-ascii?Q?3wEcGEUNkull8ogNrmbU2PmjnYElDbb55KcS6+o7vLHYdW/uYgm+KDtnuJ/x?=
 =?us-ascii?Q?HyrDjJXY52j0pX5BQjtSIyZZVBGlPFf/q+/8B82RjKaYRiqiOcCcv0oQ5Gq6?=
 =?us-ascii?Q?WoAkYsyb75efPxtZ1YNLtqGqyJDeQ4m/uU0OLvn+aJ94LYdIbHldhvOdhWj1?=
 =?us-ascii?Q?KyImZPV6wSt0cqnxWZfNCJSh5UocH4sm28eYHMab8HD4xAA3IMTLipbDgJVB?=
 =?us-ascii?Q?rx/QGhbSRMokwKqIKDe/faddzlOeeZvxs4MWeWZf8/UnLWuTvyVbcZBNuEgN?=
 =?us-ascii?Q?5WzK0bJ+z/HIW7DYOjiHSeYkb/gYp/mUwW5PuDEPhl9cP6l6ctunaBYj6KX4?=
 =?us-ascii?Q?oNqG0c9ro6F6ZNpdjtT+ZGC2zg1ELg2Xfh2Y//Q2NyOzZmO2w7ojtMS7mtV8?=
 =?us-ascii?Q?RIAWMTSqpJobC39Q905VTNa4lguKM65/NZfQsJD2CjpEh2elvbFH+K8zY/HK?=
 =?us-ascii?Q?PoZV/9qfaH15iHcnRJ8BPGTDO/S09/gXoymhcFguXsM7aVDU/TuduyH0wVqj?=
 =?us-ascii?Q?Xm/r1Oqgf+fFRJetcXVBIseoudOlYy2neJmgJpFITTE3moMAP+CA8y+FArkQ?=
 =?us-ascii?Q?1bZvPf5Gt8IcGTsymZxGzfPg0ujsI7vf6h14mltMEAgLmMsY4jfNjkJJCCFk?=
 =?us-ascii?Q?mAklHQyOwyuGIPI2bCj2Td0es7PKSEaOxNRw6Ob9nGz4r+I2aacuijH2AXNN?=
 =?us-ascii?Q?HjEleQ1WaNtcus4YaC8jxoeVpj/WnA8euYpv5IDpZjDYvXaXAaKmAXgjFgeE?=
 =?us-ascii?Q?64jkeNXirLVcPngmvFa9Y5y+ZzzklgwZJ7sE+JvNS+uB64JhGXgIro19jLJB?=
 =?us-ascii?Q?FtCciqBVpmIAWIzAaHyR8UIfDboZB5/skFZhAGwh?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?GqaEAHZkE63MoZcBvVJF3F2da/ftBI5i1mFJh5+SdPa3IQPHO/Szmmvc3Y9T?=
 =?us-ascii?Q?Fv047zXWIo0Vx8IUdKHbJ96u74iHckFdI1JalevlU66AzCajKufS3BbPYyin?=
 =?us-ascii?Q?ksRK+rQKTIgbxTdOl7jhW4dAeJ7d4gGcfg1kvKvDQqi27lgA/9USJt0wce5g?=
 =?us-ascii?Q?TB51EIx0f28iOwpQUlE4aJ5i5xoa71CcHJa9Byc5OhoYAG+DpMrI4m23UPWm?=
 =?us-ascii?Q?8pVNfY82cp6tSjKywRn3KMYFvynPCc57VU5oSGp2YG1vz/G1P8B+NFZ4F88f?=
 =?us-ascii?Q?Vqx34Za1SD1V8DG6rKH+nSRgqv4dsMP1Sf4Ss5kJRDKDUbIXUgsRKi84klzB?=
 =?us-ascii?Q?4Dg7focZeE1ucrkrFLdDeTJoCyK4EhnMbLa8Qw0vDMSbO0NRfJQdPALA2zEZ?=
 =?us-ascii?Q?uyEKZmwaNo/TJi/abEgD6t/pPDD1Z1XN/juaLOfBVSwyYu0tp+9oCNfElNCh?=
 =?us-ascii?Q?cFevUaWqlwgiYnaQvlUkEDCI3Z/NVLfSuHgWo6oNLrnqcAdikzKw8IkJDqWs?=
 =?us-ascii?Q?78Ym7VvuDWSdVtp9PqzvrBIizoPWnENhfietEVaH/FoJNWApZkutz4uxghL9?=
 =?us-ascii?Q?aedbwaVkFPe/WU0VkuFAp98wSWspGFvostS6TzGHCZ3UTpUJ45l8zeTmOm/a?=
 =?us-ascii?Q?vtE1vm6ffOPx8KgUtwHN1JUPma6OuvJTQZd9JhScaVyE0F3HYWQ6W4IBoSdk?=
 =?us-ascii?Q?/tAwZ3yHM1L0O+3usJsWknu9/5l5PAtAqg7ItSPkCSNpJ7smS/69kglD+9f2?=
 =?us-ascii?Q?IO/pfPx52Kyls8Ueucrox3q9oLhdDedKoWLPPpz6GLuO7UdBNyQQKJpyi42Q?=
 =?us-ascii?Q?STckdtgugcE3n1NnLDUBjECNN3VoZdH5RiCGkaJCRDXoIumpKyjmSBIOXCFl?=
 =?us-ascii?Q?80I1P8wK9MOGJTNMkDKuviUo1wIn06XjOiavvCVPuu3qtJFx/S7A0bgOrwYN?=
 =?us-ascii?Q?wedKiKlEdFrYBAY1B/zc9hvbz0fKS4qXqfJClYZwILc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f493eea-0a5b-4b81-f82a-08db5731e27d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 23:53:17.0067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02bxF84H/YwgLEbgwQ7kLHkTgHmJ6VShlkxM6DrIAzSW3cj3REjX420zmL1a6xPrlpXeQV6RQIgPI/uDZPEsJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7034
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305170197
X-Proofpoint-GUID: YZ7vjhh7ZeWPAUA5NyqUNjFEIm3ls7Vl
X-Proofpoint-ORIG-GUID: YZ7vjhh7ZeWPAUA5NyqUNjFEIm3ls7Vl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/17/23 16:09, Jiaqi Yan wrote:
> Adds the functionality to search a subpage's corresponding raw_hwp_page
> in hugetlb page's HWPOISON list. This functionality can also tell if a
> subpage is a raw HWPOISON page.
> 
> Exports this functionality to be immediately used in the read operation
> for hugetlbfs.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
> ---
>  include/linux/mm.h  | 23 +++++++++++++++++++++++
>  mm/memory-failure.c | 26 ++++++++++++++++----------
>  2 files changed, 39 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 27ce77080c79..f191a4119719 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

Any reason why you decided to add the following to linux/mm.h instead of
linux/hugetlb.h?  Since it is hugetlb specific I would have thought
hugetlb.h was more appropriate.

> @@ -3683,6 +3683,29 @@ enum mf_action_page_type {
>   */
>  extern const struct attribute_group memory_failure_attr_group;
>  
> +#ifdef CONFIG_HUGETLB_PAGE
> +/*
> + * Struct raw_hwp_page represents information about "raw error page",
> + * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> + */
> +struct raw_hwp_page {
> +	struct llist_node node;
> +	struct page *page;
> +};
> +
> +static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> +{
> +	return (struct llist_head *)&folio->_hugetlb_hwpoison;
> +}
> +
> +/*
> + * Given @subpage, a raw page in a hugepage, find its location in @folio's
> + * _hugetlb_hwpoison list. Return NULL if @subpage is not in the list.
> + */
> +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> +				       struct page *subpage);
> +#endif
> +
>  #if defined(CONFIG_TRANSPARENT_HUGEPAGE) || defined(CONFIG_HUGETLBFS)
>  extern void clear_huge_page(struct page *page,
>  			    unsigned long addr_hint,
> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
> index 5b663eca1f29..c49e6c2d1f07 100644
> --- a/mm/memory-failure.c
> +++ b/mm/memory-failure.c
> @@ -1818,18 +1818,24 @@ EXPORT_SYMBOL_GPL(mf_dax_kill_procs);
>  #endif /* CONFIG_FS_DAX */
>  
>  #ifdef CONFIG_HUGETLB_PAGE
> -/*
> - * Struct raw_hwp_page represents information about "raw error page",
> - * constructing singly linked list from ->_hugetlb_hwpoison field of folio.
> - */
> -struct raw_hwp_page {
> -	struct llist_node node;
> -	struct page *page;
> -};
>  
> -static inline struct llist_head *raw_hwp_list_head(struct folio *folio)
> +struct raw_hwp_page *find_raw_hwp_page(struct folio *folio,
> +				       struct page *subpage)
>  {
> -	return (struct llist_head *)&folio->_hugetlb_hwpoison;
> +	struct llist_node *t, *tnode;
> +	struct llist_head *raw_hwp_head = raw_hwp_list_head(folio);
> +	struct raw_hwp_page *hwp_page = NULL;
> +	struct raw_hwp_page *p;
> +
> +	llist_for_each_safe(tnode, t, raw_hwp_head->first) {

IIUC, in rare error cases a hugetlb page can be poisoned WITHOUT a
raw_hwp_list.  This is indicated by the hugetlb page specific flag
RawHwpUnreliable or folio_test_hugetlb_raw_hwp_unreliable().

Looks like this routine does not consider that case.  Seems like it should
always return the passed subpage if folio_test_hugetlb_raw_hwp_unreliable()
is true?
-- 
Mike Kravetz

> +		p = container_of(tnode, struct raw_hwp_page, node);
> +		if (subpage == p->page) {
> +			hwp_page = p;
> +			break;
> +		}
> +	}
> +
> +	return hwp_page;
>  }
>  
>  static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
> -- 
> 2.40.1.606.ga4b1b128d6-goog
> 

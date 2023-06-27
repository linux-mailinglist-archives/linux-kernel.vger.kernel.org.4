Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D9873FEEC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjF0Orq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232204AbjF0Oqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:46:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D6E3C35
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 07:45:47 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDOu4S008590;
        Tue, 27 Jun 2023 14:45:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=NU3/VEKO+srFBuYtvv8cXbGQ+qXnljvdJLt7ZJ0Rivo=;
 b=gn+kOlvgb21lSqqFiFTsJ7LezAKR2NgQv/HfWkh82XFMo4Ra8tT3NfXDc3jFDThQ3KQ+
 p1I0p8f4W9OlVverGF9YMqCfpERcyOFSVqD8fNCrSmBSDdyjs2apMngRhsSMoKIqKef9
 tZvON5cpTW1iPWRTZ0j7IKoiKqxtOujAyVVV+o6ar2TmRbH7J0RBwuhHEDTIBVAKnrF1
 dThVTHWD/4gkkZzoRsGEsc0DciYEszNpMBhEVIOnjqj/5GeANxOLN1pGvBXhxQYNud8x
 d/Nvw4glq34Un6GT20pF2VdXJSuGXatJwjSPH1LuQjTN2t0fAorAbMfZyphV2jXsmF9v bg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40e3cas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:45:21 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35RDVTvE038284;
        Tue, 27 Jun 2023 14:45:20 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxb3v65-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Jun 2023 14:45:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KhEfqn3Y7jJRF3yAxdfC0gVru5WRu57rLm0L9JMI0i65IrFGrboHsX5PP/gZQhEQpOyGe+hMzVMeJaOLKS6p8UOtCqrFFWLWxtiOD9CFfDy+R52HTW/E1ak0lSBPtbTtW0+Gxjzw3CdvSCVhwMLulWmzGdR72l7hok2m+7krnmc7ofFk72V5qQaSI5u1jiZE58vmIJXlEur3z+B3OoAXqSsoxCSP/dcDlj7IBKzAFWw48YFVnfuoXBOPx2H0eZ/jB1JDdPchFr1ZCIGT1lvXW8J4oRQXW+FO11bIqbqMp4v9QJ4jqZWmm94iPlFYZ58dnvOyzwj2+dn2vazgEEPg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU3/VEKO+srFBuYtvv8cXbGQ+qXnljvdJLt7ZJ0Rivo=;
 b=UVSIHbHAK5F71XAgfF17ziUnjXXT8rLwHnJ4OfDp1O/4PkEgWQOmgOxB/CXbPlosggzhZ6NY76sbUNaTTzslpaeatIrGrwaKP7wNAqkfLOWue+3ZHJEhgrLHgOr0h2u8W/Nd7donDP+ob67LSimRR6kGa2bhMrNV8TbHJOByxXaLj+5LxrVC5991Y1ByDPjxx/9MyJFhE5J/oNSUedKo41k5eRQJs2JKlRO6gdUvL0tCDS0Z9C9hoBRh7YAic8+ofwmAwwXAd+/dHlGGZggSpei5pK0dzLHoWShqcnw6MD+fag4/OA3j3p7rA/TYjs9oA8H9CFjYYQudv5Nj+nBb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU3/VEKO+srFBuYtvv8cXbGQ+qXnljvdJLt7ZJ0Rivo=;
 b=NuHSMT1s6C2XIlnlOFKOypBdjvOvjg9H4JwJfGj80qE9UKtJZXECLvPTtRizfLlhIfiT20pk3WOsSQ0R5uvp1cUxlrcrQdb7uDS+vccoIO73v+dxV7K35UjOZAb2bqwAeqIdUwoOPTccV3ti+uRLsvVsTIc/Cf6hIqPW2wbPk8I=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DS7PR10MB5053.namprd10.prod.outlook.com (2603:10b6:5:3a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 14:45:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 14:45:16 +0000
Date:   Tue, 27 Jun 2023 10:45:13 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org
Subject: Re: [PATCH v3 4/4] maple_tree: add a fast path case in
 mas_wr_slot_store()
Message-ID: <20230627144513.fp5osnsqhn3rgvs3@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        maple-tree@lists.infradead.org
References: <20230615084301.97701-1-zhangpeng.00@bytedance.com>
 <20230615084301.97701-5-zhangpeng.00@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230615084301.97701-5-zhangpeng.00@bytedance.com>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT1PR01CA0154.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::33) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DS7PR10MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: aaade60e-8e99-4b03-edea-08db771d1f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jPqZXNuj/F5uZ2lI+R0OhTUp6Gri1VUrRvYd6u4l1ws7OL8CPuwbmI1qOqODJAGw2bwiC0B1Ot6R394F5dDDvWLDNzIk8cWNhy/CNPWajmhz/G56I7fKj9ojsajQ2dT7h5eFeeO14NYk+shHRnD+J4yTniQlJYFF3mmUehOdM2JMJNV0tcO1hZy6GjNaISS/J8uXAE55opNBXAeaqxJPWQrgG/XS4a+qeRak8TZgfp49w5+jT0SJyKDtjzMEkIKecA+E/hYfxfZRSsknfXVlM00GWXdM/I5EjazM/srJAT+c5H2tIaaGzCFkvkYHVyZjV5VLAedXf2XdEc8xXBopFwd7fxKcZUjxHva13BmUgddHUoAEA5M+Dhe7HvEKdvZ2mJGQeK8whqt4pqbrwSP2eu+9KH66L5KkqOYurgSO99OU2ajlMq0S69w3bD+Vom0NgaQ1EVmVMWpz4ert2VRCyjLm2LKrhoWEVn+znMZn2zj1NgXaBQaX9pYaEIAl6IZF5V/MID+S+OJlXPiteLquybNmYHguxTO/e66yidsiJBJlM2QliNo8H8GIF0fiUflR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199021)(6506007)(6486002)(478600001)(6666004)(83380400001)(2906002)(26005)(6512007)(186003)(1076003)(9686003)(33716001)(5660300002)(86362001)(316002)(66476007)(66946007)(41300700001)(8936002)(4326008)(6916009)(66556008)(38100700002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rwm1YY6zeTDepfIMWQdZ1rFPRZOI+GrX84+iMCOtiK9rftV7u3r5B+eGlazJ?=
 =?us-ascii?Q?mxdNcQBg8LCAGenyovWxclP3yEcHL0NR/XL2AK8elaC5P89rX1DadDUF5RQW?=
 =?us-ascii?Q?vxNh6FV0GIvGiZ0he7vsOV8taxohoCMZQMRRe+eBUZNac27o+DsvhT9vhBY6?=
 =?us-ascii?Q?tgt9rY7iiXhLLlg/DCAPrz/n4UPnBENIuEYvnI+Wadajbh5WcLrXwA7Jp0K/?=
 =?us-ascii?Q?3p7g/tF9TlA0rrJeIoJoiz8xxCY6MmwHbqMLboFmKyzul0CCTwcF/Lli2Xrw?=
 =?us-ascii?Q?TkPTFtI3glnvdyBf6drVsz2+oioMPvr+r9HLVpJZ+5wKhR0oCdMY/mrlIsMz?=
 =?us-ascii?Q?rYRRGKYH53eiG5tV/Gh4Pfp+YvuN3VRQkixm/GbOVo0iVPKyicj/GWHwspeT?=
 =?us-ascii?Q?pswJ0KaQLheRqZnopW0/tQ9JGUWShXLGq7nvuBG52FuCB0sBs5dkaIckEsAV?=
 =?us-ascii?Q?teN9T0TCrzIAz3QKu9b5AB1oOO1JpzABpjKNHKcYMoxQ7QDiHw/FwNazand3?=
 =?us-ascii?Q?lXVQPAebkMKCOWmc0wbYz7DO3TIvvOM5/DjVPzNr9hG8WTlf+M4AGYNPL3Mj?=
 =?us-ascii?Q?JLlyLq0l6SqRFDONiodws/JmVCVaN62VLlGWzWGk38mRyRlHGzkM1dAiYNrU?=
 =?us-ascii?Q?WvWGUljqEkoiK9rSTZ2X4L1b+3RdrRZaiP04zls/VLaH1esWpqXIchqFsIUK?=
 =?us-ascii?Q?y7bpnah8sCmaDF4xYSuokXXLL87u1fGad8e932waY0Ca11MVlJik+kUZ2cMr?=
 =?us-ascii?Q?70Bx19A57MkBpAR6NxovLqIUQzic5G7dm3ZzNBAsZiPVNlsuDzmVH/K6QGMO?=
 =?us-ascii?Q?LsPthNpHEhnsIIhXQUbARzavnhSsd2biHkk5b0ox6xMxKBqGrjA1emzdqzTW?=
 =?us-ascii?Q?tf/8hu27l3GJkMVyCDCDnugWlizKa7UxOFqGjYYR8PvfjObzf2N/0mYDM8mp?=
 =?us-ascii?Q?IBZHdaVdpFzG6n6C3My97KE5zVDohSzXE7DDNTihNKTeHiiXLS1wWbNu1s3H?=
 =?us-ascii?Q?xrLz1nO1KUpqYNNGrfB7K4ikCqyPo+Bw5Mlk4RUuQRbJ4qmyMtnRcUaTUx1n?=
 =?us-ascii?Q?9h/pDnqmkQReCkWMBBaTVwC++TAPLOwLN0jhWAi7Op+RvyImInkxkYu9uzWF?=
 =?us-ascii?Q?AW4Ik+5JlBNesMOqeGTat4dndpveKOlhTsPpUPQrvtZhN31e+HFjbHu7nMq8?=
 =?us-ascii?Q?4wgP9GW+IVDmQA7+XswSicMnid5XIxOxh8l0TiB2/C28pf0o/+vXmc76d9Dp?=
 =?us-ascii?Q?Ae8Vjk+aZRGnWDev62iqGe7CBuiOwm4dHo21zYno25trU1TK72cI2VWbI/kI?=
 =?us-ascii?Q?X6fEIafVkMEzxL7vVQkHCY+EKPheQjiDY+z8kU2layxpVBl/sdto3cQ37Dfp?=
 =?us-ascii?Q?UVot25/Au4ZoX1OCOCArPenHrDSxB1QzE7IPnoBfaZyWqi3b+DLv3RYuM9lG?=
 =?us-ascii?Q?CStRsAGvSw9LAHpUAo305LaCJcKXWQ6Ibxt3fWFELC84nf6DT7rzi5ALtlI7?=
 =?us-ascii?Q?Il82T/F5EizRHqzS2BOlXDJZKWw/JCY2SvjJes3JGl2io3y0FOmQKC0LbIM+?=
 =?us-ascii?Q?gtvM9VBUTImYZylo/6uAqvoT3M/nGgoRPj3uF20HYKxnRLcegDaz1pa2F+kF?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+ASP5+qXCovD1MClb2isZKdZlGwGZukuEYaBIBuucTxksgQmxyorRZP+jbV0?=
 =?us-ascii?Q?kyxEICzHm54ixb/tF8ieFJfe8t2gib3A9OIzalAAfr53vuGICNEyfErFPBtl?=
 =?us-ascii?Q?YrN5jvrtVlCAa958D5aEZmu21iekIBz3lv5hNM2iOhLicJ8aruXR+wTXuJYJ?=
 =?us-ascii?Q?tm78euMgEURFxPy646Ang68JJh8LkKr9kcsutkrdMZjVelKrtdIKVbI2tCCt?=
 =?us-ascii?Q?/ih69TzTAFxlXoxvG7J1LwG2uR1vFrD7yrSAhT7zDs1K0GKvfioYD/V/0qIk?=
 =?us-ascii?Q?AM+v7Uk3DSmoJv97GSDcA0B9Cc+4VfpSd2p9vEch9ukJ3rdVi7sLIVEo5WmL?=
 =?us-ascii?Q?A8g4GoqpNQDJG2RudT7e9lONdRxlN73H8Ef3bV+trt5fmY5UFjVICAliAUNh?=
 =?us-ascii?Q?7coO8UEPdplZBU1jdAPs41/qLytTRcxUQcY6uUpuKeXrr3TPRlZd/3H80Pwp?=
 =?us-ascii?Q?uVweHehbIrrBLs7GcEjHa5EMp5Dtm/gyOodhru2ZTOJZ8GwbXxaR8v01xEVZ?=
 =?us-ascii?Q?cRQPPVuQos9AuNm4u4u9k1txB6tEtqBBlwd857ru6nUZRzGF3iOdtufMmvx1?=
 =?us-ascii?Q?NzRvtJhFpa60LA9afP1QfiE+epSoccCuQxZf/OpF/NNtcR44pdhCuLSoez3R?=
 =?us-ascii?Q?agAX20rSkBgmef+41LT5ayUKGh2HZlUFSbl7nsyNvzWN3TipkwZNT/051kT9?=
 =?us-ascii?Q?yzHSYw4LD7DLeQdASmS5ZydmTzl/sDRa/Z9eVyuIdSRNuy6b+mM8STO132U6?=
 =?us-ascii?Q?wn5S2W77lM6oVK04QnNRtw5cBRR4AamaNsSKciWmVx9X3i6DkXFSN2wPrkQN?=
 =?us-ascii?Q?EDg+dpeKQT3DfBLH+pp0kmsCRPgGHL5G+QP0Qi1mea0hZkh6Io+l1BDFAEKl?=
 =?us-ascii?Q?IV3LpMfREFOArv5fBqKZCkBkLeovh3NkyLQdstKbC3D9ATH/GH4rKYH5NJOh?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aaade60e-8e99-4b03-edea-08db771d1f45
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 14:45:16.6513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x6Aibl1jEHLnOqwP2xPqKNfNoKeTsxYlI//mjZc38OtYmUZ4uCtKCkGew5dJqOsFW0S2Lr+tWQOqNrlgY/rY0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306270137
X-Proofpoint-GUID: 6rn63NUKTi_5onGHJxSyM5jARMeKbZL8
X-Proofpoint-ORIG-GUID: 6rn63NUKTi_5onGHJxSyM5jARMeKbZL8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peng Zhang <zhangpeng.00@bytedance.com> [230615 04:43]:
> When expanding a range in two directions, only partially overwriting the
> previous and next ranges, the number of entries will not be increased, so
> we can just update the pivots as a fast path. However, it may introduce
> potential risks in RCU mode (although it may pass the test), because it
> updates two pivots. We only enable it in non-RCU mode for now.

You've fixed the above test passing without the RCU bit set, so this
comment should be removed.

> 
> Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
> ---
>  lib/maple_tree.c | 36 ++++++++++++++++++++++++------------
>  1 file changed, 24 insertions(+), 12 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index da4af6743b30..bff6531fd0bc 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4100,23 +4100,35 @@ static inline bool mas_wr_slot_store(struct ma_wr_state *wr_mas)
>  {
>  	struct ma_state *mas = wr_mas->mas;
>  	unsigned char offset = mas->offset;
> +	void __rcu **slots = wr_mas->slots;
>  	bool gap = false;
>  
> -	if (wr_mas->offset_end - offset != 1)
> -		return false;
> -
> -	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset);
> -	gap |= !mt_slot_locked(mas->tree, wr_mas->slots, offset + 1);
> +	gap |= !mt_slot_locked(mas->tree, slots, offset);
> +	gap |= !mt_slot_locked(mas->tree, slots, offset + 1);
>  
> -	if (mas->index == wr_mas->r_min) {
> -		/* Overwriting the range and over a part of the next range. */
> -		rcu_assign_pointer(wr_mas->slots[offset], wr_mas->entry);
> -		wr_mas->pivots[offset] = mas->last;
> -	} else {
> -		/* Overwriting a part of the range and over the next range */
> -		rcu_assign_pointer(wr_mas->slots[offset + 1], wr_mas->entry);
> +	if (wr_mas->offset_end - offset == 1) {
> +		if (mas->index == wr_mas->r_min) {
> +			/* Overwriting the range and a part of the next one */
> +			rcu_assign_pointer(slots[offset], wr_mas->entry);
> +			wr_mas->pivots[offset] = mas->last;
> +		} else {
> +			/* Overwriting a part of the range and the next one */
> +			rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
> +			wr_mas->pivots[offset] = mas->index - 1;
> +			mas->offset++; /* Keep mas accurate. */
> +		}
> +	} else if (!mt_in_rcu(mas->tree)) {
> +		/*
> +		 * Expand the range, only partially overwriting the previous and
> +		 * next ranges
> +		 */
> +		gap |= !mt_slot_locked(mas->tree, slots, offset + 2);
> +		rcu_assign_pointer(slots[offset + 1], wr_mas->entry);
>  		wr_mas->pivots[offset] = mas->index - 1;
> +		wr_mas->pivots[offset + 1] = mas->last;
>  		mas->offset++; /* Keep mas accurate. */
> +	} else {
> +		return false;
>  	}
>  
>  	trace_ma_write(__func__, mas, 0, wr_mas->entry);
> -- 
> 2.20.1
> 

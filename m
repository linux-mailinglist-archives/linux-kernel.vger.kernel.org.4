Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34934747822
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 20:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjGDSFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjGDSFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 14:05:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17AB10CA
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 11:05:40 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 364HFG5t014710;
        Tue, 4 Jul 2023 18:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=7KWqfi/7dleT0nvuhpmkgj5yVKX3XShguF3dNFLkZ9k=;
 b=es+2SZTlahcYlkRqJ3drN7DnG32WETOwMOsxvMiPrgK+ah2v8egoHnTyHCJodpcbdPR+
 KBtJ1v39BMpDSbHblUX38votWx9Y00NhAlm1HXbiiruLRqud0ETEl5RAxlETEd1lHv+6
 BDSxEkMa9vc06LhB/YBtlErtSVkglqUGTwo3nxCWxlr4wfqREw3xScoIx+H+67I5rbPz
 0/z3TDqx9jIOOFbgOwPAyHIPpkNTpaqWJAnzMhKIxEGU3tDXTlx7rQGcYiaY9JDUj4be
 qZT9FVeEEb10+rZ/gKih+zPif/OVtdU2hAKqF2o+iiGxepuP8Ip0XX+IMQ/+rVNLka6o 4Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjc1amwq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:04:38 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 364GrkZt040331;
        Tue, 4 Jul 2023 18:04:36 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2043.outbound.protection.outlook.com [104.47.51.43])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rjakann57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Jul 2023 18:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RMHR3bqV3qLJYHbCdr9ApAaml2dvaTLRQEe0JKc6N0PsK7ET9/Zm24G4x8qJtTyCinIVLdhYeqFNnANa4qIegu6XRvcFADBbqRF+PMloOHucydsowv0sILJrfpmP7jwVFBOd2ZRiVi7+jWSFoeZ3NZ+mDQVmWd6N+WSaQkk4XIdZo7b6LA6dCnb1U21BMkdJFkSToqQSuSCtrecuXIfNnxWgxTABEOrOc+/fnWRHCzp+Lsdb4gYMKDx+WXuuezpTgiHsN0zubN8rN0zzswTNiGvRekuYP8TkheR9wiNTjzbQpEaqAIWVnnYcUzcMm89RmhdiHYfCvqDHfjXr3g4zmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KWqfi/7dleT0nvuhpmkgj5yVKX3XShguF3dNFLkZ9k=;
 b=jWRlHfxDdyyvW5BU0c+D9eWctbkWDuT7onLUL4Clde8dwl9s6QRy3oLvP1emx+ynVWq4AK52pKEd9ISrEMdHAwhnpYLVIGwjpXO+BDvIJXy+1c7jdCvxxn3YcD4lrFN724rjtpaq+eYGICk3RsgKw7lZw6EeYv/8z9p4de7hfC2FPVQBtP8RA+gF1OLi/tEeU0DZ7aHRnSJiaX+fokVHuafvn8Pz4Z/pAwmh1j2SdA7/TH+gxK904mkdpzxRBnAp1Qyah6akHVt8DiHn+IP+m++2MFyzbOBnQjONc3ELcNdexTEv3pcfuzNamRAicnu4GpgsO9iIXqvi9XDc5L6jxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KWqfi/7dleT0nvuhpmkgj5yVKX3XShguF3dNFLkZ9k=;
 b=fU662gXDGh9TKZJOJD2jwPbA3V9Pqb45PZZh72EmKc3WkqAhtCeVL7gq1RkTixVxmPL7snk0Sv343LEg+h9ulcn2ZzRIZaPUQwa2sSewhm5wPnMVnXwWKUGND5cKR0v0BkZQaCMx6ac6TUAuP7oCZm9Fyh2chImyMV70xuxKMIg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by DM4PR10MB6912.namprd10.prod.outlook.com (2603:10b6:8:100::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Tue, 4 Jul
 2023 18:04:34 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6544.024; Tue, 4 Jul 2023
 18:04:34 +0000
Date:   Tue, 4 Jul 2023 14:04:32 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Oliver Sang <oliver.sang@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
Subject: Re: [mm] 408579cd62: WARNING:suspicious_RCU_usage
Message-ID: <20230704180432.mapeimtivfe5l5kd@revolver>
References: <ZKIsoMOT71uwCIZX@xsang-OptiPlex-9020>
 <CAHk-=wg1_8L+e09_RuX=Z_49oLn8=w82YzCk+kybS-ymSd_zbA@mail.gmail.com>
 <ZKN6CdkKyxBShPHi@xsang-OptiPlex-9020>
 <CAHk-=wjXEzCV7HGPS=2zgJJ8R14e97hAesQ_7fjFZNS=jOADYw@mail.gmail.com>
 <ZKQj238p843J4eZ1@xsang-OptiPlex-9020>
 <20230704152548.afqtyylbrxzunq55@revolver>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704152548.afqtyylbrxzunq55@revolver>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0034.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::20) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|DM4PR10MB6912:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b598000-2a72-40e7-fb5f-08db7cb91fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o/wQx1fjshvQRyOjDKF8pT9magGPqcz3D+aRaIWOpD9nWbSzTpdmndUJ37Y3ZtrmDb14btiT5VmYVs7KvCFGof7HS8V4glhBRgavWsqvFxMs3SPsZ8jGhZKtkXUrbqJbmoAv8/dDNSnJXogm7TFJ9gBJn+r7oqaU/gpUZclHqcWjcfR7+CUz+7d6SLGnD17HNSlCeQMPaR8F9dEkRYv3qd6z8r9DJI1GdNxWmRAajnW145KfO8axILHMggab8msrFuBKzR5x65IZ5DmD5Fk59XgjN7AI3YI5jPlUKryQnpEWa3WofVElcqFVZjYIp1sbdTR6eH0yeY6vKUVBVwkaNMVBRVu1wmgX5octXtJr8Fc4OW3Ka7IU8yO26wi19Ugdw5mIomHGHof1blV/9o3HndlCSCBN7UPEpkMp+Bf2hxYg5fYSGtOlCsb8BXBUTLIfAsOzzKc6dIrXYikR9XI+o2SvWKpbgy+BnynjiWPWFL/jR5crmJ4ZZPM/ZewyZ5W0Z2A5LlQr/4srB0N2cXs2zeBOtEwwz4VvuYvF5tHk+Uf/dcElRYX/u+UsM4lRjJCY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(396003)(376002)(366004)(136003)(346002)(39860400002)(451199021)(38100700002)(33716001)(2906002)(6486002)(8936002)(8676002)(54906003)(41300700001)(5660300002)(478600001)(9686003)(66946007)(66556008)(186003)(6916009)(86362001)(1076003)(6506007)(6512007)(66476007)(26005)(4326008)(316002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AoIZg3Unm2GpLvIdX6hn2YfJhqX8TqvcyoA0zvi06AqPxNyAMzxjj2fx/+eb?=
 =?us-ascii?Q?jF9fy7MC6Y4O9oumBcYEnsSGJg3H4E+ffbSZISdXFI5Shvv1rK7uCo6c6QR7?=
 =?us-ascii?Q?0RD63xUNNNxWgMvK8Ra4M7enk7fsT7yBXTWPDJV0e70XRNW96W+ncmmxhrDG?=
 =?us-ascii?Q?mBbCB4FFchUevpaO44BBzh7H6/FCapNzAgkrfpxI6wTlYWLEJODVMvFjKLQg?=
 =?us-ascii?Q?vK0EFtGjgL1e1DhGWXCc7SJYyRchwCdKBLSuBEh9vs+gpYu2iVIYTPFStM7M?=
 =?us-ascii?Q?y/Ky9AyWwmHkoHpV7ENJu63kQcWYijBvsg325vqd/IQK0U39ht44agrd+Dm1?=
 =?us-ascii?Q?NzjGKlDfO0fBI025qx/3M0051uDSrEArK3fDGb7RYNYVse0qth0RVifYJpKq?=
 =?us-ascii?Q?jNQiNmztDADUk8YVMQNxJolzNcKmYt7bMxJwh9rwjsDk4fKy+lt72qJRD76o?=
 =?us-ascii?Q?uKcl9iZ80xvSyPLFimWFg+l3aWmEXzOXML498sFkbNg/UP/cHWSC+BPnThNL?=
 =?us-ascii?Q?MxXDNo44XLmw039OynJMqH4vbbNUYzNFILXlIDuVnEl0ZIJYpgib5y7fwlJq?=
 =?us-ascii?Q?1Hxytov9N+Q4qaXwKt0uAI9WbFjtUOhXHL0wKTtEuDdS3dkDN/pUM6x0+LrV?=
 =?us-ascii?Q?HuD1xNeCqpNvBEABYm0GHTUyYLXfwbZm2/hq/lIXsPRdAe99quwc7iptZw8K?=
 =?us-ascii?Q?2YFsohZ+A676sAMYvG/q9d1SAKeCQat2mGpcOcOJyihH2WFS7p5CwMCJa1gc?=
 =?us-ascii?Q?fnt8pxO2Be4aTmGxKO+azZ2mYJF+TxP5BEOTvsloBEUeNmnYQcV4BFzLBts6?=
 =?us-ascii?Q?K/nIPPZdjK4KggzCzW5D3/q+IjUGH0yKoNxYO72oRmar8O65b5Wnzvet33pB?=
 =?us-ascii?Q?ca6tpkg3p4NfqJxK4uYIwhEoA0yP5TQzT3bWMzYe9QxkQqxYvD6c3AET9AE6?=
 =?us-ascii?Q?D0xJnqMe7ntmNgBQeAYSBe32ne0+MlD0oVq2S5MWBFuXBEGJmYcAnR70RMQm?=
 =?us-ascii?Q?QYZkHGKXEK/UXXbTqs6EftKAOS68hRMLgICl70jtCj06RburDNxF0lKWSpKg?=
 =?us-ascii?Q?irbPLTF8THb7ZOhknS4iprq2TMl4DQ62A7W6MI2hAtj2TE/zrXWU8yie9L5u?=
 =?us-ascii?Q?iQi0DUSSeP7UCdxVEV6fwzu44u+m0E1brtjxmlN0/RfaLg478oZjaEa96Tn4?=
 =?us-ascii?Q?uczL341O6t36FXx/4ZpLw8jRg123iPOITS7VPxO6N1aI57rg2OGugCM0cIQ7?=
 =?us-ascii?Q?8b1NUmoAP1iVpSUBZiJ5N972bzxXbX2WqfxrNoj/NMsemaiVesFqGYzvsxxr?=
 =?us-ascii?Q?el0yZ17R5u8eOMUbwVCWAqfrHgVfrVhAyWhKYMdlUK+fRewELaoPuk8hQdSf?=
 =?us-ascii?Q?+55nm5qI5IKX8frmXCvw5okTyYNyDjpCHrDEeb17grF/2N8H8jfG9k9NG7G/?=
 =?us-ascii?Q?rs+UCb2yQt/dm4ZduJBITBCxg57rRpkFmyRQmI39GW6f89LgeNLyL1K9ZmR1?=
 =?us-ascii?Q?qwKBxHbPi+C153+KZBzmH7FYOZVSXQLPtdJNx4HYdeWWvKtv36E/p4Ui9Y7M?=
 =?us-ascii?Q?FRDumQLHrqHlf42WTAANcTHbMyNMTV3M4ctZKTk9sg/vjPxy/cJWFvudXdta?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 8czCw/Vnr2nXjc9Wz74oUcTvagM3vFlFqEPObXqL5wADdMmCNMLLqzNUi4RcHHNn5pGciFamZ9ICeP8gHgEFmO70elIqEgBVjtkGW7jT6XCG12TusFSnSe6bTLlHbx9uX7Qk/S6mYbbcIt96UHL9fwbz/CK81JhYkfnz9Yxx6949ULlY44dmGepfxekNy+nFATW6B5U7K1tEzNb21MA42bGW4J4wZWS2EoY85aQHajsy1lQZNUfvN0mE7mcSHEESPmuKdv4c/xh50jDTaAw3h2w5wdEKTsBQKuMeI7koQRvMS2WsTaZZ1tH++WwL7aPSC9GaN8kP0etL9+Wt+EjKFpMscsJFYJqFhkB0XOft/EtNF1jo9XlwaHrIZL7buXX0OzsPqPQWrcofkEegedXCXydtf49GIxnpYxvZ4Bc1DXKi2acr6hPZmwYJkMZGBM47YC0Wk1AkyFg4oJ+atALeSdCvwqC9xX/gf+RmnHYyNMT7a5XBmXwgrW4gI7rMqdZbSe4DX5UcRcDZD8A+z7YrE7mMFyhLC5747UXRi015G9S0VV0MM+PgcFm7Ck8p7wr7JsvewoirsD7GmReKkuo9/y2KrqwDiAXJjAGSFb9C5QM74KDE+SLEK926rspYXLNZYmtrcWWFrblpSzIGZkFZchTYh2mPL37bdhyAKrQ+dFZOuX6AeJ5RT0coxqoqc2/We/W2qoZa4UUW5BWqmpjbN1qdrO+1makrM0YtEc3w6HUl2r0vPvtIG7/0LRKFq3W7eouQcg3cuIre0BeXzHY8ztgGbe9/ZGL4A9ZMw/p/n9jOcYh5iNXpw9PUGW9MoB/xpNKw2798l1elDAH7yKL/qCVAMwZ7KrHlosBmUs3UDRfAakBUehcADkj9sDzrmIzo
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b598000-2a72-40e7-fb5f-08db7cb91fc5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2023 18:04:34.8738
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydF485WZnEDPsOy5A9FODiWEzV7oc2JfotxStk5JbdZkiImtvalv4PBGbcMqz7AGuAYlsesAfMNlnSz3VnIilg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6912
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-04_12,2023-07-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307040156
X-Proofpoint-GUID: ieD8vmlVCm4fBZye8YUSSD8HIRcjn0a3
X-Proofpoint-ORIG-GUID: ieD8vmlVCm4fBZye8YUSSD8HIRcjn0a3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [230704 11:25]:
> * Oliver Sang <oliver.sang@intel.com> [230704 09:51]:

...
> > > Ok, that is indeed a very different stack trace.
> > > 
> > > So maybe the fix is a real fix, but the first complaint shut up
> > > lockdep, so this is the *second* and unrelated complaint.
> > > 
> > > And indeed: it turns out that do_vma_munmap() does this:
> > > 
> > >         ret = do_vmi_align_munmap(vmi, vma, mm, start, end, uf, unlock);
> > >         validate_mm(mm);
> > > 
> > > and so we have *another* validate_mm() that is now done outside the lock.
> > > 
> > > That one is actually pretty pointless. We've *just* validated the mm
> > > already inside do_vmi_align_munmap(), except we only did it in one of
> > > the two return cases.
> > > 
> > > So I think the fix is to just move that validate_mm() into the other
> > > return case of do_vmi_align_munmap(), and remove it from the caller.
> > > 
> > > IOW, something like the attached (NOTE! This is in *addition* to the
> > > previous patch, which is the same as the one you quoted, just with
> > > slightly different whitespace as commit ae80b4041984: "mm: validate
> > > the mm before dropping the mmap lock").
> > 
> > Thanks a lot for guidance!
> > I applied below patch directly upon ae80b4041984, and confirmed the
> > WARNING gone. Thanks
> > 
> 
> Thanks for testing this.
> 
> I can clean more of this up now that the mmap locking has been changed.
> For instance, we can drop a number of checks before a write (and all
> read cases, if any remain) since there is no alteration without the
> write lock.

Thanks Linus for fixing the two issues causing rcu warnings - my testing
had lockdep & maple tree debug, so I'm still working on why my testing
failed on the initial patch.

For the time being, I've used the config from the bot to test a larger
cleanup of this code.  I'll send it through the mm development as to get
better test coverage.

Regards,
Liam

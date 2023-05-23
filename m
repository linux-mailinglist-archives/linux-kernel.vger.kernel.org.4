Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 134F470DDD3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 15:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236975AbjEWNrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 09:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjEWNrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 09:47:23 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C1DCA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 06:47:21 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDi05T011762;
        Tue, 23 May 2023 13:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-03-30;
 bh=bMdioD16BwgetLPc71Xpo1uIYyHFuG/uxMXnxB9Z4fE=;
 b=nO43qutBWF0Q34r9ihGGl7T6awPiLoUdzo82LP32hTmqw/Du0sic3ZERvX3E9JLAwV30
 cdXHY1d0MwI8DKriJ/QTQ9TzxrxMXg9gYqWYL3mNShBrM+p1QDilxrH+Y0UU+j350S5v
 Y/JjDDj3MMvMhU1sVz1nBFCKHGqUIB+laj8hsl87RlFRBT9+2mp4XlMYT8PlY5NiRrxe
 aPkH5edy0PViMCcH4P0gJZsRwiJZDwuBatJ4/2+tchDG5DKaR0bf2YMP2fsJzMqI6LAA
 w6LBBmEqUpe6fbsf1xVuxhy7F3wlTbl++xZaivsS2sOe0A4VjWPOmhE8t7bgGv+PmEvL FQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp8cd72a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 13:46:52 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34NDMLBA028913;
        Tue, 23 May 2023 13:46:51 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2auq8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 13:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6wqmeoARKEIPbQGJzcoTzXsr+O42wwubTUrw290FbYqJbfjRTN65V1Rwjygn3oiSKoD9NNQs/F5xq6sfjimNxT2E/7sdvwtVWuNaDSjIIdtg9ita5Iov4VhnnNnTgjSpHS+ZdTkr1DXUBUEKgXKUh49ajpfzrJXLm6gUyMdr3l2aMbIBkZXT80D/BfjYRH/mFDM2gR06rHp8t9rap2iik+4EUkAF9wm69RzIfKcm4RKeMzmnC0kl7xRDQUmQpN0siqtBQW4Kq4hDE0pVeUzThbEg6iicq6Ss++FKHZ6lw7tJktLKiY1q7Q2cYPC7MEhS/3R0MR5FHxFUg9RGMcn/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMdioD16BwgetLPc71Xpo1uIYyHFuG/uxMXnxB9Z4fE=;
 b=iofW4MjsvYrFm5ImyHgchKjm/sJY0/fSm3X2W+jpsRzWEHqYrD4fl8rV4UKPQzG7JQkmwlD4/LwqZUiYfDXjYE/VOjecZynVUAT+Jqn2d4hGD+bZcxtiBG2EflQx371QlbcDki8Pi3YltVrnbiEGYEGPpuJ3ynZ/ug3pbBoDntQF56r8/2692KReEbmD5rZTm5Qm7tHWK5KC1/S11DSwRBNfCRuvBrTSqgs2BMltP/C28SCtyB+12sBI+BvrGtAzwQSoDG0viH2wLHon3xphUwf0Xvr6ptM4i8EhMee0eCRWKzG4MD2qlA2buVomaIwshB5IgSUAvRQzD+tm7aglNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMdioD16BwgetLPc71Xpo1uIYyHFuG/uxMXnxB9Z4fE=;
 b=SRnk0RM51sZAhS+cnogSPxiR11xw3cP8nAncVD1ay7GmczMU5CGhUhoBonPc89we/pSyyuZVXBbVmrL2nzRv+XzgHU6H1W9mULBE1AcGFCZ4wocdlIikn7BBiS5vEZoBjnShvK9/MG57tc+yOjD8srkVHE0Chsql+v6Bs3lGrqU=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by BY5PR10MB4180.namprd10.prod.outlook.com (2603:10b6:a03:211::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 13:46:49 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::998f:d221:5fb6:c67d%7]) with mapi id 15.20.6411.027; Tue, 23 May 2023
 13:46:49 +0000
Date:   Tue, 23 May 2023 09:46:46 -0400
From:   "Liam R. Howlett" <Liam.Howlett@Oracle.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
Subject: Re: your mail
Message-ID: <20230523134646.gelsru64qvny3fi7@revolver>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        Shanker Donthineni <sdonthineni@nvidia.com>
References: <87mt2cxb7y.ffs@tglx>
 <20230515192708.sypitem5hzycdois@revolver>
 <875y8r7v1i.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y8r7v1i.ffs@tglx>
User-Agent: NeoMutt/20220429
X-ClientProxiedBy: YT4P288CA0031.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d3::9) To SN6PR10MB3022.namprd10.prod.outlook.com
 (2603:10b6:805:d8::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR10MB3022:EE_|BY5PR10MB4180:EE_
X-MS-Office365-Filtering-Correlation-Id: 37bdaa74-2ec9-4140-78af-08db5b942848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SNstOJOHHCyoLtGf8SnWLk6lieHEwk6ktCkomqfZ+pPhTVQCesYoN04873yw/FPSg9+D31qVz9Q3z2jZYnCqAnSyClazOTJRaE7e2PQsDMLOv2gf+L7+npppSwUBR3k2/ZfyseiCvEZrhhCGWVEJh5yV6BwSUDe1zB/34aj1IMpqQE/cRXt8Tqu7ERXn3G6hvkRlzYHLYkd60b7idK+p79kPdWiXuGnY7zFGsxo+IcPZbF5jySEBAvQVs1trEbbfO8BepRYB/RpaR8eMmQDkx2vOqhKQv/2qpBcxDuatbsoyrL4S9sr2xAQZpzYlZSQuq04BwZLLLqcjdx/Ong7/ls5cpKhwt3YXJczbdwGYjIOemZp/XMrXBizjnyj+PUJ5s6eTgmc5eqvDoZ6wF1+xTxbpdvse6lSpcR9nclpbL279Vx0uzb5IQe1B6fCh8dKqtp9rMEgfAKPBED3ixywLzzjJNG0tam+ImQ7OsyDWFsmw7LF2fgVTK/WCgWQTyQIlpHuW5eBcTK9iSWPzkm4++fa90jJ4nHE2D/71hZtwXWqezslhWbB6zWq5BDV7eppX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(366004)(346002)(136003)(396003)(451199021)(41300700001)(66556008)(66476007)(66946007)(2906002)(26005)(1076003)(186003)(478600001)(6486002)(316002)(4326008)(6666004)(6916009)(5660300002)(54906003)(6512007)(7116003)(8936002)(8676002)(9686003)(6506007)(83380400001)(86362001)(3480700007)(33716001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oE8t3QzvgduvTFvKphFBXOZKgAs8ueQYLUhFM92577vuVsXukR0kitWNnXbB?=
 =?us-ascii?Q?Q+3xWEjdCPsFCLrS6AxfE8t2VW09qP6/YAF4nwANKdukzGzYNYevDkYazsyX?=
 =?us-ascii?Q?aVUd9FmeYViEPwl0PikpslgFg9fN3xpJh7FjfHXOA88uN8gk4Al0o04jWWcf?=
 =?us-ascii?Q?i+nVtuVTgFecfjZ19QIdoWrKy/Qht0kTX+lY5KY84AKTFPUqZyH2cnim4GHI?=
 =?us-ascii?Q?lDirY2J/7wGghHeDyuygak9Lg6eVrG1iesfkmO4ZOvL1/n/DK6x/tNlitlVm?=
 =?us-ascii?Q?QrZua5afHRnQxZ4CuZfYl8I2crd7yjbd+bjAtfGd0Q661VJeBSWY40CH3M3Z?=
 =?us-ascii?Q?asU3xRc632FF80mgje6KmIyBYPlfglTzAOrb/OPu/bZ4nd5ECYtd3/i06yCA?=
 =?us-ascii?Q?Ma/gf3fNy9yHDhznh+mQXlaEt+TUGzwNofc5NCwMomcwXsZi3Ep2f2heMdjS?=
 =?us-ascii?Q?V65zrMfE4/4hvsG+g1RN1ZkXKUjmctscm7+Zb9bkvYAACZ2lktYCRsv+hiqt?=
 =?us-ascii?Q?4OmjQa2nJgTXN6GvwKOIisH/rQNZU/YasEls5Ina+nyRe1RsJ4fjnJZMoEEZ?=
 =?us-ascii?Q?+wZT4byZ1u75AeKonO63Pta7/s6Qg0+FVdsbjDLxV3uzlOTQpHI+PpexMstU?=
 =?us-ascii?Q?h9QV8y39Kj9PLTHNL4j/lSqNDkeYwZhG7Yz1TRT0dCM2XLmSNv+y2kl2ah16?=
 =?us-ascii?Q?2CVtMqVi+Gkp3bBhLINMYsPNdAnbvWK2f60JMQ9aBTRpwmWIrDcQ7WM0pjQ3?=
 =?us-ascii?Q?V+1sJp2o6lQ2A4IVooGxeuYxl952hr39dk1gwcfe00gWu9Kch0IPqjNSOgfM?=
 =?us-ascii?Q?AU7BuH2hjPtOa8tSyk7k1pV9Y1GX575kkb141Zcz8X5Iev+tJ/oFPFC6RK3K?=
 =?us-ascii?Q?RxBgNu70Flf/k9no/Cnjpj2uBCY+x8nzDndXYlRm5lQ+P6vYL0XtGlhb1pvi?=
 =?us-ascii?Q?VIKsFeMNylU+mW4XfP+KHi8Msdue99OlOu0qz+1Zgh7kdwtHQQFWspRRcy23?=
 =?us-ascii?Q?9Qw4UNZTYokvhORInN21Dl3kp/tB4kFLwfU+ueuBGCrm/ZOr8s1bwHjFax3r?=
 =?us-ascii?Q?yildSEeIswRfi6qofa+DakbdDOqSt9NDsYH5+I5/e7lQIyAFM4q7unA4nNQa?=
 =?us-ascii?Q?vg3rO+sNqp7xkK9DN/E7rzwnZzZHNZYzrx7LgYy8z+TlSLR1wrgIDymHHovH?=
 =?us-ascii?Q?Z+W+sOdzEaK2fo7+D9kqb4rNreeO4KBq3/ox5wAcJrU27eEzzi0hrEQ7AQnq?=
 =?us-ascii?Q?cFCaVSqTsIeXJTwCIQNP4EWGDzUiMNzQyp92VARhHHfGI4Hmsw0ybvjvTFw2?=
 =?us-ascii?Q?Re0uchCD4Vn8z6I9JdKzfoA9EztFXaa7tz3HrFKCYUL4nxxhlaBn7vyPSK67?=
 =?us-ascii?Q?kpGENkUggkmwrKlx5GHSKYo19OZEL0ZeByg6desUmluDEdEAbzunNnqY1p1u?=
 =?us-ascii?Q?okVAgP4tiKAEagV4W3u0w5jOZ6FsJSTWu9qiyI3WjJ5iCarndXcfmDAQZcJg?=
 =?us-ascii?Q?ZGtBHXhLjQztnvEK36W6QfaG/Lt4voju+ROQbzEU2+RuWJDdoKfY9CXUs7Jh?=
 =?us-ascii?Q?imtMFhbXQmbvV87K4OvdR3wPU8XKFO0RqBp1PEivZsaYRwomvtGtusmBtlBb?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: P49tf0YZ41E4CRw+7NM9eQLY8HoNgP+oN5Vx2dcjrkvGyXsp0fwbJgVeQD0LBjp6pU4r/a6y2ytEmLngtfNUnjOlyBQmx2f7GGV+2XUsbE6hkLce2lQbfyyAREd7PB+SZWgGEsffK+qW6RJAe2I5OC2SZU2amu7byXio+hgVPVrQMvxjHezpTaoci0nnR82fkmnpTTe3RFd/9OOhg3/GKUEgczdp4QK6mv5GNh2coi/JAMcnbrMAxp2sAtwn5sE8YBlvgGtDvKvvGg4G9KEmO/V3gdrI/ZtGg3du2Fuz9I1LyU6etEv4j0hABSot/vUc7kgkE5fKopyEvOWMwsNq/F2kY0GD0CIZQp3zbAzCsObrFZTZP5am0ndLlPpyvc625ujJn/oMJO9skv1zyphToBmWYJgf3mzwYmpTBQlFLaL0XeQb50NLoz/ENGDY8A61u8ZrmggN0u8Go7Op9+vpoRpkzmkpbg6gvkxRnN+PFXI6MIQ15yjhKGMAG10wjKYygOyaue8A0wA8wKvrAIyHbhxnIlnY+vn7JhvsySlpiBXKrmDQGKbwqIEpKHvL0AcFWR+RfxyCge/yfzzvypKCYH4zz3Oi4oBN3R6fuQWGtswte46LJwMrTvTzjJnr4g8olWALu1VzCPmreDuVqP1Rx47plbzkYAtTq2eCMuse+ILI6laL0VwlwP9gciz6ZHaDNM9N1IK40PSp+GUcYsN2EEM1yjfU1zmKDb4gLJ0/B2gREFlSbr2kdYLjYXHi24oCWXl3pyNXcfy4kBCXZ1f+J/Tq0SyjQ4Xm3io4hJ717OZotGF/K62NS2+oHT/m/h+pWZ2nrsrCmpe0AylV434GSNqbAkA2zNJ68k8Z8l1oNoKXc7srE9eG+NfsQQdJG7ZUXBSRTquPOyO/zF/dMRl/rA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bdaa74-2ec9-4140-78af-08db5b942848
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 13:46:49.3810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOCFlOFayXazoBuwO1qit3Z6Nek8AaZHVLxLfTjxlTYSF+GF9agJyb2g0MXRlxU0ggo2Y2OFraRXVZ0aIOUzQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4180
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_09,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0
 mlxlogscore=410 phishscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305230107
X-Proofpoint-ORIG-GUID: TzRzx1KV93_NBUuYta4zMhOYJ5KRIkoy
X-Proofpoint-GUID: TzRzx1KV93_NBUuYta4zMhOYJ5KRIkoy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Thomas Gleixner <tglx@linutronix.de> [230516 18:48]:
> On Mon, May 15 2023 at 15:27, Liam R. Howlett wrote:
> > * Thomas Gleixner <tglx@linutronix.de> [230510 15:01]:
> >> The documentation of mt_next() claims that it starts the search at the
> >> provided index. That's incorrect as it starts the search after the provided
> >> index.
> >> 
> >> The documentation of mt_find() is slightly confusing. "Handles locking" is
> >> not really helpful as it does not explain how the "locking" works.
> >
> > More locking notes can be found in Documentation/core-api/maple_tree.rst
> > which lists mt_find() under the "Takes RCU read lock" list.  I'm okay
> > with duplicating the comment of taking the RCU read lock in here.
> 
> Without a reference to the actual locking documentation such comments
> are not super helpful.

Noted.  A reference to the larger document should probably be added.
Thanks.

> 
> >> Fix similar issues for mt_find_after() and mt_prev().
> >> 
> >> Remove the completely confusing and pointless "Note: Will not return the
> >> zero entry." comment from mt_for_each() and document @__index correctly.
> >
> > The zero entry concept is an advanced API concept which allows you to
> > store something that cannot be seen by the mt_* family of users, so it
> > will not be returned and, instead, it will return NULL.  Think of it as
> > a reservation for an entry that isn't fully initialized.  Perhaps it
> > should read "Will not return the XA_ZERO_ENTRY" ?
> >>
> >> - *
> >> - * Note: Will not return the zero entry.
> >
> > This function "will not return the zero entry", meaning it will return
> > NULL if xa_is_zero(entry).
> 
> If I understand correctly, this translates to:
> 
>   This iterator skips entries, which have been reserved for future use
>   but have not yet been fully initialized.
> 
> Right?

Well, that's one use of using the XA_ZERO_ENTRY, but it's really up to
the user to decide why they are adding something that returns NULL in a
specific range for the not-advanced API.  It might be worth adding the
XA_ZERO_ENTRY in here, since that's the only special value right now?

> 
> >> @@ -6487,9 +6493,14 @@ EXPORT_SYMBOL(mtree_destroy);
> >>   * mt_find() - Search from the start up until an entry is found.
> >>   * @mt: The maple tree
> >>   * @index: Pointer which contains the start location of the search
> >> - * @max: The maximum value to check
> >> + * @max: The maximum value of the search range
> >> + *
> >> + * Takes RCU read lock internally to protect the search, which does not
> >> + * protect the returned pointer after dropping RCU read lock.
> >>   *
> >> - * Handles locking.  @index will be incremented to one beyond the range.
> >> + * In case that an entry is found @index contains the index of the found
> >> + * entry plus one, so it can be used as iterator index to find the next
> >> + * entry.
> >
> > What about:
> > "In case that an entry is found @index contains the last index of the
> > found entry plus one"
> 
> Still confusing to the casual reader like me :)
> 
>     "In case that an entry is found @index is updated to point to the next
>      possible entry independent whether the found entry is occupying a
>      single index or a range if indices."
> 
> Hmm?

That makes sense to me.

Thanks,
Liam

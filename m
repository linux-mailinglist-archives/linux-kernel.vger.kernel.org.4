Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF955F7265
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 02:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiJGA5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 20:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbiJGA5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 20:57:39 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC00F2508
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 17:57:35 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 296Nwt91022957;
        Fri, 7 Oct 2022 00:57:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=Buhmb5mVDBNZshb4nf7O4eDyBfMhZSQUO9s4pJqDH/A=;
 b=hVcddRmlhxLsUu2Pfs8MyWn1z5DdPPVs9clHNxI0mS+RLk8D18kSbO+9BTcr/rHfqL9A
 WB2Y41YgpVmDcaN6rsNZIKsAiPx2QZMHtyHAXCe0jihlC+Xt0dCKSxPGSEfy4nYa0vcD
 g+82MoxbNrhS+w8voCUihvCz1rqBlkGn+lMrwpbyUKE35NMelJl/AY7xR/uXUICg9k5X
 TM79K+dfpPO/tsYCOWrmMXT2cC2WmneaWiycjSC0HNlD3y/WpAHn20vmNb0cPGnwbyS3
 Zkil+nCo+UzBhANdEhRORoAiPp9Ag/idayu8CoBMoohrEa6DXTpiXvYWh0CVqQFMmgc1 9w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxd5tnpxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 00:57:32 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2970KTuR020674;
        Fri, 7 Oct 2022 00:57:31 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc06nh5j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 07 Oct 2022 00:57:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jR/UmLVW+UBBQoGIB0txRSUvPn8h3zzOi/Zz0G2kbN0kj5TQbG4yyGmB1/ikX4WMJfVY+U2l2yDevMlx1NfFQJf7b59cUXUU2umph/0qNfawdCBxDHr/W9obvrhdBSJucAWWpf5wqI5G80cai34uCJlT1NbmnEn/+e5ez7uXRAQsQB0RpzfswJmxtljuxDcofRnwaiqIHubvBjPy0Nn1L38uAHmz+OuWlPXULYnJA1RxhLOlWdPr1fpLv+/I0bjXFZto06vndiHlFb3qHfNYcFpDIcEQBrol0mGB3XJzIGViJOOCcNyciI8/LwKmN1Cq3Dg7klhlqJ6hRSHFInjh7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Buhmb5mVDBNZshb4nf7O4eDyBfMhZSQUO9s4pJqDH/A=;
 b=b+B422K0zJ7GglOonwhgtYnidY1BGVztn93qwm0A/H/d4rHXZduVo1sC6yTEYjLiOTAt/KDnF5MpGilovSZ5hla5p4jnbA+GMlsYaGteBxZuWXvhW3LGnqa6kJlzal4aFkWAc5W/DsXzlK7sPGbdvBqiumXssS1Eqa4CYztXBN+sXqw4twD1IStpOM4o7Y9y7Kd7uoxU8gCCSSfn3bJ72MRtkJ0Y2WPOMKm3nnBSIho0ZJgf7ddLbrG6GQ95Ge+WUZ3mV5uuPayz2woTHvmGKAVLmZKfxaTJ0lVofIrIOSJ5Zj6fd4VUbuQ4rjZTAF06tqdApqieJqxko6c6dFY8+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Buhmb5mVDBNZshb4nf7O4eDyBfMhZSQUO9s4pJqDH/A=;
 b=DcP0h/1OQ7h5kFny8zfLMfAczkXTmWnn7/SMcpBJzG/WttBQUNrvVpZxJO2G31aJrjZ6fT39OF2c7JOxPzn+iqPDllS6ujiVkZMoKUhmrVtQSX8nVm+tLD1v0+HFrF6phAcvYzKR8ky5sBWpXqbVDbnCDO7HwJoNvqutgdry2DA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ1PR10MB5978.namprd10.prod.outlook.com (2603:10b6:a03:45f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Fri, 7 Oct
 2022 00:57:29 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::4c38:703a:3910:61d6%4]) with mapi id 15.20.5676.039; Fri, 7 Oct 2022
 00:57:29 +0000
References: <20220927225944.2254360-1-ankur.a.arora@oracle.com>
 <20220927225944.2254360-3-ankur.a.arora@oracle.com>
 <CAHC9VhRBuBiuf6917fpP7n+Sy5fFTpzzEqRXfMGPCbnNU4jswg@mail.gmail.com>
 <8735cagcgi.fsf@oracle.com>
 <CAHC9VhTQ8HR4ZF1VNCwuFabTUU+Y+ooeDuSwNTozuWMo4RbgSw@mail.gmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From:   Ankur Arora <ankur.a.arora@oracle.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Ankur Arora <ankur.a.arora@oracle.com>, linux-audit@redhat.com,
        eparis@redhat.com, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 2/3] audit: annotate branch direction for audit_in_mask()
In-reply-to: <CAHC9VhTQ8HR4ZF1VNCwuFabTUU+Y+ooeDuSwNTozuWMo4RbgSw@mail.gmail.com>
Date:   Thu, 06 Oct 2022 17:57:26 -0700
Message-ID: <875ygwbgcp.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0177.namprd04.prod.outlook.com
 (2603:10b6:303:85::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ1PR10MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: c7dd7a65-140e-432a-2b6e-08daa7fee88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uptL3ynSSnBYlZUCUWnBnmlVzSZ+qpq6FIR/ZSc6ZLlyle/TI/kLpaRkI8eblnn2iwC1eFjMWrBKT4aIoWyXAlwq/6Q9JWQICq9agIh2UgGyuUKJS3fr2s+u993VbJqygrv7uU/COaU63O2omYLY+FP78f2TW7JQfzvjrUJYTkxne0aQj1RJ7O1errbMh/e3JF1nZ60fZlJ4yTHF2TOiWlxOeK2tZKFYs5JXqg2/Ohe2QVaTzqE/nbC+hObThd33ana82IinTCgNarQxkf7xDDf6q9NfhhiGZM6Bz9YW0jF70KP7YVdcMPd/uSD+BO650e8TDEl5QX/6fjOQk9GNoypF8OhmwLQZiiqlXHBy7o/J0stbp6/4QxiCtQNtLPGYKP8Fms9W9Dta6ZHuNeHSM1/qyaREu6spunBJeLaTgGgZXJ7rcHnqyxMCYOmpPqD/nbVxU+ZP6iXfIgyQGB3iF+SN3Gop4kJ1NaOjh97+wBFLecLwWW9YQDCGam89fu72xDqqJ2lNxAKvIE9hjiQj5OwwfPUvM9r6ADc2XRMRdoiYWWHjALf4ni8FrF8uk9RJkt0ia29zAGlmOOcLtYH9ETaooDyA0AixYLamZrMzVgRGbtNhYDcgdIWd9jV65f1sJBimrOjlTgmg4ypagiTXPsR8FKJ+7OtEdE1qCNC6XgbL4gy9h7pfWRmg57gKer1Tfy+mQLSDgUb/WIldMCxiag==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(366004)(346002)(39860400002)(136003)(396003)(451199015)(26005)(38100700002)(2906002)(186003)(8936002)(83380400001)(66946007)(4326008)(316002)(66476007)(8676002)(6666004)(41300700001)(6916009)(107886003)(6506007)(5660300002)(6512007)(66556008)(53546011)(6486002)(2616005)(478600001)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XOD+kAXxao/mISOdjD74J5pDCWpcxNRjMsdIlca/LFkHBGhzhHWrrJrExU/l?=
 =?us-ascii?Q?nJ1QxJrMYRiAqSlWvdlaCqvQ1ri5Kti4Ynr6jWsIOYpKIpY/6NaJTs2gt8sj?=
 =?us-ascii?Q?29CckStKlqkocyOiudUOCLZklBea2hm++2j5vsdHDFaESKXrQMonp2Jco+/I?=
 =?us-ascii?Q?s55RPw5Ks0C4a6mzURfje6Sn4ATwIyMyjUjpj0yJRV1mU9mGz3m+PozFnihD?=
 =?us-ascii?Q?NWx/bWyIJb+YSpoGnNBYbjkVdYp3qkuUb0VYNZxi8PUTg6WZyP39Pno3cdNq?=
 =?us-ascii?Q?qM78tEQERiS0hHCuDxZTHkW9PuYJF0XfiIoEXQv0y11Dmq7DJ6dEAS7SO1Sn?=
 =?us-ascii?Q?K9i8cBH+1SC/HN6+oQsmeD0oNCf0wEnkZdZP++lGyozvkxrh6J3SlpbwoZ5G?=
 =?us-ascii?Q?7MsLWjEdTM+2VSkPysbfC7W4FAy9AoAnu50ViB4x8gIdLVLQN07gJ5hspLfr?=
 =?us-ascii?Q?zJZza47yaIOzr6FOVaVsM4PGgcRaj9jUik/gHa1sZJeXcCwiI7EufSL2F23Z?=
 =?us-ascii?Q?5EVmVKOlLbJ5i7B/iYLkYSIz0c1KL7iW2LU1dBqKp/ElFouAB234ZgZyfA82?=
 =?us-ascii?Q?r47IvouQ4UWvAI007iGi62GIpKaJFJm1kQa0zuYxOxTmBFXfqFrgBxIKS/Qc?=
 =?us-ascii?Q?YIzWuQ0GnBrr8lEV2kaCMS4V41w8XGvzDApAeIifYL8S85ONYu9wyGI/HL51?=
 =?us-ascii?Q?GrNBTpEHX6S2jmdZz5MnIe+qq9NR1ChrCw5sIn+LKbJYP+ZvE6r75vvosUs/?=
 =?us-ascii?Q?n9vgMvcdFHhfrIjqJAn8zjRX4khY1j45MagG8hwmqFO7zn4o/j9ffPErPyda?=
 =?us-ascii?Q?dU/gWR0GdSmjoXHOsU2x83e3qKxWecubxqTLV9S3dixxQ9T4lPnCj7J7oyrp?=
 =?us-ascii?Q?3LY9ne5rRX3fODNKaDSq0/9OnYCTr5BZb1vlo6uQqSivofjRTRf9hosblQnP?=
 =?us-ascii?Q?23pUu/t7uDb/7UDy9oZnk+zVD/bmS+9o2h/wA2U6yelMqePOL222AUtLHAIQ?=
 =?us-ascii?Q?zrxmxbDft7SV3SZinNN7qNhDOXJicfXxiEZ2lZDECJPybd/TsuybBS/iYNNH?=
 =?us-ascii?Q?AsStoKFIRuy6vetgmYMFkdQ26kZOU3ki+ABKaUyDITvyEVjEcztSZzcCm1TL?=
 =?us-ascii?Q?MBHlxSj1+Tm6OzHnacvfr5tmbMvoW818v1dVopUTXqGC3/gMQG8XvNvtBRsi?=
 =?us-ascii?Q?Uy7zrVx7mXGFk6m5AHL9lPOqYF7XKln/95/aRCBgZtitqvyQK9OfGRpMKCSP?=
 =?us-ascii?Q?sDUUXGUk+b0CYiRXuxez8Ev/nfM3iDbvYOiqm1qG9MWx0EdvC9ckIcwpdNg/?=
 =?us-ascii?Q?GHCgAl7kQHwvMLTrAMua4MiJOy+1j7bFOVHf7oy217qUL+HEtDj0ftFiP6bn?=
 =?us-ascii?Q?wJm44pE16hyysX3m2qnE208+WqdEIdTE0e8RfHmPPvQMwRoGr1c/TVVPrge3?=
 =?us-ascii?Q?Io0PuzZoKFUkLFlqiRhtezmp53q50Pvl8aRuTzCw1aCdJHISIzDnbwIMGYK+?=
 =?us-ascii?Q?FniT6S7pFp+5mvL0iPItgx8nQIFBrE5pevYmaqFiT8b5gjfhFvWP1TkeEHd/?=
 =?us-ascii?Q?DoyeF1/nIt8V/Z0PuO3cf3LOJeShX0MBYyXTteGYyJ1rdacRZQuFbIAuIvrN?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: eKd/nppAg5aj4mzr6Of3F36+sOLZ+jvuoBu7yFArwigLTi5lwGi8DFvuSbK8lUdcQW3Pp43PF4ngfKu8OEhsF9cLq34QvTVkRDNabFwMp0lbX8EIcP0AzDV7yvfAw8Guwhmv4q68qYm7IDDjf4EcHAcgOgIimexIvr1uEmRap5NAJ3u+hfBkLDUWU82vnJWLx3+B5RUb/K67NFe55G6eeOEdD65k3GUsHFuqPwhbHaFWhFRf9anwOuu3LFEhmf0NmN7kFG4W610BNvPJlkgZfDaND/mbuANkvFx07zAilj1E7Vxdn0ytaVNoukws+ZUsJUUkJLTMJs+kZY3ac1WQyQJ72dMWkBm3WouHH6+nhpnh2g0t1pez/1jmTtjo703mKPT+OwLRV/mLM1VnqolVdRywaIqmNON81c0MCgvjdtfO/nV76vbznxBuTczQ/tT0haEkoVyUGJa1zKWsmvDQRAiKSKE4pianD2+EPaorJReSq4lOKRUlK9DSQvicidDsLG/TGQ2e9t24rsFmyIXA4dhG5xS5km2/aehWSAMaiGTLQrx9VwA/pQkFsavaUcnQanduEPhbnfcWA8WSaRK/bHcWflSTxfo7jYzIE24ta+jbbff55SlH9cdZwIM6P7B/fCwqwoSp4D5cOlaEE804ulC3ivv5IoTncOg6RoQsFYhv3DxjM2cfiUFyKy1RqAKarw0cyiJhEHYc866JKa4gzP4spEFdi7Dizm7DgbdqezZ4MHL/Aa0e2Llyy++oXiFTdXO2ewfm+7EKxSd/AExKln4D7Ymb/4V5Oyf8HaNYTicBgvffKgDCDaxHUV6xX1zzDTuuFXFqgAMQs5qG/8IG0Q3S99VnU4Ynom+fRVnS0Ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7dd7a65-140e-432a-2b6e-08daa7fee88d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2022 00:57:29.4880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVObfGve+ufvdAlxlnXx8eknRS8GHz8Pv325dJrzT20UxPYYw4Zwg09XC8t9ZL3jwVZw21LNjkJxq46PYyxI0VndkMAe8IZDXPK5UKjqCTA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5978
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-06_05,2022-10-06_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210070004
X-Proofpoint-ORIG-GUID: 1W54SZmnDF3BcMV11mf0Q19CY1Pb_Sys
X-Proofpoint-GUID: 1W54SZmnDF3BcMV11mf0Q19CY1Pb_Sys
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Paul Moore <paul@paul-moore.com> writes:

> On Thu, Sep 29, 2022 at 4:20 PM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>> Paul Moore <paul@paul-moore.com> writes:
>> > I generally dislike merging likely()/unlikely() additions to code
>> > paths that can have varying levels of performance depending on runtime
>> > configuration.
>>
>> I think that's fair, and in this particular case the benchmark is quite
>> contrived.
>>
>> But, just to elaborate a bit more on why that unlikely() clause made
>> sense to me: it seems to me that audit typically would be triggered for
>> control syscalls and the ratio between control and non-control ones
>> would be fairly lopsided.
>
> I understand, and there is definitely some precedence in the audit
> code for using likely()/unlikely() in a manner similar as you
> described, but I'll refer to my previous comments - it's not something
> I like.  As a general rule, aside from the unlikely() calls in the
> audit wrappers present in include/linux/audit.h I would suggest not
> adding any new likely()/unlikely() calls.
>
>> Let me see if I can rewrite the conditional in a different way to get a
>> similar effect but I suspect that might be even more compiler dependent.
>
> I am okay with ordering conditionals to make the common case the
> short-circuit case.

So I played around with a bunch of different combinations of the
conditionals but nothing really improved the code all that much.

Just sent out v2 dropping the unlikely() clause.


Thanks
Ankur

>
>> Also, let me run the audit-testsuite this time. Is there a good test
>> there that you would recommend that might serve as a more representative
>> workload?
>
> Probably not.  The audit-testsuite is intended to be a quick, easy to
> run regression test that can be used by developers to help reduce
> audit breakage.  It is not representative of any particular workload,
> and is definitely not comprehensive (it is woefully lacking in several
> areas unfortunately).


--
ankur

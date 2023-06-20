Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 808FC73737D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 20:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjFTSG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 14:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjFTSGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 14:06:23 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FB9186
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 11:06:21 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35KGDwcw031272;
        Tue, 20 Jun 2023 18:05:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2023-03-30;
 bh=8lRiAYQgMc09IdUZhitg2Uz5S68NaSYXwhvwrTN/xCc=;
 b=gMT/Rl6WQ6auZsVY5ttn7r8AqO/Z9PTyGpSwNTsjmq1O7cuWf0tWVkBfJYTuKBnKo5aK
 gDF5DUBFuylqE8DVJnhQ4HQKjjd0pYv1Ay7Qbh0kBN5qZIsreaW2zEJ19CW7FAFidL7n
 frclVIQrTSIK8wBUtnuesMVDFHP4XBuU0vHGdOwVp3h1Nu352lQcOa9toqAte60GMvkV
 UPG5NA1k2HNI4MwQ35amySEn+xfJKwCB73bSnVPMcnVTbIrEGfOoZMgzB2FcVRRZDqEn
 xp7tAxVh9n7U3pM9rms2qKDwHyu23lYBue5M05Vd766c+Rrr2veSDfHRCW/MkJovMSo7 /w== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r93e1denj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 18:05:40 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35KHB321029454;
        Tue, 20 Jun 2023 18:05:38 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939ay9gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Jun 2023 18:05:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyQ/OPQZbwJWZshz30Z3kBzuBbOD1G2qcBUqr9AyWvRyhRZo6iQHpbct7BYdXRLv2qrvkwyG548oOXpicnQUgzTAkyr3GMss6TslgzkrCj11bGCUECcJbkQbnBeAwe2DF9Ry9a47rb/IR2Ipm0XQhNOaivj0avp6hASv391+WRbg1MZgKwd8Ndo0DFNYF2ONnsGM2XOJQ/OpuoKVrqrm2ScWexkZwq3VrVoRI7/+9dKom1A0OLvMFJA0JBBKF4ujgaLgFS7n2cHZF7+ceaRfVdgfWMx1P2RpdV6x9LjFh/V6X+i3lMFndHH56YkWEz17UbKWQpKDjofZeK5YQINJww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8lRiAYQgMc09IdUZhitg2Uz5S68NaSYXwhvwrTN/xCc=;
 b=VNYZoisTprvGvaVpdf4cYpdtKRwPs1apUr/8bDHWxUE2L3gwC/NtJaa/cCJdgCxjjV+pgomYSR3F7yxydP1IATy103pvTFi5kMehrZrcAtfyrSfE/FQiBwV7EK37xzRC66aXlZRXnZ0p+HbDnBMzWoi2fwoa4RCmofLfm9ICZvPqBUspP2rRxer7xubPLZvqSAF//qMNs0YIM1FmLmJskjJuXAtos1pTzidq7/ekYhcmPTF+l82v9/8IUJyOl+BUVYEx7kBeFefgmBZlgOa9xLalR9pcsOQXNqv1KlGzOj9l/qmHkxRZ3RYXqz0IetAq5XAMEi7w0hSlerytUV5TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8lRiAYQgMc09IdUZhitg2Uz5S68NaSYXwhvwrTN/xCc=;
 b=VY92WxklXudhNqz60Ws+CFgW5cIZdX6qvSO6AMkeyvuGhqcQnkCFwSOC+Bk6bIO3ggQO7UfTg5zmfDcvq/ika2OCofrdlnNPSZrsNar1woPsqpgZ8XF4l4gsVdpQpbiqe91wjyesknj/SrOeSE4vIBTwXOJIFlLGZztaAVS+ZxM=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BN0PR10MB5173.namprd10.prod.outlook.com (2603:10b6:408:127::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Tue, 20 Jun
 2023 18:05:36 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4a17:13b0:2876:97f2%7]) with mapi id 15.20.6521.020; Tue, 20 Jun 2023
 18:05:36 +0000
Date:   Tue, 20 Jun 2023 11:05:33 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
Cc:     Jiaqi Yan <jiaqiyan@google.com>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>,
        "songmuchun@bytedance.com" <songmuchun@bytedance.com>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linmiaohe@huawei.com" <linmiaohe@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "duenwen@google.com" <duenwen@google.com>,
        "axelrasmussen@google.com" <axelrasmussen@google.com>,
        "jthoughton@google.com" <jthoughton@google.com>
Subject: Re: [PATCH v1 1/3] mm/hwpoison: find subpage in hugetlb HWPOISON list
Message-ID: <20230620180533.GA3567@monkey>
References: <CACw3F50rkrWkdMKo7yq35vDbGrcF4b0zohN3dORxL_h0KxZ7Bg@mail.gmail.com>
 <20230523024305.GA920098@hori.linux.bs1.fc.nec.co.jp>
 <CACw3F53C0f_Ph0etD+BgkAz4P8pX3YArjFgSPaLh_d6rUqMUCw@mail.gmail.com>
 <CACw3F52k=fhYpLpvDoVPcmKnOALLkPsGk08PdS_H0+miSYvhEQ@mail.gmail.com>
 <20230612041901.GA3083591@ik1-406-35019.vs.sakura.ne.jp>
 <CACw3F51o1ZFSYZa+XLnk4Wwjy2w_q=Kn+aOQs0=qpfG-ZYDFKg@mail.gmail.com>
 <20230616233447.GB7371@monkey>
 <CACw3F52iG5bqQbvZ9QkkRkVfy+NbSOu9hnkVOt5khukNNG73OQ@mail.gmail.com>
 <20230617225927.GA3540@monkey>
 <20230619082330.GA1612447@ik1-406-35019.vs.sakura.ne.jp>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619082330.GA1612447@ik1-406-35019.vs.sakura.ne.jp>
X-ClientProxiedBy: MW4PR04CA0316.namprd04.prod.outlook.com
 (2603:10b6:303:82::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|BN0PR10MB5173:EE_
X-MS-Office365-Filtering-Correlation-Id: 030e5442-a88d-4bc9-b297-08db71b8f2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SveTigzPHYqs/rmIQ3tZDOqMdEw8gpPyWkwKVgOhkKdLLGYlFg4p7TUTGE7DqvnUs7kuj7X0naIUcOr0PLei2cK8vvBe0WyGwEaSSm+O2LPkjfvutGytRyUgwbMracrX3PW1EBhZZoBosjfeePtfCWIudPY/qjQxXb4/ZEuxoO4qnLdgEWQIZsfdLSn4o+g4hyBx+usAg93Jit13AVrjxIBgCMv+UJxx6Q2vQxAHYBMXYV8cBPLWx99N/2pRrgLgeWGQEc22j+3HVK5bpOM3boWh72o+5mlZYRAjUN3j5uqZfCOicW8HGSRxpcjR3XRNuImfBMoC9oyIugYaPwHZDB+YH8k61u9gelK5MKdYyysX8GZnGUNExEZmRI2ZjPT2nMTUMoxCkrIGqUYBxGM2Kk4hO4LgHVVKqQBu1WkMOz3am1RaijONGwpnB7cIvIs04cIyZ4CRXWDWoKIMxJHbr9j60zv0i0xhYLjIgInLE7wHol30rLKcXHWVf8jgkDSSBhkOJquKxYdZGE+q7g385Qd8gKtR5+mXaM0AEfen+a4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199021)(316002)(2906002)(8936002)(6916009)(4326008)(41300700001)(5660300002)(8676002)(7416002)(54906003)(44832011)(66476007)(66556008)(66946007)(478600001)(966005)(6666004)(6486002)(9686003)(6512007)(6506007)(186003)(53546011)(26005)(1076003)(83380400001)(33656002)(33716001)(38100700002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OVVPUW92TWpLajlQN3lYaXVmUWtkMjFUOWMvcVZLeWFKYWV5YjhHNHUydVU4?=
 =?utf-8?B?Z2dqZU5mNjRtMEZEWDlRVVdDNmxHcTl6TEFCVEwzNlV3UFNsWDBlYWIxMmwv?=
 =?utf-8?B?dWRrMDlQRDgzMXNQYnIrZUpzQ0ViSVVaenZjVmpCNE1WaG1wVWdQaThXdEdo?=
 =?utf-8?B?bE5WSG54dXNHTWo0Vzk3RDNkWUY3MjZ2ZzJ3WlZqSlZPVmtQTVlOWkJGM1RP?=
 =?utf-8?B?UEcrRnVrZlc0ejRzWkZKamVrK29acWI2WHYwRFlkWTZQK09NRkhSQ3JzM011?=
 =?utf-8?B?aE1WMm82Uzl0enRJVEJUa0lOZ0lJWkhoVlBpV2JTR1VaYkk3S04wN1RlVElI?=
 =?utf-8?B?V2ZkMmdiWWplSVVyTGhCNjhHYTZwVFQySkdzbUpnT1A2N2hYUVF2VkEzRzZK?=
 =?utf-8?B?QzVCYlJxUkIxbnJtbEpPa1p1VHF3T05KN0h3djVjOC96N0FIQ1d2VDkrNk9m?=
 =?utf-8?B?cWpYVXhiZEE4ZzdpMENzaXc3ejhxejRDWXhvYXdGWmdrem9OYlgzcGxLdWJJ?=
 =?utf-8?B?RGdwV3N4VWF6UmV6Nkw3TGlXTzhvcDErb0M4QXhUY045WUNHNitnWGVmUHVC?=
 =?utf-8?B?dVdwRFBxOUwwUUkrNHhac3RTd0FaWlhva05EV3FueTdOWlpqcmlDR2xFNG8w?=
 =?utf-8?B?M2t1RkVxcjN1U2VKamtlWHRVNjl0UkE2ODZONXJwa2g4dStlMWxUc3JXWm1M?=
 =?utf-8?B?UldwSFZtaUw1eEMyVElCRjlaQnZ1NWVVYS9VRVVkVmNoVFF1NmhEWkQ3Ym16?=
 =?utf-8?B?WGNocWtkQzJDajhEam1pZ1p4RE56SWQ0eUs0T05TclZXc29BUGVkbXc2aXAx?=
 =?utf-8?B?K1crRWEwQTFUUWRrTFJ6R1JlRGxKMlhETmFxZnNpTnlmYjlHLzJvTW1Jdmcy?=
 =?utf-8?B?RjIzZVVQV3l3SDJ3LzIvRWtFcEdSb25QbEJYalcxeGxxVVRxb0MxMzlDeXRO?=
 =?utf-8?B?QnFlY1JZSGpyejdSNDNPdjRyU3ViWWxzT09ycC9aeitqZ0dSUkdoK0Ntb2JC?=
 =?utf-8?B?NTc3WUkzM3NEeWZQOGh1RTI1dm1yeThWR2IzK2puTjBKcUVsUlhoT3pMLzN3?=
 =?utf-8?B?OEQ3RjYzaUxTS1NyNElUNms1S2ZDZEVyd3dxVTVxSFZ5QUFFeHJ2KzFFaEpO?=
 =?utf-8?B?OTVJdjdDS1B0M3FPSmVyM0laeGZCSVlUdi9wZHlrN2JiWDB2SXJjQVhlRkdn?=
 =?utf-8?B?M0xoaS9XSW56VE9OdFVLMG1IMTBBamtSU25xUGF6WHViUUZEMDZTNjFjU1Jv?=
 =?utf-8?B?K3p5ZzgvMFVWTHlJS3VpdkIvdzcvdXN6Z1h5SDlXOEVoc2RMMlduUGtVUzZx?=
 =?utf-8?B?NjMzdCtRckt1WjNYa3NTc09RbjhMS0hCWHhJUHBDa2lzcEk5ZlJLTVhyYVBu?=
 =?utf-8?B?WFkwV3ZqczZkZE1QYnF3Nno1UFNRVzIzdjhFaW1JYkpmRE01VXV3eGVMNWVF?=
 =?utf-8?B?Z3pRUEZ6R3d6b1ZGVXljcG1pQk9CVjVXWmI3WlowL3dnVnpXa0xZTFRROW9Q?=
 =?utf-8?B?eUF2azNNWW1GUzVPN09MS1NkZjZQVW5xajlnQkQ1YlVac2psUVkyUE80cUUz?=
 =?utf-8?B?aGNIL3FQbEQ5TVBscFdXK3JPNC9kWWhGZVhpQ1hYc2gyVE1MOE8rNGJUU3hM?=
 =?utf-8?B?dTcwdlBpQTVKVlJwNkpWZnpVMXhpcjRGZS9hS0lTTHpUN2pmMVFLcU1iR1pn?=
 =?utf-8?B?Z00vNDJYeUluNUloTEdQd2JzMkd3ZEl4OS9NYnNuWkxxbTlLamFwMEZiR0VN?=
 =?utf-8?B?ckNOeGRPWGg1UWdsU01ZVTNXSlBVQnpjcWhLVVlGdjJJanVZamhscitHMTVq?=
 =?utf-8?B?bEJDeU5QNGN0Z3dRbDRtWklyWXpuMkFoU1FyL3YrUTdVTGw3S05OcnB6YklW?=
 =?utf-8?B?bHNQYzFNTEFubU9KQzJCNlpKQTJGYUV0LzhKSVhscnpueG1UU28rSElUd0FR?=
 =?utf-8?B?OXczbHI2TkZINmRUZ1phUU1kdDI0cURnQzYrc2pFSVhqQUxzaW1JenhMN3Fi?=
 =?utf-8?B?TVYvcVNMZEdrazRHQTE3Ymg1emIzSks1Vzc2MDI0aHJUemtYZGxXNE1pT2JJ?=
 =?utf-8?B?cXhydFFEdzFMZk92dzQya21uUXZmejlPdzdYNDJYdmZJWXBndGlkY2F3VFdr?=
 =?utf-8?Q?fU+ysIWHZOCDVlnXZbse+u3VF?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?YnNmQUtWNEQzL2JkS09DbWpmRUVOeHJvYWU4T29raGU5OEhWWU5BNVlEQVp5?=
 =?utf-8?B?bE93cjJYWVhMc1ZvMkp1U0pKM0tJRk5Ed05qYkpoeTRUQjFwSi9aRHVnLy90?=
 =?utf-8?B?MkJITytPTVlZbUNKOFZ2ckdsZFgwSGY4WmUxa2lGM2RDZHM5S2NZQXB2eUJ2?=
 =?utf-8?B?U2JTN1FaYzNiSjZyclVFNlBna1U1UnpKczZvRG9YZHo3eXRMYU4rQWRneFhz?=
 =?utf-8?B?Z3pWR1JTMXRYemtjck9kNGg0UzFpRkZJUThEZ2NKUHo4K3BNcno5bEhzSVdW?=
 =?utf-8?B?MW4zREdjUWd1ZlcyVS9jcFZ3eVRDcmlzUHY2ejIxVEYyMHNoTGJWQkkzaHA2?=
 =?utf-8?B?elYvL2thU2orWGxWdFhrdXh0U3dkUVE0Lzl1aS9zNU1FNjFVb3VkbGR0enpt?=
 =?utf-8?B?YW1RM1RPZDNQU3p3RVlrRW16aHJYME5PVmRUNm9MRFRHU0pObFh6M3hqSGdu?=
 =?utf-8?B?MUNpNVpHSy85OHJVYmtEUmMwdlNPZ1d4cTAxREM2djhqMzJNd2dLUzlsVlpN?=
 =?utf-8?B?TUlyMThsckVKekFHUUc2RkJUSGNROFJXTnovNTlpWXczaVhtcmxwOGZGak42?=
 =?utf-8?B?czZDYldpUGpjeDhtMTltU0RsdnBYU21MZkVRVzZhdno2NWtwdFBnS0lHbEN4?=
 =?utf-8?B?WHNFL01yVm50cE1kQzNobnNjQWU5d1dkWXRsV09PdVJXVVdOMXBSTW1GNlg4?=
 =?utf-8?B?VUVXRHlITEovUXJmeDhjRWMzVmRMeGlvRC9IcXIyWW9ZYzZIYXQzeFE4S2Fm?=
 =?utf-8?B?aWRxN2dWQk9GNVJObTdacW8rK0xGbkMvRGlaTnhCeFAyZ0hpcjdqY2hsVGV1?=
 =?utf-8?B?czFzZG5mbk1oM1NRV09QSDB1Yjl3c2RnSldlZHdzTUVzdTFXdEUySXorcE5m?=
 =?utf-8?B?akxCZkxIZlAvTlo4aWMxWDBHSWludFhuNk9aSHgyakdvbkpUYlhmRGh6VGp4?=
 =?utf-8?B?NVJhTUExSk9DdmVyaGtSYkpTOFE0NDBwNnlVd0ZzbnZlak1ienhyQ2hnY2lJ?=
 =?utf-8?B?RTYrQndrYmJBZk5oZ21CMEx2b3pETzBPTTBDNXh0V3pGWjRtRytwdGJmWGV6?=
 =?utf-8?B?RVZJZndFNG1MM28zeENGbTBSVFlycHp6WjBMbnJWN2xuMDFWTVd1akRqa1Bp?=
 =?utf-8?B?V1U4YXFFSWxJc214Z29RU1VmdHUrcUZLT1JOOFNLdjBXRlBDWDRqL2pFdFdV?=
 =?utf-8?B?QlZ5WlJuR3RPVmtiS0Vpc1grZEdpZGFpYmpXRUtXVEZGTENlb2NaRjB2Zmov?=
 =?utf-8?B?MFVTSGhFV00ybnIxazNORmhUWFltTThmZVFJZVZvMXVIVW5JbTRiRENBUUlU?=
 =?utf-8?B?MTJrNktRNTFDcUIyM0dIRTBEMng1bmZaY3o3dXlBc1pFK1Z5KzVuZzlzakdj?=
 =?utf-8?B?ZXdEZzBySjdhM0E9PQ==?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030e5442-a88d-4bc9-b297-08db71b8f2ad
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 18:05:36.4271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZkjAVBO42o2KLmKsjUusXNLUVNLzxShBxirYkBuv9PyROQQyXLGCt/vhwgb7EZ2hzIaEvMyDuCTiiZeNHe5ww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-20_13,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306200163
X-Proofpoint-GUID: fFL59EMKDhU5inmumJOLaZd5qQSD3gMQ
X-Proofpoint-ORIG-GUID: fFL59EMKDhU5inmumJOLaZd5qQSD3gMQ
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/19/23 17:23, Naoya Horiguchi wrote:
> On Sat, Jun 17, 2023 at 03:59:27PM -0700, Mike Kravetz wrote:
> > On 06/16/23 19:18, Jiaqi Yan wrote:
> > > On Fri, Jun 16, 2023 at 4:35 PM Mike Kravetz <mike.kravetz@oracle.com> wrote:
> > > > On 06/16/23 14:19, Jiaqi Yan wrote:
> > > > >
> > > > > Now looking again this, I think concurrent adding and deleting are
> > > > > fine with each other and with themselves, because raw_hwp_list is
> > > > > lock-less llist.
> > > >
> > > > Correct.
> > > >
> > > > > As for synchronizing traversal with adding and deleting, I wonder is
> > > > > it a good idea to make __update_and_free_hugetlb_folio hold
> > > > > hugetlb_lock before it folio_clear_hugetlb_hwpoison(which traverse +
> > > > > delete raw_hwp_list)? In hugetlb, get_huge_page_for_hwpoison already
> > > > > takes hugetlb_lock; it seems to me __update_and_free_hugetlb_folio is
> > > > > missing the lock.
> > > >
> > > > I do not think the lock is needed.  However, while looking more closely
> > > > at this I think I discovered another issue.
> > > > This is VERY subtle.
> > > > Perhaps Naoya can help verify if my reasoning below is correct.
> > > >
> > > > In __update_and_free_hugetlb_folio we are not operating on a hugetlb page.
> > > > Why is this?
> > > > Before calling update_and_free_hugetlb_folio we call remove_hugetlb_folio.
> > > > The purpose of remove_hugetlb_folio is to remove the huge page from the
> > > > list AND compound page destructor indicating this is a hugetlb page is changed.
> > > > This is all done while holding the hugetlb lock.  So, the test for
> > > > folio_test_hugetlb(folio) is false.
> > > >
> > > > We have technically a compound non-hugetlb page with a non-null raw_hwp_list.
> > > >
> > > > Important note: at this time we have not reallocated vmemmap pages if
> > > > hugetlb page was vmemmap optimized.  That is done later in
> > > > __update_and_free_hugetlb_folio.
> > > 
> > > 
> > > >
> > > > The 'good news' is that after this point get_huge_page_for_hwpoison will
> > > > not recognize this as a hugetlb page, so nothing will be added to the
> > > > list.  There is no need to worry about entries being added to the list
> > > > during traversal.
> > > >
> > > > The 'bad news' is that if we get a memory error at this time we will
> > > > treat it as a memory error on a regular compound page.  So,
> > > > TestSetPageHWPoison(p) in memory_failure() may try to write a read only
> > > > struct page. :(
> > > 
> > > At least I think this is an issue.
> > > 
> > > Would it help if dissolve_free_huge_page doesn't unlock hugetlb_lock
> > > until update_and_free_hugetlb_folio is done, or basically until
> > > dissolve_free_huge_page is done?
> > 
> > Unfortunately, update_and_free_hugetlb_folio is designed to be called
> > without locks held.  This is because we can not hold any locks while
> > allocating vmemmap pages.
> > 
> > I'll try to think of some way to restructure the code.  IIUC, this is a
> > potential general issue, not just isolated to memory error handling.
> 
> Considering this issue as one specific to memory error handling, checking
> HPG_vmemmap_optimized in __get_huge_page_for_hwpoison() might be helpful to
> detect the race.  Then, an idea like the below diff (not tested) can make
> try_memory_failure_hugetlb() retry (with retaking hugetlb_lock) to wait
> for complete the allocation of vmemmap pages.
> 
> @@ -1938,8 +1938,11 @@ int __get_huge_page_for_hwpoison(unsigned long pfn, int flags,
>         int ret = 2;    /* fallback to normal page handling */
>         bool count_increased = false;
> 
> -       if (!folio_test_hugetlb(folio))
> +       if (!folio_test_hugetlb(folio)) {
> +               if (folio_test_hugetlb_vmemmap_optimized(folio))
> +                       ret = -EBUSY;

The hugetlb specific page flags (HPG_vmemmap_optimized here) reside in
the folio->private field.

In the case where the folio is a non-hugetlb folio, the folio->private field
could be any arbitrary value.  As such, the test for vmemmap_optimized may
return a false positive.  We could end up retrying for an arbitrarily
long time.

I am looking at how to restructure the code which removes and frees
hugetlb pages so that folio_test_hugetlb() would remain true until
vmemmap pages are allocated.  The easiest way to do this would introduce
another hugetlb lock/unlock cycle in the page freeing path.  This would
undo some of the speedups in the series:
https://lore.kernel.org/all/20210409205254.242291-4-mike.kravetz@oracle.com/T/#m34321fbcbdf8bb35dfe083b05d445e90ecc1efab

-- 
Mike Kravetz

>                 goto out;
> +       }
> 
>         if (flags & MF_COUNT_INCREASED) {
>                 ret = 1;
> 
> 
> Thanks,
> Naoya Horiguchi
> 
> > -- 
> > Mike Kravetz
> > 
> > > 
> > > TestSetPageHWPoison in memory_failure is called after
> > > try_memory_failure_hugetlb, and folio_test_hugetlb is tested within
> > > __get_huge_page_for_hwpoison, which is wrapped by the hugetlb_lock. So
> > > by the time dissolve_free_huge_page returns, subpages already go
> > > through hugetlb_vmemmap_restore and __destroy_compound_gigantic_folio
> > > and become non-compound raw pages (folios). Now
> > > folio_test_hugetlb(p)=false will be correct for memory_failure, and it
> > > can recover p as a dissolved non-hugetlb page.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475DE5F4D4E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJEBRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiJEBRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:17:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 904AB6DFB9
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:17:46 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 294Mm6lX002201;
        Wed, 5 Oct 2022 01:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=corp-2022-7-12;
 bh=1fGw6ZiJdBSoHEs52AmDn8XF8K9WUB38JQ6DHlTAuQw=;
 b=g9yVKxzVDTkjmQdd1qj/WLVUyEGmoLKRh8gLDLp9EHlRHMsetK8YueaewkrbUU15xImk
 3yGu7HQfFv3+bTy8voE/pMp4EcdIrSpxn5wSVNYmttPvFs1sH9Vez+gKu2JZ7ukw0fz/
 4y2L+0CoUCLhGsirMpjB9tSdiU4pc/tscz8Aj+81VghxW6V+Zdaowht/edPQJ2qZiKVI
 qbyz1jSsH4nm6DXekC4JPyvZQBp5I9R6w5BaNJWMiZ+ngwSn7LJHu6XJ/y+ah4HQcDdz
 UG3VexZ04mRYGdvP8eWfG6n8gW78IWzvUOpzUVIgjYghCK3Klhd6iKd5TTJO6lDWAkY9 Xw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jxbyn7sys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:20 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 294Mnv5r019865;
        Wed, 5 Oct 2022 01:17:19 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jxc0b15nw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Oct 2022 01:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tqq0uLXCdYpbb6iE/MrTq5AJTfKCI9vwv+rCXNptUnUMHu14Oj95LGQ5XCeRZUK0WSzJwv5FPtGVCgZd13XnbiR+0P6R6qMly2wWYkH+YW22l+U7d6tAb+euoo9ygHqr79RSu+/DQHJ0Yb3wsoSrNpkMhGTcj0dZ7v9tBctCQTX/xGWqrNcCIrKKw6Tob1wMVSPAtE1Tp3wfzjFPgcPZCkuV+vaBX1KQIKZGXcxYkEhs+Iv4vbdmQDImGsVljItu4++b2mujSvgy4atRm99T435vzcQYp/Q9qzgT9KDxtEp/HZJJszTPE2TJ5yUE77KHE+nck31uHjVy6JXrqzoxlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fGw6ZiJdBSoHEs52AmDn8XF8K9WUB38JQ6DHlTAuQw=;
 b=b7aSOJejtVAwTlGN9r0xS5yLQ4m6xn66eYowpnHz4vqUhXbwNW3jT0mOIJgQDwyFmDYGHosMrYD2REl3AZi8hvLLzxmlsEoOKbib6le72a8TV+J6Ol3BjtdE+a5HAhh3lEhHtVuZIjlp0zIRhrn27F1FyOQRVC7R7xc/f/wFibBKjeFnYVZYATcNAFyEtMoaJSjoCtYDbknxqfEZRfwVaA8eZLV0FIy0/9eCa8cm9Hf1Muk0yHWo8h8V0/rqls6QO9XWJDW8QBF+T4lxXHV8+2s1mvxfWnSUT+UiKFC6w+20NVlgOt86+w7ZjshScXdnJ1evRARrxbwObGPcWvLoSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fGw6ZiJdBSoHEs52AmDn8XF8K9WUB38JQ6DHlTAuQw=;
 b=vRaNhG0Or/Vl1erNjJc8dtxYCI7XT84Qic1VB90GodK0raOXB71dMzYBrYNKGZH0QMYU1jEtMKEksMc4W+6kTmC4o0achMwo+0GtpLPIh2okkHi1rB70o41rEDKd2qSkjvUkWJ/ZrU+5xWFYou47HDcGOMqrs86MVABeJJcPoFY=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SN7PR10MB6286.namprd10.prod.outlook.com (2603:10b6:806:26e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Wed, 5 Oct
 2022 01:17:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::dfde:308:42fe:6c5a%3]) with mapi id 15.20.5676.028; Wed, 5 Oct 2022
 01:17:17 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH 2/3] hugetlb: take hugetlb vma_lock when clearing vma_lock->vma pointer
Date:   Tue,  4 Oct 2022 18:17:06 -0700
Message-Id: <20221005011707.514612-3-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221005011707.514612-1-mike.kravetz@oracle.com>
References: <20221005011707.514612-1-mike.kravetz@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0325.namprd04.prod.outlook.com
 (2603:10b6:303:82::30) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|SN7PR10MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 438385be-dde8-4d48-73a6-08daa66f579b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1iXlqrWgKWUzTh5S0p87CeJO33WWDJ8a5NwdqFsZV8YcjszsGymxCyTrxP2IVnmLMqzwDasyczfDPG2Eq9Jp/XlggWsIATlsvZlpeur9wFqJ9R0wgnNBOAjGJfqOk35yMrADbvk4g3PQBnhU89Ox2hlCquTCctZ7krSs+IYLmFfXbUCT5XEZoEG+KHCCG2t0Dz1eCaz1C82zlRhvo9hShIsae95Ogv1mrp/TicDmhM0M8V4+YZCErEFXLpIefzdgTvdvbFEse5I//FZJSMg1AwY11szJ/ivECnr/3cz7sEHZ1GZvd+13jv8hv/CyzwL3eppTVZLTaDFaBD4XTkNj8VazvioUDgqz6VmThOMIh7elot53PnOXF9srfVCL2zBkHlcp33LiPSW+SNM0Hw6YdmzPx5Al+MFnzZGr0JccmnPvynXaJiqFsl+D1rjGzwAXeUp3aafVMeIgchaqIP/6LCvNVsxTo+9txGLrjOULTdMluDZEvUWSGTp9i4jbgUK0oRd6kWZT0Z97eOHBN7T+h/BdSOrZSpZj79UTI9D10GQkb4csm/wNijbhwQpTsi2ZMDSJZnPsleNKuS1OtklrH8jQlEr3f5zdzXs6ymJgHWeomP15FU1OZW305PX2l67WhlwUUuBiB7IhEzUPRRLmsa7g03eKdAY3PtIhIQSTDvhMqCXE+4RG7pw7X/LitL6fSG/cTBZBO6cnDIy0tstdq9y5g9tVvymAzx0H2NtoUL0wk3eREOTNxlTueqhJ7wUX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199015)(107886003)(6506007)(6666004)(966005)(6486002)(478600001)(66946007)(4326008)(66556008)(66476007)(8676002)(36756003)(316002)(54906003)(38100700002)(186003)(1076003)(2616005)(86362001)(26005)(6512007)(83380400001)(41300700001)(44832011)(5660300002)(2906002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nqsPIsCjJgjB+kmIxvYFoCPidK0C5LDPKcKsWU7Lm+cwENgplDrtqePUrNRc?=
 =?us-ascii?Q?zpxDnWylzbeIA8xVTj5TnCjnRrNqHNYv3lScSbAJOWCRTSztuobbZKsHeqkm?=
 =?us-ascii?Q?7F7u7HJxoLGFSvNsNTaVqJjvZeAVfBVbv9iIp7wYRXd7/GFqBJeQM8KWeNz9?=
 =?us-ascii?Q?UDpdfClUVSMf9u0hVuIQIIe0Qz/SaIWvGGgQLxpirtTPWbX45rLPKnDDOIa+?=
 =?us-ascii?Q?nVlzZqexL73vAHbmnbAbUWIAJdoyrL2d5GCQYyOAgVz5Mhmrzu7VnZQwLdCF?=
 =?us-ascii?Q?7KGggEe37PWe83wdgMnZFK/YObsf5BeFTuD7NjLkqiRR8SfPkXQgaZkO0fGt?=
 =?us-ascii?Q?VExB9w1cHvOTRa20Ar51Dx7e1SaZduq6zqNVAR0JIGvVLRQh8zOJkHvJKYvp?=
 =?us-ascii?Q?UtaFnaIZxgovYmvjVXDknYYLhjEHOKTaQzr9GpQY1QrKdJrSiZEA2jLsYykx?=
 =?us-ascii?Q?+glcbQojDSaFLHgbLWTyr20jCN6Exh5WRbd/dlFiNh+T/hwvHWpcg2PlWIaV?=
 =?us-ascii?Q?DvVFS+es2kT8wygnpPjrg4ftiI0PKLOp2COpofi9hjS5L5hKxJoxyRUqgYSm?=
 =?us-ascii?Q?8P14lE3n11IKnzXaGLu/hPTxPg1YDi09S/WRimjpyfF1Sy7fm9J/WfARJvEn?=
 =?us-ascii?Q?QiUujn7R3XUb8LJ4nXkUM6iRiZK8fJzlxpEVi2RFZDG9AnxZJ1OjNRnW6tfD?=
 =?us-ascii?Q?NB+5o2XWqgKrAT09HAiH+/buvBBeZ2I8BzfErs7qj7Rmsgv0rVOTnY1oJFVo?=
 =?us-ascii?Q?JJ3oKCzwY+g2Ggvq7J7Z6UJZxv+uL/N31gZURQc3rqhrjxk9mORl+i2q0M0/?=
 =?us-ascii?Q?oG9ZAeJRtPvSbSHLVLTseEPD5VDO+rOcXz7vAKI9nElX1sXjLv1h1ptVcikz?=
 =?us-ascii?Q?n+lVVKpsiYESNrGSvcp5kgm0hDXDHNzF3j/bQsGTJMOTjV1CYdad4wosrjfj?=
 =?us-ascii?Q?kksywtzb5klleReLrrUB0AK6mprlXJLGI8OY+XgNTHMdSaeud5ZJeSfW8SqS?=
 =?us-ascii?Q?KUmVuGChrYFz1cXHyMoUKVsISAHtA907DoFVaAOvU/xV+SQihQqAuIkp5rpC?=
 =?us-ascii?Q?T5ezYJqvybSwzYBDqMdEQ/eYnyUt+fkq0j35rcCEoNVF2XKnWIhNy0qLCLzh?=
 =?us-ascii?Q?thH0ddMOQa3bV8gE7nj66+0U8v9FQzvlzP1JxYH7KMDgAsnzxk9k0/WkbE0U?=
 =?us-ascii?Q?UsUJDtyJdYG8w2Szs2uxGquaZnnxkVszmdTn7G7izP3l/ay7V8OXYmgMXLDI?=
 =?us-ascii?Q?3Bpx/RmQM9HT9zEIeMyXKTQfxueyxOdzhDJ7xhmQUS8yp/VT77qc8GIU9vLE?=
 =?us-ascii?Q?BzzdASh67pPtzSSTQRApJAwb1pTc+kPqTXmyv3TL6AlahzKhArKAIzddGGmf?=
 =?us-ascii?Q?4LJY5tM0DJf5+Es9jIJfQ2naA943+Ki294to0T64MGthoXkoTZxonW8AUwTZ?=
 =?us-ascii?Q?slnWsbyN1ZfWlCF/UXn977OLGiKsrh+UIU0BPvRG5gA783K7G3sHj8Y8+2XF?=
 =?us-ascii?Q?D42iuyK2pS8eb2JfHyDukmmpIn7XB/g7GGpNHAWMxLke/0lE47g7Pgeffm6y?=
 =?us-ascii?Q?rGV2j6LZuz6oxuQ3RLURWyAvhcOsJ7527/KrGqVUA0Ypd5eV47qI+eg7GpQr?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ZAY05/vH/t9teCToZqdovoWO9MLoydWwD1b+JIaadveTdj+MPqf6GsjldZp7?=
 =?us-ascii?Q?7B90TL3PfSLPStdzXTXZqX7EdlJxe1c2r0lULo7CZI3EvZIISo5aaonweooe?=
 =?us-ascii?Q?AQ6hY4TX1t9JxSXX13Y2arfgwRLbFQIejgB+NQBNDyFaKYEPs5WET1ZYyvEk?=
 =?us-ascii?Q?QMlCjbifkbTHGU8syK5BHzcaLWVA79Z4+VVpQDOxLpbgna8vruL9rJBdLHaI?=
 =?us-ascii?Q?JZY8VyrvJyzmDuZXedCMU41HnIX/R19FT3759yP9GBXaaST+F6PwlRhrwdIR?=
 =?us-ascii?Q?YXQnHA3eLOhKsDsv2lQ368ktxf1JbUl0Zcsi7hmGMktkV3TVWZCMiDnvPJ2n?=
 =?us-ascii?Q?aF02c3rY6H3SfVIOLX5x3h/cqQ1wY4rqLf9znu6ewc70Wwhn4o5A+BT9pXRm?=
 =?us-ascii?Q?jLxffE9nrOzzJYKGg1ZUx89zLVZlNhNN6sMsSNK1ZTwMtcd+GU26IctVCAIP?=
 =?us-ascii?Q?4pvYRbm3ZwDbSbaOOJ/Q+H74o35ctpYpTl1fo3MvvncuUEVit7YgGUGQleaN?=
 =?us-ascii?Q?Ieuj3pCHfkhAnR5/ubNpv0314hK530542g23KIc1gnR2CZ4vhaGMC1IBRfub?=
 =?us-ascii?Q?UyMuSyVbiaxHN6SAWaILLfuZqgNx3dmz2tBu8BaqixgArExu2hpkhpVTpNEf?=
 =?us-ascii?Q?nJ4kAuhnb8H5ArJP+yeaP48szUbj7SNEpAEZoGuaJ4+w8PUg++QOiS/JLCwp?=
 =?us-ascii?Q?GFljNep1BmkZFPZBgd7l9sd6vwJkLKE6MCmrYsfuZ3dvRQNK5gzns0kKqB1A?=
 =?us-ascii?Q?Q2W6A15ndwJw3ZevwDRvWtR2YMpZzxopwRrOUhLMlFGsJG5U5kIrsNs4oTsP?=
 =?us-ascii?Q?2xEo8CjTT2mUflcsMhYkWfkWp7Si/thGrYEPfB9eg2tlUrag1EaaCwHSNNEI?=
 =?us-ascii?Q?yG+Ser/u1+J9aMdajLk/w+0wf/Pcqa8S9tFut/eROf/Jm2TXZhztMuNsoCJn?=
 =?us-ascii?Q?iRnyD/0jvgrXU1AXc/u1eCzX1YdEzosgcgey3oG96KvhrVjTclinwhdmLmka?=
 =?us-ascii?Q?ii/fLvmHi7RgGBw5G+rydtovd2eaCg9wYZS9ELsGgZQrTO/KUGvR1C3TIGPO?=
 =?us-ascii?Q?7dcoyZr6bl9QqU4CzV9QMBTxlkBW3WZ4ArKm0HVzAIXIZp81q3hdOtuS2K9O?=
 =?us-ascii?Q?T2UNhWNTu6BltV1fkeGAfn4Rh1+OYIAQIuYUt2D1cv4uvRjpoJMYxFPfufoY?=
 =?us-ascii?Q?pwuHxV+N24pI28+vP182GJd083JXhkdqYdjgN7K49Mgle0xy+9pVew7byuJr?=
 =?us-ascii?Q?B5rvRTaO+61NW1mjCBYkf7Jcy6fIKsDcZZL2x71Oy8ANQ4WDcp2bXKVEWHVr?=
 =?us-ascii?Q?zkgYDKVDkkh08zSN1hIMtK97FWuPC3m3tm+WkMDdnes9bNCPYfMbKF8aLWNL?=
 =?us-ascii?Q?90YAzYfOSr5V33xm/bQKK9Tr5q2q9R428qeijeCWubJe0u7gcA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438385be-dde8-4d48-73a6-08daa66f579b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2022 01:17:16.9763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rksK4qBdZTp0exjskv/hQ4Ehlt/YtNC4zyHfh2ZkuCw+VrzI+QvpcVy1U4IcX8IBtFrMQS0U5yYnfVGW2wt97w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6286
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-10-04_09,2022-09-29_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 adultscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210050007
X-Proofpoint-GUID: WDiUNiRVTfU9Tclb9W8i9hxTbbzcY-iS
X-Proofpoint-ORIG-GUID: WDiUNiRVTfU9Tclb9W8i9hxTbbzcY-iS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hugetlb file truncation/hole punch code may need to back out and take
locks in order in the routine hugetlb_unmap_file_folio().  This code
could race with vma freeing as pointed out in [1] and result in
accessing a stale vma pointer.  To address this, take the vma_lock when
clearing the vma_lock->vma pointer.

[1] https://lore.kernel.org/linux-mm/01f10195-7088-4462-6def-909549c75ef4@huawei.com/

Fixes: "hugetlb: use new vma_lock for pmd sharing synchronization"
Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 38 ++++++++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 10 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 0129d371800c..388a32b089bd 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -93,6 +93,7 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
 static int hugetlb_acct_memory(struct hstate *h, long delta);
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma);
 static void hugetlb_vma_lock_alloc(struct vm_area_struct *vma);
+static void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma);
 
 static inline bool subpool_is_free(struct hugepage_subpool *spool)
 {
@@ -5188,8 +5189,7 @@ void __unmap_hugepage_range_final(struct mmu_gather *tlb,
 	 * be asynchrously deleted.  If the page tables are shared, there
 	 * will be issues when accessed by someone else.
 	 */
-	hugetlb_vma_unlock_write(vma);
-	hugetlb_vma_lock_free(vma);
+	__hugetlb_vma_unlock_write_free(vma);
 
 	i_mmap_unlock_write(vma->vm_file->f_mapping);
 }
@@ -6894,6 +6894,30 @@ void hugetlb_vma_lock_release(struct kref *kref)
 	kfree(vma_lock);
 }
 
+void __hugetlb_vma_unlock_write_put(struct hugetlb_vma_lock *vma_lock)
+{
+	struct vm_area_struct *vma = vma_lock->vma;
+
+	/*
+	 * vma_lock structure may or not be released as a result of put,
+	 * it certainly will no longer be attached to vma so clear pointer.
+	 * Semaphore synchronizes access to vma_lock->vma field.
+	 */
+	vma_lock->vma = NULL;
+	vma->vm_private_data = NULL;
+	up_write(&vma_lock->rw_sema);
+	kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
+}
+
+void __hugetlb_vma_unlock_write_free(struct vm_area_struct *vma)
+{
+	if (__vma_shareable_flags_pmd(vma)) {
+		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
+
+		__hugetlb_vma_unlock_write_put(vma_lock);
+	}
+}
+
 static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 {
 	/*
@@ -6905,14 +6929,8 @@ static void hugetlb_vma_lock_free(struct vm_area_struct *vma)
 	if (vma->vm_private_data) {
 		struct hugetlb_vma_lock *vma_lock = vma->vm_private_data;
 
-		/*
-		 * vma_lock structure may or not be released, but it
-		 * certainly will no longer be attached to vma so clear
-		 * pointer.
-		 */
-		vma_lock->vma = NULL;
-		kref_put(&vma_lock->refs, hugetlb_vma_lock_release);
-		vma->vm_private_data = NULL;
+		down_write(&vma_lock->rw_sema);
+		__hugetlb_vma_unlock_write_put(vma_lock);
 	}
 }
 
-- 
2.37.3


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3D0724562
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjFFOMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:12:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbjFFOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:12:12 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FE3D3;
        Tue,  6 Jun 2023 07:12:10 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DE6CJ000764;
        Tue, 6 Jun 2023 14:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1hRihJ9qwBZJn16mBVwFnD6vb2rbCvQwDsLESABGIJs=;
 b=3isHSzPazhLi1SP5EXRJPdGnmahb8UIp1nY9SnV9VaMCcS3Ey73RuAAQ7SiQFQFZ3QQK
 nRSL3RF4sHoHmfCZ/8bH2LM3feig580Je4QJb7gUEYZKXhU0gA2lkzlqhOuADqFKEd+W
 O0ax9yJbNrwuX8ufE+uG0D6FqG1bDRz5hXWitwErJFKlaky1CeC+tMbevS8VzAG7N/SL
 SjOX3/xFAN0FePG3G+8NsT/N+iNqo2jf0Geqnd8B1bkxJmdh2DX6S3SFIr3piHbVJ5C0
 i8jWSiXEnM1WOd6rjaEtUqOg3+e8Mz7NS/YGuVq9DgDU+K7TLz9QDb2mKq/Wvrv0cNo1 fg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qyx1nwefs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 14:11:44 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 356DKt1h024083;
        Tue, 6 Jun 2023 14:11:44 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r0tkh6a57-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Jun 2023 14:11:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efWWG+u4F9ne0ZfPD4b6Z3ThFp7Bl01y+i1+pJToZo7aWbj8qmG24Szqjb0aI775bNl4tuSo0opn4xnGmmXZYmoiqCID1XTbTBUEqKSnBeplqhURVSxjzRzdmp+pEzW9NfxlLxIqxO31mrfxbEi44fysnxEhbryt03wWC52/tMHZX9gnViWiq/5+87JY4j/1l7xg9oIEh1cXpX7METmLxU/nbPStGUfzOHNIbTghMIcnDpFeGQrX/qTAM9OQnVOchc3jwKoz10nJoi9Iga4BbZXunjHi9p/LYVsdpXQW7dCti/XxD7CLCuPTeHxcUrjap2D1uFQdOCfi21PQxfAuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1hRihJ9qwBZJn16mBVwFnD6vb2rbCvQwDsLESABGIJs=;
 b=Ra1tcKa3luup1YdlxHgE41PyZegIC5G9+Yq/f71lONMdm9g8ZjrdeCu6/nZmYb1RCGB8y+gtFat3Ydh/DYvn00Uvfi1kRzczrNz53NASFjV9KVEJb0cl949NUMhxTDpwwags4VrnyHJKlDYPjtjF28vQC51jkhroMvsTc8vDaDEenOQuU7iVtC/J508Xpf6myBZ44OP6qS4xL+mh8Irf0LxkRXxFw9ViZAyDERLNTWCstkzL1lDQMfopbnh2fQyXyFFr2k0sIEw5JHikb0j56SHE5gVre4BhgCQ1T423mtsbYYnGP+arH40btPK7QOtY3TlSDNSOUxE8/sfy6+l+vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1hRihJ9qwBZJn16mBVwFnD6vb2rbCvQwDsLESABGIJs=;
 b=TdAMlhHGAWxRmEgknxDA5ZjC4AlKrRITxQERrsiNO41FaFZX0yJzPcfaRjvWcNIH2Knqtxbkdhiycwcyk/NRcmCo6lMg1xfaweMdjB6M/mhUmyRZx5D1brKd5xpsGD7WhQiCvkPVXD37hG/lA2Egk74gNRZ2QLMNG3o2+jWMz7U=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH0PR10MB4841.namprd10.prod.outlook.com (2603:10b6:610:c3::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Tue, 6 Jun
 2023 14:11:41 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::e38:5b81:b87f:c1eb%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 14:11:41 +0000
Message-ID: <5f38ef6c-8c50-5df9-19dd-c3c9fe590452@oracle.com>
Date:   Tue, 6 Jun 2023 15:11:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/7] perf metric: Event "Compat" value supports
 matching multiple identifiers
To:     Jing Zhang <renyu.zj@linux.alibaba.com>,
        Ian Rogers <irogers@google.com>, Will Deacon <will@kernel.org>,
        Shuai Xue <xueshuai@linux.alibaba.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org,
        Zhuo Song <zhuo.song@linux.alibaba.com>
References: <1685438374-33287-1-git-send-email-renyu.zj@linux.alibaba.com>
 <1685438374-33287-3-git-send-email-renyu.zj@linux.alibaba.com>
 <c1d8ee9b-4839-1011-4dad-c4777d8f8224@oracle.com>
 <452e724b-2a2c-52fd-274b-60db7a7f730e@linux.alibaba.com>
 <c4b2fca8-602d-9c76-90a7-3eafd92da8bc@oracle.com>
 <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <76fcb062-61a8-5f90-b39d-b5fb6da35652@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO0P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH0PR10MB4841:EE_
X-MS-Office365-Filtering-Correlation-Id: f657955e-4c46-43ba-c89c-08db6697f367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oQBE1A7ApZ0dGE+oNLUkdTgn/G6UCyI3khRdqL3pekSoTQaiT7k8ALB7xXtDjnsMu71F7ifGGj1KBhmOA2skzsOwwkFKP8hqqruQO5TXG2DNv4c/WYkEZSQQGDucm6fgWWDd5xMR208Z3SgKoJuCWtBCoYuz623RMTIO8EOyCEIWi2ftwJqp4iOmSAw1Dtm+BThT9WhPobYdbqHn6ZnuO7DBgojZiRRKRY1LEfeV4z9nWiVq4yuEhoiux/cC5ZlOMFSzcKKZ8BaNkskLXlYReAV2OXAW8WdPBMo5hk3DaqK4PTlfHJUNXPAsPf2HmgI3yiNdDmc5JQ/ClZ3Jzt+QZs4dQ7tF2hcDXTT5JMKyjNWkiQDKn38cAzIIkb1gStuzZ8DYuJTaRU41yq9aDliaHRRmbDc5OZRhOjXRuNuAid4qC5jUrHEzYedEx5MLhq5+3wgHSgVnb88GRuOTj37UTO4OUWlMI/aOq/4ai/Yc64YW9eSS0Nq6vgb0EWQCWZAL0uhBX7K7owxwJ5YqedNsaBzU1naIo569fnqrSWlkSJyncTwlLb6a7R9Li+GttIeee/xPzo5Wc5IO0193qFk3jTWywMlXPlRWZBMmpqyynOyzlYV2iLP9l1TmirzUcFwrNEeG7fICp09IpYqjvefmBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(366004)(396003)(39860400002)(136003)(451199021)(36916002)(6486002)(36756003)(66476007)(66556008)(66946007)(54906003)(110136005)(4326008)(2906002)(5660300002)(7416002)(31696002)(86362001)(41300700001)(38100700002)(316002)(8676002)(8936002)(6666004)(478600001)(186003)(2616005)(31686004)(83380400001)(6512007)(53546011)(6506007)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlFlWXI2VkJZc0JNTkdPZ3ZhRjM0NGkyNlUvTTZVYjJtemtJTThMOWcwbExx?=
 =?utf-8?B?ZkxBTXVjaHdRWk9hRjBGTXNOaU45enVOQTQrRmpObk1mQW9TdUFEM1loTndt?=
 =?utf-8?B?R1lieVJML3RjczBXYk1qaUY2dVZOeDZiU1Y2WjBNRFRXbmMwZDBzRnVKNmJ1?=
 =?utf-8?B?MGZ0WXRlZ2J4Smo2cXlwUVRmZThkdUVSVUo3dTBlOEFwNkVQWTFDbjB3NDdI?=
 =?utf-8?B?VEZkTk5obEJ1ZGVRbXF6SGRES25aOWt5ZkVmU0FTeTFsK0tGTEhTRWhMV2t3?=
 =?utf-8?B?MWtBUWZ0aUVtSHpmeDUxblNDUUNPTFJ0ZG9MZEY1MEw0dDN6d1JUVjBwSkRX?=
 =?utf-8?B?NyszVS8ybnVXaUw5MjQ1N3BGcXZkMEo5dU9Mb1VGUmtsTlhVTFZ6MWlJaCtG?=
 =?utf-8?B?NjFTMnZ1L1JxTFJqL0FDWTdwdUdjdUhQcUltdVNTUGxBRk5FZG5qbVdLU2RC?=
 =?utf-8?B?TnFrZmY3ZkwwQ3M4ZG0rb0RFZTVtSmplaEZlclBvNU1NVEZ2NjEzYU9ENFF1?=
 =?utf-8?B?cDZHd3J0UXRTR0xPQkNFeXlVU1ZvR2o3cE90Q0JiOUZJTFZLMnhicHUzaHVH?=
 =?utf-8?B?eHd5bTAzamJCZVFEMW1vRHFtNG54OHJiYlpkRkJiRnkvUldiMGd5R2NiL2Rn?=
 =?utf-8?B?dHBka2pFK1RoVlVwdDZkbHNaWDJQVkowcWdMYmZ0d2p4RWN0a2c3MUxPK0NY?=
 =?utf-8?B?ZUFwRzlJWllZNTN3M0xhaFZ5YnlUR0tFUnl2M0hNYzJIVTVyMkpJRk9yaTh3?=
 =?utf-8?B?NmNLU1lvNDV1RGlDbDQ2MnhXTmIzdzJib3h2eTdtYkVFeHFCclN2aXI3MFBL?=
 =?utf-8?B?RFFvS3gxeHpaeFJBUm5NK0pWM3VmTlBtTVVWeVVqVHJCZXNDTFJBRkk2ZWJO?=
 =?utf-8?B?di9EYTJPVnN6UXQzbTg3TGRZL0d2MkhwR2pZYmhTcTZ2ZTVyUzArcGNFUzJ2?=
 =?utf-8?B?b1pzWk14OW5obG5QOXZEeXdiTmdNM01XODVEYXRJbUpvMUZaVGdpUUc3MXV6?=
 =?utf-8?B?OFYyeGp0SXpVZ1h3TEk0dklpbkRCVDM1QkhoalQ0UnlKeVBLbk1hSU03TVZP?=
 =?utf-8?B?Wm5tU01QTGhFY2NQR1ZYaXhTay9LcVg3YlJVMFBkYlFIVFJMZll4dUlDckhS?=
 =?utf-8?B?c0pnRFcrckN5TkwxYVdwSU5wZHIwQWxaNXlOMHMrcHV3YmxFK3BSRVBxMjg1?=
 =?utf-8?B?c2g0MWVkUUJjWk9BMHBkdUtGWGVPeEdVZit0YXZxTXY4MU5Za2VDOUhtT1cz?=
 =?utf-8?B?enRuamFic2xhM0FiYWZtU3dZdlJxUG1PU09GQ1ZLREhRaWQ1dndEY1FvYzkv?=
 =?utf-8?B?Q0h6M3NTK0lGL0paMWdkdC9GYllVeEZOTHF4c2dXeUxmM2EvdTMycm9XTnhE?=
 =?utf-8?B?K3ZCV0h5TG4wTnNqemJGUmdPVFVtbU9jOGFGcElwdTVHNTZ0UDBBTWRSZGNz?=
 =?utf-8?B?K0VmRXNKN2dNNEVQdjgxVmZ3UnNtZjRPajgyQ0QrU2VvVHBwSENaN3dZVDZq?=
 =?utf-8?B?cHBlbkpxcms4WVgyeVNhcTJBQUh1TzNjZUZ3U3hmTjBTNnp1MHl5TGpyeTly?=
 =?utf-8?B?SUJzOHZkVDdtUkZieEx0eHlOWTNyVnpsbkx5U0hZR2gzdUNHTzNHb1VBZzNn?=
 =?utf-8?B?bnVScW4wSEpwcGhZOWpYODJBNjJtQS9oRTB2c1g5T0NuTGsxcFJsdklvaWlB?=
 =?utf-8?B?cnljYlAzRHgxNXlLbmtTQS9taitaSnVDdkNOeW5wWUhlakNJM2RDaklPQWdo?=
 =?utf-8?B?T1NnNDV6bzMrSlIvMjNldFNTalhLUjNJeEZSdU4xVjZCMWFFSU9TeXJkRVds?=
 =?utf-8?B?M3lVT3R6aXFwUlFYL241U1lLZUdJd1Q5MmRHaXVQei82SExEQzQ3TDBGN2Qr?=
 =?utf-8?B?eWxwRjZQeXkrMnBwVUFLQUNCdWtXT0w4Y1JsZERjbmxLQ25UdEhvVXljTTNp?=
 =?utf-8?B?TlV1cmFBc0ZwUFRzZTY3VmN1YVBmb204aWdMWVpNV2twcVRrUi9sckowTDlG?=
 =?utf-8?B?dkxXbTZFcW9UYy8vcTRNYytaSUVXMnhxMCszaTcvdUsyMzJIb3BydldCaEtt?=
 =?utf-8?B?a3JKaU5lS1RLYzM0VXlYN0xTS2RWR1hSN1NlQVBNYVRrZ1lmaWo1QW5jRThD?=
 =?utf-8?Q?WC4fPDqPLzytk8iJo+cB/ls1y?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?enhuS01EVGhIcDNSUXlET3ZieHBpRTU4bnpWWk52aFNoUVlMYjY1VFVsY0Ro?=
 =?utf-8?B?U0ZkN2hXbW9WenkxM0VBYlByUGRVRmxzV2J0Q0MxNVc1WExsME5hSjVTTHJu?=
 =?utf-8?B?Y25CUUtxSmtJMC9lYTFQclYxQndlWkQvK0RBUzhkT0ptSDV2MGxPalRRbHIz?=
 =?utf-8?B?dFQwOGV3aDlKS2R2Y0NCZnBMYnBCRXJLdnd2bmZXU3dUbElVN0lrOTlqM2RI?=
 =?utf-8?B?bS9iOHRnK2FlSWdDZmNsR0kzZ0d3V3BuUUxaUGhPdmhXMG5zRndIUTh3d0hR?=
 =?utf-8?B?aDN4eGpjRHI1eWcwUFZDQkxZUnJUWVZBN2RTTEtQbyszRER6WnRQcSt3amlF?=
 =?utf-8?B?UW9DVEVaM2lDL28vc3FlZThHWEJpYy9KYlR2OCtkSldHelVFdjJYR09kZThK?=
 =?utf-8?B?SWluQ0t0MGJxNWdhakJPMWtMSFBYaXV4V2tWQ2cvVzRvd3l0ODBMWjF0NGpD?=
 =?utf-8?B?WTNRc2VONmRzV0w4eWc5TmNtWGNmR254UjRTODRoQm14Qi9aQnFhWGZ1eG9t?=
 =?utf-8?B?UXVXbkJxY3RhNThXNnRnc1pVbUJva3ZRL094RDBMR1hIeDBmOG5yeEpaMXQr?=
 =?utf-8?B?aGxTQ1hBZEpIZE1uNGVYV255SmlGTWRrejJxdTBIZmoyWFRZMk1MbUE1L2RJ?=
 =?utf-8?B?alF6WUpCL3BKc25qVXJxYkErbmlPa1NScC82T0V6cmNoYTA5VGVyNkVpcmRl?=
 =?utf-8?B?c0Q4UW5OUUQxVVJ6M3dXL3hGZ093bm1VNG1jNE9XbFpDcVNUNHBkcCtyMnFx?=
 =?utf-8?B?ei9odkRhRmF5QVRqQlR4YW1leDNGa3czYU9DSnRvbXRHRnNaR3lQcnV1WjdP?=
 =?utf-8?B?SEwwbGtSVkFlbFE1SndTMnJxdEpsbndNTTBmWXQxZEh2QmFHZmlKQkVNa1Zs?=
 =?utf-8?B?NHhBcTBkMkRJSFVFVHF2aFRFdEU0bUFOSHR1WlRWYTJ2MVA2cTRXVm9maWdC?=
 =?utf-8?B?QlFCTmxnMGQwNHV0NDQrTk96Ulh1akxVby9XUnAza2x5YVdlWUtBVHhpSENQ?=
 =?utf-8?B?S3VNY2MzUjROWDF0VlVxZDRURWJoTWp0UzdxOUhONDJtTGRlY0lpck9ZNXN1?=
 =?utf-8?B?WnpEeEpkRTJMaW5TUkRtVFZwcHlybDBkRFVkdUo3WFUvYmRxemg3c0VyNUFl?=
 =?utf-8?B?SmRQNFg2SUdNWGxid2hiMnVCeWpOb1oxdnZqSkg3YUdGdGFwRWpZUVJFYktX?=
 =?utf-8?B?eHorYmJDZ1ZQSXlOcm45MzF6WHAzdzRpeWVMQXAxNXUvZ3VacDh2YkgwU0xx?=
 =?utf-8?B?TDdRbEVIY3dtVTFKajRJWWM2YkplMm14ZjVGUFFPMFF5TTNmS3QwalV0UnBE?=
 =?utf-8?B?YXJ3em02WFhCZnUzK0FFZHVmNm91cHhkeCtTODMvc1E2NjV2VjA5V3NpQkpj?=
 =?utf-8?B?T2FCeE1CaUJ6eEJsQmJldmVPSno5WmJMdzh4b1JxdW9EQzkwelBHMndseXJH?=
 =?utf-8?B?cTQ1aEFEcGM3anZCUkw1U2xPVDVvS3Q3OUpKZUNsYzZZZklEUEtpMXlyQVpo?=
 =?utf-8?Q?lgta6M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f657955e-4c46-43ba-c89c-08db6697f367
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 14:11:41.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rJ1OxJO/mP1EI8bKFWSI4SKuORUP84/Rpo+XoPZLKUEJHKmJgPEC1uxPd9tk96C1duflvMyvr7Ec52F6N7qsBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4841
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_10,2023-06-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2306060120
X-Proofpoint-GUID: 79OY7euoljuXnFNoqd6Qfnu6sINB9vi5
X-Proofpoint-ORIG-GUID: 79OY7euoljuXnFNoqd6Qfnu6sINB9vi5
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 03:46, Jing Zhang wrote:
>> I assume that there is some ordering requirement for cmn_revision, considering that we have equality operations on the revision in the driver.
>>
> Actually revision is a register value rather than an enumeration value.

ok, got it.

> If I modify the revision to r0p0, etc., it is also possible, but I need
> to convert the enumeration to a string.

understood

> 
> 
>>> The identifier consists of model_name and revision.
>>> The compatible value "arm_cmn600;arm_cmn650" can match the identifier "arm_cmn600_0" or "arm_cmn650_0". Maybe the message log
>>> is not clear enough.
>>>
>>> For example in patch #3 the metric "slc_miss_rate" is a generic metric for cmn-any. So we can define:
>>>
>>> +    {
>>> +        "MetricName": "slc_miss_rate",
>>> +        "BriefDescription": "The system level cache miss rate include.",
>>> +        "MetricGroup": "arm_cmn",
>>> +        "MetricExpr": "hnf_cache_miss / hnf_slc_sf_cache_access",
>>> +        "ScaleUnit": "100%",
>>> +        "Unit": "arm_cmn",
>>> +        "Compat": "arm_cmn600;arm_cmn650;arm_cmn700;arm_ci700"
>>> +    },
>>>
>>>
>>> It can match identifiers "arm_cmn600_{0,1,2..X}" or "arm_cmn650_{0,1,2..X}" or "arm_cmn700_{0,1,2..X}" or "arm_ci700_{ 0,1,2..X}".
>>> In other words, it can match all identifiers prefixed with “arm_cmn600” or “arm_cmn650” or “arm_cmn700” or “arm_ci700”.
>>>
>>> If a new model arm_cmn driver with identifier "arm_cmn750_0", it will not be matched, but if a new revision arm_cmn driver with identifier
>>> "arm_cmn700_4", it can be matched.
>> OK, I see what you mean. My confusion came about though your commit message on this same patch, which did not mention cmn650. I assumed that the example event which you were describing was supported for arm_cmn650 and you intentionally omitted it.
>>
> Yes, I didn't write cmn650 in the commit message, just because I omitted it. I will add it in a later version.
> 
>>>
>>>>> Tokens in Unit field are delimited by ';'.
>>>> Thanks for taking a stab at solving this problem.
>>>>
>>>> I have to admit that I am not the biggest fan of having multiple values to match in the "Compat" value possibly for every event. It doesn't really scale.
>>>>
>>>> I would hope that there are at least some events which we are guaranteed to always be present. From what Robin said on the v2 series, for the implementations which we care about, events are generally added per subsequent version. So we should have some base set of fixed events.
>>>>
>>>> If we are confident that we have a fixed set of base set of events, can we ensure that those events would not require this compat string which needs each version explicitly stated?
>>>>
>>> If we are sure that some events will always exist in subsequent versions, we can set the Compat field to "arm_cmn;arm_ci". After that,
>>> whether it is a different model or a different revision of the cmn PMU, it will be compatible. That is, it matches all whose identifier
>>> is prefixed with “arm_cmn” or “arm_ci”.
>> Sure, we could do something like that. Or if we are super-confident that every model and rev will support some event, then we can change perf tool to just not check Compat for that event.
>>
> Yes, I have also thought about this solution. If it is an event supported by all versions, as long as it meets the Unit match, it does not need
> to check Compat.


>However, the current perf tools tool seems to ignore the "Unit" inspection for the metric event.

Unit is the format of the event_source device name. We should match 
based on that as well as compat. I need to check the code again to 
understand how that is done... it has changed a good bit in 3 years.

> 
>>> Maybe it's not a perfect solution yet, looking forward to your suggestions.
>> Well first we need to define kernel HW identifier format. I don't know why we don't encode model and revision name, like "cmn650_r1p1". Robin?
>>
> As mentioned earlier, revision is a register value rather than an enumeration value. If change revision to revision name, I need a more redundant
> operation of converting enumeration value to string. If you think changing the naming method to "cmn650_r1p1" is clearer, of course
> there is no problem.

It's just odd to mix a string and revision number in this way.

Robin knows more about this HW than me, so I'll let him decide on the 
the preferred format.

Thanks,
John


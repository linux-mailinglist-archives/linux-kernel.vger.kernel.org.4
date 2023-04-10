Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E001C6DCCD1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjDJV0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJV0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:26:47 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD96E73
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 14:26:45 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJZlcr000333;
        Mon, 10 Apr 2023 21:26:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type :
 content-transfer-encoding : in-reply-to : mime-version; s=corp-2022-7-12;
 bh=bMEnKuyOBSE7qGIEQH0/VzFl28fYqYWLGIleFb0IlDM=;
 b=tF5v3FcIOlSQcigPw8Jct6XTq5C9ehUVgrt7o+S2UKkfk03eKvhef7Ez7OSbJU1pf6V0
 RE6ztjWi31r4wwsnMMUxo+62Dtz9BvfXWk7PgXSd0GfzKvx28M0LXiRQdrkFwxZa3xLj
 lqxEXOnNpL/xE03E4GU2Fk8FtcN6+iJ9KBxKj0bEGCj3QH9XQI/fKBo6CII9MS9FsLJG
 C2uyhbHuFavNSQYxBPYXOfq1//JvrHPwe9fzWs2wVzp7rh8m6nodNRHJFIsktdlMmzAd
 u45z7h6JU5sIGHOH0q6ZVUSj7ng5ppZww3Syq3Tlwq6a/MExY/NFVhuiCbIR8620TMqw 8g== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0eq3vbj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:26:18 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJcjSV032672;
        Mon, 10 Apr 2023 21:26:17 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw8yvep2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 21:26:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC5r0+nX4CrHI5nB6pcvtJG2aaFTTOMp5xPfkYb0AS6mRBe+GUt2RKWolB43qJtENJWMIr3ordNvJGewBB6Jp7bAnPKN3dXuRm+9ZyMB+5dfSuV9kzKFgjLC/xDWGxBPw0bhVQYMLILkEXGFhRNObLrQLn6R1Jrwkq6+ONnNfTpHLzCCnw2NDVmgYPTIFfy20aLATKSNSL9HMC5c6b8XFLw3oXwQYfqM+31VQpPAdKp6htHBjjfe3kVdOZSqESRnq4iay9hXYz68IkHfYWKdRcag89v+biaAKcPJbXCF9G61lVhsxzm2BIydcKwUBvOrH3TFOQpydgwhvhY0ht/fZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMEnKuyOBSE7qGIEQH0/VzFl28fYqYWLGIleFb0IlDM=;
 b=m3oMjrcn+sbAsd8NXjyHJCZMQngYh5kjIGKmTwDZ01aOs3Dppk+4ZMGi25x43wcEkc7XSIDhLLkdgGv8LFhZon2q03PS80o5uZ8rA9oc+Rn+qSgMSpmjS6TAMPKSdPez7zilB1hwJSj1+5kxGqivg/g1/uKhbKIj171aRifOEx7/INagjIvZ7gEp6zCqNojHoam/jLAEOS2FWAqQO0I0wLRAa1VPfqWY46abAPtVwaQkT6qWi4I14cMmwMCgVS5UAYWHFEo1DBZ5mfPa0vlapGm6nUmumTRo44XBIXmLYGuIxbEskcW0qHwlVbzsqdvjbLh7yJ6R8ut3cq4hVJ7aEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMEnKuyOBSE7qGIEQH0/VzFl28fYqYWLGIleFb0IlDM=;
 b=plXnfulBRlFiv3jRAOx7p0CZ27U3zy8fhK5YK2OWammkmE7pf5Zhx9023G+nW1LccIrMLdqAuJ5fJsKbEafilBnrMG2K2rV8Nt7hbVA/FKHEph/IEiIXxEi49MQImoGKDerSLx9qZcOCILjUJdfS7B0EW4E7D8IyUjO20ygER+4=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by PH0PR10MB4741.namprd10.prod.outlook.com (2603:10b6:510:3d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.35; Mon, 10 Apr
 2023 21:26:15 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::ffb:de39:b76b:52eb%3]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 21:26:15 +0000
Date:   Mon, 10 Apr 2023 14:26:12 -0700
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     "zhangpeng (AS)" <zhangpeng362@huawei.com>
Cc:     Vishal Moola <vishal.moola@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        willy@infradead.org, sidhartha.kumar@oracle.com,
        muchun.song@linux.dev, wangkefeng.wang@huawei.com,
        sunnanyong@huawei.com
Subject: Re: [PATCH v5 3/6] userfaultfd: convert copy_huge_page_from_user()
 to copy_folio_from_user()
Message-ID: <20230410212612.GA8315@monkey>
References: <20230331093937.945725-1-zhangpeng362@huawei.com>
 <20230331093937.945725-4-zhangpeng362@huawei.com>
 <CAOzc2pzr7VJRdsx1ud_ceBhbu2XP7Ay72jFETtN8eOt5yR7S=Q@mail.gmail.com>
 <a874c84b-4a83-c12f-e064-eab6a792c1e6@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a874c84b-4a83-c12f-e064-eab6a792c1e6@huawei.com>
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4196:EE_|PH0PR10MB4741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fb8251f-a894-40c6-c79c-08db3a0a36f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R0tdZ3iEwO6dY0mjFRacqpnQiE5SDU4ZelHaAMg6bs8hkutyRjHgcK6Fnr7jI04CJBHvzCepVg6R1oMDF2loBXb95pgjVj+x/yPnSs6Ul0VTzv0uK/tLGarowF/JVpWbz3O/8vMTWzL+y+TsnE1sj09cgE0/n9FN34BFQEvHjdjvSw50KCxS/bY6m0BhJw8ohtgIB/6gYobwYolbIxoIA/Q1jmhk8/4qK+fYyCUdmZuo1ICA3aAOEeEvpR9+blFyg/IPZAkEqVf28kE2gtTHd1KWSqU1HexuPa5wdf0Fv8zB0XYdifSAiOG/ARhUvXfRNQhN3oCnpMgGh975WijN4Lw/hKQs8yoiQyrBcS2Wyn90oLJ6m8dDiEtpjDlAM4wmYHiF+SyuvBa7QL0ac8R0XlbiwSPyAPifRhb2Pba4HGrIoutct2G6Y5HOLi8naIRsb5fYguhWu3vAkiLDo9VPrZLNNcXlb1giV21TDuTvIQqMfHTh4hZOBJyuzPUNgb24f7hEWpn5N8O+3K1EWdnlhiEZ9734BUbjttQwtgKhp9wFo8MdLtEXuDYFwYYG81FU8/VJlg9lkLvUAa9YN0VSXyUbl7n41Bn4fwzl5+E02Uk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(396003)(346002)(366004)(376002)(39860400002)(451199021)(6486002)(8936002)(478600001)(41300700001)(33656002)(66476007)(8676002)(66946007)(6916009)(86362001)(66556008)(316002)(38100700002)(33716001)(44832011)(2906002)(1076003)(6512007)(26005)(9686003)(6506007)(53546011)(6666004)(186003)(4326008)(5660300002)(14583001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWxHYnFPL0RCaHEwU1RBZEdtc2RLNWhFWldlcUNOaUQydGtpQXFHcjdCd2ps?=
 =?utf-8?B?ajVBL0JIbVR5OEVRTlVPa0JuTUdiaFBTcGZIa3owZEJHQlQ1QWtteURqMmZB?=
 =?utf-8?B?eEVQTklOZFhCaDI1amFKM3ZRUHZMUGZlaW9ZK2RuK2VWQmFVZWV1OStiZEY5?=
 =?utf-8?B?MjNWTGNmNE9YK2tZU3RsMHNJeVZnWTRicU5vM1lZWnFVNWd2aUtzbTFmUHpO?=
 =?utf-8?B?N2FPWGNhTFpFc1Q2SGNnKzRtMDBrT2xWcVVkRWp2N2pEMXYzeUM1RmVMQ0ps?=
 =?utf-8?B?RHBXaE40SCtCRVJhTUtyT3NvWHlNSmZ4aWd1d0tWalhZbDZnazFJSnp6VEQ3?=
 =?utf-8?B?MGlKMnlZSndNT1RVcG4vOVJYZHl3QWlqNXd1SXJPK1VaYllkaWtMajFYY3ln?=
 =?utf-8?B?ZitudXN4ZFBRUEswNU5oZ2NRR0VvMTZGMG15Q0haT292Zi9nQVJHZkpqaU9R?=
 =?utf-8?B?Ly8vY2ZBR3pnZVdZVldDSUI2TDh2aVFGd0srbzZWTzlONFQzOFJ3bTZLRWdG?=
 =?utf-8?B?U0ZqOFNnZitFR2w3MEhud1V4UndoLzBuVEllazFrc0wxUWdidHZ3UGw0Z0Ja?=
 =?utf-8?B?dWJieG5mek5lRzV3WjNnSUJKTWU3MVFLaTd6TFRHQyt4WitDQXZFWHZPSnVp?=
 =?utf-8?B?U2VmTTZFaWVhUlozNXViVnI2cjdTK3BPNlZ1cDQ5N240UjJTdVRRYWhQUmJ4?=
 =?utf-8?B?NFFDNU1QVVk1V29UYUxLSDNtN2pLQUJiWEV6ekgxTVJjUmxYYnZSQ1c4RmNN?=
 =?utf-8?B?cnFsdmEyakxMUngwaHVFa3JvQ05EN1BHREx2d1NjY3R6ZUxUR3I1WjFFQy9B?=
 =?utf-8?B?dEVZdXdYU0N1bFNmZko1ZzhqTzJYWUMyTldtcmRMTHFLK1V1U2NBZHdhREdS?=
 =?utf-8?B?V3dRUm1DTkVYdHhVQVdhMnZUUFo0dXZDSDMzY3ZYMXpGZWozeit4QlRnVGtM?=
 =?utf-8?B?NzBtd0VSMU96Z2dKa0VGRE1rMGZRVDNLR3dIVkZONDM4eXZKL3l1WGRWRHRr?=
 =?utf-8?B?VXBGMkdORE5IaFg4bzFseHNhTkVLS0l0bVR4RWdYSkJIcHdDU3U1TjZiNmtl?=
 =?utf-8?B?dFhWZmFZaTlNL242VjN4dFUwQXByVXVMQ0tXdkhxd3F3V2dSVW1JdWY5SjZl?=
 =?utf-8?B?ZjZ4YmJKNG5nc1lBRFErcytPdUdjVkRSMHlYdzFjYzhtMEwxUUFvQlozdzlk?=
 =?utf-8?B?dmVybFJ4U2Y3QXZwSm8xZXE0N2htWmFKckN1ZGNpTFhUVjY0Q29YcmxsVnVn?=
 =?utf-8?B?bjlTTm5CNTdBZWFWMG9PajJ0QzBMNnNCR3BQdGd1TEJmTlZoM0Z1YTU2OUhz?=
 =?utf-8?B?QkRZSjNDUzdDaXBacnZhNFM3VzgvSWNIWWNIRkJUTXM0elYxbERIMjU0V0dy?=
 =?utf-8?B?S1lzOEZvTkgrMUQwS3JReEk1WHdGWk9jRWw3eGJZNjV5OHZNNEdXSUFWaitl?=
 =?utf-8?B?RmlFV0RaYktsdUFLL1Jyd2IwOUlEc29IV3lYQlBkUmxnb2FWaUpkN0E4WGtV?=
 =?utf-8?B?d0l6N01YTlJ2N2VGditkR2FnQ2VWZHIvMVJzRUFtejhld2VON2ZaU0FsTURr?=
 =?utf-8?B?TE8ybFQyNXZUOEs5TkRRV1FJaWNFMmNzcGt0MlhDd01taWJqNTQyR21vb3ht?=
 =?utf-8?B?S1UrMDJBa2N4bGRlMGVId1V6TEk5R3BFOEhQS3hyUWFCMEtpS0pZMXhzcDhT?=
 =?utf-8?B?YkY4WVhWdEJSMjNNcEhYcnZVeE10Q0JPczhTUTVrWk9VbFl2R2tCajdqank0?=
 =?utf-8?B?dzdJNDljS3ZDd2hSWEFROEJEUjBEQkt4aWNJcjV3ZzJacitkbXBsQzl6SzBE?=
 =?utf-8?B?OG5keUJEVUI5MExWU2dvekJDQk0zNEprRmVPSGl6TEVoUmlHYUJudi9MOEox?=
 =?utf-8?B?OWRDUitCdkhoZ0g0alRrVStnMXQwOW1EUHFKWmlhbE5nZ2JqSHUwR3Y4djBh?=
 =?utf-8?B?YzNYQkpJb2N0YjJ0dUhXMk5lY1k1QlVER2FaZmEyRnczRFdCenlBTHdOSk45?=
 =?utf-8?B?ZmRCV0R0WkRqZGJ6U0FsUUE3dG14R1B5M1F5ZW85aFdYZk1LTDkzdHRneEtE?=
 =?utf-8?B?S29mSGpyaTk3TlVQeXF0UzVKSHhYQXhDSENjWnk1SGJjRXBnUXY3MUUrSS9n?=
 =?utf-8?Q?xbl8OrBrAFSCAhy+fDZHg2uF9?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?RWtncXg4RkRBWDM3YzREcEJuRmJMcWtwL3I1dTFSTDNBRFFPN3ZlaXhyZjNh?=
 =?utf-8?B?NXE1RWZXTGp4MXI3ZmVEM1Q2TFE2Qi9taWNFRkZ6SlQ5WmhjdEdJbndmdjBU?=
 =?utf-8?B?d1ZpMjFJd1BsUW9UN0lWYVZOTHNVUS9yMmRKVGpPSmo1YUJvUXRHb000Q1hD?=
 =?utf-8?B?eUVCQUFVOG5BR0ZUT3g1RUxScXRYYU1HbnlHQlZRSlY4UnU2S2hJRERrbmwy?=
 =?utf-8?B?OGVRUTF1cHVLV0k5RXVYWkE3WFByNXJCalBHemVjTE14Zy9WRUhtYUpBZGNz?=
 =?utf-8?B?U3FobG9YbkUvMmIrbzh0WTlqM25hOVlNaUROZG9vSSt4aTRkWjJibTJHelAv?=
 =?utf-8?B?VzFmNEgzMXFPRmtPTTZ1Y2RXcS9EUU5OcC91Ky90bkdZMUd4U3dLNUxYc3Jp?=
 =?utf-8?B?TWh4cW5zMCszMkdWY2owKzRqQWc4bkplbDd6VzRuZmJ1a3ZEQjFsVnlMVHRE?=
 =?utf-8?B?eWpHQzJrQjlrVmQrY1RGOGtPbk1kTlJ4S2tBYjVta1owcVpxNGR3MnVQSlMr?=
 =?utf-8?B?NFRCVEdPVnpiWk52ZzREbDYwb2tFbk1FZi9WV0RHVjhaVDBtWFNvQ2s3ZXlO?=
 =?utf-8?B?TXF3OG5jRDEwbjdlNGc0dENYYmhKMmNDcEJvc3h3cEY5Q3B5aXdYWk9VTE5k?=
 =?utf-8?B?Sm5jMDdNcG03d0p5SUlUV05iRFhMcUs4KzVFTlhxRjZYMGFVSW5QWDRBKzUy?=
 =?utf-8?B?cWMxTXZuUUJEa3cxb21mNGVkTWpSR2RNU3ozRTVaSlFZYkZhZy85MGRRUThE?=
 =?utf-8?B?SXo4OFhKYVVOOUJBWHFLcWlVQlB5N3JYY0xMVEtDSlhKa1QraW1XZzJGc2dx?=
 =?utf-8?B?d1Z0dmVNOFptVDFYcUtGNmZTSUZ2aXhSbHNQTDRlOXdtSkV6SjFYQTU2eXBv?=
 =?utf-8?B?RW1FRWxrM2duZzhEblh0TUFUazB5NEhIK1diVm9aMkI2ZUx4VGdMSm9HQ0Qy?=
 =?utf-8?B?NFZGTS9iazI3KzhmVGVTMjUzZ2xKZDhubDlFOGhZaDB6TU5uRmdJc0pub3NJ?=
 =?utf-8?B?VEpCK2VnVCtOd1BhQnV0Sk5DRmJHS1Z6RU5CN3J2OTVzcXRUc0lIcFlKRXIv?=
 =?utf-8?B?RTM3L1FDUEFFOWtSOEpYbXZlN1MwaDAwVFFBRTNFeDNXK0tOODRqbDk1WHpH?=
 =?utf-8?B?OHVweW9zc3NoVnpmQ0JBMS83SGozSjQ3Q2xqeWcwSGZueGdSUGRLL2gzM0Z3?=
 =?utf-8?B?aW1raVNhbnlEQlp6UTkrZEJpZ25BbDY1ZzY4UlJoODREY1gyNldoS3BqUGVI?=
 =?utf-8?B?WWhUSWZIYTNoVDB0NTdRQksvWk8rKzZ3NmhEN1hOV3pFbkFZUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb8251f-a894-40c6-c79c-08db3a0a36f3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 21:26:15.1079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq6Tuo69ASPO5bUq9CmT14Y6NRM6Vyk4EOayftHS+6ifP8QD+70uNg+NAzxXLAX/8xNEF/J2ZoLsAXpSoXP1jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_15,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100186
X-Proofpoint-GUID: ZN4k3_vcdSt58KhXk3n5CZZQSKPZV26W
X-Proofpoint-ORIG-GUID: ZN4k3_vcdSt58KhXk3n5CZZQSKPZV26W
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/23 12:43, zhangpeng (AS) wrote:
> On 2023/4/7 10:28, Vishal Moola wrote:
> 
> > On Fri, Mar 31, 2023 at 2:41 AM Peng Zhang <zhangpeng362@huawei.com> wrote:
> > > From: ZhangPeng <zhangpeng362@huawei.com>
> > > 
> > > Replace copy_huge_page_from_user() with copy_folio_from_user().
> > > copy_folio_from_user() does the same as copy_huge_page_from_user(), but
> > > takes in a folio instead of a page. Convert page_kaddr to kaddr in
> > > copy_folio_from_user() to do indenting cleanup.
> > > 
> > > Signed-off-by: ZhangPeng <zhangpeng362@huawei.com>
> > > Reviewed-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> > > ---
> > > -                               bool allow_pagefault)
> > > +long copy_folio_from_user(struct folio *dst_folio,
> > > +                          const void __user *usr_src,
> > > +                          bool allow_pagefault)
> > >   {
> > > -       void *page_kaddr;
> > > +       void *kaddr;
> > >          unsigned long i, rc = 0;
> > > -       unsigned long ret_val = pages_per_huge_page * PAGE_SIZE;
> > > +       unsigned int nr_pages = folio_nr_pages(dst_folio);
> > > +       unsigned long ret_val = nr_pages * PAGE_SIZE;
> > >          struct page *subpage;
> > > 
> > > -       for (i = 0; i < pages_per_huge_page; i++) {
> > > -               subpage = nth_page(dst_page, i);
> > > -               page_kaddr = kmap_local_page(subpage);
> > > +       for (i = 0; i < nr_pages; i++) {
> > > +               subpage = folio_page(dst_folio, i);
> > > +               kaddr = kmap_local_page(subpage);
> > >                  if (!allow_pagefault)
> > >                          pagefault_disable();
> > > -               rc = copy_from_user(page_kaddr,
> > > -                               usr_src + i * PAGE_SIZE, PAGE_SIZE);
> > > +               rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
> > >                  if (!allow_pagefault)
> > >                          pagefault_enable();
> > > -               kunmap_local(page_kaddr);
> > > +               kunmap_local(kaddr);
> > > 
> > >                  ret_val -= (PAGE_SIZE - rc);
> > >                  if (rc)
> > >                          break;
> > > 
> > > -               flush_dcache_page(subpage);
> > > -
> > >                  cond_resched();
> > >          }
> > > +       flush_dcache_folio(dst_folio);
> > >          return ret_val;
> > >   }
> > Moving the flush_dcache_page() outside the loop to be
> > flush_dcache_folio() changes the behavior of the function.
> > 
> > Initially, if it fails to copy the entire page, the function breaks out
> > of the loop and returns the number of unwritten bytes without
> > flushing the page from the cache. Now if it fails, it will still flush
> > out the page it failed on, as well as any later pages it may not
> > have gotten to yet.
> 
> Agreed. If it fails, could we just not flush the folio?

I believe that should be OK.  If returning an error, nobody should be
depending on any part of the page being present or not in the cache.
-- 
Mike Kravetz

> Like this:
> long copy_folio_from_user(...)
> {
> 	...
> 	for (i = 0; i < nr_pages; i++) {
> 		...
> 		rc = copy_from_user(kaddr, usr_src + i * PAGE_SIZE, PAGE_SIZE);
> 		...
> 		ret_val -= (PAGE_SIZE - rc);
> 		if (rc)
> -                       break;
> +                       return ret_val;
> 		cond_resched();
> 	}
> 	flush_dcache_folio(dst_folio);
> 	return ret_val;
> }
> 
> Thanks for your review.
> 
> Best Regards,
> Peng
> 

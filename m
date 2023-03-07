Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B326AD50C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 03:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjCGCzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 21:55:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCGCzH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 21:55:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C339580CC;
        Mon,  6 Mar 2023 18:55:05 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 326Nx0j9003594;
        Tue, 7 Mar 2023 02:54:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=zT9e19Ik34sEMK8r4eiPZy8kfACWrZmmhzruCSZHVEc=;
 b=ICoWWpq8JBNAKbAj87RfXNHiVV0Nl9C/Pf6MZOTsejLiJBQw1T0sge3fExlsD9YSm+6x
 Po0OskoLhuOYCGqV6zyuOnJEKa3g6lwTkvMr/1MbZmdp4WWj/AxRCoj9G0d9pWBt7qZh
 bw4wjmdXZ2lGJqORv4+RB2REhVNQHBHvr0Ir2ykqVP4F9v3HdQfA0oaKg5ACxcjXUDuK
 L8nwY2ZjQ8IO/XtXH0p8TcYiwQxo2Nl7/4trvMvTpq1XooPpZ2lHVXO9t0CmKDwW5+T2
 FlQZDDHA39rsn/d8s8PH2/4WbVdiciiuiEM6bUNibpiw9boBf2B9QpRBX5FIaAArF1fP wg== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3p417ccg46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:54:53 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 32723vhk009186;
        Tue, 7 Mar 2023 02:54:52 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3p4u2h5391-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Mar 2023 02:54:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HW8khZQqFca6yBjvnTDBaA5eO7pXll4HJHUwFmMdZYIapbRUDJGbLqLGS/LGUVSEesFw6dC7YbFZM0WN+tItANeXwXLChC/6xi3YkKDTNqQDD+0P+zrmzOr5cv4tF/qB/TQcCrHyVBdHtwRs4YltxMA8UsF3bvcmsRn4zzstA09wCHYQp5RhV0LpDQOP3kTVeh6CvJPtLclq5jLm2dA+K0ivuvktkfoZM2sPjLsiO1PLfYPczKWQa3UEb6/IPxoswGLXDPMsu64JGvCmswZqW45YUpKQjT6xqqcUVgwX1KUcUaaTBX/TiohaF2V7E0aN7IpfAMpg/LMlZZPDlHH3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zT9e19Ik34sEMK8r4eiPZy8kfACWrZmmhzruCSZHVEc=;
 b=bhcR1Q5wKHyzUMLQiqdEG0FRhV2ffBV+4evssIL14syDYQ6CWLwHjjhS7z5cgsES68GEvlAmXbxSSwBbX9moRJn+WiqLuOOMA8qpJuE8DvljJBiqx90cACFYhop3P2D7gXgS0UckD+WrkUwByCJIiGw5yyTPcXSH1nMFlM+bWWhn9Tf1wnIWvJ5CqpnC3v4CiipcCmn4ue4XbVDkkWYTvhCXLQC9GLAYGdnXXsDisiSpvUGs2s8lkS7oyab3Po0UqrAs1nTDNII4Nvh8m98k06NUC8X4q0MzAYP3MaZKww6dnNkcHlr2s8TFU/0Vj86O3e4UkV9+zGcP9KwPq6qCBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zT9e19Ik34sEMK8r4eiPZy8kfACWrZmmhzruCSZHVEc=;
 b=oJEEi61/RGAz6XH9bZJdiKWBWIBe+SLjiEnu0yXDbU9o2lLElFD4fRmddDCBfZ0xTb1K9NPv3UaJxJf0XAf55Gb0FVGUJPWUd7IdeYpfst0JbgUX7g/tC5YvGPfCcL4s6Vi5dFSTKDgLJGrajDNipYLQLfJteZRb8aZFy+4MX/A=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by CY8PR10MB6564.namprd10.prod.outlook.com (2603:10b6:930:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.29; Tue, 7 Mar
 2023 02:54:50 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::8ef9:5939:13aa:d6a2%8]) with mapi id 15.20.6156.028; Tue, 7 Mar 2023
 02:54:49 +0000
To:     Lee Duncan <leeman.duncan@gmail.com>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1zg8pl1nq.fsf@ca-mkp.ca.oracle.com>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
        <88927435-ae58-c24b-e7b7-b675985de433@leemhuis.info>
        <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com>
Date:   Mon, 06 Mar 2023 21:54:42 -0500
In-Reply-To: <86D685F2-D411-460B-A09B-6BE942372F0A@gmail.com> (Lee Duncan's
        message of "Fri, 3 Mar 2023 10:54:21 -0800")
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM3PR03CA0076.eurprd03.prod.outlook.com
 (2603:10a6:207:5::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|CY8PR10MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: a2edbb60-77fd-4127-8951-08db1eb75106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwKoqhPkA/H6mSe65DM9edlIThNTjQzaGUpx01pWojHPUQK5pGMToWswbwHSh74JhpzmdFyPlzmclidIb1a7BZM98vbpbBSa3Jw08DBmUaxabxUjii4Vg/Iu+Xir8TsrJTxhHtYqtw2NRLDx5O/QnZFkpGyZ8CZCWHVIzKjJz0clzFUd3Vy77EsZ6eHIATrT14Q9ngk/sHo7DDBvohd2JOhkJAlpV3QWnR410Ax8VDRnoflmu+5XUesJK1sLjkrcs0Cf4jCRJbtnlm1Kp0OE9GGLnyaNnnosvLwQLqU62LbXX+WqjhoUFlk0CLdWZVPvjqNk+cQc3MNKc+EYiYQK+s3EEhP9mmDv9PncjV8ciGyA56y2H6s8LaKYwhwrRscxtDdCI1iwE4if2jgQfzA+55eYEhE+l5GbXWJCYbvO5YEV9R6ms32h9m6NbLZZWNQa5/pf1K5r7TxrpXwvkPyMzGrHxMkpNxpeMLOva+FF3RkI/YCYXzyK9ACPmgxATneP9Fv8XgQeqeXtDqBjBKqB6bQpPOcL64Ijj+H/qI8Mw1TZguR6/uU+Ta9xgr00GSFGyMzrm9K/VDqux9x0AePimePtIpH52w9XiPBf13CmpKsrgy9ZWAE/Tr8hzwDbyPwk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199018)(36916002)(26005)(186003)(6512007)(478600001)(966005)(6666004)(6486002)(83380400001)(316002)(6506007)(54906003)(66556008)(66476007)(66946007)(4326008)(6916009)(41300700001)(8936002)(8676002)(5660300002)(38100700002)(86362001)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFl3dmJQc3RnbU8wMUdxcjV5aGFMb1craWJmTDMvSDZYZXlQNUlRWkhyV0hB?=
 =?utf-8?B?cGRQdGd1M3A5cGxkcktHbTRVaEw3NitDK1hXRyt2UnNhSjNvSmRycXRCczhO?=
 =?utf-8?B?QklyTWlZME5Nb2FNUUhONUc2SWNNTmdISWxpSGFHcS9kRi9UclhZbzFMdzU5?=
 =?utf-8?B?czVWemk0dXJoOEVKQ1BqR1ZnRy9VMStvWm1PV2NYMHRBWEhwY2NML1l0ak9G?=
 =?utf-8?B?RDViNFNSdW9yb2R3RHo2QjVHTnV6WEdiQy9mZUJ6c2V2aVFxZkhFWGxYajdi?=
 =?utf-8?B?TmpBeUtJUXl5cGc4ZkM0T1FXQTJaMFlLUGsxNS8vcUZVT0hEQ3VBMVRPRHNj?=
 =?utf-8?B?NmJIYWQrcU04bmIxalVzdWEyUEFuaDVRd1I5cjliN085VUgvenQ1YjdMOHp1?=
 =?utf-8?B?dWFHSkdmU3FhaHE3K1JzdkdFajhvTXB0OS9QZnN5dDB1b0xPZG94ZWtvb2lG?=
 =?utf-8?B?enJXVFF5TDdid2dPRmVVTjlBSTljL0ZJNWFMRkwyRmdqdmJvNEY2a3RPM0J3?=
 =?utf-8?B?aUhtWWZoYmR1OVR3ak54eVY4ekQyNjRGWDE3R04zZFpqekJMT1RWQk4ydkhY?=
 =?utf-8?B?NGNUY0RTUFp0Ujl2WWgzMTZnQjU1UXFaNklFcjVGTlRvRVNGdEJKTk1UTG5a?=
 =?utf-8?B?TUdvNXhDWkxwcXlza3E4L29aM0prTDkvR0IxTWtkODlKMXozYjd4TEhMWHNm?=
 =?utf-8?B?Z2VpSWhDeWRNcXZma0RIMksyTjRNOUdTb0J2ZnFVV0FXcUx4U1VJT1JSRmhn?=
 =?utf-8?B?SDRoc1FmaHRSckpVS1Q5UmFQVWZhTW1PYkRGZmNCVkxsN05LdURGTWh0MVp1?=
 =?utf-8?B?TUgrUkREci82Qk9EVUFuQkczV3kwTkJXS1lJd3Q0UXdrVWdtU3dzVkZYeHl3?=
 =?utf-8?B?OEY2Z1QrTzVvYm5mRWNDcy9sbXh4aXpGdmdxZWxjRlBaUnJUbnlFa3RKTFI2?=
 =?utf-8?B?QUlUQ2UxS04zN2hpWjE4alhQUjBxR2UwQUhRRDIzdWdWcE5SSmZJcHlVYURK?=
 =?utf-8?B?ZlpSWUpRSlhaVkUvYVk0LzNIUXpRb0ZXYTNmOFZJL0U2SVN0UzRjc20wb0VO?=
 =?utf-8?B?UUtYSWdoM2RlSFhUWWgxZ2ZOc0tvcnZVQ3VsanoxUjc1TThsNWJ1UnRmQ3Ry?=
 =?utf-8?B?UlVYNVhCRzgwZWRuWC8xQUFtQ3poY1lXaXU5WEw1QmpmVzdKNmgrUXRjdDNU?=
 =?utf-8?B?RWYrQnhnY0ExYURvSy9iMFdYazM0L2lsb3p1YXZvU0dzTjZSZ0RoNjUwQmdp?=
 =?utf-8?B?a2RadHpDZlFYOTZWeHV5ZHE5Z01HNmw3a1A2OSt5eTNZZ0xyb0w4cXJtbE1x?=
 =?utf-8?B?WGFTMUp4SmtZMisxdXVicFhpYVVQa01ISTRRU2lQdklGdFRTcVoyTG9FTW1N?=
 =?utf-8?B?cHJYYVdVcWxJL2RFdm9KbTF4cHZsOTZwWTVTaW1tTUZpNHk0RVo4MmI5Znhl?=
 =?utf-8?B?N2swMTdXNVBXcVM1eVZkNjhMbWJZSFljSnFHc1VUZ0pkSVg3eDhEeVBhdWFQ?=
 =?utf-8?B?dnp6Z05VblAvZkZpVTJYUkdGbktYT0tEL25zVnpheDc2YlloL0xKRlg5K1NS?=
 =?utf-8?B?Wk5PY0dsbzFUd21qV3hFUi9aMW1kYkY4Q3lQeFJjV0UwZ1dYbjYrUG1ReFNp?=
 =?utf-8?B?aXFvWnhZTExQTUhXeS8wUmdObDBYYTFXTUFiMGtwZHkrKzhlTFJUZDZaSlBK?=
 =?utf-8?B?dlZYellSV0RBM25RdjdPWUJhdzlPWW1ZTFR5MzFNdFp2TElKa2tFWSs1U0xO?=
 =?utf-8?B?elBaeTM3ZXBVbnJnZ0FVMGpmUktQb3FOaU5yVlhLRnNveCtqNlFWR2duM01s?=
 =?utf-8?B?cEFHZ3owRlg1Qkl1OVd1R1hvL0VsbldpeFVPc2ZRaVlXZlNtVUVyT0k2dUdG?=
 =?utf-8?B?TGJRbmVLRHM2N1JndWlSWjFVbHRKSHFzaTNtV3JCMXNYYTdGVVBZOW9wK29R?=
 =?utf-8?B?TU4zd0xGblE0UjNHcjFwVVJSbjN6aUtndFRYTXMxRWdUTURvT0tDdmh6OGhi?=
 =?utf-8?B?OGNSZXljdUlpRnBpV3lGZ0dwdjhHR2U4Zmh3VWNxQ25ydERVK3NVSUZNZDN4?=
 =?utf-8?B?Z2s2OGgvNUEwTDZGZE9ZQ1laeHhNd210cEZpVEJnTnU2Vm1LZWdNUEN6OGhw?=
 =?utf-8?B?dnR6MnpXZ013R0hoaHBjQittZmViVjEwMS9WRk1GWWhmUXpzWlRMZmlVK000?=
 =?utf-8?B?TGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?ZUp3UzY3N092MzYyRUlmMGdDWXZkdi96VXI4bmp4cXJTaTE4MHZEMnBidkJz?=
 =?utf-8?B?M0dJZ051NkhySE0yWmlZMS9YUnZKTmVOd3NTTk1VcXdCUkw2QURGZncyMVNG?=
 =?utf-8?B?R3dBRGtvMjRWaklXUTJSYUZYbnhOQmpneUQvclk2UlR5Qnh4TU1pTDNMN0Vo?=
 =?utf-8?B?NWoraHVYaEt1WHJyOE8rRnkxTUZvUFpGWU15MEttZ2Rkb0ZEai9YS0kvNjlr?=
 =?utf-8?B?QVVKOGhHNCtxdXRQZ1JiRDNoazJqRjYvaG92eGNSRkhOQ3RHL0NrTkJFRkVt?=
 =?utf-8?B?ZjBZeTExb2hqclUyMTZ2bFA1Mm55SThoNXJ4VVJOWVdRT1R6U29GWitlV0NY?=
 =?utf-8?B?OW8yYVl1ZGdWSDNnZGJJS3RvQ0dCMTh6aE9NMGkvdGttTzBHT1dTeHc1RDB6?=
 =?utf-8?B?eGpvUlhGU2hlMmNLQ0p5bStwQUo0NUNvdzBXNE5ra0MxMjkwMWEvS3F4RTcr?=
 =?utf-8?B?SjdQejhNRENuZHdUTkhWbjlMdk1HYkFDQWtVb3RENzc0aUd6bEV4QS9qbGxX?=
 =?utf-8?B?azRmb3gzdnd0R25kMDkvUDVHaVRBSkJIUkhPUFhzY1o5ajM5QUNUTU8zb1U3?=
 =?utf-8?B?dWJySXNsM1MyTTRxMitIMU1Ecmlyc24yUTM3MHR4WlY0T3FuUUNRUTZDdFNQ?=
 =?utf-8?B?SHRhMXQzNUdhOHlXVFhiMTM1bE9yYkRBSlhITGJpOUtHQXhnR252a1grUmZp?=
 =?utf-8?B?c3NBMUZReTFwYjFEU0tUVlFMMEx2M25pZ3BXQWxZSXo2L0hSK2lhdlJMNUdF?=
 =?utf-8?B?YURyY3Q3ZnMwZm5mK3FJRlEyV2FnNVRiNnhDVHhTMm00N25ha3dwKzdMVHAz?=
 =?utf-8?B?RTR3YTFCcFBuZFFiTTR3YjVGUjhpL0pBbGNUZHJBY3orVXV2dnM3bFFsS0Ux?=
 =?utf-8?B?NkhHK01iNXV6QU0xcmJoUG1XVk1iQ3J4MjV1SmJabTJ4dlZWa1RQYzNKelpY?=
 =?utf-8?B?SmxGVU5maitkUHBFQy9zYS9objl5M1RJbWJrOHpicWpHN1c4cWpCTW53QWcx?=
 =?utf-8?B?b25oMnc1VnBKYnMzREREcjA4VU1aYVJYSXNNNG55czlFYVFjKzM4MDNCZUww?=
 =?utf-8?B?eTduR2gwNEpPdlU0dzg0TmRzeWlFaFpMZjZHNWVuellJZW1DRW1xdjNVOXZN?=
 =?utf-8?B?a3hyL0hHeXlzdTFkV29TQnlHUWRxdllLYkFCNGthdzQ3MVcrbFFCZEN6c0sr?=
 =?utf-8?B?MmF3QWIyZkF5S2ZtS0MxMGxhRHJsaUFERjdEWHFLZHBaL2RFcVhPYkowY1VX?=
 =?utf-8?B?VWhjbzRUNlBjTUtUbU14UkdjM2VqZnV6QmtTSzZnYU5oMGxtUT09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2edbb60-77fd-4127-8951-08db1eb75106
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2023 02:54:49.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VXNQHDUMckWSN6EByIy6Po6MsGbptvuilUBXm/XvU4U8bBiYk1i0ZAd0NeoQyAdl9k4WKX/R+sO2M2aFbtS8haCZteMgEfk6Dfi9bm8ei3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6564
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-06_14,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070025
X-Proofpoint-GUID: tE4KcDGkGtu3efh-KOffSdhRlFnxO_A2
X-Proofpoint-ORIG-GUID: tE4KcDGkGtu3efh-KOffSdhRlFnxO_A2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Lee,

> I really prefer specifically listing =E2=80=9Coffending=E2=80=9D hardware=
, rather than
> automatically covering for it.

Would the following patch work?

Martin

---8<---

Subject: [PATCH] scsi: core: Add BLIST_NO_VPD_SIZE for some VDASD

Some storage, such as AIX VDASD (virtual storage) and IBM 2076 (front
end) do not like commit c92a6b5d6335 ("scsi: core: Query VPD size
before getting full page").

That commit changed getting SCSI VPD pages so that we now read just
enough of the page to get the actual page size, then read the whole
page in a second read. The problem is that the above mentioned
hardware returns zero for the page size, because of a firmware
error. In such cases, until the firmware is fixed, this new blacklist
flag says to revert to the original method of reading the VPD pages,
i.e. try to read as a whole buffer's worth on the first try.

[mkp: reworked somewhat]

Link: https://lore.kernel.org/r/20220928181350.9948-1-leeman.duncan@gmail.c=
om
Fixes: c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
Reported-by: Martin Wilck <mwilck@suse.com>
Suggested-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Duncan <lduncan@suse.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>

diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index 9feb0323bc44..dff1d692e756 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -326,6 +326,9 @@ static int scsi_get_vpd_size(struct scsi_device *sdev, =
u8 page)
 	unsigned char vpd_header[SCSI_VPD_HEADER_SIZE] __aligned(4);
 	int result;
=20
+	if (sdev->no_vpd_size)
+		return SCSI_DEFAULT_VPD_LEN;
+
 	/*
 	 * Fetch the VPD page header to find out how big the page
 	 * is. This is done to prevent problems on legacy devices
diff --git a/drivers/scsi/scsi_devinfo.c b/drivers/scsi/scsi_devinfo.c
index c7080454aea9..bc9d280417f6 100644
--- a/drivers/scsi/scsi_devinfo.c
+++ b/drivers/scsi/scsi_devinfo.c
@@ -134,7 +134,7 @@ static struct {
 	{"3PARdata", "VV", NULL, BLIST_REPORTLUN2},
 	{"ADAPTEC", "AACRAID", NULL, BLIST_FORCELUN},
 	{"ADAPTEC", "Adaptec 5400S", NULL, BLIST_FORCELUN},
-	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES},
+	{"AIX", "VDASD", NULL, BLIST_TRY_VPD_PAGES | BLIST_NO_VPD_SIZE},
 	{"AFT PRO", "-IX CF", "0.0>", BLIST_FORCELUN},
 	{"BELKIN", "USB 2 HS-CF", "1.95",  BLIST_FORCELUN | BLIST_INQUIRY_36},
 	{"BROWNIE", "1200U3P", NULL, BLIST_NOREPORTLUN},
@@ -188,6 +188,7 @@ static struct {
 	{"HPE", "OPEN-", "*", BLIST_REPORTLUN2 | BLIST_TRY_VPD_PAGES},
 	{"IBM", "AuSaV1S2", NULL, BLIST_FORCELUN},
 	{"IBM", "ProFibre 4000R", "*", BLIST_SPARSELUN | BLIST_LARGELUN},
+	{"IBM", "2076", NULL, BLIST_NO_VPD_SIZE},
 	{"IBM", "2105", NULL, BLIST_RETRY_HWERROR},
 	{"iomega", "jaz 1GB", "J.86", BLIST_NOTQ | BLIST_NOLUN},
 	{"IOMEGA", "ZIP", NULL, BLIST_NOTQ | BLIST_NOLUN},
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index f9b18fdc7b3c..6042a5587bc3 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -1055,6 +1055,9 @@ static int scsi_add_lun(struct scsi_device *sdev, uns=
igned char *inq_result,
 	else if (*bflags & BLIST_SKIP_VPD_PAGES)
 		sdev->skip_vpd_pages =3D 1;
=20
+	if (*bflags & BLIST_NO_VPD_SIZE)
+		sdev->no_vpd_size =3D 1;
+
 	transport_configure_device(&sdev->sdev_gendev);
=20
 	if (sdev->host->hostt->slave_configure) {
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 3642b8e3928b..15169d75c251 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -145,6 +145,7 @@ struct scsi_device {
 	const char * model;		/* ... after scan; point to static string */
 	const char * rev;		/* ... "nullnullnullnull" before scan */
=20
+#define SCSI_DEFAULT_VPD_LEN	255	/* default SCSI VPD page size (max) */
 	struct scsi_vpd __rcu *vpd_pg0;
 	struct scsi_vpd __rcu *vpd_pg83;
 	struct scsi_vpd __rcu *vpd_pg80;
@@ -215,6 +216,7 @@ struct scsi_device {
 					 * creation time */
 	unsigned ignore_media_change:1; /* Ignore MEDIA CHANGE on resume */
 	unsigned silence_suspend:1;	/* Do not print runtime PM related messages *=
/
+	unsigned no_vpd_size:1;		/* No VPD size reported in header */
=20
 	unsigned int queue_stopped;	/* request queue is quiesced */
 	bool offline_already;		/* Device offline message logged */
diff --git a/include/scsi/scsi_devinfo.h b/include/scsi/scsi_devinfo.h
index 5d14adae21c7..6b548dc2c496 100644
--- a/include/scsi/scsi_devinfo.h
+++ b/include/scsi/scsi_devinfo.h
@@ -32,7 +32,8 @@
 #define BLIST_IGN_MEDIA_CHANGE	((__force blist_flags_t)(1ULL << 11))
 /* do not do automatic start on add */
 #define BLIST_NOSTARTONADD	((__force blist_flags_t)(1ULL << 12))
-#define __BLIST_UNUSED_13	((__force blist_flags_t)(1ULL << 13))
+/* do not ask for VPD page size first on some broken targets */
+#define BLIST_NO_VPD_SIZE	((__force blist_flags_t)(1ULL << 13))
 #define __BLIST_UNUSED_14	((__force blist_flags_t)(1ULL << 14))
 #define __BLIST_UNUSED_15	((__force blist_flags_t)(1ULL << 15))
 #define __BLIST_UNUSED_16	((__force blist_flags_t)(1ULL << 16))
@@ -74,8 +75,7 @@
 #define __BLIST_HIGH_UNUSED (~(__BLIST_LAST_USED | \
 			       (__force blist_flags_t) \
 			       ((__force __u64)__BLIST_LAST_USED - 1ULL)))
-#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_13 | \
-			     __BLIST_UNUSED_14 | \
+#define __BLIST_UNUSED_MASK (__BLIST_UNUSED_14 | \
 			     __BLIST_UNUSED_15 | \
 			     __BLIST_UNUSED_16 | \
 			     __BLIST_UNUSED_24 | \

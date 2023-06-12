Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DA272D2F9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238702AbjFLVO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjFLVN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:13:58 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB66211C;
        Mon, 12 Jun 2023 14:08:17 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKOQvm003977;
        Mon, 12 Jun 2023 21:07:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=emdauTTQb/aXDwONd7tM3PBloeLeEdXW7mhte0QrtjQ=;
 b=2IMRK/+kEeiVrQ4JEHuRwRZs5jMnkK0WgaYA0OxZnTHgxOVfghQG4L0GaEB2vPEu8w2+
 HkoBmlt2UQRYvgNnkYmnNp19QBd7EH1ON7dp32+48dR50UIHHexZ9SYwBmGXB/7WdL6q
 tU8nA4bDtdDEz0Adc67XKiTbdty4W8F9oa3ZxBZEKwcGGjXTWnaLK8/s3iFkYRjSwjQg
 GCFV0BwfcKHoz5o1MsiDAFMJg/tWYk9IHjtVFtMxI3zluRR3TycqZVdiRvSpA3+V7BnF
 HzFKdGCCO2++GvQxtAnCvVuEu1RVCprLk2n5rRMCxFx15o7LMOl7LuRhRmZ1J7sh04yV eg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r4fs1uyup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:42 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35CKZN8s014146;
        Mon, 12 Jun 2023 21:07:41 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3r4fm321h5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 12 Jun 2023 21:07:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMnIDIJR6Wsu7XNJvZkv9efDVRYv+Z/8Q58TgElYg0ql93kYwMI17DguHsE62xIrE75yFHvJnUOVrpDUkHR+ZVPb6qQalx0PPjrhyj57SKagmr3IhaSdLgpQDjAarmwmrsnHwdDU24Vht8Jflz22yw5bi3pnDJpcDitqAFTuBlGdT/o5XpQLafRv9GSm/axzMz8DzXtwTcBj2+MWUH0thrdYiavz6Tb82PKNQVTkBQtmd74MlI0eoVxQ7eJS97Wk+kar8PGxJd+wg73feXB8Tk+FowJKZTQf/pB2Bev2wBUkY9rZprWH37+xb6BDlmFwJuHEq2hb0/qH5o3Gn1riwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emdauTTQb/aXDwONd7tM3PBloeLeEdXW7mhte0QrtjQ=;
 b=csTo+yTJg4S6zW+pNvqp7dOTe3j4gfDUVJviZdmi+xTDd/d12n8r54kfySR1WlHExAVcOBmWKy1oVmgjsGhg5KzvsKMqkZzYv27T58zqp6RpoWi4AKFw/YJ4WWF5Cqbd8gD+SbYp3nVjZlutzYDfQp4FlX/nWtvpwP8SiPIfXmciWggiO8dcAwo7MgI8xvZBdJ5Z8rZ3rVpTTFFX+ic3QY/WKMni+aYn01K4/Pu/UqX9BWHHNiFwhS2gnME/VRfR/LE/5wiCWLNOCurd4HYnV3TRLj9sxIEunVEbzcrUScCva0FnlsgfESsiLGgahy2n8HohkyWiSvKEkR5YdTLGaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=emdauTTQb/aXDwONd7tM3PBloeLeEdXW7mhte0QrtjQ=;
 b=VGF6YV7ECbysJoZ2wvBE+MQy6Gh71iTPztCMcxNnpFD1T9y9R37eBhbjuX6aF1D2/JSvN+8ivBOjF4GTYzSXbZyIeDKxUAOgjbyb31NAfyMyQy3fkIYgjgiKtSKgjDudP98Ge81bOWYFR0XSqoLumgeJA28J6QFAR1qKcxOQtvE=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by DM4PR10MB5966.namprd10.prod.outlook.com (2603:10b6:8:b2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Mon, 12 Jun
 2023 21:07:38 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6477.028; Mon, 12 Jun 2023
 21:07:38 +0000
From:   Eric DeVolder <eric.devolder@oracle.com>
To:     linux-kernel@vger.kernel.org, david@redhat.com, osalvador@suse.de,
        corbet@lwn.net, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, bhe@redhat.com,
        ebiederm@xmission.com, kexec@lists.infradead.org
Cc:     hpa@zytor.com, gregkh@linuxfoundation.org, rafael@kernel.org,
        vgoyal@redhat.com, dyoung@redhat.com, lf32.dev@gmail.com,
        akpm@linux-foundation.org, naveen.n.rao@linux.vnet.ibm.com,
        zohar@linux.ibm.com, bhelgaas@google.com, vbabka@suse.cz,
        tiwai@suse.de, seanjc@google.com, linux@weissschuh.net,
        vschneid@redhat.com, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        sourabhjain@linux.ibm.com, konrad.wilk@oracle.com,
        boris.ostrovsky@oracle.com, eric.devolder@oracle.com
Subject: [PATCH v23 2/8] crash: add generic infrastructure for crash hotplug support
Date:   Mon, 12 Jun 2023 17:07:06 -0400
Message-Id: <20230612210712.683175-3-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230612210712.683175-1-eric.devolder@oracle.com>
References: <20230612210712.683175-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|DM4PR10MB5966:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e4b938-6d00-4e6f-5180-08db6b890d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gL/NpgSH/LUnUbUOTsqGdXEjz/1lR6t19uEntZa35XTtuwlkG4Bcp8se2n2fsbmKfm8Z0+/RbuMUK7OxPvtRVracCIARlJlfka9PhfTpkIA/b51u335uK04A1bWfS6DVvYuw7GH9X4DqmZqWCf7PLT7rDo3Z+hx8fydZ3Tmd/HxQ0BB3kZQV50/Ea1YpERyVtKXfRAOk0aqpwrOZl6QE7aehOjGjakSPazJJmxKrUknKpEE1khFvNLjLGTBg9vmaVFVEgZ6CLVqDZEWXvdjMOfm06J/T0SE9TZ6BxpnVWoidxTNZvMocJGrxXqBTo5vBPJHsfW+duXIuvDmcBIF5iUP/RcpiPR9+XiW8swgyJnlkMrDLR/6DRn8XHGXsdNvfKyMgxzS45lQ7CFOOUUkoXy0nWPszxvGiPIA3OIkIDdaYxM1w9Ib7Ziw2+4ExJ0rl2roxTQS66GezOS9XM4SsS38s3FWvlCtMgwFV/aH6qwXqImXzQcShzqxsyMn/mSzu430/oWGFIwNB5G4+NZZn5ivIeb0i3OXJaZmBVaXYvIYr1+DHoamRCAhQRSfqvcyLFQL3BOzsIgaPE82xEkdT9Pcb+378nKPScUzwu3TVRjBD76UC1L7os8Hqj5CywGCJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(366004)(136003)(396003)(451199021)(86362001)(36756003)(30864003)(2906002)(26005)(6512007)(1076003)(6506007)(186003)(107886003)(7416002)(7406005)(41300700001)(83380400001)(478600001)(6666004)(8676002)(5660300002)(8936002)(4326008)(2616005)(66476007)(316002)(6486002)(66946007)(66556008)(38100700002)(921005)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hTQtZAhnPbNVzmCSqRv/BqlwLRi/UQJq7i/Alr49qZIymMhpHcV4JC3XsYnO?=
 =?us-ascii?Q?5BfWas7CJSFUWJ17kAKIo2zSOY3z0C4gwze4Lu1vwp0crcjEyEsL4Gn10kL6?=
 =?us-ascii?Q?hdJ/3e1CA5UhW8Y9WTprt+5yc4AvVU/69BXwkmzyHC6NLKqsLDcKHGiNp1oj?=
 =?us-ascii?Q?xCYeYkyfjh2Rv7pv08OzvdlLHBb1TRRlMAKL/yZepVENztrWGRKL87jBM9ak?=
 =?us-ascii?Q?USHxVsB6eeQqtFwg47ptLqdPavBGgQx3BkP0mO53dlKGA6VSVo9yAjZXsE6g?=
 =?us-ascii?Q?tbuSkyKqi/q88j1OBw0nf7s6ulZmkA4C7FxzDK/wNKsaMy+EUgvWrDInOa/y?=
 =?us-ascii?Q?xcx1cegBoBG7TwzdvJ4S/wFsIRnJJepWYzKoo6/EqDMZ0VqaDBVouqlpBNGk?=
 =?us-ascii?Q?Ral5p8RpzyOMjYTX7BfxH+4jbEBDFX18BS7eUz4FQIPFEBaiNoaY2EmqXPb7?=
 =?us-ascii?Q?aKxklBpB/ltSaSpG5JS0c65EKZQ4pVKxgNtjGyIxT1dEtYbhuArumwPQWk7F?=
 =?us-ascii?Q?IqlCdTaq5PdaGbfFZ5s//gkci4GrvL464zbwoTzKjiJ3lSmK/YLBxFtTWTua?=
 =?us-ascii?Q?oP6FMX5PT8ZRf4PoqeLDDqulcJrCoH5uIEZYaHRQldHvgrEjt06xSL+9vWBp?=
 =?us-ascii?Q?Q3csuopb6fPqE9wexi5njI5utW38tENjQW7x3rPdmhEbSJ0HJk+RSahskMN0?=
 =?us-ascii?Q?o3eSgnUstXBLudQkAjp/AJiPg1+kGaQxr4gFUqAQw/UWB8xbgiO85OHQYN06?=
 =?us-ascii?Q?ncwq6aKMmWHNEkSLFJckJktWdXGl6P5pdp12WXtFPKh/yGTLvyVstcJe1EGT?=
 =?us-ascii?Q?6v0Aum1IegnUDcLy+jsrSwc5e8sookEx9qKDuzGIwqsYjWGe030tQcaBv6SF?=
 =?us-ascii?Q?t3GCd9lt3aYo9W2WirsqQ5xZcjjGJ/xskTylB352jJk7AqrHgW6IYKoEmyUa?=
 =?us-ascii?Q?GqppYrmvd+84/efUi9fPPq8hz5RdPxrA/4ytP/+o6wzJXHJgIiMAMzD30Hon?=
 =?us-ascii?Q?K27xAMvQmASetx2+3sXlMmUc2UV0fatEucVKw4LxI5yRvkKpg/RB8iKe7GF3?=
 =?us-ascii?Q?KehME69wrVjiIINnu9j5GN2Fitax7QkyRSBY7y8ulSARVoi4FZrxH1Sleni3?=
 =?us-ascii?Q?+BtPc3/m8JnIAqkZjkeXnk+Gi9L/6fmtHdOQchr500dH0hY07Exp11MECsNJ?=
 =?us-ascii?Q?GMwG3PSaRivveNYw4Gf0OuEadnENoOm5WCjSig/HW9RMAfzqBmGEY5BfUISH?=
 =?us-ascii?Q?AreMLwAJ1RXxGrNy6q4SHb1BcH4ihHuVfuleQpGYUgS6JEBMeU1ak0Wnimis?=
 =?us-ascii?Q?RQWilD6iiIzNsdyhrG3D/9xAkpxB82J6de3y3o/AjTiy2RmW3N50qvjYwVGo?=
 =?us-ascii?Q?WFjZ2G7DB//pBpDLKRLiaFLz41GSPOD1RAyQ4i29mKk0E+/20wjvwhiAtsk6?=
 =?us-ascii?Q?6ORG/IUnIZ0gcFcLG0tKNlLQap3GOBog9TPVSGESOEFHrIEiWuZJ4MZU/+lv?=
 =?us-ascii?Q?61a0RraVbjVSza2Z3jAuXn2lce2qYDwmRpMca8bgtoytq0AYrz+QOkR0QLBB?=
 =?us-ascii?Q?h3UvY4L+1SuDd5lonwckFRoprLTUJgTYTCuiFtl0B8LVruox3eo+AQi0ZDc/?=
 =?us-ascii?Q?Fg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?+FixyZDYtNgSPnygyQu0XzEUkgrc+PBkUxKj1z2fKBtNEYE5iD+guwQHrHbH?=
 =?us-ascii?Q?MVXRH7ofPG27aGN1cCAK8/ghlEbQm0qI6cjEUDmrrnqbokYFbLvkroYtN1Uc?=
 =?us-ascii?Q?kofrrPaBhfSkvWi3DkDLbiObDTjOZF4R8S4Eb9YW5VycNvc7ZotizhcWL/6l?=
 =?us-ascii?Q?irFzMI1kmcielGrRXpmGfxGpKgkcozv4XdIFFeMQp72p+jxe73D0hZ+F+UsF?=
 =?us-ascii?Q?QYjwqny9WpWxSdudo1B879o85Suw9J03aez/yxSwVKaKCMf4D/y2MGM/FtfU?=
 =?us-ascii?Q?+pGOe7T8DQnayENMUkDydIZ53OXC020iSm5xD1IgY6Jbmf9EMO0F076spfrP?=
 =?us-ascii?Q?Vgm1MCWyoYfbKwF7J6X4xtctVth6WFTx6ojLs0ttbQY9zHUMtXSj1imRdSIv?=
 =?us-ascii?Q?devmKckcytJoEEbOh5yKT4WIXK6l+GFMLa81QGKa5ss2Pylc2yZp7gIfEgZy?=
 =?us-ascii?Q?H1sFAnvtxveCgR5NyElVeN+Wldjdooud96omgoaXOEkIAVnvHfVOfmE5j1CQ?=
 =?us-ascii?Q?wn1igGaucuZoD3ZMVTTCsb7PesKskCgGR5ZzfveQYn5Snk9qZ8F4/HEV7y9f?=
 =?us-ascii?Q?GwARQudGRQlJddOOODlroiu4/6tJxYuRsitiQ+X3IXaG0nPPfVT7bvyMIr90?=
 =?us-ascii?Q?Bmrr5DkR9Yv5dUo3y+fKMO72Y1WZDLIsDbPNx2TP9/ujmR6fNg1gSDMd96+h?=
 =?us-ascii?Q?8kIkU9ZYxSjU8JtEzUrmpbhvzPudZ7xRqEoVQwwmXdwCQvOId1yCmSTdiIQg?=
 =?us-ascii?Q?33ft104NQxBmbWeqZ8r/HzIuCAfxkFu0PFzdVao6dB+06b5mL8Z8+Nc4Ai/+?=
 =?us-ascii?Q?otBxr1mvHh6K7+tGd1UYJth1cnJYQjLVLH7do4bpgt8ijqJfPUQxKIwzHExg?=
 =?us-ascii?Q?da/WDE6Jh/Rs+e0oTVq1OpSELFhSGQu9WyMWEQGrrdUF/jIIGVWF8qTT1YWB?=
 =?us-ascii?Q?wf/MayHZIjC0bpG2chNa3RcQ3BCpeZafeinm++GaiOa1jy8SS2xrlr5ZQF1L?=
 =?us-ascii?Q?K06qNwYhQz02bHZFnwHsvLmVU4ROInCO35t584zl6aA63CtlIfuyQZaQ14P8?=
 =?us-ascii?Q?G2PMlbjDd1SYd20akNjIvlHEB8sqRwfCm+CvBE8fn/j/JRBJajH+XJiwyM46?=
 =?us-ascii?Q?bPd01RKz83pvR81V2LRMGpRvPvpAyqIxtgTFprbkAqB0vZfQC6xJJgNw7SgU?=
 =?us-ascii?Q?RLtchyhpfgILBXC1uDSz2Qsb06av+qQh3GIzV+XOFCslYtt/mrJzDC4/SMVD?=
 =?us-ascii?Q?O+nBfIQ1hhpV7uuVvEiFiN5mbaUv19OrL0H9z9KqhYmwzwnuomo+uaTvJzkO?=
 =?us-ascii?Q?K0jpkN96wliZiit7oPN2szcYh1NEJDONM+FQed+aTwqh/rLc62fOXo1FElsF?=
 =?us-ascii?Q?tYdhfNKfklRYc5vWfO8wTQT3eNNR7KtUCdJ1K+q1+p0AQr4fInR8SGa8n4qT?=
 =?us-ascii?Q?vAAYLelY0WA=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e4b938-6d00-4e6f-5180-08db6b890d20
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 21:07:38.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ERnhu7H1WgD6Wr3IB/OFfZBGlfkxpEFA7bDNFn2jOnexRtT8B/Yf2QrJzdZn0VgL/6WqBLqudoFQoKbQRUaOuNjlm+kbg2mIH9fSODC0lk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB5966
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_16,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306120180
X-Proofpoint-GUID: 6Mq04LbYqxE0VXwLMrfEUPIQV5lTXpii
X-Proofpoint-ORIG-GUID: 6Mq04LbYqxE0VXwLMrfEUPIQV5lTXpii
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support crash hotplug, a mechanism is needed to update the crash
elfcorehdr upon CPU or memory changes (eg. hot un/plug or off/
onlining). The crash elfcorehdr describes the CPUs and memory to
be written into the vmcore.

To track CPU changes, callbacks are registered with the cpuhp
mechanism via cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN). The
crash hotplug elfcorehdr update has no explicit ordering requirement
(relative to other cpuhp states), so meets the criteria for
utilizing CPUHP_BP_PREPARE_DYN. CPUHP_BP_PREPARE_DYN is a dynamic
state and avoids the need to introduce a new state for crash
hotplug. Also, CPUHP_BP_PREPARE_DYN is the last state in the PREPARE
group, just prior to the STARTING group, which is very close to the
CPU starting up in a plug/online situation, or stopping in a unplug/
offline situation. This minimizes the window of time during an
actual plug/online or unplug/offline situation in which the
elfcorehdr would be inaccurate. Note that for a CPU being unplugged
or offlined, the CPU will still be present in the list of CPUs
generated by crash_prepare_elf64_headers(). However, there is no
need to explicitly omit the CPU, see justification in
'crash: change crash_prepare_elf64_headers() to for_each_possible_cpu()'.

To track memory changes, a notifier is registered to capture the
memblock MEM_ONLINE and MEM_OFFLINE events via register_memory_notifier().

The CPU callbacks and memory notifiers invoke crash_handle_hotplug_event()
which performs needed tasks and then dispatches the event to the
architecture specific arch_crash_handle_hotplug_event() to update the
elfcorehdr with the current state of CPUs and memory. During the
process, the kexec_lock is held.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 include/linux/crash_core.h |   9 +++
 include/linux/kexec.h      |  11 +++
 kernel/Kconfig.kexec       |  31 ++++++++
 kernel/crash_core.c        | 142 +++++++++++++++++++++++++++++++++++++
 kernel/kexec_core.c        |   6 ++
 5 files changed, 199 insertions(+)

diff --git a/include/linux/crash_core.h b/include/linux/crash_core.h
index de62a722431e..e14345cc7a22 100644
--- a/include/linux/crash_core.h
+++ b/include/linux/crash_core.h
@@ -84,4 +84,13 @@ int parse_crashkernel_high(char *cmdline, unsigned long long system_ram,
 int parse_crashkernel_low(char *cmdline, unsigned long long system_ram,
 		unsigned long long *crash_size, unsigned long long *crash_base);
 
+#define KEXEC_CRASH_HP_NONE			0
+#define KEXEC_CRASH_HP_ADD_CPU			1
+#define KEXEC_CRASH_HP_REMOVE_CPU		2
+#define KEXEC_CRASH_HP_ADD_MEMORY		3
+#define KEXEC_CRASH_HP_REMOVE_MEMORY		4
+#define KEXEC_CRASH_HP_INVALID_CPU		-1U
+
+struct kimage;
+
 #endif /* LINUX_CRASH_CORE_H */
diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 811a90e09698..b9903dd48e24 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -33,6 +33,7 @@ extern note_buf_t __percpu *crash_notes;
 #include <linux/compat.h>
 #include <linux/ioport.h>
 #include <linux/module.h>
+#include <linux/highmem.h>
 #include <asm/kexec.h>
 
 /* Verify architecture specific macros are defined */
@@ -360,6 +361,12 @@ struct kimage {
 	struct purgatory_info purgatory_info;
 #endif
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	int hp_action;
+	int elfcorehdr_index;
+	bool elfcorehdr_updated;
+#endif
+
 #ifdef CONFIG_IMA_KEXEC
 	/* Virtual address of IMA measurement buffer for kexec syscall */
 	void *ima_buffer;
@@ -490,6 +497,10 @@ static inline int arch_kexec_post_alloc_pages(void *vaddr, unsigned int pages, g
 static inline void arch_kexec_pre_free_pages(void *vaddr, unsigned int pages) { }
 #endif
 
+#ifndef arch_crash_handle_hotplug_event
+static inline void arch_crash_handle_hotplug_event(struct kimage *image) { }
+#endif
+
 #else /* !CONFIG_KEXEC_CORE */
 struct pt_regs;
 struct task_struct;
diff --git a/kernel/Kconfig.kexec b/kernel/Kconfig.kexec
index 660048099865..a117163fde45 100644
--- a/kernel/Kconfig.kexec
+++ b/kernel/Kconfig.kexec
@@ -100,4 +100,35 @@ config CRASH_DUMP
 	  For s390, this option also enables zfcpdump.
 	  See also <file:Documentation/s390/zfcpdump.rst>
 
+config CRASH_HOTPLUG
+	bool "Update the crash elfcorehdr on system configuration changes"
+	default y
+	depends on CRASH_DUMP && (HOTPLUG_CPU || MEMORY_HOTPLUG)
+	depends on ARCH_HAS_CRASH_HOTPLUG
+	help
+	  Enable direct update to the crash elfcorehdr (which contains
+	  the list of CPUs and memory regions to be dumped upon a crash)
+	  in response to hot plug/unplug or online/offline of CPUs or
+	  memory. This is a much more advanced approach than userspace
+	  attempting that.
+
+	  If unsure, say Y.
+
+config CRASH_MAX_MEMORY_RANGES
+	int "Specify the maximum number of memory regions for the elfcorehdr"
+	default 8192
+	depends on CRASH_HOTPLUG
+	help
+	  For the kexec_file_load() syscall path, specify the maximum number of
+	  memory regions that the elfcorehdr buffer/segment can accommodate.
+	  These regions are obtained via walk_system_ram_res(); eg. the
+	  'System RAM' entries in /proc/iomem.
+	  This value is combined with NR_CPUS_DEFAULT and multiplied by
+	  sizeof(Elf64_Phdr) to determine the final elfcorehdr memory buffer/
+	  segment size.
+	  The value 8192, for example, covers a (sparsely populated) 1TiB system
+	  consisting of 128MiB memblocks, while resulting in an elfcorehdr
+	  memory buffer/segment size under 1MiB. This represents a sane choice
+	  to accommodate both baremetal and virtual machine configurations.
+
 endmenu
diff --git a/kernel/crash_core.c b/kernel/crash_core.c
index b7c30b748a16..53d211c690a1 100644
--- a/kernel/crash_core.c
+++ b/kernel/crash_core.c
@@ -11,6 +11,8 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/kexec.h>
+#include <linux/memory.h>
+#include <linux/cpuhotplug.h>
 
 #include <asm/page.h>
 #include <asm/sections.h>
@@ -18,6 +20,7 @@
 #include <crypto/sha1.h>
 
 #include "kallsyms_internal.h"
+#include "kexec_internal.h"
 
 /* vmcoreinfo stuff */
 unsigned char *vmcoreinfo_data;
@@ -697,3 +700,142 @@ static int __init crash_save_vmcoreinfo_init(void)
 }
 
 subsys_initcall(crash_save_vmcoreinfo_init);
+
+#ifdef CONFIG_CRASH_HOTPLUG
+#undef pr_fmt
+#define pr_fmt(fmt) "crash hp: " fmt
+/*
+ * To accurately reflect hot un/plug changes of cpu and memory resources
+ * (including onling and offlining of those resources), the elfcorehdr
+ * (which is passed to the crash kernel via the elfcorehdr= parameter)
+ * must be updated with the new list of CPUs and memories.
+ *
+ * In order to make changes to elfcorehdr, two conditions are needed:
+ * First, the segment containing the elfcorehdr must be large enough
+ * to permit a growing number of resources; the elfcorehdr memory size
+ * is based on NR_CPUS_DEFAULT and CRASH_MAX_MEMORY_RANGES.
+ * Second, purgatory must explicitly exclude the elfcorehdr from the
+ * list of segments it checks (since the elfcorehdr changes and thus
+ * would require an update to purgatory itself to update the digest).
+ */
+static void crash_handle_hotplug_event(unsigned int hp_action, unsigned int cpu)
+{
+	struct kimage *image;
+
+	/* Obtain lock while changing crash information */
+	if (!kexec_trylock()) {
+		pr_info("kexec_trylock() failed, elfcorehdr may be inaccurate\n");
+		return;
+	}
+
+	/* Check kdump is not loaded */
+	if (!kexec_crash_image)
+		goto out;
+
+	image = kexec_crash_image;
+
+	if (hp_action == KEXEC_CRASH_HP_ADD_CPU ||
+		hp_action == KEXEC_CRASH_HP_REMOVE_CPU)
+		pr_debug("hp_action %u, cpu %u\n", hp_action, cpu);
+	else
+		pr_debug("hp_action %u\n", hp_action);
+
+	/*
+	 * The elfcorehdr_index is set to -1 when the struct kimage
+	 * is allocated. Find the segment containing the elfcorehdr,
+	 * if not already found.
+	 */
+	if (image->elfcorehdr_index < 0) {
+		unsigned long mem;
+		unsigned char *ptr;
+		unsigned int n;
+
+		for (n = 0; n < image->nr_segments; n++) {
+			mem = image->segment[n].mem;
+			ptr = kmap_local_page(pfn_to_page(mem >> PAGE_SHIFT));
+			if (ptr) {
+				/* The segment containing elfcorehdr */
+				if (memcmp(ptr, ELFMAG, SELFMAG) == 0)
+					image->elfcorehdr_index = (int)n;
+				kunmap_local(ptr);
+			}
+		}
+	}
+
+	if (image->elfcorehdr_index < 0) {
+		pr_err("unable to locate elfcorehdr segment");
+		goto out;
+	}
+
+	/* Needed in order for the segments to be updated */
+	arch_kexec_unprotect_crashkres();
+
+	/* Differentiate between normal load and hotplug update */
+	image->hp_action = hp_action;
+
+	/* Now invoke arch-specific update handler */
+	arch_crash_handle_hotplug_event(image);
+
+	/* No longer handling a hotplug event */
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_updated = true;
+
+	/* Change back to read-only */
+	arch_kexec_protect_crashkres();
+
+	/* Errors in the callback is not a reason to rollback state */
+out:
+	/* Release lock now that update complete */
+	kexec_unlock();
+}
+
+static int crash_memhp_notifier(struct notifier_block *nb, unsigned long val, void *v)
+{
+	switch (val) {
+	case MEM_ONLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+
+	case MEM_OFFLINE:
+		crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_MEMORY,
+			KEXEC_CRASH_HP_INVALID_CPU);
+		break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block crash_memhp_nb = {
+	.notifier_call = crash_memhp_notifier,
+	.priority = 0
+};
+
+static int crash_cpuhp_online(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_ADD_CPU, cpu);
+	return 0;
+}
+
+static int crash_cpuhp_offline(unsigned int cpu)
+{
+	crash_handle_hotplug_event(KEXEC_CRASH_HP_REMOVE_CPU, cpu);
+	return 0;
+}
+
+static int __init crash_hotplug_init(void)
+{
+	int result = 0;
+
+	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG))
+		register_memory_notifier(&crash_memhp_nb);
+
+	if (IS_ENABLED(CONFIG_HOTPLUG_CPU)) {
+		result = cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+			"crash/cpuhp", crash_cpuhp_online, crash_cpuhp_offline);
+	}
+
+	return result;
+}
+
+subsys_initcall(crash_hotplug_init);
+#endif
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index 3d578c6fefee..8296d019737c 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -277,6 +277,12 @@ struct kimage *do_kimage_alloc_init(void)
 	/* Initialize the list of unusable pages */
 	INIT_LIST_HEAD(&image->unusable_pages);
 
+#ifdef CONFIG_CRASH_HOTPLUG
+	image->hp_action = KEXEC_CRASH_HP_NONE;
+	image->elfcorehdr_index = -1;
+	image->elfcorehdr_updated = false;
+#endif
+
 	return image;
 }
 
-- 
2.31.1


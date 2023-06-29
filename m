Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0797B742D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbjF2TX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbjF2TWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:22:48 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DEB3A96;
        Thu, 29 Jun 2023 12:22:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ3pJ3002889;
        Thu, 29 Jun 2023 19:21:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-03-30; bh=W8iEv38eAoUWiIac6DamuSVNXvMP78ssEHCbdxW608k=;
 b=L+IkdWZFNFEhwpn1VLX7tgAEM1FW9IXfAo25OMs7pW7FAWPWGIM1F6JeVD3X11UHhpjH
 hkAbZGm3QxV/PVtWmjR9DG488f/IM93sCKjmxvLBkVU8fiJnt/OD1sKk21nXKhJ3Kr7x
 +ouWBLxsPhXSya8O6Lyyc/ZpXwj/hRfKCQh8tnNpvZOuoKWSvuU7ODnV0d/X6hHcEZi+
 7trT16l63g6Rc7MawAONP/I6AHaBcGQgI4ek8VnfsICnfiO0lZ7E6bq6xwYlyef/cWDZ
 RZ5+hkYZZ2upfnoD4eZ5b7HCvnJfxilbOGSM2s1J9Ydt3Q8FoIaHaOnS7EmTtQy+dNuc yw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rf40ebwfy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:43 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35TJ0IVo038174;
        Thu, 29 Jun 2023 19:21:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2043.outbound.protection.outlook.com [104.47.66.43])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3rdpxebtjm-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Jun 2023 19:21:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JX9GCD8BR518yEpK4iUT+2rZg+fL0n8oxgD9lytEL8g8iXK5kxOCa4Aoh3kGvehupEdffAjUsBXYyJJ+USJUlPjsZ2p+EA0DefG7tEtBPH9ULgtisBFNKEol1QDsuKFXQOc20b75LMqo99WApbCvK4E+rpTlxKov21irJddyGg+8+3umypS1tMTX5jF3sbmvdHbFwD1f6Dd36mzhd9Dg7aFq9fvqvlaMWj0exbuKeJPRXv2OJabNukQqm+IOIM/PlEK37iBZe7TTYsHbIEeJf7fYQIVNKbSu6kdNLGnQUi00qoIGW5pGaN+8BX7OlIG+WQXP7mA7Cx5T1EYbX4UzdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8iEv38eAoUWiIac6DamuSVNXvMP78ssEHCbdxW608k=;
 b=Mgu4+MAmBmtjvYP5Ng3XJUf2QIawtbFcpNMEzHNpZRJ8NEK++tzA58RdUDcYhIc/N+tbJYf4OVkKhiiRgiEw7KNZv9z4Msicc2jlKsd21+3VZfY/XS7C+rhlNgJ6kFevn+v+BIFS29z2GF7478vrXfw46OxSpCD+VOIajlJwMjo1D9PvRu/JxTcB9eKm0q4FndBQ1B5rdoLE7sLX6x8q8/cGVIDlMLUm7fHiozrhjG2vu+xQiMxh1Br2+HD60Rczc6aVuHuO2s5Zbpz45JaSbpMEhEbqk+fOENWLow7FkuP6gwR0kAq+d39YAm2E7NU2UZO+2ESllPhBkD1gxB4Iew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8iEv38eAoUWiIac6DamuSVNXvMP78ssEHCbdxW608k=;
 b=qqJe0mhdUhAQpnOpFxzwnQ6Ilx6eUAHTExafUWtKgiYYT5aCRqOQs7y75RHALHE6RM08CsFOx54KWyRZ0xDsEkFD8rZ8PrGoqQ9s8mp85khA4AX50vslGuqHZas+GxHyWWm550oxsCGJMk4/+2VE/ehieqQ4hmMnBIqBriVriuk=
Received: from CO1PR10MB4531.namprd10.prod.outlook.com (2603:10b6:303:6c::22)
 by IA1PR10MB7200.namprd10.prod.outlook.com (2603:10b6:208:3f7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Thu, 29 Jun
 2023 19:21:41 +0000
Received: from CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048]) by CO1PR10MB4531.namprd10.prod.outlook.com
 ([fe80::8b8f:b4b1:bb78:b048%5]) with mapi id 15.20.6521.024; Thu, 29 Jun 2023
 19:21:41 +0000
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
Subject: [PATCH v25 05/10] kexec: exclude elfcorehdr from the segment digest
Date:   Thu, 29 Jun 2023 15:21:14 -0400
Message-Id: <20230629192119.6613-6-eric.devolder@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230629192119.6613-1-eric.devolder@oracle.com>
References: <20230629192119.6613-1-eric.devolder@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:8:2a::18) To CO1PR10MB4531.namprd10.prod.outlook.com
 (2603:10b6:303:6c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR10MB4531:EE_|IA1PR10MB7200:EE_
X-MS-Office365-Filtering-Correlation-Id: 24462888-195f-4289-baa7-08db78d61137
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M+hr1M1PebPIYWESt1s2eIZHjFQWNlV1I77JOqoErmkNGI4x/qvA8GL1dpgAMbRK04YFHtR3vRrzX9sH8P4BtgtlLPhc0WfzvMc1T4SXf4B6/hx5iB7UhIrKFsFF21GJ83OnunbU4sSKB9dfC0j9XxbDJYKWBWmi/Dt1LZY21iMwGvNxyjRN6VQGDnNpMwzKgVtSvp7DFugp7VSiNUnoGcsZQWpjRutCqjNiRsdoqKWzmPFCv9Q/S1qmc1FYok0JHO++Wj6SUaSMdIF9hWtBNObLBDeHbojNYNmys3MQxcMHD9uHwpMPK0QCh2qSHVabJXv5YPhxcyI6ddor7jCxp+P87GXBDuQCBFkmWX87Eo2JdwFG/w3T1fcJTnDY4PlnyjoXFJWV1UePwEBHHahXG4AEgRuv0FSnSjgi+9S5QC8QKuIechMEtLrA9bpJQtfwowGdENClHQuthIiEvv5f/M00+GLLNFbX6AmMlXxWCJFJyEenyIibAg7UZDtG6dhHpAlHnYa6sbu+n18TL24CPED+w6dUkCLcE9TBxHV45YXb94EyQHbZ0wZ9j4NSBmCPRMPwr/wqlr1kfvStoNLG/V0HrmF7JW42piFNRTPqsK0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4531.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199021)(83380400001)(316002)(6666004)(8676002)(4326008)(8936002)(6486002)(41300700001)(36756003)(86362001)(38100700002)(921005)(2616005)(7416002)(7406005)(66556008)(6512007)(5660300002)(66946007)(66476007)(478600001)(2906002)(186003)(26005)(1076003)(107886003)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TM0sx6/Xq9XotUX9l2vrr19DS6QeD9xsUMmgh4XZrEhZccnPjCHmmzMZV9Vw?=
 =?us-ascii?Q?8BmIBrJgNcSWRa8HrouvSUCG7oWnIFbBuo8dpqMmwsrOLmSMLMb41gXpYzoE?=
 =?us-ascii?Q?O6vVdTuvPUCpkbCSvFuFS/sYfnbpffogoe7dq82tD5+xDlnxViry3Csvk/sZ?=
 =?us-ascii?Q?lmK6cr0FBcGySTn8gI26dYYX3sb5bte5rj3vh74sd8xTKBN8OEAOcZmcxH/W?=
 =?us-ascii?Q?Ykh2TADVUd3SfV0em6S3OJ/bTFtNv6JDeIRi+UtiISaeOtnjbfeItxocJrtG?=
 =?us-ascii?Q?HmSc3k8wPEjm7PG34SM0+5OuOb2t4iFJCDJu8C6K3L0grqZMFo8/y9sD4PZy?=
 =?us-ascii?Q?gcmJ9mYd2b2ROgZzU/iJb+tX615iRsTbvrWOQyZPn0lqz16ln6m8T7uM42AF?=
 =?us-ascii?Q?/njMei35Z8lHlINp4+xNn7ElRnAyfkjJHwnye4V+8cO2k3nVv/oMu1ILf0u/?=
 =?us-ascii?Q?HEE2nijojRhIIuJ5ok52B1mYCNQzZtzloqb4LEAb5CZd3Cso93V2nqzC/2r+?=
 =?us-ascii?Q?bxikvcuQSWKgX22LFnVPflarMonVit4BckCh0tG20FUGCB65w7EOEC7X8BoX?=
 =?us-ascii?Q?6eSzgNtLawOcwT85NX0xL2gPvYRKG41UaEAOORtuBFAU0uFWb92CC0dJtfRJ?=
 =?us-ascii?Q?HeMeF+LKuKY3FzjusJ33cvQG1lAV5PoC/UNoL+O58kHngr28xJtypxPI0oMj?=
 =?us-ascii?Q?iZm3ZnTH8SIWw+ImuW54txeQCTqPFZsSd/U7giu+gftSeOPR0+7d/xaNXxS7?=
 =?us-ascii?Q?KA+yHJufiSTh39UywvZLFWUf/9Oqde/DZvqhUDNHZifO10jSnXtT2dGi5Qw2?=
 =?us-ascii?Q?OP3cCGVSsHmv3MfM0Op1D5CKs0YWjYk6y5fIojJFmLcOD5OcwzmOdj4yTg6O?=
 =?us-ascii?Q?whqlUjA8bmWAEEBy7Ol+AX9L5sIjOkpIsD1pcVA+NLZFFewp/OdcVeK0hF4w?=
 =?us-ascii?Q?KIzC9DP6TJ8qUQ79kwCJkKWYc97ayAyqcqz4oJDzj7Cxv0OZ9qytuMvUXDLG?=
 =?us-ascii?Q?RHoUFi+Vowx9AIU09FeaTjeli29LCF2yXNRxWJtYKMpdksSF7IajoBwu+8Ns?=
 =?us-ascii?Q?UcWdAOJhIiSbrYsvw5sGY0lXtSxu11F4f6VHr2tyM6Ih5eksurDfA+UxsOwW?=
 =?us-ascii?Q?mmx23OmCX0/17PXCqbNTRR3EZRNBMCZL3+qzbF7al/zcbZWA2pWO0u7Q4Df8?=
 =?us-ascii?Q?9QIDG++iSjc0zNgja5jukrN//kqH7bCit6Rqbb0cCzpYEw69ADP/VfQss8XH?=
 =?us-ascii?Q?gZqU4v97nDWejM0mDNtb+egjpbLKZVC1MAFz1MaAXKSiRvDlNDCg5rq7cUdz?=
 =?us-ascii?Q?4To/dFQ8/OFpcF4PE3BNu029mv/b9nH2AlNV+lXOItsOLFP5Km3ODXa0U07+?=
 =?us-ascii?Q?KAEIlCv8fcnFdIyRtdQMzuhxoXQ122JGPMmw8SGKKzb6aqyASX+YABR+AXQR?=
 =?us-ascii?Q?6bEcTlk6JF1aOa+c93phxUXf8V7uoFyutYgFs2ItW2NqfRJq8zr0vmBI5Ofb?=
 =?us-ascii?Q?vivh8f5NzS1mwhxY3o1VrIyysXM7CQkoIlEeuQ6PxKVtx3mMjS9aqw1HA+t2?=
 =?us-ascii?Q?CwSgkD+U/ajT14w9o2FnquBcFZCVRPhDcc504BwtgWxuo8GB8aZcfjgFIqbO?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?CQDeCFfFZ1R0JDubJmP9Afil1FjF6pRKNI4DOdChH5DCvOxqoWvqg9k9NcCK?=
 =?us-ascii?Q?hW9Cf8ZEBBOTUdjqCpCUhNEvb5qxk1XRtm0Ij5aQ1yIudMqKDu3Z3OweMmg2?=
 =?us-ascii?Q?7Fjsf9S9zC3sfpQZer3ykRFipi6vMTr7eC86/iowx+PcgGozbmVcvoUsZpok?=
 =?us-ascii?Q?zb0cv4wqyLiUq3Xx3edG8URXMIP+rgjhdw/mjnwwtG71kK1T36jQ7t4Yxve3?=
 =?us-ascii?Q?lmA22/vZpPl/+rvaVZVPxJ3s/JeA83v/pQ/mhlRKRNvj8FSCY1HKAZ5GwZCr?=
 =?us-ascii?Q?y/ZkB326050FCeFYegyHXTyecFDlKTx9FtIYWFDnk4ax6jYSDEl513kftRLJ?=
 =?us-ascii?Q?sCgHAplPqfuybVcB4JqEcxRxnWD9ReixEQrR41nA8y03ir1HucT5qXRd3Gjr?=
 =?us-ascii?Q?I52HkEfqsIBbccNlA593OkyZAxOhB2otWx5yiz/662RBmc+FMNYi6+Y/bUEi?=
 =?us-ascii?Q?c5jxYVmNIiaQhi44hJGCuZK1zVhSz0jSSB52nAU+WKKYWFXCrqlj5yOA806W?=
 =?us-ascii?Q?WBy1cUFUvwiz7c3Ds0hDuu65Emdoxw9guQIipNg2nyvc/f0J7Cqn5u7hEBQx?=
 =?us-ascii?Q?Vbs7eH3/DRxGt9LYDlfRKTPA/cTqCf4mtkP02LjPyUZi2gMnp8Y2R1awEeKw?=
 =?us-ascii?Q?8ahRePjzaV6ndncuNRrvNsv1r3Fy5neeHy/N3R1lI5J8JIztOGsu10L7Pc7e?=
 =?us-ascii?Q?XbdSEdp+jYgHXMg0/YmsoJuCOr778IbCLjo1kr414jFDn4yObN0fVEvglvKT?=
 =?us-ascii?Q?2YjUVNTZGdt7GJTa96zBMRpwujKRaM+Voxtd9Te3Fve1B8GbfutlFe7iKglE?=
 =?us-ascii?Q?J26jSzTXDdU0XRgjq/vCn7rz6T3w0ZnIgvcj53KO6PXyhIwODUXf2DO9uav7?=
 =?us-ascii?Q?1u5aAoCO8LT/Kv0pyI5yJNHjVzUTUl8mOd7E+rtZViPaxq/tkfvzUyVLrdmC?=
 =?us-ascii?Q?Rj0FzJGpb6tmnvuS2CzlN+O8XvTJG1c0nbkjwtn98MNER5e+3vwPIByIIw4d?=
 =?us-ascii?Q?nIfLLt/U6wP74hEuuKeAyjQdlOLdoQ27SFvA5W8m2vC21chkkZXCI2lyQD+Z?=
 =?us-ascii?Q?HW94dvGIG7wTr+lFtAVe5L4gsgxKsKD5WI4O/lsxQO6k/NxR2xq+ao6ukP8K?=
 =?us-ascii?Q?rux4MxHlRbuokp/FyRGEs2L1B05g5smJXgXWNfRIlx7ZIAt0oySFID3pOHqm?=
 =?us-ascii?Q?p/0g+Giw9g49EivuV8fStxREAnQrpG4l+Ev0eM+cBcfgUK0sj9ZFB2YRZO6C?=
 =?us-ascii?Q?goy10KP47vb0O+aKTrI/yE3a7udwK2K1V25K8tquqhLmxVDrux6H+brMRWTQ?=
 =?us-ascii?Q?M+ewwcC93fcocDgYBU+MhJ+uDobogCaaXvMiHvYM7rqDXMr5gDT4ShhFsB4U?=
 =?us-ascii?Q?LlxLm5Di0qZcfFBZ3C1/KLr7PcHHG8RB6oyLgLBn388szQG97muN1bqFu0P2?=
 =?us-ascii?Q?lVBfctVC/wo=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24462888-195f-4289-baa7-08db78d61137
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4531.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2023 19:21:41.1857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8s0JWoJ1aRCiTXx8C6norwnWarzFx5XsAJFksgdE8jQNaf6vRILGxga2LDKgAlBQPPMEF6XtQz/zyKMlwlbgHEvE/C6qDy54Gxhj65iHuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7200
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_06,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306290174
X-Proofpoint-GUID: BxNcQgntbmbUMwcnHXGKW08s1B19OfVS
X-Proofpoint-ORIG-GUID: BxNcQgntbmbUMwcnHXGKW08s1B19OfVS
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a crash kernel is loaded via the kexec_file_load() syscall, the
kernel places the various segments (ie crash kernel, crash initrd,
boot_params, elfcorehdr, purgatory, etc) in memory. For those
architectures that utilize purgatory, a hash digest of the segments
is calculated for integrity checking. The digest is embedded into
the purgatory image prior to placing in memory.

Updates to the elfcorehdr in response to CPU and memory changes
would cause the purgatory integrity checking to fail (at crash time,
and no vmcore created). Therefore, the elfcorehdr segment is
explicitly excluded from the purgatory digest, enabling updates to
the elfcorehdr while also avoiding the need to recompute the hash
digest and reload purgatory.

Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
 kernel/kexec_file.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
index e9cf9e8d8f01..824ffc5282f4 100644
--- a/kernel/kexec_file.c
+++ b/kernel/kexec_file.c
@@ -726,6 +726,12 @@ static int kexec_calculate_store_digests(struct kimage *image)
 	for (j = i = 0; i < image->nr_segments; i++) {
 		struct kexec_segment *ksegment;
 
+#ifdef CONFIG_CRASH_HOTPLUG
+		/* Exclude elfcorehdr segment to allow future changes via hotplug */
+		if (j == image->elfcorehdr_index)
+			continue;
+#endif
+
 		ksegment = &image->segment[i];
 		/*
 		 * Skip purgatory as it will be modified once we put digest
-- 
2.31.1


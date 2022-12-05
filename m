Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19A2643293
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 20:27:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbiLET1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbiLET0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 14:26:45 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8CE9BE35
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 11:23:31 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B5JETbw001341;
        Mon, 5 Dec 2022 19:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2022-7-12;
 bh=8uOeK2jiti/Gvy2EY4ZKC56UhfE3yp/rIMDkHrTIbuQ=;
 b=gDoxECw1lfZC11CGovSHePThWepf1o7xvRCZW+55frbA94mQnqT1/GTQKCFM80meWBp3
 yOf7JTNdO0cQoYaRuv7nAdpicOjWTfzr5mu4c26YY0MmcGVs2paz3cL8kqhMuWR2yy7f
 WWwwnIvHuqFNgNkRiTqXjT3gvw53LQaJYf/5uORQO/LfcLWiKjPmIcdAjHFQ/KUMDMGa
 e2PG2nRF/1ZBV1+Z9obuXAE3Z5Fs8R1/mndyLDcOFDmvquC4nO/FFN2MVDrzkJR0RFfD
 1yuzTIAEskznAvJ7Boraqt8LkeKRjYQfFq17dz3oJf79sBazBL8mKi64sQRst4U5ymJG Vg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m7yeqmuvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 19:23:20 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2B5HqLSK018770;
        Mon, 5 Dec 2022 19:23:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3m8u9ydg9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 19:23:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij4UlFl7HIk5b6dssWpsWtY3IDxxSycsbmSAVQPl5Q4581mPuAdBtcyQyzpM+4TTaP+btxZX9IK+9ePLc/R/atvFQ8sGLnWoaIHoVSG5Qf3mJeCdtPFgbmX9o+J6bThLGobgVURkodbXAngt1Cld1ju5w1ugJ1mpHL11LvCpwnYqv1frsS57pMnliBAP2Gl3FM3HNFO2Z86raDLLT+EQo9MHCi9glufd725UqVjw5DmdfgO293QJn3/pUeaKWAsaZWsrgcaoTs2D23lRnQUmSXm4HACoKjerV32c/dDP/anLhhi51+KD93peE5uSoCDXJlR/ui8xzBu97Ar2d5AcFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8uOeK2jiti/Gvy2EY4ZKC56UhfE3yp/rIMDkHrTIbuQ=;
 b=XbcdMfd93hefjosy8T3fvBpnOCYtwNTBOleIuwlaZb7cU19FHKeL/Rn7MKS07fb/9tyCA8OO9C8t7bbxHxQKV5Jbikt2pG653ZfHy0MPnTk4Wfvbt+/KIgtZI5fKecMwW5Ud3QrvTwOZ0VsVt+1aDRdUkBUjrcqtk9qCEhJod1OwN6MRKB3AprCMdDFabdCZr6loirpR3z1AbLoMvtsHoZCY3Ia/RMkx2rW7tmq/8Ne2q5JNFdr3q1W+t3ZzngAmGCHSm6wMGYKJ87bgD9B2VtmLacOXe4r+hAQU1SdO0zJskiDxXeKagY79AihIEcR7Avi3I6ZnkhmBinjxkarsAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8uOeK2jiti/Gvy2EY4ZKC56UhfE3yp/rIMDkHrTIbuQ=;
 b=tnnXme63s96rwZlopMYxfDxKd0mBUaTZ7/0npGJhDhLQFs9kZ3Zyvp29exZhotzyhlFik+os1arbRpc3K6y1fy1xipITjmR5Vbn2zPDjOm3Qg96w6RcmiVIhCb2jMSDzYYSD4EwQoU7gMwMEtwjtbU43t8iUonkJSyVSw36JQFs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB7008.namprd10.prod.outlook.com (2603:10b6:510:287::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 19:23:17 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5880.013; Mon, 5 Dec 2022
 19:23:17 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Yu Zhao <yuzhao@google.com>, Jason Donenfeld <Jason@zx2c4.com>,
        Matthew Wilcox <willy@infradead.org>,
        SeongJae Park <sj@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Liam Howlett <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>
Subject: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously incorrect
 VMAs
Thread-Topic: [PATCH v2] mmap: Fix do_brk_flags() modifying obviously
 incorrect VMAs
Thread-Index: AQHZCN8GtZfVbzYk1k+O68Wup8Rcdg==
Date:   Mon, 5 Dec 2022 19:23:17 +0000
Message-ID: <20221205192304.1957418-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB7008:EE_
x-ms-office365-filtering-correlation-id: 076c1486-34b2-48d6-d3f2-08dad6f6297b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: msRFLU1669Dqfm8jSEBJBAk6W737hNcknkLgTCAjjOXCwqzf9ym8u4HVpf4f4NAQjoEqW0fZQmsE2O6YT0j5rbZAAv4HY8RprdupWPSOf3QT08MVB7zuekWPJpSXr/MKJW6ZI7uL159mxdGGh0Zx42fFNgF+4qbtuQOAbCHsL+w7P31Qqh34nyN6zz9SWsOI2uTtBp4i59/Vs1SZidfRSL6AjL9MEFpKMYlubRF4YZUs0mGbI5uRRRruhZKMBUTaLCteNeA+hUTZc8RSZ5MeR69vs7cPsEBKqMIklW+KRdp5xGvBBB5Wi5u9+k48yY7squG8jREBfcExH5F48tOEXAhwO2H4nCTaP8uGZslaX0RidAFP5nWsOGof31cZykIZghBitkacABH4mNGdPhAG6NrFHj7CaZR6MHMf/PzpgMc16jkhQdNyYkTVOcHbAgGmLkRA+xOnEpmteFpV10iyFt0bqUwtdNjBfjHci2182m7sI+77E15LW5N5DHZnrISLCTJLSIR8mfS3941khwqZP5PKILEDQDMXXnxC4gagBK/1nV0EQtRiGKSUsF1j2tE2+P3llcY9yL0+xghNPn81IEGm2DgqYwoI2AfopsBgoJL/3uph1Zakieegn5ojq5hXBO3tLlua76syaVY9KMxm0P5fUja5Zg4Lfl/XyXcgZwqV/YxepHBdydveqOavUQd7qEubDsdJiv5xnjlQIADCog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(136003)(39860400002)(366004)(376002)(396003)(451199015)(26005)(6512007)(6486002)(478600001)(6506007)(316002)(66556008)(66476007)(76116006)(71200400001)(66946007)(91956017)(110136005)(54906003)(4326008)(2616005)(8676002)(66446008)(64756008)(44832011)(5660300002)(8936002)(1076003)(83380400001)(186003)(2906002)(41300700001)(36756003)(38100700002)(122000001)(38070700005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?IfVglh5KekJ2s+bxR6lWV8aueUXrNMp2gVETK4udbYaGmANyOkXx44nVeS?=
 =?iso-8859-1?Q?36H7hwpMHNcj3hczt6QRpzxn4+i4t3VjmNY0cAvIMy0nQoyDtoZRJxww3G?=
 =?iso-8859-1?Q?OFthYXzUcPcWaB18bgTlHsLuHxJ/0livJUkCA9cukIh0wv1pTFRzzXuWBY?=
 =?iso-8859-1?Q?ImAdEBdYqWBzp2jErYrz4LhhG3F29vsrggjIy0oHH4s4Ad6jT+2hRbbvjN?=
 =?iso-8859-1?Q?MohuaQWv1gsEX/E5C/cLjABFQeNuaajl9h47K5VWa5YQAaYJJGYsS64tuq?=
 =?iso-8859-1?Q?QuFs+Eq2sYmoB8WfXtPJFDLAkVeTRBkq0cIQ57660AMQjzIpM6b375MhBp?=
 =?iso-8859-1?Q?l1QCGfd77QO8YjTk0xXbTawT1LqpPTCXNVM2ucSP134iD/NWjih7MRzJHF?=
 =?iso-8859-1?Q?yAzLVb2YxXAvvXA2BmewCukMfkl2StNs77Y73Ter4WT5qlR3OhvEROPGE/?=
 =?iso-8859-1?Q?NfM1pyqy2Xg0cpNpFHFO7+p3VQRwuFwchAx3ao/1CYE5ac5PbsFboVEbmc?=
 =?iso-8859-1?Q?MzK9moDJV6ziSNGh7NiZ2Quh3CNzD2ApXnYWLK/ydFDAq4OV6LtLOP9Ks1?=
 =?iso-8859-1?Q?ve+KzwdSaD2xAvWFLjhM/NFVAWpRpT4dz3/VAezwcEWmFdiomrTUiZ3SV8?=
 =?iso-8859-1?Q?iT7e3EmaWyPN0q3MsM8vkkBuGpQixUv8MvazkpxCiaR7qyr2dErCwI7EB8?=
 =?iso-8859-1?Q?1wk2DhGjHuz7LeVFWs/4x7Um8jCtW09c+dMYcWVpEJBH7JKASMNrJxPnqe?=
 =?iso-8859-1?Q?Dbd8iThkXku4OBUQrOg5qMSJM5S5ugvLFdzi2hJnixdqDx3hF5/B7x//zx?=
 =?iso-8859-1?Q?9oW5MuI2Zepd7jpJefimwnMxmIx1SebtKvxcIAC4Cj5TzXGTBnmRocBHwx?=
 =?iso-8859-1?Q?q0Vu6iMwVR890+q/wvBEXDcO/E2JLgUClz/jjcR2hcSHOXadTVEU/hEvQn?=
 =?iso-8859-1?Q?YmMcfpGNsUMOYGCqwICwPXuJNpDXU0HdW+OsBeQ5vDlO6nX9/FY4Vxbbp6?=
 =?iso-8859-1?Q?XwHkLJVE45WVYdXS/hirCqtsrZsNonJG2weoE5qy5PDgfO1I7VvbSO/24o?=
 =?iso-8859-1?Q?pc2zgrrFX2nUB2TsXAB+/sikHRCoVx0dutgTAyzML/mba3khsNozkmpafa?=
 =?iso-8859-1?Q?V0UHJ5TcdmZJhTx7nuTUfZyHo/mk5zjrvu1nTYLCnBhzAhrxWhMI1jwJds?=
 =?iso-8859-1?Q?0O5Ieoj3AyPAOEy18iYL6K9Nck3QODYtVYk9oe6zizOUuUC1II/UbTNE6W?=
 =?iso-8859-1?Q?Z9YZ1wV+CAR1f3YBf5qeRgb4J/0DFPsRScaKwoy+oof7VviS6HkPsqWIOp?=
 =?iso-8859-1?Q?xO/ivH1L9AX6vQrcdcNqc+uZ0KMcwjrp7nuxxEWFVVstZBdcRbK0xYjFvd?=
 =?iso-8859-1?Q?XYIxNr+MgQxcyvrYz5R5yEVDO97ubP00mTjoupzzeXeVndJHD8KAcwIQJD?=
 =?iso-8859-1?Q?p3rot5vS9LFlLibweyiHY/zj5CTIUG3/E2jdAZRE8gbEjjlBbEhoZlNC4l?=
 =?iso-8859-1?Q?hVFVs6m19EmzBYaNHPGRYf6Jt0Q/t1fEl9/0DsJI/5MD5xcWL0tuAcIMMN?=
 =?iso-8859-1?Q?IxzeA3JpXSCmxx9FO67gaaciNdX78nduFN2RMKjxt0JDBTAhHk3FFKiNyE?=
 =?iso-8859-1?Q?qSc1dZTGYFsZzW5XqdJTl9e5PZflWYBSM+ybYTOeXFHR28j4kgeTtWvQ?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?WJbOb9fsrey+oSRNlIjwQEhx1yQr3iqiFpo9JemnYnbKAwMZ3naGDrfldN?=
 =?iso-8859-1?Q?3lZjQ2T8Ox+O4ES8VmycM7oGCUxaSHSDRJbPslWT+A15LQZaQReE96T3S7?=
 =?iso-8859-1?Q?kmfZSYj1k4BshqCbIpXJI+Y6SvPtjGhHqDNqWAT7+sDVK/JNmwfrt422+b?=
 =?iso-8859-1?Q?Oi74vLvOT6PoBAW5ZCStY25I39F1E2Iqof0+ab9zgDjfnNRiK8aVnUnjni?=
 =?iso-8859-1?Q?a6KrUXCkRqGCNFJO/dstATm4tS5rf7lwKBneJnvRs8Mw01v1sxfXmAlxCZ?=
 =?iso-8859-1?Q?Rx++A8pbCKurLHabAMNUCaKY9+MUWPxywMU66hEoZz4TJsgtSbbiq6TjYm?=
 =?iso-8859-1?Q?quNTfYmE8SmGXoTeeigryCi5iO3WR7twmdFlxDOL2WDac3yTHffPJtFPdK?=
 =?iso-8859-1?Q?RCnFHj5G7w6YUwrckXdLZXCV8XETMXxN5Ok5nEPLZStdn64FDU0zDbvVoU?=
 =?iso-8859-1?Q?NKKE7VEYHZ54/RNlZzKoTr9IE46wE7AtVbmAHvQfFSCxmHmIyrAS1Rlw1y?=
 =?iso-8859-1?Q?De2Y0hcLm6gFzbrYiK3fU7/MyVDGAeI5yQeVmPZH0nVICp0DQEikMh06Zo?=
 =?iso-8859-1?Q?x8yp1Uk0kS+OZjAlCKyxCtJp5NwEEPAiKF4dIzJSzL7rFlLFiL+oeuN7QX?=
 =?iso-8859-1?Q?ViOeG1RcFmfDsD5kM/tM63UsolUJUhSu3ap2x9awmVDIrDHcXMjLu6zcwP?=
 =?iso-8859-1?Q?YCBqcGe84e7KDoylE78jlRviqYfq7JSrGsx97V2Law7AQlN9k2lcE2XiFc?=
 =?iso-8859-1?Q?7x85CQAKf3nC8nh1JnbMclWw2VvCVEzAp4+0AKtUnEjYzC+D2Td3geUBuU?=
 =?iso-8859-1?Q?Xzzo4nirbQ/a65wZUivLCBQjgYR9BrJtEH+IuLikSPVgdVm/qUknBPHcw2?=
 =?iso-8859-1?Q?PFWrL3sSHMyg+zkppRXI8st5dUI9bzs7PF8AsGOLQmq5kS6uYIAPNXChqi?=
 =?iso-8859-1?Q?TtCZtTcyaSwk7WYShOqWj8ukkGETMv1QV8SPO6AmYNTr19NSvXvMIq6SSh?=
 =?iso-8859-1?Q?C+lqT6u7XdWK7axdP0oESzqHMSiBTn8vmhzBH8YwPWfFYxml3TlupksNCJ?=
 =?iso-8859-1?Q?9w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 076c1486-34b2-48d6-d3f2-08dad6f6297b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 19:23:17.2157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pojOigLkQzj+SoFfym9gCvj6y+UiDb6yLGSSp3WzOtQgRupECtOiq0BhogAZCe94yna4HphujD/qKqo0NXArJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-05_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=895 mlxscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2212050161
X-Proofpoint-GUID: NyFWCVNkvN34xCMQfgjl3xtGTiSTUTSm
X-Proofpoint-ORIG-GUID: NyFWCVNkvN34xCMQfgjl3xtGTiSTUTSm
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add more sanity checks to the VMA that do_brk_flags() will expand.
Ensure the VMA matches basic merge requirements within the function
before calling can_vma_merge_after().

Drop the duplicate checks from vm_brk_flags() since they will be
enforced later.

Fixes: 2e7ce7d354f2 ("mm/mmap: change do_brk_flags() to expand existing VMA=
 and add do_brk_munmap()")
Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index a5eb2f175da0..5d48170fc2b2 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2946,9 +2946,9 @@ static int do_brk_flags(struct ma_state *mas, struct =
vm_area_struct *vma,
 	 * Expand the existing vma if possible; Note that singular lists do not
 	 * occur after forking, so the expand will only happen on new VMAs.
 	 */
-	if (vma &&
-	    (!vma->anon_vma || list_is_singular(&vma->anon_vma_chain)) &&
-	    ((vma->vm_flags & ~VM_SOFTDIRTY) =3D=3D flags)) {
+	if (vma && vma->vm_end =3D=3D addr && !vma_policy(vma) &&
+	    can_vma_merge_after(vma, flags, NULL, NULL,
+				addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL)) {
 		mas_set_range(mas, vma->vm_start, addr + len - 1);
 		if (mas_preallocate(mas, vma, GFP_KERNEL))
 			return -ENOMEM;
@@ -3035,11 +3035,6 @@ int vm_brk_flags(unsigned long addr, unsigned long r=
equest, unsigned long flags)
 		goto munmap_failed;
=20
 	vma =3D mas_prev(&mas, 0);
-	if (!vma || vma->vm_end !=3D addr || vma_policy(vma) ||
-	    !can_vma_merge_after(vma, flags, NULL, NULL,
-				 addr >> PAGE_SHIFT, NULL_VM_UFFD_CTX, NULL))
-		vma =3D NULL;
-
 	ret =3D do_brk_flags(&mas, vma, addr, len, flags);
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
--=20
2.35.1

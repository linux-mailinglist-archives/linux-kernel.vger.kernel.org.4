Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D776674A58B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 23:10:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjGFVJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 17:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjGFVJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 17:09:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173B91BC9;
        Thu,  6 Jul 2023 14:09:25 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 366KOUWT021738;
        Thu, 6 Jul 2023 21:09:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=6DzxOy/9qaMCbA5JNqIwptJShQOE/54SZ3tq6Xd3pH8=;
 b=2+27+Pbw3hQ2yM3lmnuM4hZq1C5BrPFy5lSXtAwuRNe8B1i+MWs8JSgyDlRKtwPmwVSP
 I7VMWYEo5jtYxWniFVU+yRAoqrgpqlsnKotsniqWePh8XpK2TAZGLRCG1C5IhS9bgJfY
 BJVWvkbPg7ii2RKwhqc+TKBWeaEJOhltcs9zvLdHhtRf87XN4qT186suV6FHINgcvJl5
 GzS+5EomgViw5acxeVlvvzcf7Mgo6vbXkxqduQSis78hNXWN+SAv0lwZgUhAcB4avoQ+
 pNNfbZp+6XiFVImlr8rD+AE4OWPmeKIfxswl8bGivXLkOWhaRbBT4QocjcF/6V3VU5EL SA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rp4md83bk-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 21:09:02 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 366KoJIx033416;
        Thu, 6 Jul 2023 21:00:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak7sp5m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 06 Jul 2023 21:00:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lk+Jbur1Q99s82YNPbeZOIEpsGSZWHBLq9sD1ZBtEB5LlbK3KN49sgjKgfC6HKtbESUUDDkb1pqcMd/iLOkzKsz4TfVk/zaJHiOiABiosap6XolCJH9RjbH3fhw6dqBS+ykEGUXOtZNRVSXMZKtNamwmu1tr8wVjQsEGJPayDql5qmSpDd/O8RLcuNLyXPfkRw+TPCXfO4hvSC04T7PqYxeZKhfQyV0fLhfcUX37mgDEGywZ6Uf3fHnrNTnd2+EpnWh3JBz1j2jp+dvKzkvXsdeD9d/HgEwD9hQgg+q1tvgcarXRJSVnzmyqiE/kBFAzlcSXOMFtRTXHkURELMyxtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6DzxOy/9qaMCbA5JNqIwptJShQOE/54SZ3tq6Xd3pH8=;
 b=TRXXpF2OXydAObYPxTRClYdraoq2rhKL7yIL6p7aRuf5RWjS2A4DL0SrdBZ4MPccD6IAkJhs4RPS9iacEHaHHNe4nQdpWgCkb66wE33tAzhi2KRy+gxuHo21EbKHkCmPm4lcZUivzx37/iW2TiqqOJM+rJtM0tg7x9JablI4Psv1DSWoZRAJlr/s+m4pP7Ta53W8YUp8UQwoFLq6WYxe6cRZzxesJvyQYbHpizv5Dh5Szbj4AsMgahbfFBm1IEB/AJF4FC7xbV7hTkhpkY/xhbaFg/3gIUaCOPpMwiy3dN6uyX33H1GXMLr3l4VDyeCrDIVjO3xx++gkdlhSxcAaxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6DzxOy/9qaMCbA5JNqIwptJShQOE/54SZ3tq6Xd3pH8=;
 b=bAeJyuAA+IUxQ6Blp03RXVEHcP8jwZwA0Zy217Gn6N5/AhwreqTKUi17BBpf4yqKNjqfbmUC/5gCs5DH1MupWbHMr/wDoYgNTqcCYdL4hmwRxu6BVqAWcIuQ+YHPv0w6t+sOWh31y4DWVFCzHRXsxkn9o8zhKB9XWif7VmKvlIk=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by IA1PR10MB6805.namprd10.prod.outlook.com (2603:10b6:208:42b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.24; Thu, 6 Jul
 2023 21:00:27 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9%5]) with mapi id 15.20.6565.019; Thu, 6 Jul 2023
 21:00:27 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "david@fries.net" <david@fries.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        Evgeniy Polyakov <zbr@ioremap.net>,
        Christian Brauner <brauner@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v7 5/6] connector/cn_proc: Allow non-root users access
Thread-Topic: [PATCH v7 5/6] connector/cn_proc: Allow non-root users access
Thread-Index: AQHZrgwd5Uh3sQesl0S5mkJB0BWZKK+tMUQAgAAMagA=
Date:   Thu, 6 Jul 2023 21:00:27 +0000
Message-ID: <2B585919-6017-4496-B001-F6CEE8F35470@oracle.com>
References: <20230704001136.2301645-1-anjali.k.kulkarni@oracle.com>
 <20230704001136.2301645-6-anjali.k.kulkarni@oracle.com>
 <20230706201600.kkgf7urekwt4y7r3@revolver>
In-Reply-To: <20230706201600.kkgf7urekwt4y7r3@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|IA1PR10MB6805:EE_
x-ms-office365-filtering-correlation-id: c197e2ca-1107-4f69-3c98-08db7e640660
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nPeQLREgrfDW8itTNQ3lKBpYd3CLcKbA7Nd8P5GeMvS1kbs6ezAMf4BrowHIpwPr871ktRoCF6j2dlzlP7dYGbbWowUhxSMl3NEAM2pATPKsqtOSbI1ic3mXPnunnhm5s41GKZPixWNJJ1pQhHoGnrCeMCdG1A91f6EQK8WH6CO7sX8KQm/22UbBTh4utUkfT+FwRlAekZPKkAXnJO82q8mIv1ypgNwT8omkrOMEu8SDV2njU1Gvznhnta9gian4fCin/Hmvc7lAjz0gg0KUbfxFDAHnb8IAnGw9Vt1NgT9O1shP9ssdQWGmIgFjA19+iHzWcR5+KaC912SHjyd039we646+b8qw8jQhXqJDj6PLKHiYgpql+gGoFPivMk8MvBL8+Duzhn8oxsGSrD/qTVaAw2fSme6Wh8STbBQAx0ln7GIMVTMzXTyzKJubupgu2yibsKCob4SROVckCJuoz9Bpxm1QGLKueGdB4FCW0qEiEXBthQU8r+Z50wqWGAuS0dPrmsPAItIaOkC54hEazbT4xhyZHNOgJ5CdZYWticYhJzEqbUQVtNlDl8E3WpnVdpSIvKFOK+VB5gofeF81K6RD26pg9TBr96nfMnYyxstTmoIUAfbyJGMw203JIElB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(136003)(366004)(396003)(39860400002)(451199021)(6486002)(478600001)(76116006)(54906003)(37006003)(71200400001)(53546011)(6506007)(26005)(6512007)(966005)(186003)(66946007)(2906002)(41300700001)(66556008)(316002)(6636002)(64756008)(4326008)(66446008)(66476007)(7416002)(8676002)(8936002)(5660300002)(6862004)(122000001)(38100700002)(36756003)(33656002)(38070700005)(86362001)(2616005)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MrwD1Pe/yMbkupkrJPVsXzx597uJlI/V6OX+bkxQBVupGNHCVWT4CQi/y1Ro?=
 =?us-ascii?Q?b+gTWmFRQ152htYnU8YaGnWjwOiMXWqu7M7mvgWjUyRsJ1hJTuXrXIgcbwlg?=
 =?us-ascii?Q?sLmz15WrhE6HKBGfQjN4fFErdkstb69lCUjEgDge5fwe5M2NTFK9d0jarTxR?=
 =?us-ascii?Q?sVniPLHxKf9OnQQcqWE9h1wDS3Dtrz3LlCSgvo6g2SWJtm2hj4SbTI9i7vuv?=
 =?us-ascii?Q?PkycyvQzVV/Pnq8PsCG+9vEyZDnK5ZBoNal+SnNCw5ndNfj1pv0oSm2bUdba?=
 =?us-ascii?Q?9X0Z53nRAN7hCEzx71YC6KzFEXQTkzna6oS4fQX/UGkZApbH5io7rD+ZTCjh?=
 =?us-ascii?Q?VqzipovXoemUbkqARx5lO6h9+o0vwj5mQck2Sd1Yfdkji48ifgajtq3RwQDk?=
 =?us-ascii?Q?F4sK7e8gmteHONMHDqfBVnYJM5vf0shhzyXWyu8cm1ctWJ8FV006s6IJvOmL?=
 =?us-ascii?Q?BnIqbE5+uxJbWb/5mw+KpCMDsJDgn7Lnvda+JN1149cJ9NpWutawojvSJEVl?=
 =?us-ascii?Q?bdGRuGTSHORg0vPy5UeknStEo7mFDGhdSk0umTfa+jSGr5nzFhmPCDPWkKF1?=
 =?us-ascii?Q?W1ew0afQWXS3EzmMx93MQMDjsMkYLsjoJf6FizexAvTeLzDi36pWPjmUiQiX?=
 =?us-ascii?Q?tNQwOiZCofhcWYXdFASgv6DQ46DOdXlGCqWdrhcuJSLGcAf/hFc3S7N+06C8?=
 =?us-ascii?Q?PeGOcthB+xD2ZyqOZcnUFQFu/TRO0sYegimP4sCuGc+s2YJ7Or2fDA2Nz+OX?=
 =?us-ascii?Q?MqtEr/VWEBv6hOoqrzWC4PEuSWAUcNVzhGAdurrpoKLEqnnkZjOf+NO4Pw26?=
 =?us-ascii?Q?TbUByeJ3G3Po4FWgRAZnj25RgO1Facco5Z3BIU57Gi8FbsdRZ6w8ltdtGQQ2?=
 =?us-ascii?Q?wsmRUJO8wuW/RG5koq9kBzvTPTMnpSumGSK2+sbWE1UC1IacuQ2Qj37lN0jO?=
 =?us-ascii?Q?V8sJWV+Q20Kp3PS2jXXdd1GwA3beGEhAATdHlv/tu82a6sqarT3RCi9ptj3r?=
 =?us-ascii?Q?I5tUKvbbm85hdgi9UN6GpNiNGhj2bzWSF02ko6TovOgw/neBNyCfkhaCC2Kc?=
 =?us-ascii?Q?6TAwuHIURtyMqbJU8OpggrFW2MPgx2ZbzEqV4H9Te5rSbYCMaD+WVDGkMseE?=
 =?us-ascii?Q?xVnH9UExoYW/PoW/K+JRWZf8nsNqDiGue5qtKR4DyAH0aGo2ulnuajnd3tX+?=
 =?us-ascii?Q?85EdyEEWOGj+/Q9TLaqC+jQ2GTyQ+GY+GEJEBPdVmzJTminIzF+uffIAXszF?=
 =?us-ascii?Q?7A93llSq847arj9tymWQzxHH4tQjAkBhj7KsFmLIoW24d8j55IH1zbWjNCZj?=
 =?us-ascii?Q?V/77kajUD4PrgifBvBlvLCicN0gU/bRXUywPvq7y+r9zN0m5N9FOKfYUsf3t?=
 =?us-ascii?Q?+GvFlYU6IRMDcd/WgL9XS8uQ90p+CYpUNG7iiRaVY1ev+3OoTJEpSp8qdDV7?=
 =?us-ascii?Q?sKtdHmb4VZoJcrqyEYVe1s1rIeNOvFlray+hJJ7P2GiVGSAkccMHHBR959ZJ?=
 =?us-ascii?Q?hiTsc1KyoZWNP75nQWxcfbpcmpWD9c/8L43BMlUxyC4G4pkwn6pmlnZ8symT?=
 =?us-ascii?Q?3qcjjcG7thpgXA5BMzqlT6peCu5RcXilGzGsG0akhLoyNzbI7Sm4u0fUGW/l?=
 =?us-ascii?Q?DA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4C3364B44EA5AF4DA7A049C1E87F8D08@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?nobw5+rtlMHxoHBy2COg4qzJKgX1Qhz4rTZc0F7vSZBQdNOEpuh2pJbOenqw?=
 =?us-ascii?Q?bLcD4w75x0yU3FeeuVfi2PLaY02bHwzjG/mX7pCOh1PX2T5khTQzYM+Zo71f?=
 =?us-ascii?Q?SxPmrKuQhUPoMNBy98hmFANOdk1GfGizX+JKUf/vBnUCIRDAhAV7xpscO0bA?=
 =?us-ascii?Q?q8JOYMuyqZrN98t0RGukkCbN+QtP4XOhhRXJYXNDvl3OstJATqy44/CTYVsU?=
 =?us-ascii?Q?UbGaxZ28L4NGfEOszNkLNIjvf8c+43pQO92SxKFS/iRp/PTFNUcdb22lyBAJ?=
 =?us-ascii?Q?1HLsK+Mj8VYETq39QjOciZ1cDqrDi1S1zAahUvWRoimubV+p6FnrCEktTZpX?=
 =?us-ascii?Q?LzkgeJiqIXz2sYfOc04vTY1ygGs2h8sLEH2YGeIX/m+ceUhBSpRRbM523J5U?=
 =?us-ascii?Q?RXXk8aE4dluXvsGJXdgAb25SviEC0uONoidj1JsUOCU5933CHVdvgex1705K?=
 =?us-ascii?Q?3sZedhLX8Avl7G1ggE/bkrlsHmTtYRQv4yRVMsw6FmhYqDfUFDVYLcPO/+0k?=
 =?us-ascii?Q?GadZ6Ga3AVuPPPiUebcss5Jzo/1tUn37eYeKLWMp4xplD/9Ajo+kW5xOzRja?=
 =?us-ascii?Q?iYut5rO+YEOCNIXMp+SOo3GCkgWGacUeD0hNOJP/P60KSx3K3H6jHhCf1n5x?=
 =?us-ascii?Q?oCVufy61KqYuNMIdrTrjhJLxij7SZqeyqLnXhw2XFh9pSBzhxMZ6LINUuzpE?=
 =?us-ascii?Q?hakQeBS0Xo6uW9Q0SMmcfbri8TSD5XHTxqOPc2MIrUkR4OYLfCTCT7r+vybq?=
 =?us-ascii?Q?+PmVgoJ2PaR9bZtZcKCU0i8Fdg8w7JRuvzeXk3RZdMeRWeuA2k+tBWYVhTGz?=
 =?us-ascii?Q?zxg5R5VJRBCcsu1gbsjVoDSYjcu+g8zlrUN7VRLrQwS+nDmTRU7731DepF91?=
 =?us-ascii?Q?BR7g5EC+CbXNjO5H0/zxdjxYkRdKt1HAOteYw96Ib1fm7+4a2+krEGgHofGt?=
 =?us-ascii?Q?U6j1Ea4G5zKFSSPUKw0wo4IXEyQAegNcIVbdNiVT2Jmr+THbm+T/lFwEfPgQ?=
 =?us-ascii?Q?YSGwMT+BX/pum9N9L7Dgwhlci/2a3mkQ2bpCIEgAYJI/h75RIL3qFXCwao7Y?=
 =?us-ascii?Q?LB6/hMe015smHq8TLNAKzAfmEP0aOEnleIHcGl/CWLuAVL76524=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c197e2ca-1107-4f69-3c98-08db7e640660
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 21:00:27.1671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5HfUm1HlDIKFT+MsUu7frUVaGZsohaL+Zf+LQPBJPiLLqKlhSPn3cY72kRkNNw/5c4sspL0SG6ZEEynD96Cn7RFKf05x4BX1atAILcl2qr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6805
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-06_15,2023-07-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307060185
X-Proofpoint-GUID: 14bAjowhWcX0kjZn9Feo6UaVjZ5PaM1V
X-Proofpoint-ORIG-GUID: 14bAjowhWcX0kjZn9Feo6UaVjZ5PaM1V
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jul 6, 2023, at 1:16 PM, Liam Howlett <liam.howlett@oracle.com> wrote:
>=20
> * Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [691231 23:00]:
>> There were a couple of reasons for not allowing non-root users access
>> initially - one is there was some point no proper receive buffer
>> management in place for netlink multicast. But that should be long
>> fixed. See link below for more context.
>>=20
>> Second is that some of the messages may contain data that is root only. =
But
>> this should be handled with a finer granularity, which is being done at =
the
>> protocol layer. The only problematic protocols are nf_queue and the
>> firewall netlink. Hence, this restriction for non-root access was relaxe=
d
>> for NETLINK_ROUTE initially:
>> https://lore.kernel.org/all/20020612013101.A22399@wotan.suse.de/
>>=20
>> This restriction has also been removed for following protocols:
>> NETLINK_KOBJECT_UEVENT, NETLINK_AUDIT, NETLINK_SOCK_DIAG,
>> NETLINK_GENERIC, NETLINK_SELINUX.
>>=20
>> Since process connector messages are not sensitive (process fork, exit
>> notifications etc.), and anyone can read /proc data, we can allow non-ro=
ot
>> access here. However, since process event notification is not the only
>> consumer of NETLINK_CONNECTOR, we can make this change even more
>> fine grained than the protocol level, by checking for multicast group
>> within the protocol.
>>=20
>> Allow non-root access for NETLINK_CONNECTOR via NL_CFG_F_NONROOT_RECV
>> but add new bind function cn_bind(), which allows non-root access only
>> for CN_IDX_PROC multicast group.
>>=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> drivers/connector/cn_proc.c | 7 -------
>> drivers/connector/connector.c | 19 +++++++++++++++++++
>> 2 files changed, 19 insertions(+), 7 deletions(-)
>>=20
>> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
>> index dfc84d44f804..bb1fa5d66cf9 100644
>> --- a/drivers/connector/cn_proc.c
>> +++ b/drivers/connector/cn_proc.c
>> @@ -410,12 +410,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>> 	 !task_is_in_init_pid_ns(current))
>> 		return;
>>=20
>> -	/* Can only change if privileged. */
>> -	if (!__netlink_ns_capable(nsp, &init_user_ns, CAP_NET_ADMIN)) {
>> -		err =3D EPERM;
>> -		goto out;
>> -	}
>> -
>> 	if (msg->len =3D=3D sizeof(*pinput)) {
>> 		pinput =3D (struct proc_input *)msg->data;
>> 		mc_op =3D pinput->mcast_op;
>> @@ -467,7 +461,6 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>> 		break;
>> 	}
>>=20
>> -out:
>=20
> This label is still in use from your changes in patch 3.

Yes, will send updated patch with this fixed.

>=20
>> 	cn_proc_ack(err, msg->seq, msg->ack);
>> }
>>=20
>> diff --git a/drivers/connector/connector.c b/drivers/connector/connector=
.c
>> index d1179df2b0ba..7f7b94f616a6 100644
>> --- a/drivers/connector/connector.c
>> +++ b/drivers/connector/connector.c
>> @@ -166,6 +166,23 @@ static int cn_call_callback(struct sk_buff *skb)
>> 	return err;
>> }
>>=20
>> +/*
>> + * Allow non-root access for NETLINK_CONNECTOR family having CN_IDX_PRO=
C
>> + * multicast group.
>> + */
>> +static int cn_bind(struct net *net, int group)
>> +{
>> +	unsigned long groups =3D (unsigned long) group;
>> +
>> +	if (ns_capable(net->user_ns, CAP_NET_ADMIN))
>> +		return 0;
>> +
>> +	if (test_bit(CN_IDX_PROC - 1, &groups))
>> +		return 0;
>> +
>> +	return -EPERM;
>> +}
>> +
>> static void cn_release(struct sock *sk, unsigned long *groups)
>> {
>> 	if (groups && test_bit(CN_IDX_PROC - 1, groups)) {
>> @@ -261,6 +278,8 @@ static int cn_init(void)
>> 	struct netlink_kernel_cfg cfg =3D {
>> 		.groups	=3D CN_NETLINK_USERS + 0xf,
>> 		.input	=3D cn_rx_skb,
>> +		.flags =3D NL_CFG_F_NONROOT_RECV,
>> +		.bind =3D cn_bind,
>> 		.release =3D cn_release,
>> 	};
>>=20
>> --=20
>> 2.41.0


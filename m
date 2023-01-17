Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC38666D465
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:36:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjAQCg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235300AbjAQCfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:35:25 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EAD2B60D
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:33 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09URb005537;
        Tue, 17 Jan 2023 02:34:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=FHBfff0pz8udEyTLfQgLPM5yOGpMVDTo1aPpd36UeFU=;
 b=z7RPACG/NKXAEza0Mo9wFIIXXrbqa3+Cr66u+ZT8MROOC0i86K6KT/d5R8Du0iG72HLD
 RbO+Exv42xsvQxToZd6dpWt2pqh2LUwRlackKDmkQ3/jD+8T3C5qI4HZC2iQGC+V+hZ9
 WES9TbgNYy/EUq3buEhUQ7uRapvXnszeJYj08vxdfZQWH1NBUbJjcFdw7DYYxcO4G0RN
 ZLdUHI6Hg9olkeC4f7JxlFaTQm7aGovm3eUhPPLTMtZUjZejT6Z/I120exiuj3NrLiNW
 C4ohEANjQ4xSJyDW+HpU5fJk+X3biSkjT65Df2ROipwziCh2MO8Ow1fO7oGUA5b3aFTL Zg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5ed-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:27 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30H1b4BV028327;
        Tue, 17 Jan 2023 02:34:26 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxqn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVtamiMN2+FTSvirk/F3bQ99HZnrgNRRAElL5DbMKnMLag4+26VEvOmzht1J8//0iDTY92aXfmlWCxr2Fr6qssuu2ojMipPm5dYTJ2HdvZ7JiwQph5gecLL3WyEypF/SkBan1JoqSg8IwldEjkxYZ3itkHhirqo7j62isa2/bOe0g+sm8CtKAp9Zq2HyzoWhMCfm30QM1cp9Y3cCmprwdwjQALq2chxh6qmy9iuWtjSI1CcFp1HJaGaSoQCrmXvvAzEjjfL79ob3gYmaNY69oHfUYp26nmshMWGQWSD2fVf/9G/ZUCTqTndSrVcQTNpbIgrZAi2P8S7S/RmEE8LJpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FHBfff0pz8udEyTLfQgLPM5yOGpMVDTo1aPpd36UeFU=;
 b=fP0gQF6qriT9tHfQzYqkjC4blhc5x49q5CVfj5TleeQCPyEMfW4wmXUkfkZRMg02AYgjkwlqqUW+5h8Vn+cocmyseGIDm5K8GRlQxSTA7FOk9KoBzoHIPIsL7wWIer3WH48htd0EbKaHJSWP6CJvLsRiHCY+2lqleQ83ifciJBP2HuQcPTTtPYWZQUNjJRMEYJbdn8Ldqae+pNNTna42tIQGYD7UzWv3xiRBLV7ikRJOUhWF5kSO2mwUstRSeFZiwGmc0yCA0UZtf/DcoFwwF2Sg0lymfLTboZs9vaIlW9UxgkvEqWe3RaL9tf0GB6XYvqCxBAw/6rWooJYTKF6kHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FHBfff0pz8udEyTLfQgLPM5yOGpMVDTo1aPpd36UeFU=;
 b=eTcblPzVpaku0jKPXxKf4LQLKKyAAqdYankP+9C89J1dRixHb2gKxe8Uc5fM3EzIENpvLge4BMV45Ou8832v3B+lCJPErJ7mjywD+xRNC6St6/gzVHab7N80prX7kEx9K06PwsLdAGvqHtioeFnj0uTcr/BCHcg3ZnTZ2T5XQQQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CO6PR10MB5538.namprd10.prod.outlook.com (2603:10b6:303:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Tue, 17 Jan
 2023 02:34:23 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:23 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH v3 28/48] nommu: Pass through vma iterator to shrink_vma()
Thread-Topic: [PATCH v3 28/48] nommu: Pass through vma iterator to
 shrink_vma()
Thread-Index: AQHZKhwzvG/+hOM+tUqNzGWiXmLirQ==
Date:   Tue, 17 Jan 2023 02:34:18 +0000
Message-ID: <20230117023335.1690727-29-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CO6PR10MB5538:EE_
x-ms-office365-filtering-correlation-id: 9b11ab40-1528-44fe-89e4-08daf8335841
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Hx9wwg9o60VVu88hU/oFOKTT+H5IPxmVxq0/o4CoDpG3cBn4o3M4JLMoAwx0tBueTldLKEp/wT2nCPKLW2zXH5vTDiWvtnurVMQ/j41j1MJIyBFDt5D4aCLzjyWFrbmIvzIBb04PG9BWWTQyqF9bg0N5F8ExY8qf9b00e2Js2yzKVkOodbEq5vtJcQ95nyXN6ZZkgMjuvCenHge2n094OLbuCl9Bd1LpnaD0Rh/VEBTWe+s89XJukVL9yWfZq5nsLLI7MlNd6DdXXYHcctLVXsC6Bfu3ohnva91p4mHNbwuUfm/Tu0i78LXTxLP1FgiyJpJRhgeDCB26CWebLyFD4zIgaShefrP086HvnALcNVBFlYTl6ubqrWkksReZcG/H/n5qG+jJLgrjtrjoHafAg/VcSd1ogXyJJdhUjNmtYjGiH0S2CcwLdPNk0qBBzK5Ulqr7IK7R6u6WLS7n+PIs4yTOx+427SGxF93pirXOYrvqetPJ+jc9zAXK8zLvW9maGv/ccchrJwSLTlAA3deviH7JE/0s6jG49VNt7YRPBKoZ1ZfeCrKnOeOSi9xRAY8qxSuxckNl5frZ4VG2qhKsLxrxLMGw/UrWB6yoS+ZSs84Jou8H9ozDSaLryU8cf/9tdDY2DidQWkwrJCxdkUO0OFBHX48uaN2IUm4Qfz1xHGxANlmhAWb66TE5eOX2NcOuTmqgqdOdpDSFytHUOq8EBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36756003)(91956017)(86362001)(8676002)(6512007)(64756008)(4326008)(186003)(76116006)(66946007)(66556008)(41300700001)(2616005)(66446008)(26005)(66476007)(316002)(71200400001)(478600001)(6666004)(38070700005)(6506007)(110136005)(107886003)(6486002)(44832011)(122000001)(38100700002)(2906002)(5660300002)(83380400001)(8936002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ip6SJYeJRrEsBWLuCVSO/oPYWlY0fN5XOUMUp1vRFUPdMNISJRzIFfpUhw?=
 =?iso-8859-1?Q?c2Z6doXLNSaltaIUdtoIWdg54aU1TbGt5MsniDOWKqkkPs+ajCwnnlsVlI?=
 =?iso-8859-1?Q?WNjN6LSuox9cRK6t0mB5weZhDsjHwlIX1/yd9nwGwHyTiaFVRmaGYeWQuj?=
 =?iso-8859-1?Q?wxx23W6qA8cwx/Bst+dYf5Si6Cn0Ccx2d/ACSYntYQlh+a4+TJvhkaYamd?=
 =?iso-8859-1?Q?Rsgm6ccLjnyoQKbyPeX3E0zqNh6g+bQZNU58b4PDKsbZNKu/fOWHvkUp6V?=
 =?iso-8859-1?Q?+W9A523dHrOpElnChNMeAIdgDuL8Ab6LMibsfsGKWAkWEJpzWL7qZ1yDnY?=
 =?iso-8859-1?Q?gpm6p9B5576Ei5bXhQf8koPpCqV6n2fNgqSa9vMA1xCzCjwakgVBHAOycw?=
 =?iso-8859-1?Q?fbVWgOMAVBTStNW2yezAJsgO2lfnbTd/fAqnDc9kn9lF98P3OEXrr/suO7?=
 =?iso-8859-1?Q?sRycit6qSutj3SzBIKNX+I0AgaB4fBpzEBffT1o5xUVhewaAgvgab7de9P?=
 =?iso-8859-1?Q?+ZByER8gAA1plCl0KG2gFsg+AzrcZZEkRZuR7NTmitcQBmHsaIkGR+BMjf?=
 =?iso-8859-1?Q?jIuBnvYwS8lAJnJCv/mR9wKebzjSH97xGIh142dfz6oz7jlnvDyycaaTVp?=
 =?iso-8859-1?Q?dqb2CJSJqxo9CwEBsoG5zqkmjABWl6yuZhEGHjy01+s8p2Hk8zZujlUnVA?=
 =?iso-8859-1?Q?/rM880K9MYlDp1Xj0/keW9vlBxD3avbOCVNZR3A0nBcrJ19k+jwsoAmqe0?=
 =?iso-8859-1?Q?XdZv4T8a3i05Gj4n2BHpE8HkR8RkliQ/9WB2aQXFiJ1zvGricvwtF7hvOj?=
 =?iso-8859-1?Q?GHO3Fmv49X+Ersa8UlxyihvEbYDi7KxbkdVmcFngvYCHK87aSbLAl1yfr1?=
 =?iso-8859-1?Q?XNit+qU6QMf3VHoU6ErGaLsE4w1mBtPIEUdggEYOakLwPAqjfgQhXkXMcJ?=
 =?iso-8859-1?Q?FWarE8U7QFrsgp/1v6Ay3q04j5Jqw2JkB5L0fXvyae47oL5si3QH5HgYkU?=
 =?iso-8859-1?Q?tjGqHsjZJG5b4zuUuuGBTD4HmuoOpHIFU9gJxhY8m74U4XlhyVFmT0bP7N?=
 =?iso-8859-1?Q?jRDbOMgLkt85hu57dRsqJpblzO22D0t2w8kb3Nn6qw/uEOzFmFAN4QkqvK?=
 =?iso-8859-1?Q?yVfGInBQEjx1Uo2+vywhZieSItFc8ZBThGHNcc4iKhhmB4NIV0sQBpVDpE?=
 =?iso-8859-1?Q?5YTWUJ6C7l51Ga5QyJwwdS+O4sjZ2X9i/H4r1rODEMiUL4cCJsvCHQP5tN?=
 =?iso-8859-1?Q?5Q1OATrcmNYfE6kDiivMJmxwMpSs+DYRAdJiTvoAbepL74FshU7Fsm/Kzd?=
 =?iso-8859-1?Q?Y9GJbi498S0Oh9gooIjQKuiXEig9aWKOmiLK5VXe/bw7WKuqi3KrJmiFZ3?=
 =?iso-8859-1?Q?Zyw8f084ZZEP7UM39HrylZnIF2qpCdGY5N2OpGjBEknhjEouFQe6HtPjsI?=
 =?iso-8859-1?Q?uqCe9tgceFL33dck/3JgxWklzdIjToJWNVZRP7cVpmSqOPTsTpt25Blxze?=
 =?iso-8859-1?Q?1cO5QsQGLwCcZDENq3uPBUBN5ocW4y6RVq5H6hyy36zEcr9hIiAVRnmPuZ?=
 =?iso-8859-1?Q?pegEeNpoN5dScXgQcFX9HEHvWMR/f5Mi4E4DmbtdF45QHsTeBVZQkDY8ya?=
 =?iso-8859-1?Q?gMxye2UnhGiYOaogmKgeFSe3JxPYzS8AnhvSIobe/mzc6n2IkeW/PMTw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MeYfpMhUicwMV8w1PGUpkfPCHuECRpPr8icORh8Rn5Xn3iO80r6FnIzqCeKVeLPXU18/yIndg0XduTnO4Y6/4oc38njuQ74UksK7oPjJmy9OXeAafhClTrxzyU6Gemh0nQbyM1UvQWGJ/oz7qtYwZx5KofNS7a6AkmrRY7VCMPsx6SChakjqBUNWiM7CEuJSQYiykw8D5nUrLdVH92eRjPDJ4D9a5qeTi5/q3Td/yySLsowFeaiSvoBOONjK0FtabRu7wos9aO6K1hPHqevCO1kfxJG/z1A0Pt9IetrSMJY3kRyrJEUWYsDI5xMsI+5W52IznhpTkThPeAWCQCybFfcuDNKC0hyfWoCLFq3hsr/1I8R2qNl8u9GHZDvvC0a8gaHNlH4zbkXaMvCa95xsx+5Q7G4Dokj+hdCYgJIOVh1huOyI0jE2flHe9c2PaoF9DAy+h0Ml69ioEKMcZku98l5DVtNXNFusVHXab+rd+v7L3La5i7hvyYu1Ws9bScYK4SbMMlis9KlQ3f5aQdMneiuJwTdLHsQaywrt8iu96z4l6GK3ywpvji+TRBDfzoaSLqQN/n7YVuzSmBHvKXZJofKPUdEtdH8V/10wHS1N6HDDtZP5kYx+a5opSzQUpJ/1cPeSRHxxpmDPOmwQ8JJuLCLCnzJd7z/2W4+LCmmTPzuUpC15tv+0MXFOi+CPKuOpWdYZUhJXLiHyvwq3F8wgDH3oAoQ6/Twv2iJkvsgY3Ehz5LzrEezkGYqusBhZOl2n9Oo7QI8L+yCHPoFIXuHprCSkSPyX7NfAIBh63JhlaJMEIjUPCnHYq8SxTdFoYuE4bDg+/6Ja28YU9pvPf/S6NO9HvBy+KaKnnsfwHhBl+33GyhuKJ6FdVPFW850dPGOouK8dG5g/psjUcJj7hrtJZg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b11ab40-1528-44fe-89e4-08daf8335841
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:19.0153
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X/w0jq/S4OSSd2jMdauNmhzWeDEBI1dE3JXeB3UF7C1v+plh5BLCTNdgcw3joLd5fOSlCX0xvkxv++Z2lfN/Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: ulaiPH1Dy-jWxrrBB1BmXEGu5Hsu8VTP
X-Proofpoint-GUID: ulaiPH1Dy-jWxrrBB1BmXEGu5Hsu8VTP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@oracle.com>

Rename the function to vmi_shrink_vma() indicate it takes the vma
iterator.  Use the iterator to preallocate and drop the delete function.
The maple tree is able to do the modification easier than the linked
list and rbtree, so just clear the necessary area in the tree.

add_vma_to_mm() is no longer used, so drop this function.

vmi_add_vma_to_mm() is now only used once, so inline this function into
do_mmap().

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/nommu.c | 63 +++++++++++++++---------------------------------------
 1 file changed, 17 insertions(+), 46 deletions(-)

diff --git a/mm/nommu.c b/mm/nommu.c
index 595f942c6101..f892af0a6ca3 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -560,44 +560,6 @@ static void setup_vma_to_mm(struct vm_area_struct *vma=
, struct mm_struct *mm)
 	}
 }
=20
-/*
- * vmi_add_vma_to_mm() - VMA Iterator variant of add_vmi_to_mm().
- * @vmi: The VMA iterator
- * @mm: The mm_struct
- * @vma: The vma to add
- *
- */
-static void vmi_add_vma_to_mm(struct vma_iterator *vmi, struct mm_struct *=
mm,
-			      struct vm_area_struct *vma)
-{
-	BUG_ON(!vma->vm_region);
-
-	setup_vma_to_mm(vma, mm);
-	mm->map_count++;
-
-	/* add the VMA to the tree */
-	vma_iter_store(vmi, vma);
-}
-
-/*
- * add a VMA into a process's mm_struct in the appropriate place in the li=
st
- * and tree and add to the address space's page tree also if not an anonym=
ous
- * page
- * - should be called with mm->mmap_lock held writelocked
- */
-static int add_vma_to_mm(struct mm_struct *mm, struct vm_area_struct *vma)
-{
-	VMA_ITERATOR(vmi, mm, vma->vm_start);
-
-	if (vma_iter_prealloc(&vmi, vma)) {
-		pr_warn("Allocation of vma tree for process %d failed\n",
-		       current->pid);
-		return -ENOMEM;
-	}
-	vmi_add_vma_to_mm(&vmi, mm, vma);
-	return 0;
-}
-
 static void cleanup_vma_from_mm(struct vm_area_struct *vma)
 {
 	vma->vm_mm->map_count--;
@@ -1211,7 +1173,11 @@ unsigned long do_mmap(struct file *file,
 	current->mm->total_vm +=3D len >> PAGE_SHIFT;
=20
 share:
-	vmi_add_vma_to_mm(&vmi, current->mm, vma);
+	BUG_ON(!vma->vm_region);
+	setup_vma_to_mm(vma, current->mm);
+	current->mm->map_count++;
+	/* add the VMA to the tree */
+	vma_iter_store(&vmi, vma);
=20
 	/* we flush the region from the icache only when the first executable
 	 * mapping of it is made  */
@@ -1396,7 +1362,7 @@ int vmi_split_vma(struct vma_iterator *vmi, struct mm=
_struct *mm,
  * shrink a VMA by removing the specified chunk from either the beginning =
or
  * the end
  */
-static int shrink_vma(struct mm_struct *mm,
+static int vmi_shrink_vma(struct vma_iterator *vmi,
 		      struct vm_area_struct *vma,
 		      unsigned long from, unsigned long to)
 {
@@ -1404,14 +1370,19 @@ static int shrink_vma(struct mm_struct *mm,
=20
 	/* adjust the VMA's pointers, which may reposition it in the MM's tree
 	 * and list */
-	if (delete_vma_from_mm(vma))
+	if (vma_iter_prealloc(vmi, vma)) {
+		pr_warn("Allocation of vma tree for process %d failed\n",
+		       current->pid);
 		return -ENOMEM;
-	if (from > vma->vm_start)
+	}
+
+	if (from > vma->vm_start) {
+		vma_iter_clear(vmi, from, vma->vm_end);
 		vma->vm_end =3D from;
-	else
+	} else {
+		vma_iter_clear(vmi, vma->vm_start, to);
 		vma->vm_start =3D to;
-	if (add_vma_to_mm(mm, vma))
-		return -ENOMEM;
+	}
=20
 	/* cut the backing region down to size */
 	region =3D vma->vm_region;
@@ -1488,7 +1459,7 @@ int do_munmap(struct mm_struct *mm, unsigned long sta=
rt, size_t len, struct list
 			if (ret < 0)
 				return ret;
 		}
-		return shrink_vma(mm, vma, start, end);
+		return vmi_shrink_vma(&vmi, vma, start, end);
 	}
=20
 erase_whole_vma:
--=20
2.35.1

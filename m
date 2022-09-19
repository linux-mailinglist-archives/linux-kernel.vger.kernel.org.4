Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3341B5BC30B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 08:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiISGny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 02:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiISGnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 02:43:51 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F721CB19;
        Sun, 18 Sep 2022 23:43:50 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28J0xAqg006382;
        Mon, 19 Sep 2022 06:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2022-7-12;
 bh=ntkzN8OWymI98+3Q3N2LKZwx95MMbKwS8ldFVKhr+QQ=;
 b=t5ZMmlpRJ8Qm0ndn6mCfejfveIPZe1o4uTyIVgJgAOwqvEleu9+Da6cou9tcDYyjiac4
 6+9UQYi8mtAxsPzSvcxVW/5Wm/dK/GExukcn3qxpNhG70Np+DoQOhhOpGiZebNdOrAJG
 xVJeuVZcSPppCPzTzQIANsafrZLnCMp/h94s0kZZPluDehSPKyL9CEkHAzu6YDj4pVV9
 yyiLh6LDl+2jRcJgqJ7vcr9TTiZJEmDl3F15ty9PZbUSHS3YjN8YUXWOjZNkojhSIM9z
 CONqMWVDKJD15U0hzzGkN6wUnvn0UKyIi+txTj1NRQhUVHUA0tzw80JeRDbPIPRKNr8r GQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jn68m2tv0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 06:43:30 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28J4gf41010896;
        Mon, 19 Sep 2022 06:43:29 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3jp39nqbhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Sep 2022 06:43:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GoghCCwdsCxANMtFJu93+1Hj/KEegTR7zqbucdU/p5U/MnDDWD7KW2N1Zm8BHrhYUpY4A5aCw++iifLcTNm28dOmltlFzOPGl34t3cQdlkNoYXCnBIMu3K2hF8skbFxKy7D9kBdl8AdFSmeGoiPe4oyX8saKVbfEseS8EDdV+t9ORsFrASMRj612vgZDayq+upLIRQIhDT71WISmYdbhONikwhMQ+hmVWgf0tWv4LvjzpZS8oUh8BGioYJMxvz0iLB4eztOePrvsFH9XQGXpERiSg6vtluZgJ2i800/5ZPErwvPljamcoufdTNv9QMiQ+MvWa6Wi/bpw/NrK76z8FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntkzN8OWymI98+3Q3N2LKZwx95MMbKwS8ldFVKhr+QQ=;
 b=nN+e3Qpg3xwMLSCEGdLyR3ISzFt5yuWJhxVBsmryMqLuhMyd88C+kWOoW9R3JL5do1ki/U3xX7g1MkoI9Q2sqeCAHuN0JIgxDJ9OHhxl6Y12NF6Ja64olaEECMHdYfY0ujlzeqQv8q6N/IQZPA++EO41IC8uxKQn+bK2D3kJF82TOAXl86I5gxKlNwG3W9KKtTe9rCi9tuRDyGXL4f9dKENhxLuu2F9cvD948nHuhSrRNDPLiMRbncAIvewIIUfBpM2Td5r2EQgchIbPm/+zFVV6lrp8KUOicWhI0kqsa+TNsU9sgM5kFPju4kZ5VMttBQJ/MUmAMJ/KKwLFJxdnXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntkzN8OWymI98+3Q3N2LKZwx95MMbKwS8ldFVKhr+QQ=;
 b=lGjwUvMQumTar9Jp8zM+kp8ReJU58hRJNJyhx/W4Pj6gxW1mKpXeTamDju5go5eQqV4j4aOwwL9xzHLyi7du9Ix9fb0dFdCPfZhxtzzqDvXKQmJGuJqYHK8/YETMl+YJ/Rag4bPGN60dhkuacIWeVP/I6+k88EyI51kz+B0RwJY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5244.namprd10.prod.outlook.com
 (2603:10b6:610:d9::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21; Mon, 19 Sep
 2022 06:43:27 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::a493:38d9:86ee:73d6%6]) with mapi id 15.20.5632.016; Mon, 19 Sep 2022
 06:43:27 +0000
Date:   Mon, 19 Sep 2022 09:43:19 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH v2] crypto: marvell/octeontx - prevent integer overflows
Message-ID: <YygPh/RTMxucazLl@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-ClientProxiedBy: ZR2P278CA0030.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::20) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2365:EE_|CH0PR10MB5244:EE_
X-MS-Office365-Filtering-Correlation-Id: dc2562f4-05b2-433d-52c3-08da9a0a41b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9pdmlrXtjMlfcH/wT3HdIu5jEYCuPWYgBdcTVpAYbsvyD6V83GqgA4f+3d25IrB9UeirgMu6IIfFGhZwc/2w3i+Cyw1J+jxPNC33NfO3O+bHtQjLqIJ5T86G6k1OkrZFpwpcaNGlaYY7ZPeAVPOc0pjmzypngkIjB9MHE0PGbkPyMWE92DGCCfWUA8Mkrqb7FtksHTwFgYjc8VspMMEG+fZVobvYC9WuRxqKHOVUL4JoYmTpEwpL/VVZBnJhkiD2z82uoak0Mcb+YDhWfsUusbH7D9oLh2o3Yu5Q6TUrB+XddQTO7PQedgQyyymFEu2XfyxInOs+CMRize/7rWeVr90yJnqmDtC4JaZnCCYNPeTIRML0mnLtnqdSwZSZTN2+WcXAmAgbtENBp3/uSPwycpIlnNJlbF6wRm4zYAp6yPzKI2vPNeb8h67FiLVUX6ZRa04NGAsu+LrPgiVlBzJIhDGjvs12laykR7VUWgRo5cyF6hjX+x9VZmMC3J94Vp4DV6AalXh7bmhKn+uJIT3QGlRZ6ULs89DMJQYTxo8KyR4WP0PHrTGn6Ba0+wnxEzTEMyAH7tRXmkRlgWaoDi6JZFHpOSTdtqiZUN9E5E2ErBsmrqdT66ruK5xf7xX5e+ozhdljb1IQ5PFNHK7WSUWgmKSogwNY3763RjQ4daxxz7CP5l/WC+uEgu/I+B4921zV1Rn0YSijbWCXXVPQ5zaClA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(39860400002)(376002)(346002)(366004)(396003)(451199015)(66946007)(66556008)(8676002)(4326008)(66476007)(5660300002)(7416002)(8936002)(54906003)(6916009)(86362001)(316002)(38100700002)(83380400001)(6666004)(6486002)(6506007)(41300700001)(478600001)(186003)(9686003)(6512007)(26005)(33716001)(2906002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?34WuTY+EBTiHdiyL22UuaH1mdZVfsk//ZyW79WRCtmQiZoaZTusSiux8qwTa?=
 =?us-ascii?Q?6ZwYD/+V3F6Ha/2Nqj0FyDTH5A9YOqkMez868dHZzQFNSh7oUSFZ6zPXA/ZR?=
 =?us-ascii?Q?8MfJGskaIXB5cN91gNlTUJD//JARqSQJmUWqYoW8H+YdQxzN1tssFqT8F8rv?=
 =?us-ascii?Q?KJjUUs6SuKxRN9mk1PpWgd7+geR8MPztlcwJtOpYmx9PfSwvCK9yLUd5aPQ7?=
 =?us-ascii?Q?UzWMS7BFZ8RKAVoeR4eKbeMFapmT5dEEYk398fw0CbzQcFnJnFCX0V+nZ/7o?=
 =?us-ascii?Q?xtddo2q14qxd0jtfg3rFkFD8whz26tzJZmJ9Kv4llV/2qdnk5YADfmkOVyku?=
 =?us-ascii?Q?npn2s8I2yxNhk5nHRYtXA5lcXgq5Zdoc378jjvnmWnlrFAEYprlWiuCg7Tt2?=
 =?us-ascii?Q?qEVQXi2gQ2ZP4JEgUgtHBvXuptMEY3Dy5FVY4MH//6wBj+O7gfp7bGLh6eLV?=
 =?us-ascii?Q?jMu33eyHPCNzJ0GEcGUjc3V5E4l4ACkG0KISnbbuTA8Wuj6KXUPvYT00/4uZ?=
 =?us-ascii?Q?Vx9IxO/S8GO2eYs34A3a92Z7aQxjiXdi/Ko7eAjGtZ97FNZRXz8LrmSCEHnv?=
 =?us-ascii?Q?Ti5+QIFRgW0P8IGEWhApfk9u7hmzmWnOdq59GNo5zMQ52HPdGmRwU2bQaTiq?=
 =?us-ascii?Q?dKoOMb/FIRmgyY464g/McSeu3XdD4ShTvsSBJ4x+6CmLAVBb+9kvj9TBSsEE?=
 =?us-ascii?Q?h0vBbQLbf39LBbZZtDBdBnzrkej3SrrTA98GBQbMcNmSR0827PCwKh8zm7gG?=
 =?us-ascii?Q?jCeM2pHxR7KpVnzelSpc+CGaAscAIeKHPuGhwjOgADH9xKx21YzQ34/H1zOe?=
 =?us-ascii?Q?TySq7hDL3v7EAJ/1VXuaXZNn7yx3Lxvpc0xwI/ldVG24uYD+xFUPOIZby6+F?=
 =?us-ascii?Q?0PtwS1wir5ofzDO9QhzpTCJRrP0fTHpQSVnSAbPwAVl64I/B3x35QXzRxidv?=
 =?us-ascii?Q?SjUMO1nSpoSkFf4C9v6F2eX57ShkZHtHljSbghM8Jf/3r+ODyLUJANwDVN/I?=
 =?us-ascii?Q?pU58RDTYTlJjJJEWamHEFmwa0zyxT91bWVJXnUPouBgDeXa3U1S2kETkcxNI?=
 =?us-ascii?Q?UaR8TR+/LaX+/zzfcm7i6GLYL4qc0fuwX8ub+3vPllGL+4zZ9pmYQTJXPtP5?=
 =?us-ascii?Q?0WKQEJ+Xn8elLF5r3sUTFoL+zLztNOQkR1qzIzKz+jxRbQq8ALUukRxvY1wv?=
 =?us-ascii?Q?eB5ruzjlvBzYcJknqVhq/Ln7o7nkfQYGXlE0sahQQEooIsXh7iLW8d1tfEvL?=
 =?us-ascii?Q?tI91BQ138pUXMNz6QB6m89uEY9AVcF1e4I59UAipzhHX6di8vlrrAA9Ml93T?=
 =?us-ascii?Q?ctlbykFPhwlTYRuQVuyBC1N2/YSZpSDLylDLy96dlUW8rpDKVPiaF9DPA0nT?=
 =?us-ascii?Q?XMpGyYk6X4KwkBMXzEjei+jxq9M0m4kTL9IemLb2tvhvu4SPxlOXq83J2sh4?=
 =?us-ascii?Q?vus06PolRNriP5Pwrsf9690IK2bGvCS7UUqcS7SF8pCXB6nqOXNweJfg2be3?=
 =?us-ascii?Q?XmaVXcrA33q4F54obSyPUw4qWMvQmbK+xuMNHOneXnIbnp85qD9CrdLfckar?=
 =?us-ascii?Q?o1bcdf36aqE4mQOn5sdGNj0mPs9lrz0uKHsXE3vjxzJYdNASpvBD/VlUzqO8?=
 =?us-ascii?Q?Rg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2562f4-05b2-433d-52c3-08da9a0a41b7
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2022 06:43:27.0323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+D+CVOXOWLZIAzGeiFznJuUXrz8lwfJ8xaaakQzUXwfTTUcsrSdkdOmze7mKi74vDQz/9BUKLXuiuizhOd7eoCGNfsm8/XyL7JCD4aAFgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-19_03,2022-09-16_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209190044
X-Proofpoint-ORIG-GUID: 4H55CWgb0UwM4ai1RKdh4nttAHqygie3
X-Proofpoint-GUID: 4H55CWgb0UwM4ai1RKdh4nttAHqygie3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The "code_length" value comes from the firmware file.  If your firmware
is untrusted realistically there is probably very little you can do to
protect yourself.  Still we try to limit the damage as much as possible.
Also Smatch marks any data read from the filesystem as untrusted and
prints warnings if it not capped correctly.

The "code_length * 2" can overflow.  The round_up(ucode_size, 16) +
sizeof() expression can overflow too.  Prevent these overflows.

Fixes: d9110b0b01ff ("crypto: marvell - add support for OCTEON TX CPT engine")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
v2: In the first commit, I accidentally added some unnecessary checks.
    Those were only drafts and I sent them uninitentionally.  Sorry!

 .../crypto/marvell/octeontx/otx_cptpf_ucode.c  | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index 23c6edc70914..df9c2b8747e6 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -286,6 +286,7 @@ static int process_tar_file(struct device *dev,
 	struct tar_ucode_info_t *tar_info;
 	struct otx_cpt_ucode_hdr *ucode_hdr;
 	int ucode_type, ucode_size;
+	unsigned int code_length;
 
 	/*
 	 * If size is less than microcode header size then don't report
@@ -303,7 +304,13 @@ static int process_tar_file(struct device *dev,
 	if (get_ucode_type(ucode_hdr, &ucode_type))
 		return 0;
 
-	ucode_size = ntohl(ucode_hdr->code_length) * 2;
+	code_length = ntohl(ucode_hdr->code_length);
+	if (code_length >= INT_MAX / 2) {
+		dev_err(dev, "Invalid code_length %u\n", code_length);
+		return -EINVAL;
+	}
+
+	ucode_size = code_length * 2;
 	if (!ucode_size || (size < round_up(ucode_size, 16) +
 	    sizeof(struct otx_cpt_ucode_hdr) + OTX_CPT_UCODE_SIGN_LEN)) {
 		dev_err(dev, "Ucode %s invalid size\n", filename);
@@ -886,6 +893,7 @@ static int ucode_load(struct device *dev, struct otx_cpt_ucode *ucode,
 {
 	struct otx_cpt_ucode_hdr *ucode_hdr;
 	const struct firmware *fw;
+	unsigned int code_length;
 	int ret;
 
 	set_ucode_filename(ucode, ucode_filename);
@@ -896,7 +904,13 @@ static int ucode_load(struct device *dev, struct otx_cpt_ucode *ucode,
 	ucode_hdr = (struct otx_cpt_ucode_hdr *) fw->data;
 	memcpy(ucode->ver_str, ucode_hdr->ver_str, OTX_CPT_UCODE_VER_STR_SZ);
 	ucode->ver_num = ucode_hdr->ver_num;
-	ucode->size = ntohl(ucode_hdr->code_length) * 2;
+	code_length = ntohl(ucode_hdr->code_length);
+	if (code_length >= INT_MAX / 2) {
+		dev_err(dev, "Ucode invalid code_length %u\n", code_length);
+		ret = -EINVAL;
+		goto release_fw;
+	}
+	ucode->size = code_length * 2;
 	if (!ucode->size || (fw->size < round_up(ucode->size, 16)
 	    + sizeof(struct otx_cpt_ucode_hdr) + OTX_CPT_UCODE_SIGN_LEN)) {
 		dev_err(dev, "Ucode %s invalid size\n", ucode_filename);
-- 
2.35.1


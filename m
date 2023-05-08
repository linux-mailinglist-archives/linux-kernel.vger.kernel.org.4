Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1EB96FB6B5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjEHTVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjEHTVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:21:39 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F021649F6;
        Mon,  8 May 2023 12:21:38 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348DVAfX000412;
        Mon, 8 May 2023 19:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=FKNc7R9pzW6ZWbBKD/Qn+STi3Ezrps532f3vutV/80g=;
 b=h8apV4KAeziz0V+cTiXzEesjgs3VEXK1fPcaHMvuZbPB6US0hTmiRlcJXr9HuBptE6pb
 CWTmRlkuQlR585BDsAdHvL4XCuW5qoivmDHHWd131IjWLOJYqKiObkrRBYG4Yz1I5ERH
 N+H6NC3r7+N+x655LyBYyrhckz+/YSm0KSRsW6Luu78YswxpT7qtM31ZY7e01NxMcNH/
 RBfVEFEgcux/aFDA5GXyrj9aP77avERWSJuEO9gMOB0IAK0ZuozwPmrfu36nOaXpjMe0
 sVTSn4M370pG2aJxwoiwXUsKgJ2lyGXgAnIxw3t4Gt+ZKLjbaPnSGfEpjP8X+/5STMP1 kg== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qf21f2rat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 19:21:20 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id A6211800220;
        Mon,  8 May 2023 19:21:18 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 07:21:18 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 8 May 2023 07:21:18 -1200
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 07:21:17 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ijz1bc7cF4nQimZ+V0D8DRxbLzhp3TZTtsWXNXY5V0ptt5Ss2aXq2R5pn/55jvNHgx7iYYiB8q9LUoqtRvsMquSvMzWd2M64YsAtwad0chI+EKOhPNzrEyIlKZ+oV6n31eMmZhsP0xH7uDJBzbw5ri/gne9+C4xNx/nphTzNmqpVYX1ymNSGwB9oGiAKLibT46JT9G3UnTBbaJdQzbRuiNuWSVcFJSQVPwhfSwbQmy2JJ/edtMPf/H8V5+I9qFMvDep6Ve2ko0cspcpbq5NiK/81VphMqYYqPuJ26ZgPW2HR/FeWoUmAn1Mx2G1j9U3+/zZDBObVeJfty6ghGUQ3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKNc7R9pzW6ZWbBKD/Qn+STi3Ezrps532f3vutV/80g=;
 b=M7s+C6Ti++YYazFsV7Mczn8mnKgk6vvigfDlsc7EwYxwi5pJMpYYX5Ujg+HPAnFChK5orbQS45is9YmHjjJbTs6Ql+AFV2cgkn+pvioKc9UzucgkD8ArIcTwiQxSWoUx6fiZtraDjVJAx5mvDYIXS4tVN4Kc5ncyn8r4GzJp0219pCPeUgVnMS7OdIBIXevnzDt2lMrzfnWJ72Y0nmYLkd0SIuBP5s7DIVTnMPfh2yw1w5fRAr2y2X5pjKICrHsFuN5/uX8Pnxbmp9vmQ4+3PZ+7C1jUIibhmsXGE/v2/vd3Yk2a96+YEhvE4/yoxktKz1MWSUd0pSHsgBQhk/p5zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1781.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Mon, 8 May 2023 19:21:15 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::71d7:118b:6b9:c794]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::71d7:118b:6b9:c794%7]) with mapi id 15.20.6363.031; Mon, 8 May 2023
 19:21:14 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "gmazyland@gmail.com" <gmazyland@gmail.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@suse.de" <bp@suse.de>, "mingo@kernel.org" <mingo@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "bernie.keany@intel.com" <bernie.keany@intel.com>,
        "charishma1.gairuboyina@intel.com" <charishma1.gairuboyina@intel.com>,
        "lalithambika.krishnakumar@intel.com" 
        <lalithambika.krishnakumar@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Subject: RE: [PATCH v6 11/12] crypto: x86/aes-kl - Support AES algorithm using
 Key Locker instructions
Thread-Topic: [PATCH v6 11/12] crypto: x86/aes-kl - Support AES algorithm
 using Key Locker instructions
Thread-Index: AQHZbAH88VGTsMp+/EmLUGEOvPYmc69Q69qQ
Date:   Mon, 8 May 2023 19:21:14 +0000
Message-ID: <MW5PR84MB1842D5D264A5B067934F30CEAB719@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-12-chang.seok.bae@intel.com>
In-Reply-To: <20230410225936.8940-12-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1781:EE_
x-ms-office365-filtering-correlation-id: 922310dc-f784-4b5c-7143-08db4ff96421
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: or6qTqk8ZUUs0UiBovMcLlKJj4xgfHEs6//Wo1C7Gvtyev9pSo2bf2jMqSCOHc+RFl59IRhrJtvfYPy/y9g7sSaLHLSQOKbgU1Ei5STWKI0CQZ3oY/o9Nm3t0osgCxF4iVXBIR6v0PNNNddJjG4PIkmdA6sePagWg6wLX0olqSR4c9GTzLtQXowov0jsbAtXBwiS6mVTrJTWz0mlY7O04ge5Ko3Dm3JGLaflnC4UtkVOvhdK5YEan3ybcmfFdwwqD0+EuiVSnDEwbKYFDHeEu5Uphc8uLcx+gPs6yVWvHXnRY0rY9Mi0+ka0BEAjx1RtdXeyLX5X0/1fKT14I2CyXulqw9yDWA6hWzCM9XR1rlv6Smyukc57EfGIjQDlSdd6vyC0gqiyfN3EAgpNQQ6K0JSFBcaa+97os3qXcnYNj10+py78Co7tco8vlYGzz4WoP0W2SSSGOgUS9i6rtkS1z/nkAZCWwOW5Z72Xv1ozIrT+f30qUk7Dp2+t7A3ANwbh038hjd1UxX/15EACGgBGzG4bo1hOblhgzXNmbuNDcdYnZAbdp9Mxb3xmcbOb6u4IJ4m6TXtvBVQp+yvPO0RZo4y9OKs6JcjT2dVnU91vgXg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(110136005)(76116006)(7416002)(5660300002)(64756008)(66446008)(4326008)(66946007)(8676002)(478600001)(66556008)(66476007)(54906003)(8936002)(4744005)(2906002)(316002)(52536014)(41300700001)(71200400001)(7696005)(26005)(9686003)(6506007)(186003)(82960400001)(55016003)(83380400001)(38070700005)(38100700002)(33656002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?u8v1Dat1Ol7526Vkqj4ZpV89gO/V8sQkHX+/UcxwVBjYY1AQuTYqwEMwB1rh?=
 =?us-ascii?Q?qUE4XAtQ1zOlFE9qQGwtzJoe1Rp0v8UAng8POKwnvOwdLa2BwbsZgMtzzTnG?=
 =?us-ascii?Q?nvHY1WScKZF2x27yY/DQ9uhnDwOBeol8H48mMiuAjFbrnL7Qp96uNo0PCryA?=
 =?us-ascii?Q?zUXNk0PxBRqKEcgzaxIWIYRAxYjqzzUegZQhLlDHaZpc8FwzUipF8S549ii2?=
 =?us-ascii?Q?B52HOTtxRr6W9y5blKyH9WsP7wNG7D6foKY19TLiiL5Moq1WCAaSGJyxjv5o?=
 =?us-ascii?Q?HVKYgKKSr9/bd1zCfGocIrClz9EbBj1apSG+99CdodUTnWHMgOdTFpEDZ88C?=
 =?us-ascii?Q?XQOgwwNRsLqo3qFjBXIN2pGVFsQhlMB75iHdeUWDZ5mBE4pbuR+qSr/ycaog?=
 =?us-ascii?Q?g4Za6z/qTWWHFzqIf7BWcdl6TuG8VBr0UiwyBekcMrWCaHNuhfWdemJFUUGj?=
 =?us-ascii?Q?mNAJAqBvZ1cOQbGfyYJDWbnR8gpr0NUP2aqzoRy+pC+6O5T+azxMQaL04Ltq?=
 =?us-ascii?Q?4Ob3X2laV6ac43SYOBtcaqa2pmG/v9oA5SRXf0/yq/CvaTtORXREJwWw8/o/?=
 =?us-ascii?Q?XkTAjA/f+4Jb9Z8E1HDnLU35CabeysUdFf0WIp0WVeoV/SvZLrQt5E2KQYRb?=
 =?us-ascii?Q?QspGB64rcy3lpxiyCJVuOQw6iV9+ccGwxKzY3aoh+mESvGMs/kMuvw72W4jV?=
 =?us-ascii?Q?eD6Nh76ZltuDbbE3qvXRQVJLWgILJs1UlaXjMHtrffEQW56353SEVBu6+SIS?=
 =?us-ascii?Q?31/GIetCIfaCp8L5EflPwZ9ZrH2bToRf5wuo3fB16GZiFA0N1D1koFQBX77F?=
 =?us-ascii?Q?VaeFvCPixdaMK99WdQH8fq3BPjjwcBmks5LF/TdWD1LrNnlx9lIjPTVqLEX/?=
 =?us-ascii?Q?ymCTw6A06KkvO7hpytdSn8ksoyKQ7owyCa6TzzNOvjeXCpEARwiCdopOwMJv?=
 =?us-ascii?Q?IwupQv9NoNSAb+BWMpcTSOPk2k1sd+gy2gOlflRyoNPgrdOQeJ3+WCnM50uM?=
 =?us-ascii?Q?+dxEMb2+dUdla7i7w/H9SMeVQ3NulsMWY6QeptoVyVs/PDH4HxtK4fuUNdkY?=
 =?us-ascii?Q?GfyDmTZoN4Uc5aNNGUIpMAuPg/F7w0OJf6tsZJFKtGeyibu6hUqR2+kTBWGV?=
 =?us-ascii?Q?OBYcjgKkXPTzXCZuk0DAkrzlzXzw7Wgin9qJrix77TI1Ipn/bTsuKUUQtDfG?=
 =?us-ascii?Q?+F6pzIWspx8RsYxGCionQS3Zdp1/r8+yWPz+QKYHU0OBmq6OrbK3AXuXtiP5?=
 =?us-ascii?Q?tdg9+6qPe/jycAPdYThwPxDx62RzrAPthAanzICjIsEttGl1d4sl0AFARsBb?=
 =?us-ascii?Q?qv1LH5KfbsWsQZW2ZnL3ODN8OzGs5uyxFxWZVuMEslY7vMfazKLWT93QwaDm?=
 =?us-ascii?Q?Ggk64lzORQAqsVO6BwVmtgt0OzszxYtmsvePyHLN2qB26TtVzpUzXneuykqc?=
 =?us-ascii?Q?L2Vf5WZK9/XtXLt4NSAKWGKgyt/iR5TrMJONVhEbc38tuQ4mCiEVg2rloX8I?=
 =?us-ascii?Q?mBjajKxOTxMcP28OWxahwZGssZC2TdoC6KRUgWqz4OZXWeq6Rr5D2EwUCxyH?=
 =?us-ascii?Q?5G2pfC10Aw+mDtDH9VI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 922310dc-f784-4b5c-7143-08db4ff96421
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 19:21:14.8373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JBDsr4MMBqkG9+KIIiwm5LBb10pk9t9IKtGQcQ3/gYqptQZTtsbJQzQS/oJ/LXM+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1781
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: ETdyDvO-uGUyVQv-UpRUAvLDClbu0Srp
X-Proofpoint-GUID: ETdyDvO-uGUyVQv-UpRUAvLDClbu0Srp
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=953
 lowpriorityscore=0 malwarescore=0 mlxscore=0 spamscore=0 clxscore=1011
 impostorscore=0 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2305080128
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> diff --git a/crypto/Kconfig b/crypto/Kconfig
...
> +config AS_HAS_KEYLOCKER
> +	def_bool $(as-instr,encodekey256 %eax$(comma)%eax)
> +	help
> +	  Supported by binutils >=3D 2.36 and LLVM integrated assembler >=3D V1=
2
> +
> +config CRYPTO_AES_KL
> +	tristate "AES cipher algorithms (AES-KL)"
> +	depends on AS_HAS_KEYLOCKER
> +	depends on CRYPTO_AES_NI_INTEL
> +	select X86_KEYLOCKER

This material belongs in arch/x86/Kconfig now (which didn't exist when
this patch series began).



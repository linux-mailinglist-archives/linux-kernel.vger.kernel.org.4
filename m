Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AF66FB6B3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 21:20:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjEHTTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 15:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbjEHTTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 15:19:44 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C8749E8;
        Mon,  8 May 2023 12:19:43 -0700 (PDT)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 348HjiRQ016070;
        Mon, 8 May 2023 19:19:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=J9WPFBQijH0hPBw6DM99UzZQaj93HJoJ+PgGdwBWZ8U=;
 b=WQz0gz3RjNA0hP8HICmh7iLiJNZfGPkp88QB+7J97hsZwbmRFVEgmi+68b5CVJIr1qjg
 MCZsy2qj1VWzIH03Nopwe9CwRNlWzIZOAsXWGF5O0IqQcbBxd4Zk3nmT+c1dtSj6Orti
 TGjfNscxq3tIDJDE7N/rmda2IlzPuKApQ6ATBERFYfPsONpQw3IVcWkYTbebbiO66AXq
 nXwMrvPSbsy7I4NcGRTOj81Ef09+Y/FJULYKqdz91gVk1y8F2BrxYJRUALQxpCj38+nr
 JeHqcQWdR/gswABZn1lscBCgHQdPeCtet4HUEGMqQ6Gzakp+NEkWWUERCVSXU1NBYEUg tA== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3qf5s10njy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 08 May 2023 19:19:06 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 2CF3F12E97;
        Mon,  8 May 2023 19:19:03 +0000 (UTC)
Received: from p1wg14926.americas.hpqcorp.net (10.119.18.115) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 07:19:02 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42
 via Frontend Transport; Mon, 8 May 2023 07:19:02 -1200
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.42; Mon, 8 May 2023 19:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cd32PCMQR1MGvnlpGlzdondN6c3TH14mMIWUWZFQLGU8CedTpaBx+c+hvdQClVC9SltMR58eVqtYw33oqzwJ1BgGOhQWuMPkqaTF/i5QPnJV7A0zFQgSY92fTGxKSzCZV7GkHKotuYugEgVPhrCRTs7z3EeIw/GBslNVVIcMhbmbi8FNxF8BoAgecAnoEr1KJF/43tntxZMxy5QHg9mnVnTZt8y1RGz30y6a/AGKXX9xEm57Jt2+Pl5xZ45rXwXXEyHR7nuxEj5pstp8dsjx5vS933QiO5/yGtCqgSBXtmQ/HJm69NjzlJAs+FMQoTEBUnj6/Dy1Fnw24SzNLQzgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9WPFBQijH0hPBw6DM99UzZQaj93HJoJ+PgGdwBWZ8U=;
 b=Zr0hvBCotCSvJWpwmGiruSSPgAzurDbRLX5xZ8hXJDTDvgtPl38wI8S/VpLDzKQW8jWEEpBe3wZTiP6h66pWamCCmLVFlcn6uwx0gj8fm9KwhfIfZxz9F59YQI3pHpxhZ0Cm/6nw5PFHDD7rpMyogdqzUTpg48EyeBJXJO20mqRZg8hYR8z9vg/vF36Jxy6ijxDm8Xmf62A0Xa7JMZCzNFg6CXLr0m01/bP30Uciml8nhe2sqzhpHxBl/lEXec8Pt06gR+k+MqCJeNmAkDpW1GqsrsfBsdVoUiw5NjOUOERQGCa6UEPTJhWzzgaY/LLZj/qmNJtRvTTNigAtIjgMSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by DM4PR84MB1781.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4c::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.32; Mon, 8 May 2023 19:18:50 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::71d7:118b:6b9:c794]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::71d7:118b:6b9:c794%7]) with mapi id 15.20.6363.031; Mon, 8 May 2023
 19:18:50 +0000
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
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping key
 at boot-time
Thread-Topic: [PATCH v6 07/12] x86/cpu/keylocker: Load an internal wrapping
 key at boot-time
Thread-Index: AQHZbAHvJOw7tE8EFUqNRCfBgGyiXq9Qxy3A
Date:   Mon, 8 May 2023 19:18:50 +0000
Message-ID: <MW5PR84MB184225DA6EA0FA7A9191C057AB719@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
 <20230410225936.8940-8-chang.seok.bae@intel.com>
In-Reply-To: <20230410225936.8940-8-chang.seok.bae@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|DM4PR84MB1781:EE_
x-ms-office365-filtering-correlation-id: 3e56d50d-37f6-411c-91a6-08db4ff90df1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyMuYX+50PZDRs/jaJK7eS5bDrpKCCGPH9401ymD+G0j7tMAh3D83aBQdfZdEsLrJwtgWy3NkXi6R+erf5exvr/JXpoRuAXBA54OFrrS2Up9Z6ptg5IRbCSaC2GtVUq2dcOiAMwQ85EEMgscH/rFOVRN+baQQ9X/olS73oYVA2TAO0RDHbjX4UPo7LmXdOAI6ElfQiNfVdZf71GfvW5XGJTDtJCHq/eumdG2ngjfMt6jT3Oh1X/h+MnhlAmusz9U4SBE2WPv5dsQ2GUCIdkZyLsqZXnR83KGPBgcZYHifLa9TRSh06uwGH/Qfbr8j1dym2rlTTWFf2YStDhSXuGpN/xVVXDZ/lwtF+pT1UO3nYJc+4zoYFqh0nKNCkLVQHsZqcSJ3mi54pvaj00uFJa54RmlfbWmzaQxLaa65yc7910IsJqXpwEo2qEOtCZgy1eS2k/oOU8GPDyn7s9nFb3JnBu9jMWoy7DwjYHD2XEGYdWfQL5n6pZMSIoY6MVgrPgl/XzR1Zfg5aJ2d/vZ3RPilOK8XJMYD1BSgbQal3Tf02RJRXEgRDqrTpDu31banuzejJtk54LCTSIEZ8oducqhv2K4H7QXFPdWIIVTei9Pinb3gMBPjv+qqIAU7uTjHi/m
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(346002)(396003)(136003)(39860400002)(451199021)(110136005)(76116006)(7416002)(5660300002)(64756008)(66446008)(4326008)(66946007)(8676002)(478600001)(66556008)(66476007)(54906003)(8936002)(4744005)(2906002)(316002)(52536014)(41300700001)(71200400001)(7696005)(26005)(9686003)(6506007)(186003)(82960400001)(55016003)(83380400001)(38070700005)(38100700002)(33656002)(86362001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xfyeahWxSSOyh5EVAEqRm6bWsiCJBOU5IGIcoh1bFSTISdpLlZVlBAAnylK5?=
 =?us-ascii?Q?by+lwKF0YP+0FZQoVEWL0jQ+E5fImzdDN+rd8RrYjN9l+On0dI6/oDGfjXOC?=
 =?us-ascii?Q?plYnBifFsiGbyQvqhq58AE0XYHWyeWNdfazCG1tcwgIW9oyXJuMR/0QVcMHk?=
 =?us-ascii?Q?jxTYs6Ihbrg1bx8BknFefS7FRZAg1uEgcw110pF+3iOhWNE5n9BwweSyrYeT?=
 =?us-ascii?Q?cSOsy0xJVQGLyuB+Y+iLfgKWgwm5LxkiqXl/Ji+Srd13RHv6pluPAI3u/RLH?=
 =?us-ascii?Q?GUg5iW9nAcRVHAOevmN3+7nYJZdlA85Z19iXNiONb6is81GCLlA54ipjAHLH?=
 =?us-ascii?Q?Pd8IwBL0zJ91SUAE3M4P19SELO9/S4ysTceHSpn6P7vxN6/RkRpTj4KR6CPr?=
 =?us-ascii?Q?GPiHspqo294pP0CuYKJo/rhf5oAVb5Qx3HfOUFls3TV3fp2NiEKanZcXktJV?=
 =?us-ascii?Q?rIPedUiGHEv8ShBRwm919T1kh5G9B57dQ6DRoIiGSNbR/Wi8ren++Gu9cox7?=
 =?us-ascii?Q?SOUUC6rkvxX2XY1W+6mdPjx2sY2+/djfFrosV9dmMGCjF0jJA92CHDK1hwmA?=
 =?us-ascii?Q?L0KQhFPd5mW9IW3aEniNr62kHSyIw9Wv2rqc24bj4zaSq1beta1jPp5PZY/0?=
 =?us-ascii?Q?IREj9HntRV7zE/eExuoSlSBVMSB8c3kkPFd87c01sTqFJC0NyjGzXjoF7pu5?=
 =?us-ascii?Q?NrveEF1fY1LzMEyzYZyR8EvfLe9xlfam6bvY5opeq0LAR914gWBBNqpOLHDF?=
 =?us-ascii?Q?mKYOSWqqwJ6Mws42te3q/lY4bTaSACM3rPenV5lqZfUksMTFNL6L32M5MBdN?=
 =?us-ascii?Q?sXvCIpRuq5t3eOGDFxsvMwtHoqScW2O2Oqi9eEi3/C7AHmzlmFBLVUCxs/T5?=
 =?us-ascii?Q?LTk6Yui410l0ERJAA5Y4KyfHhz4viO96NEiu0ILqbyaoPNNNJjI1u2AETwkg?=
 =?us-ascii?Q?aLJ8cLI3U0VzpjkLvDU+0PViNl+6RqsRTCg4jpH5RU+E2Lqk1vpctHbGRvke?=
 =?us-ascii?Q?6YOE4YBeuQ1HnYlP+CEide+Tu+kfGflBo/MuOR9qH1JYuI5Y9cxlI3fvJcYe?=
 =?us-ascii?Q?ZRXYvcqysNp8kueBSX2h8q6t9kAuslh7E1BClyEh3goDkMSpNIkDLk/V2fuq?=
 =?us-ascii?Q?c34B/qmszrynK++Qg+1pHT7cwNgh6/F2WKJhD9/tVsSwJjMpt3ZMYofBBB2E?=
 =?us-ascii?Q?qo6Zzs8k29UeyUkeXiLK/26r0KX5CJqrCgyZXpyvl/j73zTrhD3gcLRRCcJ9?=
 =?us-ascii?Q?tzRMzUYr5mM9S72ZPcDhUczEQDd4tXFFwh4j48nK/Cd6Dewuo7akOG1J7o6v?=
 =?us-ascii?Q?yWbNdmfXpUnaYtTOjdTsOyWrUMnkEc838lCw1fDM86Ckmt7skh3knuJyrJzw?=
 =?us-ascii?Q?aZuPTHzaOUwiXJH8Yvj9pNxe0enrV8gMJfejaPO2YuraVPg6jWSFF6Oh4h3d?=
 =?us-ascii?Q?rCkmyKl6lovQFnb+cba912K8Pg0PAHyr0p9OWpq2wWhbTcCZZy+DvCc7+TnS?=
 =?us-ascii?Q?necTu5orTJCvtMy81P9gXEcOZxiqmv5o8rvV8r6j+mEGNugArAwbwiOvBbKk?=
 =?us-ascii?Q?/E4wgUaJDkG8tI4mukU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e56d50d-37f6-411c-91a6-08db4ff90df1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2023 19:18:50.1877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Isr9Ni/qTcxXU8M7JMdCjKcoTuI+hZdfzV6rmIYY/aOzUlNhClwxWCvnrT01Vced
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR84MB1781
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: v3wbkFgu3jKvIdIjXX92AWIU-_NGDmG9
X-Proofpoint-GUID: v3wbkFgu3jKvIdIjXX92AWIU-_NGDmG9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-08_13,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxscore=0 impostorscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1011 suspectscore=0 priorityscore=1501 mlxlogscore=908
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
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


> diff --git a/arch/x86/kernel/keylocker.c b/arch/x86/kernel/keylocker.c
...
> +void __init destroy_keylocker_data(void)
> +{
> +	memset(&kl_setup.key, KEY_DESTROY, sizeof(kl_setup.key));
> +}

That's a special value for garbage collected keyring keys assigned
a keytype of ".dead". memzero() or memzero_explicit() might be better=20
for this use case.



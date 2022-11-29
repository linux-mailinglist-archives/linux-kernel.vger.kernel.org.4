Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F335A63C58A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbiK2Qrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:47:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbiK2QrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:47:07 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC9F6C713
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:45:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ATGOtVm013826;
        Tue, 29 Nov 2022 16:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=RE1qYzJUPweAud9X48iXoGzgLX1BMCeUn+fFRSfSGME=;
 b=vsJNQXcXshc4kIs6hXlvFKXp+WPWKjPWRMuyzE6rfLVPa7mC0MEKla/pxkMBuVBl9/mN
 SHyQna2xLnekjlEDYyigK16YD8UhMr5+rVKGxQJbbvZRSBPcDq2JuOs26JCLAUgKMzGl
 v7nXgWlh9vODEuSvMsEPS9aVegvShlJhL7UI8BHsodN76zFFwOu7Y5Lmb+wyH5c55Ett
 ukYX7FHQMuIDwR9UVTh7MDchlBC/DLHAjFwAoLGMgsF9t9nsI4pNF3f4J/zPAFFrzTMx
 kx04LkQpBMk5raNqR/13mbWM7atUlOrvKNJ4Cv7w+EyM1qS3ZGgXRJNyJjs+7qF4vBge EA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3m3adt7e55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2ATFkaTw026698;
        Tue, 29 Nov 2022 16:45:09 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3m3c1vkkp0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Nov 2022 16:45:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PwAvL7e4iOtX/bTxrJJqMXudKpwb66HbZ+MkEqp8CwNuCN+1iTOZpVkO5SgvTWn8rOX4lh1KFkwd9hQMd1EsIS5z0S1IDfzMMmyqzcxrENuYNZYghqIldTAh1iOXmbMOIBKMulg9amETPQae4560H+uNJzmYtqNMEsjD5aH6KWc7UiPokJqiFtNpSBNt7xrZDmMcuPBJlLwPZwpG6iXmkBNozI7mJsHPH/JvWr0Z69892gmn7RXXQuW5vvJJKm8eRYRHtEtVbD2FVtAYFT5jixWS80KMCRpXN01z62kd3OfPWkBAJo/agLdWrm+nFJwY7HM3rQ44YYKIuh1WZDJY1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RE1qYzJUPweAud9X48iXoGzgLX1BMCeUn+fFRSfSGME=;
 b=jsIApXeZEYxRd0LA4OF3KQ9YyW059k9N2SHM7YEao/svxAKRAGuSJNEYaXOrTW76KsGEqKzLVbh0VzG7G9T8Rxg5KyjV0ZRh+x0LxIcdAoNxk361kqTkJiaF9Y3vzm7pgAJ0aF7sxXedXe0A7pAzWODNGzE5PZcW1vch1dzc5Zprn9nxuOzP9uuJzbW4HK7N2PkhIkptTX/InGs/pIjXYZsWKywSKWiueqi+hLPSAzb3nJwtH2ZaYInNwf2UCm5oztht5FeNkAieT9Tj5bZe2R3bH4kGR8rCgTfEB7J8OU33pwSRf2VlaxXWI0jdpKJx5gjXWcdrdpC8crT+9EJF8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RE1qYzJUPweAud9X48iXoGzgLX1BMCeUn+fFRSfSGME=;
 b=dIIwS+8kRDHf62pIP+XwNIP5zWKK+3U+0oZ0reE/vPJWzH+cTWslwefH1EkKZqAsz0aCEhrgyTl8eGgFFP3VBsF2Qp1iUxyMwan6DBkq4Pe9TPl4tjP8mdaZdM8oJKfdqC30nSYc2Znrsno8anPNZbtVxCgvgvWDAUo2v0d58tg=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by PH0PR10MB4792.namprd10.prod.outlook.com (2603:10b6:510:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 16:45:06 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5857.022; Tue, 29 Nov 2022
 16:45:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 31/43] mm: Add vma iterator to vma_adjust() arguments
Thread-Topic: [PATCH 31/43] mm: Add vma iterator to vma_adjust() arguments
Thread-Index: AQHZBBHcINIegAxAhESGSaQNm2bhHQ==
Date:   Tue, 29 Nov 2022 16:44:34 +0000
Message-ID: <20221129164352.3374638-32-Liam.Howlett@oracle.com>
References: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
In-Reply-To: <20221129164352.3374638-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|PH0PR10MB4792:EE_
x-ms-office365-filtering-correlation-id: 32faf6a8-b307-4b2a-15a1-08dad2291231
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z25Bfn/THauRl6lcmK8NPoZvOS47U5WTpV46ejdyxTKx71jopfRJXv38TRNm2dVT4tGS+hxqw2pU9NtrcvF/dmZmVaSWGzBye0CtxORQzbbDKyYiY8upDfkbjRqZOrE0ab+oMX1eRaH7PEGpasVcorWeQysaS3+VEZNUwgdDkq2IwKDndG9yAI7yCEOQTb7qaYNsOhMgwPdf6WfGUl1rzwj9DOWIzlU/tkIC5+PJDYs/qsq0WGEKvT00SG3kVIWZ0q59aVPV9OcdKc7ni0vAZa2kGVP2FshRd609QpnmPPWcwl1zfG9gJH4zjhuCejsyJu4IMRjokLF8aKzyFIO8QFfW5ZS7eTfqamCONnLBdfiNLTHpZfzSRtzVGsUv7XIg7M5lJh92zfxxcT+3gRDjxNvDr4U+RZVjcESK2SB0vs4HuTeek1fOdCwhsnyPYcqdf/fYaHA47sCBwWYtpOq/kZ92pRY4i6NNL9fVh66rOJqKZo0J2gDMZMekBDkq4/sjIlEQ2x3SYzMMl3IyhJoqpfAdvbQ0SN1cWyGjZZZXQipHFq4kbmer2wmvmKbbj5sOb/122wiF/D4NHOqlKvroiTPb2vFmPR5Kr58ml9Q6sQTZSoV+eUdGKR2yzEMT6uwK+2mrTWn8ZC6qYU1hJzqclk4CAPTpko38q4KLxN/iyFTsV0pSwnJtVPoc5Wbwo0aKMWpurCW35VF0ETIeXD3CmQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199015)(38070700005)(2906002)(36756003)(86362001)(6666004)(6486002)(71200400001)(107886003)(478600001)(44832011)(41300700001)(316002)(76116006)(66556008)(66946007)(91956017)(5660300002)(66476007)(26005)(110136005)(66446008)(4326008)(54906003)(8936002)(8676002)(64756008)(6506007)(6512007)(186003)(122000001)(2616005)(38100700002)(1076003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GUeccbMUr+w/5GgxjWxDF7Loul3sCxsinZPKWg6zXBpv1VmvgX6eNWzBmg?=
 =?iso-8859-1?Q?C6Q3phOw+C8qMWBTdXGkBAb+XZ8E+5C8BPL+ovGvzVTggxpYP0h7T4O0sx?=
 =?iso-8859-1?Q?tkAKn8euUbZBbH/P4xOnUpygIbVqo9Aur7cS2eV8uG2fU6CJDoJD4yBP11?=
 =?iso-8859-1?Q?+0W1brcreAau8OdJBhOYp1Hln7v0V5305E8VdlzoYd6AWD6Yhtup0Rom0F?=
 =?iso-8859-1?Q?YwdDFyOFg6Gzc4TkbGwbDW2IdO0TStFge9+PE9uJmGMKrmC7UTlNpB7oO4?=
 =?iso-8859-1?Q?kLsYYQMA7jP8rw2PmeVmxEMT1IqBb5RXUTYCiz16wcWZeG26uMhwQQuKkW?=
 =?iso-8859-1?Q?6cGf+TdOecshj4flBrGeeORZQk+0PS7JZ7xl81Ui02F94Jo3UCnuud0wWB?=
 =?iso-8859-1?Q?+5sQjOAt+bskcOYcwevGc8rlw19dtg/1kMQAnLGhxu+t4UzF1GOAKOgTLd?=
 =?iso-8859-1?Q?w1nVK95y6R43tlKsSOTETa6vZRnFWYqggbydC0q63jq22vzVNrGWzo4HjQ?=
 =?iso-8859-1?Q?/pKacuNPRH+lLbV3V7r6f8MqoGFcVxyRTDTa7/0lU14d4u4qkermxFr01a?=
 =?iso-8859-1?Q?xlCwrC69q+SRA0b9bBrAks2G+tla3CBw18dXLKFSDTmhfIfoSG1BcPH6qq?=
 =?iso-8859-1?Q?iEGuWM8h5SJWvNJyjcAM7etgRcsWU7oCYVop88/Dktue2ZEMoUDrpBJxdQ?=
 =?iso-8859-1?Q?14QZio7fGPgSCSs1uBFktHs6ktxipfCPapQzhsJHiF4zC3M0K7N0Kxo7c7?=
 =?iso-8859-1?Q?lxqMDLAzT4mKMkqIXx1h9dnC1XZkAh9i3VTLmBLkKFRoADxSxCWJerJl4m?=
 =?iso-8859-1?Q?1M1fIU8KVLQ34g6jJpSHi8RGgCBWjhRQ7eylz+VrsvJz+ZzLa/k3jFRv9Y?=
 =?iso-8859-1?Q?opJntQvIrJU4Lx9fPMy+Q3kkOmiYbrWeMGq3Dt7qp5/fjCnpHtMK95JlKm?=
 =?iso-8859-1?Q?zGviBzDpEq6PTQFnTO1+BXOhSvtbK/06cgwM/zQT+VcZUI493cSq6v0A61?=
 =?iso-8859-1?Q?hXKhlyR8gt5Ra4yyO/u4Zl5g/CTr7Dr61/dEBZWYZGYfUq4N0ZfQje4f21?=
 =?iso-8859-1?Q?EUkjuBgKna8uA5nQXsgA4pML/WGwN7/tj9eStOAbRhO8AN26fUTk36h2SW?=
 =?iso-8859-1?Q?e0j3BltV3xPl954m3F3yvEJvXTHV4qyE8cy9SmXcE+vpze1Hs+b96Itlol?=
 =?iso-8859-1?Q?OuOl5DmgW4yuKpphLSDV/Va4uN7MfhXT5zno11Dz6ViPTDfbB+SePEApOq?=
 =?iso-8859-1?Q?vwcT7LPKYqPH7XV1mQptJfIwQz8Y3PqMfXmzDUY/iH54Ai6yHesso7sy26?=
 =?iso-8859-1?Q?X9LooraIcMTlBFtrD/qseO04mEaRIgjDfLx5PKzI6LuhKN669BYXkMq/Jm?=
 =?iso-8859-1?Q?XK4eN/lTrqVknNN4nkG28/TQQFDNxm2Pb9+N6mDPhr6Une5/bCuEKFlBZ5?=
 =?iso-8859-1?Q?+pdnK73W3pooM1HDhlW1HUUDryVLlHnMaGn1A+UBzsWjMQSgWwkrhEBjoo?=
 =?iso-8859-1?Q?T5FljFwE0b0/Mzi0QkMXlvii5Yc8e5FNMe/wYjFX5jmWNI8UGrBZgQzvrU?=
 =?iso-8859-1?Q?EwRbsbuEkIEIaIqGTI0+DpnVWGdpxo4w7GQ7a0dtxFpdNv/nr+g7k4QwKc?=
 =?iso-8859-1?Q?G3AAhbnyDpMll9adoP5c7aDaEEIiMaRfp7efrXETqQVmHD+gWXvgDz0w?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: u75OXopxrQcXe1eTs5ucJLmeQILjsbGOVAxCxrly21UXfXBDXYxORNODckhF+XYKmlOv9usLLXlpVAExhiBZzLbqtubpsI4A0CiLy1itvXbCqdIlVSEhR7rqFaS1KQwp5q3K2fuRgixWU9g3fT9UsmO/KJFNT8BccgWTizTItCMJ/qI8N2ej7rqkmkk2X+ZHTd0po+FtS7iixPpxT28l+XZ7l5S5qmwt7qQv/54NwWJFd2kKpymhN6hwmaPWlxHT53fyBQNogogbdxQZ75A1qcrt/eL2L6ZHJVFIrF2yK1B9g6ILiRAGtuMjPBFVroG9oNCPaOHEkdtFCLWsl5oP0EAdfVbxv4E1uiJp5SK42MCiybdJPv1sczxV+Zzze3w/f57dYen5U35XaBsXu4kGswYSzwJ2w92VeujxDS/Xzh7Z+TwSDEVepzuPcaQ43peKcK/LmYqLSD6T+a64oX0I8lp/bCoHC6ZwG3AEFCHlHTbrXPkeeUvAt0bGxEhJ9oNoUs77rXtY+TXKsp4V73YxMOW7Nx3OdMllVMKLGqft15mtUIJGwZul901QWlasA9lvdBqFE3dZSMB0wIcnW55B9BbC62P4OH4W7bShrrl5MiO7hgVMsu1yAnX85WW3IktTRQfwzlHT91NqeJGL1pMlhmocazPmB3o+8SrUeNR6No4MR7vi7F5YDrkaeAUEnyTU/5lSb0FLK4F2Ie8d4RPsaycl1zfe813GSvA1BlrJMGmlVmfGWKr3EOcla5JXOG5N8IAIyRa36NUS8FIbOX2cYtmBt9VQKoR4Mbqq+CDdfJD6o1u2DAhLVzKl6HSfDY5qqiu5JJ/jgIeqcei6xzcIIvUuGr4hEeKUQHxqa76psxtQWKr1dlWIIzgZRSJSD1V99oTxIksdO8ALX3d9UeS6Fw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32faf6a8-b307-4b2a-15a1-08dad2291231
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2022 16:44:34.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtbCV/stATfztdrnSgMhBuGYsHo2lkAy8FLDVNEFqTA7dFxuLVvE04Z8HRpgFmPO9jv4vb2/rXH1rnHeUFVW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4792
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-29_11,2022-11-29_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211290093
X-Proofpoint-ORIG-GUID: WwNS8ncFWX6SLSR66VvwuzOfMC3IKYPF
X-Proofpoint-GUID: WwNS8ncFWX6SLSR66VvwuzOfMC3IKYPF
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Change the vma_adjust() function definition to accept the vma iterator
and pass it through to __vma_adjust().

Update fs/exec to use the new vma_adjust() function parameters.

Revert the __split_vma() calls back from __vma_adjust() to vma_adjust()
and pass through the vma iterator.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 fs/exec.c          | 11 ++++-------
 include/linux/mm.h |  9 ++++-----
 mm/mmap.c          | 10 +++++-----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index de9eaf5926bc..8d2b47e436b0 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -698,7 +698,7 @@ static int shift_arg_pages(struct vm_area_struct *vma, =
unsigned long shift)
 	/*
 	 * cover the whole range: [new_start, old_end)
 	 */
-	if (vma_adjust(vma, new_start, old_end, vma->vm_pgoff, NULL))
+	if (vma_adjust(&vmi, vma, new_start, old_end, vma->vm_pgoff, NULL))
 		return -ENOMEM;
=20
 	/*
@@ -730,12 +730,9 @@ static int shift_arg_pages(struct vm_area_struct *vma,=
 unsigned long shift)
 	}
 	tlb_finish_mmu(&tlb);
=20
-	/*
-	 * Shrink the vma to just the new range.  Always succeeds.
-	 */
-	vma_adjust(vma, new_start, new_end, vma->vm_pgoff, NULL);
-
-	return 0;
+	vma_prev(&vmi);
+	/* Shrink the vma to just the new range */
+	return vma_adjust(&vmi, vma, new_start, new_end, vma->vm_pgoff, NULL);
 }
=20
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index ed6495c66703..b5cdb9d9e987 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2695,12 +2695,11 @@ extern int __vm_enough_memory(struct mm_struct *mm,=
 long pages, int cap_sys_admi
 extern int __vma_adjust(struct vma_iterator *vmi, struct vm_area_struct *v=
ma, unsigned long start,
 	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert,
 	struct vm_area_struct *expand);
-static inline int vma_adjust(struct vm_area_struct *vma, unsigned long sta=
rt,
-	unsigned long end, pgoff_t pgoff, struct vm_area_struct *insert)
+static inline int vma_adjust(struct vma_iterator *vmi,
+	struct vm_area_struct *vma, unsigned long start, unsigned long end,
+	pgoff_t pgoff, struct vm_area_struct *insert)
 {
-	VMA_ITERATOR(vmi, vma->vm_mm, start);
-
-	return __vma_adjust(&vmi, vma, start, end, pgoff, insert, NULL);
+	return __vma_adjust(vmi, vma, start, end, pgoff, insert, NULL);
 }
 extern struct vm_area_struct *vma_merge(struct vma_iterator *vmi,
 	struct mm_struct *, struct vm_area_struct *prev, unsigned long addr,
diff --git a/mm/mmap.c b/mm/mmap.c
index b1d17eb5fe59..6b05e1dbf705 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2269,12 +2269,12 @@ int __split_vma(struct vma_iterator *vmi, struct vm=
_area_struct *vma,
 		new->vm_ops->open(new);
=20
 	if (new_below)
-		err =3D __vma_adjust(vmi, vma, addr, vma->vm_end,
-		   vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
-		   new, NULL);
+		err =3D vma_adjust(vmi, vma, addr, vma->vm_end,
+			vma->vm_pgoff + ((addr - new->vm_start) >> PAGE_SHIFT),
+			new);
 	else
-		err =3D __vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
-				 new, NULL);
+		err =3D vma_adjust(vmi, vma, vma->vm_start, addr, vma->vm_pgoff,
+				 new);
=20
 	/* Success. */
 	if (!err) {
--=20
2.35.1

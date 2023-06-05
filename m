Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5178E722366
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjFEK2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjFEK16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:27:58 -0400
Received: from esa1.hc3370-68.iphmx.com (esa1.hc3370-68.iphmx.com [216.71.145.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD11A1
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1685960877;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ZdXyEYA9GG2pDpXNCZbGMa6ZF07QnkHm18ZET2blfY=;
  b=GXyaWXKJqMa0u2L+qUW2zHzmKRi98cCattGJq3tQEZt/bGc5UAjAUNkq
   MTKG5kN7Qz6izcWojhNRdUFb99UsmbnWHYMKPDRUbltgfvDgQA/G+g+gK
   j2HeHt4goA71kDWs2B58c6QEmqAfqJYpd81XYKc+IO/nYaMRNipoDjY7y
   U=;
X-IronPort-RemoteIP: 104.47.58.169
X-IronPort-MID: 112017602
X-IronPort-Reputation: None
X-IronPort-Listener: OutboundMail
X-IronPort-SenderGroup: RELAY_O365
X-IronPort-MailFlowPolicy: $RELAYED
IronPort-Data: A9a23:8ApNyqvnf1/yoBHpwWAvii5jhufnVFZeMUV32f8akzHdYApBsoF/q
 tZmKWzVOPyJamqnfNx2a47g8UwFvZTXnYdrGQBpq3swFCpE+JbJXdiXEBz9bniYRiHhoOCLz
 O1FM4Wdc5pkJpP4jk3wWlQ0hSAkjclkfpKlVKiffHg3HVQ+IMsYoUoLs/YjhYJ1isSODQqIu
 Nfjy+XSI1bg0DNvWo4uw/vrRChH4rKq4Fv0gnRkPaoQ5AGGyyFMZH4iDfrZw0XQE9E88tGSH
 44v/JnhlkvF8hEkDM+Sk7qTWiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JFAatjsB2bnsgZ9
 Tl4ncfYpTHFnEH7sL91vxFwS0mSNEDdkVPNCSDXXce7lyUqf5ZwqhnH4Y5f0YAwo45K7W9yG
 fMwEQsINgytjs2NyYmAS+JVl8MZHvbhM9ZK0p1g5Wmx4fcOZ7nmGvyPz/kImTA6i4ZJAOrUY
 NcfZXx3dhPcbhZTO1ARTpUjgOOvgXq5eDpdwL6XjfNvvy6Pk0osgP60bou9lt+iHK25mm6Co
 XnduWDwDRwAK9WbzRKO8262h/+JliT+MG4XPOThrKYz3wPLnAT/DjUoEmnkpNKk1HKeRvtfc
 mEU3S4Ig4QLoRnDot7VGkfQTGS/lhIVRdcWE+Q88wyL4qvS/wudQGMDS1ZpbN0gqd9zRjEw0
 FKNt83mCCYps7CPT3+ZsLCOoluaKSUTaGMPeyIAZQ8E+MX45pE+iArVSdRuG7Lzicf6cRnyy
 T2XqCk1h50IkNUGka68+Djvnz2otrDNTwgo+h/QWGO1qA90DKagZoqn7nDB4PpAJZrfRV6E1
 FAOg+CX6OEDC8HLmCHlaOkEArzv5/+DKzDaqVpuGYQxsTWr53OnO4tX5VlWNBc3GsUJYznkZ
 AnUoww5zJ1cJnyxdodsfpm8Tc8tyMDIH9P/V+uSacFSeJ9vbwyW1CZ0bEWU0ibml01Eubk9P
 pGWau62AHoaALghxz2zL88e1rkxzywWxm7JQ53/iRO93tKjiGW9TL4ENB6EaLA/5abd+QHNq
 Y8BZo2N1glVV/D4bm/P64kPIFsWLH89Q5frt8hQce3FKQ1jcI08N8LsLXoaU9QNt8xoei3gp
 xlRhmcwJILDuED6
IronPort-HdrOrdr: A9a23:jF0ala+YKBrm5xcAE7puk+DcI+orL9Y04lQ7vn2ZLiYlFfBw9v
 re+MjzsCWetN9/Yh0dcLy7V5VoI0mzyXcF2+ks1N6ZNWGN1VdAR7sC0WKN+UyDJwTOssJbyK
 d8Y+xfJbTLfD1HZB/BkWqFL+o=
X-Talos-CUID: 9a23:YnOQ42Dl4lEqpyH6ExBc8RYINMkKSXTm93bbGl6/M1RWQrLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AUBswVwyNWEcCQHCbwrfbO/uHCkKaqJrpOh8Iuoh?=
 =?us-ascii?q?Yh+mZHCwpFje6iBKZbrZyfw=3D=3D?=
X-IronPort-AV: E=Sophos;i="6.00,217,1681185600"; 
   d="scan'208";a="112017602"
Received: from mail-bn8nam11lp2169.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.169])
  by ob1.hc3370-68.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 05 Jun 2023 06:27:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCQLgLU6AZd5epGW+VAeUY6DWT8pXGfYIh9dL5WPj4P4bs2Edt1pWUa9UEJ1nhXeM7SDxG/kSwvV4fcujhgsEZq2GVkz6RBcZA4g6KomgMicoOsF8kSevw6sGrw2rzUhbJbgvXQXrigFP5G+ywoQIryDrOKP761a5+BQcvB6Lc7mniIhQHmCZpN8+idiVfRWWLMTMPDW8zKbRD2lKRPAwfevAgAPBN8h6xP8vvYfYH2mFZ7D+rZClTWnBURrYP1K2hgY0eTevnHwN/r+ZhOIZP2IjUBxAXWRai9bldxUt17LH2Wp8wkxYFAzWGJEfrqqX12Xu49OAAJsA2RCq5fK6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZdXyEYA9GG2pDpXNCZbGMa6ZF07QnkHm18ZET2blfY=;
 b=VjJ0miidi1H6z3I0VQJEz0Galg2GG0PeMj2NhIv5s20wq+3y9g7Pt1ibCcEG5Tmduq1/H5nYjtjiCX39++vFA7rEaTF5XcGrgsSe/jHXDcVRQkokSSHZxwbzEbaMoO8j14CISBCqwny8VZUzq9DH9A13Z0r/nhI0yP00UoOCL50NGfU4691wa2S9YTni2Dq0mdNn5gv2aCnd2j5LHde27Rciyqb6jCm4nBTnm+FUg9OIMujxjYtAxqt3FH9tjW1vTHWbdNF6ILrqzXxihSkojAp7Xj50ZbBcNfq2wVlDFqMb+WWFHWO8XywvZ5wCosQUebR2mkjFIhCkWbshgtiMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZdXyEYA9GG2pDpXNCZbGMa6ZF07QnkHm18ZET2blfY=;
 b=VQh293PeW14f++jWmK7HCqjbZTfHxzV7uZa4t5/p8KazxxqFxkOgwHS9/5WtOlwIhn0Tew/o0JtYJqGO1hPatzZpJJtxw0dfvFF8eoyjkZgQb7HmnZtQ9xtOQ6gtVMqjpsoxQKSdG3EAfEWRjEK9rkpBqVkvvnKmX6WBRNiIZQA=
Received: from DM6PR03MB5372.namprd03.prod.outlook.com (2603:10b6:5:24f::15)
 by PH7PR03MB7107.namprd03.prod.outlook.com (2603:10b6:510:2b3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 5 Jun
 2023 10:27:50 +0000
Received: from DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::53f7:d006:1645:81e2]) by DM6PR03MB5372.namprd03.prod.outlook.com
 ([fe80::53f7:d006:1645:81e2%6]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 10:27:49 +0000
From:   Ross Lagerwall <ross.lagerwall@citrix.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
CC:     Jan Beulich <jbeulich@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Peter Jones <pjones@redhat.com>,
        Konrad Rzeszutek Wilk <konrad@kernel.org>
Subject: Re: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Thread-Topic: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0
Thread-Index: AQHZkwepCLd5o5Ie30KiSFAaN3rMQq92Lj4AgAXcJLg=
Date:   Mon, 5 Jun 2023 10:27:49 +0000
Message-ID: <DM6PR03MB53726A050EABDC6093800EC3F04DA@DM6PR03MB5372.namprd03.prod.outlook.com>
References: <20230530150106.2703849-1-ross.lagerwall@citrix.com>
 <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
In-Reply-To: <5aae0317-72cf-fc3c-6ce3-7e1fe1d6b699@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=citrix.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR03MB5372:EE_|PH7PR03MB7107:EE_
x-ms-office365-filtering-correlation-id: 06638622-d4d8-4885-d348-08db65af8322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aaoBm2R6pnbn0ECUZp1pGVQd6GyRYW9B3VySjN0p5zG/PJKSdYP6LIJ/OjpaHUThSiTxMZz1CZ665dZGQurYeEzhbS68IYePdH4YwjrkMMWGUzZdOldIXnyGot0kNJ5RndQvDMGb7yI+8xwrUpa5N3pdEnTkagI1WlLmxzd2PG96JQRC04PdsGvN5KufqX8DS1gcJT4BhkquA29/r0ZOyZm1Wj0bmFOzlcWFmP/CZ/bc40bjIG2fOrTSf+X6d7x9mbNhFqtuVVeqb4pQQjkyIHyzA/d9+ufK4L7/rJ0A5jx2ukSPrFKmyp2Es4RKEwT/mliDCo+vb/RD9sDKsJmCsgrKFtJCx33eu4U/Nq6Chayxp5BnwfEcGq+FR/G/gQRgc5hKUcKLcyDiML3ZYF/DYmoeih9WffEDucQklsvzHB21Kk3FO1bRqb1mCnZq/pct/SZ73lmyoBPH6VGAgnwjsLd69lXH+QhR1E+YvzmWVLPFidbrKKmlqAp4r0WH2g3XPzZGLaL+mm8CdNqrCmXlMshcHVjfg0PPlPxvt+Qnz5irrP2gmMPUsE/RajTUE6ZNrMjSSuikBtlfjZvfNtJMSJ1bDEMZSUiwnau2DZ4/rKUMh/s/3fKThiL2gUxBC49J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR03MB5372.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(83380400001)(7416002)(82960400001)(44832011)(110136005)(54906003)(33656002)(55016003)(478600001)(8676002)(8936002)(41300700001)(38070700005)(316002)(76116006)(66946007)(66476007)(52536014)(66556008)(91956017)(66446008)(122000001)(64756008)(4326008)(5660300002)(38100700002)(86362001)(7696005)(71200400001)(2906002)(6506007)(26005)(9686003)(53546011)(186003)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WpZtLucy3dsQ96HGgJoQJIRSiN3emu1uRHE+jfuQiatGcV2zmYO2UfIrSk?=
 =?iso-8859-1?Q?7xrQR/bXTb0GSGgtEmcrFtfSr9Oljb0/YnVisYwdB/sRHhW2bFjG8McoCH?=
 =?iso-8859-1?Q?obFyxUF9FTA7hHCGynYEhwBBrDNfsYORXytjwhG5bVCwYRhFsPm9KOVq9h?=
 =?iso-8859-1?Q?bSDrRIrkQQETHWcycAh28aT3lxqZ37FmAmozAlC6Wr4QkQoDsWolnzLR3B?=
 =?iso-8859-1?Q?k02HgpQD7gf57Ut92IgJN8ojFkGFZOhfOG1dxNdwdPk3c873aKBj0QsTOD?=
 =?iso-8859-1?Q?S9EQpupMRwBzwrTCkzSgxKWV7YOFLPEnGuQ3LPlydXT6D5GazRfGAsKrHC?=
 =?iso-8859-1?Q?SkZWGlJNa6QLcR/A8wNLYF2mLeQIFTy1rpQDtEGtIf1przJ69HmBDLASIB?=
 =?iso-8859-1?Q?J5XdmPYl4osAakmevwa7kqGrxObN1qw1KvlskkLxckVs10TYNXJaITnHXe?=
 =?iso-8859-1?Q?3iLK4eqlbs1qw1PkS9m2x3pkq4bt9Bik7RodoTHcRa2cUD+l2bIh8INL93?=
 =?iso-8859-1?Q?88A6MHVS7//8mMMRbHTQh0WNTCKrKMsR4GiqhxMzfVrWmpdeGBLxX7hJ4F?=
 =?iso-8859-1?Q?ucl8nE0L3xTxi228ONcBXuZBd1Zukk1XOKvbxuSHNLORz1cycWlWVZ32gY?=
 =?iso-8859-1?Q?1imXmgX3HKJXI9yaTYnwidHXg0K2vz0U1HtLVK+iyRBm+VdcnYrlGlsRmQ?=
 =?iso-8859-1?Q?oj0BmVvc8ppOg9DiV+dVqi+MX5JcA1Hp4g2kA68sm+HkV24assrGaiVV1w?=
 =?iso-8859-1?Q?qVcdR6o9AZ/QDluckZAsGqmRa0q3rYkg/USh763MG9VvFIdLcpCn2rBX9j?=
 =?iso-8859-1?Q?Bl4KRnQDIX4jHzjdkJNF/hJ2Vfd+o+rNm5uJvoQpwE2DBAMMXgqK3GDxNe?=
 =?iso-8859-1?Q?zyWHQ400NuBFF3KNQqoo7uVWkOvz+0/ZI7YysemiIDy/33rODoDZNhPRCo?=
 =?iso-8859-1?Q?AECNrzq/3VQJdrQXhqPyXwMcpBDbGSprHQnS7RUTHUs6PEytrZLuQLRVlH?=
 =?iso-8859-1?Q?xuaQKwVaOdAayLOQXqcHrQjvqu+NmG7tUZITt+n77miPPNDyixi59pB9o4?=
 =?iso-8859-1?Q?dS6/CmH4RmZcdiiylfspM0XE2ihbkonhMidM5ewFfeAGrGa+r63j7zrz/0?=
 =?iso-8859-1?Q?fI0+IF+dLiBWdklhCRLKySRTP2m2/OSo0srt58EsrS0SvBRCxmPXlqdFR1?=
 =?iso-8859-1?Q?6nfM6zUwY9rWP2JVg6xHUxr6+0Z1cf0Oer2qBwxl2ky4eX5S5WD98eWMDl?=
 =?iso-8859-1?Q?aAEQzb5pqEEK6BZdpACj1ID5i+dSSl1GXI8dRNNga4l5TQMB5YzHKu3/iD?=
 =?iso-8859-1?Q?WHrVsc6Z/YJA3ym9rYZY7KXGxjlRW24a2oyOzuu2A6aOTSCuZR0ZcU+rfv?=
 =?iso-8859-1?Q?IgLuNtyCRaygtsrxKJi1MiCwF1gCOFoAffD/zXJOsl+tMZJeoJfliPzsH7?=
 =?iso-8859-1?Q?1du66wR8P1sHfBDAShubxCQrDiJR0mUGDDUc7AqjfiOhwv0VHjCRme+IAf?=
 =?iso-8859-1?Q?ADvmK/p5uw93gZ91u2JGAjG0o60Ur+69pTcAWg1xIPyWn9ZZxpbOuNxLg8?=
 =?iso-8859-1?Q?Kul9Ixse21OTIyP4VxVhoMv7B54kRPGZDf7MmtMh4Pi592Ogar3FoHYzCi?=
 =?iso-8859-1?Q?UEaXt9lsbb+9LLNLALBelaJlyT37Qj1kC1?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?iso-8859-1?Q?C9TDGfOL9d38y5dP35oqVMokdLrONZDHBbT8FIANU+12UJDN1M2r9lvKzO?=
 =?iso-8859-1?Q?6dM4NIRGL1SpLqPyyAQL/6/srJDUPubuwChRE/0mPli3wDvkLcVc9mquG+?=
 =?iso-8859-1?Q?+/biRiEjPCW7lRsfIZ1jwyEzYDoCZkKANYx2EyEhWIFvvFLpUac7sUe12T?=
 =?iso-8859-1?Q?1tq51z0uRYqdC0ynWTv3Kyj0jjkablToP1LzqKO2B0FSN09gc0Q9Bj33Jc?=
 =?iso-8859-1?Q?xn7S/jr+3lmWCCbCPdGOdWkWV+arJxkEso6/gMxtAAR0zxBlgL+D2SFc+1?=
 =?iso-8859-1?Q?m6QJ2B+tAZcurnGho2l6USpW+TSPA+sepHywYT3R/fsNQIpMOIYInbAMVp?=
 =?iso-8859-1?Q?BOCgNvRsiJqzJ7FinXX2BYR2QW0tygr0iE/s8b645G+bPDWfWHUyI5PdZO?=
 =?iso-8859-1?Q?GHf9aR6IqP1Tt8bUTf9NTtFj/k1seeZGQMUrKWrS3qrE7E95xCN9NMVV1+?=
 =?iso-8859-1?Q?t3/KVOwgCXct/dOEAfaIiV4FNvHtWFCee1t5I/WleYgYxzem9S4Ua1zcWn?=
 =?iso-8859-1?Q?H8rgyhIzXboMrPGRHbgUzo7S2ZGVGbLEmEQLYmozMtdAbvUlsvmmtJRgdN?=
 =?iso-8859-1?Q?y7hUfwEtYh0ezf1qHxqjUWSeWtQ10Hxkodw0k/0i8XLHbEH/cgDlIqVQEc?=
 =?iso-8859-1?Q?ccYYnrrshgGQWIlzLa1QB+wGLX65MsWcOvKBWiLJtkqvT7os2qaZnuqHXh?=
 =?iso-8859-1?Q?3l7YTW0cAV8h/6wUJHIYOlFF+v+2LgkznO1M1gusGnxe5Lt+Md0t01hl8H?=
 =?iso-8859-1?Q?wZ9IGAzcCkN3GHhqsYBZvz/yHB0JqKm5JHw8Wd2Er8Tkdu8+VCDC23NXrh?=
 =?iso-8859-1?Q?Pf1I2Tqah1ouV8ZRQB7TUvH/tOJyO5FT1vX1kLAjDWqSoRt7eBQN8vTVK7?=
 =?iso-8859-1?Q?dDneK9HXS2dSEuHjld+wfDQtjN0ycSqmN4cqXVQeHm9VKgQl4gIbony1oQ?=
 =?iso-8859-1?Q?idJK8vQbOND1nZ5jkEU02/KUvUx/wJQWBM18KhBwRIv/IX4BKFvU528SNe?=
 =?iso-8859-1?Q?VSBDO5dXOWp5nnCN3b0T5nKyPdt6fMEvHKhekMX36yxZgG/bUkEyGud4Lu?=
 =?iso-8859-1?Q?F9zzF1d1gsvgPXD3WjeG1fy8pKUAkxX/9k8plzoQiGmu?=
X-OriginatorOrg: citrix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR03MB5372.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06638622-d4d8-4885-d348-08db65af8322
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2023 10:27:49.6451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FfH0CIAt683xSBC9mXFye8EtZ4Oum1MAmd5IQ/KT7Lq/c+4Su3w6Q0c8PyRHFKj7yQbbExmqsXHJCLoZhsdCOBoZ6Pi4ev8LtRLezbrAAIc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7107
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Hansen <dave.hansen@intel.com>=0A=
> Sent: Thursday, June 1, 2023 5:57 PM=0A=
> To: Ross Lagerwall <ross.lagerwall@citrix.com>; linux-kernel@vger.kernel.=
org <linux-kernel@vger.kernel.org>; xen-devel@lists.xenproject.org <xen-dev=
el@lists.xenproject.org>=0A=
> Cc: Jan Beulich <jbeulich@suse.com>; Thomas Gleixner <tglx@linutronix.de>=
; Ingo Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; Dave Hans=
en <dave.hansen@linux.intel.com>; x86@kernel.org <x86@kernel.org>; Juergen =
Gross <jgross@suse.com>; Boris Ostrovsky <boris.ostrovsky@oracle.com>; Pete=
r Jones <pjones@redhat.com>; Konrad Rzeszutek Wilk <konrad@kernel.org>=0A=
> Subject: Re: [PATCH v2] iscsi_ibft: Fix finding the iBFT under Xen Dom 0 =
=0A=
> =A0=0A=
> On 5/30/23 08:01, Ross Lagerwall wrote:=0A=
> > Since firmware doesn't indicate the iBFT in the E820, add a reserved=0A=
> > region so that it gets identity mapped when running as Dom 0 so that it=
=0A=
> > is possible to search for it. Move the call to reserve_ibft_region()=0A=
> > later so that it is called after the Xen identity mapping adjustments=
=0A=
> > are applied.=0A=
> > =0A=
> > Finally, instead of using isa_bus_to_virt() which doesn't do the right=
=0A=
> > thing under Xen, use early_memremap() like the dmi_scan code does.=0A=
> =0A=
> This is connecting Xen, iSCSI and x86.=A0 Some background here would be=
=0A=
> *really* nice for dummies like me that deal heavily in only one of those=
=0A=
> three.=0A=
> =0A=
> One or two sentences like this:=0A=
> =0A=
> =A0=A0=A0=A0=A0=A0=A0 Firmware can provide an iSCSI-specific table called=
 the iBFT=0A=
> =A0=A0=A0=A0=A0=A0=A0 which helps the OS boot from iSCSI devices.=0A=
> =0A=
> can go a long way for dummies like me.=A0 As could some background about=
=0A=
> why this:=0A=
> =0A=
> =A0=A0=A0=A0=A0=A0=A0 ... add a reserved region so that it gets identity =
mapped when=0A=
> =A0=A0=A0=A0=A0=A0=A0 running as Dom 0 so that it is possible to search f=
or it.=0A=
> =0A=
> These are all English words, but off the top of my head, I have no idea=
=0A=
> why reserved regions get identity mapped when running as Dom 0 or why=0A=
> that makes it possible to search.=0A=
> =0A=
> The addresses and size here:=0A=
> =0A=
> > +#ifdef CONFIG_ISCSI_IBFT_FIND=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Reserve 0.5 MiB to 1 MiB regio=
n so iBFT can be found */=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.entries[xen_e820_t=
able.nr_entries].addr =3D 0x80000;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.entries[xen_e820_t=
able.nr_entries].size =3D 0x80000;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.entries[xen_e820_t=
able.nr_entries].type =3D E820_TYPE_RESERVED;=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 xen_e820_table.nr_entries++;=0A=
> > +#endif=0A=
> =0A=
> also appear to be conjured out of thin air.=0A=
> =0A=
> As does the move of:=0A=
> =0A=
> > +=A0=A0=A0=A0 reserve_ibft_region();=0A=
> =0A=
> I'm sure I can go figure this all out with some research.=A0 But, I'd=0A=
> really appreciate some extra effort from you in this changelog to save=0A=
> me the time.=A0 I bet you can explain it a lot more efficiently than I ca=
n=0A=
> go figure it out.=0A=
=0A=
Sure, I will resend with an expanded commit message.=0A=
=0A=
Ross=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3007561E888
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 03:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbiKGCLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 21:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGCLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 21:11:17 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B8FDF0B;
        Sun,  6 Nov 2022 18:11:16 -0800 (PST)
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A6EW80R002314;
        Mon, 7 Nov 2022 02:10:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=4wpf865dkuYK93cTAnK/EG9GzlmLfDM02la+KYOIJIs=;
 b=m9XgOrA589/FfSzjfNh1OnOMpRAJm3Chd5r19QFicSrAcshSiJPM1vdVoswgZBDliGsS
 AI7MAl6tx1wiMuudRatLG+v975PcHkvm7zV8/P6AIxWpgW+L0MNeJLYbma1mENNFnzjm
 onuFBsnkRvYinlUOQV8CLdMaz2jD/wAiJSf2XoHEBQN970Ya9Xpbx1lKy8v93XzhTtmS
 4YfZ4wdA6UF34zVsNVUHX9//suegbLc7Z+BFFezdVfGYxEYEq3INEqURfOsxszt4e/dY
 +4Kcwf7Aia+JeSM+A6DiAmBMSBZ1VjB06sTA+GmBb369niF/FZusgzSw9NdWlVY+AUCE zQ== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kngn5a8qk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 02:10:49 +0000
Received: from p1wg14924.americas.hpqcorp.net (unknown [10.119.18.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 90B5A80473C;
        Mon,  7 Nov 2022 02:10:47 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14924.americas.hpqcorp.net (10.119.18.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 6 Nov 2022 14:10:36 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Sun, 6 Nov 2022 14:10:36 -1200
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 6 Nov 2022 14:10:36 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXX20NUOzgyZLBm19AqJ1vB1xiXVsYS12p8n8rjAMFp/BY5YuWamDaMGOu+vpQsbvT1u5/517WMrHxrOfKdcCt3p2m1lynID892HXzcBa22kgwYtiiT4kchK6qzDLZlnM8rN/eyoiOFnykYBwwr7PNiMk2MxwV1P4F/WLYLH1bmwFBmir5aRKXL2513uK4gwSFwngjIv1p8pkIsePj3VgAGdhCPCRwttPLmaGZI1Y20bPDUfnkKxphvQ7RFMwyhVG9tRgKBy/f1UX2rwxzufewd0y7j2ySE1iI/UZaNOVa5/GxL6f89NRu4YjmMbyHTGkT7/sB+MBnUc4SEE3vFu8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wpf865dkuYK93cTAnK/EG9GzlmLfDM02la+KYOIJIs=;
 b=iGXh2V4CRvsYV76DH7XEVZfeVKJTON7bNC0cDi1Av9yga7SzjVMZMmiux7eUFYoemc76UocFxL6i04XT7m/r7JS2iU1u8JkYJ15R8JCZz2N8EYsoh99Sx75Pm1sF0UanyVO+dSObecTxbFXfcspCqslzJ74gpz8YsyQH0SKaYyIu3P5hbxaDUuejvaWurUzutpLnMVX/DbQhscUyHBBDj2n7TO4049U/1cITHHRZKbEC5YIcA5wOUYZYIabA16SJ2ucBHqaadCtRT8Bk/QTVNiRG24CGQe1xwqJuCewBe7KdJiXoM0frQWmMyGAJTBNaGJqCPmLXaqgjRHiaynPe2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1c4::18)
 by PH0PR84MB1788.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:162::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.25; Mon, 7 Nov
 2022 02:10:35 +0000
Received: from MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22]) by MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::e739:d90:9fca:8e22%7]) with mapi id 15.20.5791.026; Mon, 7 Nov 2022
 02:10:35 +0000
From:   "Elliott, Robert (Servers)" <elliott@hpe.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>
CC:     Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Topic: [PATCH v4 4/4] rcu: Add RCU stall diagnosis information
Thread-Index: AQHY7/L6iCQl4en4NUitoR4cceQrK64vgODwgAFDcoCAAejvYA==
Date:   Mon, 7 Nov 2022 02:10:35 +0000
Message-ID: <MW5PR84MB1842933AB81EECFAF2ECCE7DAB3C9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
References: <20221104021224.102-1-thunder.leizhen@huawei.com>
 <20221104021224.102-5-thunder.leizhen@huawei.com>
 <MW5PR84MB18425CBD1259317004F7771AAB3A9@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20221105200637.GC28461@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR84MB1842:EE_|PH0PR84MB1788:EE_
x-ms-office365-filtering-correlation-id: 50b43515-806f-4c94-7759-08dac06541b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LVjMJGlyYkPT0zLnuVXgNPFiEujuDOOKPjFfYeg+ypbfRMeR5i3ojZvGsLZ8EmM0HvPhQ5ZQfATg1K7Yqi1o6v6Y2q2aFm1BRF3f1bNE3om1pjjS1QLgtxj9qfFEH/gkZSzr/IzD+f0/Np+5Q/Q4USxRXgBCyNlsciktK4KpIit6QkiezDNJXNYjbU1HvBjf2JclGlmsEez8z+sq0QnkocJo+3erAY4wQskLIFaHvGLjqdxNpuWs/spju04NFWvNqz7bVyjoN7R3EyLaHGxBShTzPVlOs1gaHV5fKk+6+o8Z8Ew5mmtGLpRilul2obOIwGbbfM3nAjvwfXrdvQhRIzpRrUCFRpeMtQKAQMXxSNEyWyR//sSIeLT1mOSVMKjLn3dFJfyFth6KWH5LYzjYbZh/te9w+Rdg1Qi0wDblMXBbkw98h28cD7T+69QfsRJ9kkJcyd380vvarI1T72FvHSkHxw4tuGMJ6nxD9hlWJ5o7epculO93JdeVMxcggje6V52kdoViC6v83sxl2xviygqSzhxacye/HJCjyqWS6NhVE4u6rn6a6p+FwPOzWPOto+AszLm9bTHSsxBP3DKV6PcPjSdUkq50h8OY0QOlOadsIKIRg0R02J5cyX/cBlgGQmEsMfmvOeyHelP74GxQZAlchT/Pgq4F9cqy+YEvPGVmV4AI5tw0AGbGCmuAY/yW15DyjfU6UBLXr2qJWvbJ11FFcoNDkTlwsaXyOsFxTtiZDSqk40md/rf82xMBoPr4XrL8fO5lOQ+Bua4Gf2bWDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230022)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199015)(52536014)(7696005)(186003)(66574015)(86362001)(110136005)(54906003)(316002)(33656002)(82960400001)(55016003)(122000001)(38100700002)(38070700005)(83380400001)(9686003)(26005)(41300700001)(8936002)(5660300002)(7416002)(71200400001)(478600001)(66446008)(66556008)(8676002)(66476007)(64756008)(6506007)(4326008)(76116006)(66946007)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TCmbIFhdi5JqF6LnoTeFDvs26Ukzyv3VEEicW6SUKPA38p26BBZvbfLqNXLw?=
 =?us-ascii?Q?+pcM1yjx6N8F3/AM8uz6Z2oYFjM+lZ4y92MBSpFk9icmIlCbiJCkmObI9S1T?=
 =?us-ascii?Q?6XOknGRYWbFV18ZmQreM7IxGy6GT5xsflpRuVPPbe1T6Dk8v3onicoz+32+p?=
 =?us-ascii?Q?Nu4Rp/dUD7x7lwQlFZ7ad/9dsdxmi1l4LriRzJn9j7OiUDft6am4CtxP2fIC?=
 =?us-ascii?Q?y+HTdPpJdoVqGJIg0yj7fZcJx5hZYrS064+zDK5i+nM4JecJGt/od+2h9aPB?=
 =?us-ascii?Q?izzvr9OU0ZurIzJvVlYp8K9Y7O+MJ67iGucEkJjqqEuncZhsv2pDcVu4q3+8?=
 =?us-ascii?Q?CNJ+wHHKeJi8dneyIE9z/rMM5+fGLsNx2SNQMTMEzljlHL//W+WyRzk0ZxDU?=
 =?us-ascii?Q?3jg6FxwWTPoCEsgyq1CJzFscsPYaQgpALS5iz9Zs/pjUZWM7u4R/LclqoKgS?=
 =?us-ascii?Q?uI37WcPH+GJ/K0j99WrTu8taciGyLyhjPVzUdwLVeBijM/aeX16jiT9IGONV?=
 =?us-ascii?Q?sTnpXqHmm3eYld1KwTDGRFbC589BoCzQvnABPO+rzh5Pp0s/GdocAOyESIxN?=
 =?us-ascii?Q?FVv8YhiaFvhdcD67rdjK759hid2zdmm0i6k/YdfT1knLDm45R+qSYcHwyIJt?=
 =?us-ascii?Q?tL5BfuFkMKZCMgR/F5UF9e8G84sl6kK3Lq+QkDEdNu98ffvIwDQepZMW+OSH?=
 =?us-ascii?Q?kS3xfSpatEhUiea9I2VjwaDwfVKFFJal6+4tQbqhBM5kF9JwpyhaEV60hzBd?=
 =?us-ascii?Q?v1hvT1KWv5PGkqrvVlp+VfIzM2xnUQu26jMwQcbo1j8QXesYQfmT1LdHftdU?=
 =?us-ascii?Q?hW8EkT8/uuqGP24P+7FgmkJlk7t+sdHwZp1p+lhRDenGmxeeyqIExxVMYekm?=
 =?us-ascii?Q?lJbQhMTIZvp5XjF2w8bcTgg5YyThKH+JPjozq/ZwOGbreTWjWTmolh/b+ngo?=
 =?us-ascii?Q?NXm9Oxciy5dOJpFCWHgjsk/cj9XOoffKzerpl1h2K/ngRp/+7Ea4mDkTDDJr?=
 =?us-ascii?Q?eK8IBPOZPtgFu0P15VMmKiWEkYeN1/11Z1cbXckyC8uJXWSGDSdiFBDiaz3i?=
 =?us-ascii?Q?PXeN1azjugHhO/JNOYho3kyQchbMW0sxlls0Ya5vWPfLj5bF/EQ8AeFVTI+C?=
 =?us-ascii?Q?xzv1Y8ngTis5SYs7BPHor8qTsb3Wti/I6vlDP0xhJS041lPvhnqeBkXrsIPY?=
 =?us-ascii?Q?u+hkHQ7MjIsdxULAK4K3uWBKJY44s47RktV9y9mLM/BPtTrqyZsv+hux5huL?=
 =?us-ascii?Q?02/PCL+lToOAairzyLHEjRLxZ+neu/yAEpYUgERAqFG1npVdVPKttVOnvQRF?=
 =?us-ascii?Q?SLvw4s6DI6fM5BVzuUw0OsVXOvYDXQJ8HLemZIezmvaZE3vmEr6WZIrifRTH?=
 =?us-ascii?Q?VY7qGV9N66p37miCzzkkdscCS43L1foDgySyShWzXslNE9ojNqk7iLdmfo0X?=
 =?us-ascii?Q?0hF5ogYmgCuFu0HHf4pBRK6A7Cs8NSfny53sv9oefjVOV2XA6Y660tKe2mYW?=
 =?us-ascii?Q?+S8uSEL6udJHy4H1bErXxon/gBxi15VJwOR3/Rg7vWDJJllaRYas2GX45rac?=
 =?us-ascii?Q?qt+43nZckgES7rkhl0g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 50b43515-806f-4c94-7759-08dac06541b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2022 02:10:35.2585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Z45NlC958JggRx0yoXd8mHD5aIPgk41Cs+Emldq4x8hZT04uobyjZ5cs3L5e+2W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1788
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: MCiqBmBqu4QOBUw1LDszp1UMGMPDknQ9
X-Proofpoint-GUID: MCiqBmBqu4QOBUw1LDszp1UMGMPDknQ9
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-06_16,2022-11-03_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070016
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> > > +config RCU_CPU_STALL_CPUTIME
> >
> > Since the information might change and grow over time, consider
> > calling it "ADDITIONAL_INFO" rather than just "CPUTIME".
>=20
> Except that I already redirected Zhen Lei from a generic description
> to a more specific one.  The reason for this is that I already get
> complaints about the large volume of output from RCU CPU stall warnings,
> which suggests that unless the additional information is quite small,
> it should get its own Kconfig option and kernel boot parameter.
>=20
> So we well be keeping RCU_CPU_STALL_CPUTIME.

No problem - CPUTIME is easier to search for, and will likely
always remain as one of the values reported.

> But please tie any such patch to an actual use case.  After all, if no
> one actually uses that additional information, we have irritates untold
> numbers of electrons for no purpose.

I've been working on fixing intermittent RCU stalls that turned out to be
caused by x86-optimized crypto modules holding kernel_fpu_begin()/end()
too long and crypto tests not calling cond_resched() often enough, so am
interested in features that will help identify and prevent such
problems.

> Also, some of those functions are on fastpaths, so adding unconditional
> instrumentation overhead might result in an objection or three.
>=20
> As always, choose wisely!  ;-)
>=20
> If I don't see anything from you by this coming Friday, I will fold my
> usual wordsmithing into the patch.

I applied the series to a tree not including any crypto module
fixes, but an overnight run didn't trigger any RCU stalls. So, I
modified the tcrypt test module to simulate a problem by
running a lengthy loop after kernel_fpu_begin(). =20
Here's an example of how the output looks:


[ 1816.698380] rcu: INFO: rcu_preempt self-detected stall on CPU
[ 1816.704368] rcu:     0-....: (2999 ticks this GP) idle=3D1dbc/1/0x400000=
0000000000 softirq=3D39683/39683 fqs=3D751
[ 1816.714200] rcu:          hardirqs   softirqs   csw/system
[ 1816.719922] rcu:  number:        5         10            0
[ 1816.725643] rcu: cputime:        3          0         1492   =3D=3D> 150=
0(ms)
[ 1816.732669]  (t=3D3030 jiffies g=3D89765 q=3D308 ncpus=3D56)
[ 1816.737857] CPU: 0 PID: 46826 Comm: modprobe Tainted: G        W        =
  6.0.0+ #5
[ 1816.745754] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10=
, BIOS U32 03/08/2022
[ 1816.754523] RIP: 0010:rude_sleep_cycles.constprop.0+0x1c/0x30 [tcrypt]
[ 1816.761290] Code: 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 0f 1f 44 00 =
00 0f 31 48 c1 e2 20 be ab 90 41 00 48 89 d1 48 c1 e6 0b 48 09 c1 0f 31 <48=
> c1 e2 20 48 09 c2 48 29 ca 48 39 d6 73 ef c3 cc cc cc cc 48 8b
...

That makes me realize what "csw/switch" means:
- "csw" context switches applies to the number line
- "system" applies the cputime line
=20
Maybe this shouldn't be a table? Make it grep-friendly:
[ 1816.719922] rcu: half-timeout counts: hardirq =3D5 softirq=3D10 csw=3D0
[ 1816.725643] rcu: half_timeout cputimes (ms): time=3D1500 hardirq=3D3 sof=
tirq=3D0 system=3D1492

The new prints interfere with existing prints, pushing the "t=3D3030" line=
=20
further away from its context. That's from a pr_cont. Existing prints after
the "self-detect stall" message all start with \t, so they are roughly
related to the first line. The new prints should probably do the same.

Since the first line ends with \n, the pr_cont will never make it on the
same line, so it might be cleaner to use pr_err instead. That way it'll hav=
e
the "rcu:" prefix of the other lines.

That's from:
        pr_err("INFO: %s self-detected stall on CPU\n", rcu_state.name);
        raw_spin_lock_irqsave_rcu_node(rdp->mynode, flags);
        print_cpu_stall_info(smp_processor_id());
[that's where this patch adds more prints]
        raw_spin_unlock_irqrestore_rcu_node(rdp->mynode, flags);
        for_each_possible_cpu(cpu)
                totqlen +=3D rcu_get_n_cbs_cpu(cpu);
        pr_cont("\t(t=3D%lu jiffies g=3D%ld q=3D%lu ncpus=3D%d)\n",
                jiffies - gps,
                (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_stat=
e.n_online_cpus);


One other print has similar construction:
        pr_err("INFO: %s detected stalls on CPUs/tasks:\n", rcu_state.name)=
;
        ...
                                        print_cpu_stall_info(cpu);
        ...
        pr_cont("\t(detected by %d, t=3D%ld jiffies, g=3D%ld, q=3D%lu ncpus=
=3D%d)\n",
               smp_processor_id(), (long)(jiffies - gps),
               (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state=
.n_online_cpus);



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D170A6650E1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 02:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbjAKBIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 20:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234570AbjAKBIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 20:08:18 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98AD842603
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 17:08:15 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30B0PCpQ001159;
        Wed, 11 Jan 2023 01:07:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ODgcXo9CBYFEvUBXMqFZ99jiyuSfmPV0K3t9gatDcd4=;
 b=hsmq5I5G5tbJK4zhDAwMg66VAm2Eq7WUkLctKuBJPw3g81pNXNu7UZyoDpEaOkBMRwJr
 snEJj+GdkWkEENHmPz8fsSMSm+iqfQyXC7l8z8g6iRP6Mp+k34hi3k3t3K/0MH3HD1In
 1kGCSqGi6hqPB7miCcn9AQ52KGitxgm8h+TvvIz56C1JZhorBw2cjUzH6a3kD+CZkcs6
 Qbb/nPA/KXf0eyVip4qGpn+e6/juFF1IsL2SLOhAh1TzT5ebCxdzQGxj1qE/GdSt7dUR
 /DxLnW7yGc3etNoIjBt872ZSprG4pTrxghwTkkaUXgozBkf1C8uGY5mtWkyvlCKRl0CS yw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n1jhu01yf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 01:07:50 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30B140Ya040703;
        Wed, 11 Jan 2023 01:07:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4d05ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Jan 2023 01:07:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehS1UhVz2zbabnRByqOqszSPwv41JPz/8pqaIC5aHfMZWIAHPAq3+JmWiJyDxGWD8paJ/O3X0ls/Gf8WCeiltS6gG9pm0a9ei3TQx/SbCIC3pTwqMArYEIL0ZTtjNH6E1Sd6TBFaC5oxkb5gQdrqzw0ufUNbDQUcmYsk8BJEegoZQksFP0eDKVVTYmePGMuqHwA/DiYVAhYQMdh3NXVBblXGWjbBImp2SLJObbXqhrq7muH/AqLVyAjZG31S3keKcqk9tLQcVBYBLdB1sHZVH1POHQ6rjxPbCMMS9S53zCDY5EvqOim6hwgP7t9mIPOCZb62/OXZ8bb1i/R6TCus3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ODgcXo9CBYFEvUBXMqFZ99jiyuSfmPV0K3t9gatDcd4=;
 b=hMcvZeiSzw6ujquM5Le73Yw6Eu/le/6P+bk0P8/fTjbqyF7k/2rtaaAemiE+1WT9wWt/PQObyvLSo9n5u+8Gk3MQrPNGFp01cacvo18bUi078ZzieBR2yyJm2+sJ4v71cK1+uZVsPx4PAEpKQcus6OJ9a+e8z7OpH8ZIF/XUWomW5MBgg3VfL9PW09Zu8tkSaG9YvKL5XIO5APB/TrBZunCfyekbDK5lDvgz3dFm/l29C6567Ya+BE3VBgQ8J9NgCWzLwZDW9lInWpJW+1FNRsiFJG+enoujte6g1Owc9IazCqvA22UInKmtP7+XP4gTGbALQMAd0qUo+YsrM/Fwvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ODgcXo9CBYFEvUBXMqFZ99jiyuSfmPV0K3t9gatDcd4=;
 b=iWHagZ/9JWmnXaGoX85rtQuRzIXjtK4RQ2Dbe6vHSKSmwtg7f9FWY61vliSpNS/V8KmpvWdyUh4UcDFpZna9JTojOOQvYKcxkg4WiWlBs9K0JDBlMc40nBI8PCwEiEjJzZ5HWc9I8YvfW0Ji6jy6oGNoEkA4M6FIK8BzWvPr9pw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by MN0PR10MB6005.namprd10.prod.outlook.com (2603:10b6:208:3cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.9; Wed, 11 Jan
 2023 01:07:47 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Wed, 11 Jan 2023
 01:07:47 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     SeongJae Park <sj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Topic: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Index: AQHZJEs16LTgU8asl06B/cuTn0zvJ66Wdu0AgABH6wCAAADcgIAA9UaAgACWMICAAB54AA==
Date:   Wed, 11 Jan 2023 01:07:47 +0000
Message-ID: <20230111010744.tyzjo7noocm6owko@revolver>
References: <20230109154012.3342cbb91defbc485db641c1@linux-foundation.org>
 <20230109234317.1408-1-sj@kernel.org>
 <20230110142109.gphhirh7jo67br6x@revolver>
 <20230110151841.149f2bd34dcc7ebcdd6bbaad@linux-foundation.org>
In-Reply-To: <20230110151841.149f2bd34dcc7ebcdd6bbaad@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|MN0PR10MB6005:EE_
x-ms-office365-filtering-correlation-id: 8ba1d42e-b55d-46ca-9598-08daf37040b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IS0KCONtIrAAQcdnnUhDo3G8OT83g15bDzUIHb6SFlexoWQgeRFul5zJkEC0ADMze5yV7KcTxJ/QMyoF4N5F82E5F1dPpJiegUn191RfsfwmXOsOI/yEPuHzLTxVciklBI/kABr9vKL/1Fe0hxk/uftBDUrcfv4dHqAPiZQryJvRFBTGr9oiqTvMDxwmdwSUBdrSACfyxQeysUIb5t4bBRMidSFyecHFyeErls3Hh3Nb2z4q3LH868PmG6cUiTQwg7c9OjVvOr/l6PW3ay3aWSv3sHyspXaofLtMPR4j0/e8YtJyGimIQsYsdqCG6WpcwNJiRHiERAlj5FwLt6NARYo8L2Kpa5zIdnK/gtT9pmaii26ATmCvZwiddN10kRm5asHbiXzYt47R9TcHN2DmcXCYZa/rapt50ECmKoOWUyDoTpsTIjbraUQB0kLHrRo68oPi6aD+BRdXgx64ufVGY+Shkgc9Ng0KADFqjYtxYK/LOvEl6B/RoYQR2fu5z58Y6XckSq/DcW/OtrjHcrxadiMlRKB9jP/zq+GCO+jSkZwSjZCQw60smtycqBxPIJ83KWjtxh4FJ3cngjyTrA1zDnxDsRYMIDXCo8gGzsOSTxK9D1fi6f/YT1l3hyWyc8u6k4bMoHwa+lhX0tWSHQJHNGp01z94pkqBb6LwE5h0aYoZQD0Kjd/vG0HPCoc5ydh0Ia+fPGmOZDvbJy9rVyf6xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199015)(66556008)(91956017)(41300700001)(66476007)(76116006)(6916009)(4326008)(8676002)(64756008)(66446008)(8936002)(66946007)(5660300002)(316002)(54906003)(44832011)(38070700005)(38100700002)(86362001)(122000001)(71200400001)(478600001)(6486002)(83380400001)(2906002)(6506007)(1076003)(9686003)(6512007)(26005)(186003)(33716001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+wdeJw/i3LaQkF8wDpR21JmsvcvBTh/5V1DBBHsUAsQ1x/jsMtu9qsx1AZ/h?=
 =?us-ascii?Q?rFjb6+Ln59r+MWNQwqwA0qE/vm09B/uZgweFuKruZgHc3wvi+jM2ZZUhh3H/?=
 =?us-ascii?Q?/IgU1QNWDzcEUgLlpxPG9CklsCvkagQ/Vu2ek7ed7eE38zgqpXoxW/r6gq/k?=
 =?us-ascii?Q?dBHmmqYb/yKVrRTaHIKOmE6qCcg9sj8dBMfA6iT1CK1DgqbU4sWEBk6eVVGm?=
 =?us-ascii?Q?UvVmHX/qPONqawVUpa4O4hcfg0BEa9Nf4mr+FFCyDbx7r+SPu/jOd1krIhAq?=
 =?us-ascii?Q?QR/gLoqArC0fL8ckZbgn+2/QcqTCuha6Wak2mDUOhg2Sm1Nejkofg2JZr3kT?=
 =?us-ascii?Q?QcJJCzijhw5wbRLc+0Z+Vppq32aACM0IO8jYY4vZQM5x2WAlEi2mDXyn6DcY?=
 =?us-ascii?Q?eQzVccUXUTN+DA1JodbQIh1Q0wXUs9M4rpxKG53PBI4veSpLnbfGFLDsO1Rl?=
 =?us-ascii?Q?TJMeKYIpuACa6mHb7gi8sOBiIF3RXyMDHUf3XASUeNCQXm7Lb1L53TAsVZDN?=
 =?us-ascii?Q?bB/FSMYREykEXLpA64MBxV/pSG6O5ic8udPWqv6k/6c8xscnQMyc2w4gg2l1?=
 =?us-ascii?Q?gj+3/w1/7gcypw+Q/x0xJkwo06p7DAy0+yIGJVUxkCV+YtKX6aDiPm7tIu+K?=
 =?us-ascii?Q?QFHa55Cf+rUZhtJuz6cLEJLTghAWn1waFLWQhYekMj7nBfEdA5l6rjqc/RXa?=
 =?us-ascii?Q?UcmBIURrQOx3vVCCefG/9J+sYFFyRYT/6QT1uShzW9U7UAEkZKjhJfR0tAHJ?=
 =?us-ascii?Q?DFoD/mMZQEq50hHbhDeS4jLZl5V7cZiHZUtkP/K4II0p+xVVQ+EHTye8kjue?=
 =?us-ascii?Q?yagr4abWEXTHUuI79RP53SvfpZWRijrkLVJtSqaHey0CLWDXu11JEsqdww4N?=
 =?us-ascii?Q?iM7jN/I1TsW9wIfbjh2zlA6XMSUy56SkEx2XjHzWUNZ7Wdlg3sUM+f6v9P9e?=
 =?us-ascii?Q?O6rWWBJzRBG9MxPean3wiZN3Q3aO2fCSIEyilL/i40kvrwFfv55AOe+X+Vhk?=
 =?us-ascii?Q?Di8zV7GVD06ReJUXNbPKoW5If9bPQZhELe4WMssZo+nfkf0gRdJN/ryjPAla?=
 =?us-ascii?Q?zgYLLJtGJkpzcGrgGEtyACEkSWiudsNAsP7Hf7zQvHwg1zCCcy4dEruMBeEU?=
 =?us-ascii?Q?h+fkD4Y6/0nlHiohTIz19Yg1mwpDCWG9DrXqaBVs3eBU8SyjVoJFSs2o4QJs?=
 =?us-ascii?Q?sk8DWcfflMoYzjQ3ucKIZLnSu/jCv5VqaIdXg2O4YQ+7rJB9KadYBWhLq2/z?=
 =?us-ascii?Q?WiNlBeIVsROXPxgs1gaOZtyJZHNh9/hIGBRFc/jOYusLbcFr9RcDMfPO1GET?=
 =?us-ascii?Q?SCAOy8xc2fwqTVPqncG/QVMAaObAv+3hs7/nyyfrnJiJQCREukuVU0VB9LLP?=
 =?us-ascii?Q?Ro7Czdu1Z5LUcT5Ulp5MKSBVQzQR+1LMmLUSgPNklCAstPNIc+RGLoyA2jAZ?=
 =?us-ascii?Q?shpOuL8kT4s5qukhffii+dIDjP4TrbpAnbPtBZ5/ORC3CU0HWo1T7AxBSMoE?=
 =?us-ascii?Q?TzVr70UxSUmlFxHVewmWF8/6B66ywBhbe9EQpp44gRyCZMkYfx1Zcu5PDUZS?=
 =?us-ascii?Q?aGWD9afavhFobLLNn9ueBIeYQWVYjsfueeNwlHc7vCG8BJ0c18Qz0f6+wG1L?=
 =?us-ascii?Q?Qg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B189A25FA25E87459571E0B7397983F2@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: bXu4g2ekAlwWbDJ0bolhdmX8fbtbeOunoSq0cfmi08lNm78yBYS3MRjgVlV3UmngjUtVTH0+JKJhJ8aToTFRge32VZuTlBJho2N1hjyhJaWXM0YmWz5HrPA14MmC7HMhwMdUZFi3d1YJmNmtKsoTcFQrvtAeATQBYu97QhHpuz/K9Hu9sQzPxV9FkHUOc42TC4tfvtP7GJpQZyopEG8VUZ3bJV2kjPpmANQvjRWJ+ghM7+S8aFLzUIZbQCD0gsUcz8xlkBigCk9S1R8uZ9WwqzKO+OuRxMKKpot96EJSqN+uQRaaLqiOTXuMP+3Ms+ZZmKHaIO8nXz/iTFnxHGvBwbrhZrz39GN8O8rgiQjENuUDBwFiBoorS7eJbqZIFzLa9SG7qMc7MqEpflvkcqnQxsElJAGqp4hYprZQLG1/MBahJqlsYI9SGgc0A3+tLQntXnlALESPqqWh0RFOVmZ5R619S16tCuTa0ePcSh1dWxtrJ39dkV9bah+KQ/ilRllvTGQS51LjED0UySpVj0g4mYho2UYX9TGn2/lYZkmyCiSBxDAGYezSnhnFP1iG+XIg5Yc9hmCLEyC1eK7EA7uxHJ6AvrtXeHJgBILshJ1HL9q1Rkw+5WwSvVv272UlYxtMPYqLOU9bSUb0ujXKP8W+BJMKo2MBXyFKndJJrxZuLrAtBA2wQtgPHCGYyHr1Wg/8ukMsc5ToSq89l0WpE+vK4zfsaZrCubZIQ88oEYPX2nzO6fPSU5o6XLVRpfqFhsNgtqbJ/BNCrVu3/ZbiuzALt0FUwCQivziEXmXdf8MUX6icLdlcdR7k8muPuUnX2tZEwkwEJ7Y8bXsGUwkman/jWzg83RIHvgWu7ZL04GderB87KvBtwAiW9TeGjvxF5tghaC/qsgQ0b5qWQVmkw5T303bnO4o4Gb2DbgHwqARQ5uQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba1d42e-b55d-46ca-9598-08daf37040b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2023 01:07:47.3784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZbJZ4T09kC9w7zssbjdVZ6/8VkHhHkt0+YLE34AKNzQDWL7s1AmrzOgP9a3F0Dcnpj9fSMgnTZh2CSLvOJPhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6005
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-10_10,2023-01-10_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=742
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301110005
X-Proofpoint-GUID: XI8N18E6WYfauUlfQfUC6Qo5aNx0jVM6
X-Proofpoint-ORIG-GUID: XI8N18E6WYfauUlfQfUC6Qo5aNx0jVM6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton <akpm@linux-foundation.org> [230110 18:18]:
> On Tue, 10 Jan 2023 14:21:15 +0000 Liam Howlett <liam.howlett@oracle.com>=
 wrote:
>=20
> > * SeongJae Park <sj@kernel.org> [230109 18:43]:
> > > Hi Andrew,
> > >=20
> > > On Mon, 9 Jan 2023 15:40:12 -0800 Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> > >=20
> > > > On Mon,  9 Jan 2023 19:22:48 +0000 SeongJae Park <sj@kernel.org> wr=
ote:
> > > >=20
> > > > > On Mon, 9 Jan 2023 16:55:42 +0000 Liam Howlett <liam.howlett@orac=
le.com> wrote:
> > > > >=20
> > > > > > If an invalidated maple state is encountered during write, rese=
t the
> > > > > > maple state to MAS_START.  This will result in a re-walk of the=
 tree to
> > > > > > the correct location for the write.
> > > >=20
> > > > Can we think of a Fixes: for this?
> >=20
> > It wasn't really an issue until I wrote the vma iterator store
> > function.
> >=20
> > You can put this before (mm-unstable git id..)
> > 9df3d25a97ec ("mm: expand vma iterator interface")
>=20
> I have dropped "mm: expand vma iterator interface"'s series.  Should we
> retain this patch as a standalone thing and is the changelog still
> appropriate?

No, just drop it and I'll re-spin v3 to include maple tree fixes on the
top.

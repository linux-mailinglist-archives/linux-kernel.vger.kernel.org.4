Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEAD66D457
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbjAQCfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235355AbjAQCe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:34:26 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE08229E3B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 18:34:24 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30H09Urf005545;
        Tue, 17 Jan 2023 02:34:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=i3H9gUfYFOM+Ivkc7nM0n/EQWMB3nORkpZUrqw/ZgU0=;
 b=skXqMcVSId1BqkDDArBq5UpSMGdd98cGIIfkWJbkqZ5gxEmZr4SzaN7r8PeSeefY11gZ
 J495AfXggwIFLrAJthULlFxsJfa8cV10wzog75jt/lDxxRDFSZhz/SUwJ27HjIIGfYSK
 ryE5uZ1SauIE0lTSTArA4YOdrC0EX2Latb1+ABTcr8Qo+NRMoZCQkSIAmja/WIVteXCH
 +qIMnmUOTvGoHh92uE8M19uIvybwsmY4u6lg6Hi+bFxNQudo02YoB+8Nwcy1tFpNLFZa
 nEy5kfjMQbXQevBPJuK4eYavAS5xb4UGtIgHe+mx57C5dS/serGYWAGUXwACeBvps2jF PA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3n40mdb5e3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:15 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30GMM4rb028480;
        Tue, 17 Jan 2023 02:34:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n4s2rfxkx-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Jan 2023 02:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi8745pSUfeMPeELCo4ewUrN/8Vn4I04hVxg25rmvR7lXvvnoCC1g32BXCmQcOhnMKIqDjqUBCyYN/ReTfx8sqdNmuRorf0xkWsdEWVbWLSTUhaOHgAtwVh33h3isbpMpbd6xWBVKv4GPav51h/S40F8bCHWkfN9TQKiBViQI4z/H+Nw3FuwpqyajHrZOyL2gaVG7BhUlY296c9UCQDPK6GNe1YkEdo7MS7TNmpafySCkuDJ4Wi3T6qn7dLBJbKwehXfu2Uz426+cT9lMKzV/cInBJfuYCLxpNpUCPCfE7vdmeUR4t0SKEDz4ZvbSe9iR9Rvk/4puKqoO6PR0mlMhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i3H9gUfYFOM+Ivkc7nM0n/EQWMB3nORkpZUrqw/ZgU0=;
 b=AagIpPv8SglLoY7dyxzoJEDjgp7Cu97f1SjWcrgqv8tuynuwtmVdAmGaQg0VTebQ2xGa+RNxsxD2ut+H/nxNkUe+hqm8H9pPxvP5zGzk9nnl/wz7SsfpAqGx1GVHslKbiOJhS7R1gIFZGoxPIi70LniQOGgcIAULZgf19CxJWUF5ynweJQRqLk9+27Hjb9PE83QcybhKrvhXoSKGdNvCIldhantpbxMk9TaLcMUfrDFbAstuWqfEF3dOVbapATakxB8nbmhbAb5tTIz0oQkgTC0cSVnn476SB6pV3AWa0++5hYKKmihMfJW4hDZv15Q0CUPTP1VUEuRnsOUqGHiE/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i3H9gUfYFOM+Ivkc7nM0n/EQWMB3nORkpZUrqw/ZgU0=;
 b=cLFGXWIemS4x6C/DM5Xm9YNQvItKI/NeBnF4OGpcB3B5JPazFOaehFi0LymFhhpggOciz2anoNfjVS5SD+PgOVcvj921x1Xb7uqarPK38lC22JBUsFr+2+R21Z/PCGIBVz/ZTEV1u5OIoPm5ud1dpUtHrOJhueqP1x+xFcIqXCw=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CH0PR10MB5356.namprd10.prod.outlook.com (2603:10b6:610:c3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Tue, 17 Jan
 2023 02:34:12 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.6002.012; Tue, 17 Jan 2023
 02:34:11 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
CC:     Liam Howlett <liam.howlett@oracle.com>,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH v3 05/48] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Topic: [PATCH v3 05/48] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Thread-Index: AQHZKhwuta7+AQoZ00W/1/aoOxpVew==
Date:   Tue, 17 Jan 2023 02:34:11 +0000
Message-ID: <20230117023335.1690727-6-Liam.Howlett@oracle.com>
References: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
In-Reply-To: <20230117023335.1690727-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.35.1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CH0PR10MB5356:EE_
x-ms-office365-filtering-correlation-id: 0f4194b6-6586-46b4-c09e-08daf8335140
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vbZmXtzbHGaGIbJR1+y5sEyjnVeqQPtTz5aJD2/Wf9PrHrq8AUp7jbRA5kZMUQGXgVsZ5385K5qPqk/IXBv5HYF4dpxtDZgKbXMRbDJhJb5QpWo4WkCCgXR0joeYpnDQZI6AAf3e4A/iV1Yatosf9/RDtRcneQyZVHvokVstnaLzQQ3xOaWU6JDkUscHGCGZRK0nh9JDwHA/oGFAZNgSAXpB2ZBJ4oODTDiIkz3LT6VXEqPzq5KdNgwCW/3aVfBA4s58rki1JG9JVw4h4c82LOGrflch03oNCrc9j2YfhXsAAOt23zY0rlVOMvKwi2jxoJ+Xvlhz6P0CvRx/xgF65Epj9kaSF3gse2CeW2H8fChxF/4WfTE0OuTKYVjpqtjbj9iCunDSsxCpjqYYm0InA2D8hqLpSdlByENW/LA73/AHzvOJjQOgPGNZGisnCLVTnmKa26fwMrMoz3HuL2ievaMqNtG1N3GlyAUn6M3/6WTywAwzQv6exOQ0AdJ0JIPucLm/yobca0W1KAV0R71XMO1i2oG/7XjZOSJyoiyMQaSrz7ZRCE+gCw898BdH8Snrb/MJeXn0mBj3pApbLbEnt66J+2La158K2K/if9y8mAJUkfhbkSpOSqhTkyW6Zu9cWUcBuka3wIvSCRZhMzu0d63kNK6DwT1n2C3E2UvaVnUUhx5vobdcNWv/6jyxAHOCQBTUnC7zCLuyy0pSpP/u+EwimmKD14vGfxF7eztOMao=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(396003)(366004)(376002)(346002)(39860400002)(136003)(451199015)(36756003)(38070700005)(5660300002)(8676002)(44832011)(8936002)(4326008)(76116006)(66946007)(64756008)(66556008)(66476007)(66446008)(4744005)(2906002)(83380400001)(38100700002)(122000001)(966005)(478600001)(54906003)(71200400001)(316002)(110136005)(6486002)(86362001)(1076003)(41300700001)(91956017)(2616005)(6512007)(186003)(26005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AYieW8ecA4AXJiBbOuygEahXj3/kfPhGC+YqYldoIixvzJFGJQQd+P00td?=
 =?iso-8859-1?Q?u1pZZfMUhD/iKm2tEEBh2pMbFQYtXf0emrevqindlNZee07Edlad9U9Z5t?=
 =?iso-8859-1?Q?T6tFD4y/ynwKfiSK/YrssyWFkumHhAJZqTs7dwR3hJ04X/egg1TgELOSfe?=
 =?iso-8859-1?Q?W2goGggXIUPTGcQWVJdzRkVpEf43BsFwCD85Ihr9FtjmyM/q3uTHyZpflQ?=
 =?iso-8859-1?Q?+xJMumvVgS8aypjl+eo+t8CZ5kFEW15Pwhnyl8jMdT07rdUp6IoO7TVsFP?=
 =?iso-8859-1?Q?OxF+p2UTzQcUlXjipmVWQIaOR0O2qt33KBcgrKiTjlqJm9fv9JcwdCDSTR?=
 =?iso-8859-1?Q?/2C/+zbjbjRDd8vUpdd2qje/aGykU8gtdO+TdbQywDpls4wxUh0pA2WK2I?=
 =?iso-8859-1?Q?XYzJBI/L86orNoLeLksZj9NgNbFvJr4G60z98I4xffVnZFIQRaOdqOIWpT?=
 =?iso-8859-1?Q?ogMNoS2osXjaVean2BOIO7ZhAQbFcdNBqsOaC8IjYm5ZmznsmQt54lkAo4?=
 =?iso-8859-1?Q?v9gXdqLzHGHcWjemVpgEhuyfr6FLYEBodCRhWfPyxMGfa9tZU1N4EFw9dR?=
 =?iso-8859-1?Q?putzam9GWK3ptgjBDE1ZazOLz6T7EFZs3GPyBGMFkDhDDzhctzm4pNqKC6?=
 =?iso-8859-1?Q?wVwn74XWgn+J50NN/rSgClZXfx/8y2N/VnITl/kQSZG6RQ6Qs4tRowtSW3?=
 =?iso-8859-1?Q?XbFNcF5cyuvgL2b961c7vst8N9UQFE+yWTWkjlxQRSeMxRNqTM4qcnDVf/?=
 =?iso-8859-1?Q?si2Le3BGuBoLDT3KVH2s+9wkLBOfaMYg/vJF2vIDzD7VStOeZw8N7BYw6f?=
 =?iso-8859-1?Q?M1h6b+aQcHZJJJoSXASLJWc1PklLaJnJy4vZnpcyEjpyqUWK+F4Elu5Jy/?=
 =?iso-8859-1?Q?M9a9j9ueGlLWm/wTHXpTciLntHKMUBa3xf6yMAmLcHwXaZ4WAZdxRszxif?=
 =?iso-8859-1?Q?thdY+Xa+jseT+P50GJG7ONQaisoQYX4QL91WkROeaKWxVswKsJMXo5k6gx?=
 =?iso-8859-1?Q?rD8SM49oPp8MaYQAMBEdR3wundsFFXks7tLw0HIaNdIYv57d/RBPrGDPRJ?=
 =?iso-8859-1?Q?2rTbLFV2v7B0itU0AFdp64C93BkVR82y4x//p0TkVtE9ARmEpjduAGG0ZU?=
 =?iso-8859-1?Q?UZ1Urbw1GZBKYHx52rVoAAQbOGLTfHh1QY94hDNkB++FKhBFl52bxaEeKW?=
 =?iso-8859-1?Q?ur7K+hEo4aZYOcyjd3kRzZ0pFKBUVR5qIiXbCImZEqzdbyJek6JfnosOvI?=
 =?iso-8859-1?Q?llU0YxugGlGE/mlhLnOVfbkOsSZ/BV6ape7yDvdjyr7msXnpti0ow5gsZa?=
 =?iso-8859-1?Q?wRjtVy81A+G4Q4JFbNQ4z33LUY/5DYeebYuMBG0534P9Uw3Duu5j+PDPGc?=
 =?iso-8859-1?Q?XxoXn4yc0++KWfsVE2nXQO6kih1G+WKjPibaZ9uBD7HFmWb/DQy3SWVR0b?=
 =?iso-8859-1?Q?wEF7mFWbFctIkMaa1uOoJGoNlJdG4ac5HUmDe3Kw8RVTHQpirIUfQcDxnZ?=
 =?iso-8859-1?Q?PX//a/Ct8Z7/qWtx+fJ5T4WF+s2hTtw4tkMmX+RlUa8WMqXMpP6e/C02VH?=
 =?iso-8859-1?Q?pyjqRFQvb+GYq0EROOTWrEarhI6+AkQuSzOSLAP9zkCpmrna+BK7wuDSpk?=
 =?iso-8859-1?Q?0qJamcKcJtIBfx9dTYF7t0ORJ5JsnLmWqTUSKjltjqRgMzdhKm7hvVRA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cBWWSQfgWh5PadCcbkYTK0S1HYdR7dkl8msNJe2pA2f9eP+Dh+FGkVt99NCWZgjCBCu+OgbqLGyxtrIp+lgezbhvbylM7UErafMxTn5KwiDAEP+zJ1785iDZFV78bi9CVrFRtNYezXMCEoowRu9fXbApfeJ5NS/BN5X6xti9wHw5C4qkl9uG5l8h3Ns/5ibGgYawGOD6uj/4xxRTAmfgAVJ8iEE5bcuwYb/ufWz0jnH1R8ojnaDbNWCTYfjG5bwSkMFnDfiU3jAKWrtKFNJfK4Q7jqbwrGOe7drrJIazJoMmuKJIk0C6lYwCc3Ah3vQQC1/j7OloZn6JUM+hycuSnil6fcoJ+87UUIG8V8KrTOSK/8u18MYOFaglqaKmsjD9TkipOGwaXfOt+VlL7bQ02bkIN+uBw7waiDZNwYylfPf0V2RJuXeR0viZpNpJClgRGyKBWrf6DrNZBKOYXQAT0xD5IlteCGz3ya+RKWRIIyluMHaK82CX/nXo8nzEsN9ZztkBu4kr+iNC4eythOvEWuhINQwomLhR76mL082UFnIWDMbh9i7VHOzCGZFn4UVvHZlr0XrTitllEn2Zt2AMOJkIZZEArWyC/u+nS4jBqKdxcaUrJDOSWRvIPtA/497DbbYkO4xgXcZnp0gIKezClR8PRlvAMHxeJz0GotHF3Aq7NEtGjkpNYm+vBCkdXXzzeoszGsfR/iIjKvTrsCjosR7jeLUqnjPYs7tE1agbhTzIjFFWf4IYv1SGC7VAgwLRBc5N+wvoGMnlEG3zzINOri7+Obm2tEp8YRTqVPppIdK/4jykWdFtUZhRkaILz+xeNOLDm6RbHohCXB/tpGkDCkS67qQ5jZYzBldhmXS7V/1sfbAOVTf2A4W2g15zz3gFplOq2vJHYT30+MJn7FlBfWY1utC6oWbNgD3xCTRmphs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f4194b6-6586-46b4-c09e-08daf8335140
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2023 02:34:11.3596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ik2MlgfA6J+16L1yAXOrF8XiVabmlGtwJx/lg10WExxCR0nnzBjVIy/V94BGgeUrg0QPAfb9pIzQtsifE4qaxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5356
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-16_18,2023-01-13_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301170017
X-Proofpoint-ORIG-GUID: Fg17NcaRt7B8R0zc6Xt4b9MWqm06Omc8
X-Proofpoint-GUID: Fg17NcaRt7B8R0zc6Xt4b9MWqm06Omc8
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

If an invalidated maple state is encountered during write, reset the
maple state to MAS_START.  This will result in a re-walk of the tree to
the correct location for the write.

Link: https://lore.kernel.org/all/20230107020126.1627-1-sj@kernel.org/
Reported-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 9af88726d88a..03429149870c 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5619,6 +5619,9 @@ static inline void mte_destroy_walk(struct maple_enod=
e *enode,
=20
 static void mas_wr_store_setup(struct ma_wr_state *wr_mas)
 {
+	if (unlikely(mas_is_paused(wr_mas->mas)))
+		mas_reset(wr_mas->mas);
+
 	if (!mas_is_start(wr_mas->mas)) {
 		if (mas_is_none(wr_mas->mas)) {
 			mas_reset(wr_mas->mas);
--=20
2.35.1

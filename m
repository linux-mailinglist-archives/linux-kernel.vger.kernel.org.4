Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1C66536AE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 19:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbiLUSxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 13:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiLUSxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 13:53:50 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A95BCF0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 10:53:49 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BLHDlKx012260;
        Wed, 21 Dec 2022 18:53:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=SRDa8LugfJbUJ6RaP8e7+UipuPFiIv0h73/rowDQs+w=;
 b=llhiwipp0gnx1JR2rMRVHL7/ftnr5YmWK35pAAkDY2T1Mq9Cl9s1F/cn1y894DPXfT4v
 JI9nZDGhrHmQbemrKkGUS9rCXqI6jmnrfz2+o3JFiTFA7sqsNYAsOmqRTzxJ3jTyam5G
 IhsR1FrVmbtz660tm8hzsn1FVGbU2r8bl720ffo0XziK1JqwX5kxs4eqXPcQ+5peH/RR
 zX4LIOeEAzlx5qywJW612CG4tKEu6zU3/zWeGOqDOtBwJ/OWHlDulSDcKnKLt1ISXmEK
 Lh0TviFyqoOLOaGbsRk3yvbZPc6aZvEs0XQ7ZxUFk/0WxOO187orw57K3KlDAZgkaJiF mg== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3mh6tm9kk0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:53:39 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 2BLISfvj003467;
        Wed, 21 Dec 2022 18:53:39 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3mh47710vj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Dec 2022 18:53:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SD9NakIHpj9X+4+Nqbzw2+PFx50GyYg5vnm9zdrih95vtSHU6vzcRhXfsmoJ4B7RiPAwGRxbqbk3lvXfczyK4iYyC/tlliZ2nlSLErVID1MDZSzNao+EjtePnn6Swrh6PKR5hvf/qHfVDoaR6/nUcq51Ny2E3OWJBfW6ocTGZ+yXWvCz+aI22hG7LhR+Aw5MmQEXVo4rc40X/Lpwnl/1TjL0UmqAfgEzRnsY/DxIlUw8NTU9Xd5B/Cl9J/egrDQy8fgtlalJ/dIP6rZ/oqTK2ObDSLgtkoMhaK+kSATsCQabx1BZhTvAS+tmK2gkhZh88Ukod53xFK1x06Fse6akQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRDa8LugfJbUJ6RaP8e7+UipuPFiIv0h73/rowDQs+w=;
 b=A+mtqomCcp8IfOUJj0Q1OO5veL8arxaZjsH+7+zfBGWirSRXFUC5VQQvNpDEt7pCvazXjiS0DH7L/uE3S3ZKYbJ73HYOEfSI95hAHLBNty24xyAHygrE0EbMrY21jthZop7Wega5G50u0N7CaO4xjwoif6WPZ7XuegOYA7tietfLyP7cw6rSA4ojOZ2bcMuQ+82evStAe9kdUbIRlxS0/fQ1/3HnZOXFK3eJAF4VB4QQkFkM6sUTT2DAeJ5K40/lQqj9Ng4sfaY9Zybh86Bew5MtwpqLaQgpkLyzAeiPAfxamv0blaFaIbWH+BZ9mYtwdBkiUsbNPEqk5mrgrwASfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRDa8LugfJbUJ6RaP8e7+UipuPFiIv0h73/rowDQs+w=;
 b=uU9CdkuetDkVG7YxTJw6NsgqPPc4tNIWugKWiSH9N3yMBisxR0JplEjDz1xiRNR88o6wA4g5xb1M0gmYd6wJMqg7DXlFzlGZjETv8rAuNkjD9dSKNysfueCZS1buPXnOhltcxn2PeLkRDZrMeVW6/dK9zfvtqAdUCyv4avpDvGs=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5801.namprd10.prod.outlook.com (2603:10b6:a03:423::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.16; Wed, 21 Dec
 2022 18:53:36 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a02:2ac8:ee3e:682%4]) with mapi id 15.20.5924.016; Wed, 21 Dec 2022
 18:53:36 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Vernon Yang <vernon2gm@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH v2 0/7] Clean up and refinement for maple tree
Thread-Topic: [PATCH v2 0/7] Clean up and refinement for maple tree
Thread-Index: AQHZFQGqV1gzvMDpnEimGuywMFnWrK54sQUA
Date:   Wed, 21 Dec 2022 18:53:36 +0000
Message-ID: <20221221185330.5h27xfrvnargmduw@revolver>
References: <20221221060058.609003-1-vernon2gm@gmail.com>
In-Reply-To: <20221221060058.609003-1-vernon2gm@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|SJ0PR10MB5801:EE_
x-ms-office365-filtering-correlation-id: cdaa169d-49a3-443c-135a-08dae384aaba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9LyDtZrjaOD+JdUjNkzARfQx62Z1FUwnJzbwi2wn+YXkGOaSWZ6m/BsUFiZOJ6dfH9j9fNL+qD2TZ6cMCX5eVen50fEa7ZfMzG50M7ccNxGid+wUuZpNxHOUX+Ys3/lM9SHRWOrrlBarFLW/WhKFIMtijq+Ot3ILz6R+II0VgnMfKVliaU05AIDjLJhRn5GUJ+rdOhdFPHdzcyaFjxlZMWRtkXVXDAWMu8Tx+nSLDi/KHiBj4zy1AMca18quUuV2exQOyV25yCS3xWslpjbPXLuTIHlfDQuV2sCgrcHf+WETI5QOYygaVIBIo02h1EzXMJHKu3652gjszHdmSyqCpx7k3AA06TC8frRohTZ9SdwoypXeUpl0PFqMyM3YxX0HTIphA/nU8WD2gEML7F5sXTcJWrUNfppMVrRkNRKJG+mdN4wvSgxsA3+OIpSIIesRj/bwOc+l1M5jPQ0T74UYmLxi3xrzY0IWeZRQc+SWA01LzZUQCIHs6eNfGvGI0D41sG0FyPykeScHHtkXgWbtAIFO6UDNXvqAL8uDIrAySn68yv1zsEYzGBiLl5d9i7EnIGHL/WQbBN0NJIIdMLXYZ4pNIt7a9Y66ObMnvCMQt6UaaRkgxbxh+ay9oSmANK12/YDmlNEgKuwqWKbzFT00cfKvOuU41gg24zWef0hzfVPfPu/0Gt7QNlU1T1sv8mSF5wcodObBgT8EqWOB6nLh0/+S5d5cxnfkNuseoMXqsqc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199015)(38070700005)(64756008)(66446008)(66946007)(71200400001)(966005)(478600001)(186003)(6486002)(44832011)(26005)(6512007)(6506007)(76116006)(5660300002)(8936002)(91956017)(41300700001)(9686003)(54906003)(66476007)(6916009)(316002)(2906002)(4326008)(66556008)(8676002)(38100700002)(122000001)(1076003)(33716001)(83380400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gbZZjY/kt2FS/4wNVLO+Z5LY3hcRRVZnvvT/hXLoGIEUZjyBNP2eiMzws5LZ?=
 =?us-ascii?Q?p4B2Q5SC1PjPZpR79Vw7xuYNJPj1zhH7wMBhRyIRt82jJURmKANcp8NyM5Sl?=
 =?us-ascii?Q?hS/Ys1YqGkN0SdLGi7V+KFO5POxxcQRrSNIIVrtvcMln3tE5SrP+81ePbe/C?=
 =?us-ascii?Q?lQQypAw01n9rkBrLPnBZT555ZXZpVWtJqCuKcFFgjNDpQdeDP3ldjSSMfPgd?=
 =?us-ascii?Q?y+ZhSR6DrMXseQDasY8oCQ/mlmdlBfxdRElQBvraUwGHxBWmXqZnjLRdW1UD?=
 =?us-ascii?Q?g8ItHC3pQyNuBa9CnJyC1dIC/El5tCon1r0Zo2GVCwk4G8MZWboAmhD1twA3?=
 =?us-ascii?Q?BgrYzBR3WGd+Ev87nqiFp+nWbeiKxQR3ztsMZif9DTPOC8hlRz4oozQIps0b?=
 =?us-ascii?Q?5JNmLK4ZhJhQab9NPhW6izJxhoK78dc5BOh0ni5eV30Ilq7Tr+Cf65RYecaL?=
 =?us-ascii?Q?w2sKfZ9OAcsZN2U3AAN1M5bW1of9ZfQ/a+tJufY4qERGOT6JKfaSgwRKxpla?=
 =?us-ascii?Q?cwy0KY/5ZMW/bS/1F72oCsumqfxR53rVyZzHfrGPkw3hUbUJWdh8+S7inOHC?=
 =?us-ascii?Q?yfCmbG6p38lcU94YHJrZEwi8JRBTYR6jBobOYlpV+Lprgx0OyPQXgvOmpLDC?=
 =?us-ascii?Q?d7wzxGE2XOZmS2OiSDSYlT3N7EYtUuWvSoUuePmRjEu65wlS8oPKp3JbB3de?=
 =?us-ascii?Q?wB4XJkXIC5sJOGtA9qjHCadkRFdwuoNRUdAHGi9aH6R8bDEO2cYsRmYgTZJk?=
 =?us-ascii?Q?FfQu4ivwFtVXwWdapx1Dtvkk9krKGlPsjZ1bP+mC2W15yvL+nxHCv5XGq5Mh?=
 =?us-ascii?Q?zS5NDZDaJfv0es9QspcUkLtkprmd9VQWoqxfX5Zc6yOJBRn12GfVyiPsyPuR?=
 =?us-ascii?Q?Oc+pfe4J8ctVVA3S9ONKyyTzsQzNj3hizxpsCieGXx63Mr8jG4ZRg5r+4ruU?=
 =?us-ascii?Q?UD3kTXkuh/VI2QmIq+VmeGszyflMRicxH4Dt4elYCI/4G1olAmMucENrcHJ3?=
 =?us-ascii?Q?cxKIcD0d1ETrdRg1AzHZ9QLS/sa+Q6aQcwcWVjjGf2hpMsmxVUwQ1FLjJ8d8?=
 =?us-ascii?Q?4ECVmKgx+1z4e4W22NwIG2CId1uve+UhZeO5+7AWzdgk9mBspBKktpUVSliC?=
 =?us-ascii?Q?C7yVQJGKpz68iUixlEW1u733qjxS/FE0FZIri4XZpLM5+A7nF/8ykgPCBu7q?=
 =?us-ascii?Q?gPgNJENW5HGBSqiuuKWVredWEk41HwC9HErredjTcMGtSOiWS5fGdn4ewaDm?=
 =?us-ascii?Q?XEsnUyzDRHD7BgYYsuhryprUfJ/q9M6kFgk88xJycUoF2E5BmIBfiM/8db1A?=
 =?us-ascii?Q?ehvdZhO5CdZPyRBkWLgy7J6atgBsrEk5/umSD3iCwjuCBuFCD3grujRF36JX?=
 =?us-ascii?Q?RcwSJBidngaHoivjaUIgbZTaN0F4wWSAr8IBwer8H+c3+Ok1oTMgp7h3XIrF?=
 =?us-ascii?Q?iuk+hZpjky4AEJmqQuvmB/i+WcouD47uDcq67VQ6D2C77NAmJb7zulX/p8/a?=
 =?us-ascii?Q?kJNH8VbRlfd+5auArfqNbEVUoOMEKNyWIUzEz6LTl8eoXc7oqT9u2OqtKYXI?=
 =?us-ascii?Q?UgmzBs2nti/ufD4O2bYEzzT2rhLWbwN/Zx+C5IBodxdq0m3M6e2pBwIti0Ny?=
 =?us-ascii?Q?kw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C14EC5B93895C54B8F32EC74297B42D3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdaa169d-49a3-443c-135a-08dae384aaba
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2022 18:53:36.5699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5vTj1NPu5tUfD2U548j0K/qOub0Lz7uobdYGgTYIarCpZn1aMVnUj9ZD+t2Z7d3nG+22QLQHGqLIYpmg+RdLhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5801
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-21_11,2022-12-21_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=966 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2212210160
X-Proofpoint-GUID: y8dua7OOWKf_vuiGHAJpRVMzO6tkzukE
X-Proofpoint-ORIG-GUID: y8dua7OOWKf_vuiGHAJpRVMzO6tkzukE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vernon Yang <vernon2gm@gmail.com> [221221 01:01]:
> Hello,
>=20
> This patchset clean up and refinement some maple tree code, a few small
> changes make the code easier to understand and for better readability.
>=20
> v2 changes:
> - Add Reviewed-by Liam R. Howlett to all patches besides 6 & 8.
> - Remove patch 6.
> - Add an unlikely() to the if statement for patch 8.
>=20
> v1: https://lore.kernel.org/linux-mm/20221220140829.1665432-1-vernon2gm@g=
mail.com/

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

>=20
> Vernon Yang (7):
>   maple_tree: remove extra space and blank line
>   maple_tree: remove extra return statement
>   maple_tree: use mt_node_max() instead of direct operations mt_max[]
>   maple_tree: use macro MA_ROOT_PARENT instead of number
>   maple_tree: remove the redundant code
>   maple_tree: refine ma_state init from mas_start()
>   maple_tree: refine mab_calc_split function
>=20
>  include/linux/maple_tree.h |  6 ------
>  lib/maple_tree.c           | 35 ++++++++++++-----------------------
>  2 files changed, 12 insertions(+), 29 deletions(-)
>=20
> --
> 2.34.1
> =

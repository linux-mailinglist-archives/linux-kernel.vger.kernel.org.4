Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0475B8612
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiINKRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiINKRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:17:03 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980D877E9C
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 03:16:59 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28E8mglN012101;
        Wed, 14 Sep 2022 10:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=aOwgO8/cfYwepFB0/qiwhW/fgyNzlky46D8n0sLl4/c=;
 b=Aklkt/yt/TjAbSyPkyRvaw3CP9fZ+pnMwKiqTuQQiIeRFLALOCNmpsuSuovXLloGl+vv
 B1ht4rEnYF+Ht6NOyWKLnyALNkDxSZlJK+ACSoJp+Da76VB0aAD0s4UTzu9ns5TR0ByF
 NnA9TYoJyi8xqiukI/TJLAQz+cS9RZpYlK/s80q7hqID8XqAhyUNR7LPms9U5Mg+U06j
 hRh28PKXDNgquN406p1BFY7sHm6vMdO99++VqMXA7D2wfIAtgRso0neh+dxiHb3zNk1x
 w233ldLDfAjV3T9KHTWg4T+67gQiSxtYg8iqf2VsUyi+TUk+Ti3RRx7gNsnlOxtOHquJ fg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3jjxyf1sfb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 10:16:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 28E9R6q0013796;
        Wed, 14 Sep 2022 10:16:29 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3jjy2au0d6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 14 Sep 2022 10:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgLADFKzCN7FaZLb7PcLtpFOZxPjbRoldGbmf2JMNNWqvB6XuR0tr31i1nBneGXu61icHYftUsI9uMGhxDpwSbW0MSQwuhUuBc/5Bj9zEKH0JrsCh2Utgsf62LjhAmIGSinJ3NTf01HwhGfZwvwb6gnZGVrbIfB0f7UGdUBSiRNdN0KQIDc9yXwaPCk20SSRoN0VbuCBzdgJ7U0cNTFEt4wauJ/m8kBjjggoPIjRBqV5z0FSXVBl7z53y05Rvc/wL9nIf4KPofxRxngIKbfIxLvjVTbJjsOV3v5qsrLHTkKf7hk3/dz0cLJ8GuJp2wZ5J7LTmn4CdT7Urk0L8u+eWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aOwgO8/cfYwepFB0/qiwhW/fgyNzlky46D8n0sLl4/c=;
 b=hm3eFzP5kEYN6jRGkB0Ld4GvEnlrmeUPdi6VmCdhxS/hQW+KANABqejeacwvq0vRGFIdqDKGdeiCxWZgV6fpyo6iC2VwLVCvUq+MPiJeNlSjolZ8zz/xya2UeMckKKLnpjYUUyC8zIjqtjjNCLaLbWLGzUtSHay+w0GmNMtxUBfvUH8crgb8ZQwjLeNfHKxNsHhQ0gVCSm4dDskH74118HqyauDvLtyrbgopXWNurZE7Vc/Xfj38CTAQvuQyjEgLGr6AfzCWRlEDhoqtvXx2MTdHBqDzSLqWDFmd+DT7+oB7JmaQnVRJOj0KTPVFAogQuGJgQbH5SFUnKdWZ33B+Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aOwgO8/cfYwepFB0/qiwhW/fgyNzlky46D8n0sLl4/c=;
 b=eFE7IYbX7aIP+mvO4CQkuE9L6yGEWhmm71TGOtvv1ItINJr3vvYRQs65pCxfXCtHFgZBelB4/Lo594Zvtj1wqEDx0xfXTLZthAGrMzw9C/v2sJs+PbUsNS+vmBo4/AP9pTEDfiK2f4dHgdgzU3HHynEKUU3ibrSU3l9ZuMHeyTQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY8PR10MB6683.namprd10.prod.outlook.com (2603:10b6:930:92::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.12; Wed, 14 Sep
 2022 10:16:26 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::a420:3107:436d:d223%5]) with mapi id 15.20.5612.022; Wed, 14 Sep 2022
 10:16:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
CC:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Sven Schnelle <svens@linux.ibm.com>
Subject: Re: [PATCH v14 01/70] Maple Tree: add new data structure
Thread-Topic: [PATCH v14 01/70] Maple Tree: add new data structure
Thread-Index: AQHYwimpxJxzaH2u5EOTs01m2IvvKK3bgtcAgAM+5YA=
Date:   Wed, 14 Sep 2022 10:16:25 +0000
Message-ID: <20220914101619.gqcwedq4jv5qneck@revolver>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-2-Liam.Howlett@oracle.com>
 <Yx7w8gXqZMS+fEgc@debian.me>
In-Reply-To: <Yx7w8gXqZMS+fEgc@debian.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR10MB3022:EE_|CY8PR10MB6683:EE_
x-ms-office365-filtering-correlation-id: cabd459f-4d5f-43e7-814e-08da963a2ea0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TZnV9VDgisYKEM9lMJgoEit/KcStQSzrdJzaUtYxn+4HuUQIJ4iLYd+glrXgTD+/lkwC9F9MkMK2ohBrTwJ2eQD0w5DenJrZQWF57Tr7zC3X3tKZXtVjFUoOBoYb9v5qM8fMdOobiDNJI9svxJ8LfymavCMdQ4+JPTGiKDkvdbWmf4vT4/HgvJgmGs+eKNbg4z5BOcJKujsbNX37C9B9cScqEjpeX7lYAj3YaCDKqa2tE5WYtxc5i+x7nshKLKlTofbwvITWjOC4MWJf1NaZriKP2NaxjtqXu7CqNGG1Ydc8j2YLKVpBXzA+jXIZYG8yMEFU5WS0jp6Cv4j9Z6OFbIqSOWnB9cmtc/k7wSrsKlegAjvtPvyAS4dSbtfThyzkVRd0D6O82MD1BVgbuSm/pibGs7OpFy9F9gEcWHwZFXOQF0w3luHHZYVihs00g8uY54jg9EdsNkJEw9ZGL0vl7Ju31AaWIrYm4/KtT7v6n3K9aSSVZ5hdVmGbZaILxM7ZyxmZfjBVuclGYj2zxkXtpBIbxlm7XjqwYkmILM3+66JndjMYEu2wYTddMcI+vnCG6hcUknd/7DNFmgGNZNcIn5S3YibJgdk1+mFOzEq0dy80gDLlwAGs7n6dqMOhTKOP6z5PFx0Np293UVY6ha9O4gsz1K45CWF0nlXZKWh1NXBscb0JVv0no9+559vrWUtqZQCZUpfFbC9EXz8YVhYGTamg9d518cEYrrN13Xjvy95dnbH5GQ3kpez0Y+PeoV2BmGtHc03m73qlrkmEYJjGzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199015)(4326008)(5660300002)(6916009)(66946007)(33716001)(38070700005)(1076003)(91956017)(66556008)(71200400001)(38100700002)(8936002)(64756008)(66446008)(8676002)(6486002)(76116006)(44832011)(41300700001)(9686003)(66476007)(30864003)(86362001)(26005)(2906002)(316002)(478600001)(54906003)(186003)(122000001)(6506007)(83380400001)(6512007)(559001)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oke9UQqfWCYF31hjGEwsNM1XYHD+eDlt1tbH9EKi31V1LxunAB/3jyPLZNgM?=
 =?us-ascii?Q?Ji6FBc5VdUjGgulpFTvlK8n+RECALEIahWjW8oohoVHziZLd3brkLLIQ4L7g?=
 =?us-ascii?Q?GMdox1LtrAb92/TqU+5TaA6c8+M7U42RvRbqGzy4B5wqgbrK2WUXl5WmOyuy?=
 =?us-ascii?Q?4mcZ9WZ0N1KpOGZJIWD1l0sNs3tmmapVpA+TWkw5mYzzrDyB45PI447/5xsw?=
 =?us-ascii?Q?bjOnBWTVEenti9mlPG+1pJ2+d7F6oecfjccUx+KkQHWjVvaRPubpr7Wv7gQ1?=
 =?us-ascii?Q?iSV/129BoW8qbhdm7poSXYfuWeRX84Wj38b/ZsgAKCD5ZenzDoj+DdBRRMuJ?=
 =?us-ascii?Q?HShSfX9M8p5gx0XGRmQZQGJM6ludyANYCOhXIqNsrZLvcBrWoHu6TrM3ij0R?=
 =?us-ascii?Q?7uEOR9+2iq1yYChGj+OqWCzCWrRqsEVBNav/NbgSwbvNHaaM0cYGOEJY5Had?=
 =?us-ascii?Q?bzi9mcUuAB5m7W4tBHyn36oAJKHT+d/FV2ZDS/qCWSb/ZiuoOoAFr5Z0LTqS?=
 =?us-ascii?Q?J9Vo4cJKQPo3jfd7fJKtcTSuRqEQLQ5uRj2vjOyg4lG8Ruj+ntENagY0eJF3?=
 =?us-ascii?Q?W4NneVQZ1CzDfO2Jxv4LofpYwSqlWuzpf3umXTP+P7aDlEte7wzB7Ffp6G0A?=
 =?us-ascii?Q?7UutH/tbX0ciihqkfeNUs+v/jl3sZSLwckht0PHCfa3sRKivyxD1ZVkVzE2K?=
 =?us-ascii?Q?Vw9XKtrHT9BClPancJg8Y3CXApm21obeH5wgLEqyEGjjuXVpum1aItxBjPDt?=
 =?us-ascii?Q?yRA1XMIWmrPLgn8cuvy8cF/h7o7ZNJy+w3L7XHdsoaHqLCnK3328yXaWpzmi?=
 =?us-ascii?Q?fYmwCgojfGbc/PnbGHhCSnjXFEzfLCyLmQUfxRuvWsAzPkUvJ7q+XdPl1LD5?=
 =?us-ascii?Q?Wa4nQWef95KnmhZXv8HrkiShCDUE7aOHXZ5cWilfQ11WoSqWS6lylrE2NnEd?=
 =?us-ascii?Q?+tsX3Wb34/MU4ibgQoWhSYLEVsnHbO/VPazozhadZe9ytCgxu2SDHqvkcdtT?=
 =?us-ascii?Q?0HPTM4a1ZzLXvBpvsZmooTUo78thE12MjxKHc/tNEWjQA40MLS2JLwYGLx2A?=
 =?us-ascii?Q?eu4eHjFxMyqP4Km9O3c9CN7xYr3tC7IQjl9xSCOU+t3Tjxn+b5st/NzI0a1R?=
 =?us-ascii?Q?5wSLBS3BpZLCmaz72bhSiJp1OSY+ELTZlgAz6Os1h5YjiqEdHPZCD6RmJ4En?=
 =?us-ascii?Q?3C+YV/pUDvuFVc3RO4i5hc/oCugAY8JYSRSORxH0uy4d+Afuh9Qzoc4TMa/t?=
 =?us-ascii?Q?/90q8flpDSklnabV15jGNRwHK4iAeK4xrqSO4125SRRCAQyXr44y7Em+LXgK?=
 =?us-ascii?Q?Y52vE2cZvKoz9TcMcMqc7MXQQHCl+4+zRzl7qbNIxLAysXv8MWm43Uj6U2q6?=
 =?us-ascii?Q?nr3EevlC8z/CxYYoxy8c9NtKZoLuRcJ+msWg7cq5CqAF2YfHs2uYz7Q6HKlu?=
 =?us-ascii?Q?4g4hpxp0IZpd6TzVMAZhs4HxF5NlxZ0rj71G/Wdwko0malGcmUokEj3QAdWG?=
 =?us-ascii?Q?5qoRsYjhduqFWXoXWb9+Mc2X6rzdFDloS9N81Keg3K/J5EKUh/BDvzgGYojj?=
 =?us-ascii?Q?ymfbFbUfXSJz8gWCYHZRKe79f55JYRGehYyrZ0+dP9RYN8UH/8OyAjlDXA/d?=
 =?us-ascii?Q?Iw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <152A51D1C7A3774B85A272C061A00C4D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cabd459f-4d5f-43e7-814e-08da963a2ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2022 10:16:26.0574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ju4k3l0yv8D1AOroNxdRI/D9kbVM8fzgsQ44wQWzJYTay6/dKKGkUospxJImnCo6F0Q9HmEbAF26PoikJmnfwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6683
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-14_03,2022-09-14_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2208220000 definitions=main-2209140050
X-Proofpoint-GUID: v_8JumLpdJ2lzASi7uLr97uCh9cDlufH
X-Proofpoint-ORIG-GUID: v_8JumLpdJ2lzASi7uLr97uCh9cDlufH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Bagas Sanjaya <bagasdotme@gmail.com> [220912 04:42]:
> On Tue, Sep 06, 2022 at 07:48:39PM +0000, Liam Howlett wrote:
> > diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core=
-api/maple_tree.rst
> > new file mode 100644
> > index 000000000000..45defcf15da7
> > --- /dev/null
> > +++ b/Documentation/core-api/maple_tree.rst
> > @@ -0,0 +1,217 @@
> > +.. SPDX-License-Identifier: GPL-2.0+
> > +
> > +
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +Maple Tree
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +:Author: Liam R. Howlett
> > +
> > +Overview
> > +=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The Maple Tree is a B-Tree data type which is optimized for storing
> > +non-overlapping ranges, including ranges of size 1.  The tree was desi=
gned to
> > +be simple to use and does not require a user written search method.  I=
t
> > +supports iterating over a range of entries and going to the previous o=
r next
> > +entry in a cache-efficient manner.  The tree can also be put into an R=
CU-safe
> > +mode of operation which allows reading and writing concurrently.  Writ=
ers must
> > +synchronize on a lock, which can be the default spinlock, or the user =
can set
> > +the lock to an external lock of a different type.
> > +
> > +The Maple Tree maintains a small memory footprint and was designed to =
use
> > +modern processor cache efficiently.  The majority of the users will be=
 able to
> > +use the normal API.  An :ref:`maple-tree-advanced-api` exists for more=
 complex
> > +scenarios.  The most important usage of the Maple Tree is the tracking=
 of the
> > +virtual memory areas.
> > +
> > +The Maple Tree can store values between ``0`` and ``ULONG_MAX``.  The =
Maple
> > +Tree reserves values with the bottom two bits set to '10' which are be=
low 4096
> > +(ie 2, 6, 10 .. 4094) for internal use.  If the entries may use reserv=
ed
> > +entries then the users can convert the entries using xa_mk_value() and=
 convert
> > +them back by calling xa_to_value().  If the user needs to use a reserv=
ed
> > +value, then the user can convert the value when using the
> > +:ref:`maple-tree-advanced-api`, but are blocked by the normal API.
> > +
> > +The Maple Tree can also be configured to support searching for a gap o=
f a given
> > +size (or larger).
> > +
> > +Pre-allocating of nodes is also supported using the
> > +:ref:`maple-tree-advanced-api`.  This is useful for users who must gua=
rantee a
> > +successful store operation within a given
> > +code segment when allocating cannot be done.  Allocations of nodes are
> > +relatively small at around 256 bytes.
> > +
> > +.. _maple-tree-normal-api:
> > +
> > +Normal API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +Start by initialising a maple tree, either with DEFINE_MTREE() for sta=
tically
> > +allocated maple trees or mt_init() for dynamically allocated ones.  A
> > +freshly-initialised maple tree contains a ``NULL`` pointer for the ran=
ge ``0``
> > +- ``ULONG_MAX``.  There are currently two types of maple trees support=
ed: the
> > +allocation tree and the regular tree.  The regular tree has a higher b=
ranching
> > +factor for internal nodes.  The allocation tree has a lower branching =
factor
> > +but allows the user to search for a gap of a given size or larger from=
 either
> > +``0`` upwards or ``ULONG_MAX`` down.  An allocation tree can be used b=
y
> > +passing in the ``MT_FLAGS_ALLOC_RANGE`` flag when initialising the tre=
e.
> > +
> > +You can then set entries using mtree_store() or mtree_store_range().
> > +mtree_store() will overwrite any entry with the new entry and return 0=
 on
> > +success or an error code otherwise.  mtree_store_range() works in the =
same way
> > +but takes a range.  mtree_load() is used to retrieve the entry stored =
at a
> > +given index.  You can use mtree_erase() to erase an entire range by on=
ly
> > +knowing one value within that range, or mtree_store() call with an ent=
ry of
> > +NULL may be used to partially erase a range or many ranges at once.
> > +
> > +If you want to only store a new entry to a range (or index) if that ra=
nge is
> > +currently ``NULL``, you can use mtree_insert_range() or mtree_insert()=
 which
> > +return -EEXIST if the range is not empty.
> > +
> > +You can search for an entry from an index upwards by using mt_find().
> > +
> > +You can walk each entry within a range by calling mt_for_each().  You =
must
> > +provide a temporary variable to store a cursor.  If you want to walk e=
ach
> > +element of the tree then ``0`` and ``ULONG_MAX`` may be used as the ra=
nge.  If
> > +the caller is going to hold the lock for the duration of the walk then=
 it is
> > +worth looking at the mas_for_each() API in the :ref:`maple-tree-advanc=
ed-api`
> > +section.
> > +
> > +Sometimes it is necessary to ensure the next call to store to a maple =
tree does
> > +not allocate memory, please see :ref:`maple-tree-advanced-api` for thi=
s use case.
> > +
> > +Finally, you can remove all entries from a maple tree by calling
> > +mtree_destroy().  If the maple tree entries are pointers, you may wish=
 to free
> > +the entries first.
> > +
> > +Allocating Nodes
> > +----------------
> > +
> > +The allocations are handled by the internal tree code.  See
> > +:ref:`maple-tree-advanced-alloc` for other options.
> > +
> > +Locking
> > +-------
> > +
> > +You do not have to worry about locking.  See :ref:`maple-tree-advanced=
-locks`
> > +for other options.
> > +
> > +The Maple Tree uses RCU and an internal spinlock to synchronise access=
:
> > +
> > +Takes RCU read lock:
> > + * mtree_load()
> > + * mt_find()
> > + * mt_for_each()
> > + * mt_next()
> > + * mt_prev()
> > +
> > +Takes ma_lock internally:
> > + * mtree_store()
> > + * mtree_store_range()
> > + * mtree_insert()
> > + * mtree_insert_range()
> > + * mtree_erase()
> > + * mtree_destroy()
> > + * mt_set_in_rcu()
> > + * mt_clear_in_rcu()
> > +
> > +If you want to take advantage of the internal lock to protect the data
> > +structures that you are storing in the Maple Tree, you can call mtree_=
lock()
> > +before calling mtree_load(), then take a reference count on the object=
 you
> > +have found before calling mtree_unlock().  This will prevent stores fr=
om
> > +removing the object from the tree between looking up the object and
> > +incrementing the refcount.  You can also use RCU to avoid dereferencin=
g
> > +freed memory, but an explanation of that is beyond the scope of this
> > +document.
> > +
> > +.. _maple-tree-advanced-api:
> > +
> > +Advanced API
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > +
> > +The advanced API offers more flexibility and better performance at the
> > +cost of an interface which can be harder to use and has fewer safeguar=
ds.
> > +You must take care of your own locking while using the advanced API.
> > +You can use the ma_lock, RCU or an external lock for protection.
> > +You can mix advanced and normal operations on the same array, as long
> > +as the locking is compatible.  The :ref:`maple-tree-normal-api` is imp=
lemented
> > +in terms of the advanced API.
> > +
> > +The advanced API is based around the ma_state, this is where the 'mas'
> > +prefix originates.  The ma_state struct keeps track of tree operations=
 to make
> > +life easier for both internal and external tree users.
> > +
> > +Initialising the maple tree is the same as in the :ref:`maple-tree-nor=
mal-api`.
> > +Please see above.
> > +
> > +The maple state keeps track of the range start and end in mas->index a=
nd
> > +mas->last, respectively.
> > +
> > +mas_walk() will walk the tree to the location of mas->index and set th=
e
> > +mas->index and mas->last according to the range for the entry.
> > +
> > +You can set entries using mas_store().  mas_store() will overwrite any=
 entry
> > +with the new entry and return the first existing entry that is overwri=
tten.
> > +The range is passed in as members of the maple state: index and last.
> > +
> > +You can use mas_erase() to erase an entire range by setting index and
> > +last of the maple state to the desired range to erase.  This will eras=
e
> > +the first range that is found in that range, set the maple state index
> > +and last as the range that was erased and return the entry that existe=
d
> > +at that location.
> > +
> > +You can walk each entry within a range by using mas_for_each().  If yo=
u want
> > +to walk each element of the tree then ``0`` and ``ULONG_MAX`` may be u=
sed as
> > +the range.  If the lock needs to be periodically dropped, see the lock=
ing
> > +section mas_pause().
> > +
> > +Using a maple state allows mas_next() and mas_prev() to function as if=
 the
> > +tree was a linked list.  With such a high branching factor the amortiz=
ed
> > +performance penalty is outweighed by cache optimization.  mas_next() w=
ill
> > +return the next entry which occurs after the entry at index.  mas_prev=
()
> > +will return the previous entry which occurs before the entry at index.
> > +
> > +mas_find() will find the first entry which exists at or above index on
> > +the first call, and the next entry from every subsequent calls.
> > +
> > +mas_find_rev() will find the fist entry which exists at or below the l=
ast on
> > +the first call, and the previous entry from every subsequent calls.
> > +
> > +If the user needs to yield the lock during an operation, then the mapl=
e state
> > +must be paused using mas_pause().
> > +
> > +There are a few extra interfaces provided when using an allocation tre=
e.
> > +If you wish to search for a gap within a range, then mas_empty_area()
> > +or mas_empty_area_rev() can be used.  mas_empty_area() searches for a =
gap
> > +starting at the lowest index given up to the maximum of the range.
> > +mas_empty_area_rev() searches for a gap starting at the highest index =
given
> > +and continues downward to the lower bound of the range.
> > +
> > +.. _maple-tree-advanced-alloc:
> > +
> > +Advanced Allocating Nodes
> > +-------------------------
> > +
> > +Allocations are usually handled internally to the tree, however if all=
ocations
> > +need to occur before a write occurs then calling mas_expected_entries(=
) will
> > +allocate the worst-case number of needed nodes to insert the provided =
number of
> > +ranges.  This also causes the tree to enter mass insertion mode.  Once
> > +insertions are complete calling mas_destroy() on the maple state will =
free the
> > +unused allocations.
> > +
> > +.. _maple-tree-advanced-locks:
> > +
> > +Advanced Locking
> > +----------------
> > +
> > +The maple tree uses a spinlock by default, but external locks can be u=
sed for
> > +tree updates as well.  To use an external lock, the tree must be initi=
alized
> > +with the ``MT_FLAGS_LOCK_EXTERN flag``, this is usually done with the
> > +MTREE_INIT_EXT() #define, which takes an external lock as an argument.
> > +
> > +Functions and structures
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > +
> > +.. kernel-doc:: include/linux/maple_tree.h
> > +.. kernel-doc:: lib/maple_tree.c
>=20
> The documentation can be improved (both grammar and formatting), like:

Thanks for reading through this document.

Three are some good changes like the additions of the references, but
I'm less enthusiastic about others.  I'll have to go through them in
more detail.

Thanks,
Liam

>=20
> ---- >8 ----
>=20
> diff --git a/Documentation/core-api/maple_tree.rst b/Documentation/core-a=
pi/maple_tree.rst
> index 45defcf15da71a..c1aa6bf3ab5edd 100644
> --- a/Documentation/core-api/maple_tree.rst
> +++ b/Documentation/core-api/maple_tree.rst
> @@ -10,36 +10,36 @@ Maple Tree
>  Overview
>  =3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -The Maple Tree is a B-Tree data type which is optimized for storing
> +The maple tree is a B-Tree data type which is optimized for storing
>  non-overlapping ranges, including ranges of size 1.  The tree was design=
ed to
>  be simple to use and does not require a user written search method.  It
>  supports iterating over a range of entries and going to the previous or =
next
>  entry in a cache-efficient manner.  The tree can also be put into an RCU=
-safe
>  mode of operation which allows reading and writing concurrently.  Writer=
s must
> -synchronize on a lock, which can be the default spinlock, or the user ca=
n set
> -the lock to an external lock of a different type.
> +synchronize on a lock (which can be set to either the default spinlock o=
r an
> +external lock of a different type).
> =20
>  The Maple Tree maintains a small memory footprint and was designed to us=
e
> -modern processor cache efficiently.  The majority of the users will be a=
ble to
> -use the normal API.  An :ref:`maple-tree-advanced-api` exists for more c=
omplex
> -scenarios.  The most important usage of the Maple Tree is the tracking o=
f the
> +modern processor cache efficiently.  For most users, using the
> +:ref:`normal API <maple-tree-normal-api>` will suffice. The
> +:ref:`advanced API <maple-tree-advanced-api>` is available for more comp=
lex
> +scenarios.  The most important usage of the maple tree is the tracking o=
f
>  virtual memory areas.
> =20
> -The Maple Tree can store values between ``0`` and ``ULONG_MAX``.  The Ma=
ple
> -Tree reserves values with the bottom two bits set to '10' which are belo=
w 4096
> +The maple tree can store values between 0 and ``ULONG_MAX``. It reserves
> +values with the bottom two bits set to ``10`` which are below 4096
>  (ie 2, 6, 10 .. 4094) for internal use.  If the entries may use reserved
>  entries then the users can convert the entries using xa_mk_value() and c=
onvert
>  them back by calling xa_to_value().  If the user needs to use a reserved
> -value, then the user can convert the value when using the
> -:ref:`maple-tree-advanced-api`, but are blocked by the normal API.
> +value, then the value can be converted when using the advanced API; howe=
ver
> +converting that way is blocked by the normal API.
> =20
> -The Maple Tree can also be configured to support searching for a gap of =
a given
> -size (or larger).
> +The maple tree can also be configured to support searching for a gap of =
a
> +given size (or larger).
> =20
> -Pre-allocating of nodes is also supported using the
> -:ref:`maple-tree-advanced-api`.  This is useful for users who must guara=
ntee a
> -successful store operation within a given
> -code segment when allocating cannot be done.  Allocations of nodes are
> +Pre-allocating of nodes is also supported by using the advanced API. Thi=
s is
> +useful for users who must guarantee a successful store operation within =
a
> +given code segment when allocating cannot be done. Allocations of nodes =
are
>  relatively small at around 256 bytes.
> =20
>  .. _maple-tree-normal-api:
> @@ -47,39 +47,40 @@ relatively small at around 256 bytes.
>  Normal API
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
> -Start by initialising a maple tree, either with DEFINE_MTREE() for stati=
cally
> +Start by initializing a maple tree, either with DEFINE_MTREE() for stati=
cally
>  allocated maple trees or mt_init() for dynamically allocated ones.  A
> -freshly-initialised maple tree contains a ``NULL`` pointer for the range=
 ``0``
> +freshly-initialized maple tree contains a ``NULL`` pointer for the range=
 0
>  - ``ULONG_MAX``.  There are currently two types of maple trees supported=
: the
> -allocation tree and the regular tree.  The regular tree has a higher bra=
nching
> +allocation tree and the regular tree. The regular tree has a higher bran=
ching
>  factor for internal nodes.  The allocation tree has a lower branching fa=
ctor
>  but allows the user to search for a gap of a given size or larger from e=
ither
>  ``0`` upwards or ``ULONG_MAX`` down.  An allocation tree can be used by
> -passing in the ``MT_FLAGS_ALLOC_RANGE`` flag when initialising the tree.
> +passing in the ``MT_FLAGS_ALLOC_RANGE`` flag when initializing the tree.
> =20
> -You can then set entries using mtree_store() or mtree_store_range().
> -mtree_store() will overwrite any entry with the new entry and return 0 o=
n
> -success or an error code otherwise.  mtree_store_range() works in the sa=
me way
> -but takes a range.  mtree_load() is used to retrieve the entry stored at=
 a
> -given index.  You can use mtree_erase() to erase an entire range by only
> -knowing one value within that range, or mtree_store() call with an entry=
 of
> -NULL may be used to partially erase a range or many ranges at once.
> +After initializing the tree, you can set entries using mtree_store() or
> +mtree_store_range(). mtree_store() will overwrite any entry with the new=
 entry
> +and return 0 on success or an error code otherwise. mtree_store_range() =
works
> +in the same way but takes a range instead. mtree_load() is used to retri=
eve
> +the entry stored at a given index. You can use mtree_erase() to erase an
> +entire range by only knowing one value within that range. mtree_store() =
call
> +with an entry of ``NULL`` may be used to partially erase a range or many
> +ranges at once.
> =20
>  If you want to only store a new entry to a range (or index) if that rang=
e is
>  currently ``NULL``, you can use mtree_insert_range() or mtree_insert() w=
hich
> -return -EEXIST if the range is not empty.
> +return ``-EEXIST`` if the range is not empty.
> =20
>  You can search for an entry from an index upwards by using mt_find().
> =20
> -You can walk each entry within a range by calling mt_for_each().  You mu=
st
> -provide a temporary variable to store a cursor.  If you want to walk eac=
h
> +You can walk each entry within a range by calling mt_for_each(). A tempo=
rary
> +variable must be provided to store a cursor.  If you want to walk each
>  element of the tree then ``0`` and ``ULONG_MAX`` may be used as the rang=
e.  If
> -the caller is going to hold the lock for the duration of the walk then i=
t is
> -worth looking at the mas_for_each() API in the :ref:`maple-tree-advanced=
-api`
> -section.
> +the caller is going to hold the lock for the duration of the walk then u=
se
> +mas_for_each().
> =20
> -Sometimes it is necessary to ensure the next call to store to a maple tr=
ee does
> -not allocate memory, please see :ref:`maple-tree-advanced-api` for this =
use case.
> +Sometimes it is necessary to ensure the next call to store to a maple tr=
ee
> +does not allocate memory. See :ref:`advanced API <maple-tree-advanced-ap=
i>`
> +for details.
> =20
>  Finally, you can remove all entries from a maple tree by calling
>  mtree_destroy().  If the maple tree entries are pointers, you may wish t=
o free
> @@ -89,24 +90,26 @@ Allocating Nodes
>  ----------------
> =20
>  The allocations are handled by the internal tree code.  See
> -:ref:`maple-tree-advanced-alloc` for other options.
> +:ref:`maple-tree-advanced-alloc` for details.
> =20
>  Locking
>  -------
> =20
>  You do not have to worry about locking.  See :ref:`maple-tree-advanced-l=
ocks`
> -for other options.
> +for how to use external locking.
> =20
> -The Maple Tree uses RCU and an internal spinlock to synchronise access:
> +The Maple Tree uses RCU and an internal spinlock to synchronize access.
> +
> +The following methods takes RCU read lock:
> =20
> -Takes RCU read lock:
>   * mtree_load()
>   * mt_find()
>   * mt_for_each()
>   * mt_next()
>   * mt_prev()
> =20
> -Takes ma_lock internally:
> +The following methods takes ``ma_lock`` internally:
> +
>   * mtree_store()
>   * mtree_store_range()
>   * mtree_insert()
> @@ -117,13 +120,13 @@ Takes ma_lock internally:
>   * mt_clear_in_rcu()
> =20
>  If you want to take advantage of the internal lock to protect the data
> -structures that you are storing in the Maple Tree, you can call mtree_lo=
ck()
> -before calling mtree_load(), then take a reference count on the object y=
ou
> -have found before calling mtree_unlock().  This will prevent stores from
> -removing the object from the tree between looking up the object and
> -incrementing the refcount.  You can also use RCU to avoid dereferencing
> -freed memory, but an explanation of that is beyond the scope of this
> -document.
> +structures that you are storing in the maple tree, you can call
> +``mtree_lock()`` before calling mtree_load(), then take a reference coun=
t
> +on the object that have been found before calling ``mtree_unlock()``.  T=
his
> +will prevent stores from removing the object from the tree between looki=
ng up
> +the object and incrementing the refcount.  You can also use RCU to avoid
> +dereferencing freed memory, but an explanation of that is beyond the sco=
pe of
> +this document.
> =20
>  .. _maple-tree-advanced-api:
> =20
> @@ -133,27 +136,27 @@ Advanced API
>  The advanced API offers more flexibility and better performance at the
>  cost of an interface which can be harder to use and has fewer safeguards=
.
>  You must take care of your own locking while using the advanced API.
> -You can use the ma_lock, RCU or an external lock for protection.
> +``ma_lock``, RCU or an external lock can be used for protection.
>  You can mix advanced and normal operations on the same array, as long
> -as the locking is compatible.  The :ref:`maple-tree-normal-api` is imple=
mented
> -in terms of the advanced API.
> +as the locking is compatible.  The :ref:`normal API <maple-tree-normal-a=
pi>`
> +is implemented in terms of the advanced API.
> =20
> -The advanced API is based around the ma_state, this is where the 'mas'
> -prefix originates.  The ma_state struct keeps track of tree operations t=
o make
> -life easier for both internal and external tree users.
> +The advanced API is based around the ``ma_state``; this is where the ``m=
as``
> +prefix originates.  The ``ma_state`` struct keeps track of tree operatio=
ns
> +to make life easier for both internal and external tree users.
> =20
> -Initialising the maple tree is the same as in the :ref:`maple-tree-norma=
l-api`.
> -Please see above.
> +Initializing the maple tree that uses advanced API is same as the one th=
at
> +uses normal API.
> =20
> -The maple state keeps track of the range start and end in mas->index and
> -mas->last, respectively.
> +The maple state keeps track of the range start and end in ``mas->index``=
 and
> +``mas->last``, respectively.
> =20
>  mas_walk() will walk the tree to the location of mas->index and set the
> -mas->index and mas->last according to the range for the entry.
> +``mas->index`` and ``mas->last`` according to the range for the entry.
> =20
> -You can set entries using mas_store().  mas_store() will overwrite any e=
ntry
> +You can set entries using mas_store(). It will overwrite any entry
>  with the new entry and return the first existing entry that is overwritt=
en.
> -The range is passed in as members of the maple state: index and last.
> +The range is passed in as members of the maple state: ``index`` and ``la=
st``.
> =20
>  You can use mas_erase() to erase an entire range by setting index and
>  last of the maple state to the desired range to erase.  This will erase
> @@ -162,9 +165,8 @@ and last as the range that was erased and return the =
entry that existed
>  at that location.
> =20
>  You can walk each entry within a range by using mas_for_each().  If you =
want
> -to walk each element of the tree then ``0`` and ``ULONG_MAX`` may be use=
d as
> -the range.  If the lock needs to be periodically dropped, see the lockin=
g
> -section mas_pause().
> +to walk each element of the tree then 0 and ``ULONG_MAX`` may be used as
> +the range.  If the lock needs to be periodically dropped, use mas_pause(=
).
> =20
>  Using a maple state allows mas_next() and mas_prev() to function as if t=
he
>  tree was a linked list.  With such a high branching factor the amortized
> @@ -173,32 +175,32 @@ return the next entry which occurs after the entry =
at index.  mas_prev()
>  will return the previous entry which occurs before the entry at index.
> =20
>  mas_find() will find the first entry which exists at or above index on
> -the first call, and the next entry from every subsequent calls.
> +the first call and the next entry from every subsequent calls.
> =20
>  mas_find_rev() will find the fist entry which exists at or below the las=
t on
> -the first call, and the previous entry from every subsequent calls.
> +the first call and the previous entry from every subsequent calls.
> =20
> -If the user needs to yield the lock during an operation, then the maple =
state
> +If you need to yield the lock during an operation, then the maple state
>  must be paused using mas_pause().
> =20
>  There are a few extra interfaces provided when using an allocation tree.
>  If you wish to search for a gap within a range, then mas_empty_area()
> -or mas_empty_area_rev() can be used.  mas_empty_area() searches for a ga=
p
> -starting at the lowest index given up to the maximum of the range.
> -mas_empty_area_rev() searches for a gap starting at the highest index gi=
ven
> -and continues downward to the lower bound of the range.
> +or mas_empty_area_rev() can be used. The former searches for a gap
> +starting at the lowest index given up to the maximum of the range, while=
 the
> +latter searches for a gap starting at the highest index given and contin=
ues
> +downward to the lower bound of the range.
> =20
>  .. _maple-tree-advanced-alloc:
> =20
>  Advanced Allocating Nodes
>  -------------------------
> =20
> -Allocations are usually handled internally to the tree, however if alloc=
ations
> -need to occur before a write occurs then calling mas_expected_entries() =
will
> -allocate the worst-case number of needed nodes to insert the provided nu=
mber of
> -ranges.  This also causes the tree to enter mass insertion mode.  Once
> -insertions are complete calling mas_destroy() on the maple state will fr=
ee the
> -unused allocations.
> +Allocations are usually handled internally to the tree. However, if
> +allocations need to occur before a write occurs then calling
> +mas_expected_entries() will allocate the worst-case number of needed nod=
es
> +to insert the provided number of ranges. This also causes the tree to en=
ter
> +mass insertion mode.  Once insertions are complete calling mas_destroy()=
 on
> +the maple state will free the unused allocations.
> =20
>  .. _maple-tree-advanced-locks:
> =20
> @@ -207,8 +209,8 @@ Advanced Locking
> =20
>  The maple tree uses a spinlock by default, but external locks can be use=
d for
>  tree updates as well.  To use an external lock, the tree must be initial=
ized
> -with the ``MT_FLAGS_LOCK_EXTERN flag``, this is usually done with the
> -MTREE_INIT_EXT() #define, which takes an external lock as an argument.
> +with the ``MT_FLAGS_LOCK_EXTERN flag``. This is usually done with the
> +MTREE_INIT_EXT() macro, which takes an external lock as an argument.
> =20
>  Functions and structures
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 2effab72add10e..c03652fba05e17 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -153,18 +153,22 @@ enum maple_type {
> =20
> =20
>  /**
> - * DOC: Maple tree flags
> + * DOC: Flags and constants
>   *
> - * * MT_FLAGS_ALLOC_RANGE	- Track gaps in this tree
> - * * MT_FLAGS_USE_RCU		- Operate in RCU mode
> - * * MT_FLAGS_HEIGHT_OFFSET	- The position of the tree height in the fla=
gs
> - * * MT_FLAGS_HEIGHT_MASK	- The mask for the maple tree height value
> - * * MT_FLAGS_LOCK_MASK		- How the mt_lock is used
> - * * MT_FLAGS_LOCK_IRQ		- Acquired irq-safe
> - * * MT_FLAGS_LOCK_BH		- Acquired bh-safe
> - * * MT_FLAGS_LOCK_EXTERN	- mt_lock is not used
> + * Maple tree flags:
>   *
> - * MAPLE_HEIGHT_MAX	The largest height that can be stored
> + * * ``MT_FLAGS_ALLOC_RANGE``	- Track gaps in this tree
> + * * ``MT_FLAGS_USE_RCU``	- Operate in RCU mode
> + * * ``MT_FLAGS_HEIGHT_OFFSET``	- The position of the tree height in the=
 flags
> + * * ``MT_FLAGS_HEIGHT_MASK``	- The mask for the maple tree height value
> + * * ``MT_FLAGS_LOCK_MASK``	- How the mt_lock is used
> + * * ``MT_FLAGS_LOCK_IRQ``	- Acquired irq-safe
> + * * ``MT_FLAGS_LOCK_BH``	- Acquired bh-safe
> + * * ``MT_FLAGS_LOCK_EXTERN``	- mt_lock is not used
> + *
> + * Maple tree constants:
> + *
> + * * ``MAPLE_HEIGHT_MAX``	- The largest height that can be stored
>   */
>  #define MT_FLAGS_ALLOC_RANGE	0x01
>  #define MT_FLAGS_USE_RCU	0x02
> @@ -498,7 +502,7 @@ int mas_empty_area_rev(struct ma_state *mas, unsigned=
 long min,
>   *
>   * Resets the error or walk state of the @mas so future walks of the
>   * array will start from the root.  Use this if you have dropped the
> - * lock and want to reuse the ma_state.
> + * lock and want to reuse the ``ma_state``.
>   *
>   * Context: Any context.
>   */
> @@ -513,8 +517,8 @@ static inline void mas_reset(struct ma_state *mas)
>   * @__entry: Entry retrieved from the tree
>   * @__max: maximum index to retrieve from the tree
>   *
> - * When returned, mas->index and mas->last will hold the entire range fo=
r the
> - * entry.
> + * When returned, ``mas->index`` and ``mas->last`` will hold the entire
> + * range for the entry.
>   *
>   * Note: may return the zero entry.
>   *
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index e1743803c85125..d09485313f2f04 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -5034,8 +5034,8 @@ static inline bool mas_anode_descend(struct ma_stat=
e *mas, unsigned long size)
>   * mas_walk() - Search for @mas->index in the tree.
>   * @mas: The maple state.
>   *
> - * mas->index and mas->last will be set to the range if there is a value=
.  If
> - * mas->node is MAS_NONE, reset to MAS_START.
> + * @mas->index and @mas->last will be set to the range if there is a val=
ue.=20
> + * If @mas->node is ``MAS_NONE``, reset to ``MAS_START``.
>   *
>   * Return: the entry at the location or %NULL.
>   */
> @@ -5222,7 +5222,7 @@ static inline void mas_sparse_area(struct ma_state =
*mas, unsigned long min,
>  	mas->index =3D max;
>  }
> =20
> -/*
> +/**
>   * mas_empty_area() - Get the lowest address within the range that is
>   * sufficient for the size requested.
>   * @mas: The maple state
> @@ -5277,7 +5277,7 @@ int mas_empty_area(struct ma_state *mas, unsigned l=
ong min,
>  	return 0;
>  }
> =20
> -/*
> +/**
>   * mas_empty_area_rev() - Get the highest address within the range that =
is
>   * sufficient for the size requested.
>   * @mas: The maple state
> @@ -5629,10 +5629,11 @@ static void mas_wr_store_setup(struct ma_wr_state=
 *wr_mas)
>   * @entry: The entry to store.
>   *
>   * The @mas->index and @mas->last is used to set the range for the @entr=
y.
> - * Note: The @mas should have pre-allocated entries to ensure there is m=
emory to
> - * store the entry.  Please see mas_expected_entries()/mas_destroy() for=
 more details.
> + * Note: The @mas should have pre-allocated entries to ensure there is m=
emory
> + * to store the entry. See mas_expected_entries()/mas_destroy() for more
> + * details.
>   *
> - * Return: the first entry between mas->index and mas->last or %NULL.
> + * Return: the first entry between @mas->index and @mas->last or %NULL.
>   */
>  void *mas_store(struct ma_state *mas, void *entry)
>  {
> @@ -5665,10 +5666,12 @@ void *mas_store(struct ma_state *mas, void *entry=
)
>   * mas_store_gfp() - Store a value into the tree.
>   * @mas: The maple state
>   * @entry: The entry to store
> - * @gfp: The GFP_FLAGS to use for allocations if necessary.
> + * @gfp: The ``GFP_FLAGS`` to use for allocations if necessary.
>   *
> - * Return: 0 on success, -EINVAL on invalid request, -ENOMEM if memory c=
ould not
> - * be allocated.
> + * Return:
> + * * 0 on success
> + * * ``-EINVAL`` on invalid request
> + * * ``-ENOMEM`` if memory could not be allocated.
>   */
>  int mas_store_gfp(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
> @@ -5708,9 +5711,9 @@ void mas_store_prealloc(struct ma_state *mas, void =
*entry)
>   * mas_preallocate() - Preallocate enough nodes for a store operation
>   * @mas: The maple state
>   * @entry: The entry that will be stored
> - * @gfp: The GFP_FLAGS to use for allocations.
> + * @gfp: The ``GFP_FLAGS`` to use for allocations.
>   *
> - * Return: 0 on success, -ENOMEM if memory could not be allocated.
> + * Return: 0 on success, ``-ENOMEM`` if memory could not be allocated.
>   */
>  int mas_preallocate(struct ma_state *mas, void *entry, gfp_t gfp)
>  {
> @@ -5729,13 +5732,12 @@ int mas_preallocate(struct ma_state *mas, void *e=
ntry, gfp_t gfp)
>  	return ret;
>  }
> =20
> -/*
> +/**
>   * mas_destroy() - destroy a maple state.
>   * @mas: The maple state
>   *
>   * Upon completion, check the left-most node and rebalance against the n=
ode to
> - * the right if necessary.  Frees any allocated nodes associated with th=
is maple
> - * state.
> + * the right if necessary.  Frees any allocated nodes associated with @m=
as.
>   */
>  void mas_destroy(struct ma_state *mas)
>  {
> @@ -5773,17 +5775,17 @@ void mas_destroy(struct ma_state *mas)
>  	mas->alloc =3D NULL;
>  }
> =20
> -/*
> +/**
>   * mas_expected_entries() - Set the expected number of entries that will=
 be inserted.
>   * @mas: The maple state
>   * @nr_entries: The number of expected entries.
>   *
>   * This will attempt to pre-allocate enough nodes to store the expected =
number
>   * of entries.  The allocations will occur using the bulk allocator inte=
rface
> - * for speed.  Please call mas_destroy() on the @mas after inserting the=
 entries
> - * to ensure any unused nodes are freed.
> + * for speed.  Please call mas_destroy() on the @mas after inserting
> + * entries to ensure any unused nodes are freed.
>   *
> - * Return: 0 on success, -ENOMEM if memory could not be allocated.
> + * Return: 0 on success, ``-ENOMEM`` if memory could not be allocated.
>   */
>  int mas_expected_entries(struct ma_state *mas, unsigned long nr_entries)
>  {
> @@ -5839,11 +5841,12 @@ int mas_expected_entries(struct ma_state *mas, un=
signed long nr_entries)
>   * @mas: The maple state
>   * @max: The maximum index to check.
>   *
> - * Returns the next entry after @mas->index.
> - * Must hold rcu_read_lock or the write lock.
> - * Can return the zero entry.
> + * Context: Callers must hold ``rcu_read_lock`` or the write lock.
>   *
> - * Return: The next entry or %NULL
> + * Returns the next entry after @mas->index.
> + * The function can return the zero entry.
> + *
> + * Return: The next entry or %NULL.
>   */
>  void *mas_next(struct ma_state *mas, unsigned long max)
>  {
> @@ -5894,9 +5897,10 @@ EXPORT_SYMBOL_GPL(mt_next);
>   * @mas: The maple state
>   * @min: The minimum value to check.
>   *
> - * Must hold rcu_read_lock or the write lock.
> - * Will reset mas to MAS_START if the node is MAS_NONE.  Will stop on no=
t
> - * searchable nodes.
> + * Context: Callers must hold ``rcu_read_lock`` or the write lock.
> + *
> + * The function will reset @mas to ``MAS_START`` if the node is ``MAS_NO=
NE``.
> + * It will also stop on unsearchable nodes.
>   *
>   * Return: the previous value or %NULL.
>   */
> @@ -5957,12 +5961,12 @@ EXPORT_SYMBOL_GPL(mt_prev);
>   * mas_pause() - Pause a mas_find/mas_for_each to drop the lock.
>   * @mas: The maple state to pause
>   *
> - * Some users need to pause a walk and drop the lock they're holding in
> + * In some cases, there is a need to pause a walk and drop the held lock=
 in
>   * order to yield to a higher priority thread or carry out an operation
> - * on an entry.  Those users should call this function before they drop
> - * the lock.  It resets the @mas to be suitable for the next iteration
> - * of the loop after the user has reacquired the lock.  If most entries
> - * found during a walk require you to call mas_pause(), the mt_for_each(=
)
> + * on an entry. If this is the case, this function should be called befo=
re
> + * the lock is dropped. It resets the @mas to be suitable for the next
> + * iteration of the loop after the user has reacquired the lock. If most
> + * entries found during a walk requires calling mas_pause(), the mt_for_=
each()
>   * iterator may be more appropriate.
>   *
>   */
> @@ -5978,9 +5982,10 @@ EXPORT_SYMBOL_GPL(mas_pause);
>   * @mas: The maple state
>   * @max: The maximum value to check.
>   *
> - * Must hold rcu_read_lock or the write lock.
> - * If an entry exists, last and index are updated accordingly.
> - * May set @mas->node to MAS_NONE.
> + * Context: Callers must hold ``rcu_read_lock`` or the write lock.
> + *
> + * If an entry exists, @mas->last and @mas->index are updated accordingl=
y.
> + * The function may set @mas->node to ``MAS_NONE``.
>   *
>   * Return: The entry or %NULL.
>   */
> @@ -6021,9 +6026,10 @@ void *mas_find(struct ma_state *mas, unsigned long=
 max)
>   * @mas: The maple state
>   * @min: The minimum value to check.
>   *
> - * Must hold rcu_read_lock or the write lock.
> - * If an entry exists, last and index are updated accordingly.
> - * May set @mas->node to MAS_NONE.
> + * Context: Callers must hold ``rcu_read_lock`` or the write lock.
> + *
> + * If an entry exists, @mas->last and @mas->index are updated accordingl=
y.
> + * The function may set @mas->node to ``MAS_NONE``.
>   *
>   * Return: The entry or %NULL.
>   */
> @@ -6066,7 +6072,8 @@ EXPORT_SYMBOL_GPL(mas_find);
>   * range.
>   * @mas: The maple state
>   *
> - * Must hold the write lock.
> + * Context: Callers must hold the write lock.
> + *
>   * Searches for @mas->index, sets @mas->index and @mas->last to the rang=
e and
>   * erases that range.
>   *
> @@ -6101,7 +6108,7 @@ EXPORT_SYMBOL_GPL(mas_erase);
>   * mas_nomem() - Check if there was an error allocating and do the alloc=
ation
>   * if necessary If there are allocations, then free them.
>   * @mas: The maple state
> - * @gfp: The GFP_FLAGS to use for allocations
> + * @gfp: The ``GFP_FLAGS`` to use for allocations
>   * Return: true on allocation, false otherwise.
>   */
>  bool mas_nomem(struct ma_state *mas, gfp_t gfp)
> @@ -6178,10 +6185,12 @@ EXPORT_SYMBOL(mtree_load);
>   * @index: The start of the range
>   * @last: The end of the range
>   * @entry: The entry to store
> - * @gfp: The GFP_FLAGS to use for allocations
> + * @gfp: The ``GFP_FLAGS`` to use for allocations
>   *
> - * Return: 0 on success, -EINVAL on invalid request, -ENOMEM if memory c=
ould not
> - * be allocated.
> + * Return:
> + * * 0 on success
> + * * ``-EINVAL`` on invalid request
> + * * ``-ENOMEM`` if memory could not be allocated.
>   */
>  int mtree_store_range(struct maple_tree *mt, unsigned long index,
>  		unsigned long last, void *entry, gfp_t gfp)
> @@ -6215,10 +6224,12 @@ EXPORT_SYMBOL(mtree_store_range);
>   * @mt: The maple tree
>   * @index: The index to store the value
>   * @entry: The entry to store
> - * @gfp: The GFP_FLAGS to use for allocations
> + * @gfp: The ``GFP_FLAGS`` to use for allocations
>   *
> - * Return: 0 on success, -EINVAL on invalid request, -ENOMEM if memory c=
ould not
> - * be allocated.
> + * Return:
> + * * 0 on success
> + * * ``-EINVAL`` on invalid request
> + * * ``-ENOMEM`` if memory could not be allocated.
>   */
>  int mtree_store(struct maple_tree *mt, unsigned long index, void *entry,
>  		 gfp_t gfp)
> @@ -6233,10 +6244,13 @@ EXPORT_SYMBOL(mtree_store);
>   * @first: The start of the range
>   * @last: The end of the range
>   * @entry: The entry to store
> - * @gfp: The GFP_FLAGS to use for allocations.
> + * @gfp: The ``GFP_FLAGS`` to use for allocations.
>   *
> - * Return: 0 on success, -EEXISTS if the range is occupied, -EINVAL on i=
nvalid
> - * request, -ENOMEM if memory could not be allocated.
> + * Return:
> + * * 0 on success
> + * * ``-EEXISTS`` if the range is occupied
> + * * ``-EINVAL`` on invalid request
> + * * ``-ENOMEM`` if memory could not be allocated.
>   */
>  int mtree_insert_range(struct maple_tree *mt, unsigned long first,
>  		unsigned long last, void *entry, gfp_t gfp)
> @@ -6268,10 +6282,13 @@ EXPORT_SYMBOL(mtree_insert_range);
>   * @mt: The maple tree
>   * @index : The index to store the value
>   * @entry: The entry to store
> - * @gfp: The FGP_FLAGS to use for allocations.
> + * @gfp: The ``GFP_FLAGS`` to use for allocations.
>   *
> - * Return: 0 on success, -EEXISTS if the range is occupied, -EINVAL on i=
nvalid
> - * request, -ENOMEM if memory could not be allocated.
> + * Return:
> + * * 0 on success
> + * * ``-EEXISTS`` if the range is occupied
> + * * ``-EINVAL`` on invalid request
> + * * ``-ENOMEM`` if memory could not be allocated.
>   */
>  int mtree_insert(struct maple_tree *mt, unsigned long index, void *entry=
,
>  		 gfp_t gfp)
> @@ -6354,8 +6371,9 @@ EXPORT_SYMBOL(mtree_alloc_rrange);
>   * @mt: The maple tree
>   * @index: The index to erase
>   *
> - * Erasing is the same as a walk to an entry then a store of a NULL to t=
hat
> - * ENTIRE range.  In fact, it is implemented as such using the advanced =
API.
> + * Erasing is the same walking to an entry then storing ``NULL`` to that
> + * entire range.  In fact, it is implemented as such using the advanced
> + * API.
>   *
>   * Return: The entry stored at the @index or %NULL
>   */
> @@ -6378,7 +6396,7 @@ EXPORT_SYMBOL(mtree_erase);
>   * __mt_destroy() - Walk and free all nodes of a locked maple tree.
>   * @mt: The maple tree
>   *
> - * Note: Does not handle locking.
> + * Note: This function does not handle locking.
>   */
>  void __mt_destroy(struct maple_tree *mt)
>  {
> @@ -6396,7 +6414,7 @@ EXPORT_SYMBOL_GPL(__mt_destroy);
>   * mtree_destroy() - Destroy a maple tree
>   * @mt: The maple tree
>   *
> - * Frees all resources used by the tree.  Handles locking.
> + * Frees all resources used by the tree. This function handles locking.
>   */
>  void mtree_destroy(struct maple_tree *mt)
>  {
> @@ -6412,7 +6430,8 @@ EXPORT_SYMBOL(mtree_destroy);
>   * @index: Pointer which contains the start location of the search
>   * @max: The maximum value to check
>   *
> - * Handles locking.  @index will be incremented to one beyond the range.
> + * This function handles locking.  @index will be incremented to one bey=
ond
> + * the range.
>   *
>   * Return: The entry at or after the @index or %NULL
>   */
> @@ -6471,7 +6490,7 @@ EXPORT_SYMBOL(mt_find);
>   * @index: Pointer which contains the start location of the search
>   * @max: The maximum value to check
>   *
> - * Handles locking, detects wrapping on index =3D=3D 0
> + * This function handles locking and detects wrapping on ``index =3D=3D =
0``.
>   *
>   * Return: The entry at or after the @index or %NULL
>   */
>=20
> Thanks.
>=20
> --=20
> An old man doll... just what I always wanted! - Clara


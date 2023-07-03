Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D449074633A
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 21:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjGCTQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 15:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjGCTQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 15:16:40 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC815E5D;
        Mon,  3 Jul 2023 12:16:35 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363G8OAC020146;
        Mon, 3 Jul 2023 19:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=94wO+d2QPOvUM/sqkwtknU4QTTwAX+i/D2WtryzrDCc=;
 b=qSIgbH0NuNTF5G6FM9zVAx3xy/wDtXE0i2V7z1gZDqMYtZVGXV2Mr6UvyioPREUkcZfK
 fXj/QVzHrM5Gsmsr+NBga++2P7yCDyqjKNtZpvb5r8Ozjf+Zdw7K7VHHbiD3oRDug+C2
 0h5jL/ZIdM4hhW80d0E2h8ulWp7lBHs9yRSfcCoOkQ+cpUgQ5hzFJmBi6jZ5uxRMSlpO
 nEoDszTROFBe8QPKdA5vMVczwjF4r6GkM15YMAwXZirWLqxQH5HrRi4kgqJ6e/+XOZfg
 fdDBKZdPb23OiT5cIFWVEJYVrNvnf08fzY4uLFP4kx9u46JrzZD58J0F8SWF7r6ycjEB sg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3rjax3bbux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 19:16:16 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 363HUiva039614;
        Mon, 3 Jul 2023 19:16:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3rjak3euw1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jul 2023 19:16:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAx4dKU/3nHAp4feYzxrYKXaehYKMSaaMXwml20ac9XPZKiov3Nik+aM7c5gXcOTNbdjHwjeV+n0wAJU0PzUGepBIqw4joerY3KsAqTOog0SfscM0Rx0GrC3dzj4huSc/Xgd0yvB9+a1zXTekIBCBDAQL8uAfvJif31TyjE4l47xuiTX9T/wGl3K1EqkLK14fgvMWqbFoOf8TuzYfqw7P05wBYdug05ANX8sKXiI3QgEe8E9GP9pYCBd0S0TLKJCqk86sHwEB74f285KWten0ahITK2lPpeeQAM/kW8YbKWDirZAzHupNZJEjNcJwT8oQPQfsGxhl07QIoIZ1NC1Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94wO+d2QPOvUM/sqkwtknU4QTTwAX+i/D2WtryzrDCc=;
 b=BQVSKUPG91E4gEk5UqkvmqhHI9sZ1Nnv3EjbOuFguSheY9Ne5Q+A6yzQBf1EjXXblWgainALx5+6QFR3MWjqe5uqr4CkiPyM/XrkQjqI+L5GZvl5hdNXvr93hdpfUPOMBMuXztow5VH1+LgPmabFBCJJDF6m9xQJPB4wsrFB+YFuwj/5JOAB+L0S8oychOoBet1DQewKChw4S/PRl9qKFTKs2dbbYHgQenXCVB0cF3pSmAjp83jXOfXtSulWEg1KRqypqdITQsPLKhE+HxywJ7uXZP56jrPZk35QpBWbu06kuARi1jjy4QkY4Ah2xv17ur7FW05bbr7y3RN7+1VsnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94wO+d2QPOvUM/sqkwtknU4QTTwAX+i/D2WtryzrDCc=;
 b=Xg+Bp7QWOGgSqwlcHnHEZGQT02dO8rMW6X5LA0Q6uz4JgPQyUFrqRaR52xqHI7B75iucHoE5WzYLV7NYq1NOxVE1ax8l/4zB+lN18Rb6CftSJWPgNsjnuLyGykD+XsN6Gw6DBZk0OMUK3dPKrSIsBVNB2qoGKii3mEUNPu0JiDg=
Received: from BY5PR10MB4129.namprd10.prod.outlook.com (2603:10b6:a03:210::21)
 by IA0PR10MB6724.namprd10.prod.outlook.com (2603:10b6:208:43e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Mon, 3 Jul
 2023 19:16:12 +0000
Received: from BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9]) by BY5PR10MB4129.namprd10.prod.outlook.com
 ([fe80::ec9b:ef74:851b:6aa9%5]) with mapi id 15.20.6544.024; Mon, 3 Jul 2023
 19:16:12 +0000
From:   Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
To:     Liam Howlett <liam.howlett@oracle.com>
CC:     "davem@davemloft.net" <davem@davemloft.net>,
        "david@fries.net" <david@fries.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "zbr@ioremap.net" <zbr@ioremap.net>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "ecree.xilinx@gmail.com" <ecree.xilinx@gmail.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "socketcan@hartkopp.net" <socketcan@hartkopp.net>,
        "petrm@nvidia.com" <petrm@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v6 4/6] connector/cn_proc: Performance improvements
Thread-Topic: [PATCH v6 4/6] connector/cn_proc: Performance improvements
Thread-Index: AQHZnxnC/MDNHBx4WU6j14N+Cq6Y2a+j5jMAgAShQIA=
Date:   Mon, 3 Jul 2023 19:16:12 +0000
Message-ID: <AFD77859-E642-441E-95DD-7E8530F26D2E@oracle.com>
References: <20230614234129.3264175-1-anjali.k.kulkarni@oracle.com>
 <20230614234129.3264175-5-anjali.k.kulkarni@oracle.com>
 <20230630203400.k4yuaecr2p5upn5k@revolver>
In-Reply-To: <20230630203400.k4yuaecr2p5upn5k@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR10MB4129:EE_|IA0PR10MB6724:EE_
x-ms-office365-filtering-correlation-id: 79c5375d-12cd-403d-c1cd-08db7bf9f703
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QZIlfxjJNKQBEbNTyFRsktA6DeQMFffW27h32IEwr1d0ch/rXRkfayWI1vILGOqiJwv9keQMSB7Pj27lmTTbTzYLXw6ULaFRd8mldoQ3sDY673lIXivImyWZe0Ssv5jXfEdIGABq5VakH3DHAKmBEDSVEBhrhiYLUKDpa9HegE6xm9T5YmQUwnV+gYTgkfIorJ5z/+45LqSWSsGxKMR72az3G2OSynwZZpj2WS1TAo7o74X2+YfKulcG5He9E2EDJgRD+75tW+cABbMaGb2OKrPjsBbvtYuVLadm/9DHwM6i/IiTIXsCUDYo4nBe6cQyvvHOUNCI0y7V3XRzhSskWL7BMys6paSkHrhJeqa8cssviTFaC9NVNTWeMOrmjKQL2ct3oJ1BD7RA0xmAmxZ214RL5za4cVAK894zO1EnYeYD/lqdBbpgqvzxQ0VuOGj+EMJZJd9Z63mrP+PDfMa8W0Fs2gQJS+nyW/Y9jwMihIuHECiuFr23MDgQ0NQZP8JwNCfcafJmETntu6lMvIJUnLBzPF2lL4/IsvzyI1q36mKonyONDzr31OIsTgno7cr66iM4606parKxQmK0LZvA3zw/AR2Pq0wAZnOKyZ2cCkFbAokVkvHGu3i0XUp+5mTNhYRn6T1fJVyGF5CKaYqlog==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4129.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(396003)(39860400002)(366004)(451199021)(478600001)(71200400001)(6512007)(6506007)(86362001)(2616005)(186003)(38100700002)(54906003)(66476007)(64756008)(6636002)(66556008)(4326008)(66946007)(66446008)(83380400001)(37006003)(53546011)(76116006)(6486002)(316002)(122000001)(5660300002)(6862004)(8676002)(8936002)(7416002)(38070700005)(41300700001)(2906002)(33656002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SzcxFehXy0ypTP11BhrfKYSkABl4npCmsejLgRCKonZC32EM7MODF1kVf5il?=
 =?us-ascii?Q?8+56gOOIMySt6cLMSwVER+14BNwU3eNVClPzYdhrlsHl9/1MHuKoa58K31Qv?=
 =?us-ascii?Q?vVU4yVdgFAjVIQNA7Qtlk6BIO69b5r1YzsD2UbNww8SXU3xzmgomJafZl2Pu?=
 =?us-ascii?Q?z2Ga4OZxsXy7kedCNmrvrPNRb85S9xQJb7FpSw4czQsNJjC4nm2wXB5/2qsf?=
 =?us-ascii?Q?uCsqquwGqF9f4d/PjyafjPVXGNNy6/RnT0cHhdqsXh0pN6GFkdW2YoBboTch?=
 =?us-ascii?Q?MbDHROoMgL9yd34DZwvM5pRwRu8GmwFfstJbaeNlSuBhMIDreebNWk6ru/3/?=
 =?us-ascii?Q?py5LzNCALXFqhS8Bm/a0JUECJHuS7Vlc1hd+KAihQBjLrroY1JkAKO2OscEp?=
 =?us-ascii?Q?0/NebJdUgqm5zX1pGeGzjfl/yp9SejDAsd0you3watdtEmas4G05JzYN1ImE?=
 =?us-ascii?Q?NBibnI5DzM0gdtmJWJRPOoSp4NVMuFTPqkogl5H2+aS5+UicyiQUKcsFmhdz?=
 =?us-ascii?Q?ShrVqJZElUXh3uCNyfSgP+PyWEnTuL3QaumBdle0phrsVo0+yygAHd/WGCI+?=
 =?us-ascii?Q?N7U3TNJLqG+IoHU95cQ++fQeuIiFUzaNYzCyHrfr33XLO2jSrC9qzvYu7dUf?=
 =?us-ascii?Q?kDGiWBy8lsNulre5kCo+hB+bIppzqTup0SvNpHql56TEyabTaI2HzWv151E5?=
 =?us-ascii?Q?30hDTFm8l+ijOGLMfUhbedn6s9ooQhfLfmV+gqM22QPm7aXBGEIEiG1yXPg0?=
 =?us-ascii?Q?D53IVFBrVgzYkAMs2OiyLZiUEe3glbTkSq/N/WNXSf0d5YuLQV7AYU9ZiNpZ?=
 =?us-ascii?Q?zGVgpnIN+tNJjUyyyVXFVUkZHOHkXmBipLKS3yGaEDAF4JTfrEr714qalgfa?=
 =?us-ascii?Q?3vTlG6i59g2nYXZRePEPGRtlVnJjVIWkj5mtZc4EKOcl5XwcZq5ffJWbQQxu?=
 =?us-ascii?Q?VxDhPXfaYiCqfG8GCvJ8j/xGKRjKOAXLkHLR9tpICS5OtIjnc7dmE4GgpMPE?=
 =?us-ascii?Q?2QTRTCst+Lk0sIjTT9QCbocSyI7m7e6v9G2jd97Um2MTMV/AGm19PMOkuPRw?=
 =?us-ascii?Q?YzUyehXft43CYFIAQt+IUhhkMfQ6fnudNAqUraHyYewKVPqqWb9TF9jdorGy?=
 =?us-ascii?Q?W6wyM4e5YzL3glQf3RbscHWf53IH25nvBTksySSHOQbHUQJUvd02yOn4DkH/?=
 =?us-ascii?Q?w+hQlX6gB/OhZSiPFSEDBaDqokJiWwradKbzrA13aSrjeH8sEa/glRCJeQx+?=
 =?us-ascii?Q?SDIBGXr910f7Y5u5Nnt4+jyzh1w1qr9gre/dY1ya66YJb69Hzpk5Nq6RFx7W?=
 =?us-ascii?Q?MZ7olsr4GDAm/l6wj+MGEzPqHqNgTorLZcFXyku1Y/cNzfQUgfUaeVKo74C3?=
 =?us-ascii?Q?ym0Q+2RIbAO9lpOS4/R9eqqWCRqZFDzV6dNQoODPgj+0MMgnXkBFvmeMBFJh?=
 =?us-ascii?Q?4cdL4TfPDTOJRqxei74I56L6VNkywpB/T0cbpfaBAUVPVIJUVFDS1lMGNyAO?=
 =?us-ascii?Q?YVxzwxQAsBOJqNnS+R9jWnQpcM+caNaOXgyxMXST4V2M2VMlvTLI3tTQAx3G?=
 =?us-ascii?Q?tqJsUUQ37YRrchigmfhanadYJm5wHE/SpH3KBnD5+hGmupZ0EkDe/nYfk0r/?=
 =?us-ascii?Q?DElmry35mDiG7RggUmtSHMLqTJftSwwi6cX8jze/frDEBLtModE49fzMEHE5?=
 =?us-ascii?Q?Frg9UJj5nYipNFGReRIVcQtGsbo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1E6F0DBA40EAB542A3ABBE9923252F69@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?EY1Sn6gaXr1eJV78z90hOKOEBSOuV6juptpitudAfghavboTcbGu3IE8HuzP?=
 =?us-ascii?Q?gD+KiLWOOEb26XFckgDXWrKSOcsF75jX8/xL5NKqOlfQXI3mmtQklIV4S9Zm?=
 =?us-ascii?Q?g6o5BzHh2JihMNg58PLJwjcMZTncxQi2Yx4m1YZ1rvputGpU5Xd39/p70N6N?=
 =?us-ascii?Q?NExR3WQjhDbZF8QU994KgnZ1ztPaFfbtYdjBDQG6sKtl8CYPK1HK8Lm5LYSU?=
 =?us-ascii?Q?w9vPhrlO9mia/zDSFkt9CpnO83HUHC5Mg8KzjM2YdTG10egT5bULcct3Xk7x?=
 =?us-ascii?Q?YQ1S3KmWuDvEZS0ZgBcSjdOFIw/KS2/BPX+ab/PSTd++zVqQx0E9o/BwuWX0?=
 =?us-ascii?Q?QEzvOIICPblsrvk4FoxstfBV7cNVK7ztUEMbr3qKEvsQWmR+9bjzWtNkj/U9?=
 =?us-ascii?Q?EKzSS1QpTilqXP6RKrRA9zk8Rtv7iD1sHHzWtBfiIWskwnWRwvg2gV+sDxQg?=
 =?us-ascii?Q?r+HX78IOzjdx2x2iM1tzsy9H3A5uqFIB+1pThiIq8ybmYtbyDbqWJs8e4+Nv?=
 =?us-ascii?Q?SSQNqphTGyw3mrhDsJ1PCWmJOdJAN9rf5PZ4Vzikr1NsJGq9egh0tl7VnVNG?=
 =?us-ascii?Q?WJ6vj9oS1cIL3z968uBk5ocz6dY4xJh7XTXeaoljzyv2B59gSKebgcoV74o8?=
 =?us-ascii?Q?ztqgve2mOrHVqSZvUHu4zx3aB3B8aRSH5UJ/IkTVeqgrSwoNsZHtOtW9Ai0D?=
 =?us-ascii?Q?/2D8/6jIzHbbhR5RgtwNBBghxlzPDISWFMZLbFZyKcnq11VS1JnxomLlK7qE?=
 =?us-ascii?Q?DHRxjyknUCjdxS2Xbht8xddFLwsTasPgVX+gqeQLZE/m5Lzd4JD3v6Ox9+Nq?=
 =?us-ascii?Q?FKisFlyLZrTJOx5y34kOp4tOWOBXneyFkGVzED+/A/2Z916th+FT07WGBQ5D?=
 =?us-ascii?Q?3G5Xlw9/W5pKgB7EPeGtnhcZpafL5RyLZntKLzmSII7fITkhJEoCReCQGWQL?=
 =?us-ascii?Q?0rxWGv4ZXdRm9NVQvTzrrQK8cJgmhN+TTsIhG4DUc0X+lA36srunPWdfPVp3?=
 =?us-ascii?Q?InLJt+wU86dX3JtxOd4Di4szgkIKPwtfuWYI7Vpftb+QSFpjIWlG4mL+hXmg?=
 =?us-ascii?Q?20qCd2uxXndWi5mmQzd+Adv/12vTpJ22LOAHPZlWY5rS64FBpMnKm5I9L40W?=
 =?us-ascii?Q?V0X9zscZyaGI/77FikA3a3hYU+rUcaI0jwjg9q6OTatkYRD/zAKHcMs=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4129.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c5375d-12cd-403d-c1cd-08db7bf9f703
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2023 19:16:12.4348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TSH92VVu+pgYs6EcQP7Ex2njMz4V/mr2SnZXlEiMJ02YhQRE/pUo4igfwGeWsquR8eK3aRCPKQ2LZG8EF9pbQ0qaPo4oD0bIP9H6kFrxNQU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6724
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_14,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030175
X-Proofpoint-GUID: caMtNv8nuAMXuOc6NuM00UoxvuuWvD_v
X-Proofpoint-ORIG-GUID: caMtNv8nuAMXuOc6NuM00UoxvuuWvD_v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 30, 2023, at 1:34 PM, Liam Howlett <liam.howlett@oracle.com> wrote=
:
>=20
> * Anjali Kulkarni <anjali.k.kulkarni@oracle.com> [230614 19:41]:
>> This patch adds the capability to filter messages sent by the proc
>> connector on the event type supplied in the message from the client
>> to the connector. The client can register to listen for an event type
>> given in struct proc_input.
>>=20
>> This event based filteting will greatly enhance performance - handling
>> 8K exits takes about 70ms, whereas 8K-forks + 8K-exits takes about 150ms
>> & handling 8K-forks + 8K-exits + 8K-execs takes 200ms. There are current=
ly
>> 9 different types of events, and we need to listen to all of them. Also,
>> measuring the time using pidfds for monitoring 8K process exits took
>> much longer - 200ms, as compared to 70ms using only exit notifications o=
f
>> proc connector.
>>=20
>> We also add a new event type - PROC_EVENT_NONZERO_EXIT, which is
>> only sent by kernel to a listening application when any process exiting,
>> has a non-zero exit status. This will help the clients like Oracle DB,
>> where a monitoring process wants notfications for non-zero process exits
>> so it can cleanup after them.
>>=20
>> This kind of a new event could also be useful to other applications like
>> Google's lmkd daemon, which needs a killed process's exit notification.
>>=20
>> The patch takes care that existing clients using old mechanism of not
>> sending the event type work without any changes.
>>=20
>> cn_filter function checks to see if the event type being notified via
>> proc connector matches the event type requested by client, before
>> sending(matches) or dropping(does not match) a packet.
>>=20
>> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
>> ---
>> drivers/connector/cn_proc.c | 64 ++++++++++++++++++++++++++++++++----
>> include/uapi/linux/cn_proc.h | 19 +++++++++++
>> 2 files changed, 77 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
>> index 84f38d2bd4b9..825d5f506919 100644
>> --- a/drivers/connector/cn_proc.c
>> +++ b/drivers/connector/cn_proc.c
>> @@ -50,21 +50,47 @@ static DEFINE_PER_CPU(struct local_event, local_even=
t) =3D {
>>=20
>> static int cn_filter(struct sock *dsk, struct sk_buff *skb, void *data)
>> {
>> +	uintptr_t val;
>> +	__u32 what, exit_code, *ptr;
>> 	enum proc_cn_mcast_op mc_op;
>=20
> I guess reverse xmas tree would be requested here as well?

Will add here.

>=20
>>=20
>> -	if (!dsk)
>> +	if (!dsk || !data)
>> 		return 0;
>>=20
>> +	ptr =3D (__u32 *)data;
>> +	what =3D *ptr++;
>> +	exit_code =3D *ptr;
>> +	val =3D ((struct proc_input *)(dsk->sk_user_data))->event_type;
>> 	mc_op =3D ((struct proc_input *)(dsk->sk_user_data))->mcast_op;
>>=20
>> 	if (mc_op =3D=3D PROC_CN_MCAST_IGNORE)
>> 		return 1;
>>=20
>> -	return 0;
>> +	if ((__u32)val =3D=3D PROC_EVENT_ALL)
>> +		return 0;
>> +
>> +	/*
>> +	 * Drop packet if we have to report only non-zero exit status
>> +	 * (PROC_EVENT_NONZERO_EXIT) and exit status is 0
>> +	 */
>> +	if (((__u32)val & PROC_EVENT_NONZERO_EXIT) &&
>> +	 (what =3D=3D PROC_EVENT_EXIT)) {
>> +		if (exit_code)
>> +			return 0;
>> +		else
>=20
> Nit: don't really need the else here.

Will remove it.

>=20
>> +			return 1;
>> +	}
>> +
>> +	if ((__u32)val & what)
>> +		return 0;
>> +
>> +	return 1;
>> }
>>=20
>> static inline void send_msg(struct cn_msg *msg)
>> {
>> +	__u32 filter_data[2];
>> +
>> 	local_lock(&local_event.lock);
>>=20
>> 	msg->seq =3D __this_cpu_inc_return(local_event.count) - 1;
>> @@ -76,8 +102,16 @@ static inline void send_msg(struct cn_msg *msg)
>> 	 *
>> 	 * If cn_netlink_send() fails, the data is not sent.
>> 	 */
>> +	filter_data[0] =3D ((struct proc_event *)msg->data)->what;
>> +	if (filter_data[0] =3D=3D PROC_EVENT_EXIT) {
>> +		filter_data[1] =3D
>> +		((struct proc_event *)msg->data)->event_data.exit.exit_code;
>> +	} else {
>> +		filter_data[1] =3D 0;
>> +	}
>> +
>> 	cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
>> -			 cn_filter, NULL);
>> +			 cn_filter, (void *)filter_data);
>>=20
>> 	local_unlock(&local_event.lock);
>> }
>> @@ -357,12 +391,15 @@ static void cn_proc_ack(int err, int rcvd_seq, int=
 rcvd_ack)
>>=20
>> /**
>> * cn_proc_mcast_ctl
>> - * @data: message sent from userspace via the connector
>> + * @msg: message sent from userspace via the connector
>> + * @nsp: NETLINK_CB of the client's socket buffer
>> */
>> static void cn_proc_mcast_ctl(struct cn_msg *msg,
>> 			 struct netlink_skb_parms *nsp)
>> {
>> 	enum proc_cn_mcast_op mc_op =3D 0, prev_mc_op =3D 0;
>> +	struct proc_input *pinput =3D NULL;
>> +	enum proc_cn_event ev_type =3D 0;
>> 	int err =3D 0, initial =3D 0;
>> 	struct sock *sk =3D NULL;
>>=20
>> @@ -381,10 +418,21 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>> 		goto out;
>> 	}
>>=20
>> -	if (msg->len =3D=3D sizeof(mc_op))
>> +	if (msg->len =3D=3D sizeof(*pinput)) {
>> +		pinput =3D (struct proc_input *)msg->data;
>> +		mc_op =3D pinput->mcast_op;
>> +		ev_type =3D pinput->event_type;
>> +	} else if (msg->len =3D=3D sizeof(mc_op)) {
>> 		mc_op =3D *((enum proc_cn_mcast_op *)msg->data);
>> -	else
>> +		ev_type =3D PROC_EVENT_ALL;
>> +	} else {
>> 		return;
>> +	}
>> +
>> +	ev_type =3D valid_event((enum proc_cn_event)ev_type);
>> +
>> +	if (ev_type =3D=3D PROC_EVENT_NONE)
>> +		ev_type =3D PROC_EVENT_ALL;
>>=20
>> 	if (nsp->sk) {
>> 		sk =3D nsp->sk;
>> @@ -396,6 +444,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>> 			prev_mc_op =3D
>> 			((struct proc_input *)(sk->sk_user_data))->mcast_op;
>> 		}
>> +		((struct proc_input *)(sk->sk_user_data))->event_type =3D
>> +			ev_type;
>> 		((struct proc_input *)(sk->sk_user_data))->mcast_op =3D mc_op;
>> 	}
>>=20
>> @@ -407,6 +457,8 @@ static void cn_proc_mcast_ctl(struct cn_msg *msg,
>> 	case PROC_CN_MCAST_IGNORE:
>> 		if (!initial && (prev_mc_op !=3D PROC_CN_MCAST_IGNORE))
>> 			atomic_dec(&proc_event_num_listeners);
>> +		((struct proc_input *)(sk->sk_user_data))->event_type =3D
>> +			PROC_EVENT_NONE;
>> 		break;
>> 	default:
>> 		err =3D EINVAL;
>> diff --git a/include/uapi/linux/cn_proc.h b/include/uapi/linux/cn_proc.h
>> index 6a06fb424313..f2afb7cc4926 100644
>> --- a/include/uapi/linux/cn_proc.h
>> +++ b/include/uapi/linux/cn_proc.h
>> @@ -30,6 +30,15 @@ enum proc_cn_mcast_op {
>> 	PROC_CN_MCAST_IGNORE =3D 2
>> };
>>=20
>> +#define PROC_EVENT_ALL (PROC_EVENT_FORK | PROC_EVENT_EXEC | PROC_EVENT_=
UID | \
>> +			PROC_EVENT_GID | PROC_EVENT_SID | PROC_EVENT_PTRACE | \
>> +			PROC_EVENT_COMM | PROC_EVENT_NONZERO_EXIT | \
>> +			PROC_EVENT_COREDUMP | PROC_EVENT_EXIT)
>> +
>> +/*
>> + * If you add an entry in proc_cn_event, make sure you add it in
>> + * PROC_EVENT_ALL above as well.
>> + */
>> enum proc_cn_event {
>> 	/* Use successive bits so the enums can be used to record
>> 	 * sets of events as well
>> @@ -45,15 +54,25 @@ enum proc_cn_event {
>> 	/* "next" should be 0x00000400 */
>> 	/* "last" is the last process event: exit,
>> 	 * while "next to last" is coredumping event
>> +	 * before that is report only if process dies
>> +	 * with non-zero exit status
>> 	 */
>> +	PROC_EVENT_NONZERO_EXIT =3D 0x20000000,
>> 	PROC_EVENT_COREDUMP =3D 0x40000000,
>> 	PROC_EVENT_EXIT =3D 0x80000000
>> };
>>=20
>> struct proc_input {
>> 	enum proc_cn_mcast_op mcast_op;
>> +	enum proc_cn_event event_type;
>> };
>>=20
>> +static inline enum proc_cn_event valid_event(enum proc_cn_event ev_type=
)
>> +{
>> +	ev_type &=3D PROC_EVENT_ALL;
>> +	return ev_type;
>> +}
>> +
>> /*
>> * From the user's point of view, the process
>> * ID is the thread group ID and thread ID is the internal
>> --=20
>> 2.41.0

